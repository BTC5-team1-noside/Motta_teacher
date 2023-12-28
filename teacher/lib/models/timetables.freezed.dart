// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'timetables.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Timetables _$TimetablesFromJson(Map<String, dynamic> json) {
  return _Timetables.fromJson(json);
}

/// @nodoc
mixin _$Timetables {
  List<TimetableList> get timetableList => throw _privateConstructorUsedError;
  List<String> get subjectNames => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TimetablesCopyWith<Timetables> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TimetablesCopyWith<$Res> {
  factory $TimetablesCopyWith(
          Timetables value, $Res Function(Timetables) then) =
      _$TimetablesCopyWithImpl<$Res, Timetables>;
  @useResult
  $Res call({List<TimetableList> timetableList, List<String> subjectNames});
}

/// @nodoc
class _$TimetablesCopyWithImpl<$Res, $Val extends Timetables>
    implements $TimetablesCopyWith<$Res> {
  _$TimetablesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? timetableList = null,
    Object? subjectNames = null,
  }) {
    return _then(_value.copyWith(
      timetableList: null == timetableList
          ? _value.timetableList
          : timetableList // ignore: cast_nullable_to_non_nullable
              as List<TimetableList>,
      subjectNames: null == subjectNames
          ? _value.subjectNames
          : subjectNames // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TimetablesImplCopyWith<$Res>
    implements $TimetablesCopyWith<$Res> {
  factory _$$TimetablesImplCopyWith(
          _$TimetablesImpl value, $Res Function(_$TimetablesImpl) then) =
      __$$TimetablesImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<TimetableList> timetableList, List<String> subjectNames});
}

/// @nodoc
class __$$TimetablesImplCopyWithImpl<$Res>
    extends _$TimetablesCopyWithImpl<$Res, _$TimetablesImpl>
    implements _$$TimetablesImplCopyWith<$Res> {
  __$$TimetablesImplCopyWithImpl(
      _$TimetablesImpl _value, $Res Function(_$TimetablesImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? timetableList = null,
    Object? subjectNames = null,
  }) {
    return _then(_$TimetablesImpl(
      timetableList: null == timetableList
          ? _value._timetableList
          : timetableList // ignore: cast_nullable_to_non_nullable
              as List<TimetableList>,
      subjectNames: null == subjectNames
          ? _value._subjectNames
          : subjectNames // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TimetablesImpl with DiagnosticableTreeMixin implements _Timetables {
  const _$TimetablesImpl(
      {required final List<TimetableList> timetableList,
      required final List<String> subjectNames})
      : _timetableList = timetableList,
        _subjectNames = subjectNames;

  factory _$TimetablesImpl.fromJson(Map<String, dynamic> json) =>
      _$$TimetablesImplFromJson(json);

  final List<TimetableList> _timetableList;
  @override
  List<TimetableList> get timetableList {
    if (_timetableList is EqualUnmodifiableListView) return _timetableList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_timetableList);
  }

  final List<String> _subjectNames;
  @override
  List<String> get subjectNames {
    if (_subjectNames is EqualUnmodifiableListView) return _subjectNames;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_subjectNames);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Timetables(timetableList: $timetableList, subjectNames: $subjectNames)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Timetables'))
      ..add(DiagnosticsProperty('timetableList', timetableList))
      ..add(DiagnosticsProperty('subjectNames', subjectNames));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TimetablesImpl &&
            const DeepCollectionEquality()
                .equals(other._timetableList, _timetableList) &&
            const DeepCollectionEquality()
                .equals(other._subjectNames, _subjectNames));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_timetableList),
      const DeepCollectionEquality().hash(_subjectNames));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TimetablesImplCopyWith<_$TimetablesImpl> get copyWith =>
      __$$TimetablesImplCopyWithImpl<_$TimetablesImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TimetablesImplToJson(
      this,
    );
  }
}

abstract class _Timetables implements Timetables {
  const factory _Timetables(
      {required final List<TimetableList> timetableList,
      required final List<String> subjectNames}) = _$TimetablesImpl;

  factory _Timetables.fromJson(Map<String, dynamic> json) =
      _$TimetablesImpl.fromJson;

  @override
  List<TimetableList> get timetableList;
  @override
  List<String> get subjectNames;
  @override
  @JsonKey(ignore: true)
  _$$TimetablesImplCopyWith<_$TimetablesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TimetableList _$TimetableListFromJson(Map<String, dynamic> json) {
  return _TimetableList.fromJson(json);
}

/// @nodoc
mixin _$TimetableList {
  String get day => throw _privateConstructorUsedError;
  List<Subjects> get subjects => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TimetableListCopyWith<TimetableList> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TimetableListCopyWith<$Res> {
  factory $TimetableListCopyWith(
          TimetableList value, $Res Function(TimetableList) then) =
      _$TimetableListCopyWithImpl<$Res, TimetableList>;
  @useResult
  $Res call({String day, List<Subjects> subjects});
}

/// @nodoc
class _$TimetableListCopyWithImpl<$Res, $Val extends TimetableList>
    implements $TimetableListCopyWith<$Res> {
  _$TimetableListCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? day = null,
    Object? subjects = null,
  }) {
    return _then(_value.copyWith(
      day: null == day
          ? _value.day
          : day // ignore: cast_nullable_to_non_nullable
              as String,
      subjects: null == subjects
          ? _value.subjects
          : subjects // ignore: cast_nullable_to_non_nullable
              as List<Subjects>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TimetableListImplCopyWith<$Res>
    implements $TimetableListCopyWith<$Res> {
  factory _$$TimetableListImplCopyWith(
          _$TimetableListImpl value, $Res Function(_$TimetableListImpl) then) =
      __$$TimetableListImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String day, List<Subjects> subjects});
}

/// @nodoc
class __$$TimetableListImplCopyWithImpl<$Res>
    extends _$TimetableListCopyWithImpl<$Res, _$TimetableListImpl>
    implements _$$TimetableListImplCopyWith<$Res> {
  __$$TimetableListImplCopyWithImpl(
      _$TimetableListImpl _value, $Res Function(_$TimetableListImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? day = null,
    Object? subjects = null,
  }) {
    return _then(_$TimetableListImpl(
      day: null == day
          ? _value.day
          : day // ignore: cast_nullable_to_non_nullable
              as String,
      subjects: null == subjects
          ? _value._subjects
          : subjects // ignore: cast_nullable_to_non_nullable
              as List<Subjects>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TimetableListImpl
    with DiagnosticableTreeMixin
    implements _TimetableList {
  const _$TimetableListImpl(
      {required this.day, required final List<Subjects> subjects})
      : _subjects = subjects;

  factory _$TimetableListImpl.fromJson(Map<String, dynamic> json) =>
      _$$TimetableListImplFromJson(json);

  @override
  final String day;
  final List<Subjects> _subjects;
  @override
  List<Subjects> get subjects {
    if (_subjects is EqualUnmodifiableListView) return _subjects;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_subjects);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'TimetableList(day: $day, subjects: $subjects)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'TimetableList'))
      ..add(DiagnosticsProperty('day', day))
      ..add(DiagnosticsProperty('subjects', subjects));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TimetableListImpl &&
            (identical(other.day, day) || other.day == day) &&
            const DeepCollectionEquality().equals(other._subjects, _subjects));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, day, const DeepCollectionEquality().hash(_subjects));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TimetableListImplCopyWith<_$TimetableListImpl> get copyWith =>
      __$$TimetableListImplCopyWithImpl<_$TimetableListImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TimetableListImplToJson(
      this,
    );
  }
}

abstract class _TimetableList implements TimetableList {
  const factory _TimetableList(
      {required final String day,
      required final List<Subjects> subjects}) = _$TimetableListImpl;

  factory _TimetableList.fromJson(Map<String, dynamic> json) =
      _$TimetableListImpl.fromJson;

  @override
  String get day;
  @override
  List<Subjects> get subjects;
  @override
  @JsonKey(ignore: true)
  _$$TimetableListImplCopyWith<_$TimetableListImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Subjects _$SubjectsFromJson(Map<String, dynamic> json) {
  return _Subjects.fromJson(json);
}

/// @nodoc
mixin _$Subjects {
  int get period => throw _privateConstructorUsedError;
  String get subject_name => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SubjectsCopyWith<Subjects> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SubjectsCopyWith<$Res> {
  factory $SubjectsCopyWith(Subjects value, $Res Function(Subjects) then) =
      _$SubjectsCopyWithImpl<$Res, Subjects>;
  @useResult
  $Res call({int period, String subject_name});
}

/// @nodoc
class _$SubjectsCopyWithImpl<$Res, $Val extends Subjects>
    implements $SubjectsCopyWith<$Res> {
  _$SubjectsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? period = null,
    Object? subject_name = null,
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
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SubjectsImplCopyWith<$Res>
    implements $SubjectsCopyWith<$Res> {
  factory _$$SubjectsImplCopyWith(
          _$SubjectsImpl value, $Res Function(_$SubjectsImpl) then) =
      __$$SubjectsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int period, String subject_name});
}

/// @nodoc
class __$$SubjectsImplCopyWithImpl<$Res>
    extends _$SubjectsCopyWithImpl<$Res, _$SubjectsImpl>
    implements _$$SubjectsImplCopyWith<$Res> {
  __$$SubjectsImplCopyWithImpl(
      _$SubjectsImpl _value, $Res Function(_$SubjectsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? period = null,
    Object? subject_name = null,
  }) {
    return _then(_$SubjectsImpl(
      period: null == period
          ? _value.period
          : period // ignore: cast_nullable_to_non_nullable
              as int,
      subject_name: null == subject_name
          ? _value.subject_name
          : subject_name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SubjectsImpl with DiagnosticableTreeMixin implements _Subjects {
  const _$SubjectsImpl({required this.period, required this.subject_name});

  factory _$SubjectsImpl.fromJson(Map<String, dynamic> json) =>
      _$$SubjectsImplFromJson(json);

  @override
  final int period;
  @override
  final String subject_name;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Subjects(period: $period, subject_name: $subject_name)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Subjects'))
      ..add(DiagnosticsProperty('period', period))
      ..add(DiagnosticsProperty('subject_name', subject_name));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SubjectsImpl &&
            (identical(other.period, period) || other.period == period) &&
            (identical(other.subject_name, subject_name) ||
                other.subject_name == subject_name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, period, subject_name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SubjectsImplCopyWith<_$SubjectsImpl> get copyWith =>
      __$$SubjectsImplCopyWithImpl<_$SubjectsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SubjectsImplToJson(
      this,
    );
  }
}

abstract class _Subjects implements Subjects {
  const factory _Subjects(
      {required final int period,
      required final String subject_name}) = _$SubjectsImpl;

  factory _Subjects.fromJson(Map<String, dynamic> json) =
      _$SubjectsImpl.fromJson;

  @override
  int get period;
  @override
  String get subject_name;
  @override
  @JsonKey(ignore: true)
  _$$SubjectsImplCopyWith<_$SubjectsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
