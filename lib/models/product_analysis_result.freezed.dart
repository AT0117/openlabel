// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_analysis_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FlagItem {

 String get code; String get title; String get severity; String get evidence; String get rationale;
/// Create a copy of FlagItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FlagItemCopyWith<FlagItem> get copyWith => _$FlagItemCopyWithImpl<FlagItem>(this as FlagItem, _$identity);

  /// Serializes this FlagItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FlagItem&&(identical(other.code, code) || other.code == code)&&(identical(other.title, title) || other.title == title)&&(identical(other.severity, severity) || other.severity == severity)&&(identical(other.evidence, evidence) || other.evidence == evidence)&&(identical(other.rationale, rationale) || other.rationale == rationale));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,title,severity,evidence,rationale);

@override
String toString() {
  return 'FlagItem(code: $code, title: $title, severity: $severity, evidence: $evidence, rationale: $rationale)';
}


}

/// @nodoc
abstract mixin class $FlagItemCopyWith<$Res>  {
  factory $FlagItemCopyWith(FlagItem value, $Res Function(FlagItem) _then) = _$FlagItemCopyWithImpl;
@useResult
$Res call({
 String code, String title, String severity, String evidence, String rationale
});




}
/// @nodoc
class _$FlagItemCopyWithImpl<$Res>
    implements $FlagItemCopyWith<$Res> {
  _$FlagItemCopyWithImpl(this._self, this._then);

  final FlagItem _self;
  final $Res Function(FlagItem) _then;

/// Create a copy of FlagItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? title = null,Object? severity = null,Object? evidence = null,Object? rationale = null,}) {
  return _then(_self.copyWith(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,severity: null == severity ? _self.severity : severity // ignore: cast_nullable_to_non_nullable
as String,evidence: null == evidence ? _self.evidence : evidence // ignore: cast_nullable_to_non_nullable
as String,rationale: null == rationale ? _self.rationale : rationale // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [FlagItem].
extension FlagItemPatterns on FlagItem {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FlagItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FlagItem() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FlagItem value)  $default,){
final _that = this;
switch (_that) {
case _FlagItem():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FlagItem value)?  $default,){
final _that = this;
switch (_that) {
case _FlagItem() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String code,  String title,  String severity,  String evidence,  String rationale)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FlagItem() when $default != null:
return $default(_that.code,_that.title,_that.severity,_that.evidence,_that.rationale);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String code,  String title,  String severity,  String evidence,  String rationale)  $default,) {final _that = this;
switch (_that) {
case _FlagItem():
return $default(_that.code,_that.title,_that.severity,_that.evidence,_that.rationale);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String code,  String title,  String severity,  String evidence,  String rationale)?  $default,) {final _that = this;
switch (_that) {
case _FlagItem() when $default != null:
return $default(_that.code,_that.title,_that.severity,_that.evidence,_that.rationale);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FlagItem implements FlagItem {
  const _FlagItem({required this.code, required this.title, required this.severity, required this.evidence, required this.rationale});
  factory _FlagItem.fromJson(Map<String, dynamic> json) => _$FlagItemFromJson(json);

@override final  String code;
@override final  String title;
@override final  String severity;
@override final  String evidence;
@override final  String rationale;

/// Create a copy of FlagItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FlagItemCopyWith<_FlagItem> get copyWith => __$FlagItemCopyWithImpl<_FlagItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FlagItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FlagItem&&(identical(other.code, code) || other.code == code)&&(identical(other.title, title) || other.title == title)&&(identical(other.severity, severity) || other.severity == severity)&&(identical(other.evidence, evidence) || other.evidence == evidence)&&(identical(other.rationale, rationale) || other.rationale == rationale));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,title,severity,evidence,rationale);

@override
String toString() {
  return 'FlagItem(code: $code, title: $title, severity: $severity, evidence: $evidence, rationale: $rationale)';
}


}

/// @nodoc
abstract mixin class _$FlagItemCopyWith<$Res> implements $FlagItemCopyWith<$Res> {
  factory _$FlagItemCopyWith(_FlagItem value, $Res Function(_FlagItem) _then) = __$FlagItemCopyWithImpl;
@override @useResult
$Res call({
 String code, String title, String severity, String evidence, String rationale
});




}
/// @nodoc
class __$FlagItemCopyWithImpl<$Res>
    implements _$FlagItemCopyWith<$Res> {
  __$FlagItemCopyWithImpl(this._self, this._then);

  final _FlagItem _self;
  final $Res Function(_FlagItem) _then;

/// Create a copy of FlagItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? title = null,Object? severity = null,Object? evidence = null,Object? rationale = null,}) {
  return _then(_FlagItem(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,severity: null == severity ? _self.severity : severity // ignore: cast_nullable_to_non_nullable
as String,evidence: null == evidence ? _self.evidence : evidence // ignore: cast_nullable_to_non_nullable
as String,rationale: null == rationale ? _self.rationale : rationale // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$ProductAnalysisResult {

@JsonKey(name: 'scan_id') String? get scanId;@JsonKey(name: 'product_name') String? get productName;@JsonKey(name: 'trust_score') double? get trustScore;@JsonKey(name: 'trust_level') String get trustLevel;@JsonKey(name: 'overall_verdict') String get overallVerdict; List<FlagItem> get flags;@JsonKey(name: 'fssai_number') String? get fssaiNumber;@JsonKey(name: 'legal_draft_available') bool get legalDraftAvailable;@JsonKey(name: 'legal_draft_text') String? get legalDraftText;@JsonKey(name: 'healthier_alternatives') List<String>? get healthierAlternatives;@JsonKey(name: 'allergy_risks') List<String>? get allergyRisks;@JsonKey(name: 'upf_score') double? get upfScore;@JsonKey(name: 'is_non_edible') bool get isNonEdible;
/// Create a copy of ProductAnalysisResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductAnalysisResultCopyWith<ProductAnalysisResult> get copyWith => _$ProductAnalysisResultCopyWithImpl<ProductAnalysisResult>(this as ProductAnalysisResult, _$identity);

  /// Serializes this ProductAnalysisResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductAnalysisResult&&(identical(other.scanId, scanId) || other.scanId == scanId)&&(identical(other.productName, productName) || other.productName == productName)&&(identical(other.trustScore, trustScore) || other.trustScore == trustScore)&&(identical(other.trustLevel, trustLevel) || other.trustLevel == trustLevel)&&(identical(other.overallVerdict, overallVerdict) || other.overallVerdict == overallVerdict)&&const DeepCollectionEquality().equals(other.flags, flags)&&(identical(other.fssaiNumber, fssaiNumber) || other.fssaiNumber == fssaiNumber)&&(identical(other.legalDraftAvailable, legalDraftAvailable) || other.legalDraftAvailable == legalDraftAvailable)&&(identical(other.legalDraftText, legalDraftText) || other.legalDraftText == legalDraftText)&&const DeepCollectionEquality().equals(other.healthierAlternatives, healthierAlternatives)&&const DeepCollectionEquality().equals(other.allergyRisks, allergyRisks)&&(identical(other.upfScore, upfScore) || other.upfScore == upfScore)&&(identical(other.isNonEdible, isNonEdible) || other.isNonEdible == isNonEdible));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,scanId,productName,trustScore,trustLevel,overallVerdict,const DeepCollectionEquality().hash(flags),fssaiNumber,legalDraftAvailable,legalDraftText,const DeepCollectionEquality().hash(healthierAlternatives),const DeepCollectionEquality().hash(allergyRisks),upfScore,isNonEdible);

@override
String toString() {
  return 'ProductAnalysisResult(scanId: $scanId, productName: $productName, trustScore: $trustScore, trustLevel: $trustLevel, overallVerdict: $overallVerdict, flags: $flags, fssaiNumber: $fssaiNumber, legalDraftAvailable: $legalDraftAvailable, legalDraftText: $legalDraftText, healthierAlternatives: $healthierAlternatives, allergyRisks: $allergyRisks, upfScore: $upfScore, isNonEdible: $isNonEdible)';
}


}

/// @nodoc
abstract mixin class $ProductAnalysisResultCopyWith<$Res>  {
  factory $ProductAnalysisResultCopyWith(ProductAnalysisResult value, $Res Function(ProductAnalysisResult) _then) = _$ProductAnalysisResultCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'scan_id') String? scanId,@JsonKey(name: 'product_name') String? productName,@JsonKey(name: 'trust_score') double? trustScore,@JsonKey(name: 'trust_level') String trustLevel,@JsonKey(name: 'overall_verdict') String overallVerdict, List<FlagItem> flags,@JsonKey(name: 'fssai_number') String? fssaiNumber,@JsonKey(name: 'legal_draft_available') bool legalDraftAvailable,@JsonKey(name: 'legal_draft_text') String? legalDraftText,@JsonKey(name: 'healthier_alternatives') List<String>? healthierAlternatives,@JsonKey(name: 'allergy_risks') List<String>? allergyRisks,@JsonKey(name: 'upf_score') double? upfScore,@JsonKey(name: 'is_non_edible') bool isNonEdible
});




}
/// @nodoc
class _$ProductAnalysisResultCopyWithImpl<$Res>
    implements $ProductAnalysisResultCopyWith<$Res> {
  _$ProductAnalysisResultCopyWithImpl(this._self, this._then);

  final ProductAnalysisResult _self;
  final $Res Function(ProductAnalysisResult) _then;

/// Create a copy of ProductAnalysisResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? scanId = freezed,Object? productName = freezed,Object? trustScore = freezed,Object? trustLevel = null,Object? overallVerdict = null,Object? flags = null,Object? fssaiNumber = freezed,Object? legalDraftAvailable = null,Object? legalDraftText = freezed,Object? healthierAlternatives = freezed,Object? allergyRisks = freezed,Object? upfScore = freezed,Object? isNonEdible = null,}) {
  return _then(_self.copyWith(
scanId: freezed == scanId ? _self.scanId : scanId // ignore: cast_nullable_to_non_nullable
as String?,productName: freezed == productName ? _self.productName : productName // ignore: cast_nullable_to_non_nullable
as String?,trustScore: freezed == trustScore ? _self.trustScore : trustScore // ignore: cast_nullable_to_non_nullable
as double?,trustLevel: null == trustLevel ? _self.trustLevel : trustLevel // ignore: cast_nullable_to_non_nullable
as String,overallVerdict: null == overallVerdict ? _self.overallVerdict : overallVerdict // ignore: cast_nullable_to_non_nullable
as String,flags: null == flags ? _self.flags : flags // ignore: cast_nullable_to_non_nullable
as List<FlagItem>,fssaiNumber: freezed == fssaiNumber ? _self.fssaiNumber : fssaiNumber // ignore: cast_nullable_to_non_nullable
as String?,legalDraftAvailable: null == legalDraftAvailable ? _self.legalDraftAvailable : legalDraftAvailable // ignore: cast_nullable_to_non_nullable
as bool,legalDraftText: freezed == legalDraftText ? _self.legalDraftText : legalDraftText // ignore: cast_nullable_to_non_nullable
as String?,healthierAlternatives: freezed == healthierAlternatives ? _self.healthierAlternatives : healthierAlternatives // ignore: cast_nullable_to_non_nullable
as List<String>?,allergyRisks: freezed == allergyRisks ? _self.allergyRisks : allergyRisks // ignore: cast_nullable_to_non_nullable
as List<String>?,upfScore: freezed == upfScore ? _self.upfScore : upfScore // ignore: cast_nullable_to_non_nullable
as double?,isNonEdible: null == isNonEdible ? _self.isNonEdible : isNonEdible // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ProductAnalysisResult].
extension ProductAnalysisResultPatterns on ProductAnalysisResult {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProductAnalysisResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProductAnalysisResult() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProductAnalysisResult value)  $default,){
final _that = this;
switch (_that) {
case _ProductAnalysisResult():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProductAnalysisResult value)?  $default,){
final _that = this;
switch (_that) {
case _ProductAnalysisResult() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'scan_id')  String? scanId, @JsonKey(name: 'product_name')  String? productName, @JsonKey(name: 'trust_score')  double? trustScore, @JsonKey(name: 'trust_level')  String trustLevel, @JsonKey(name: 'overall_verdict')  String overallVerdict,  List<FlagItem> flags, @JsonKey(name: 'fssai_number')  String? fssaiNumber, @JsonKey(name: 'legal_draft_available')  bool legalDraftAvailable, @JsonKey(name: 'legal_draft_text')  String? legalDraftText, @JsonKey(name: 'healthier_alternatives')  List<String>? healthierAlternatives, @JsonKey(name: 'allergy_risks')  List<String>? allergyRisks, @JsonKey(name: 'upf_score')  double? upfScore, @JsonKey(name: 'is_non_edible')  bool isNonEdible)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProductAnalysisResult() when $default != null:
return $default(_that.scanId,_that.productName,_that.trustScore,_that.trustLevel,_that.overallVerdict,_that.flags,_that.fssaiNumber,_that.legalDraftAvailable,_that.legalDraftText,_that.healthierAlternatives,_that.allergyRisks,_that.upfScore,_that.isNonEdible);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'scan_id')  String? scanId, @JsonKey(name: 'product_name')  String? productName, @JsonKey(name: 'trust_score')  double? trustScore, @JsonKey(name: 'trust_level')  String trustLevel, @JsonKey(name: 'overall_verdict')  String overallVerdict,  List<FlagItem> flags, @JsonKey(name: 'fssai_number')  String? fssaiNumber, @JsonKey(name: 'legal_draft_available')  bool legalDraftAvailable, @JsonKey(name: 'legal_draft_text')  String? legalDraftText, @JsonKey(name: 'healthier_alternatives')  List<String>? healthierAlternatives, @JsonKey(name: 'allergy_risks')  List<String>? allergyRisks, @JsonKey(name: 'upf_score')  double? upfScore, @JsonKey(name: 'is_non_edible')  bool isNonEdible)  $default,) {final _that = this;
switch (_that) {
case _ProductAnalysisResult():
return $default(_that.scanId,_that.productName,_that.trustScore,_that.trustLevel,_that.overallVerdict,_that.flags,_that.fssaiNumber,_that.legalDraftAvailable,_that.legalDraftText,_that.healthierAlternatives,_that.allergyRisks,_that.upfScore,_that.isNonEdible);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'scan_id')  String? scanId, @JsonKey(name: 'product_name')  String? productName, @JsonKey(name: 'trust_score')  double? trustScore, @JsonKey(name: 'trust_level')  String trustLevel, @JsonKey(name: 'overall_verdict')  String overallVerdict,  List<FlagItem> flags, @JsonKey(name: 'fssai_number')  String? fssaiNumber, @JsonKey(name: 'legal_draft_available')  bool legalDraftAvailable, @JsonKey(name: 'legal_draft_text')  String? legalDraftText, @JsonKey(name: 'healthier_alternatives')  List<String>? healthierAlternatives, @JsonKey(name: 'allergy_risks')  List<String>? allergyRisks, @JsonKey(name: 'upf_score')  double? upfScore, @JsonKey(name: 'is_non_edible')  bool isNonEdible)?  $default,) {final _that = this;
switch (_that) {
case _ProductAnalysisResult() when $default != null:
return $default(_that.scanId,_that.productName,_that.trustScore,_that.trustLevel,_that.overallVerdict,_that.flags,_that.fssaiNumber,_that.legalDraftAvailable,_that.legalDraftText,_that.healthierAlternatives,_that.allergyRisks,_that.upfScore,_that.isNonEdible);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProductAnalysisResult implements ProductAnalysisResult {
  const _ProductAnalysisResult({@JsonKey(name: 'scan_id') this.scanId, @JsonKey(name: 'product_name') this.productName, @JsonKey(name: 'trust_score') this.trustScore, @JsonKey(name: 'trust_level') required this.trustLevel, @JsonKey(name: 'overall_verdict') required this.overallVerdict, required final  List<FlagItem> flags, @JsonKey(name: 'fssai_number') this.fssaiNumber, @JsonKey(name: 'legal_draft_available') required this.legalDraftAvailable, @JsonKey(name: 'legal_draft_text') this.legalDraftText, @JsonKey(name: 'healthier_alternatives') final  List<String>? healthierAlternatives, @JsonKey(name: 'allergy_risks') final  List<String>? allergyRisks, @JsonKey(name: 'upf_score') this.upfScore, @JsonKey(name: 'is_non_edible') this.isNonEdible = false}): _flags = flags,_healthierAlternatives = healthierAlternatives,_allergyRisks = allergyRisks;
  factory _ProductAnalysisResult.fromJson(Map<String, dynamic> json) => _$ProductAnalysisResultFromJson(json);

@override@JsonKey(name: 'scan_id') final  String? scanId;
@override@JsonKey(name: 'product_name') final  String? productName;
@override@JsonKey(name: 'trust_score') final  double? trustScore;
@override@JsonKey(name: 'trust_level') final  String trustLevel;
@override@JsonKey(name: 'overall_verdict') final  String overallVerdict;
 final  List<FlagItem> _flags;
@override List<FlagItem> get flags {
  if (_flags is EqualUnmodifiableListView) return _flags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_flags);
}

@override@JsonKey(name: 'fssai_number') final  String? fssaiNumber;
@override@JsonKey(name: 'legal_draft_available') final  bool legalDraftAvailable;
@override@JsonKey(name: 'legal_draft_text') final  String? legalDraftText;
 final  List<String>? _healthierAlternatives;
@override@JsonKey(name: 'healthier_alternatives') List<String>? get healthierAlternatives {
  final value = _healthierAlternatives;
  if (value == null) return null;
  if (_healthierAlternatives is EqualUnmodifiableListView) return _healthierAlternatives;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<String>? _allergyRisks;
@override@JsonKey(name: 'allergy_risks') List<String>? get allergyRisks {
  final value = _allergyRisks;
  if (value == null) return null;
  if (_allergyRisks is EqualUnmodifiableListView) return _allergyRisks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override@JsonKey(name: 'upf_score') final  double? upfScore;
@override@JsonKey(name: 'is_non_edible') final  bool isNonEdible;

/// Create a copy of ProductAnalysisResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProductAnalysisResultCopyWith<_ProductAnalysisResult> get copyWith => __$ProductAnalysisResultCopyWithImpl<_ProductAnalysisResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProductAnalysisResultToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProductAnalysisResult&&(identical(other.scanId, scanId) || other.scanId == scanId)&&(identical(other.productName, productName) || other.productName == productName)&&(identical(other.trustScore, trustScore) || other.trustScore == trustScore)&&(identical(other.trustLevel, trustLevel) || other.trustLevel == trustLevel)&&(identical(other.overallVerdict, overallVerdict) || other.overallVerdict == overallVerdict)&&const DeepCollectionEquality().equals(other._flags, _flags)&&(identical(other.fssaiNumber, fssaiNumber) || other.fssaiNumber == fssaiNumber)&&(identical(other.legalDraftAvailable, legalDraftAvailable) || other.legalDraftAvailable == legalDraftAvailable)&&(identical(other.legalDraftText, legalDraftText) || other.legalDraftText == legalDraftText)&&const DeepCollectionEquality().equals(other._healthierAlternatives, _healthierAlternatives)&&const DeepCollectionEquality().equals(other._allergyRisks, _allergyRisks)&&(identical(other.upfScore, upfScore) || other.upfScore == upfScore)&&(identical(other.isNonEdible, isNonEdible) || other.isNonEdible == isNonEdible));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,scanId,productName,trustScore,trustLevel,overallVerdict,const DeepCollectionEquality().hash(_flags),fssaiNumber,legalDraftAvailable,legalDraftText,const DeepCollectionEquality().hash(_healthierAlternatives),const DeepCollectionEquality().hash(_allergyRisks),upfScore,isNonEdible);

@override
String toString() {
  return 'ProductAnalysisResult(scanId: $scanId, productName: $productName, trustScore: $trustScore, trustLevel: $trustLevel, overallVerdict: $overallVerdict, flags: $flags, fssaiNumber: $fssaiNumber, legalDraftAvailable: $legalDraftAvailable, legalDraftText: $legalDraftText, healthierAlternatives: $healthierAlternatives, allergyRisks: $allergyRisks, upfScore: $upfScore, isNonEdible: $isNonEdible)';
}


}

/// @nodoc
abstract mixin class _$ProductAnalysisResultCopyWith<$Res> implements $ProductAnalysisResultCopyWith<$Res> {
  factory _$ProductAnalysisResultCopyWith(_ProductAnalysisResult value, $Res Function(_ProductAnalysisResult) _then) = __$ProductAnalysisResultCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'scan_id') String? scanId,@JsonKey(name: 'product_name') String? productName,@JsonKey(name: 'trust_score') double? trustScore,@JsonKey(name: 'trust_level') String trustLevel,@JsonKey(name: 'overall_verdict') String overallVerdict, List<FlagItem> flags,@JsonKey(name: 'fssai_number') String? fssaiNumber,@JsonKey(name: 'legal_draft_available') bool legalDraftAvailable,@JsonKey(name: 'legal_draft_text') String? legalDraftText,@JsonKey(name: 'healthier_alternatives') List<String>? healthierAlternatives,@JsonKey(name: 'allergy_risks') List<String>? allergyRisks,@JsonKey(name: 'upf_score') double? upfScore,@JsonKey(name: 'is_non_edible') bool isNonEdible
});




}
/// @nodoc
class __$ProductAnalysisResultCopyWithImpl<$Res>
    implements _$ProductAnalysisResultCopyWith<$Res> {
  __$ProductAnalysisResultCopyWithImpl(this._self, this._then);

  final _ProductAnalysisResult _self;
  final $Res Function(_ProductAnalysisResult) _then;

/// Create a copy of ProductAnalysisResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? scanId = freezed,Object? productName = freezed,Object? trustScore = freezed,Object? trustLevel = null,Object? overallVerdict = null,Object? flags = null,Object? fssaiNumber = freezed,Object? legalDraftAvailable = null,Object? legalDraftText = freezed,Object? healthierAlternatives = freezed,Object? allergyRisks = freezed,Object? upfScore = freezed,Object? isNonEdible = null,}) {
  return _then(_ProductAnalysisResult(
scanId: freezed == scanId ? _self.scanId : scanId // ignore: cast_nullable_to_non_nullable
as String?,productName: freezed == productName ? _self.productName : productName // ignore: cast_nullable_to_non_nullable
as String?,trustScore: freezed == trustScore ? _self.trustScore : trustScore // ignore: cast_nullable_to_non_nullable
as double?,trustLevel: null == trustLevel ? _self.trustLevel : trustLevel // ignore: cast_nullable_to_non_nullable
as String,overallVerdict: null == overallVerdict ? _self.overallVerdict : overallVerdict // ignore: cast_nullable_to_non_nullable
as String,flags: null == flags ? _self._flags : flags // ignore: cast_nullable_to_non_nullable
as List<FlagItem>,fssaiNumber: freezed == fssaiNumber ? _self.fssaiNumber : fssaiNumber // ignore: cast_nullable_to_non_nullable
as String?,legalDraftAvailable: null == legalDraftAvailable ? _self.legalDraftAvailable : legalDraftAvailable // ignore: cast_nullable_to_non_nullable
as bool,legalDraftText: freezed == legalDraftText ? _self.legalDraftText : legalDraftText // ignore: cast_nullable_to_non_nullable
as String?,healthierAlternatives: freezed == healthierAlternatives ? _self._healthierAlternatives : healthierAlternatives // ignore: cast_nullable_to_non_nullable
as List<String>?,allergyRisks: freezed == allergyRisks ? _self._allergyRisks : allergyRisks // ignore: cast_nullable_to_non_nullable
as List<String>?,upfScore: freezed == upfScore ? _self.upfScore : upfScore // ignore: cast_nullable_to_non_nullable
as double?,isNonEdible: null == isNonEdible ? _self.isNonEdible : isNonEdible // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
