import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:translator/translator.dart';
import 'package:openlabel/api/api_client.dart';
import 'package:openlabel/providers/language_provider.dart';
import 'package:openlabel/models/product_analysis_result.dart';
import 'package:openlabel/utils/image_compression_service.dart';

final analysisControllerProvider =
    AsyncNotifierProvider<AnalysisController, ProductAnalysisResult?>(
      AnalysisController.new,
    );

final translatedResultProvider = FutureProvider<ProductAnalysisResult?>((
  ref,
) async {
  final baseAsync = ref.watch(analysisControllerProvider);
  final result = baseAsync.valueOrNull;
  if (result == null) return null;

  final lang = ref.watch(languageProvider);
  if (lang == 'en') return result;

  final translator = GoogleTranslator();

  Future<String> t(String text) async {
    if (text.trim().isEmpty) return text;
    try {
      final translation = await translator.translate(text, to: lang);
      return translation.text;
    } catch (_) {
      return text;
    }
  }

  final tOverall = await t(result.overallVerdict);
  final tProduct = result.productName != null
      ? await t(result.productName!)
      : null;
  final tLegal = result.legalDraftText != null
      ? await t(result.legalDraftText!)
      : null;

  final tFlags = await Future.wait(
    result.flags.map((f) async {
      return f.copyWith(
        title: await t(f.title),
        rationale: await t(f.rationale),
        evidence: await t(f.evidence),
      );
    }),
  );

  final tAlts = result.healthierAlternatives != null
      ? await Future.wait(
          result.healthierAlternatives!.map((a) async {
            return await t(a);
          }),
        )
      : null;

  return result.copyWith(
    productName: tProduct,
    overallVerdict: tOverall,
    legalDraftText: tLegal,
    flags: tFlags,
    healthierAlternatives: tAlts,
  );
});

class AnalysisController extends AsyncNotifier<ProductAnalysisResult?> {
  late final Dio _dio;

  @override
  Future<ProductAnalysisResult?> build() async {
    _dio = ref.watch(apiClientProvider);
    return null;
  }

  Future<String?> _getUserRegion() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) return null;

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) return null;
      }
      if (permission == LocationPermission.deniedForever) return null;

      Position position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.medium,
        ),
      );

      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        final parts = <String>[];
        if (place.administrativeArea != null &&
            place.administrativeArea!.isNotEmpty)
          parts.add(place.administrativeArea!);
        if (place.country != null && place.country!.isNotEmpty)
          parts.add(place.country!);
        return parts.isEmpty ? null : parts.join(', ');
      }
    } catch (e) {
      // Ignore to prevent blocking the scan
    }
    return null;
  }

  Future<void> analyzeImages(XFile front, XFile back) async {
    state = const AsyncLoading();
    try {
      final userLocation = await _getUserRegion();
      final frontBase64 = await compressAndEncodeImage(front);
      final backBase64 = await compressAndEncodeImage(back);

      final data = <String, dynamic>{
        'front_image_base64': frontBase64,
        'back_image_base64': backBase64,
        'product_name': null,
        'retail_price': null,
      };
      if (userLocation != null) data['user_location'] = userLocation;

      final response = await _dio.post('/api/v1/scan/dual-image', data: data);

      final responseData = response.data is String
          ? jsonDecode(response.data)
          : response.data;
      final result = ProductAnalysisResult.fromJson(
        responseData as Map<String, dynamic>,
      );
      state = AsyncData(result);
    } on DioException catch (e, st) {
      state = AsyncError(e, st);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> analyzeUrl(String url) async {
    state = const AsyncLoading();
    try {
      final userLocation = await _getUserRegion();
      final data = <String, dynamic>{'url': url};
      if (userLocation != null) data['user_location'] = userLocation;

      final response = await _dio.post('/api/v1/scan/link', data: data);

      final responseData = response.data is String
          ? jsonDecode(response.data)
          : response.data;
      final result = ProductAnalysisResult.fromJson(
        responseData as Map<String, dynamic>,
      );
      state = AsyncData(result);
    } on DioException catch (e, st) {
      state = AsyncError(e, st);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}
