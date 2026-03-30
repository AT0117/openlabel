import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final apiClientProvider = Provider<Dio>((ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://openlabel-mdgj.onrender.com',
      connectTimeout: const Duration(minutes: 6),
      receiveTimeout: const Duration(minutes: 6),
      // Expect JSON by default
      contentType: 'application/json',
    ),
  );

  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) {
        // Attempt to get the session token if Supabase is initialized
        try {
          final token = Supabase.instance.client.auth.currentSession?.accessToken;
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
        } catch (e) {
          // Supabase might not be initialized yet or not used
        }
        return handler.next(options);
      },
    ),
  );

  return dio;
});
