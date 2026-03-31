// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_analysis_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FlagItem _$FlagItemFromJson(Map<String, dynamic> json) => _FlagItem(
  code: json['code'] as String,
  title: json['title'] as String,
  severity: json['severity'] as String,
  evidence: json['evidence'] as String,
  rationale: json['rationale'] as String,
);

Map<String, dynamic> _$FlagItemToJson(_FlagItem instance) => <String, dynamic>{
  'code': instance.code,
  'title': instance.title,
  'severity': instance.severity,
  'evidence': instance.evidence,
  'rationale': instance.rationale,
};

_ProductAnalysisResult _$ProductAnalysisResultFromJson(
  Map<String, dynamic> json,
) => _ProductAnalysisResult(
  scanId: json['scan_id'] as String?,
  productName: json['product_name'] as String?,
  trustScore: (json['trust_score'] as num?)?.toDouble(),
  trustLevel: json['trust_level'] as String,
  overallVerdict: json['overall_verdict'] as String,
  flags: (json['flags'] as List<dynamic>)
      .map((e) => FlagItem.fromJson(e as Map<String, dynamic>))
      .toList(),
  fssaiNumber: json['fssai_number'] as String?,
  legalDraftAvailable: json['legal_draft_available'] as bool,
  legalDraftText: json['legal_draft_text'] as String?,
  healthierAlternatives: (json['healthier_alternatives'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  allergyRisks: (json['allergy_risks'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  upfScore: (json['upf_score'] as num?)?.toDouble(),
  isNonEdible: json['is_non_edible'] as bool? ?? false,
);

Map<String, dynamic> _$ProductAnalysisResultToJson(
  _ProductAnalysisResult instance,
) => <String, dynamic>{
  'scan_id': instance.scanId,
  'product_name': instance.productName,
  'trust_score': instance.trustScore,
  'trust_level': instance.trustLevel,
  'overall_verdict': instance.overallVerdict,
  'flags': instance.flags,
  'fssai_number': instance.fssaiNumber,
  'legal_draft_available': instance.legalDraftAvailable,
  'legal_draft_text': instance.legalDraftText,
  'healthier_alternatives': instance.healthierAlternatives,
  'allergy_risks': instance.allergyRisks,
  'upf_score': instance.upfScore,
  'is_non_edible': instance.isNonEdible,
};
