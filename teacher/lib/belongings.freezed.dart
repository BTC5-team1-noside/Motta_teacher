// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'belongings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

DayBelongings _$DayBelongingsFromJson(Map<String, dynamic> json) {
  return _DayBelongings.fromJson(json);
}

/// @nodoc
mixin _$DayBelongings {
  String get selectedDate => throw _privateConstructorUsedError;
  List<Subject> get subjects => throw _privateConstructorUsedError;
  List<String> get itemNames => throw _privateConstructorUsedError;
  List<String> get additionalItemNames => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DayBelongingsCopyWith<DayBelongings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DayBelongingsCopyWith<$Res> {
  factory $DayBelongingsCopyWith(
          DayBelongings value, $Res Function(DayBelongings) then) =
      _$DayBelongingsCopyWithImpl<$Res, DayBelongings>;
  @useResult
  $Res call(
      {String selectedDate,
      List<Subject> subjects,
      List<String> itemNames,
      List<String> additionalItemNames});
}

/// @nodoc
class _$DayBelongingsCopyWithImpl<$Res, $Val extends DayBelongings>
    implements $DayBelongingsCopyWith<$Res> {
  _$DayBelongingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedDate = null,
    Object? subjects = null,
    Object? itemNames = null,
    Object? additionalItemNames = null,
  }) {
    return _then(_value.copyWith(
      selectedDate: null == selectedDate
          ? _value.selectedDate
          : selectedDate // ignore: cast_nullable_to_non_nullable
              as String,
      subjects: null == subjects
          ? _value.subjects
          : subjects // ignore: cast_nullable_to_non_nullable
              as List<Subject>,
      itemNames: null == itemNames
          ? _value.itemNames
          : itemNames // ignore: cast_nullable_to_non_nullable
              as List<String>,
      additionalItemNames: null == additionalItemNames
          ? _value.additionalItemNames
          : additionalItemNames // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DayBelongingsImplCopyWith<$Res>
    implements $DayBelongingsCopyWith<$Res> {
  factory _$$DayBelongingsImplCopyWith(
          _$DayBelongingsImpl value, $Res Function(_$DayBelongingsImpl) then) =
      __$$DayBelongingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String selectedDate,
      List<Subject> subjects,
      List<String> itemNames,
      List<String> additionalItemNames});
}

/// @nodoc
class __$$DayBelongingsImplCopyWithImpl<$Res>
    extends _$DayBelongingsCopyWithImpl<$Res, _$DayBelongingsImpl>
    implements _$$DayBelongingsImplCopyWith<$Res> {
  __$$DayBelongingsImplCopyWithImpl(
      _$DayBelongingsImpl _value, $Res Function(_$DayBelongingsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedDate = null,
    Object? subjects = null,
    Object? itemNames = null,
    Object? additionalItemNames = null,
  }) {
    return _then(_$DayBelongingsImpl(
      selectedDate: null == selectedDate
          ? _value.selectedDate
          : selectedDate // ignore: cast_nullable_to_non_nullable
              as String,
      subjects: null == subjects
          ? _value._subjects
          : subjects // ignore: cast_nullable_to_non_nullable
              as List<Subject>,
      itemNames: null == itemNames
          ? _value._itemNames
          : itemNames // ignore: cast_nullable_to_non_nullable
              as List<String>,
      additionalItemNames: null == additionalItemNames
          ? _value._additionalItemNames
          : additionalItemNames // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DayBelongingsImpl
    with DiagnosticableTreeMixin
    implements _DayBelongings {
  const _$DayBelongingsImpl(
      {required this.selectedDate,
      required final List<Subject> subjects,
      required final List<String> itemNames,
      required final List<String> additionalItemNames})
      : _subjects = subjects,
        _itemNames = itemNames,
        _additionalItemNames = additionalItemNames;

  factory _$DayBelongingsImpl.fromJson(Map<String, dynamic> json) =>
      _$$DayBelongingsImplFromJson(json);

  @override
  final String selectedDate;
  final List<Subject> _subjects;
  @override
  List<Subject> get subjects {
    if (_subjects is EqualUnmodifiableListView) return _subjects;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_subjects);
  }

  final List<String> _itemNames;
  @override
  List<String> get itemNames {
    if (_itemNames is EqualUnmodifiableListView) return _itemNames;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_itemNames);
  }

  final List<String> _additionalItemNames;
  @override
  List<String> get additionalItemNames {
    if (_additionalItemNames is EqualUnmodifiableListView)
      return _additionalItemNames;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_additionalItemNames);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'DayBelongings(selectedDate: $selectedDate, subjects: $subjects, itemNames: $itemNames, additionalItemNames: $additionalItemNames)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'DayBelongings'))
      ..add(DiagnosticsProperty('selectedDate', selectedDate))
      ..add(DiagnosticsProperty('subjects', subjects))
      ..add(DiagnosticsProperty('itemNames', itemNames))
      ..add(DiagnosticsProperty('additionalItemNames', additionalItemNames));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DayBelongingsImpl &&
            (identical(other.selectedDate, selectedDate) ||
                other.selectedDate == selectedDate) &&
            const DeepCollectionEquality().equals(other._subjects, _subjects) &&
            const DeepCollectionEquality()
                .equals(other._itemNames, _itemNames) &&
            const DeepCollectionEquality()
                .equals(other._additionalItemNames, _additionalItemNames));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      selectedDate,
      const DeepCollectionEquality().hash(_subjects),
      const DeepCollectionEquality().hash(_itemNames),
      const DeepCollectionEquality().hash(_additionalItemNames));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DayBelongingsImplCopyWith<_$DayBelongingsImpl> get copyWith =>
      __$$DayBelongingsImplCopyWithImpl<_$DayBelongingsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DayBelongingsImplToJson(
      this,
    );
  }
}

abstract class _DayBelongings implements DayBelongings {
  const factory _DayBelongings(
      {required final String selectedDate,
      required final List<Subject> subjects,
      required final List<String> itemNames,
      required final List<String> additionalItemNames}) = _$DayBelongingsImpl;

  factory _DayBelongings.fromJson(Map<String, dynamic> json) =
      _$DayBelongingsImpl.fromJson;

  @override
  String get selectedDate;
  @override
  List<Subject> get subjects;
  @override
  List<String> get itemNames;
  @override
  List<String> get additionalItemNames;
  @override
  @JsonKey(ignore: true)
  _$$DayBelongingsImplCopyWith<_$DayBelongingsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Subject _$SubjectFromJson(Map<String, dynamic> json) {
  return _Subject.fromJson(json);
}

/// @nodoc
mixin _$Subject {
  int get period => throw _privateConstructorUsedError;
  String get subject_name => throw _privateConstructorUsedError;
  List<String> get belongings => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SubjectCopyWith<Subject> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SubjectCopyWith<$Res> {
  factory $SubjectCopyWith(Subject value, $Res Function(Subject) then) =
      _$SubjectCopyWithImpl<$Res, Subject>;
  @useResult
  $Res call({int period, String subject_name, List<String> belongings});
}

/// @nodoc
class _$SubjectCopyWithImpl<$Res, $Val extends Subject>
    implements $SubjectCopyWith<$Res> {
  _$SubjectCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? period = null,
    Object? subject_name = null,
    Object? belongings = null,
  }) {
    return _then(_value.copyWith(
      period: null == period
          ? _value.period
          : period // ignore: cast_nullable_to_non_nullable
              as int,
      subject_name: null == subject_name
          ? _value.subject_name
          : subject_name // ignore: cast_nullable_to_non_nullable
              as String,
      belongings: null == belongings
          ? _value.belongings
          : belongings // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SubjectImplCopyWith<$Res> implements $SubjectCopyWith<$Res> {
  factory _$$SubjectImplCopyWith(
          _$SubjectImpl value, $Res Function(_$SubjectImpl) then) =
      __$$SubjectImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int period, String subject_name, List<String> belongings});
}

/// @nodoc
class __$$SubjectImplCopyWithImpl<$Res>
    extends _$SubjectCopyWithImpl<$Res, _$SubjectImpl>
    implements _$$SubjectImplCopyWith<$Res> {
  __$$SubjectImplCopyWithImpl(
      _$SubjectImpl _value, $Res Function(_$SubjectImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? period = null,
    Object? subject_name = null,
    Object? belongings = null,
  }) {
    return _then(_$SubjectImpl(
      period: null == period
          ? _value.period
          : period // ignore: cast_nullable_to_non_nullable
              as int,
      subject_name: null == subject_name
          ? _value.subject_name
          : subject_name // ignore: cast_nullable_to_non_nullable
              as String,
      belongings: null == belongings
          ? _value._belongings
          : belongings // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SubjectImpl with DiagnosticableTreeMixin implements _Subject {
  const _$SubjectImpl(
      {required this.period,
      required this.subject_name,
      required final List<String> belongings})
      : _belongings = belongings;

  factory _$SubjectImpl.fromJson(Map<String, dynamic> json) =>
      _$$SubjectImplFromJson(json);

  @override
  final int period;
  @override
  final String subject_name;
  final List<String> _belongings;
  @override
  List<String> get belongings {
    if (_belongings is EqualUnmodifiableListView) return _belongings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_belongings);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Subject(period: $period, subject_name: $subject_name, belongings: $belongings)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Subject'))
      ..add(DiagnosticsProperty('period', period))
      ..add(DiagnosticsProperty('subject_name', subject_name))
      ..add(DiagnosticsProperty('belongings', belongings));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SubjectImpl &&
            (identical(other.period, period) || other.period == period) &&
            (identical(other.subject_name, subject_name) ||
                other.subject_name == subject_name) &&
            const DeepCollectionEquality()
                .equals(other._belongings, _belongings));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, period, subject_name,
      const DeepCollectionEquality().hash(_belongings));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SubjectImplCopyWith<_$SubjectImpl> get copyWith =>
      __$$SubjectImplCopyWithImpl<_$SubjectImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SubjectImplToJson(
      this,
    );
  }
}

abstract class _Subject implements Subject {
  const factory _Subject(
      {required final int period,
      required final String subject_name,
      required final List<String> belongings}) = _$SubjectImpl;

  factory _Subject.fromJson(Map<String, dynamic> json) = _$SubjectImpl.fromJson;

  @override
  int get period;
  @override
  String get subject_name;
  @override
  List<String> get belongings;
  @override
  @JsonKey(ignore: true)
  _$$SubjectImplCopyWith<_$SubjectImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
