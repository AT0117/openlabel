import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_analysis_result.freezed.dart';
part 'product_analysis_result.g.dart';

@freezed
abstract class FlagItem with _$FlagItem {
  const factory FlagItem({
    required String code,
    required String title,
    required String severity,
    required String evidence,
    required String rationale,
  }) = _FlagItem;
  factory FlagItem.fromJson(Map<String, dynamic> json) =>
      _$FlagItemFromJson(json);
}

@freezed
abstract class ProductAnalysisResult with _$ProductAnalysisResult {
  const factory ProductAnalysisResult({
    @JsonKey(name: 'scan_id') String? scanId,
    @JsonKey(name: 'product_name') String? productName,
    @JsonKey(name: 'trust_score') double? trustScore,
    @JsonKey(name: 'trust_level') required String trustLevel,
    @JsonKey(name: 'overall_verdict') required String overallVerdict,
    required List<FlagItem> flags,
    @JsonKey(name: 'fssai_number') String? fssaiNumber,
    @JsonKey(name: 'legal_draft_available') required bool legalDraftAvailable,
    @JsonKey(name: 'legal_draft_text') String? legalDraftText,
    @JsonKey(name: 'healthier_alternatives') List<String>? healthierAlternatives,
    @JsonKey(name: 'allergy_risks') List<String>? allergyRisks,
    @JsonKey(name: 'upf_score') double? upfScore,
  }) = _ProductAnalysisResult;

  factory ProductAnalysisResult.fromJson(Map<String, dynamic> json) =>
      _$ProductAnalysisResultFromJson(json);
}
