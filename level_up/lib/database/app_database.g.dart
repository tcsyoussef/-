// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $ProfilesTable extends Profiles with TableInfo<$ProfilesTable, Profile> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProfilesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _wakeUpMeta = const VerificationMeta('wakeUp');
  @override
  late final GeneratedColumn<String> wakeUp = GeneratedColumn<String>(
      'wake_up', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('12:00'));
  static const VerificationMeta _sleepTimeMeta =
      const VerificationMeta('sleepTime');
  @override
  late final GeneratedColumn<String> sleepTime = GeneratedColumn<String>(
      'sleep_time', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('04:00'));
  static const VerificationMeta _dailyDevMinutesMeta =
      const VerificationMeta('dailyDevMinutes');
  @override
  late final GeneratedColumn<int> dailyDevMinutes = GeneratedColumn<int>(
      'daily_dev_minutes', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(360));
  static const VerificationMeta _trainingLocationMeta =
      const VerificationMeta('trainingLocation');
  @override
  late final GeneratedColumn<String> trainingLocation = GeneratedColumn<String>(
      'training_location', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('Home'));
  static const VerificationMeta _englishLevelMeta =
      const VerificationMeta('englishLevel');
  @override
  late final GeneratedColumn<String> englishLevel = GeneratedColumn<String>(
      'english_level', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('A2 / early B1'));
  static const VerificationMeta _englishTargetMeta =
      const VerificationMeta('englishTarget');
  @override
  late final GeneratedColumn<String> englishTarget = GeneratedColumn<String>(
      'english_target', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('Strong B2 / late B2'));
  static const VerificationMeta _repairLevelMeta =
      const VerificationMeta('repairLevel');
  @override
  late final GeneratedColumn<String> repairLevel = GeneratedColumn<String>(
      'repair_level', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue:
          const Constant('Advanced motherboard diagnosis and repair'));
  static const VerificationMeta _equipmentNotesMeta =
      const VerificationMeta('equipmentNotes');
  @override
  late final GeneratedColumn<String> equipmentNotes = GeneratedColumn<String>(
      'equipment_notes', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(
          'Basic digital multimeter; one faulty laptop motherboard'));
  static const VerificationMeta _nutritionBudgetMeta =
      const VerificationMeta('nutritionBudget');
  @override
  late final GeneratedColumn<String> nutritionBudget = GeneratedColumn<String>(
      'nutrition_budget', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('Very low'));
  static const VerificationMeta _skincareStatusMeta =
      const VerificationMeta('skincareStatus');
  @override
  late final GeneratedColumn<String> skincareStatus = GeneratedColumn<String>(
      'skincare_status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('None currently'));
  static const VerificationMeta _trainingStyleMeta =
      const VerificationMeta('trainingStyle');
  @override
  late final GeneratedColumn<String> trainingStyle = GeneratedColumn<String>(
      'training_style', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('Bodyweight + household backpack'));
  static const VerificationMeta _languageMeta =
      const VerificationMeta('language');
  @override
  late final GeneratedColumn<String> language = GeneratedColumn<String>(
      'language', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('English'));
  static const VerificationMeta _currencyMeta =
      const VerificationMeta('currency');
  @override
  late final GeneratedColumn<String> currency = GeneratedColumn<String>(
      'currency', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('MAD'));
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        wakeUp,
        sleepTime,
        dailyDevMinutes,
        trainingLocation,
        englishLevel,
        englishTarget,
        repairLevel,
        equipmentNotes,
        nutritionBudget,
        skincareStatus,
        trainingStyle,
        language,
        currency,
        notes,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'profiles';
  @override
  VerificationContext validateIntegrity(Insertable<Profile> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('wake_up')) {
      context.handle(_wakeUpMeta,
          wakeUp.isAcceptableOrUnknown(data['wake_up']!, _wakeUpMeta));
    }
    if (data.containsKey('sleep_time')) {
      context.handle(_sleepTimeMeta,
          sleepTime.isAcceptableOrUnknown(data['sleep_time']!, _sleepTimeMeta));
    }
    if (data.containsKey('daily_dev_minutes')) {
      context.handle(
          _dailyDevMinutesMeta,
          dailyDevMinutes.isAcceptableOrUnknown(
              data['daily_dev_minutes']!, _dailyDevMinutesMeta));
    }
    if (data.containsKey('training_location')) {
      context.handle(
          _trainingLocationMeta,
          trainingLocation.isAcceptableOrUnknown(
              data['training_location']!, _trainingLocationMeta));
    }
    if (data.containsKey('english_level')) {
      context.handle(
          _englishLevelMeta,
          englishLevel.isAcceptableOrUnknown(
              data['english_level']!, _englishLevelMeta));
    }
    if (data.containsKey('english_target')) {
      context.handle(
          _englishTargetMeta,
          englishTarget.isAcceptableOrUnknown(
              data['english_target']!, _englishTargetMeta));
    }
    if (data.containsKey('repair_level')) {
      context.handle(
          _repairLevelMeta,
          repairLevel.isAcceptableOrUnknown(
              data['repair_level']!, _repairLevelMeta));
    }
    if (data.containsKey('equipment_notes')) {
      context.handle(
          _equipmentNotesMeta,
          equipmentNotes.isAcceptableOrUnknown(
              data['equipment_notes']!, _equipmentNotesMeta));
    }
    if (data.containsKey('nutrition_budget')) {
      context.handle(
          _nutritionBudgetMeta,
          nutritionBudget.isAcceptableOrUnknown(
              data['nutrition_budget']!, _nutritionBudgetMeta));
    }
    if (data.containsKey('skincare_status')) {
      context.handle(
          _skincareStatusMeta,
          skincareStatus.isAcceptableOrUnknown(
              data['skincare_status']!, _skincareStatusMeta));
    }
    if (data.containsKey('training_style')) {
      context.handle(
          _trainingStyleMeta,
          trainingStyle.isAcceptableOrUnknown(
              data['training_style']!, _trainingStyleMeta));
    }
    if (data.containsKey('language')) {
      context.handle(_languageMeta,
          language.isAcceptableOrUnknown(data['language']!, _languageMeta));
    }
    if (data.containsKey('currency')) {
      context.handle(_currencyMeta,
          currency.isAcceptableOrUnknown(data['currency']!, _currencyMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Profile map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Profile(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      wakeUp: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}wake_up'])!,
      sleepTime: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sleep_time'])!,
      dailyDevMinutes: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}daily_dev_minutes'])!,
      trainingLocation: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}training_location'])!,
      englishLevel: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}english_level'])!,
      englishTarget: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}english_target'])!,
      repairLevel: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}repair_level'])!,
      equipmentNotes: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}equipment_notes'])!,
      nutritionBudget: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}nutrition_budget'])!,
      skincareStatus: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}skincare_status'])!,
      trainingStyle: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}training_style'])!,
      language: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}language'])!,
      currency: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}currency'])!,
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $ProfilesTable createAlias(String alias) {
    return $ProfilesTable(attachedDatabase, alias);
  }
}

class Profile extends DataClass implements Insertable<Profile> {
  final int id;
  final String wakeUp;
  final String sleepTime;
  final int dailyDevMinutes;
  final String trainingLocation;
  final String englishLevel;
  final String englishTarget;
  final String repairLevel;
  final String equipmentNotes;
  final String nutritionBudget;
  final String skincareStatus;
  final String trainingStyle;
  final String language;
  final String currency;
  final String? notes;
  final DateTime updatedAt;
  const Profile(
      {required this.id,
      required this.wakeUp,
      required this.sleepTime,
      required this.dailyDevMinutes,
      required this.trainingLocation,
      required this.englishLevel,
      required this.englishTarget,
      required this.repairLevel,
      required this.equipmentNotes,
      required this.nutritionBudget,
      required this.skincareStatus,
      required this.trainingStyle,
      required this.language,
      required this.currency,
      this.notes,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['wake_up'] = Variable<String>(wakeUp);
    map['sleep_time'] = Variable<String>(sleepTime);
    map['daily_dev_minutes'] = Variable<int>(dailyDevMinutes);
    map['training_location'] = Variable<String>(trainingLocation);
    map['english_level'] = Variable<String>(englishLevel);
    map['english_target'] = Variable<String>(englishTarget);
    map['repair_level'] = Variable<String>(repairLevel);
    map['equipment_notes'] = Variable<String>(equipmentNotes);
    map['nutrition_budget'] = Variable<String>(nutritionBudget);
    map['skincare_status'] = Variable<String>(skincareStatus);
    map['training_style'] = Variable<String>(trainingStyle);
    map['language'] = Variable<String>(language);
    map['currency'] = Variable<String>(currency);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ProfilesCompanion toCompanion(bool nullToAbsent) {
    return ProfilesCompanion(
      id: Value(id),
      wakeUp: Value(wakeUp),
      sleepTime: Value(sleepTime),
      dailyDevMinutes: Value(dailyDevMinutes),
      trainingLocation: Value(trainingLocation),
      englishLevel: Value(englishLevel),
      englishTarget: Value(englishTarget),
      repairLevel: Value(repairLevel),
      equipmentNotes: Value(equipmentNotes),
      nutritionBudget: Value(nutritionBudget),
      skincareStatus: Value(skincareStatus),
      trainingStyle: Value(trainingStyle),
      language: Value(language),
      currency: Value(currency),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      updatedAt: Value(updatedAt),
    );
  }

  factory Profile.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Profile(
      id: serializer.fromJson<int>(json['id']),
      wakeUp: serializer.fromJson<String>(json['wakeUp']),
      sleepTime: serializer.fromJson<String>(json['sleepTime']),
      dailyDevMinutes: serializer.fromJson<int>(json['dailyDevMinutes']),
      trainingLocation: serializer.fromJson<String>(json['trainingLocation']),
      englishLevel: serializer.fromJson<String>(json['englishLevel']),
      englishTarget: serializer.fromJson<String>(json['englishTarget']),
      repairLevel: serializer.fromJson<String>(json['repairLevel']),
      equipmentNotes: serializer.fromJson<String>(json['equipmentNotes']),
      nutritionBudget: serializer.fromJson<String>(json['nutritionBudget']),
      skincareStatus: serializer.fromJson<String>(json['skincareStatus']),
      trainingStyle: serializer.fromJson<String>(json['trainingStyle']),
      language: serializer.fromJson<String>(json['language']),
      currency: serializer.fromJson<String>(json['currency']),
      notes: serializer.fromJson<String?>(json['notes']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'wakeUp': serializer.toJson<String>(wakeUp),
      'sleepTime': serializer.toJson<String>(sleepTime),
      'dailyDevMinutes': serializer.toJson<int>(dailyDevMinutes),
      'trainingLocation': serializer.toJson<String>(trainingLocation),
      'englishLevel': serializer.toJson<String>(englishLevel),
      'englishTarget': serializer.toJson<String>(englishTarget),
      'repairLevel': serializer.toJson<String>(repairLevel),
      'equipmentNotes': serializer.toJson<String>(equipmentNotes),
      'nutritionBudget': serializer.toJson<String>(nutritionBudget),
      'skincareStatus': serializer.toJson<String>(skincareStatus),
      'trainingStyle': serializer.toJson<String>(trainingStyle),
      'language': serializer.toJson<String>(language),
      'currency': serializer.toJson<String>(currency),
      'notes': serializer.toJson<String?>(notes),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Profile copyWith(
          {int? id,
          String? wakeUp,
          String? sleepTime,
          int? dailyDevMinutes,
          String? trainingLocation,
          String? englishLevel,
          String? englishTarget,
          String? repairLevel,
          String? equipmentNotes,
          String? nutritionBudget,
          String? skincareStatus,
          String? trainingStyle,
          String? language,
          String? currency,
          Value<String?> notes = const Value.absent(),
          DateTime? updatedAt}) =>
      Profile(
        id: id ?? this.id,
        wakeUp: wakeUp ?? this.wakeUp,
        sleepTime: sleepTime ?? this.sleepTime,
        dailyDevMinutes: dailyDevMinutes ?? this.dailyDevMinutes,
        trainingLocation: trainingLocation ?? this.trainingLocation,
        englishLevel: englishLevel ?? this.englishLevel,
        englishTarget: englishTarget ?? this.englishTarget,
        repairLevel: repairLevel ?? this.repairLevel,
        equipmentNotes: equipmentNotes ?? this.equipmentNotes,
        nutritionBudget: nutritionBudget ?? this.nutritionBudget,
        skincareStatus: skincareStatus ?? this.skincareStatus,
        trainingStyle: trainingStyle ?? this.trainingStyle,
        language: language ?? this.language,
        currency: currency ?? this.currency,
        notes: notes.present ? notes.value : this.notes,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  Profile copyWithCompanion(ProfilesCompanion data) {
    return Profile(
      id: data.id.present ? data.id.value : this.id,
      wakeUp: data.wakeUp.present ? data.wakeUp.value : this.wakeUp,
      sleepTime: data.sleepTime.present ? data.sleepTime.value : this.sleepTime,
      dailyDevMinutes: data.dailyDevMinutes.present
          ? data.dailyDevMinutes.value
          : this.dailyDevMinutes,
      trainingLocation: data.trainingLocation.present
          ? data.trainingLocation.value
          : this.trainingLocation,
      englishLevel: data.englishLevel.present
          ? data.englishLevel.value
          : this.englishLevel,
      englishTarget: data.englishTarget.present
          ? data.englishTarget.value
          : this.englishTarget,
      repairLevel:
          data.repairLevel.present ? data.repairLevel.value : this.repairLevel,
      equipmentNotes: data.equipmentNotes.present
          ? data.equipmentNotes.value
          : this.equipmentNotes,
      nutritionBudget: data.nutritionBudget.present
          ? data.nutritionBudget.value
          : this.nutritionBudget,
      skincareStatus: data.skincareStatus.present
          ? data.skincareStatus.value
          : this.skincareStatus,
      trainingStyle: data.trainingStyle.present
          ? data.trainingStyle.value
          : this.trainingStyle,
      language: data.language.present ? data.language.value : this.language,
      currency: data.currency.present ? data.currency.value : this.currency,
      notes: data.notes.present ? data.notes.value : this.notes,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Profile(')
          ..write('id: $id, ')
          ..write('wakeUp: $wakeUp, ')
          ..write('sleepTime: $sleepTime, ')
          ..write('dailyDevMinutes: $dailyDevMinutes, ')
          ..write('trainingLocation: $trainingLocation, ')
          ..write('englishLevel: $englishLevel, ')
          ..write('englishTarget: $englishTarget, ')
          ..write('repairLevel: $repairLevel, ')
          ..write('equipmentNotes: $equipmentNotes, ')
          ..write('nutritionBudget: $nutritionBudget, ')
          ..write('skincareStatus: $skincareStatus, ')
          ..write('trainingStyle: $trainingStyle, ')
          ..write('language: $language, ')
          ..write('currency: $currency, ')
          ..write('notes: $notes, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      wakeUp,
      sleepTime,
      dailyDevMinutes,
      trainingLocation,
      englishLevel,
      englishTarget,
      repairLevel,
      equipmentNotes,
      nutritionBudget,
      skincareStatus,
      trainingStyle,
      language,
      currency,
      notes,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Profile &&
          other.id == this.id &&
          other.wakeUp == this.wakeUp &&
          other.sleepTime == this.sleepTime &&
          other.dailyDevMinutes == this.dailyDevMinutes &&
          other.trainingLocation == this.trainingLocation &&
          other.englishLevel == this.englishLevel &&
          other.englishTarget == this.englishTarget &&
          other.repairLevel == this.repairLevel &&
          other.equipmentNotes == this.equipmentNotes &&
          other.nutritionBudget == this.nutritionBudget &&
          other.skincareStatus == this.skincareStatus &&
          other.trainingStyle == this.trainingStyle &&
          other.language == this.language &&
          other.currency == this.currency &&
          other.notes == this.notes &&
          other.updatedAt == this.updatedAt);
}

class ProfilesCompanion extends UpdateCompanion<Profile> {
  final Value<int> id;
  final Value<String> wakeUp;
  final Value<String> sleepTime;
  final Value<int> dailyDevMinutes;
  final Value<String> trainingLocation;
  final Value<String> englishLevel;
  final Value<String> englishTarget;
  final Value<String> repairLevel;
  final Value<String> equipmentNotes;
  final Value<String> nutritionBudget;
  final Value<String> skincareStatus;
  final Value<String> trainingStyle;
  final Value<String> language;
  final Value<String> currency;
  final Value<String?> notes;
  final Value<DateTime> updatedAt;
  const ProfilesCompanion({
    this.id = const Value.absent(),
    this.wakeUp = const Value.absent(),
    this.sleepTime = const Value.absent(),
    this.dailyDevMinutes = const Value.absent(),
    this.trainingLocation = const Value.absent(),
    this.englishLevel = const Value.absent(),
    this.englishTarget = const Value.absent(),
    this.repairLevel = const Value.absent(),
    this.equipmentNotes = const Value.absent(),
    this.nutritionBudget = const Value.absent(),
    this.skincareStatus = const Value.absent(),
    this.trainingStyle = const Value.absent(),
    this.language = const Value.absent(),
    this.currency = const Value.absent(),
    this.notes = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  ProfilesCompanion.insert({
    this.id = const Value.absent(),
    this.wakeUp = const Value.absent(),
    this.sleepTime = const Value.absent(),
    this.dailyDevMinutes = const Value.absent(),
    this.trainingLocation = const Value.absent(),
    this.englishLevel = const Value.absent(),
    this.englishTarget = const Value.absent(),
    this.repairLevel = const Value.absent(),
    this.equipmentNotes = const Value.absent(),
    this.nutritionBudget = const Value.absent(),
    this.skincareStatus = const Value.absent(),
    this.trainingStyle = const Value.absent(),
    this.language = const Value.absent(),
    this.currency = const Value.absent(),
    this.notes = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  static Insertable<Profile> custom({
    Expression<int>? id,
    Expression<String>? wakeUp,
    Expression<String>? sleepTime,
    Expression<int>? dailyDevMinutes,
    Expression<String>? trainingLocation,
    Expression<String>? englishLevel,
    Expression<String>? englishTarget,
    Expression<String>? repairLevel,
    Expression<String>? equipmentNotes,
    Expression<String>? nutritionBudget,
    Expression<String>? skincareStatus,
    Expression<String>? trainingStyle,
    Expression<String>? language,
    Expression<String>? currency,
    Expression<String>? notes,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (wakeUp != null) 'wake_up': wakeUp,
      if (sleepTime != null) 'sleep_time': sleepTime,
      if (dailyDevMinutes != null) 'daily_dev_minutes': dailyDevMinutes,
      if (trainingLocation != null) 'training_location': trainingLocation,
      if (englishLevel != null) 'english_level': englishLevel,
      if (englishTarget != null) 'english_target': englishTarget,
      if (repairLevel != null) 'repair_level': repairLevel,
      if (equipmentNotes != null) 'equipment_notes': equipmentNotes,
      if (nutritionBudget != null) 'nutrition_budget': nutritionBudget,
      if (skincareStatus != null) 'skincare_status': skincareStatus,
      if (trainingStyle != null) 'training_style': trainingStyle,
      if (language != null) 'language': language,
      if (currency != null) 'currency': currency,
      if (notes != null) 'notes': notes,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  ProfilesCompanion copyWith(
      {Value<int>? id,
      Value<String>? wakeUp,
      Value<String>? sleepTime,
      Value<int>? dailyDevMinutes,
      Value<String>? trainingLocation,
      Value<String>? englishLevel,
      Value<String>? englishTarget,
      Value<String>? repairLevel,
      Value<String>? equipmentNotes,
      Value<String>? nutritionBudget,
      Value<String>? skincareStatus,
      Value<String>? trainingStyle,
      Value<String>? language,
      Value<String>? currency,
      Value<String?>? notes,
      Value<DateTime>? updatedAt}) {
    return ProfilesCompanion(
      id: id ?? this.id,
      wakeUp: wakeUp ?? this.wakeUp,
      sleepTime: sleepTime ?? this.sleepTime,
      dailyDevMinutes: dailyDevMinutes ?? this.dailyDevMinutes,
      trainingLocation: trainingLocation ?? this.trainingLocation,
      englishLevel: englishLevel ?? this.englishLevel,
      englishTarget: englishTarget ?? this.englishTarget,
      repairLevel: repairLevel ?? this.repairLevel,
      equipmentNotes: equipmentNotes ?? this.equipmentNotes,
      nutritionBudget: nutritionBudget ?? this.nutritionBudget,
      skincareStatus: skincareStatus ?? this.skincareStatus,
      trainingStyle: trainingStyle ?? this.trainingStyle,
      language: language ?? this.language,
      currency: currency ?? this.currency,
      notes: notes ?? this.notes,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (wakeUp.present) {
      map['wake_up'] = Variable<String>(wakeUp.value);
    }
    if (sleepTime.present) {
      map['sleep_time'] = Variable<String>(sleepTime.value);
    }
    if (dailyDevMinutes.present) {
      map['daily_dev_minutes'] = Variable<int>(dailyDevMinutes.value);
    }
    if (trainingLocation.present) {
      map['training_location'] = Variable<String>(trainingLocation.value);
    }
    if (englishLevel.present) {
      map['english_level'] = Variable<String>(englishLevel.value);
    }
    if (englishTarget.present) {
      map['english_target'] = Variable<String>(englishTarget.value);
    }
    if (repairLevel.present) {
      map['repair_level'] = Variable<String>(repairLevel.value);
    }
    if (equipmentNotes.present) {
      map['equipment_notes'] = Variable<String>(equipmentNotes.value);
    }
    if (nutritionBudget.present) {
      map['nutrition_budget'] = Variable<String>(nutritionBudget.value);
    }
    if (skincareStatus.present) {
      map['skincare_status'] = Variable<String>(skincareStatus.value);
    }
    if (trainingStyle.present) {
      map['training_style'] = Variable<String>(trainingStyle.value);
    }
    if (language.present) {
      map['language'] = Variable<String>(language.value);
    }
    if (currency.present) {
      map['currency'] = Variable<String>(currency.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProfilesCompanion(')
          ..write('id: $id, ')
          ..write('wakeUp: $wakeUp, ')
          ..write('sleepTime: $sleepTime, ')
          ..write('dailyDevMinutes: $dailyDevMinutes, ')
          ..write('trainingLocation: $trainingLocation, ')
          ..write('englishLevel: $englishLevel, ')
          ..write('englishTarget: $englishTarget, ')
          ..write('repairLevel: $repairLevel, ')
          ..write('equipmentNotes: $equipmentNotes, ')
          ..write('nutritionBudget: $nutritionBudget, ')
          ..write('skincareStatus: $skincareStatus, ')
          ..write('trainingStyle: $trainingStyle, ')
          ..write('language: $language, ')
          ..write('currency: $currency, ')
          ..write('notes: $notes, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $AppSettingsTable extends AppSettings
    with TableInfo<$AppSettingsTable, AppSetting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppSettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _notificationsEnabledMeta =
      const VerificationMeta('notificationsEnabled');
  @override
  late final GeneratedColumn<bool> notificationsEnabled = GeneratedColumn<bool>(
      'notifications_enabled', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("notifications_enabled" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _notificationPermissionGrantedMeta =
      const VerificationMeta('notificationPermissionGranted');
  @override
  late final GeneratedColumn<bool> notificationPermissionGranted =
      GeneratedColumn<bool>(
          'notification_permission_granted', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintIsAlways(
              'CHECK ("notification_permission_granted" IN (0, 1))'),
          defaultValue: const Constant(false));
  static const VerificationMeta _reminderWakeMeta =
      const VerificationMeta('reminderWake');
  @override
  late final GeneratedColumn<String> reminderWake = GeneratedColumn<String>(
      'reminder_wake', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('12:00'));
  static const VerificationMeta _reminderFitnessMeta =
      const VerificationMeta('reminderFitness');
  @override
  late final GeneratedColumn<String> reminderFitness = GeneratedColumn<String>(
      'reminder_fitness', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('12:30'));
  static const VerificationMeta _reminderEnglish1Meta =
      const VerificationMeta('reminderEnglish1');
  @override
  late final GeneratedColumn<String> reminderEnglish1 = GeneratedColumn<String>(
      'reminder_english1', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('14:30'));
  static const VerificationMeta _reminderRepairTheoryMeta =
      const VerificationMeta('reminderRepairTheory');
  @override
  late final GeneratedColumn<String> reminderRepairTheory =
      GeneratedColumn<String>('reminder_repair_theory', aliasedName, false,
          type: DriftSqlType.string,
          requiredDuringInsert: false,
          defaultValue: const Constant('15:45'));
  static const VerificationMeta _reminderEnglish2Meta =
      const VerificationMeta('reminderEnglish2');
  @override
  late final GeneratedColumn<String> reminderEnglish2 = GeneratedColumn<String>(
      'reminder_english2', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('18:15'));
  static const VerificationMeta _reminderRepairPracticalMeta =
      const VerificationMeta('reminderRepairPractical');
  @override
  late final GeneratedColumn<String> reminderRepairPractical =
      GeneratedColumn<String>('reminder_repair_practical', aliasedName, false,
          type: DriftSqlType.string,
          requiredDuringInsert: false,
          defaultValue: const Constant('19:30'));
  static const VerificationMeta _reminderAppearanceMeta =
      const VerificationMeta('reminderAppearance');
  @override
  late final GeneratedColumn<String> reminderAppearance =
      GeneratedColumn<String>('reminder_appearance', aliasedName, false,
          type: DriftSqlType.string,
          requiredDuringInsert: false,
          defaultValue: const Constant('20:30'));
  static const VerificationMeta _reminderSleepMeta =
      const VerificationMeta('reminderSleep');
  @override
  late final GeneratedColumn<String> reminderSleep = GeneratedColumn<String>(
      'reminder_sleep', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('03:30'));
  static const VerificationMeta _themeModeMeta =
      const VerificationMeta('themeMode');
  @override
  late final GeneratedColumn<String> themeMode = GeneratedColumn<String>(
      'theme_mode', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('dark'));
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        notificationsEnabled,
        notificationPermissionGranted,
        reminderWake,
        reminderFitness,
        reminderEnglish1,
        reminderRepairTheory,
        reminderEnglish2,
        reminderRepairPractical,
        reminderAppearance,
        reminderSleep,
        themeMode,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_settings';
  @override
  VerificationContext validateIntegrity(Insertable<AppSetting> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('notifications_enabled')) {
      context.handle(
          _notificationsEnabledMeta,
          notificationsEnabled.isAcceptableOrUnknown(
              data['notifications_enabled']!, _notificationsEnabledMeta));
    }
    if (data.containsKey('notification_permission_granted')) {
      context.handle(
          _notificationPermissionGrantedMeta,
          notificationPermissionGranted.isAcceptableOrUnknown(
              data['notification_permission_granted']!,
              _notificationPermissionGrantedMeta));
    }
    if (data.containsKey('reminder_wake')) {
      context.handle(
          _reminderWakeMeta,
          reminderWake.isAcceptableOrUnknown(
              data['reminder_wake']!, _reminderWakeMeta));
    }
    if (data.containsKey('reminder_fitness')) {
      context.handle(
          _reminderFitnessMeta,
          reminderFitness.isAcceptableOrUnknown(
              data['reminder_fitness']!, _reminderFitnessMeta));
    }
    if (data.containsKey('reminder_english1')) {
      context.handle(
          _reminderEnglish1Meta,
          reminderEnglish1.isAcceptableOrUnknown(
              data['reminder_english1']!, _reminderEnglish1Meta));
    }
    if (data.containsKey('reminder_repair_theory')) {
      context.handle(
          _reminderRepairTheoryMeta,
          reminderRepairTheory.isAcceptableOrUnknown(
              data['reminder_repair_theory']!, _reminderRepairTheoryMeta));
    }
    if (data.containsKey('reminder_english2')) {
      context.handle(
          _reminderEnglish2Meta,
          reminderEnglish2.isAcceptableOrUnknown(
              data['reminder_english2']!, _reminderEnglish2Meta));
    }
    if (data.containsKey('reminder_repair_practical')) {
      context.handle(
          _reminderRepairPracticalMeta,
          reminderRepairPractical.isAcceptableOrUnknown(
              data['reminder_repair_practical']!,
              _reminderRepairPracticalMeta));
    }
    if (data.containsKey('reminder_appearance')) {
      context.handle(
          _reminderAppearanceMeta,
          reminderAppearance.isAcceptableOrUnknown(
              data['reminder_appearance']!, _reminderAppearanceMeta));
    }
    if (data.containsKey('reminder_sleep')) {
      context.handle(
          _reminderSleepMeta,
          reminderSleep.isAcceptableOrUnknown(
              data['reminder_sleep']!, _reminderSleepMeta));
    }
    if (data.containsKey('theme_mode')) {
      context.handle(_themeModeMeta,
          themeMode.isAcceptableOrUnknown(data['theme_mode']!, _themeModeMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AppSetting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppSetting(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      notificationsEnabled: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}notifications_enabled'])!,
      notificationPermissionGranted: attachedDatabase.typeMapping.read(
          DriftSqlType.bool,
          data['${effectivePrefix}notification_permission_granted'])!,
      reminderWake: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}reminder_wake'])!,
      reminderFitness: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}reminder_fitness'])!,
      reminderEnglish1: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}reminder_english1'])!,
      reminderRepairTheory: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}reminder_repair_theory'])!,
      reminderEnglish2: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}reminder_english2'])!,
      reminderRepairPractical: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}reminder_repair_practical'])!,
      reminderAppearance: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}reminder_appearance'])!,
      reminderSleep: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}reminder_sleep'])!,
      themeMode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}theme_mode'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $AppSettingsTable createAlias(String alias) {
    return $AppSettingsTable(attachedDatabase, alias);
  }
}

class AppSetting extends DataClass implements Insertable<AppSetting> {
  final int id;
  final bool notificationsEnabled;
  final bool notificationPermissionGranted;
  final String reminderWake;
  final String reminderFitness;
  final String reminderEnglish1;
  final String reminderRepairTheory;
  final String reminderEnglish2;
  final String reminderRepairPractical;
  final String reminderAppearance;
  final String reminderSleep;
  final String themeMode;
  final DateTime updatedAt;
  const AppSetting(
      {required this.id,
      required this.notificationsEnabled,
      required this.notificationPermissionGranted,
      required this.reminderWake,
      required this.reminderFitness,
      required this.reminderEnglish1,
      required this.reminderRepairTheory,
      required this.reminderEnglish2,
      required this.reminderRepairPractical,
      required this.reminderAppearance,
      required this.reminderSleep,
      required this.themeMode,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['notifications_enabled'] = Variable<bool>(notificationsEnabled);
    map['notification_permission_granted'] =
        Variable<bool>(notificationPermissionGranted);
    map['reminder_wake'] = Variable<String>(reminderWake);
    map['reminder_fitness'] = Variable<String>(reminderFitness);
    map['reminder_english1'] = Variable<String>(reminderEnglish1);
    map['reminder_repair_theory'] = Variable<String>(reminderRepairTheory);
    map['reminder_english2'] = Variable<String>(reminderEnglish2);
    map['reminder_repair_practical'] =
        Variable<String>(reminderRepairPractical);
    map['reminder_appearance'] = Variable<String>(reminderAppearance);
    map['reminder_sleep'] = Variable<String>(reminderSleep);
    map['theme_mode'] = Variable<String>(themeMode);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  AppSettingsCompanion toCompanion(bool nullToAbsent) {
    return AppSettingsCompanion(
      id: Value(id),
      notificationsEnabled: Value(notificationsEnabled),
      notificationPermissionGranted: Value(notificationPermissionGranted),
      reminderWake: Value(reminderWake),
      reminderFitness: Value(reminderFitness),
      reminderEnglish1: Value(reminderEnglish1),
      reminderRepairTheory: Value(reminderRepairTheory),
      reminderEnglish2: Value(reminderEnglish2),
      reminderRepairPractical: Value(reminderRepairPractical),
      reminderAppearance: Value(reminderAppearance),
      reminderSleep: Value(reminderSleep),
      themeMode: Value(themeMode),
      updatedAt: Value(updatedAt),
    );
  }

  factory AppSetting.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppSetting(
      id: serializer.fromJson<int>(json['id']),
      notificationsEnabled:
          serializer.fromJson<bool>(json['notificationsEnabled']),
      notificationPermissionGranted:
          serializer.fromJson<bool>(json['notificationPermissionGranted']),
      reminderWake: serializer.fromJson<String>(json['reminderWake']),
      reminderFitness: serializer.fromJson<String>(json['reminderFitness']),
      reminderEnglish1: serializer.fromJson<String>(json['reminderEnglish1']),
      reminderRepairTheory:
          serializer.fromJson<String>(json['reminderRepairTheory']),
      reminderEnglish2: serializer.fromJson<String>(json['reminderEnglish2']),
      reminderRepairPractical:
          serializer.fromJson<String>(json['reminderRepairPractical']),
      reminderAppearance:
          serializer.fromJson<String>(json['reminderAppearance']),
      reminderSleep: serializer.fromJson<String>(json['reminderSleep']),
      themeMode: serializer.fromJson<String>(json['themeMode']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'notificationsEnabled': serializer.toJson<bool>(notificationsEnabled),
      'notificationPermissionGranted':
          serializer.toJson<bool>(notificationPermissionGranted),
      'reminderWake': serializer.toJson<String>(reminderWake),
      'reminderFitness': serializer.toJson<String>(reminderFitness),
      'reminderEnglish1': serializer.toJson<String>(reminderEnglish1),
      'reminderRepairTheory': serializer.toJson<String>(reminderRepairTheory),
      'reminderEnglish2': serializer.toJson<String>(reminderEnglish2),
      'reminderRepairPractical':
          serializer.toJson<String>(reminderRepairPractical),
      'reminderAppearance': serializer.toJson<String>(reminderAppearance),
      'reminderSleep': serializer.toJson<String>(reminderSleep),
      'themeMode': serializer.toJson<String>(themeMode),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  AppSetting copyWith(
          {int? id,
          bool? notificationsEnabled,
          bool? notificationPermissionGranted,
          String? reminderWake,
          String? reminderFitness,
          String? reminderEnglish1,
          String? reminderRepairTheory,
          String? reminderEnglish2,
          String? reminderRepairPractical,
          String? reminderAppearance,
          String? reminderSleep,
          String? themeMode,
          DateTime? updatedAt}) =>
      AppSetting(
        id: id ?? this.id,
        notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
        notificationPermissionGranted:
            notificationPermissionGranted ?? this.notificationPermissionGranted,
        reminderWake: reminderWake ?? this.reminderWake,
        reminderFitness: reminderFitness ?? this.reminderFitness,
        reminderEnglish1: reminderEnglish1 ?? this.reminderEnglish1,
        reminderRepairTheory: reminderRepairTheory ?? this.reminderRepairTheory,
        reminderEnglish2: reminderEnglish2 ?? this.reminderEnglish2,
        reminderRepairPractical:
            reminderRepairPractical ?? this.reminderRepairPractical,
        reminderAppearance: reminderAppearance ?? this.reminderAppearance,
        reminderSleep: reminderSleep ?? this.reminderSleep,
        themeMode: themeMode ?? this.themeMode,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  AppSetting copyWithCompanion(AppSettingsCompanion data) {
    return AppSetting(
      id: data.id.present ? data.id.value : this.id,
      notificationsEnabled: data.notificationsEnabled.present
          ? data.notificationsEnabled.value
          : this.notificationsEnabled,
      notificationPermissionGranted: data.notificationPermissionGranted.present
          ? data.notificationPermissionGranted.value
          : this.notificationPermissionGranted,
      reminderWake: data.reminderWake.present
          ? data.reminderWake.value
          : this.reminderWake,
      reminderFitness: data.reminderFitness.present
          ? data.reminderFitness.value
          : this.reminderFitness,
      reminderEnglish1: data.reminderEnglish1.present
          ? data.reminderEnglish1.value
          : this.reminderEnglish1,
      reminderRepairTheory: data.reminderRepairTheory.present
          ? data.reminderRepairTheory.value
          : this.reminderRepairTheory,
      reminderEnglish2: data.reminderEnglish2.present
          ? data.reminderEnglish2.value
          : this.reminderEnglish2,
      reminderRepairPractical: data.reminderRepairPractical.present
          ? data.reminderRepairPractical.value
          : this.reminderRepairPractical,
      reminderAppearance: data.reminderAppearance.present
          ? data.reminderAppearance.value
          : this.reminderAppearance,
      reminderSleep: data.reminderSleep.present
          ? data.reminderSleep.value
          : this.reminderSleep,
      themeMode: data.themeMode.present ? data.themeMode.value : this.themeMode,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppSetting(')
          ..write('id: $id, ')
          ..write('notificationsEnabled: $notificationsEnabled, ')
          ..write(
              'notificationPermissionGranted: $notificationPermissionGranted, ')
          ..write('reminderWake: $reminderWake, ')
          ..write('reminderFitness: $reminderFitness, ')
          ..write('reminderEnglish1: $reminderEnglish1, ')
          ..write('reminderRepairTheory: $reminderRepairTheory, ')
          ..write('reminderEnglish2: $reminderEnglish2, ')
          ..write('reminderRepairPractical: $reminderRepairPractical, ')
          ..write('reminderAppearance: $reminderAppearance, ')
          ..write('reminderSleep: $reminderSleep, ')
          ..write('themeMode: $themeMode, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      notificationsEnabled,
      notificationPermissionGranted,
      reminderWake,
      reminderFitness,
      reminderEnglish1,
      reminderRepairTheory,
      reminderEnglish2,
      reminderRepairPractical,
      reminderAppearance,
      reminderSleep,
      themeMode,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppSetting &&
          other.id == this.id &&
          other.notificationsEnabled == this.notificationsEnabled &&
          other.notificationPermissionGranted ==
              this.notificationPermissionGranted &&
          other.reminderWake == this.reminderWake &&
          other.reminderFitness == this.reminderFitness &&
          other.reminderEnglish1 == this.reminderEnglish1 &&
          other.reminderRepairTheory == this.reminderRepairTheory &&
          other.reminderEnglish2 == this.reminderEnglish2 &&
          other.reminderRepairPractical == this.reminderRepairPractical &&
          other.reminderAppearance == this.reminderAppearance &&
          other.reminderSleep == this.reminderSleep &&
          other.themeMode == this.themeMode &&
          other.updatedAt == this.updatedAt);
}

class AppSettingsCompanion extends UpdateCompanion<AppSetting> {
  final Value<int> id;
  final Value<bool> notificationsEnabled;
  final Value<bool> notificationPermissionGranted;
  final Value<String> reminderWake;
  final Value<String> reminderFitness;
  final Value<String> reminderEnglish1;
  final Value<String> reminderRepairTheory;
  final Value<String> reminderEnglish2;
  final Value<String> reminderRepairPractical;
  final Value<String> reminderAppearance;
  final Value<String> reminderSleep;
  final Value<String> themeMode;
  final Value<DateTime> updatedAt;
  const AppSettingsCompanion({
    this.id = const Value.absent(),
    this.notificationsEnabled = const Value.absent(),
    this.notificationPermissionGranted = const Value.absent(),
    this.reminderWake = const Value.absent(),
    this.reminderFitness = const Value.absent(),
    this.reminderEnglish1 = const Value.absent(),
    this.reminderRepairTheory = const Value.absent(),
    this.reminderEnglish2 = const Value.absent(),
    this.reminderRepairPractical = const Value.absent(),
    this.reminderAppearance = const Value.absent(),
    this.reminderSleep = const Value.absent(),
    this.themeMode = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  AppSettingsCompanion.insert({
    this.id = const Value.absent(),
    this.notificationsEnabled = const Value.absent(),
    this.notificationPermissionGranted = const Value.absent(),
    this.reminderWake = const Value.absent(),
    this.reminderFitness = const Value.absent(),
    this.reminderEnglish1 = const Value.absent(),
    this.reminderRepairTheory = const Value.absent(),
    this.reminderEnglish2 = const Value.absent(),
    this.reminderRepairPractical = const Value.absent(),
    this.reminderAppearance = const Value.absent(),
    this.reminderSleep = const Value.absent(),
    this.themeMode = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  static Insertable<AppSetting> custom({
    Expression<int>? id,
    Expression<bool>? notificationsEnabled,
    Expression<bool>? notificationPermissionGranted,
    Expression<String>? reminderWake,
    Expression<String>? reminderFitness,
    Expression<String>? reminderEnglish1,
    Expression<String>? reminderRepairTheory,
    Expression<String>? reminderEnglish2,
    Expression<String>? reminderRepairPractical,
    Expression<String>? reminderAppearance,
    Expression<String>? reminderSleep,
    Expression<String>? themeMode,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (notificationsEnabled != null)
        'notifications_enabled': notificationsEnabled,
      if (notificationPermissionGranted != null)
        'notification_permission_granted': notificationPermissionGranted,
      if (reminderWake != null) 'reminder_wake': reminderWake,
      if (reminderFitness != null) 'reminder_fitness': reminderFitness,
      if (reminderEnglish1 != null) 'reminder_english1': reminderEnglish1,
      if (reminderRepairTheory != null)
        'reminder_repair_theory': reminderRepairTheory,
      if (reminderEnglish2 != null) 'reminder_english2': reminderEnglish2,
      if (reminderRepairPractical != null)
        'reminder_repair_practical': reminderRepairPractical,
      if (reminderAppearance != null) 'reminder_appearance': reminderAppearance,
      if (reminderSleep != null) 'reminder_sleep': reminderSleep,
      if (themeMode != null) 'theme_mode': themeMode,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  AppSettingsCompanion copyWith(
      {Value<int>? id,
      Value<bool>? notificationsEnabled,
      Value<bool>? notificationPermissionGranted,
      Value<String>? reminderWake,
      Value<String>? reminderFitness,
      Value<String>? reminderEnglish1,
      Value<String>? reminderRepairTheory,
      Value<String>? reminderEnglish2,
      Value<String>? reminderRepairPractical,
      Value<String>? reminderAppearance,
      Value<String>? reminderSleep,
      Value<String>? themeMode,
      Value<DateTime>? updatedAt}) {
    return AppSettingsCompanion(
      id: id ?? this.id,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      notificationPermissionGranted:
          notificationPermissionGranted ?? this.notificationPermissionGranted,
      reminderWake: reminderWake ?? this.reminderWake,
      reminderFitness: reminderFitness ?? this.reminderFitness,
      reminderEnglish1: reminderEnglish1 ?? this.reminderEnglish1,
      reminderRepairTheory: reminderRepairTheory ?? this.reminderRepairTheory,
      reminderEnglish2: reminderEnglish2 ?? this.reminderEnglish2,
      reminderRepairPractical:
          reminderRepairPractical ?? this.reminderRepairPractical,
      reminderAppearance: reminderAppearance ?? this.reminderAppearance,
      reminderSleep: reminderSleep ?? this.reminderSleep,
      themeMode: themeMode ?? this.themeMode,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (notificationsEnabled.present) {
      map['notifications_enabled'] = Variable<bool>(notificationsEnabled.value);
    }
    if (notificationPermissionGranted.present) {
      map['notification_permission_granted'] =
          Variable<bool>(notificationPermissionGranted.value);
    }
    if (reminderWake.present) {
      map['reminder_wake'] = Variable<String>(reminderWake.value);
    }
    if (reminderFitness.present) {
      map['reminder_fitness'] = Variable<String>(reminderFitness.value);
    }
    if (reminderEnglish1.present) {
      map['reminder_english1'] = Variable<String>(reminderEnglish1.value);
    }
    if (reminderRepairTheory.present) {
      map['reminder_repair_theory'] =
          Variable<String>(reminderRepairTheory.value);
    }
    if (reminderEnglish2.present) {
      map['reminder_english2'] = Variable<String>(reminderEnglish2.value);
    }
    if (reminderRepairPractical.present) {
      map['reminder_repair_practical'] =
          Variable<String>(reminderRepairPractical.value);
    }
    if (reminderAppearance.present) {
      map['reminder_appearance'] = Variable<String>(reminderAppearance.value);
    }
    if (reminderSleep.present) {
      map['reminder_sleep'] = Variable<String>(reminderSleep.value);
    }
    if (themeMode.present) {
      map['theme_mode'] = Variable<String>(themeMode.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppSettingsCompanion(')
          ..write('id: $id, ')
          ..write('notificationsEnabled: $notificationsEnabled, ')
          ..write(
              'notificationPermissionGranted: $notificationPermissionGranted, ')
          ..write('reminderWake: $reminderWake, ')
          ..write('reminderFitness: $reminderFitness, ')
          ..write('reminderEnglish1: $reminderEnglish1, ')
          ..write('reminderRepairTheory: $reminderRepairTheory, ')
          ..write('reminderEnglish2: $reminderEnglish2, ')
          ..write('reminderRepairPractical: $reminderRepairPractical, ')
          ..write('reminderAppearance: $reminderAppearance, ')
          ..write('reminderSleep: $reminderSleep, ')
          ..write('themeMode: $themeMode, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $GoalsTable extends Goals with TableInfo<$GoalsTable, Goal> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GoalsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _sortOrderMeta =
      const VerificationMeta('sortOrder');
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
      'sort_order', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _progressMeta =
      const VerificationMeta('progress');
  @override
  late final GeneratedColumn<double> progress = GeneratedColumn<double>(
      'progress', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  @override
  List<GeneratedColumn> get $columns =>
      [id, title, description, sortOrder, progress];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'goals';
  @override
  VerificationContext validateIntegrity(Insertable<Goal> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('sort_order')) {
      context.handle(_sortOrderMeta,
          sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta));
    } else if (isInserting) {
      context.missing(_sortOrderMeta);
    }
    if (data.containsKey('progress')) {
      context.handle(_progressMeta,
          progress.isAcceptableOrUnknown(data['progress']!, _progressMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Goal map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Goal(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
      sortOrder: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sort_order'])!,
      progress: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}progress'])!,
    );
  }

  @override
  $GoalsTable createAlias(String alias) {
    return $GoalsTable(attachedDatabase, alias);
  }
}

class Goal extends DataClass implements Insertable<Goal> {
  final String id;
  final String title;
  final String description;
  final int sortOrder;
  final double progress;
  const Goal(
      {required this.id,
      required this.title,
      required this.description,
      required this.sortOrder,
      required this.progress});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    map['description'] = Variable<String>(description);
    map['sort_order'] = Variable<int>(sortOrder);
    map['progress'] = Variable<double>(progress);
    return map;
  }

  GoalsCompanion toCompanion(bool nullToAbsent) {
    return GoalsCompanion(
      id: Value(id),
      title: Value(title),
      description: Value(description),
      sortOrder: Value(sortOrder),
      progress: Value(progress),
    );
  }

  factory Goal.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Goal(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String>(json['description']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      progress: serializer.fromJson<double>(json['progress']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String>(description),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'progress': serializer.toJson<double>(progress),
    };
  }

  Goal copyWith(
          {String? id,
          String? title,
          String? description,
          int? sortOrder,
          double? progress}) =>
      Goal(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        sortOrder: sortOrder ?? this.sortOrder,
        progress: progress ?? this.progress,
      );
  Goal copyWithCompanion(GoalsCompanion data) {
    return Goal(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      description:
          data.description.present ? data.description.value : this.description,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      progress: data.progress.present ? data.progress.value : this.progress,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Goal(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('progress: $progress')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, description, sortOrder, progress);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Goal &&
          other.id == this.id &&
          other.title == this.title &&
          other.description == this.description &&
          other.sortOrder == this.sortOrder &&
          other.progress == this.progress);
}

class GoalsCompanion extends UpdateCompanion<Goal> {
  final Value<String> id;
  final Value<String> title;
  final Value<String> description;
  final Value<int> sortOrder;
  final Value<double> progress;
  final Value<int> rowid;
  const GoalsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.progress = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  GoalsCompanion.insert({
    required String id,
    required String title,
    required String description,
    required int sortOrder,
    this.progress = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        title = Value(title),
        description = Value(description),
        sortOrder = Value(sortOrder);
  static Insertable<Goal> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? description,
    Expression<int>? sortOrder,
    Expression<double>? progress,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (progress != null) 'progress': progress,
      if (rowid != null) 'rowid': rowid,
    });
  }

  GoalsCompanion copyWith(
      {Value<String>? id,
      Value<String>? title,
      Value<String>? description,
      Value<int>? sortOrder,
      Value<double>? progress,
      Value<int>? rowid}) {
    return GoalsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      sortOrder: sortOrder ?? this.sortOrder,
      progress: progress ?? this.progress,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (progress.present) {
      map['progress'] = Variable<double>(progress.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GoalsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('progress: $progress, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RoadmapMonthsTable extends RoadmapMonths
    with TableInfo<$RoadmapMonthsTable, RoadmapMonth> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RoadmapMonthsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _monthIndexMeta =
      const VerificationMeta('monthIndex');
  @override
  late final GeneratedColumn<int> monthIndex = GeneratedColumn<int>(
      'month_index', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _quarterMeta =
      const VerificationMeta('quarter');
  @override
  late final GeneratedColumn<int> quarter = GeneratedColumn<int>(
      'quarter', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _focusMeta = const VerificationMeta('focus');
  @override
  late final GeneratedColumn<String> focus = GeneratedColumn<String>(
      'focus', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _objectivesMeta =
      const VerificationMeta('objectives');
  @override
  late final GeneratedColumn<String> objectives = GeneratedColumn<String>(
      'objectives', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _startDateMeta =
      const VerificationMeta('startDate');
  @override
  late final GeneratedColumn<DateTime> startDate = GeneratedColumn<DateTime>(
      'start_date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _endDateMeta =
      const VerificationMeta('endDate');
  @override
  late final GeneratedColumn<DateTime> endDate = GeneratedColumn<DateTime>(
      'end_date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, monthIndex, quarter, title, focus, objectives, startDate, endDate];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'roadmap_months';
  @override
  VerificationContext validateIntegrity(Insertable<RoadmapMonth> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('month_index')) {
      context.handle(
          _monthIndexMeta,
          monthIndex.isAcceptableOrUnknown(
              data['month_index']!, _monthIndexMeta));
    } else if (isInserting) {
      context.missing(_monthIndexMeta);
    }
    if (data.containsKey('quarter')) {
      context.handle(_quarterMeta,
          quarter.isAcceptableOrUnknown(data['quarter']!, _quarterMeta));
    } else if (isInserting) {
      context.missing(_quarterMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('focus')) {
      context.handle(
          _focusMeta, focus.isAcceptableOrUnknown(data['focus']!, _focusMeta));
    } else if (isInserting) {
      context.missing(_focusMeta);
    }
    if (data.containsKey('objectives')) {
      context.handle(
          _objectivesMeta,
          objectives.isAcceptableOrUnknown(
              data['objectives']!, _objectivesMeta));
    } else if (isInserting) {
      context.missing(_objectivesMeta);
    }
    if (data.containsKey('start_date')) {
      context.handle(_startDateMeta,
          startDate.isAcceptableOrUnknown(data['start_date']!, _startDateMeta));
    } else if (isInserting) {
      context.missing(_startDateMeta);
    }
    if (data.containsKey('end_date')) {
      context.handle(_endDateMeta,
          endDate.isAcceptableOrUnknown(data['end_date']!, _endDateMeta));
    } else if (isInserting) {
      context.missing(_endDateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RoadmapMonth map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RoadmapMonth(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      monthIndex: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}month_index'])!,
      quarter: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}quarter'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      focus: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}focus'])!,
      objectives: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}objectives'])!,
      startDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}start_date'])!,
      endDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}end_date'])!,
    );
  }

  @override
  $RoadmapMonthsTable createAlias(String alias) {
    return $RoadmapMonthsTable(attachedDatabase, alias);
  }
}

class RoadmapMonth extends DataClass implements Insertable<RoadmapMonth> {
  final int id;
  final int monthIndex;
  final int quarter;
  final String title;
  final String focus;
  final String objectives;
  final DateTime startDate;
  final DateTime endDate;
  const RoadmapMonth(
      {required this.id,
      required this.monthIndex,
      required this.quarter,
      required this.title,
      required this.focus,
      required this.objectives,
      required this.startDate,
      required this.endDate});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['month_index'] = Variable<int>(monthIndex);
    map['quarter'] = Variable<int>(quarter);
    map['title'] = Variable<String>(title);
    map['focus'] = Variable<String>(focus);
    map['objectives'] = Variable<String>(objectives);
    map['start_date'] = Variable<DateTime>(startDate);
    map['end_date'] = Variable<DateTime>(endDate);
    return map;
  }

  RoadmapMonthsCompanion toCompanion(bool nullToAbsent) {
    return RoadmapMonthsCompanion(
      id: Value(id),
      monthIndex: Value(monthIndex),
      quarter: Value(quarter),
      title: Value(title),
      focus: Value(focus),
      objectives: Value(objectives),
      startDate: Value(startDate),
      endDate: Value(endDate),
    );
  }

  factory RoadmapMonth.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RoadmapMonth(
      id: serializer.fromJson<int>(json['id']),
      monthIndex: serializer.fromJson<int>(json['monthIndex']),
      quarter: serializer.fromJson<int>(json['quarter']),
      title: serializer.fromJson<String>(json['title']),
      focus: serializer.fromJson<String>(json['focus']),
      objectives: serializer.fromJson<String>(json['objectives']),
      startDate: serializer.fromJson<DateTime>(json['startDate']),
      endDate: serializer.fromJson<DateTime>(json['endDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'monthIndex': serializer.toJson<int>(monthIndex),
      'quarter': serializer.toJson<int>(quarter),
      'title': serializer.toJson<String>(title),
      'focus': serializer.toJson<String>(focus),
      'objectives': serializer.toJson<String>(objectives),
      'startDate': serializer.toJson<DateTime>(startDate),
      'endDate': serializer.toJson<DateTime>(endDate),
    };
  }

  RoadmapMonth copyWith(
          {int? id,
          int? monthIndex,
          int? quarter,
          String? title,
          String? focus,
          String? objectives,
          DateTime? startDate,
          DateTime? endDate}) =>
      RoadmapMonth(
        id: id ?? this.id,
        monthIndex: monthIndex ?? this.monthIndex,
        quarter: quarter ?? this.quarter,
        title: title ?? this.title,
        focus: focus ?? this.focus,
        objectives: objectives ?? this.objectives,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
      );
  RoadmapMonth copyWithCompanion(RoadmapMonthsCompanion data) {
    return RoadmapMonth(
      id: data.id.present ? data.id.value : this.id,
      monthIndex:
          data.monthIndex.present ? data.monthIndex.value : this.monthIndex,
      quarter: data.quarter.present ? data.quarter.value : this.quarter,
      title: data.title.present ? data.title.value : this.title,
      focus: data.focus.present ? data.focus.value : this.focus,
      objectives:
          data.objectives.present ? data.objectives.value : this.objectives,
      startDate: data.startDate.present ? data.startDate.value : this.startDate,
      endDate: data.endDate.present ? data.endDate.value : this.endDate,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RoadmapMonth(')
          ..write('id: $id, ')
          ..write('monthIndex: $monthIndex, ')
          ..write('quarter: $quarter, ')
          ..write('title: $title, ')
          ..write('focus: $focus, ')
          ..write('objectives: $objectives, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, monthIndex, quarter, title, focus, objectives, startDate, endDate);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RoadmapMonth &&
          other.id == this.id &&
          other.monthIndex == this.monthIndex &&
          other.quarter == this.quarter &&
          other.title == this.title &&
          other.focus == this.focus &&
          other.objectives == this.objectives &&
          other.startDate == this.startDate &&
          other.endDate == this.endDate);
}

class RoadmapMonthsCompanion extends UpdateCompanion<RoadmapMonth> {
  final Value<int> id;
  final Value<int> monthIndex;
  final Value<int> quarter;
  final Value<String> title;
  final Value<String> focus;
  final Value<String> objectives;
  final Value<DateTime> startDate;
  final Value<DateTime> endDate;
  const RoadmapMonthsCompanion({
    this.id = const Value.absent(),
    this.monthIndex = const Value.absent(),
    this.quarter = const Value.absent(),
    this.title = const Value.absent(),
    this.focus = const Value.absent(),
    this.objectives = const Value.absent(),
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
  });
  RoadmapMonthsCompanion.insert({
    this.id = const Value.absent(),
    required int monthIndex,
    required int quarter,
    required String title,
    required String focus,
    required String objectives,
    required DateTime startDate,
    required DateTime endDate,
  })  : monthIndex = Value(monthIndex),
        quarter = Value(quarter),
        title = Value(title),
        focus = Value(focus),
        objectives = Value(objectives),
        startDate = Value(startDate),
        endDate = Value(endDate);
  static Insertable<RoadmapMonth> custom({
    Expression<int>? id,
    Expression<int>? monthIndex,
    Expression<int>? quarter,
    Expression<String>? title,
    Expression<String>? focus,
    Expression<String>? objectives,
    Expression<DateTime>? startDate,
    Expression<DateTime>? endDate,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (monthIndex != null) 'month_index': monthIndex,
      if (quarter != null) 'quarter': quarter,
      if (title != null) 'title': title,
      if (focus != null) 'focus': focus,
      if (objectives != null) 'objectives': objectives,
      if (startDate != null) 'start_date': startDate,
      if (endDate != null) 'end_date': endDate,
    });
  }

  RoadmapMonthsCompanion copyWith(
      {Value<int>? id,
      Value<int>? monthIndex,
      Value<int>? quarter,
      Value<String>? title,
      Value<String>? focus,
      Value<String>? objectives,
      Value<DateTime>? startDate,
      Value<DateTime>? endDate}) {
    return RoadmapMonthsCompanion(
      id: id ?? this.id,
      monthIndex: monthIndex ?? this.monthIndex,
      quarter: quarter ?? this.quarter,
      title: title ?? this.title,
      focus: focus ?? this.focus,
      objectives: objectives ?? this.objectives,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (monthIndex.present) {
      map['month_index'] = Variable<int>(monthIndex.value);
    }
    if (quarter.present) {
      map['quarter'] = Variable<int>(quarter.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (focus.present) {
      map['focus'] = Variable<String>(focus.value);
    }
    if (objectives.present) {
      map['objectives'] = Variable<String>(objectives.value);
    }
    if (startDate.present) {
      map['start_date'] = Variable<DateTime>(startDate.value);
    }
    if (endDate.present) {
      map['end_date'] = Variable<DateTime>(endDate.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RoadmapMonthsCompanion(')
          ..write('id: $id, ')
          ..write('monthIndex: $monthIndex, ')
          ..write('quarter: $quarter, ')
          ..write('title: $title, ')
          ..write('focus: $focus, ')
          ..write('objectives: $objectives, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate')
          ..write(')'))
        .toString();
  }
}

class $ScheduleBlocksTable extends ScheduleBlocks
    with TableInfo<$ScheduleBlocksTable, ScheduleBlock> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ScheduleBlocksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<String> date = GeneratedColumn<String>(
      'date', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _startTimeMeta =
      const VerificationMeta('startTime');
  @override
  late final GeneratedColumn<String> startTime = GeneratedColumn<String>(
      'start_time', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _endTimeMeta =
      const VerificationMeta('endTime');
  @override
  late final GeneratedColumn<String> endTime = GeneratedColumn<String>(
      'end_time', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _goalIdMeta = const VerificationMeta('goalId');
  @override
  late final GeneratedColumn<String> goalId = GeneratedColumn<String>(
      'goal_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('pending'));
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _sortOrderMeta =
      const VerificationMeta('sortOrder');
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
      'sort_order', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        date,
        startTime,
        endTime,
        title,
        goalId,
        status,
        notes,
        sortOrder,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'schedule_blocks';
  @override
  VerificationContext validateIntegrity(Insertable<ScheduleBlock> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('start_time')) {
      context.handle(_startTimeMeta,
          startTime.isAcceptableOrUnknown(data['start_time']!, _startTimeMeta));
    } else if (isInserting) {
      context.missing(_startTimeMeta);
    }
    if (data.containsKey('end_time')) {
      context.handle(_endTimeMeta,
          endTime.isAcceptableOrUnknown(data['end_time']!, _endTimeMeta));
    } else if (isInserting) {
      context.missing(_endTimeMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('goal_id')) {
      context.handle(_goalIdMeta,
          goalId.isAcceptableOrUnknown(data['goal_id']!, _goalIdMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('sort_order')) {
      context.handle(_sortOrderMeta,
          sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ScheduleBlock map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ScheduleBlock(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}date'])!,
      startTime: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}start_time'])!,
      endTime: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}end_time'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      goalId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}goal_id']),
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      sortOrder: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sort_order'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $ScheduleBlocksTable createAlias(String alias) {
    return $ScheduleBlocksTable(attachedDatabase, alias);
  }
}

class ScheduleBlock extends DataClass implements Insertable<ScheduleBlock> {
  final int id;
  final String date;
  final String startTime;
  final String endTime;
  final String title;
  final String? goalId;
  final String status;
  final String? notes;
  final int sortOrder;
  final DateTime updatedAt;
  const ScheduleBlock(
      {required this.id,
      required this.date,
      required this.startTime,
      required this.endTime,
      required this.title,
      this.goalId,
      required this.status,
      this.notes,
      required this.sortOrder,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['date'] = Variable<String>(date);
    map['start_time'] = Variable<String>(startTime);
    map['end_time'] = Variable<String>(endTime);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || goalId != null) {
      map['goal_id'] = Variable<String>(goalId);
    }
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['sort_order'] = Variable<int>(sortOrder);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ScheduleBlocksCompanion toCompanion(bool nullToAbsent) {
    return ScheduleBlocksCompanion(
      id: Value(id),
      date: Value(date),
      startTime: Value(startTime),
      endTime: Value(endTime),
      title: Value(title),
      goalId:
          goalId == null && nullToAbsent ? const Value.absent() : Value(goalId),
      status: Value(status),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      sortOrder: Value(sortOrder),
      updatedAt: Value(updatedAt),
    );
  }

  factory ScheduleBlock.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ScheduleBlock(
      id: serializer.fromJson<int>(json['id']),
      date: serializer.fromJson<String>(json['date']),
      startTime: serializer.fromJson<String>(json['startTime']),
      endTime: serializer.fromJson<String>(json['endTime']),
      title: serializer.fromJson<String>(json['title']),
      goalId: serializer.fromJson<String?>(json['goalId']),
      status: serializer.fromJson<String>(json['status']),
      notes: serializer.fromJson<String?>(json['notes']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'date': serializer.toJson<String>(date),
      'startTime': serializer.toJson<String>(startTime),
      'endTime': serializer.toJson<String>(endTime),
      'title': serializer.toJson<String>(title),
      'goalId': serializer.toJson<String?>(goalId),
      'status': serializer.toJson<String>(status),
      'notes': serializer.toJson<String?>(notes),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  ScheduleBlock copyWith(
          {int? id,
          String? date,
          String? startTime,
          String? endTime,
          String? title,
          Value<String?> goalId = const Value.absent(),
          String? status,
          Value<String?> notes = const Value.absent(),
          int? sortOrder,
          DateTime? updatedAt}) =>
      ScheduleBlock(
        id: id ?? this.id,
        date: date ?? this.date,
        startTime: startTime ?? this.startTime,
        endTime: endTime ?? this.endTime,
        title: title ?? this.title,
        goalId: goalId.present ? goalId.value : this.goalId,
        status: status ?? this.status,
        notes: notes.present ? notes.value : this.notes,
        sortOrder: sortOrder ?? this.sortOrder,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  ScheduleBlock copyWithCompanion(ScheduleBlocksCompanion data) {
    return ScheduleBlock(
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
      startTime: data.startTime.present ? data.startTime.value : this.startTime,
      endTime: data.endTime.present ? data.endTime.value : this.endTime,
      title: data.title.present ? data.title.value : this.title,
      goalId: data.goalId.present ? data.goalId.value : this.goalId,
      status: data.status.present ? data.status.value : this.status,
      notes: data.notes.present ? data.notes.value : this.notes,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ScheduleBlock(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('title: $title, ')
          ..write('goalId: $goalId, ')
          ..write('status: $status, ')
          ..write('notes: $notes, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, date, startTime, endTime, title, goalId,
      status, notes, sortOrder, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ScheduleBlock &&
          other.id == this.id &&
          other.date == this.date &&
          other.startTime == this.startTime &&
          other.endTime == this.endTime &&
          other.title == this.title &&
          other.goalId == this.goalId &&
          other.status == this.status &&
          other.notes == this.notes &&
          other.sortOrder == this.sortOrder &&
          other.updatedAt == this.updatedAt);
}

class ScheduleBlocksCompanion extends UpdateCompanion<ScheduleBlock> {
  final Value<int> id;
  final Value<String> date;
  final Value<String> startTime;
  final Value<String> endTime;
  final Value<String> title;
  final Value<String?> goalId;
  final Value<String> status;
  final Value<String?> notes;
  final Value<int> sortOrder;
  final Value<DateTime> updatedAt;
  const ScheduleBlocksCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.startTime = const Value.absent(),
    this.endTime = const Value.absent(),
    this.title = const Value.absent(),
    this.goalId = const Value.absent(),
    this.status = const Value.absent(),
    this.notes = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  ScheduleBlocksCompanion.insert({
    this.id = const Value.absent(),
    required String date,
    required String startTime,
    required String endTime,
    required String title,
    this.goalId = const Value.absent(),
    this.status = const Value.absent(),
    this.notes = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.updatedAt = const Value.absent(),
  })  : date = Value(date),
        startTime = Value(startTime),
        endTime = Value(endTime),
        title = Value(title);
  static Insertable<ScheduleBlock> custom({
    Expression<int>? id,
    Expression<String>? date,
    Expression<String>? startTime,
    Expression<String>? endTime,
    Expression<String>? title,
    Expression<String>? goalId,
    Expression<String>? status,
    Expression<String>? notes,
    Expression<int>? sortOrder,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (startTime != null) 'start_time': startTime,
      if (endTime != null) 'end_time': endTime,
      if (title != null) 'title': title,
      if (goalId != null) 'goal_id': goalId,
      if (status != null) 'status': status,
      if (notes != null) 'notes': notes,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  ScheduleBlocksCompanion copyWith(
      {Value<int>? id,
      Value<String>? date,
      Value<String>? startTime,
      Value<String>? endTime,
      Value<String>? title,
      Value<String?>? goalId,
      Value<String>? status,
      Value<String?>? notes,
      Value<int>? sortOrder,
      Value<DateTime>? updatedAt}) {
    return ScheduleBlocksCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      title: title ?? this.title,
      goalId: goalId ?? this.goalId,
      status: status ?? this.status,
      notes: notes ?? this.notes,
      sortOrder: sortOrder ?? this.sortOrder,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    if (startTime.present) {
      map['start_time'] = Variable<String>(startTime.value);
    }
    if (endTime.present) {
      map['end_time'] = Variable<String>(endTime.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (goalId.present) {
      map['goal_id'] = Variable<String>(goalId.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ScheduleBlocksCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('title: $title, ')
          ..write('goalId: $goalId, ')
          ..write('status: $status, ')
          ..write('notes: $notes, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $ScheduleHistoryTable extends ScheduleHistory
    with TableInfo<$ScheduleHistoryTable, ScheduleHistoryData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ScheduleHistoryTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _blockIdMeta =
      const VerificationMeta('blockId');
  @override
  late final GeneratedColumn<int> blockId = GeneratedColumn<int>(
      'block_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _previousStatusMeta =
      const VerificationMeta('previousStatus');
  @override
  late final GeneratedColumn<String> previousStatus = GeneratedColumn<String>(
      'previous_status', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _newStatusMeta =
      const VerificationMeta('newStatus');
  @override
  late final GeneratedColumn<String> newStatus = GeneratedColumn<String>(
      'new_status', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _reasonMeta = const VerificationMeta('reason');
  @override
  late final GeneratedColumn<String> reason = GeneratedColumn<String>(
      'reason', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _changedAtMeta =
      const VerificationMeta('changedAt');
  @override
  late final GeneratedColumn<DateTime> changedAt = GeneratedColumn<DateTime>(
      'changed_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [id, blockId, previousStatus, newStatus, reason, changedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'schedule_history';
  @override
  VerificationContext validateIntegrity(
      Insertable<ScheduleHistoryData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('block_id')) {
      context.handle(_blockIdMeta,
          blockId.isAcceptableOrUnknown(data['block_id']!, _blockIdMeta));
    } else if (isInserting) {
      context.missing(_blockIdMeta);
    }
    if (data.containsKey('previous_status')) {
      context.handle(
          _previousStatusMeta,
          previousStatus.isAcceptableOrUnknown(
              data['previous_status']!, _previousStatusMeta));
    } else if (isInserting) {
      context.missing(_previousStatusMeta);
    }
    if (data.containsKey('new_status')) {
      context.handle(_newStatusMeta,
          newStatus.isAcceptableOrUnknown(data['new_status']!, _newStatusMeta));
    } else if (isInserting) {
      context.missing(_newStatusMeta);
    }
    if (data.containsKey('reason')) {
      context.handle(_reasonMeta,
          reason.isAcceptableOrUnknown(data['reason']!, _reasonMeta));
    }
    if (data.containsKey('changed_at')) {
      context.handle(_changedAtMeta,
          changedAt.isAcceptableOrUnknown(data['changed_at']!, _changedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ScheduleHistoryData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ScheduleHistoryData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      blockId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}block_id'])!,
      previousStatus: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}previous_status'])!,
      newStatus: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}new_status'])!,
      reason: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}reason']),
      changedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}changed_at'])!,
    );
  }

  @override
  $ScheduleHistoryTable createAlias(String alias) {
    return $ScheduleHistoryTable(attachedDatabase, alias);
  }
}

class ScheduleHistoryData extends DataClass
    implements Insertable<ScheduleHistoryData> {
  final int id;
  final int blockId;
  final String previousStatus;
  final String newStatus;
  final String? reason;
  final DateTime changedAt;
  const ScheduleHistoryData(
      {required this.id,
      required this.blockId,
      required this.previousStatus,
      required this.newStatus,
      this.reason,
      required this.changedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['block_id'] = Variable<int>(blockId);
    map['previous_status'] = Variable<String>(previousStatus);
    map['new_status'] = Variable<String>(newStatus);
    if (!nullToAbsent || reason != null) {
      map['reason'] = Variable<String>(reason);
    }
    map['changed_at'] = Variable<DateTime>(changedAt);
    return map;
  }

  ScheduleHistoryCompanion toCompanion(bool nullToAbsent) {
    return ScheduleHistoryCompanion(
      id: Value(id),
      blockId: Value(blockId),
      previousStatus: Value(previousStatus),
      newStatus: Value(newStatus),
      reason:
          reason == null && nullToAbsent ? const Value.absent() : Value(reason),
      changedAt: Value(changedAt),
    );
  }

  factory ScheduleHistoryData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ScheduleHistoryData(
      id: serializer.fromJson<int>(json['id']),
      blockId: serializer.fromJson<int>(json['blockId']),
      previousStatus: serializer.fromJson<String>(json['previousStatus']),
      newStatus: serializer.fromJson<String>(json['newStatus']),
      reason: serializer.fromJson<String?>(json['reason']),
      changedAt: serializer.fromJson<DateTime>(json['changedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'blockId': serializer.toJson<int>(blockId),
      'previousStatus': serializer.toJson<String>(previousStatus),
      'newStatus': serializer.toJson<String>(newStatus),
      'reason': serializer.toJson<String?>(reason),
      'changedAt': serializer.toJson<DateTime>(changedAt),
    };
  }

  ScheduleHistoryData copyWith(
          {int? id,
          int? blockId,
          String? previousStatus,
          String? newStatus,
          Value<String?> reason = const Value.absent(),
          DateTime? changedAt}) =>
      ScheduleHistoryData(
        id: id ?? this.id,
        blockId: blockId ?? this.blockId,
        previousStatus: previousStatus ?? this.previousStatus,
        newStatus: newStatus ?? this.newStatus,
        reason: reason.present ? reason.value : this.reason,
        changedAt: changedAt ?? this.changedAt,
      );
  ScheduleHistoryData copyWithCompanion(ScheduleHistoryCompanion data) {
    return ScheduleHistoryData(
      id: data.id.present ? data.id.value : this.id,
      blockId: data.blockId.present ? data.blockId.value : this.blockId,
      previousStatus: data.previousStatus.present
          ? data.previousStatus.value
          : this.previousStatus,
      newStatus: data.newStatus.present ? data.newStatus.value : this.newStatus,
      reason: data.reason.present ? data.reason.value : this.reason,
      changedAt: data.changedAt.present ? data.changedAt.value : this.changedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ScheduleHistoryData(')
          ..write('id: $id, ')
          ..write('blockId: $blockId, ')
          ..write('previousStatus: $previousStatus, ')
          ..write('newStatus: $newStatus, ')
          ..write('reason: $reason, ')
          ..write('changedAt: $changedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, blockId, previousStatus, newStatus, reason, changedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ScheduleHistoryData &&
          other.id == this.id &&
          other.blockId == this.blockId &&
          other.previousStatus == this.previousStatus &&
          other.newStatus == this.newStatus &&
          other.reason == this.reason &&
          other.changedAt == this.changedAt);
}

class ScheduleHistoryCompanion extends UpdateCompanion<ScheduleHistoryData> {
  final Value<int> id;
  final Value<int> blockId;
  final Value<String> previousStatus;
  final Value<String> newStatus;
  final Value<String?> reason;
  final Value<DateTime> changedAt;
  const ScheduleHistoryCompanion({
    this.id = const Value.absent(),
    this.blockId = const Value.absent(),
    this.previousStatus = const Value.absent(),
    this.newStatus = const Value.absent(),
    this.reason = const Value.absent(),
    this.changedAt = const Value.absent(),
  });
  ScheduleHistoryCompanion.insert({
    this.id = const Value.absent(),
    required int blockId,
    required String previousStatus,
    required String newStatus,
    this.reason = const Value.absent(),
    this.changedAt = const Value.absent(),
  })  : blockId = Value(blockId),
        previousStatus = Value(previousStatus),
        newStatus = Value(newStatus);
  static Insertable<ScheduleHistoryData> custom({
    Expression<int>? id,
    Expression<int>? blockId,
    Expression<String>? previousStatus,
    Expression<String>? newStatus,
    Expression<String>? reason,
    Expression<DateTime>? changedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (blockId != null) 'block_id': blockId,
      if (previousStatus != null) 'previous_status': previousStatus,
      if (newStatus != null) 'new_status': newStatus,
      if (reason != null) 'reason': reason,
      if (changedAt != null) 'changed_at': changedAt,
    });
  }

  ScheduleHistoryCompanion copyWith(
      {Value<int>? id,
      Value<int>? blockId,
      Value<String>? previousStatus,
      Value<String>? newStatus,
      Value<String?>? reason,
      Value<DateTime>? changedAt}) {
    return ScheduleHistoryCompanion(
      id: id ?? this.id,
      blockId: blockId ?? this.blockId,
      previousStatus: previousStatus ?? this.previousStatus,
      newStatus: newStatus ?? this.newStatus,
      reason: reason ?? this.reason,
      changedAt: changedAt ?? this.changedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (blockId.present) {
      map['block_id'] = Variable<int>(blockId.value);
    }
    if (previousStatus.present) {
      map['previous_status'] = Variable<String>(previousStatus.value);
    }
    if (newStatus.present) {
      map['new_status'] = Variable<String>(newStatus.value);
    }
    if (reason.present) {
      map['reason'] = Variable<String>(reason.value);
    }
    if (changedAt.present) {
      map['changed_at'] = Variable<DateTime>(changedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ScheduleHistoryCompanion(')
          ..write('id: $id, ')
          ..write('blockId: $blockId, ')
          ..write('previousStatus: $previousStatus, ')
          ..write('newStatus: $newStatus, ')
          ..write('reason: $reason, ')
          ..write('changedAt: $changedAt')
          ..write(')'))
        .toString();
  }
}

class $TasksTable extends Tasks with TableInfo<$TasksTable, Task> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TasksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<String> date = GeneratedColumn<String>(
      'date', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _goalIdMeta = const VerificationMeta('goalId');
  @override
  late final GeneratedColumn<String> goalId = GeneratedColumn<String>(
      'goal_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('pending'));
  static const VerificationMeta _isDayOneMeta =
      const VerificationMeta('isDayOne');
  @override
  late final GeneratedColumn<bool> isDayOne = GeneratedColumn<bool>(
      'is_day_one', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_day_one" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _sortOrderMeta =
      const VerificationMeta('sortOrder');
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
      'sort_order', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _completedAtMeta =
      const VerificationMeta('completedAt');
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
      'completed_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        date,
        goalId,
        title,
        description,
        status,
        isDayOne,
        sortOrder,
        completedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tasks';
  @override
  VerificationContext validateIntegrity(Insertable<Task> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('goal_id')) {
      context.handle(_goalIdMeta,
          goalId.isAcceptableOrUnknown(data['goal_id']!, _goalIdMeta));
    } else if (isInserting) {
      context.missing(_goalIdMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('is_day_one')) {
      context.handle(_isDayOneMeta,
          isDayOne.isAcceptableOrUnknown(data['is_day_one']!, _isDayOneMeta));
    }
    if (data.containsKey('sort_order')) {
      context.handle(_sortOrderMeta,
          sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta));
    }
    if (data.containsKey('completed_at')) {
      context.handle(
          _completedAtMeta,
          completedAt.isAcceptableOrUnknown(
              data['completed_at']!, _completedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Task map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Task(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}date'])!,
      goalId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}goal_id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      isDayOne: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_day_one'])!,
      sortOrder: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sort_order'])!,
      completedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}completed_at']),
    );
  }

  @override
  $TasksTable createAlias(String alias) {
    return $TasksTable(attachedDatabase, alias);
  }
}

class Task extends DataClass implements Insertable<Task> {
  final int id;
  final String date;
  final String goalId;
  final String title;
  final String? description;
  final String status;
  final bool isDayOne;
  final int sortOrder;
  final DateTime? completedAt;
  const Task(
      {required this.id,
      required this.date,
      required this.goalId,
      required this.title,
      this.description,
      required this.status,
      required this.isDayOne,
      required this.sortOrder,
      this.completedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['date'] = Variable<String>(date);
    map['goal_id'] = Variable<String>(goalId);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['status'] = Variable<String>(status);
    map['is_day_one'] = Variable<bool>(isDayOne);
    map['sort_order'] = Variable<int>(sortOrder);
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<DateTime>(completedAt);
    }
    return map;
  }

  TasksCompanion toCompanion(bool nullToAbsent) {
    return TasksCompanion(
      id: Value(id),
      date: Value(date),
      goalId: Value(goalId),
      title: Value(title),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      status: Value(status),
      isDayOne: Value(isDayOne),
      sortOrder: Value(sortOrder),
      completedAt: completedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(completedAt),
    );
  }

  factory Task.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Task(
      id: serializer.fromJson<int>(json['id']),
      date: serializer.fromJson<String>(json['date']),
      goalId: serializer.fromJson<String>(json['goalId']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String?>(json['description']),
      status: serializer.fromJson<String>(json['status']),
      isDayOne: serializer.fromJson<bool>(json['isDayOne']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      completedAt: serializer.fromJson<DateTime?>(json['completedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'date': serializer.toJson<String>(date),
      'goalId': serializer.toJson<String>(goalId),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String?>(description),
      'status': serializer.toJson<String>(status),
      'isDayOne': serializer.toJson<bool>(isDayOne),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'completedAt': serializer.toJson<DateTime?>(completedAt),
    };
  }

  Task copyWith(
          {int? id,
          String? date,
          String? goalId,
          String? title,
          Value<String?> description = const Value.absent(),
          String? status,
          bool? isDayOne,
          int? sortOrder,
          Value<DateTime?> completedAt = const Value.absent()}) =>
      Task(
        id: id ?? this.id,
        date: date ?? this.date,
        goalId: goalId ?? this.goalId,
        title: title ?? this.title,
        description: description.present ? description.value : this.description,
        status: status ?? this.status,
        isDayOne: isDayOne ?? this.isDayOne,
        sortOrder: sortOrder ?? this.sortOrder,
        completedAt: completedAt.present ? completedAt.value : this.completedAt,
      );
  Task copyWithCompanion(TasksCompanion data) {
    return Task(
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
      goalId: data.goalId.present ? data.goalId.value : this.goalId,
      title: data.title.present ? data.title.value : this.title,
      description:
          data.description.present ? data.description.value : this.description,
      status: data.status.present ? data.status.value : this.status,
      isDayOne: data.isDayOne.present ? data.isDayOne.value : this.isDayOne,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      completedAt:
          data.completedAt.present ? data.completedAt.value : this.completedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Task(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('goalId: $goalId, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('status: $status, ')
          ..write('isDayOne: $isDayOne, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('completedAt: $completedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, date, goalId, title, description, status,
      isDayOne, sortOrder, completedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Task &&
          other.id == this.id &&
          other.date == this.date &&
          other.goalId == this.goalId &&
          other.title == this.title &&
          other.description == this.description &&
          other.status == this.status &&
          other.isDayOne == this.isDayOne &&
          other.sortOrder == this.sortOrder &&
          other.completedAt == this.completedAt);
}

class TasksCompanion extends UpdateCompanion<Task> {
  final Value<int> id;
  final Value<String> date;
  final Value<String> goalId;
  final Value<String> title;
  final Value<String?> description;
  final Value<String> status;
  final Value<bool> isDayOne;
  final Value<int> sortOrder;
  final Value<DateTime?> completedAt;
  const TasksCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.goalId = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.status = const Value.absent(),
    this.isDayOne = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.completedAt = const Value.absent(),
  });
  TasksCompanion.insert({
    this.id = const Value.absent(),
    required String date,
    required String goalId,
    required String title,
    this.description = const Value.absent(),
    this.status = const Value.absent(),
    this.isDayOne = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.completedAt = const Value.absent(),
  })  : date = Value(date),
        goalId = Value(goalId),
        title = Value(title);
  static Insertable<Task> custom({
    Expression<int>? id,
    Expression<String>? date,
    Expression<String>? goalId,
    Expression<String>? title,
    Expression<String>? description,
    Expression<String>? status,
    Expression<bool>? isDayOne,
    Expression<int>? sortOrder,
    Expression<DateTime>? completedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (goalId != null) 'goal_id': goalId,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (status != null) 'status': status,
      if (isDayOne != null) 'is_day_one': isDayOne,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (completedAt != null) 'completed_at': completedAt,
    });
  }

  TasksCompanion copyWith(
      {Value<int>? id,
      Value<String>? date,
      Value<String>? goalId,
      Value<String>? title,
      Value<String?>? description,
      Value<String>? status,
      Value<bool>? isDayOne,
      Value<int>? sortOrder,
      Value<DateTime?>? completedAt}) {
    return TasksCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      goalId: goalId ?? this.goalId,
      title: title ?? this.title,
      description: description ?? this.description,
      status: status ?? this.status,
      isDayOne: isDayOne ?? this.isDayOne,
      sortOrder: sortOrder ?? this.sortOrder,
      completedAt: completedAt ?? this.completedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    if (goalId.present) {
      map['goal_id'] = Variable<String>(goalId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (isDayOne.present) {
      map['is_day_one'] = Variable<bool>(isDayOne.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TasksCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('goalId: $goalId, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('status: $status, ')
          ..write('isDayOne: $isDayOne, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('completedAt: $completedAt')
          ..write(')'))
        .toString();
  }
}

class $ExercisesTable extends Exercises
    with TableInfo<$ExercisesTable, Exercise> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExercisesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _categoryMeta =
      const VerificationMeta('category');
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
      'category', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _instructionsMeta =
      const VerificationMeta('instructions');
  @override
  late final GeneratedColumn<String> instructions = GeneratedColumn<String>(
      'instructions', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _defaultSetsMeta =
      const VerificationMeta('defaultSets');
  @override
  late final GeneratedColumn<int> defaultSets = GeneratedColumn<int>(
      'default_sets', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(3));
  static const VerificationMeta _defaultRepsMeta =
      const VerificationMeta('defaultReps');
  @override
  late final GeneratedColumn<String> defaultReps = GeneratedColumn<String>(
      'default_reps', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('10'));
  static const VerificationMeta _restSecondsMeta =
      const VerificationMeta('restSeconds');
  @override
  late final GeneratedColumn<int> restSeconds = GeneratedColumn<int>(
      'rest_seconds', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(60));
  static const VerificationMeta _beginnerSafeMeta =
      const VerificationMeta('beginnerSafe');
  @override
  late final GeneratedColumn<bool> beginnerSafe = GeneratedColumn<bool>(
      'beginner_safe', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("beginner_safe" IN (0, 1))'),
      defaultValue: const Constant(true));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        category,
        instructions,
        defaultSets,
        defaultReps,
        restSeconds,
        beginnerSafe
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'exercises';
  @override
  VerificationContext validateIntegrity(Insertable<Exercise> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('instructions')) {
      context.handle(
          _instructionsMeta,
          instructions.isAcceptableOrUnknown(
              data['instructions']!, _instructionsMeta));
    } else if (isInserting) {
      context.missing(_instructionsMeta);
    }
    if (data.containsKey('default_sets')) {
      context.handle(
          _defaultSetsMeta,
          defaultSets.isAcceptableOrUnknown(
              data['default_sets']!, _defaultSetsMeta));
    }
    if (data.containsKey('default_reps')) {
      context.handle(
          _defaultRepsMeta,
          defaultReps.isAcceptableOrUnknown(
              data['default_reps']!, _defaultRepsMeta));
    }
    if (data.containsKey('rest_seconds')) {
      context.handle(
          _restSecondsMeta,
          restSeconds.isAcceptableOrUnknown(
              data['rest_seconds']!, _restSecondsMeta));
    }
    if (data.containsKey('beginner_safe')) {
      context.handle(
          _beginnerSafeMeta,
          beginnerSafe.isAcceptableOrUnknown(
              data['beginner_safe']!, _beginnerSafeMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Exercise map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Exercise(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      category: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category'])!,
      instructions: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}instructions'])!,
      defaultSets: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}default_sets'])!,
      defaultReps: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}default_reps'])!,
      restSeconds: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}rest_seconds'])!,
      beginnerSafe: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}beginner_safe'])!,
    );
  }

  @override
  $ExercisesTable createAlias(String alias) {
    return $ExercisesTable(attachedDatabase, alias);
  }
}

class Exercise extends DataClass implements Insertable<Exercise> {
  final int id;
  final String name;
  final String category;
  final String instructions;
  final int defaultSets;
  final String defaultReps;
  final int restSeconds;
  final bool beginnerSafe;
  const Exercise(
      {required this.id,
      required this.name,
      required this.category,
      required this.instructions,
      required this.defaultSets,
      required this.defaultReps,
      required this.restSeconds,
      required this.beginnerSafe});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['category'] = Variable<String>(category);
    map['instructions'] = Variable<String>(instructions);
    map['default_sets'] = Variable<int>(defaultSets);
    map['default_reps'] = Variable<String>(defaultReps);
    map['rest_seconds'] = Variable<int>(restSeconds);
    map['beginner_safe'] = Variable<bool>(beginnerSafe);
    return map;
  }

  ExercisesCompanion toCompanion(bool nullToAbsent) {
    return ExercisesCompanion(
      id: Value(id),
      name: Value(name),
      category: Value(category),
      instructions: Value(instructions),
      defaultSets: Value(defaultSets),
      defaultReps: Value(defaultReps),
      restSeconds: Value(restSeconds),
      beginnerSafe: Value(beginnerSafe),
    );
  }

  factory Exercise.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Exercise(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      category: serializer.fromJson<String>(json['category']),
      instructions: serializer.fromJson<String>(json['instructions']),
      defaultSets: serializer.fromJson<int>(json['defaultSets']),
      defaultReps: serializer.fromJson<String>(json['defaultReps']),
      restSeconds: serializer.fromJson<int>(json['restSeconds']),
      beginnerSafe: serializer.fromJson<bool>(json['beginnerSafe']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'category': serializer.toJson<String>(category),
      'instructions': serializer.toJson<String>(instructions),
      'defaultSets': serializer.toJson<int>(defaultSets),
      'defaultReps': serializer.toJson<String>(defaultReps),
      'restSeconds': serializer.toJson<int>(restSeconds),
      'beginnerSafe': serializer.toJson<bool>(beginnerSafe),
    };
  }

  Exercise copyWith(
          {int? id,
          String? name,
          String? category,
          String? instructions,
          int? defaultSets,
          String? defaultReps,
          int? restSeconds,
          bool? beginnerSafe}) =>
      Exercise(
        id: id ?? this.id,
        name: name ?? this.name,
        category: category ?? this.category,
        instructions: instructions ?? this.instructions,
        defaultSets: defaultSets ?? this.defaultSets,
        defaultReps: defaultReps ?? this.defaultReps,
        restSeconds: restSeconds ?? this.restSeconds,
        beginnerSafe: beginnerSafe ?? this.beginnerSafe,
      );
  Exercise copyWithCompanion(ExercisesCompanion data) {
    return Exercise(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      category: data.category.present ? data.category.value : this.category,
      instructions: data.instructions.present
          ? data.instructions.value
          : this.instructions,
      defaultSets:
          data.defaultSets.present ? data.defaultSets.value : this.defaultSets,
      defaultReps:
          data.defaultReps.present ? data.defaultReps.value : this.defaultReps,
      restSeconds:
          data.restSeconds.present ? data.restSeconds.value : this.restSeconds,
      beginnerSafe: data.beginnerSafe.present
          ? data.beginnerSafe.value
          : this.beginnerSafe,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Exercise(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('category: $category, ')
          ..write('instructions: $instructions, ')
          ..write('defaultSets: $defaultSets, ')
          ..write('defaultReps: $defaultReps, ')
          ..write('restSeconds: $restSeconds, ')
          ..write('beginnerSafe: $beginnerSafe')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, category, instructions, defaultSets,
      defaultReps, restSeconds, beginnerSafe);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Exercise &&
          other.id == this.id &&
          other.name == this.name &&
          other.category == this.category &&
          other.instructions == this.instructions &&
          other.defaultSets == this.defaultSets &&
          other.defaultReps == this.defaultReps &&
          other.restSeconds == this.restSeconds &&
          other.beginnerSafe == this.beginnerSafe);
}

class ExercisesCompanion extends UpdateCompanion<Exercise> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> category;
  final Value<String> instructions;
  final Value<int> defaultSets;
  final Value<String> defaultReps;
  final Value<int> restSeconds;
  final Value<bool> beginnerSafe;
  const ExercisesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.category = const Value.absent(),
    this.instructions = const Value.absent(),
    this.defaultSets = const Value.absent(),
    this.defaultReps = const Value.absent(),
    this.restSeconds = const Value.absent(),
    this.beginnerSafe = const Value.absent(),
  });
  ExercisesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String category,
    required String instructions,
    this.defaultSets = const Value.absent(),
    this.defaultReps = const Value.absent(),
    this.restSeconds = const Value.absent(),
    this.beginnerSafe = const Value.absent(),
  })  : name = Value(name),
        category = Value(category),
        instructions = Value(instructions);
  static Insertable<Exercise> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? category,
    Expression<String>? instructions,
    Expression<int>? defaultSets,
    Expression<String>? defaultReps,
    Expression<int>? restSeconds,
    Expression<bool>? beginnerSafe,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (category != null) 'category': category,
      if (instructions != null) 'instructions': instructions,
      if (defaultSets != null) 'default_sets': defaultSets,
      if (defaultReps != null) 'default_reps': defaultReps,
      if (restSeconds != null) 'rest_seconds': restSeconds,
      if (beginnerSafe != null) 'beginner_safe': beginnerSafe,
    });
  }

  ExercisesCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String>? category,
      Value<String>? instructions,
      Value<int>? defaultSets,
      Value<String>? defaultReps,
      Value<int>? restSeconds,
      Value<bool>? beginnerSafe}) {
    return ExercisesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      instructions: instructions ?? this.instructions,
      defaultSets: defaultSets ?? this.defaultSets,
      defaultReps: defaultReps ?? this.defaultReps,
      restSeconds: restSeconds ?? this.restSeconds,
      beginnerSafe: beginnerSafe ?? this.beginnerSafe,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (instructions.present) {
      map['instructions'] = Variable<String>(instructions.value);
    }
    if (defaultSets.present) {
      map['default_sets'] = Variable<int>(defaultSets.value);
    }
    if (defaultReps.present) {
      map['default_reps'] = Variable<String>(defaultReps.value);
    }
    if (restSeconds.present) {
      map['rest_seconds'] = Variable<int>(restSeconds.value);
    }
    if (beginnerSafe.present) {
      map['beginner_safe'] = Variable<bool>(beginnerSafe.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExercisesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('category: $category, ')
          ..write('instructions: $instructions, ')
          ..write('defaultSets: $defaultSets, ')
          ..write('defaultReps: $defaultReps, ')
          ..write('restSeconds: $restSeconds, ')
          ..write('beginnerSafe: $beginnerSafe')
          ..write(')'))
        .toString();
  }
}

class $WorkoutSessionsTable extends WorkoutSessions
    with TableInfo<$WorkoutSessionsTable, WorkoutSession> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WorkoutSessionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<String> date = GeneratedColumn<String>(
      'date', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _planNameMeta =
      const VerificationMeta('planName');
  @override
  late final GeneratedColumn<String> planName = GeneratedColumn<String>(
      'plan_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('pending'));
  static const VerificationMeta _durationMinutesMeta =
      const VerificationMeta('durationMinutes');
  @override
  late final GeneratedColumn<int> durationMinutes = GeneratedColumn<int>(
      'duration_minutes', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _completedAtMeta =
      const VerificationMeta('completedAt');
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
      'completed_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, date, planName, status, durationMinutes, notes, completedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'workout_sessions';
  @override
  VerificationContext validateIntegrity(Insertable<WorkoutSession> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('plan_name')) {
      context.handle(_planNameMeta,
          planName.isAcceptableOrUnknown(data['plan_name']!, _planNameMeta));
    } else if (isInserting) {
      context.missing(_planNameMeta);
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('duration_minutes')) {
      context.handle(
          _durationMinutesMeta,
          durationMinutes.isAcceptableOrUnknown(
              data['duration_minutes']!, _durationMinutesMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('completed_at')) {
      context.handle(
          _completedAtMeta,
          completedAt.isAcceptableOrUnknown(
              data['completed_at']!, _completedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WorkoutSession map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WorkoutSession(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}date'])!,
      planName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}plan_name'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      durationMinutes: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}duration_minutes']),
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      completedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}completed_at']),
    );
  }

  @override
  $WorkoutSessionsTable createAlias(String alias) {
    return $WorkoutSessionsTable(attachedDatabase, alias);
  }
}

class WorkoutSession extends DataClass implements Insertable<WorkoutSession> {
  final int id;
  final String date;
  final String planName;
  final String status;
  final int? durationMinutes;
  final String? notes;
  final DateTime? completedAt;
  const WorkoutSession(
      {required this.id,
      required this.date,
      required this.planName,
      required this.status,
      this.durationMinutes,
      this.notes,
      this.completedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['date'] = Variable<String>(date);
    map['plan_name'] = Variable<String>(planName);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || durationMinutes != null) {
      map['duration_minutes'] = Variable<int>(durationMinutes);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<DateTime>(completedAt);
    }
    return map;
  }

  WorkoutSessionsCompanion toCompanion(bool nullToAbsent) {
    return WorkoutSessionsCompanion(
      id: Value(id),
      date: Value(date),
      planName: Value(planName),
      status: Value(status),
      durationMinutes: durationMinutes == null && nullToAbsent
          ? const Value.absent()
          : Value(durationMinutes),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      completedAt: completedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(completedAt),
    );
  }

  factory WorkoutSession.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WorkoutSession(
      id: serializer.fromJson<int>(json['id']),
      date: serializer.fromJson<String>(json['date']),
      planName: serializer.fromJson<String>(json['planName']),
      status: serializer.fromJson<String>(json['status']),
      durationMinutes: serializer.fromJson<int?>(json['durationMinutes']),
      notes: serializer.fromJson<String?>(json['notes']),
      completedAt: serializer.fromJson<DateTime?>(json['completedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'date': serializer.toJson<String>(date),
      'planName': serializer.toJson<String>(planName),
      'status': serializer.toJson<String>(status),
      'durationMinutes': serializer.toJson<int?>(durationMinutes),
      'notes': serializer.toJson<String?>(notes),
      'completedAt': serializer.toJson<DateTime?>(completedAt),
    };
  }

  WorkoutSession copyWith(
          {int? id,
          String? date,
          String? planName,
          String? status,
          Value<int?> durationMinutes = const Value.absent(),
          Value<String?> notes = const Value.absent(),
          Value<DateTime?> completedAt = const Value.absent()}) =>
      WorkoutSession(
        id: id ?? this.id,
        date: date ?? this.date,
        planName: planName ?? this.planName,
        status: status ?? this.status,
        durationMinutes: durationMinutes.present
            ? durationMinutes.value
            : this.durationMinutes,
        notes: notes.present ? notes.value : this.notes,
        completedAt: completedAt.present ? completedAt.value : this.completedAt,
      );
  WorkoutSession copyWithCompanion(WorkoutSessionsCompanion data) {
    return WorkoutSession(
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
      planName: data.planName.present ? data.planName.value : this.planName,
      status: data.status.present ? data.status.value : this.status,
      durationMinutes: data.durationMinutes.present
          ? data.durationMinutes.value
          : this.durationMinutes,
      notes: data.notes.present ? data.notes.value : this.notes,
      completedAt:
          data.completedAt.present ? data.completedAt.value : this.completedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WorkoutSession(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('planName: $planName, ')
          ..write('status: $status, ')
          ..write('durationMinutes: $durationMinutes, ')
          ..write('notes: $notes, ')
          ..write('completedAt: $completedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, date, planName, status, durationMinutes, notes, completedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WorkoutSession &&
          other.id == this.id &&
          other.date == this.date &&
          other.planName == this.planName &&
          other.status == this.status &&
          other.durationMinutes == this.durationMinutes &&
          other.notes == this.notes &&
          other.completedAt == this.completedAt);
}

class WorkoutSessionsCompanion extends UpdateCompanion<WorkoutSession> {
  final Value<int> id;
  final Value<String> date;
  final Value<String> planName;
  final Value<String> status;
  final Value<int?> durationMinutes;
  final Value<String?> notes;
  final Value<DateTime?> completedAt;
  const WorkoutSessionsCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.planName = const Value.absent(),
    this.status = const Value.absent(),
    this.durationMinutes = const Value.absent(),
    this.notes = const Value.absent(),
    this.completedAt = const Value.absent(),
  });
  WorkoutSessionsCompanion.insert({
    this.id = const Value.absent(),
    required String date,
    required String planName,
    this.status = const Value.absent(),
    this.durationMinutes = const Value.absent(),
    this.notes = const Value.absent(),
    this.completedAt = const Value.absent(),
  })  : date = Value(date),
        planName = Value(planName);
  static Insertable<WorkoutSession> custom({
    Expression<int>? id,
    Expression<String>? date,
    Expression<String>? planName,
    Expression<String>? status,
    Expression<int>? durationMinutes,
    Expression<String>? notes,
    Expression<DateTime>? completedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (planName != null) 'plan_name': planName,
      if (status != null) 'status': status,
      if (durationMinutes != null) 'duration_minutes': durationMinutes,
      if (notes != null) 'notes': notes,
      if (completedAt != null) 'completed_at': completedAt,
    });
  }

  WorkoutSessionsCompanion copyWith(
      {Value<int>? id,
      Value<String>? date,
      Value<String>? planName,
      Value<String>? status,
      Value<int?>? durationMinutes,
      Value<String?>? notes,
      Value<DateTime?>? completedAt}) {
    return WorkoutSessionsCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      planName: planName ?? this.planName,
      status: status ?? this.status,
      durationMinutes: durationMinutes ?? this.durationMinutes,
      notes: notes ?? this.notes,
      completedAt: completedAt ?? this.completedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    if (planName.present) {
      map['plan_name'] = Variable<String>(planName.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (durationMinutes.present) {
      map['duration_minutes'] = Variable<int>(durationMinutes.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WorkoutSessionsCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('planName: $planName, ')
          ..write('status: $status, ')
          ..write('durationMinutes: $durationMinutes, ')
          ..write('notes: $notes, ')
          ..write('completedAt: $completedAt')
          ..write(')'))
        .toString();
  }
}

class $WorkoutSetsTable extends WorkoutSets
    with TableInfo<$WorkoutSetsTable, WorkoutSet> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WorkoutSetsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _sessionIdMeta =
      const VerificationMeta('sessionId');
  @override
  late final GeneratedColumn<int> sessionId = GeneratedColumn<int>(
      'session_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _exerciseIdMeta =
      const VerificationMeta('exerciseId');
  @override
  late final GeneratedColumn<int> exerciseId = GeneratedColumn<int>(
      'exercise_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _setNumberMeta =
      const VerificationMeta('setNumber');
  @override
  late final GeneratedColumn<int> setNumber = GeneratedColumn<int>(
      'set_number', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _targetRepsMeta =
      const VerificationMeta('targetReps');
  @override
  late final GeneratedColumn<String> targetReps = GeneratedColumn<String>(
      'target_reps', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _actualRepsMeta =
      const VerificationMeta('actualReps');
  @override
  late final GeneratedColumn<String> actualReps = GeneratedColumn<String>(
      'actual_reps', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _weightKgMeta =
      const VerificationMeta('weightKg');
  @override
  late final GeneratedColumn<double> weightKg = GeneratedColumn<double>(
      'weight_kg', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _completedMeta =
      const VerificationMeta('completed');
  @override
  late final GeneratedColumn<bool> completed = GeneratedColumn<bool>(
      'completed', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("completed" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _isPrMeta = const VerificationMeta('isPr');
  @override
  late final GeneratedColumn<bool> isPr = GeneratedColumn<bool>(
      'is_pr', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_pr" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        sessionId,
        exerciseId,
        setNumber,
        targetReps,
        actualReps,
        weightKg,
        completed,
        isPr
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'workout_sets';
  @override
  VerificationContext validateIntegrity(Insertable<WorkoutSet> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('session_id')) {
      context.handle(_sessionIdMeta,
          sessionId.isAcceptableOrUnknown(data['session_id']!, _sessionIdMeta));
    } else if (isInserting) {
      context.missing(_sessionIdMeta);
    }
    if (data.containsKey('exercise_id')) {
      context.handle(
          _exerciseIdMeta,
          exerciseId.isAcceptableOrUnknown(
              data['exercise_id']!, _exerciseIdMeta));
    } else if (isInserting) {
      context.missing(_exerciseIdMeta);
    }
    if (data.containsKey('set_number')) {
      context.handle(_setNumberMeta,
          setNumber.isAcceptableOrUnknown(data['set_number']!, _setNumberMeta));
    } else if (isInserting) {
      context.missing(_setNumberMeta);
    }
    if (data.containsKey('target_reps')) {
      context.handle(
          _targetRepsMeta,
          targetReps.isAcceptableOrUnknown(
              data['target_reps']!, _targetRepsMeta));
    } else if (isInserting) {
      context.missing(_targetRepsMeta);
    }
    if (data.containsKey('actual_reps')) {
      context.handle(
          _actualRepsMeta,
          actualReps.isAcceptableOrUnknown(
              data['actual_reps']!, _actualRepsMeta));
    }
    if (data.containsKey('weight_kg')) {
      context.handle(_weightKgMeta,
          weightKg.isAcceptableOrUnknown(data['weight_kg']!, _weightKgMeta));
    }
    if (data.containsKey('completed')) {
      context.handle(_completedMeta,
          completed.isAcceptableOrUnknown(data['completed']!, _completedMeta));
    }
    if (data.containsKey('is_pr')) {
      context.handle(
          _isPrMeta, isPr.isAcceptableOrUnknown(data['is_pr']!, _isPrMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WorkoutSet map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WorkoutSet(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      sessionId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}session_id'])!,
      exerciseId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}exercise_id'])!,
      setNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}set_number'])!,
      targetReps: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}target_reps'])!,
      actualReps: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}actual_reps']),
      weightKg: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}weight_kg']),
      completed: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}completed'])!,
      isPr: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_pr'])!,
    );
  }

  @override
  $WorkoutSetsTable createAlias(String alias) {
    return $WorkoutSetsTable(attachedDatabase, alias);
  }
}

class WorkoutSet extends DataClass implements Insertable<WorkoutSet> {
  final int id;
  final int sessionId;
  final int exerciseId;
  final int setNumber;
  final String targetReps;
  final String? actualReps;
  final double? weightKg;
  final bool completed;
  final bool isPr;
  const WorkoutSet(
      {required this.id,
      required this.sessionId,
      required this.exerciseId,
      required this.setNumber,
      required this.targetReps,
      this.actualReps,
      this.weightKg,
      required this.completed,
      required this.isPr});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['session_id'] = Variable<int>(sessionId);
    map['exercise_id'] = Variable<int>(exerciseId);
    map['set_number'] = Variable<int>(setNumber);
    map['target_reps'] = Variable<String>(targetReps);
    if (!nullToAbsent || actualReps != null) {
      map['actual_reps'] = Variable<String>(actualReps);
    }
    if (!nullToAbsent || weightKg != null) {
      map['weight_kg'] = Variable<double>(weightKg);
    }
    map['completed'] = Variable<bool>(completed);
    map['is_pr'] = Variable<bool>(isPr);
    return map;
  }

  WorkoutSetsCompanion toCompanion(bool nullToAbsent) {
    return WorkoutSetsCompanion(
      id: Value(id),
      sessionId: Value(sessionId),
      exerciseId: Value(exerciseId),
      setNumber: Value(setNumber),
      targetReps: Value(targetReps),
      actualReps: actualReps == null && nullToAbsent
          ? const Value.absent()
          : Value(actualReps),
      weightKg: weightKg == null && nullToAbsent
          ? const Value.absent()
          : Value(weightKg),
      completed: Value(completed),
      isPr: Value(isPr),
    );
  }

  factory WorkoutSet.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WorkoutSet(
      id: serializer.fromJson<int>(json['id']),
      sessionId: serializer.fromJson<int>(json['sessionId']),
      exerciseId: serializer.fromJson<int>(json['exerciseId']),
      setNumber: serializer.fromJson<int>(json['setNumber']),
      targetReps: serializer.fromJson<String>(json['targetReps']),
      actualReps: serializer.fromJson<String?>(json['actualReps']),
      weightKg: serializer.fromJson<double?>(json['weightKg']),
      completed: serializer.fromJson<bool>(json['completed']),
      isPr: serializer.fromJson<bool>(json['isPr']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'sessionId': serializer.toJson<int>(sessionId),
      'exerciseId': serializer.toJson<int>(exerciseId),
      'setNumber': serializer.toJson<int>(setNumber),
      'targetReps': serializer.toJson<String>(targetReps),
      'actualReps': serializer.toJson<String?>(actualReps),
      'weightKg': serializer.toJson<double?>(weightKg),
      'completed': serializer.toJson<bool>(completed),
      'isPr': serializer.toJson<bool>(isPr),
    };
  }

  WorkoutSet copyWith(
          {int? id,
          int? sessionId,
          int? exerciseId,
          int? setNumber,
          String? targetReps,
          Value<String?> actualReps = const Value.absent(),
          Value<double?> weightKg = const Value.absent(),
          bool? completed,
          bool? isPr}) =>
      WorkoutSet(
        id: id ?? this.id,
        sessionId: sessionId ?? this.sessionId,
        exerciseId: exerciseId ?? this.exerciseId,
        setNumber: setNumber ?? this.setNumber,
        targetReps: targetReps ?? this.targetReps,
        actualReps: actualReps.present ? actualReps.value : this.actualReps,
        weightKg: weightKg.present ? weightKg.value : this.weightKg,
        completed: completed ?? this.completed,
        isPr: isPr ?? this.isPr,
      );
  WorkoutSet copyWithCompanion(WorkoutSetsCompanion data) {
    return WorkoutSet(
      id: data.id.present ? data.id.value : this.id,
      sessionId: data.sessionId.present ? data.sessionId.value : this.sessionId,
      exerciseId:
          data.exerciseId.present ? data.exerciseId.value : this.exerciseId,
      setNumber: data.setNumber.present ? data.setNumber.value : this.setNumber,
      targetReps:
          data.targetReps.present ? data.targetReps.value : this.targetReps,
      actualReps:
          data.actualReps.present ? data.actualReps.value : this.actualReps,
      weightKg: data.weightKg.present ? data.weightKg.value : this.weightKg,
      completed: data.completed.present ? data.completed.value : this.completed,
      isPr: data.isPr.present ? data.isPr.value : this.isPr,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WorkoutSet(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('exerciseId: $exerciseId, ')
          ..write('setNumber: $setNumber, ')
          ..write('targetReps: $targetReps, ')
          ..write('actualReps: $actualReps, ')
          ..write('weightKg: $weightKg, ')
          ..write('completed: $completed, ')
          ..write('isPr: $isPr')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, sessionId, exerciseId, setNumber,
      targetReps, actualReps, weightKg, completed, isPr);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WorkoutSet &&
          other.id == this.id &&
          other.sessionId == this.sessionId &&
          other.exerciseId == this.exerciseId &&
          other.setNumber == this.setNumber &&
          other.targetReps == this.targetReps &&
          other.actualReps == this.actualReps &&
          other.weightKg == this.weightKg &&
          other.completed == this.completed &&
          other.isPr == this.isPr);
}

class WorkoutSetsCompanion extends UpdateCompanion<WorkoutSet> {
  final Value<int> id;
  final Value<int> sessionId;
  final Value<int> exerciseId;
  final Value<int> setNumber;
  final Value<String> targetReps;
  final Value<String?> actualReps;
  final Value<double?> weightKg;
  final Value<bool> completed;
  final Value<bool> isPr;
  const WorkoutSetsCompanion({
    this.id = const Value.absent(),
    this.sessionId = const Value.absent(),
    this.exerciseId = const Value.absent(),
    this.setNumber = const Value.absent(),
    this.targetReps = const Value.absent(),
    this.actualReps = const Value.absent(),
    this.weightKg = const Value.absent(),
    this.completed = const Value.absent(),
    this.isPr = const Value.absent(),
  });
  WorkoutSetsCompanion.insert({
    this.id = const Value.absent(),
    required int sessionId,
    required int exerciseId,
    required int setNumber,
    required String targetReps,
    this.actualReps = const Value.absent(),
    this.weightKg = const Value.absent(),
    this.completed = const Value.absent(),
    this.isPr = const Value.absent(),
  })  : sessionId = Value(sessionId),
        exerciseId = Value(exerciseId),
        setNumber = Value(setNumber),
        targetReps = Value(targetReps);
  static Insertable<WorkoutSet> custom({
    Expression<int>? id,
    Expression<int>? sessionId,
    Expression<int>? exerciseId,
    Expression<int>? setNumber,
    Expression<String>? targetReps,
    Expression<String>? actualReps,
    Expression<double>? weightKg,
    Expression<bool>? completed,
    Expression<bool>? isPr,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sessionId != null) 'session_id': sessionId,
      if (exerciseId != null) 'exercise_id': exerciseId,
      if (setNumber != null) 'set_number': setNumber,
      if (targetReps != null) 'target_reps': targetReps,
      if (actualReps != null) 'actual_reps': actualReps,
      if (weightKg != null) 'weight_kg': weightKg,
      if (completed != null) 'completed': completed,
      if (isPr != null) 'is_pr': isPr,
    });
  }

  WorkoutSetsCompanion copyWith(
      {Value<int>? id,
      Value<int>? sessionId,
      Value<int>? exerciseId,
      Value<int>? setNumber,
      Value<String>? targetReps,
      Value<String?>? actualReps,
      Value<double?>? weightKg,
      Value<bool>? completed,
      Value<bool>? isPr}) {
    return WorkoutSetsCompanion(
      id: id ?? this.id,
      sessionId: sessionId ?? this.sessionId,
      exerciseId: exerciseId ?? this.exerciseId,
      setNumber: setNumber ?? this.setNumber,
      targetReps: targetReps ?? this.targetReps,
      actualReps: actualReps ?? this.actualReps,
      weightKg: weightKg ?? this.weightKg,
      completed: completed ?? this.completed,
      isPr: isPr ?? this.isPr,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (sessionId.present) {
      map['session_id'] = Variable<int>(sessionId.value);
    }
    if (exerciseId.present) {
      map['exercise_id'] = Variable<int>(exerciseId.value);
    }
    if (setNumber.present) {
      map['set_number'] = Variable<int>(setNumber.value);
    }
    if (targetReps.present) {
      map['target_reps'] = Variable<String>(targetReps.value);
    }
    if (actualReps.present) {
      map['actual_reps'] = Variable<String>(actualReps.value);
    }
    if (weightKg.present) {
      map['weight_kg'] = Variable<double>(weightKg.value);
    }
    if (completed.present) {
      map['completed'] = Variable<bool>(completed.value);
    }
    if (isPr.present) {
      map['is_pr'] = Variable<bool>(isPr.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WorkoutSetsCompanion(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('exerciseId: $exerciseId, ')
          ..write('setNumber: $setNumber, ')
          ..write('targetReps: $targetReps, ')
          ..write('actualReps: $actualReps, ')
          ..write('weightKg: $weightKg, ')
          ..write('completed: $completed, ')
          ..write('isPr: $isPr')
          ..write(')'))
        .toString();
  }
}

class $MeasurementsTable extends Measurements
    with TableInfo<$MeasurementsTable, Measurement> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MeasurementsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<String> date = GeneratedColumn<String>(
      'date', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _weightKgMeta =
      const VerificationMeta('weightKg');
  @override
  late final GeneratedColumn<double> weightKg = GeneratedColumn<double>(
      'weight_kg', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _waistCmMeta =
      const VerificationMeta('waistCm');
  @override
  late final GeneratedColumn<double> waistCm = GeneratedColumn<double>(
      'waist_cm', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _pushUpsMeta =
      const VerificationMeta('pushUps');
  @override
  late final GeneratedColumn<int> pushUps = GeneratedColumn<int>(
      'push_ups', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _squatsMeta = const VerificationMeta('squats');
  @override
  late final GeneratedColumn<int> squats = GeneratedColumn<int>(
      'squats', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _plankSecondsMeta =
      const VerificationMeta('plankSeconds');
  @override
  late final GeneratedColumn<int> plankSeconds = GeneratedColumn<int>(
      'plank_seconds', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _resistanceNotesMeta =
      const VerificationMeta('resistanceNotes');
  @override
  late final GeneratedColumn<String> resistanceNotes = GeneratedColumn<String>(
      'resistance_notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _consistencyScoreMeta =
      const VerificationMeta('consistencyScore');
  @override
  late final GeneratedColumn<double> consistencyScore = GeneratedColumn<double>(
      'consistency_score', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _photoPathMeta =
      const VerificationMeta('photoPath');
  @override
  late final GeneratedColumn<String> photoPath = GeneratedColumn<String>(
      'photo_path', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        date,
        weightKg,
        waistCm,
        pushUps,
        squats,
        plankSeconds,
        resistanceNotes,
        consistencyScore,
        photoPath,
        notes
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'measurements';
  @override
  VerificationContext validateIntegrity(Insertable<Measurement> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('weight_kg')) {
      context.handle(_weightKgMeta,
          weightKg.isAcceptableOrUnknown(data['weight_kg']!, _weightKgMeta));
    }
    if (data.containsKey('waist_cm')) {
      context.handle(_waistCmMeta,
          waistCm.isAcceptableOrUnknown(data['waist_cm']!, _waistCmMeta));
    }
    if (data.containsKey('push_ups')) {
      context.handle(_pushUpsMeta,
          pushUps.isAcceptableOrUnknown(data['push_ups']!, _pushUpsMeta));
    }
    if (data.containsKey('squats')) {
      context.handle(_squatsMeta,
          squats.isAcceptableOrUnknown(data['squats']!, _squatsMeta));
    }
    if (data.containsKey('plank_seconds')) {
      context.handle(
          _plankSecondsMeta,
          plankSeconds.isAcceptableOrUnknown(
              data['plank_seconds']!, _plankSecondsMeta));
    }
    if (data.containsKey('resistance_notes')) {
      context.handle(
          _resistanceNotesMeta,
          resistanceNotes.isAcceptableOrUnknown(
              data['resistance_notes']!, _resistanceNotesMeta));
    }
    if (data.containsKey('consistency_score')) {
      context.handle(
          _consistencyScoreMeta,
          consistencyScore.isAcceptableOrUnknown(
              data['consistency_score']!, _consistencyScoreMeta));
    }
    if (data.containsKey('photo_path')) {
      context.handle(_photoPathMeta,
          photoPath.isAcceptableOrUnknown(data['photo_path']!, _photoPathMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Measurement map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Measurement(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}date'])!,
      weightKg: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}weight_kg']),
      waistCm: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}waist_cm']),
      pushUps: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}push_ups']),
      squats: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}squats']),
      plankSeconds: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}plank_seconds']),
      resistanceNotes: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}resistance_notes']),
      consistencyScore: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}consistency_score']),
      photoPath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}photo_path']),
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
    );
  }

  @override
  $MeasurementsTable createAlias(String alias) {
    return $MeasurementsTable(attachedDatabase, alias);
  }
}

class Measurement extends DataClass implements Insertable<Measurement> {
  final int id;
  final String date;
  final double? weightKg;
  final double? waistCm;
  final int? pushUps;
  final int? squats;
  final int? plankSeconds;
  final String? resistanceNotes;
  final double? consistencyScore;
  final String? photoPath;
  final String? notes;
  const Measurement(
      {required this.id,
      required this.date,
      this.weightKg,
      this.waistCm,
      this.pushUps,
      this.squats,
      this.plankSeconds,
      this.resistanceNotes,
      this.consistencyScore,
      this.photoPath,
      this.notes});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['date'] = Variable<String>(date);
    if (!nullToAbsent || weightKg != null) {
      map['weight_kg'] = Variable<double>(weightKg);
    }
    if (!nullToAbsent || waistCm != null) {
      map['waist_cm'] = Variable<double>(waistCm);
    }
    if (!nullToAbsent || pushUps != null) {
      map['push_ups'] = Variable<int>(pushUps);
    }
    if (!nullToAbsent || squats != null) {
      map['squats'] = Variable<int>(squats);
    }
    if (!nullToAbsent || plankSeconds != null) {
      map['plank_seconds'] = Variable<int>(plankSeconds);
    }
    if (!nullToAbsent || resistanceNotes != null) {
      map['resistance_notes'] = Variable<String>(resistanceNotes);
    }
    if (!nullToAbsent || consistencyScore != null) {
      map['consistency_score'] = Variable<double>(consistencyScore);
    }
    if (!nullToAbsent || photoPath != null) {
      map['photo_path'] = Variable<String>(photoPath);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  MeasurementsCompanion toCompanion(bool nullToAbsent) {
    return MeasurementsCompanion(
      id: Value(id),
      date: Value(date),
      weightKg: weightKg == null && nullToAbsent
          ? const Value.absent()
          : Value(weightKg),
      waistCm: waistCm == null && nullToAbsent
          ? const Value.absent()
          : Value(waistCm),
      pushUps: pushUps == null && nullToAbsent
          ? const Value.absent()
          : Value(pushUps),
      squats:
          squats == null && nullToAbsent ? const Value.absent() : Value(squats),
      plankSeconds: plankSeconds == null && nullToAbsent
          ? const Value.absent()
          : Value(plankSeconds),
      resistanceNotes: resistanceNotes == null && nullToAbsent
          ? const Value.absent()
          : Value(resistanceNotes),
      consistencyScore: consistencyScore == null && nullToAbsent
          ? const Value.absent()
          : Value(consistencyScore),
      photoPath: photoPath == null && nullToAbsent
          ? const Value.absent()
          : Value(photoPath),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
    );
  }

  factory Measurement.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Measurement(
      id: serializer.fromJson<int>(json['id']),
      date: serializer.fromJson<String>(json['date']),
      weightKg: serializer.fromJson<double?>(json['weightKg']),
      waistCm: serializer.fromJson<double?>(json['waistCm']),
      pushUps: serializer.fromJson<int?>(json['pushUps']),
      squats: serializer.fromJson<int?>(json['squats']),
      plankSeconds: serializer.fromJson<int?>(json['plankSeconds']),
      resistanceNotes: serializer.fromJson<String?>(json['resistanceNotes']),
      consistencyScore: serializer.fromJson<double?>(json['consistencyScore']),
      photoPath: serializer.fromJson<String?>(json['photoPath']),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'date': serializer.toJson<String>(date),
      'weightKg': serializer.toJson<double?>(weightKg),
      'waistCm': serializer.toJson<double?>(waistCm),
      'pushUps': serializer.toJson<int?>(pushUps),
      'squats': serializer.toJson<int?>(squats),
      'plankSeconds': serializer.toJson<int?>(plankSeconds),
      'resistanceNotes': serializer.toJson<String?>(resistanceNotes),
      'consistencyScore': serializer.toJson<double?>(consistencyScore),
      'photoPath': serializer.toJson<String?>(photoPath),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  Measurement copyWith(
          {int? id,
          String? date,
          Value<double?> weightKg = const Value.absent(),
          Value<double?> waistCm = const Value.absent(),
          Value<int?> pushUps = const Value.absent(),
          Value<int?> squats = const Value.absent(),
          Value<int?> plankSeconds = const Value.absent(),
          Value<String?> resistanceNotes = const Value.absent(),
          Value<double?> consistencyScore = const Value.absent(),
          Value<String?> photoPath = const Value.absent(),
          Value<String?> notes = const Value.absent()}) =>
      Measurement(
        id: id ?? this.id,
        date: date ?? this.date,
        weightKg: weightKg.present ? weightKg.value : this.weightKg,
        waistCm: waistCm.present ? waistCm.value : this.waistCm,
        pushUps: pushUps.present ? pushUps.value : this.pushUps,
        squats: squats.present ? squats.value : this.squats,
        plankSeconds:
            plankSeconds.present ? plankSeconds.value : this.plankSeconds,
        resistanceNotes: resistanceNotes.present
            ? resistanceNotes.value
            : this.resistanceNotes,
        consistencyScore: consistencyScore.present
            ? consistencyScore.value
            : this.consistencyScore,
        photoPath: photoPath.present ? photoPath.value : this.photoPath,
        notes: notes.present ? notes.value : this.notes,
      );
  Measurement copyWithCompanion(MeasurementsCompanion data) {
    return Measurement(
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
      weightKg: data.weightKg.present ? data.weightKg.value : this.weightKg,
      waistCm: data.waistCm.present ? data.waistCm.value : this.waistCm,
      pushUps: data.pushUps.present ? data.pushUps.value : this.pushUps,
      squats: data.squats.present ? data.squats.value : this.squats,
      plankSeconds: data.plankSeconds.present
          ? data.plankSeconds.value
          : this.plankSeconds,
      resistanceNotes: data.resistanceNotes.present
          ? data.resistanceNotes.value
          : this.resistanceNotes,
      consistencyScore: data.consistencyScore.present
          ? data.consistencyScore.value
          : this.consistencyScore,
      photoPath: data.photoPath.present ? data.photoPath.value : this.photoPath,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Measurement(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('weightKg: $weightKg, ')
          ..write('waistCm: $waistCm, ')
          ..write('pushUps: $pushUps, ')
          ..write('squats: $squats, ')
          ..write('plankSeconds: $plankSeconds, ')
          ..write('resistanceNotes: $resistanceNotes, ')
          ..write('consistencyScore: $consistencyScore, ')
          ..write('photoPath: $photoPath, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, date, weightKg, waistCm, pushUps, squats,
      plankSeconds, resistanceNotes, consistencyScore, photoPath, notes);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Measurement &&
          other.id == this.id &&
          other.date == this.date &&
          other.weightKg == this.weightKg &&
          other.waistCm == this.waistCm &&
          other.pushUps == this.pushUps &&
          other.squats == this.squats &&
          other.plankSeconds == this.plankSeconds &&
          other.resistanceNotes == this.resistanceNotes &&
          other.consistencyScore == this.consistencyScore &&
          other.photoPath == this.photoPath &&
          other.notes == this.notes);
}

class MeasurementsCompanion extends UpdateCompanion<Measurement> {
  final Value<int> id;
  final Value<String> date;
  final Value<double?> weightKg;
  final Value<double?> waistCm;
  final Value<int?> pushUps;
  final Value<int?> squats;
  final Value<int?> plankSeconds;
  final Value<String?> resistanceNotes;
  final Value<double?> consistencyScore;
  final Value<String?> photoPath;
  final Value<String?> notes;
  const MeasurementsCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.weightKg = const Value.absent(),
    this.waistCm = const Value.absent(),
    this.pushUps = const Value.absent(),
    this.squats = const Value.absent(),
    this.plankSeconds = const Value.absent(),
    this.resistanceNotes = const Value.absent(),
    this.consistencyScore = const Value.absent(),
    this.photoPath = const Value.absent(),
    this.notes = const Value.absent(),
  });
  MeasurementsCompanion.insert({
    this.id = const Value.absent(),
    required String date,
    this.weightKg = const Value.absent(),
    this.waistCm = const Value.absent(),
    this.pushUps = const Value.absent(),
    this.squats = const Value.absent(),
    this.plankSeconds = const Value.absent(),
    this.resistanceNotes = const Value.absent(),
    this.consistencyScore = const Value.absent(),
    this.photoPath = const Value.absent(),
    this.notes = const Value.absent(),
  }) : date = Value(date);
  static Insertable<Measurement> custom({
    Expression<int>? id,
    Expression<String>? date,
    Expression<double>? weightKg,
    Expression<double>? waistCm,
    Expression<int>? pushUps,
    Expression<int>? squats,
    Expression<int>? plankSeconds,
    Expression<String>? resistanceNotes,
    Expression<double>? consistencyScore,
    Expression<String>? photoPath,
    Expression<String>? notes,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (weightKg != null) 'weight_kg': weightKg,
      if (waistCm != null) 'waist_cm': waistCm,
      if (pushUps != null) 'push_ups': pushUps,
      if (squats != null) 'squats': squats,
      if (plankSeconds != null) 'plank_seconds': plankSeconds,
      if (resistanceNotes != null) 'resistance_notes': resistanceNotes,
      if (consistencyScore != null) 'consistency_score': consistencyScore,
      if (photoPath != null) 'photo_path': photoPath,
      if (notes != null) 'notes': notes,
    });
  }

  MeasurementsCompanion copyWith(
      {Value<int>? id,
      Value<String>? date,
      Value<double?>? weightKg,
      Value<double?>? waistCm,
      Value<int?>? pushUps,
      Value<int?>? squats,
      Value<int?>? plankSeconds,
      Value<String?>? resistanceNotes,
      Value<double?>? consistencyScore,
      Value<String?>? photoPath,
      Value<String?>? notes}) {
    return MeasurementsCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      weightKg: weightKg ?? this.weightKg,
      waistCm: waistCm ?? this.waistCm,
      pushUps: pushUps ?? this.pushUps,
      squats: squats ?? this.squats,
      plankSeconds: plankSeconds ?? this.plankSeconds,
      resistanceNotes: resistanceNotes ?? this.resistanceNotes,
      consistencyScore: consistencyScore ?? this.consistencyScore,
      photoPath: photoPath ?? this.photoPath,
      notes: notes ?? this.notes,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    if (weightKg.present) {
      map['weight_kg'] = Variable<double>(weightKg.value);
    }
    if (waistCm.present) {
      map['waist_cm'] = Variable<double>(waistCm.value);
    }
    if (pushUps.present) {
      map['push_ups'] = Variable<int>(pushUps.value);
    }
    if (squats.present) {
      map['squats'] = Variable<int>(squats.value);
    }
    if (plankSeconds.present) {
      map['plank_seconds'] = Variable<int>(plankSeconds.value);
    }
    if (resistanceNotes.present) {
      map['resistance_notes'] = Variable<String>(resistanceNotes.value);
    }
    if (consistencyScore.present) {
      map['consistency_score'] = Variable<double>(consistencyScore.value);
    }
    if (photoPath.present) {
      map['photo_path'] = Variable<String>(photoPath.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MeasurementsCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('weightKg: $weightKg, ')
          ..write('waistCm: $waistCm, ')
          ..write('pushUps: $pushUps, ')
          ..write('squats: $squats, ')
          ..write('plankSeconds: $plankSeconds, ')
          ..write('resistanceNotes: $resistanceNotes, ')
          ..write('consistencyScore: $consistencyScore, ')
          ..write('photoPath: $photoPath, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }
}

class $NutritionGuidesTable extends NutritionGuides
    with TableInfo<$NutritionGuidesTable, NutritionGuide> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NutritionGuidesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _contentMeta =
      const VerificationMeta('content');
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
      'content', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _categoryMeta =
      const VerificationMeta('category');
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
      'category', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, title, content, category];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'nutrition_guides';
  @override
  VerificationContext validateIntegrity(Insertable<NutritionGuide> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('content')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['content']!, _contentMeta));
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  NutritionGuide map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NutritionGuide(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      content: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}content'])!,
      category: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category'])!,
    );
  }

  @override
  $NutritionGuidesTable createAlias(String alias) {
    return $NutritionGuidesTable(attachedDatabase, alias);
  }
}

class NutritionGuide extends DataClass implements Insertable<NutritionGuide> {
  final int id;
  final String title;
  final String content;
  final String category;
  const NutritionGuide(
      {required this.id,
      required this.title,
      required this.content,
      required this.category});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['content'] = Variable<String>(content);
    map['category'] = Variable<String>(category);
    return map;
  }

  NutritionGuidesCompanion toCompanion(bool nullToAbsent) {
    return NutritionGuidesCompanion(
      id: Value(id),
      title: Value(title),
      content: Value(content),
      category: Value(category),
    );
  }

  factory NutritionGuide.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NutritionGuide(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      content: serializer.fromJson<String>(json['content']),
      category: serializer.fromJson<String>(json['category']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'content': serializer.toJson<String>(content),
      'category': serializer.toJson<String>(category),
    };
  }

  NutritionGuide copyWith(
          {int? id, String? title, String? content, String? category}) =>
      NutritionGuide(
        id: id ?? this.id,
        title: title ?? this.title,
        content: content ?? this.content,
        category: category ?? this.category,
      );
  NutritionGuide copyWithCompanion(NutritionGuidesCompanion data) {
    return NutritionGuide(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      content: data.content.present ? data.content.value : this.content,
      category: data.category.present ? data.category.value : this.category,
    );
  }

  @override
  String toString() {
    return (StringBuffer('NutritionGuide(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('content: $content, ')
          ..write('category: $category')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, content, category);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NutritionGuide &&
          other.id == this.id &&
          other.title == this.title &&
          other.content == this.content &&
          other.category == this.category);
}

class NutritionGuidesCompanion extends UpdateCompanion<NutritionGuide> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> content;
  final Value<String> category;
  const NutritionGuidesCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.content = const Value.absent(),
    this.category = const Value.absent(),
  });
  NutritionGuidesCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required String content,
    required String category,
  })  : title = Value(title),
        content = Value(content),
        category = Value(category);
  static Insertable<NutritionGuide> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? content,
    Expression<String>? category,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (content != null) 'content': content,
      if (category != null) 'category': category,
    });
  }

  NutritionGuidesCompanion copyWith(
      {Value<int>? id,
      Value<String>? title,
      Value<String>? content,
      Value<String>? category}) {
    return NutritionGuidesCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      category: category ?? this.category,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NutritionGuidesCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('content: $content, ')
          ..write('category: $category')
          ..write(')'))
        .toString();
  }
}

class $EnglishLessonsTable extends EnglishLessons
    with TableInfo<$EnglishLessonsTable, EnglishLesson> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EnglishLessonsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _monthIndexMeta =
      const VerificationMeta('monthIndex');
  @override
  late final GeneratedColumn<int> monthIndex = GeneratedColumn<int>(
      'month_index', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _weekIndexMeta =
      const VerificationMeta('weekIndex');
  @override
  late final GeneratedColumn<int> weekIndex = GeneratedColumn<int>(
      'week_index', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _themeMeta = const VerificationMeta('theme');
  @override
  late final GeneratedColumn<String> theme = GeneratedColumn<String>(
      'theme', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _grammarFocusMeta =
      const VerificationMeta('grammarFocus');
  @override
  late final GeneratedColumn<String> grammarFocus = GeneratedColumn<String>(
      'grammar_focus', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _vocabFocusMeta =
      const VerificationMeta('vocabFocus');
  @override
  late final GeneratedColumn<String> vocabFocus = GeneratedColumn<String>(
      'vocab_focus', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _contentMeta =
      const VerificationMeta('content');
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
      'content', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, monthIndex, weekIndex, theme, grammarFocus, vocabFocus, content];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'english_lessons';
  @override
  VerificationContext validateIntegrity(Insertable<EnglishLesson> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('month_index')) {
      context.handle(
          _monthIndexMeta,
          monthIndex.isAcceptableOrUnknown(
              data['month_index']!, _monthIndexMeta));
    } else if (isInserting) {
      context.missing(_monthIndexMeta);
    }
    if (data.containsKey('week_index')) {
      context.handle(_weekIndexMeta,
          weekIndex.isAcceptableOrUnknown(data['week_index']!, _weekIndexMeta));
    } else if (isInserting) {
      context.missing(_weekIndexMeta);
    }
    if (data.containsKey('theme')) {
      context.handle(
          _themeMeta, theme.isAcceptableOrUnknown(data['theme']!, _themeMeta));
    } else if (isInserting) {
      context.missing(_themeMeta);
    }
    if (data.containsKey('grammar_focus')) {
      context.handle(
          _grammarFocusMeta,
          grammarFocus.isAcceptableOrUnknown(
              data['grammar_focus']!, _grammarFocusMeta));
    } else if (isInserting) {
      context.missing(_grammarFocusMeta);
    }
    if (data.containsKey('vocab_focus')) {
      context.handle(
          _vocabFocusMeta,
          vocabFocus.isAcceptableOrUnknown(
              data['vocab_focus']!, _vocabFocusMeta));
    } else if (isInserting) {
      context.missing(_vocabFocusMeta);
    }
    if (data.containsKey('content')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['content']!, _contentMeta));
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  EnglishLesson map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EnglishLesson(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      monthIndex: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}month_index'])!,
      weekIndex: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}week_index'])!,
      theme: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}theme'])!,
      grammarFocus: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}grammar_focus'])!,
      vocabFocus: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}vocab_focus'])!,
      content: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}content'])!,
    );
  }

  @override
  $EnglishLessonsTable createAlias(String alias) {
    return $EnglishLessonsTable(attachedDatabase, alias);
  }
}

class EnglishLesson extends DataClass implements Insertable<EnglishLesson> {
  final int id;
  final int monthIndex;
  final int weekIndex;
  final String theme;
  final String grammarFocus;
  final String vocabFocus;
  final String content;
  const EnglishLesson(
      {required this.id,
      required this.monthIndex,
      required this.weekIndex,
      required this.theme,
      required this.grammarFocus,
      required this.vocabFocus,
      required this.content});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['month_index'] = Variable<int>(monthIndex);
    map['week_index'] = Variable<int>(weekIndex);
    map['theme'] = Variable<String>(theme);
    map['grammar_focus'] = Variable<String>(grammarFocus);
    map['vocab_focus'] = Variable<String>(vocabFocus);
    map['content'] = Variable<String>(content);
    return map;
  }

  EnglishLessonsCompanion toCompanion(bool nullToAbsent) {
    return EnglishLessonsCompanion(
      id: Value(id),
      monthIndex: Value(monthIndex),
      weekIndex: Value(weekIndex),
      theme: Value(theme),
      grammarFocus: Value(grammarFocus),
      vocabFocus: Value(vocabFocus),
      content: Value(content),
    );
  }

  factory EnglishLesson.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EnglishLesson(
      id: serializer.fromJson<int>(json['id']),
      monthIndex: serializer.fromJson<int>(json['monthIndex']),
      weekIndex: serializer.fromJson<int>(json['weekIndex']),
      theme: serializer.fromJson<String>(json['theme']),
      grammarFocus: serializer.fromJson<String>(json['grammarFocus']),
      vocabFocus: serializer.fromJson<String>(json['vocabFocus']),
      content: serializer.fromJson<String>(json['content']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'monthIndex': serializer.toJson<int>(monthIndex),
      'weekIndex': serializer.toJson<int>(weekIndex),
      'theme': serializer.toJson<String>(theme),
      'grammarFocus': serializer.toJson<String>(grammarFocus),
      'vocabFocus': serializer.toJson<String>(vocabFocus),
      'content': serializer.toJson<String>(content),
    };
  }

  EnglishLesson copyWith(
          {int? id,
          int? monthIndex,
          int? weekIndex,
          String? theme,
          String? grammarFocus,
          String? vocabFocus,
          String? content}) =>
      EnglishLesson(
        id: id ?? this.id,
        monthIndex: monthIndex ?? this.monthIndex,
        weekIndex: weekIndex ?? this.weekIndex,
        theme: theme ?? this.theme,
        grammarFocus: grammarFocus ?? this.grammarFocus,
        vocabFocus: vocabFocus ?? this.vocabFocus,
        content: content ?? this.content,
      );
  EnglishLesson copyWithCompanion(EnglishLessonsCompanion data) {
    return EnglishLesson(
      id: data.id.present ? data.id.value : this.id,
      monthIndex:
          data.monthIndex.present ? data.monthIndex.value : this.monthIndex,
      weekIndex: data.weekIndex.present ? data.weekIndex.value : this.weekIndex,
      theme: data.theme.present ? data.theme.value : this.theme,
      grammarFocus: data.grammarFocus.present
          ? data.grammarFocus.value
          : this.grammarFocus,
      vocabFocus:
          data.vocabFocus.present ? data.vocabFocus.value : this.vocabFocus,
      content: data.content.present ? data.content.value : this.content,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EnglishLesson(')
          ..write('id: $id, ')
          ..write('monthIndex: $monthIndex, ')
          ..write('weekIndex: $weekIndex, ')
          ..write('theme: $theme, ')
          ..write('grammarFocus: $grammarFocus, ')
          ..write('vocabFocus: $vocabFocus, ')
          ..write('content: $content')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, monthIndex, weekIndex, theme, grammarFocus, vocabFocus, content);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EnglishLesson &&
          other.id == this.id &&
          other.monthIndex == this.monthIndex &&
          other.weekIndex == this.weekIndex &&
          other.theme == this.theme &&
          other.grammarFocus == this.grammarFocus &&
          other.vocabFocus == this.vocabFocus &&
          other.content == this.content);
}

class EnglishLessonsCompanion extends UpdateCompanion<EnglishLesson> {
  final Value<int> id;
  final Value<int> monthIndex;
  final Value<int> weekIndex;
  final Value<String> theme;
  final Value<String> grammarFocus;
  final Value<String> vocabFocus;
  final Value<String> content;
  const EnglishLessonsCompanion({
    this.id = const Value.absent(),
    this.monthIndex = const Value.absent(),
    this.weekIndex = const Value.absent(),
    this.theme = const Value.absent(),
    this.grammarFocus = const Value.absent(),
    this.vocabFocus = const Value.absent(),
    this.content = const Value.absent(),
  });
  EnglishLessonsCompanion.insert({
    this.id = const Value.absent(),
    required int monthIndex,
    required int weekIndex,
    required String theme,
    required String grammarFocus,
    required String vocabFocus,
    required String content,
  })  : monthIndex = Value(monthIndex),
        weekIndex = Value(weekIndex),
        theme = Value(theme),
        grammarFocus = Value(grammarFocus),
        vocabFocus = Value(vocabFocus),
        content = Value(content);
  static Insertable<EnglishLesson> custom({
    Expression<int>? id,
    Expression<int>? monthIndex,
    Expression<int>? weekIndex,
    Expression<String>? theme,
    Expression<String>? grammarFocus,
    Expression<String>? vocabFocus,
    Expression<String>? content,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (monthIndex != null) 'month_index': monthIndex,
      if (weekIndex != null) 'week_index': weekIndex,
      if (theme != null) 'theme': theme,
      if (grammarFocus != null) 'grammar_focus': grammarFocus,
      if (vocabFocus != null) 'vocab_focus': vocabFocus,
      if (content != null) 'content': content,
    });
  }

  EnglishLessonsCompanion copyWith(
      {Value<int>? id,
      Value<int>? monthIndex,
      Value<int>? weekIndex,
      Value<String>? theme,
      Value<String>? grammarFocus,
      Value<String>? vocabFocus,
      Value<String>? content}) {
    return EnglishLessonsCompanion(
      id: id ?? this.id,
      monthIndex: monthIndex ?? this.monthIndex,
      weekIndex: weekIndex ?? this.weekIndex,
      theme: theme ?? this.theme,
      grammarFocus: grammarFocus ?? this.grammarFocus,
      vocabFocus: vocabFocus ?? this.vocabFocus,
      content: content ?? this.content,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (monthIndex.present) {
      map['month_index'] = Variable<int>(monthIndex.value);
    }
    if (weekIndex.present) {
      map['week_index'] = Variable<int>(weekIndex.value);
    }
    if (theme.present) {
      map['theme'] = Variable<String>(theme.value);
    }
    if (grammarFocus.present) {
      map['grammar_focus'] = Variable<String>(grammarFocus.value);
    }
    if (vocabFocus.present) {
      map['vocab_focus'] = Variable<String>(vocabFocus.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EnglishLessonsCompanion(')
          ..write('id: $id, ')
          ..write('monthIndex: $monthIndex, ')
          ..write('weekIndex: $weekIndex, ')
          ..write('theme: $theme, ')
          ..write('grammarFocus: $grammarFocus, ')
          ..write('vocabFocus: $vocabFocus, ')
          ..write('content: $content')
          ..write(')'))
        .toString();
  }
}

class $VocabEntriesTable extends VocabEntries
    with TableInfo<$VocabEntriesTable, VocabEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VocabEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _wordMeta = const VerificationMeta('word');
  @override
  late final GeneratedColumn<String> word = GeneratedColumn<String>(
      'word', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _meaningMeta =
      const VerificationMeta('meaning');
  @override
  late final GeneratedColumn<String> meaning = GeneratedColumn<String>(
      'meaning', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _exampleMeta =
      const VerificationMeta('example');
  @override
  late final GeneratedColumn<String> example = GeneratedColumn<String>(
      'example', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<String> date = GeneratedColumn<String>(
      'date', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _revisionCountMeta =
      const VerificationMeta('revisionCount');
  @override
  late final GeneratedColumn<int> revisionCount = GeneratedColumn<int>(
      'revision_count', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _lastReviewedMeta =
      const VerificationMeta('lastReviewed');
  @override
  late final GeneratedColumn<DateTime> lastReviewed = GeneratedColumn<DateTime>(
      'last_reviewed', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, word, meaning, example, date, revisionCount, lastReviewed];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'vocab_entries';
  @override
  VerificationContext validateIntegrity(Insertable<VocabEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('word')) {
      context.handle(
          _wordMeta, word.isAcceptableOrUnknown(data['word']!, _wordMeta));
    } else if (isInserting) {
      context.missing(_wordMeta);
    }
    if (data.containsKey('meaning')) {
      context.handle(_meaningMeta,
          meaning.isAcceptableOrUnknown(data['meaning']!, _meaningMeta));
    } else if (isInserting) {
      context.missing(_meaningMeta);
    }
    if (data.containsKey('example')) {
      context.handle(_exampleMeta,
          example.isAcceptableOrUnknown(data['example']!, _exampleMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('revision_count')) {
      context.handle(
          _revisionCountMeta,
          revisionCount.isAcceptableOrUnknown(
              data['revision_count']!, _revisionCountMeta));
    }
    if (data.containsKey('last_reviewed')) {
      context.handle(
          _lastReviewedMeta,
          lastReviewed.isAcceptableOrUnknown(
              data['last_reviewed']!, _lastReviewedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  VocabEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return VocabEntry(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      word: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}word'])!,
      meaning: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}meaning'])!,
      example: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}example']),
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}date'])!,
      revisionCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}revision_count'])!,
      lastReviewed: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}last_reviewed']),
    );
  }

  @override
  $VocabEntriesTable createAlias(String alias) {
    return $VocabEntriesTable(attachedDatabase, alias);
  }
}

class VocabEntry extends DataClass implements Insertable<VocabEntry> {
  final int id;
  final String word;
  final String meaning;
  final String? example;
  final String date;
  final int revisionCount;
  final DateTime? lastReviewed;
  const VocabEntry(
      {required this.id,
      required this.word,
      required this.meaning,
      this.example,
      required this.date,
      required this.revisionCount,
      this.lastReviewed});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['word'] = Variable<String>(word);
    map['meaning'] = Variable<String>(meaning);
    if (!nullToAbsent || example != null) {
      map['example'] = Variable<String>(example);
    }
    map['date'] = Variable<String>(date);
    map['revision_count'] = Variable<int>(revisionCount);
    if (!nullToAbsent || lastReviewed != null) {
      map['last_reviewed'] = Variable<DateTime>(lastReviewed);
    }
    return map;
  }

  VocabEntriesCompanion toCompanion(bool nullToAbsent) {
    return VocabEntriesCompanion(
      id: Value(id),
      word: Value(word),
      meaning: Value(meaning),
      example: example == null && nullToAbsent
          ? const Value.absent()
          : Value(example),
      date: Value(date),
      revisionCount: Value(revisionCount),
      lastReviewed: lastReviewed == null && nullToAbsent
          ? const Value.absent()
          : Value(lastReviewed),
    );
  }

  factory VocabEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return VocabEntry(
      id: serializer.fromJson<int>(json['id']),
      word: serializer.fromJson<String>(json['word']),
      meaning: serializer.fromJson<String>(json['meaning']),
      example: serializer.fromJson<String?>(json['example']),
      date: serializer.fromJson<String>(json['date']),
      revisionCount: serializer.fromJson<int>(json['revisionCount']),
      lastReviewed: serializer.fromJson<DateTime?>(json['lastReviewed']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'word': serializer.toJson<String>(word),
      'meaning': serializer.toJson<String>(meaning),
      'example': serializer.toJson<String?>(example),
      'date': serializer.toJson<String>(date),
      'revisionCount': serializer.toJson<int>(revisionCount),
      'lastReviewed': serializer.toJson<DateTime?>(lastReviewed),
    };
  }

  VocabEntry copyWith(
          {int? id,
          String? word,
          String? meaning,
          Value<String?> example = const Value.absent(),
          String? date,
          int? revisionCount,
          Value<DateTime?> lastReviewed = const Value.absent()}) =>
      VocabEntry(
        id: id ?? this.id,
        word: word ?? this.word,
        meaning: meaning ?? this.meaning,
        example: example.present ? example.value : this.example,
        date: date ?? this.date,
        revisionCount: revisionCount ?? this.revisionCount,
        lastReviewed:
            lastReviewed.present ? lastReviewed.value : this.lastReviewed,
      );
  VocabEntry copyWithCompanion(VocabEntriesCompanion data) {
    return VocabEntry(
      id: data.id.present ? data.id.value : this.id,
      word: data.word.present ? data.word.value : this.word,
      meaning: data.meaning.present ? data.meaning.value : this.meaning,
      example: data.example.present ? data.example.value : this.example,
      date: data.date.present ? data.date.value : this.date,
      revisionCount: data.revisionCount.present
          ? data.revisionCount.value
          : this.revisionCount,
      lastReviewed: data.lastReviewed.present
          ? data.lastReviewed.value
          : this.lastReviewed,
    );
  }

  @override
  String toString() {
    return (StringBuffer('VocabEntry(')
          ..write('id: $id, ')
          ..write('word: $word, ')
          ..write('meaning: $meaning, ')
          ..write('example: $example, ')
          ..write('date: $date, ')
          ..write('revisionCount: $revisionCount, ')
          ..write('lastReviewed: $lastReviewed')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, word, meaning, example, date, revisionCount, lastReviewed);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is VocabEntry &&
          other.id == this.id &&
          other.word == this.word &&
          other.meaning == this.meaning &&
          other.example == this.example &&
          other.date == this.date &&
          other.revisionCount == this.revisionCount &&
          other.lastReviewed == this.lastReviewed);
}

class VocabEntriesCompanion extends UpdateCompanion<VocabEntry> {
  final Value<int> id;
  final Value<String> word;
  final Value<String> meaning;
  final Value<String?> example;
  final Value<String> date;
  final Value<int> revisionCount;
  final Value<DateTime?> lastReviewed;
  const VocabEntriesCompanion({
    this.id = const Value.absent(),
    this.word = const Value.absent(),
    this.meaning = const Value.absent(),
    this.example = const Value.absent(),
    this.date = const Value.absent(),
    this.revisionCount = const Value.absent(),
    this.lastReviewed = const Value.absent(),
  });
  VocabEntriesCompanion.insert({
    this.id = const Value.absent(),
    required String word,
    required String meaning,
    this.example = const Value.absent(),
    required String date,
    this.revisionCount = const Value.absent(),
    this.lastReviewed = const Value.absent(),
  })  : word = Value(word),
        meaning = Value(meaning),
        date = Value(date);
  static Insertable<VocabEntry> custom({
    Expression<int>? id,
    Expression<String>? word,
    Expression<String>? meaning,
    Expression<String>? example,
    Expression<String>? date,
    Expression<int>? revisionCount,
    Expression<DateTime>? lastReviewed,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (word != null) 'word': word,
      if (meaning != null) 'meaning': meaning,
      if (example != null) 'example': example,
      if (date != null) 'date': date,
      if (revisionCount != null) 'revision_count': revisionCount,
      if (lastReviewed != null) 'last_reviewed': lastReviewed,
    });
  }

  VocabEntriesCompanion copyWith(
      {Value<int>? id,
      Value<String>? word,
      Value<String>? meaning,
      Value<String?>? example,
      Value<String>? date,
      Value<int>? revisionCount,
      Value<DateTime?>? lastReviewed}) {
    return VocabEntriesCompanion(
      id: id ?? this.id,
      word: word ?? this.word,
      meaning: meaning ?? this.meaning,
      example: example ?? this.example,
      date: date ?? this.date,
      revisionCount: revisionCount ?? this.revisionCount,
      lastReviewed: lastReviewed ?? this.lastReviewed,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (word.present) {
      map['word'] = Variable<String>(word.value);
    }
    if (meaning.present) {
      map['meaning'] = Variable<String>(meaning.value);
    }
    if (example.present) {
      map['example'] = Variable<String>(example.value);
    }
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    if (revisionCount.present) {
      map['revision_count'] = Variable<int>(revisionCount.value);
    }
    if (lastReviewed.present) {
      map['last_reviewed'] = Variable<DateTime>(lastReviewed.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VocabEntriesCompanion(')
          ..write('id: $id, ')
          ..write('word: $word, ')
          ..write('meaning: $meaning, ')
          ..write('example: $example, ')
          ..write('date: $date, ')
          ..write('revisionCount: $revisionCount, ')
          ..write('lastReviewed: $lastReviewed')
          ..write(')'))
        .toString();
  }
}

class $EnglishSessionsTable extends EnglishSessions
    with TableInfo<$EnglishSessionsTable, EnglishSession> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EnglishSessionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<String> date = GeneratedColumn<String>(
      'date', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _sessionNumberMeta =
      const VerificationMeta('sessionNumber');
  @override
  late final GeneratedColumn<int> sessionNumber = GeneratedColumn<int>(
      'session_number', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _grammarMinutesMeta =
      const VerificationMeta('grammarMinutes');
  @override
  late final GeneratedColumn<int> grammarMinutes = GeneratedColumn<int>(
      'grammar_minutes', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _vocabMinutesMeta =
      const VerificationMeta('vocabMinutes');
  @override
  late final GeneratedColumn<int> vocabMinutes = GeneratedColumn<int>(
      'vocab_minutes', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _listeningMinutesMeta =
      const VerificationMeta('listeningMinutes');
  @override
  late final GeneratedColumn<int> listeningMinutes = GeneratedColumn<int>(
      'listening_minutes', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _readingMinutesMeta =
      const VerificationMeta('readingMinutes');
  @override
  late final GeneratedColumn<int> readingMinutes = GeneratedColumn<int>(
      'reading_minutes', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _speakingMinutesMeta =
      const VerificationMeta('speakingMinutes');
  @override
  late final GeneratedColumn<int> speakingMinutes = GeneratedColumn<int>(
      'speaking_minutes', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _writingMinutesMeta =
      const VerificationMeta('writingMinutes');
  @override
  late final GeneratedColumn<int> writingMinutes = GeneratedColumn<int>(
      'writing_minutes', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('pending'));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        date,
        sessionNumber,
        grammarMinutes,
        vocabMinutes,
        listeningMinutes,
        readingMinutes,
        speakingMinutes,
        writingMinutes,
        notes,
        status
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'english_sessions';
  @override
  VerificationContext validateIntegrity(Insertable<EnglishSession> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('session_number')) {
      context.handle(
          _sessionNumberMeta,
          sessionNumber.isAcceptableOrUnknown(
              data['session_number']!, _sessionNumberMeta));
    } else if (isInserting) {
      context.missing(_sessionNumberMeta);
    }
    if (data.containsKey('grammar_minutes')) {
      context.handle(
          _grammarMinutesMeta,
          grammarMinutes.isAcceptableOrUnknown(
              data['grammar_minutes']!, _grammarMinutesMeta));
    }
    if (data.containsKey('vocab_minutes')) {
      context.handle(
          _vocabMinutesMeta,
          vocabMinutes.isAcceptableOrUnknown(
              data['vocab_minutes']!, _vocabMinutesMeta));
    }
    if (data.containsKey('listening_minutes')) {
      context.handle(
          _listeningMinutesMeta,
          listeningMinutes.isAcceptableOrUnknown(
              data['listening_minutes']!, _listeningMinutesMeta));
    }
    if (data.containsKey('reading_minutes')) {
      context.handle(
          _readingMinutesMeta,
          readingMinutes.isAcceptableOrUnknown(
              data['reading_minutes']!, _readingMinutesMeta));
    }
    if (data.containsKey('speaking_minutes')) {
      context.handle(
          _speakingMinutesMeta,
          speakingMinutes.isAcceptableOrUnknown(
              data['speaking_minutes']!, _speakingMinutesMeta));
    }
    if (data.containsKey('writing_minutes')) {
      context.handle(
          _writingMinutesMeta,
          writingMinutes.isAcceptableOrUnknown(
              data['writing_minutes']!, _writingMinutesMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  EnglishSession map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EnglishSession(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}date'])!,
      sessionNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}session_number'])!,
      grammarMinutes: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}grammar_minutes'])!,
      vocabMinutes: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}vocab_minutes'])!,
      listeningMinutes: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}listening_minutes'])!,
      readingMinutes: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}reading_minutes'])!,
      speakingMinutes: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}speaking_minutes'])!,
      writingMinutes: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}writing_minutes'])!,
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
    );
  }

  @override
  $EnglishSessionsTable createAlias(String alias) {
    return $EnglishSessionsTable(attachedDatabase, alias);
  }
}

class EnglishSession extends DataClass implements Insertable<EnglishSession> {
  final int id;
  final String date;
  final int sessionNumber;
  final int grammarMinutes;
  final int vocabMinutes;
  final int listeningMinutes;
  final int readingMinutes;
  final int speakingMinutes;
  final int writingMinutes;
  final String? notes;
  final String status;
  const EnglishSession(
      {required this.id,
      required this.date,
      required this.sessionNumber,
      required this.grammarMinutes,
      required this.vocabMinutes,
      required this.listeningMinutes,
      required this.readingMinutes,
      required this.speakingMinutes,
      required this.writingMinutes,
      this.notes,
      required this.status});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['date'] = Variable<String>(date);
    map['session_number'] = Variable<int>(sessionNumber);
    map['grammar_minutes'] = Variable<int>(grammarMinutes);
    map['vocab_minutes'] = Variable<int>(vocabMinutes);
    map['listening_minutes'] = Variable<int>(listeningMinutes);
    map['reading_minutes'] = Variable<int>(readingMinutes);
    map['speaking_minutes'] = Variable<int>(speakingMinutes);
    map['writing_minutes'] = Variable<int>(writingMinutes);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['status'] = Variable<String>(status);
    return map;
  }

  EnglishSessionsCompanion toCompanion(bool nullToAbsent) {
    return EnglishSessionsCompanion(
      id: Value(id),
      date: Value(date),
      sessionNumber: Value(sessionNumber),
      grammarMinutes: Value(grammarMinutes),
      vocabMinutes: Value(vocabMinutes),
      listeningMinutes: Value(listeningMinutes),
      readingMinutes: Value(readingMinutes),
      speakingMinutes: Value(speakingMinutes),
      writingMinutes: Value(writingMinutes),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      status: Value(status),
    );
  }

  factory EnglishSession.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EnglishSession(
      id: serializer.fromJson<int>(json['id']),
      date: serializer.fromJson<String>(json['date']),
      sessionNumber: serializer.fromJson<int>(json['sessionNumber']),
      grammarMinutes: serializer.fromJson<int>(json['grammarMinutes']),
      vocabMinutes: serializer.fromJson<int>(json['vocabMinutes']),
      listeningMinutes: serializer.fromJson<int>(json['listeningMinutes']),
      readingMinutes: serializer.fromJson<int>(json['readingMinutes']),
      speakingMinutes: serializer.fromJson<int>(json['speakingMinutes']),
      writingMinutes: serializer.fromJson<int>(json['writingMinutes']),
      notes: serializer.fromJson<String?>(json['notes']),
      status: serializer.fromJson<String>(json['status']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'date': serializer.toJson<String>(date),
      'sessionNumber': serializer.toJson<int>(sessionNumber),
      'grammarMinutes': serializer.toJson<int>(grammarMinutes),
      'vocabMinutes': serializer.toJson<int>(vocabMinutes),
      'listeningMinutes': serializer.toJson<int>(listeningMinutes),
      'readingMinutes': serializer.toJson<int>(readingMinutes),
      'speakingMinutes': serializer.toJson<int>(speakingMinutes),
      'writingMinutes': serializer.toJson<int>(writingMinutes),
      'notes': serializer.toJson<String?>(notes),
      'status': serializer.toJson<String>(status),
    };
  }

  EnglishSession copyWith(
          {int? id,
          String? date,
          int? sessionNumber,
          int? grammarMinutes,
          int? vocabMinutes,
          int? listeningMinutes,
          int? readingMinutes,
          int? speakingMinutes,
          int? writingMinutes,
          Value<String?> notes = const Value.absent(),
          String? status}) =>
      EnglishSession(
        id: id ?? this.id,
        date: date ?? this.date,
        sessionNumber: sessionNumber ?? this.sessionNumber,
        grammarMinutes: grammarMinutes ?? this.grammarMinutes,
        vocabMinutes: vocabMinutes ?? this.vocabMinutes,
        listeningMinutes: listeningMinutes ?? this.listeningMinutes,
        readingMinutes: readingMinutes ?? this.readingMinutes,
        speakingMinutes: speakingMinutes ?? this.speakingMinutes,
        writingMinutes: writingMinutes ?? this.writingMinutes,
        notes: notes.present ? notes.value : this.notes,
        status: status ?? this.status,
      );
  EnglishSession copyWithCompanion(EnglishSessionsCompanion data) {
    return EnglishSession(
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
      sessionNumber: data.sessionNumber.present
          ? data.sessionNumber.value
          : this.sessionNumber,
      grammarMinutes: data.grammarMinutes.present
          ? data.grammarMinutes.value
          : this.grammarMinutes,
      vocabMinutes: data.vocabMinutes.present
          ? data.vocabMinutes.value
          : this.vocabMinutes,
      listeningMinutes: data.listeningMinutes.present
          ? data.listeningMinutes.value
          : this.listeningMinutes,
      readingMinutes: data.readingMinutes.present
          ? data.readingMinutes.value
          : this.readingMinutes,
      speakingMinutes: data.speakingMinutes.present
          ? data.speakingMinutes.value
          : this.speakingMinutes,
      writingMinutes: data.writingMinutes.present
          ? data.writingMinutes.value
          : this.writingMinutes,
      notes: data.notes.present ? data.notes.value : this.notes,
      status: data.status.present ? data.status.value : this.status,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EnglishSession(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('sessionNumber: $sessionNumber, ')
          ..write('grammarMinutes: $grammarMinutes, ')
          ..write('vocabMinutes: $vocabMinutes, ')
          ..write('listeningMinutes: $listeningMinutes, ')
          ..write('readingMinutes: $readingMinutes, ')
          ..write('speakingMinutes: $speakingMinutes, ')
          ..write('writingMinutes: $writingMinutes, ')
          ..write('notes: $notes, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      date,
      sessionNumber,
      grammarMinutes,
      vocabMinutes,
      listeningMinutes,
      readingMinutes,
      speakingMinutes,
      writingMinutes,
      notes,
      status);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EnglishSession &&
          other.id == this.id &&
          other.date == this.date &&
          other.sessionNumber == this.sessionNumber &&
          other.grammarMinutes == this.grammarMinutes &&
          other.vocabMinutes == this.vocabMinutes &&
          other.listeningMinutes == this.listeningMinutes &&
          other.readingMinutes == this.readingMinutes &&
          other.speakingMinutes == this.speakingMinutes &&
          other.writingMinutes == this.writingMinutes &&
          other.notes == this.notes &&
          other.status == this.status);
}

class EnglishSessionsCompanion extends UpdateCompanion<EnglishSession> {
  final Value<int> id;
  final Value<String> date;
  final Value<int> sessionNumber;
  final Value<int> grammarMinutes;
  final Value<int> vocabMinutes;
  final Value<int> listeningMinutes;
  final Value<int> readingMinutes;
  final Value<int> speakingMinutes;
  final Value<int> writingMinutes;
  final Value<String?> notes;
  final Value<String> status;
  const EnglishSessionsCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.sessionNumber = const Value.absent(),
    this.grammarMinutes = const Value.absent(),
    this.vocabMinutes = const Value.absent(),
    this.listeningMinutes = const Value.absent(),
    this.readingMinutes = const Value.absent(),
    this.speakingMinutes = const Value.absent(),
    this.writingMinutes = const Value.absent(),
    this.notes = const Value.absent(),
    this.status = const Value.absent(),
  });
  EnglishSessionsCompanion.insert({
    this.id = const Value.absent(),
    required String date,
    required int sessionNumber,
    this.grammarMinutes = const Value.absent(),
    this.vocabMinutes = const Value.absent(),
    this.listeningMinutes = const Value.absent(),
    this.readingMinutes = const Value.absent(),
    this.speakingMinutes = const Value.absent(),
    this.writingMinutes = const Value.absent(),
    this.notes = const Value.absent(),
    this.status = const Value.absent(),
  })  : date = Value(date),
        sessionNumber = Value(sessionNumber);
  static Insertable<EnglishSession> custom({
    Expression<int>? id,
    Expression<String>? date,
    Expression<int>? sessionNumber,
    Expression<int>? grammarMinutes,
    Expression<int>? vocabMinutes,
    Expression<int>? listeningMinutes,
    Expression<int>? readingMinutes,
    Expression<int>? speakingMinutes,
    Expression<int>? writingMinutes,
    Expression<String>? notes,
    Expression<String>? status,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (sessionNumber != null) 'session_number': sessionNumber,
      if (grammarMinutes != null) 'grammar_minutes': grammarMinutes,
      if (vocabMinutes != null) 'vocab_minutes': vocabMinutes,
      if (listeningMinutes != null) 'listening_minutes': listeningMinutes,
      if (readingMinutes != null) 'reading_minutes': readingMinutes,
      if (speakingMinutes != null) 'speaking_minutes': speakingMinutes,
      if (writingMinutes != null) 'writing_minutes': writingMinutes,
      if (notes != null) 'notes': notes,
      if (status != null) 'status': status,
    });
  }

  EnglishSessionsCompanion copyWith(
      {Value<int>? id,
      Value<String>? date,
      Value<int>? sessionNumber,
      Value<int>? grammarMinutes,
      Value<int>? vocabMinutes,
      Value<int>? listeningMinutes,
      Value<int>? readingMinutes,
      Value<int>? speakingMinutes,
      Value<int>? writingMinutes,
      Value<String?>? notes,
      Value<String>? status}) {
    return EnglishSessionsCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      sessionNumber: sessionNumber ?? this.sessionNumber,
      grammarMinutes: grammarMinutes ?? this.grammarMinutes,
      vocabMinutes: vocabMinutes ?? this.vocabMinutes,
      listeningMinutes: listeningMinutes ?? this.listeningMinutes,
      readingMinutes: readingMinutes ?? this.readingMinutes,
      speakingMinutes: speakingMinutes ?? this.speakingMinutes,
      writingMinutes: writingMinutes ?? this.writingMinutes,
      notes: notes ?? this.notes,
      status: status ?? this.status,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    if (sessionNumber.present) {
      map['session_number'] = Variable<int>(sessionNumber.value);
    }
    if (grammarMinutes.present) {
      map['grammar_minutes'] = Variable<int>(grammarMinutes.value);
    }
    if (vocabMinutes.present) {
      map['vocab_minutes'] = Variable<int>(vocabMinutes.value);
    }
    if (listeningMinutes.present) {
      map['listening_minutes'] = Variable<int>(listeningMinutes.value);
    }
    if (readingMinutes.present) {
      map['reading_minutes'] = Variable<int>(readingMinutes.value);
    }
    if (speakingMinutes.present) {
      map['speaking_minutes'] = Variable<int>(speakingMinutes.value);
    }
    if (writingMinutes.present) {
      map['writing_minutes'] = Variable<int>(writingMinutes.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EnglishSessionsCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('sessionNumber: $sessionNumber, ')
          ..write('grammarMinutes: $grammarMinutes, ')
          ..write('vocabMinutes: $vocabMinutes, ')
          ..write('listeningMinutes: $listeningMinutes, ')
          ..write('readingMinutes: $readingMinutes, ')
          ..write('speakingMinutes: $speakingMinutes, ')
          ..write('writingMinutes: $writingMinutes, ')
          ..write('notes: $notes, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }
}

class $EnglishAssessmentsTable extends EnglishAssessments
    with TableInfo<$EnglishAssessmentsTable, EnglishAssessment> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EnglishAssessmentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<String> date = GeneratedColumn<String>(
      'date', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _scoreMeta = const VerificationMeta('score');
  @override
  late final GeneratedColumn<int> score = GeneratedColumn<int>(
      'score', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _maxScoreMeta =
      const VerificationMeta('maxScore');
  @override
  late final GeneratedColumn<int> maxScore = GeneratedColumn<int>(
      'max_score', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(20));
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _writingSampleMeta =
      const VerificationMeta('writingSample');
  @override
  late final GeneratedColumn<String> writingSample = GeneratedColumn<String>(
      'writing_sample', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _recordingPathMeta =
      const VerificationMeta('recordingPath');
  @override
  late final GeneratedColumn<String> recordingPath = GeneratedColumn<String>(
      'recording_path', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, date, type, score, maxScore, notes, writingSample, recordingPath];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'english_assessments';
  @override
  VerificationContext validateIntegrity(Insertable<EnglishAssessment> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('score')) {
      context.handle(
          _scoreMeta, score.isAcceptableOrUnknown(data['score']!, _scoreMeta));
    } else if (isInserting) {
      context.missing(_scoreMeta);
    }
    if (data.containsKey('max_score')) {
      context.handle(_maxScoreMeta,
          maxScore.isAcceptableOrUnknown(data['max_score']!, _maxScoreMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('writing_sample')) {
      context.handle(
          _writingSampleMeta,
          writingSample.isAcceptableOrUnknown(
              data['writing_sample']!, _writingSampleMeta));
    }
    if (data.containsKey('recording_path')) {
      context.handle(
          _recordingPathMeta,
          recordingPath.isAcceptableOrUnknown(
              data['recording_path']!, _recordingPathMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  EnglishAssessment map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EnglishAssessment(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}date'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      score: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}score'])!,
      maxScore: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}max_score'])!,
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      writingSample: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}writing_sample']),
      recordingPath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}recording_path']),
    );
  }

  @override
  $EnglishAssessmentsTable createAlias(String alias) {
    return $EnglishAssessmentsTable(attachedDatabase, alias);
  }
}

class EnglishAssessment extends DataClass
    implements Insertable<EnglishAssessment> {
  final int id;
  final String date;
  final String type;
  final int score;
  final int maxScore;
  final String? notes;
  final String? writingSample;
  final String? recordingPath;
  const EnglishAssessment(
      {required this.id,
      required this.date,
      required this.type,
      required this.score,
      required this.maxScore,
      this.notes,
      this.writingSample,
      this.recordingPath});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['date'] = Variable<String>(date);
    map['type'] = Variable<String>(type);
    map['score'] = Variable<int>(score);
    map['max_score'] = Variable<int>(maxScore);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    if (!nullToAbsent || writingSample != null) {
      map['writing_sample'] = Variable<String>(writingSample);
    }
    if (!nullToAbsent || recordingPath != null) {
      map['recording_path'] = Variable<String>(recordingPath);
    }
    return map;
  }

  EnglishAssessmentsCompanion toCompanion(bool nullToAbsent) {
    return EnglishAssessmentsCompanion(
      id: Value(id),
      date: Value(date),
      type: Value(type),
      score: Value(score),
      maxScore: Value(maxScore),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      writingSample: writingSample == null && nullToAbsent
          ? const Value.absent()
          : Value(writingSample),
      recordingPath: recordingPath == null && nullToAbsent
          ? const Value.absent()
          : Value(recordingPath),
    );
  }

  factory EnglishAssessment.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EnglishAssessment(
      id: serializer.fromJson<int>(json['id']),
      date: serializer.fromJson<String>(json['date']),
      type: serializer.fromJson<String>(json['type']),
      score: serializer.fromJson<int>(json['score']),
      maxScore: serializer.fromJson<int>(json['maxScore']),
      notes: serializer.fromJson<String?>(json['notes']),
      writingSample: serializer.fromJson<String?>(json['writingSample']),
      recordingPath: serializer.fromJson<String?>(json['recordingPath']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'date': serializer.toJson<String>(date),
      'type': serializer.toJson<String>(type),
      'score': serializer.toJson<int>(score),
      'maxScore': serializer.toJson<int>(maxScore),
      'notes': serializer.toJson<String?>(notes),
      'writingSample': serializer.toJson<String?>(writingSample),
      'recordingPath': serializer.toJson<String?>(recordingPath),
    };
  }

  EnglishAssessment copyWith(
          {int? id,
          String? date,
          String? type,
          int? score,
          int? maxScore,
          Value<String?> notes = const Value.absent(),
          Value<String?> writingSample = const Value.absent(),
          Value<String?> recordingPath = const Value.absent()}) =>
      EnglishAssessment(
        id: id ?? this.id,
        date: date ?? this.date,
        type: type ?? this.type,
        score: score ?? this.score,
        maxScore: maxScore ?? this.maxScore,
        notes: notes.present ? notes.value : this.notes,
        writingSample:
            writingSample.present ? writingSample.value : this.writingSample,
        recordingPath:
            recordingPath.present ? recordingPath.value : this.recordingPath,
      );
  EnglishAssessment copyWithCompanion(EnglishAssessmentsCompanion data) {
    return EnglishAssessment(
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
      type: data.type.present ? data.type.value : this.type,
      score: data.score.present ? data.score.value : this.score,
      maxScore: data.maxScore.present ? data.maxScore.value : this.maxScore,
      notes: data.notes.present ? data.notes.value : this.notes,
      writingSample: data.writingSample.present
          ? data.writingSample.value
          : this.writingSample,
      recordingPath: data.recordingPath.present
          ? data.recordingPath.value
          : this.recordingPath,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EnglishAssessment(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('type: $type, ')
          ..write('score: $score, ')
          ..write('maxScore: $maxScore, ')
          ..write('notes: $notes, ')
          ..write('writingSample: $writingSample, ')
          ..write('recordingPath: $recordingPath')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, date, type, score, maxScore, notes, writingSample, recordingPath);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EnglishAssessment &&
          other.id == this.id &&
          other.date == this.date &&
          other.type == this.type &&
          other.score == this.score &&
          other.maxScore == this.maxScore &&
          other.notes == this.notes &&
          other.writingSample == this.writingSample &&
          other.recordingPath == this.recordingPath);
}

class EnglishAssessmentsCompanion extends UpdateCompanion<EnglishAssessment> {
  final Value<int> id;
  final Value<String> date;
  final Value<String> type;
  final Value<int> score;
  final Value<int> maxScore;
  final Value<String?> notes;
  final Value<String?> writingSample;
  final Value<String?> recordingPath;
  const EnglishAssessmentsCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.type = const Value.absent(),
    this.score = const Value.absent(),
    this.maxScore = const Value.absent(),
    this.notes = const Value.absent(),
    this.writingSample = const Value.absent(),
    this.recordingPath = const Value.absent(),
  });
  EnglishAssessmentsCompanion.insert({
    this.id = const Value.absent(),
    required String date,
    required String type,
    required int score,
    this.maxScore = const Value.absent(),
    this.notes = const Value.absent(),
    this.writingSample = const Value.absent(),
    this.recordingPath = const Value.absent(),
  })  : date = Value(date),
        type = Value(type),
        score = Value(score);
  static Insertable<EnglishAssessment> custom({
    Expression<int>? id,
    Expression<String>? date,
    Expression<String>? type,
    Expression<int>? score,
    Expression<int>? maxScore,
    Expression<String>? notes,
    Expression<String>? writingSample,
    Expression<String>? recordingPath,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (type != null) 'type': type,
      if (score != null) 'score': score,
      if (maxScore != null) 'max_score': maxScore,
      if (notes != null) 'notes': notes,
      if (writingSample != null) 'writing_sample': writingSample,
      if (recordingPath != null) 'recording_path': recordingPath,
    });
  }

  EnglishAssessmentsCompanion copyWith(
      {Value<int>? id,
      Value<String>? date,
      Value<String>? type,
      Value<int>? score,
      Value<int>? maxScore,
      Value<String?>? notes,
      Value<String?>? writingSample,
      Value<String?>? recordingPath}) {
    return EnglishAssessmentsCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      type: type ?? this.type,
      score: score ?? this.score,
      maxScore: maxScore ?? this.maxScore,
      notes: notes ?? this.notes,
      writingSample: writingSample ?? this.writingSample,
      recordingPath: recordingPath ?? this.recordingPath,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (score.present) {
      map['score'] = Variable<int>(score.value);
    }
    if (maxScore.present) {
      map['max_score'] = Variable<int>(maxScore.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (writingSample.present) {
      map['writing_sample'] = Variable<String>(writingSample.value);
    }
    if (recordingPath.present) {
      map['recording_path'] = Variable<String>(recordingPath.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EnglishAssessmentsCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('type: $type, ')
          ..write('score: $score, ')
          ..write('maxScore: $maxScore, ')
          ..write('notes: $notes, ')
          ..write('writingSample: $writingSample, ')
          ..write('recordingPath: $recordingPath')
          ..write(')'))
        .toString();
  }
}

class $RepairLessonsTable extends RepairLessons
    with TableInfo<$RepairLessonsTable, RepairLesson> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RepairLessonsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _monthIndexMeta =
      const VerificationMeta('monthIndex');
  @override
  late final GeneratedColumn<int> monthIndex = GeneratedColumn<int>(
      'month_index', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _contentMeta =
      const VerificationMeta('content');
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
      'content', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _lessonTypeMeta =
      const VerificationMeta('lessonType');
  @override
  late final GeneratedColumn<String> lessonType = GeneratedColumn<String>(
      'lesson_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _requiresEquipmentMeta =
      const VerificationMeta('requiresEquipment');
  @override
  late final GeneratedColumn<bool> requiresEquipment = GeneratedColumn<bool>(
      'requires_equipment', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("requires_equipment" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _requiredEquipmentMeta =
      const VerificationMeta('requiredEquipment');
  @override
  late final GeneratedColumn<String> requiredEquipment =
      GeneratedColumn<String>('required_equipment', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _safetyCriticalMeta =
      const VerificationMeta('safetyCritical');
  @override
  late final GeneratedColumn<bool> safetyCritical = GeneratedColumn<bool>(
      'safety_critical', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("safety_critical" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        monthIndex,
        title,
        content,
        lessonType,
        requiresEquipment,
        requiredEquipment,
        safetyCritical
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'repair_lessons';
  @override
  VerificationContext validateIntegrity(Insertable<RepairLesson> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('month_index')) {
      context.handle(
          _monthIndexMeta,
          monthIndex.isAcceptableOrUnknown(
              data['month_index']!, _monthIndexMeta));
    } else if (isInserting) {
      context.missing(_monthIndexMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('content')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['content']!, _contentMeta));
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('lesson_type')) {
      context.handle(
          _lessonTypeMeta,
          lessonType.isAcceptableOrUnknown(
              data['lesson_type']!, _lessonTypeMeta));
    } else if (isInserting) {
      context.missing(_lessonTypeMeta);
    }
    if (data.containsKey('requires_equipment')) {
      context.handle(
          _requiresEquipmentMeta,
          requiresEquipment.isAcceptableOrUnknown(
              data['requires_equipment']!, _requiresEquipmentMeta));
    }
    if (data.containsKey('required_equipment')) {
      context.handle(
          _requiredEquipmentMeta,
          requiredEquipment.isAcceptableOrUnknown(
              data['required_equipment']!, _requiredEquipmentMeta));
    }
    if (data.containsKey('safety_critical')) {
      context.handle(
          _safetyCriticalMeta,
          safetyCritical.isAcceptableOrUnknown(
              data['safety_critical']!, _safetyCriticalMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RepairLesson map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RepairLesson(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      monthIndex: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}month_index'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      content: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}content'])!,
      lessonType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}lesson_type'])!,
      requiresEquipment: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}requires_equipment'])!,
      requiredEquipment: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}required_equipment']),
      safetyCritical: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}safety_critical'])!,
    );
  }

  @override
  $RepairLessonsTable createAlias(String alias) {
    return $RepairLessonsTable(attachedDatabase, alias);
  }
}

class RepairLesson extends DataClass implements Insertable<RepairLesson> {
  final int id;
  final int monthIndex;
  final String title;
  final String content;
  final String lessonType;
  final bool requiresEquipment;
  final String? requiredEquipment;
  final bool safetyCritical;
  const RepairLesson(
      {required this.id,
      required this.monthIndex,
      required this.title,
      required this.content,
      required this.lessonType,
      required this.requiresEquipment,
      this.requiredEquipment,
      required this.safetyCritical});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['month_index'] = Variable<int>(monthIndex);
    map['title'] = Variable<String>(title);
    map['content'] = Variable<String>(content);
    map['lesson_type'] = Variable<String>(lessonType);
    map['requires_equipment'] = Variable<bool>(requiresEquipment);
    if (!nullToAbsent || requiredEquipment != null) {
      map['required_equipment'] = Variable<String>(requiredEquipment);
    }
    map['safety_critical'] = Variable<bool>(safetyCritical);
    return map;
  }

  RepairLessonsCompanion toCompanion(bool nullToAbsent) {
    return RepairLessonsCompanion(
      id: Value(id),
      monthIndex: Value(monthIndex),
      title: Value(title),
      content: Value(content),
      lessonType: Value(lessonType),
      requiresEquipment: Value(requiresEquipment),
      requiredEquipment: requiredEquipment == null && nullToAbsent
          ? const Value.absent()
          : Value(requiredEquipment),
      safetyCritical: Value(safetyCritical),
    );
  }

  factory RepairLesson.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RepairLesson(
      id: serializer.fromJson<int>(json['id']),
      monthIndex: serializer.fromJson<int>(json['monthIndex']),
      title: serializer.fromJson<String>(json['title']),
      content: serializer.fromJson<String>(json['content']),
      lessonType: serializer.fromJson<String>(json['lessonType']),
      requiresEquipment: serializer.fromJson<bool>(json['requiresEquipment']),
      requiredEquipment:
          serializer.fromJson<String?>(json['requiredEquipment']),
      safetyCritical: serializer.fromJson<bool>(json['safetyCritical']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'monthIndex': serializer.toJson<int>(monthIndex),
      'title': serializer.toJson<String>(title),
      'content': serializer.toJson<String>(content),
      'lessonType': serializer.toJson<String>(lessonType),
      'requiresEquipment': serializer.toJson<bool>(requiresEquipment),
      'requiredEquipment': serializer.toJson<String?>(requiredEquipment),
      'safetyCritical': serializer.toJson<bool>(safetyCritical),
    };
  }

  RepairLesson copyWith(
          {int? id,
          int? monthIndex,
          String? title,
          String? content,
          String? lessonType,
          bool? requiresEquipment,
          Value<String?> requiredEquipment = const Value.absent(),
          bool? safetyCritical}) =>
      RepairLesson(
        id: id ?? this.id,
        monthIndex: monthIndex ?? this.monthIndex,
        title: title ?? this.title,
        content: content ?? this.content,
        lessonType: lessonType ?? this.lessonType,
        requiresEquipment: requiresEquipment ?? this.requiresEquipment,
        requiredEquipment: requiredEquipment.present
            ? requiredEquipment.value
            : this.requiredEquipment,
        safetyCritical: safetyCritical ?? this.safetyCritical,
      );
  RepairLesson copyWithCompanion(RepairLessonsCompanion data) {
    return RepairLesson(
      id: data.id.present ? data.id.value : this.id,
      monthIndex:
          data.monthIndex.present ? data.monthIndex.value : this.monthIndex,
      title: data.title.present ? data.title.value : this.title,
      content: data.content.present ? data.content.value : this.content,
      lessonType:
          data.lessonType.present ? data.lessonType.value : this.lessonType,
      requiresEquipment: data.requiresEquipment.present
          ? data.requiresEquipment.value
          : this.requiresEquipment,
      requiredEquipment: data.requiredEquipment.present
          ? data.requiredEquipment.value
          : this.requiredEquipment,
      safetyCritical: data.safetyCritical.present
          ? data.safetyCritical.value
          : this.safetyCritical,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RepairLesson(')
          ..write('id: $id, ')
          ..write('monthIndex: $monthIndex, ')
          ..write('title: $title, ')
          ..write('content: $content, ')
          ..write('lessonType: $lessonType, ')
          ..write('requiresEquipment: $requiresEquipment, ')
          ..write('requiredEquipment: $requiredEquipment, ')
          ..write('safetyCritical: $safetyCritical')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, monthIndex, title, content, lessonType,
      requiresEquipment, requiredEquipment, safetyCritical);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RepairLesson &&
          other.id == this.id &&
          other.monthIndex == this.monthIndex &&
          other.title == this.title &&
          other.content == this.content &&
          other.lessonType == this.lessonType &&
          other.requiresEquipment == this.requiresEquipment &&
          other.requiredEquipment == this.requiredEquipment &&
          other.safetyCritical == this.safetyCritical);
}

class RepairLessonsCompanion extends UpdateCompanion<RepairLesson> {
  final Value<int> id;
  final Value<int> monthIndex;
  final Value<String> title;
  final Value<String> content;
  final Value<String> lessonType;
  final Value<bool> requiresEquipment;
  final Value<String?> requiredEquipment;
  final Value<bool> safetyCritical;
  const RepairLessonsCompanion({
    this.id = const Value.absent(),
    this.monthIndex = const Value.absent(),
    this.title = const Value.absent(),
    this.content = const Value.absent(),
    this.lessonType = const Value.absent(),
    this.requiresEquipment = const Value.absent(),
    this.requiredEquipment = const Value.absent(),
    this.safetyCritical = const Value.absent(),
  });
  RepairLessonsCompanion.insert({
    this.id = const Value.absent(),
    required int monthIndex,
    required String title,
    required String content,
    required String lessonType,
    this.requiresEquipment = const Value.absent(),
    this.requiredEquipment = const Value.absent(),
    this.safetyCritical = const Value.absent(),
  })  : monthIndex = Value(monthIndex),
        title = Value(title),
        content = Value(content),
        lessonType = Value(lessonType);
  static Insertable<RepairLesson> custom({
    Expression<int>? id,
    Expression<int>? monthIndex,
    Expression<String>? title,
    Expression<String>? content,
    Expression<String>? lessonType,
    Expression<bool>? requiresEquipment,
    Expression<String>? requiredEquipment,
    Expression<bool>? safetyCritical,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (monthIndex != null) 'month_index': monthIndex,
      if (title != null) 'title': title,
      if (content != null) 'content': content,
      if (lessonType != null) 'lesson_type': lessonType,
      if (requiresEquipment != null) 'requires_equipment': requiresEquipment,
      if (requiredEquipment != null) 'required_equipment': requiredEquipment,
      if (safetyCritical != null) 'safety_critical': safetyCritical,
    });
  }

  RepairLessonsCompanion copyWith(
      {Value<int>? id,
      Value<int>? monthIndex,
      Value<String>? title,
      Value<String>? content,
      Value<String>? lessonType,
      Value<bool>? requiresEquipment,
      Value<String?>? requiredEquipment,
      Value<bool>? safetyCritical}) {
    return RepairLessonsCompanion(
      id: id ?? this.id,
      monthIndex: monthIndex ?? this.monthIndex,
      title: title ?? this.title,
      content: content ?? this.content,
      lessonType: lessonType ?? this.lessonType,
      requiresEquipment: requiresEquipment ?? this.requiresEquipment,
      requiredEquipment: requiredEquipment ?? this.requiredEquipment,
      safetyCritical: safetyCritical ?? this.safetyCritical,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (monthIndex.present) {
      map['month_index'] = Variable<int>(monthIndex.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (lessonType.present) {
      map['lesson_type'] = Variable<String>(lessonType.value);
    }
    if (requiresEquipment.present) {
      map['requires_equipment'] = Variable<bool>(requiresEquipment.value);
    }
    if (requiredEquipment.present) {
      map['required_equipment'] = Variable<String>(requiredEquipment.value);
    }
    if (safetyCritical.present) {
      map['safety_critical'] = Variable<bool>(safetyCritical.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RepairLessonsCompanion(')
          ..write('id: $id, ')
          ..write('monthIndex: $monthIndex, ')
          ..write('title: $title, ')
          ..write('content: $content, ')
          ..write('lessonType: $lessonType, ')
          ..write('requiresEquipment: $requiresEquipment, ')
          ..write('requiredEquipment: $requiredEquipment, ')
          ..write('safetyCritical: $safetyCritical')
          ..write(')'))
        .toString();
  }
}

class $ComponentsTable extends Components
    with TableInfo<$ComponentsTable, Component> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ComponentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _typicalValuesMeta =
      const VerificationMeta('typicalValues');
  @override
  late final GeneratedColumn<String> typicalValues = GeneratedColumn<String>(
      'typical_values', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, description, typicalValues, notes];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'components';
  @override
  VerificationContext validateIntegrity(Insertable<Component> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('typical_values')) {
      context.handle(
          _typicalValuesMeta,
          typicalValues.isAcceptableOrUnknown(
              data['typical_values']!, _typicalValuesMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Component map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Component(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
      typicalValues: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}typical_values']),
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
    );
  }

  @override
  $ComponentsTable createAlias(String alias) {
    return $ComponentsTable(attachedDatabase, alias);
  }
}

class Component extends DataClass implements Insertable<Component> {
  final int id;
  final String name;
  final String description;
  final String? typicalValues;
  final String? notes;
  const Component(
      {required this.id,
      required this.name,
      required this.description,
      this.typicalValues,
      this.notes});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['description'] = Variable<String>(description);
    if (!nullToAbsent || typicalValues != null) {
      map['typical_values'] = Variable<String>(typicalValues);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  ComponentsCompanion toCompanion(bool nullToAbsent) {
    return ComponentsCompanion(
      id: Value(id),
      name: Value(name),
      description: Value(description),
      typicalValues: typicalValues == null && nullToAbsent
          ? const Value.absent()
          : Value(typicalValues),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
    );
  }

  factory Component.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Component(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String>(json['description']),
      typicalValues: serializer.fromJson<String?>(json['typicalValues']),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String>(description),
      'typicalValues': serializer.toJson<String?>(typicalValues),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  Component copyWith(
          {int? id,
          String? name,
          String? description,
          Value<String?> typicalValues = const Value.absent(),
          Value<String?> notes = const Value.absent()}) =>
      Component(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        typicalValues:
            typicalValues.present ? typicalValues.value : this.typicalValues,
        notes: notes.present ? notes.value : this.notes,
      );
  Component copyWithCompanion(ComponentsCompanion data) {
    return Component(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      description:
          data.description.present ? data.description.value : this.description,
      typicalValues: data.typicalValues.present
          ? data.typicalValues.value
          : this.typicalValues,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Component(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('typicalValues: $typicalValues, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, description, typicalValues, notes);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Component &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.typicalValues == this.typicalValues &&
          other.notes == this.notes);
}

class ComponentsCompanion extends UpdateCompanion<Component> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> description;
  final Value<String?> typicalValues;
  final Value<String?> notes;
  const ComponentsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.typicalValues = const Value.absent(),
    this.notes = const Value.absent(),
  });
  ComponentsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String description,
    this.typicalValues = const Value.absent(),
    this.notes = const Value.absent(),
  })  : name = Value(name),
        description = Value(description);
  static Insertable<Component> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<String>? typicalValues,
    Expression<String>? notes,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (typicalValues != null) 'typical_values': typicalValues,
      if (notes != null) 'notes': notes,
    });
  }

  ComponentsCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String>? description,
      Value<String?>? typicalValues,
      Value<String?>? notes}) {
    return ComponentsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      typicalValues: typicalValues ?? this.typicalValues,
      notes: notes ?? this.notes,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (typicalValues.present) {
      map['typical_values'] = Variable<String>(typicalValues.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ComponentsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('typicalValues: $typicalValues, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }
}

class $EquipmentItemsTable extends EquipmentItems
    with TableInfo<$EquipmentItemsTable, EquipmentItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EquipmentItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _ownedMeta = const VerificationMeta('owned');
  @override
  late final GeneratedColumn<bool> owned = GeneratedColumn<bool>(
      'owned', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("owned" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _acquiredAtMeta =
      const VerificationMeta('acquiredAt');
  @override
  late final GeneratedColumn<DateTime> acquiredAt = GeneratedColumn<DateTime>(
      'acquired_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [id, name, owned, notes, acquiredAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'equipment_items';
  @override
  VerificationContext validateIntegrity(Insertable<EquipmentItem> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('owned')) {
      context.handle(
          _ownedMeta, owned.isAcceptableOrUnknown(data['owned']!, _ownedMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('acquired_at')) {
      context.handle(
          _acquiredAtMeta,
          acquiredAt.isAcceptableOrUnknown(
              data['acquired_at']!, _acquiredAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  EquipmentItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EquipmentItem(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      owned: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}owned'])!,
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      acquiredAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}acquired_at']),
    );
  }

  @override
  $EquipmentItemsTable createAlias(String alias) {
    return $EquipmentItemsTable(attachedDatabase, alias);
  }
}

class EquipmentItem extends DataClass implements Insertable<EquipmentItem> {
  final int id;
  final String name;
  final bool owned;
  final String? notes;
  final DateTime? acquiredAt;
  const EquipmentItem(
      {required this.id,
      required this.name,
      required this.owned,
      this.notes,
      this.acquiredAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['owned'] = Variable<bool>(owned);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    if (!nullToAbsent || acquiredAt != null) {
      map['acquired_at'] = Variable<DateTime>(acquiredAt);
    }
    return map;
  }

  EquipmentItemsCompanion toCompanion(bool nullToAbsent) {
    return EquipmentItemsCompanion(
      id: Value(id),
      name: Value(name),
      owned: Value(owned),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      acquiredAt: acquiredAt == null && nullToAbsent
          ? const Value.absent()
          : Value(acquiredAt),
    );
  }

  factory EquipmentItem.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EquipmentItem(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      owned: serializer.fromJson<bool>(json['owned']),
      notes: serializer.fromJson<String?>(json['notes']),
      acquiredAt: serializer.fromJson<DateTime?>(json['acquiredAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'owned': serializer.toJson<bool>(owned),
      'notes': serializer.toJson<String?>(notes),
      'acquiredAt': serializer.toJson<DateTime?>(acquiredAt),
    };
  }

  EquipmentItem copyWith(
          {int? id,
          String? name,
          bool? owned,
          Value<String?> notes = const Value.absent(),
          Value<DateTime?> acquiredAt = const Value.absent()}) =>
      EquipmentItem(
        id: id ?? this.id,
        name: name ?? this.name,
        owned: owned ?? this.owned,
        notes: notes.present ? notes.value : this.notes,
        acquiredAt: acquiredAt.present ? acquiredAt.value : this.acquiredAt,
      );
  EquipmentItem copyWithCompanion(EquipmentItemsCompanion data) {
    return EquipmentItem(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      owned: data.owned.present ? data.owned.value : this.owned,
      notes: data.notes.present ? data.notes.value : this.notes,
      acquiredAt:
          data.acquiredAt.present ? data.acquiredAt.value : this.acquiredAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EquipmentItem(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('owned: $owned, ')
          ..write('notes: $notes, ')
          ..write('acquiredAt: $acquiredAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, owned, notes, acquiredAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EquipmentItem &&
          other.id == this.id &&
          other.name == this.name &&
          other.owned == this.owned &&
          other.notes == this.notes &&
          other.acquiredAt == this.acquiredAt);
}

class EquipmentItemsCompanion extends UpdateCompanion<EquipmentItem> {
  final Value<int> id;
  final Value<String> name;
  final Value<bool> owned;
  final Value<String?> notes;
  final Value<DateTime?> acquiredAt;
  const EquipmentItemsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.owned = const Value.absent(),
    this.notes = const Value.absent(),
    this.acquiredAt = const Value.absent(),
  });
  EquipmentItemsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.owned = const Value.absent(),
    this.notes = const Value.absent(),
    this.acquiredAt = const Value.absent(),
  }) : name = Value(name);
  static Insertable<EquipmentItem> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<bool>? owned,
    Expression<String>? notes,
    Expression<DateTime>? acquiredAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (owned != null) 'owned': owned,
      if (notes != null) 'notes': notes,
      if (acquiredAt != null) 'acquired_at': acquiredAt,
    });
  }

  EquipmentItemsCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<bool>? owned,
      Value<String?>? notes,
      Value<DateTime?>? acquiredAt}) {
    return EquipmentItemsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      owned: owned ?? this.owned,
      notes: notes ?? this.notes,
      acquiredAt: acquiredAt ?? this.acquiredAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (owned.present) {
      map['owned'] = Variable<bool>(owned.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (acquiredAt.present) {
      map['acquired_at'] = Variable<DateTime>(acquiredAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EquipmentItemsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('owned: $owned, ')
          ..write('notes: $notes, ')
          ..write('acquiredAt: $acquiredAt')
          ..write(')'))
        .toString();
  }
}

class $RepairExercisesTable extends RepairExercises
    with TableInfo<$RepairExercisesTable, RepairExercise> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RepairExercisesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _instructionsMeta =
      const VerificationMeta('instructions');
  @override
  late final GeneratedColumn<String> instructions = GeneratedColumn<String>(
      'instructions', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _lockedMeta = const VerificationMeta('locked');
  @override
  late final GeneratedColumn<bool> locked = GeneratedColumn<bool>(
      'locked', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("locked" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _requiredEquipmentMeta =
      const VerificationMeta('requiredEquipment');
  @override
  late final GeneratedColumn<String> requiredEquipment =
      GeneratedColumn<String>('required_equipment', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _safetyNotesMeta =
      const VerificationMeta('safetyNotes');
  @override
  late final GeneratedColumn<String> safetyNotes = GeneratedColumn<String>(
      'safety_notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, title, instructions, locked, requiredEquipment, safetyNotes];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'repair_exercises';
  @override
  VerificationContext validateIntegrity(Insertable<RepairExercise> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('instructions')) {
      context.handle(
          _instructionsMeta,
          instructions.isAcceptableOrUnknown(
              data['instructions']!, _instructionsMeta));
    } else if (isInserting) {
      context.missing(_instructionsMeta);
    }
    if (data.containsKey('locked')) {
      context.handle(_lockedMeta,
          locked.isAcceptableOrUnknown(data['locked']!, _lockedMeta));
    }
    if (data.containsKey('required_equipment')) {
      context.handle(
          _requiredEquipmentMeta,
          requiredEquipment.isAcceptableOrUnknown(
              data['required_equipment']!, _requiredEquipmentMeta));
    }
    if (data.containsKey('safety_notes')) {
      context.handle(
          _safetyNotesMeta,
          safetyNotes.isAcceptableOrUnknown(
              data['safety_notes']!, _safetyNotesMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RepairExercise map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RepairExercise(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      instructions: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}instructions'])!,
      locked: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}locked'])!,
      requiredEquipment: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}required_equipment']),
      safetyNotes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}safety_notes']),
    );
  }

  @override
  $RepairExercisesTable createAlias(String alias) {
    return $RepairExercisesTable(attachedDatabase, alias);
  }
}

class RepairExercise extends DataClass implements Insertable<RepairExercise> {
  final int id;
  final String title;
  final String instructions;
  final bool locked;
  final String? requiredEquipment;
  final String? safetyNotes;
  const RepairExercise(
      {required this.id,
      required this.title,
      required this.instructions,
      required this.locked,
      this.requiredEquipment,
      this.safetyNotes});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['instructions'] = Variable<String>(instructions);
    map['locked'] = Variable<bool>(locked);
    if (!nullToAbsent || requiredEquipment != null) {
      map['required_equipment'] = Variable<String>(requiredEquipment);
    }
    if (!nullToAbsent || safetyNotes != null) {
      map['safety_notes'] = Variable<String>(safetyNotes);
    }
    return map;
  }

  RepairExercisesCompanion toCompanion(bool nullToAbsent) {
    return RepairExercisesCompanion(
      id: Value(id),
      title: Value(title),
      instructions: Value(instructions),
      locked: Value(locked),
      requiredEquipment: requiredEquipment == null && nullToAbsent
          ? const Value.absent()
          : Value(requiredEquipment),
      safetyNotes: safetyNotes == null && nullToAbsent
          ? const Value.absent()
          : Value(safetyNotes),
    );
  }

  factory RepairExercise.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RepairExercise(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      instructions: serializer.fromJson<String>(json['instructions']),
      locked: serializer.fromJson<bool>(json['locked']),
      requiredEquipment:
          serializer.fromJson<String?>(json['requiredEquipment']),
      safetyNotes: serializer.fromJson<String?>(json['safetyNotes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'instructions': serializer.toJson<String>(instructions),
      'locked': serializer.toJson<bool>(locked),
      'requiredEquipment': serializer.toJson<String?>(requiredEquipment),
      'safetyNotes': serializer.toJson<String?>(safetyNotes),
    };
  }

  RepairExercise copyWith(
          {int? id,
          String? title,
          String? instructions,
          bool? locked,
          Value<String?> requiredEquipment = const Value.absent(),
          Value<String?> safetyNotes = const Value.absent()}) =>
      RepairExercise(
        id: id ?? this.id,
        title: title ?? this.title,
        instructions: instructions ?? this.instructions,
        locked: locked ?? this.locked,
        requiredEquipment: requiredEquipment.present
            ? requiredEquipment.value
            : this.requiredEquipment,
        safetyNotes: safetyNotes.present ? safetyNotes.value : this.safetyNotes,
      );
  RepairExercise copyWithCompanion(RepairExercisesCompanion data) {
    return RepairExercise(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      instructions: data.instructions.present
          ? data.instructions.value
          : this.instructions,
      locked: data.locked.present ? data.locked.value : this.locked,
      requiredEquipment: data.requiredEquipment.present
          ? data.requiredEquipment.value
          : this.requiredEquipment,
      safetyNotes:
          data.safetyNotes.present ? data.safetyNotes.value : this.safetyNotes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RepairExercise(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('instructions: $instructions, ')
          ..write('locked: $locked, ')
          ..write('requiredEquipment: $requiredEquipment, ')
          ..write('safetyNotes: $safetyNotes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, title, instructions, locked, requiredEquipment, safetyNotes);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RepairExercise &&
          other.id == this.id &&
          other.title == this.title &&
          other.instructions == this.instructions &&
          other.locked == this.locked &&
          other.requiredEquipment == this.requiredEquipment &&
          other.safetyNotes == this.safetyNotes);
}

class RepairExercisesCompanion extends UpdateCompanion<RepairExercise> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> instructions;
  final Value<bool> locked;
  final Value<String?> requiredEquipment;
  final Value<String?> safetyNotes;
  const RepairExercisesCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.instructions = const Value.absent(),
    this.locked = const Value.absent(),
    this.requiredEquipment = const Value.absent(),
    this.safetyNotes = const Value.absent(),
  });
  RepairExercisesCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required String instructions,
    this.locked = const Value.absent(),
    this.requiredEquipment = const Value.absent(),
    this.safetyNotes = const Value.absent(),
  })  : title = Value(title),
        instructions = Value(instructions);
  static Insertable<RepairExercise> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? instructions,
    Expression<bool>? locked,
    Expression<String>? requiredEquipment,
    Expression<String>? safetyNotes,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (instructions != null) 'instructions': instructions,
      if (locked != null) 'locked': locked,
      if (requiredEquipment != null) 'required_equipment': requiredEquipment,
      if (safetyNotes != null) 'safety_notes': safetyNotes,
    });
  }

  RepairExercisesCompanion copyWith(
      {Value<int>? id,
      Value<String>? title,
      Value<String>? instructions,
      Value<bool>? locked,
      Value<String?>? requiredEquipment,
      Value<String?>? safetyNotes}) {
    return RepairExercisesCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      instructions: instructions ?? this.instructions,
      locked: locked ?? this.locked,
      requiredEquipment: requiredEquipment ?? this.requiredEquipment,
      safetyNotes: safetyNotes ?? this.safetyNotes,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (instructions.present) {
      map['instructions'] = Variable<String>(instructions.value);
    }
    if (locked.present) {
      map['locked'] = Variable<bool>(locked.value);
    }
    if (requiredEquipment.present) {
      map['required_equipment'] = Variable<String>(requiredEquipment.value);
    }
    if (safetyNotes.present) {
      map['safety_notes'] = Variable<String>(safetyNotes.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RepairExercisesCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('instructions: $instructions, ')
          ..write('locked: $locked, ')
          ..write('requiredEquipment: $requiredEquipment, ')
          ..write('safetyNotes: $safetyNotes')
          ..write(')'))
        .toString();
  }
}

class $MeasurementNotebookTable extends MeasurementNotebook
    with TableInfo<$MeasurementNotebookTable, MeasurementNotebookData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MeasurementNotebookTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<String> date = GeneratedColumn<String>(
      'date', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _pointMeta = const VerificationMeta('point');
  @override
  late final GeneratedColumn<String> point = GeneratedColumn<String>(
      'point', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
      'value', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _unitMeta = const VerificationMeta('unit');
  @override
  late final GeneratedColumn<String> unit = GeneratedColumn<String>(
      'unit', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _unpoweredOnlyMeta =
      const VerificationMeta('unpoweredOnly');
  @override
  late final GeneratedColumn<bool> unpoweredOnly = GeneratedColumn<bool>(
      'unpowered_only', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("unpowered_only" IN (0, 1))'),
      defaultValue: const Constant(true));
  @override
  List<GeneratedColumn> get $columns =>
      [id, date, point, value, unit, notes, unpoweredOnly];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'measurement_notebook';
  @override
  VerificationContext validateIntegrity(
      Insertable<MeasurementNotebookData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('point')) {
      context.handle(
          _pointMeta, point.isAcceptableOrUnknown(data['point']!, _pointMeta));
    } else if (isInserting) {
      context.missing(_pointMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
          _valueMeta, value.isAcceptableOrUnknown(data['value']!, _valueMeta));
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    if (data.containsKey('unit')) {
      context.handle(
          _unitMeta, unit.isAcceptableOrUnknown(data['unit']!, _unitMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('unpowered_only')) {
      context.handle(
          _unpoweredOnlyMeta,
          unpoweredOnly.isAcceptableOrUnknown(
              data['unpowered_only']!, _unpoweredOnlyMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MeasurementNotebookData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MeasurementNotebookData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}date'])!,
      point: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}point'])!,
      value: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}value'])!,
      unit: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}unit']),
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      unpoweredOnly: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}unpowered_only'])!,
    );
  }

  @override
  $MeasurementNotebookTable createAlias(String alias) {
    return $MeasurementNotebookTable(attachedDatabase, alias);
  }
}

class MeasurementNotebookData extends DataClass
    implements Insertable<MeasurementNotebookData> {
  final int id;
  final String date;
  final String point;
  final String value;
  final String? unit;
  final String? notes;
  final bool unpoweredOnly;
  const MeasurementNotebookData(
      {required this.id,
      required this.date,
      required this.point,
      required this.value,
      this.unit,
      this.notes,
      required this.unpoweredOnly});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['date'] = Variable<String>(date);
    map['point'] = Variable<String>(point);
    map['value'] = Variable<String>(value);
    if (!nullToAbsent || unit != null) {
      map['unit'] = Variable<String>(unit);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['unpowered_only'] = Variable<bool>(unpoweredOnly);
    return map;
  }

  MeasurementNotebookCompanion toCompanion(bool nullToAbsent) {
    return MeasurementNotebookCompanion(
      id: Value(id),
      date: Value(date),
      point: Value(point),
      value: Value(value),
      unit: unit == null && nullToAbsent ? const Value.absent() : Value(unit),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      unpoweredOnly: Value(unpoweredOnly),
    );
  }

  factory MeasurementNotebookData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MeasurementNotebookData(
      id: serializer.fromJson<int>(json['id']),
      date: serializer.fromJson<String>(json['date']),
      point: serializer.fromJson<String>(json['point']),
      value: serializer.fromJson<String>(json['value']),
      unit: serializer.fromJson<String?>(json['unit']),
      notes: serializer.fromJson<String?>(json['notes']),
      unpoweredOnly: serializer.fromJson<bool>(json['unpoweredOnly']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'date': serializer.toJson<String>(date),
      'point': serializer.toJson<String>(point),
      'value': serializer.toJson<String>(value),
      'unit': serializer.toJson<String?>(unit),
      'notes': serializer.toJson<String?>(notes),
      'unpoweredOnly': serializer.toJson<bool>(unpoweredOnly),
    };
  }

  MeasurementNotebookData copyWith(
          {int? id,
          String? date,
          String? point,
          String? value,
          Value<String?> unit = const Value.absent(),
          Value<String?> notes = const Value.absent(),
          bool? unpoweredOnly}) =>
      MeasurementNotebookData(
        id: id ?? this.id,
        date: date ?? this.date,
        point: point ?? this.point,
        value: value ?? this.value,
        unit: unit.present ? unit.value : this.unit,
        notes: notes.present ? notes.value : this.notes,
        unpoweredOnly: unpoweredOnly ?? this.unpoweredOnly,
      );
  MeasurementNotebookData copyWithCompanion(MeasurementNotebookCompanion data) {
    return MeasurementNotebookData(
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
      point: data.point.present ? data.point.value : this.point,
      value: data.value.present ? data.value.value : this.value,
      unit: data.unit.present ? data.unit.value : this.unit,
      notes: data.notes.present ? data.notes.value : this.notes,
      unpoweredOnly: data.unpoweredOnly.present
          ? data.unpoweredOnly.value
          : this.unpoweredOnly,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MeasurementNotebookData(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('point: $point, ')
          ..write('value: $value, ')
          ..write('unit: $unit, ')
          ..write('notes: $notes, ')
          ..write('unpoweredOnly: $unpoweredOnly')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, date, point, value, unit, notes, unpoweredOnly);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MeasurementNotebookData &&
          other.id == this.id &&
          other.date == this.date &&
          other.point == this.point &&
          other.value == this.value &&
          other.unit == this.unit &&
          other.notes == this.notes &&
          other.unpoweredOnly == this.unpoweredOnly);
}

class MeasurementNotebookCompanion
    extends UpdateCompanion<MeasurementNotebookData> {
  final Value<int> id;
  final Value<String> date;
  final Value<String> point;
  final Value<String> value;
  final Value<String?> unit;
  final Value<String?> notes;
  final Value<bool> unpoweredOnly;
  const MeasurementNotebookCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.point = const Value.absent(),
    this.value = const Value.absent(),
    this.unit = const Value.absent(),
    this.notes = const Value.absent(),
    this.unpoweredOnly = const Value.absent(),
  });
  MeasurementNotebookCompanion.insert({
    this.id = const Value.absent(),
    required String date,
    required String point,
    required String value,
    this.unit = const Value.absent(),
    this.notes = const Value.absent(),
    this.unpoweredOnly = const Value.absent(),
  })  : date = Value(date),
        point = Value(point),
        value = Value(value);
  static Insertable<MeasurementNotebookData> custom({
    Expression<int>? id,
    Expression<String>? date,
    Expression<String>? point,
    Expression<String>? value,
    Expression<String>? unit,
    Expression<String>? notes,
    Expression<bool>? unpoweredOnly,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (point != null) 'point': point,
      if (value != null) 'value': value,
      if (unit != null) 'unit': unit,
      if (notes != null) 'notes': notes,
      if (unpoweredOnly != null) 'unpowered_only': unpoweredOnly,
    });
  }

  MeasurementNotebookCompanion copyWith(
      {Value<int>? id,
      Value<String>? date,
      Value<String>? point,
      Value<String>? value,
      Value<String?>? unit,
      Value<String?>? notes,
      Value<bool>? unpoweredOnly}) {
    return MeasurementNotebookCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      point: point ?? this.point,
      value: value ?? this.value,
      unit: unit ?? this.unit,
      notes: notes ?? this.notes,
      unpoweredOnly: unpoweredOnly ?? this.unpoweredOnly,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    if (point.present) {
      map['point'] = Variable<String>(point.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (unit.present) {
      map['unit'] = Variable<String>(unit.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (unpoweredOnly.present) {
      map['unpowered_only'] = Variable<bool>(unpoweredOnly.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MeasurementNotebookCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('point: $point, ')
          ..write('value: $value, ')
          ..write('unit: $unit, ')
          ..write('notes: $notes, ')
          ..write('unpoweredOnly: $unpoweredOnly')
          ..write(')'))
        .toString();
  }
}

class $RepairCasesTable extends RepairCases
    with TableInfo<$RepairCasesTable, RepairCase> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RepairCasesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<String> date = GeneratedColumn<String>(
      'date', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _modelMeta = const VerificationMeta('model');
  @override
  late final GeneratedColumn<String> model = GeneratedColumn<String>(
      'model', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _symptomsMeta =
      const VerificationMeta('symptoms');
  @override
  late final GeneratedColumn<String> symptoms = GeneratedColumn<String>(
      'symptoms', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _diagnosisMeta =
      const VerificationMeta('diagnosis');
  @override
  late final GeneratedColumn<String> diagnosis = GeneratedColumn<String>(
      'diagnosis', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _workflowMeta =
      const VerificationMeta('workflow');
  @override
  late final GeneratedColumn<String> workflow = GeneratedColumn<String>(
      'workflow', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _partsMeta = const VerificationMeta('parts');
  @override
  late final GeneratedColumn<String> parts = GeneratedColumn<String>(
      'parts', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _outcomeMeta =
      const VerificationMeta('outcome');
  @override
  late final GeneratedColumn<String> outcome = GeneratedColumn<String>(
      'outcome', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _photoPathMeta =
      const VerificationMeta('photoPath');
  @override
  late final GeneratedColumn<String> photoPath = GeneratedColumn<String>(
      'photo_path', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        date,
        model,
        symptoms,
        diagnosis,
        workflow,
        parts,
        outcome,
        photoPath,
        notes
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'repair_cases';
  @override
  VerificationContext validateIntegrity(Insertable<RepairCase> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('model')) {
      context.handle(
          _modelMeta, model.isAcceptableOrUnknown(data['model']!, _modelMeta));
    } else if (isInserting) {
      context.missing(_modelMeta);
    }
    if (data.containsKey('symptoms')) {
      context.handle(_symptomsMeta,
          symptoms.isAcceptableOrUnknown(data['symptoms']!, _symptomsMeta));
    } else if (isInserting) {
      context.missing(_symptomsMeta);
    }
    if (data.containsKey('diagnosis')) {
      context.handle(_diagnosisMeta,
          diagnosis.isAcceptableOrUnknown(data['diagnosis']!, _diagnosisMeta));
    }
    if (data.containsKey('workflow')) {
      context.handle(_workflowMeta,
          workflow.isAcceptableOrUnknown(data['workflow']!, _workflowMeta));
    }
    if (data.containsKey('parts')) {
      context.handle(
          _partsMeta, parts.isAcceptableOrUnknown(data['parts']!, _partsMeta));
    }
    if (data.containsKey('outcome')) {
      context.handle(_outcomeMeta,
          outcome.isAcceptableOrUnknown(data['outcome']!, _outcomeMeta));
    }
    if (data.containsKey('photo_path')) {
      context.handle(_photoPathMeta,
          photoPath.isAcceptableOrUnknown(data['photo_path']!, _photoPathMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RepairCase map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RepairCase(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}date'])!,
      model: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}model'])!,
      symptoms: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}symptoms'])!,
      diagnosis: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}diagnosis']),
      workflow: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}workflow']),
      parts: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}parts']),
      outcome: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}outcome']),
      photoPath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}photo_path']),
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
    );
  }

  @override
  $RepairCasesTable createAlias(String alias) {
    return $RepairCasesTable(attachedDatabase, alias);
  }
}

class RepairCase extends DataClass implements Insertable<RepairCase> {
  final int id;
  final String date;
  final String model;
  final String symptoms;
  final String? diagnosis;
  final String? workflow;
  final String? parts;
  final String? outcome;
  final String? photoPath;
  final String? notes;
  const RepairCase(
      {required this.id,
      required this.date,
      required this.model,
      required this.symptoms,
      this.diagnosis,
      this.workflow,
      this.parts,
      this.outcome,
      this.photoPath,
      this.notes});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['date'] = Variable<String>(date);
    map['model'] = Variable<String>(model);
    map['symptoms'] = Variable<String>(symptoms);
    if (!nullToAbsent || diagnosis != null) {
      map['diagnosis'] = Variable<String>(diagnosis);
    }
    if (!nullToAbsent || workflow != null) {
      map['workflow'] = Variable<String>(workflow);
    }
    if (!nullToAbsent || parts != null) {
      map['parts'] = Variable<String>(parts);
    }
    if (!nullToAbsent || outcome != null) {
      map['outcome'] = Variable<String>(outcome);
    }
    if (!nullToAbsent || photoPath != null) {
      map['photo_path'] = Variable<String>(photoPath);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  RepairCasesCompanion toCompanion(bool nullToAbsent) {
    return RepairCasesCompanion(
      id: Value(id),
      date: Value(date),
      model: Value(model),
      symptoms: Value(symptoms),
      diagnosis: diagnosis == null && nullToAbsent
          ? const Value.absent()
          : Value(diagnosis),
      workflow: workflow == null && nullToAbsent
          ? const Value.absent()
          : Value(workflow),
      parts:
          parts == null && nullToAbsent ? const Value.absent() : Value(parts),
      outcome: outcome == null && nullToAbsent
          ? const Value.absent()
          : Value(outcome),
      photoPath: photoPath == null && nullToAbsent
          ? const Value.absent()
          : Value(photoPath),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
    );
  }

  factory RepairCase.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RepairCase(
      id: serializer.fromJson<int>(json['id']),
      date: serializer.fromJson<String>(json['date']),
      model: serializer.fromJson<String>(json['model']),
      symptoms: serializer.fromJson<String>(json['symptoms']),
      diagnosis: serializer.fromJson<String?>(json['diagnosis']),
      workflow: serializer.fromJson<String?>(json['workflow']),
      parts: serializer.fromJson<String?>(json['parts']),
      outcome: serializer.fromJson<String?>(json['outcome']),
      photoPath: serializer.fromJson<String?>(json['photoPath']),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'date': serializer.toJson<String>(date),
      'model': serializer.toJson<String>(model),
      'symptoms': serializer.toJson<String>(symptoms),
      'diagnosis': serializer.toJson<String?>(diagnosis),
      'workflow': serializer.toJson<String?>(workflow),
      'parts': serializer.toJson<String?>(parts),
      'outcome': serializer.toJson<String?>(outcome),
      'photoPath': serializer.toJson<String?>(photoPath),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  RepairCase copyWith(
          {int? id,
          String? date,
          String? model,
          String? symptoms,
          Value<String?> diagnosis = const Value.absent(),
          Value<String?> workflow = const Value.absent(),
          Value<String?> parts = const Value.absent(),
          Value<String?> outcome = const Value.absent(),
          Value<String?> photoPath = const Value.absent(),
          Value<String?> notes = const Value.absent()}) =>
      RepairCase(
        id: id ?? this.id,
        date: date ?? this.date,
        model: model ?? this.model,
        symptoms: symptoms ?? this.symptoms,
        diagnosis: diagnosis.present ? diagnosis.value : this.diagnosis,
        workflow: workflow.present ? workflow.value : this.workflow,
        parts: parts.present ? parts.value : this.parts,
        outcome: outcome.present ? outcome.value : this.outcome,
        photoPath: photoPath.present ? photoPath.value : this.photoPath,
        notes: notes.present ? notes.value : this.notes,
      );
  RepairCase copyWithCompanion(RepairCasesCompanion data) {
    return RepairCase(
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
      model: data.model.present ? data.model.value : this.model,
      symptoms: data.symptoms.present ? data.symptoms.value : this.symptoms,
      diagnosis: data.diagnosis.present ? data.diagnosis.value : this.diagnosis,
      workflow: data.workflow.present ? data.workflow.value : this.workflow,
      parts: data.parts.present ? data.parts.value : this.parts,
      outcome: data.outcome.present ? data.outcome.value : this.outcome,
      photoPath: data.photoPath.present ? data.photoPath.value : this.photoPath,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RepairCase(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('model: $model, ')
          ..write('symptoms: $symptoms, ')
          ..write('diagnosis: $diagnosis, ')
          ..write('workflow: $workflow, ')
          ..write('parts: $parts, ')
          ..write('outcome: $outcome, ')
          ..write('photoPath: $photoPath, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, date, model, symptoms, diagnosis,
      workflow, parts, outcome, photoPath, notes);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RepairCase &&
          other.id == this.id &&
          other.date == this.date &&
          other.model == this.model &&
          other.symptoms == this.symptoms &&
          other.diagnosis == this.diagnosis &&
          other.workflow == this.workflow &&
          other.parts == this.parts &&
          other.outcome == this.outcome &&
          other.photoPath == this.photoPath &&
          other.notes == this.notes);
}

class RepairCasesCompanion extends UpdateCompanion<RepairCase> {
  final Value<int> id;
  final Value<String> date;
  final Value<String> model;
  final Value<String> symptoms;
  final Value<String?> diagnosis;
  final Value<String?> workflow;
  final Value<String?> parts;
  final Value<String?> outcome;
  final Value<String?> photoPath;
  final Value<String?> notes;
  const RepairCasesCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.model = const Value.absent(),
    this.symptoms = const Value.absent(),
    this.diagnosis = const Value.absent(),
    this.workflow = const Value.absent(),
    this.parts = const Value.absent(),
    this.outcome = const Value.absent(),
    this.photoPath = const Value.absent(),
    this.notes = const Value.absent(),
  });
  RepairCasesCompanion.insert({
    this.id = const Value.absent(),
    required String date,
    required String model,
    required String symptoms,
    this.diagnosis = const Value.absent(),
    this.workflow = const Value.absent(),
    this.parts = const Value.absent(),
    this.outcome = const Value.absent(),
    this.photoPath = const Value.absent(),
    this.notes = const Value.absent(),
  })  : date = Value(date),
        model = Value(model),
        symptoms = Value(symptoms);
  static Insertable<RepairCase> custom({
    Expression<int>? id,
    Expression<String>? date,
    Expression<String>? model,
    Expression<String>? symptoms,
    Expression<String>? diagnosis,
    Expression<String>? workflow,
    Expression<String>? parts,
    Expression<String>? outcome,
    Expression<String>? photoPath,
    Expression<String>? notes,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (model != null) 'model': model,
      if (symptoms != null) 'symptoms': symptoms,
      if (diagnosis != null) 'diagnosis': diagnosis,
      if (workflow != null) 'workflow': workflow,
      if (parts != null) 'parts': parts,
      if (outcome != null) 'outcome': outcome,
      if (photoPath != null) 'photo_path': photoPath,
      if (notes != null) 'notes': notes,
    });
  }

  RepairCasesCompanion copyWith(
      {Value<int>? id,
      Value<String>? date,
      Value<String>? model,
      Value<String>? symptoms,
      Value<String?>? diagnosis,
      Value<String?>? workflow,
      Value<String?>? parts,
      Value<String?>? outcome,
      Value<String?>? photoPath,
      Value<String?>? notes}) {
    return RepairCasesCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      model: model ?? this.model,
      symptoms: symptoms ?? this.symptoms,
      diagnosis: diagnosis ?? this.diagnosis,
      workflow: workflow ?? this.workflow,
      parts: parts ?? this.parts,
      outcome: outcome ?? this.outcome,
      photoPath: photoPath ?? this.photoPath,
      notes: notes ?? this.notes,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    if (model.present) {
      map['model'] = Variable<String>(model.value);
    }
    if (symptoms.present) {
      map['symptoms'] = Variable<String>(symptoms.value);
    }
    if (diagnosis.present) {
      map['diagnosis'] = Variable<String>(diagnosis.value);
    }
    if (workflow.present) {
      map['workflow'] = Variable<String>(workflow.value);
    }
    if (parts.present) {
      map['parts'] = Variable<String>(parts.value);
    }
    if (outcome.present) {
      map['outcome'] = Variable<String>(outcome.value);
    }
    if (photoPath.present) {
      map['photo_path'] = Variable<String>(photoPath.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RepairCasesCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('model: $model, ')
          ..write('symptoms: $symptoms, ')
          ..write('diagnosis: $diagnosis, ')
          ..write('workflow: $workflow, ')
          ..write('parts: $parts, ')
          ..write('outcome: $outcome, ')
          ..write('photoPath: $photoPath, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }
}

class $AppearanceRoutinesTable extends AppearanceRoutines
    with TableInfo<$AppearanceRoutinesTable, AppearanceRoutine> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppearanceRoutinesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<String> date = GeneratedColumn<String>(
      'date', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _routineTypeMeta =
      const VerificationMeta('routineType');
  @override
  late final GeneratedColumn<String> routineType = GeneratedColumn<String>(
      'routine_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _checklistJsonMeta =
      const VerificationMeta('checklistJson');
  @override
  late final GeneratedColumn<String> checklistJson = GeneratedColumn<String>(
      'checklist_json', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('pending'));
  static const VerificationMeta _completedAtMeta =
      const VerificationMeta('completedAt');
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
      'completed_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, date, routineType, checklistJson, status, completedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'appearance_routines';
  @override
  VerificationContext validateIntegrity(Insertable<AppearanceRoutine> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('routine_type')) {
      context.handle(
          _routineTypeMeta,
          routineType.isAcceptableOrUnknown(
              data['routine_type']!, _routineTypeMeta));
    } else if (isInserting) {
      context.missing(_routineTypeMeta);
    }
    if (data.containsKey('checklist_json')) {
      context.handle(
          _checklistJsonMeta,
          checklistJson.isAcceptableOrUnknown(
              data['checklist_json']!, _checklistJsonMeta));
    } else if (isInserting) {
      context.missing(_checklistJsonMeta);
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('completed_at')) {
      context.handle(
          _completedAtMeta,
          completedAt.isAcceptableOrUnknown(
              data['completed_at']!, _completedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AppearanceRoutine map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppearanceRoutine(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}date'])!,
      routineType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}routine_type'])!,
      checklistJson: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}checklist_json'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      completedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}completed_at']),
    );
  }

  @override
  $AppearanceRoutinesTable createAlias(String alias) {
    return $AppearanceRoutinesTable(attachedDatabase, alias);
  }
}

class AppearanceRoutine extends DataClass
    implements Insertable<AppearanceRoutine> {
  final int id;
  final String date;
  final String routineType;
  final String checklistJson;
  final String status;
  final DateTime? completedAt;
  const AppearanceRoutine(
      {required this.id,
      required this.date,
      required this.routineType,
      required this.checklistJson,
      required this.status,
      this.completedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['date'] = Variable<String>(date);
    map['routine_type'] = Variable<String>(routineType);
    map['checklist_json'] = Variable<String>(checklistJson);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<DateTime>(completedAt);
    }
    return map;
  }

  AppearanceRoutinesCompanion toCompanion(bool nullToAbsent) {
    return AppearanceRoutinesCompanion(
      id: Value(id),
      date: Value(date),
      routineType: Value(routineType),
      checklistJson: Value(checklistJson),
      status: Value(status),
      completedAt: completedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(completedAt),
    );
  }

  factory AppearanceRoutine.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppearanceRoutine(
      id: serializer.fromJson<int>(json['id']),
      date: serializer.fromJson<String>(json['date']),
      routineType: serializer.fromJson<String>(json['routineType']),
      checklistJson: serializer.fromJson<String>(json['checklistJson']),
      status: serializer.fromJson<String>(json['status']),
      completedAt: serializer.fromJson<DateTime?>(json['completedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'date': serializer.toJson<String>(date),
      'routineType': serializer.toJson<String>(routineType),
      'checklistJson': serializer.toJson<String>(checklistJson),
      'status': serializer.toJson<String>(status),
      'completedAt': serializer.toJson<DateTime?>(completedAt),
    };
  }

  AppearanceRoutine copyWith(
          {int? id,
          String? date,
          String? routineType,
          String? checklistJson,
          String? status,
          Value<DateTime?> completedAt = const Value.absent()}) =>
      AppearanceRoutine(
        id: id ?? this.id,
        date: date ?? this.date,
        routineType: routineType ?? this.routineType,
        checklistJson: checklistJson ?? this.checklistJson,
        status: status ?? this.status,
        completedAt: completedAt.present ? completedAt.value : this.completedAt,
      );
  AppearanceRoutine copyWithCompanion(AppearanceRoutinesCompanion data) {
    return AppearanceRoutine(
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
      routineType:
          data.routineType.present ? data.routineType.value : this.routineType,
      checklistJson: data.checklistJson.present
          ? data.checklistJson.value
          : this.checklistJson,
      status: data.status.present ? data.status.value : this.status,
      completedAt:
          data.completedAt.present ? data.completedAt.value : this.completedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppearanceRoutine(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('routineType: $routineType, ')
          ..write('checklistJson: $checklistJson, ')
          ..write('status: $status, ')
          ..write('completedAt: $completedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, date, routineType, checklistJson, status, completedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppearanceRoutine &&
          other.id == this.id &&
          other.date == this.date &&
          other.routineType == this.routineType &&
          other.checklistJson == this.checklistJson &&
          other.status == this.status &&
          other.completedAt == this.completedAt);
}

class AppearanceRoutinesCompanion extends UpdateCompanion<AppearanceRoutine> {
  final Value<int> id;
  final Value<String> date;
  final Value<String> routineType;
  final Value<String> checklistJson;
  final Value<String> status;
  final Value<DateTime?> completedAt;
  const AppearanceRoutinesCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.routineType = const Value.absent(),
    this.checklistJson = const Value.absent(),
    this.status = const Value.absent(),
    this.completedAt = const Value.absent(),
  });
  AppearanceRoutinesCompanion.insert({
    this.id = const Value.absent(),
    required String date,
    required String routineType,
    required String checklistJson,
    this.status = const Value.absent(),
    this.completedAt = const Value.absent(),
  })  : date = Value(date),
        routineType = Value(routineType),
        checklistJson = Value(checklistJson);
  static Insertable<AppearanceRoutine> custom({
    Expression<int>? id,
    Expression<String>? date,
    Expression<String>? routineType,
    Expression<String>? checklistJson,
    Expression<String>? status,
    Expression<DateTime>? completedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (routineType != null) 'routine_type': routineType,
      if (checklistJson != null) 'checklist_json': checklistJson,
      if (status != null) 'status': status,
      if (completedAt != null) 'completed_at': completedAt,
    });
  }

  AppearanceRoutinesCompanion copyWith(
      {Value<int>? id,
      Value<String>? date,
      Value<String>? routineType,
      Value<String>? checklistJson,
      Value<String>? status,
      Value<DateTime?>? completedAt}) {
    return AppearanceRoutinesCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      routineType: routineType ?? this.routineType,
      checklistJson: checklistJson ?? this.checklistJson,
      status: status ?? this.status,
      completedAt: completedAt ?? this.completedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    if (routineType.present) {
      map['routine_type'] = Variable<String>(routineType.value);
    }
    if (checklistJson.present) {
      map['checklist_json'] = Variable<String>(checklistJson.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppearanceRoutinesCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('routineType: $routineType, ')
          ..write('checklistJson: $checklistJson, ')
          ..write('status: $status, ')
          ..write('completedAt: $completedAt')
          ..write(')'))
        .toString();
  }
}

class $AppearanceProductsTable extends AppearanceProducts
    with TableInfo<$AppearanceProductsTable, AppearanceProduct> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppearanceProductsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _categoryMeta =
      const VerificationMeta('category');
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
      'category', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _brandMeta = const VerificationMeta('brand');
  @override
  late final GeneratedColumn<String> brand = GeneratedColumn<String>(
      'brand', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _priceMadMeta =
      const VerificationMeta('priceMad');
  @override
  late final GeneratedColumn<double> priceMad = GeneratedColumn<double>(
      'price_mad', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _ownedMeta = const VerificationMeta('owned');
  @override
  late final GeneratedColumn<bool> owned = GeneratedColumn<bool>(
      'owned', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("owned" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, category, brand, priceMad, owned, notes];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'appearance_products';
  @override
  VerificationContext validateIntegrity(Insertable<AppearanceProduct> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('brand')) {
      context.handle(
          _brandMeta, brand.isAcceptableOrUnknown(data['brand']!, _brandMeta));
    }
    if (data.containsKey('price_mad')) {
      context.handle(_priceMadMeta,
          priceMad.isAcceptableOrUnknown(data['price_mad']!, _priceMadMeta));
    }
    if (data.containsKey('owned')) {
      context.handle(
          _ownedMeta, owned.isAcceptableOrUnknown(data['owned']!, _ownedMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AppearanceProduct map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppearanceProduct(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      category: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category'])!,
      brand: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}brand']),
      priceMad: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}price_mad']),
      owned: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}owned'])!,
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
    );
  }

  @override
  $AppearanceProductsTable createAlias(String alias) {
    return $AppearanceProductsTable(attachedDatabase, alias);
  }
}

class AppearanceProduct extends DataClass
    implements Insertable<AppearanceProduct> {
  final int id;
  final String name;
  final String category;
  final String? brand;
  final double? priceMad;
  final bool owned;
  final String? notes;
  const AppearanceProduct(
      {required this.id,
      required this.name,
      required this.category,
      this.brand,
      this.priceMad,
      required this.owned,
      this.notes});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['category'] = Variable<String>(category);
    if (!nullToAbsent || brand != null) {
      map['brand'] = Variable<String>(brand);
    }
    if (!nullToAbsent || priceMad != null) {
      map['price_mad'] = Variable<double>(priceMad);
    }
    map['owned'] = Variable<bool>(owned);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  AppearanceProductsCompanion toCompanion(bool nullToAbsent) {
    return AppearanceProductsCompanion(
      id: Value(id),
      name: Value(name),
      category: Value(category),
      brand:
          brand == null && nullToAbsent ? const Value.absent() : Value(brand),
      priceMad: priceMad == null && nullToAbsent
          ? const Value.absent()
          : Value(priceMad),
      owned: Value(owned),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
    );
  }

  factory AppearanceProduct.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppearanceProduct(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      category: serializer.fromJson<String>(json['category']),
      brand: serializer.fromJson<String?>(json['brand']),
      priceMad: serializer.fromJson<double?>(json['priceMad']),
      owned: serializer.fromJson<bool>(json['owned']),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'category': serializer.toJson<String>(category),
      'brand': serializer.toJson<String?>(brand),
      'priceMad': serializer.toJson<double?>(priceMad),
      'owned': serializer.toJson<bool>(owned),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  AppearanceProduct copyWith(
          {int? id,
          String? name,
          String? category,
          Value<String?> brand = const Value.absent(),
          Value<double?> priceMad = const Value.absent(),
          bool? owned,
          Value<String?> notes = const Value.absent()}) =>
      AppearanceProduct(
        id: id ?? this.id,
        name: name ?? this.name,
        category: category ?? this.category,
        brand: brand.present ? brand.value : this.brand,
        priceMad: priceMad.present ? priceMad.value : this.priceMad,
        owned: owned ?? this.owned,
        notes: notes.present ? notes.value : this.notes,
      );
  AppearanceProduct copyWithCompanion(AppearanceProductsCompanion data) {
    return AppearanceProduct(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      category: data.category.present ? data.category.value : this.category,
      brand: data.brand.present ? data.brand.value : this.brand,
      priceMad: data.priceMad.present ? data.priceMad.value : this.priceMad,
      owned: data.owned.present ? data.owned.value : this.owned,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppearanceProduct(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('category: $category, ')
          ..write('brand: $brand, ')
          ..write('priceMad: $priceMad, ')
          ..write('owned: $owned, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, category, brand, priceMad, owned, notes);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppearanceProduct &&
          other.id == this.id &&
          other.name == this.name &&
          other.category == this.category &&
          other.brand == this.brand &&
          other.priceMad == this.priceMad &&
          other.owned == this.owned &&
          other.notes == this.notes);
}

class AppearanceProductsCompanion extends UpdateCompanion<AppearanceProduct> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> category;
  final Value<String?> brand;
  final Value<double?> priceMad;
  final Value<bool> owned;
  final Value<String?> notes;
  const AppearanceProductsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.category = const Value.absent(),
    this.brand = const Value.absent(),
    this.priceMad = const Value.absent(),
    this.owned = const Value.absent(),
    this.notes = const Value.absent(),
  });
  AppearanceProductsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String category,
    this.brand = const Value.absent(),
    this.priceMad = const Value.absent(),
    this.owned = const Value.absent(),
    this.notes = const Value.absent(),
  })  : name = Value(name),
        category = Value(category);
  static Insertable<AppearanceProduct> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? category,
    Expression<String>? brand,
    Expression<double>? priceMad,
    Expression<bool>? owned,
    Expression<String>? notes,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (category != null) 'category': category,
      if (brand != null) 'brand': brand,
      if (priceMad != null) 'price_mad': priceMad,
      if (owned != null) 'owned': owned,
      if (notes != null) 'notes': notes,
    });
  }

  AppearanceProductsCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String>? category,
      Value<String?>? brand,
      Value<double?>? priceMad,
      Value<bool>? owned,
      Value<String?>? notes}) {
    return AppearanceProductsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      brand: brand ?? this.brand,
      priceMad: priceMad ?? this.priceMad,
      owned: owned ?? this.owned,
      notes: notes ?? this.notes,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (brand.present) {
      map['brand'] = Variable<String>(brand.value);
    }
    if (priceMad.present) {
      map['price_mad'] = Variable<double>(priceMad.value);
    }
    if (owned.present) {
      map['owned'] = Variable<bool>(owned.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppearanceProductsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('category: $category, ')
          ..write('brand: $brand, ')
          ..write('priceMad: $priceMad, ')
          ..write('owned: $owned, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }
}

class $AppearancePhotosTable extends AppearancePhotos
    with TableInfo<$AppearancePhotosTable, AppearancePhoto> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppearancePhotosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<String> date = GeneratedColumn<String>(
      'date', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _angleMeta = const VerificationMeta('angle');
  @override
  late final GeneratedColumn<String> angle = GeneratedColumn<String>(
      'angle', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _filePathMeta =
      const VerificationMeta('filePath');
  @override
  late final GeneratedColumn<String> filePath = GeneratedColumn<String>(
      'file_path', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [id, date, angle, filePath, notes];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'appearance_photos';
  @override
  VerificationContext validateIntegrity(Insertable<AppearancePhoto> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('angle')) {
      context.handle(
          _angleMeta, angle.isAcceptableOrUnknown(data['angle']!, _angleMeta));
    } else if (isInserting) {
      context.missing(_angleMeta);
    }
    if (data.containsKey('file_path')) {
      context.handle(_filePathMeta,
          filePath.isAcceptableOrUnknown(data['file_path']!, _filePathMeta));
    } else if (isInserting) {
      context.missing(_filePathMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AppearancePhoto map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppearancePhoto(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}date'])!,
      angle: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}angle'])!,
      filePath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}file_path'])!,
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
    );
  }

  @override
  $AppearancePhotosTable createAlias(String alias) {
    return $AppearancePhotosTable(attachedDatabase, alias);
  }
}

class AppearancePhoto extends DataClass implements Insertable<AppearancePhoto> {
  final int id;
  final String date;
  final String angle;
  final String filePath;
  final String? notes;
  const AppearancePhoto(
      {required this.id,
      required this.date,
      required this.angle,
      required this.filePath,
      this.notes});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['date'] = Variable<String>(date);
    map['angle'] = Variable<String>(angle);
    map['file_path'] = Variable<String>(filePath);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  AppearancePhotosCompanion toCompanion(bool nullToAbsent) {
    return AppearancePhotosCompanion(
      id: Value(id),
      date: Value(date),
      angle: Value(angle),
      filePath: Value(filePath),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
    );
  }

  factory AppearancePhoto.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppearancePhoto(
      id: serializer.fromJson<int>(json['id']),
      date: serializer.fromJson<String>(json['date']),
      angle: serializer.fromJson<String>(json['angle']),
      filePath: serializer.fromJson<String>(json['filePath']),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'date': serializer.toJson<String>(date),
      'angle': serializer.toJson<String>(angle),
      'filePath': serializer.toJson<String>(filePath),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  AppearancePhoto copyWith(
          {int? id,
          String? date,
          String? angle,
          String? filePath,
          Value<String?> notes = const Value.absent()}) =>
      AppearancePhoto(
        id: id ?? this.id,
        date: date ?? this.date,
        angle: angle ?? this.angle,
        filePath: filePath ?? this.filePath,
        notes: notes.present ? notes.value : this.notes,
      );
  AppearancePhoto copyWithCompanion(AppearancePhotosCompanion data) {
    return AppearancePhoto(
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
      angle: data.angle.present ? data.angle.value : this.angle,
      filePath: data.filePath.present ? data.filePath.value : this.filePath,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppearancePhoto(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('angle: $angle, ')
          ..write('filePath: $filePath, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, date, angle, filePath, notes);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppearancePhoto &&
          other.id == this.id &&
          other.date == this.date &&
          other.angle == this.angle &&
          other.filePath == this.filePath &&
          other.notes == this.notes);
}

class AppearancePhotosCompanion extends UpdateCompanion<AppearancePhoto> {
  final Value<int> id;
  final Value<String> date;
  final Value<String> angle;
  final Value<String> filePath;
  final Value<String?> notes;
  const AppearancePhotosCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.angle = const Value.absent(),
    this.filePath = const Value.absent(),
    this.notes = const Value.absent(),
  });
  AppearancePhotosCompanion.insert({
    this.id = const Value.absent(),
    required String date,
    required String angle,
    required String filePath,
    this.notes = const Value.absent(),
  })  : date = Value(date),
        angle = Value(angle),
        filePath = Value(filePath);
  static Insertable<AppearancePhoto> custom({
    Expression<int>? id,
    Expression<String>? date,
    Expression<String>? angle,
    Expression<String>? filePath,
    Expression<String>? notes,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (angle != null) 'angle': angle,
      if (filePath != null) 'file_path': filePath,
      if (notes != null) 'notes': notes,
    });
  }

  AppearancePhotosCompanion copyWith(
      {Value<int>? id,
      Value<String>? date,
      Value<String>? angle,
      Value<String>? filePath,
      Value<String?>? notes}) {
    return AppearancePhotosCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      angle: angle ?? this.angle,
      filePath: filePath ?? this.filePath,
      notes: notes ?? this.notes,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    if (angle.present) {
      map['angle'] = Variable<String>(angle.value);
    }
    if (filePath.present) {
      map['file_path'] = Variable<String>(filePath.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppearancePhotosCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('angle: $angle, ')
          ..write('filePath: $filePath, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }
}

class $GroomingRecordsTable extends GroomingRecords
    with TableInfo<$GroomingRecordsTable, GroomingRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GroomingRecordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<String> date = GeneratedColumn<String>(
      'date', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _detailsMeta =
      const VerificationMeta('details');
  @override
  late final GeneratedColumn<String> details = GeneratedColumn<String>(
      'details', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _conditionMeta =
      const VerificationMeta('condition');
  @override
  late final GeneratedColumn<String> condition = GeneratedColumn<String>(
      'condition', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [id, date, type, details, condition];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'grooming_records';
  @override
  VerificationContext validateIntegrity(Insertable<GroomingRecord> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('details')) {
      context.handle(_detailsMeta,
          details.isAcceptableOrUnknown(data['details']!, _detailsMeta));
    } else if (isInserting) {
      context.missing(_detailsMeta);
    }
    if (data.containsKey('condition')) {
      context.handle(_conditionMeta,
          condition.isAcceptableOrUnknown(data['condition']!, _conditionMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GroomingRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GroomingRecord(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}date'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      details: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}details'])!,
      condition: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}condition']),
    );
  }

  @override
  $GroomingRecordsTable createAlias(String alias) {
    return $GroomingRecordsTable(attachedDatabase, alias);
  }
}

class GroomingRecord extends DataClass implements Insertable<GroomingRecord> {
  final int id;
  final String date;
  final String type;
  final String details;
  final String? condition;
  const GroomingRecord(
      {required this.id,
      required this.date,
      required this.type,
      required this.details,
      this.condition});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['date'] = Variable<String>(date);
    map['type'] = Variable<String>(type);
    map['details'] = Variable<String>(details);
    if (!nullToAbsent || condition != null) {
      map['condition'] = Variable<String>(condition);
    }
    return map;
  }

  GroomingRecordsCompanion toCompanion(bool nullToAbsent) {
    return GroomingRecordsCompanion(
      id: Value(id),
      date: Value(date),
      type: Value(type),
      details: Value(details),
      condition: condition == null && nullToAbsent
          ? const Value.absent()
          : Value(condition),
    );
  }

  factory GroomingRecord.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GroomingRecord(
      id: serializer.fromJson<int>(json['id']),
      date: serializer.fromJson<String>(json['date']),
      type: serializer.fromJson<String>(json['type']),
      details: serializer.fromJson<String>(json['details']),
      condition: serializer.fromJson<String?>(json['condition']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'date': serializer.toJson<String>(date),
      'type': serializer.toJson<String>(type),
      'details': serializer.toJson<String>(details),
      'condition': serializer.toJson<String?>(condition),
    };
  }

  GroomingRecord copyWith(
          {int? id,
          String? date,
          String? type,
          String? details,
          Value<String?> condition = const Value.absent()}) =>
      GroomingRecord(
        id: id ?? this.id,
        date: date ?? this.date,
        type: type ?? this.type,
        details: details ?? this.details,
        condition: condition.present ? condition.value : this.condition,
      );
  GroomingRecord copyWithCompanion(GroomingRecordsCompanion data) {
    return GroomingRecord(
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
      type: data.type.present ? data.type.value : this.type,
      details: data.details.present ? data.details.value : this.details,
      condition: data.condition.present ? data.condition.value : this.condition,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GroomingRecord(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('type: $type, ')
          ..write('details: $details, ')
          ..write('condition: $condition')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, date, type, details, condition);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GroomingRecord &&
          other.id == this.id &&
          other.date == this.date &&
          other.type == this.type &&
          other.details == this.details &&
          other.condition == this.condition);
}

class GroomingRecordsCompanion extends UpdateCompanion<GroomingRecord> {
  final Value<int> id;
  final Value<String> date;
  final Value<String> type;
  final Value<String> details;
  final Value<String?> condition;
  const GroomingRecordsCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.type = const Value.absent(),
    this.details = const Value.absent(),
    this.condition = const Value.absent(),
  });
  GroomingRecordsCompanion.insert({
    this.id = const Value.absent(),
    required String date,
    required String type,
    required String details,
    this.condition = const Value.absent(),
  })  : date = Value(date),
        type = Value(type),
        details = Value(details);
  static Insertable<GroomingRecord> custom({
    Expression<int>? id,
    Expression<String>? date,
    Expression<String>? type,
    Expression<String>? details,
    Expression<String>? condition,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (type != null) 'type': type,
      if (details != null) 'details': details,
      if (condition != null) 'condition': condition,
    });
  }

  GroomingRecordsCompanion copyWith(
      {Value<int>? id,
      Value<String>? date,
      Value<String>? type,
      Value<String>? details,
      Value<String?>? condition}) {
    return GroomingRecordsCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      type: type ?? this.type,
      details: details ?? this.details,
      condition: condition ?? this.condition,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (details.present) {
      map['details'] = Variable<String>(details.value);
    }
    if (condition.present) {
      map['condition'] = Variable<String>(condition.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GroomingRecordsCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('type: $type, ')
          ..write('details: $details, ')
          ..write('condition: $condition')
          ..write(')'))
        .toString();
  }
}

class $ReviewsTable extends Reviews with TableInfo<$ReviewsTable, Review> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReviewsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<String> date = GeneratedColumn<String>(
      'date', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _contentMeta =
      const VerificationMeta('content');
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
      'content', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _consistencyScoreMeta =
      const VerificationMeta('consistencyScore');
  @override
  late final GeneratedColumn<double> consistencyScore = GeneratedColumn<double>(
      'consistency_score', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _achievementScoreMeta =
      const VerificationMeta('achievementScore');
  @override
  late final GeneratedColumn<double> achievementScore = GeneratedColumn<double>(
      'achievement_score', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, date, type, content, consistencyScore, achievementScore];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'reviews';
  @override
  VerificationContext validateIntegrity(Insertable<Review> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('content')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['content']!, _contentMeta));
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('consistency_score')) {
      context.handle(
          _consistencyScoreMeta,
          consistencyScore.isAcceptableOrUnknown(
              data['consistency_score']!, _consistencyScoreMeta));
    }
    if (data.containsKey('achievement_score')) {
      context.handle(
          _achievementScoreMeta,
          achievementScore.isAcceptableOrUnknown(
              data['achievement_score']!, _achievementScoreMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Review map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Review(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}date'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      content: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}content'])!,
      consistencyScore: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}consistency_score']),
      achievementScore: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}achievement_score']),
    );
  }

  @override
  $ReviewsTable createAlias(String alias) {
    return $ReviewsTable(attachedDatabase, alias);
  }
}

class Review extends DataClass implements Insertable<Review> {
  final int id;
  final String date;
  final String type;
  final String content;
  final double? consistencyScore;
  final double? achievementScore;
  const Review(
      {required this.id,
      required this.date,
      required this.type,
      required this.content,
      this.consistencyScore,
      this.achievementScore});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['date'] = Variable<String>(date);
    map['type'] = Variable<String>(type);
    map['content'] = Variable<String>(content);
    if (!nullToAbsent || consistencyScore != null) {
      map['consistency_score'] = Variable<double>(consistencyScore);
    }
    if (!nullToAbsent || achievementScore != null) {
      map['achievement_score'] = Variable<double>(achievementScore);
    }
    return map;
  }

  ReviewsCompanion toCompanion(bool nullToAbsent) {
    return ReviewsCompanion(
      id: Value(id),
      date: Value(date),
      type: Value(type),
      content: Value(content),
      consistencyScore: consistencyScore == null && nullToAbsent
          ? const Value.absent()
          : Value(consistencyScore),
      achievementScore: achievementScore == null && nullToAbsent
          ? const Value.absent()
          : Value(achievementScore),
    );
  }

  factory Review.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Review(
      id: serializer.fromJson<int>(json['id']),
      date: serializer.fromJson<String>(json['date']),
      type: serializer.fromJson<String>(json['type']),
      content: serializer.fromJson<String>(json['content']),
      consistencyScore: serializer.fromJson<double?>(json['consistencyScore']),
      achievementScore: serializer.fromJson<double?>(json['achievementScore']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'date': serializer.toJson<String>(date),
      'type': serializer.toJson<String>(type),
      'content': serializer.toJson<String>(content),
      'consistencyScore': serializer.toJson<double?>(consistencyScore),
      'achievementScore': serializer.toJson<double?>(achievementScore),
    };
  }

  Review copyWith(
          {int? id,
          String? date,
          String? type,
          String? content,
          Value<double?> consistencyScore = const Value.absent(),
          Value<double?> achievementScore = const Value.absent()}) =>
      Review(
        id: id ?? this.id,
        date: date ?? this.date,
        type: type ?? this.type,
        content: content ?? this.content,
        consistencyScore: consistencyScore.present
            ? consistencyScore.value
            : this.consistencyScore,
        achievementScore: achievementScore.present
            ? achievementScore.value
            : this.achievementScore,
      );
  Review copyWithCompanion(ReviewsCompanion data) {
    return Review(
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
      type: data.type.present ? data.type.value : this.type,
      content: data.content.present ? data.content.value : this.content,
      consistencyScore: data.consistencyScore.present
          ? data.consistencyScore.value
          : this.consistencyScore,
      achievementScore: data.achievementScore.present
          ? data.achievementScore.value
          : this.achievementScore,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Review(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('type: $type, ')
          ..write('content: $content, ')
          ..write('consistencyScore: $consistencyScore, ')
          ..write('achievementScore: $achievementScore')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, date, type, content, consistencyScore, achievementScore);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Review &&
          other.id == this.id &&
          other.date == this.date &&
          other.type == this.type &&
          other.content == this.content &&
          other.consistencyScore == this.consistencyScore &&
          other.achievementScore == this.achievementScore);
}

class ReviewsCompanion extends UpdateCompanion<Review> {
  final Value<int> id;
  final Value<String> date;
  final Value<String> type;
  final Value<String> content;
  final Value<double?> consistencyScore;
  final Value<double?> achievementScore;
  const ReviewsCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.type = const Value.absent(),
    this.content = const Value.absent(),
    this.consistencyScore = const Value.absent(),
    this.achievementScore = const Value.absent(),
  });
  ReviewsCompanion.insert({
    this.id = const Value.absent(),
    required String date,
    required String type,
    required String content,
    this.consistencyScore = const Value.absent(),
    this.achievementScore = const Value.absent(),
  })  : date = Value(date),
        type = Value(type),
        content = Value(content);
  static Insertable<Review> custom({
    Expression<int>? id,
    Expression<String>? date,
    Expression<String>? type,
    Expression<String>? content,
    Expression<double>? consistencyScore,
    Expression<double>? achievementScore,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (type != null) 'type': type,
      if (content != null) 'content': content,
      if (consistencyScore != null) 'consistency_score': consistencyScore,
      if (achievementScore != null) 'achievement_score': achievementScore,
    });
  }

  ReviewsCompanion copyWith(
      {Value<int>? id,
      Value<String>? date,
      Value<String>? type,
      Value<String>? content,
      Value<double?>? consistencyScore,
      Value<double?>? achievementScore}) {
    return ReviewsCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      type: type ?? this.type,
      content: content ?? this.content,
      consistencyScore: consistencyScore ?? this.consistencyScore,
      achievementScore: achievementScore ?? this.achievementScore,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (consistencyScore.present) {
      map['consistency_score'] = Variable<double>(consistencyScore.value);
    }
    if (achievementScore.present) {
      map['achievement_score'] = Variable<double>(achievementScore.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReviewsCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('type: $type, ')
          ..write('content: $content, ')
          ..write('consistencyScore: $consistencyScore, ')
          ..write('achievementScore: $achievementScore')
          ..write(')'))
        .toString();
  }
}

class $AchievementsTable extends Achievements
    with TableInfo<$AchievementsTable, Achievement> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AchievementsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
      'code', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _unlockedAtMeta =
      const VerificationMeta('unlockedAt');
  @override
  late final GeneratedColumn<DateTime> unlockedAt = GeneratedColumn<DateTime>(
      'unlocked_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _unlockedMeta =
      const VerificationMeta('unlocked');
  @override
  late final GeneratedColumn<bool> unlocked = GeneratedColumn<bool>(
      'unlocked', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("unlocked" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns =>
      [id, code, title, description, unlockedAt, unlocked];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'achievements';
  @override
  VerificationContext validateIntegrity(Insertable<Achievement> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('code')) {
      context.handle(
          _codeMeta, code.isAcceptableOrUnknown(data['code']!, _codeMeta));
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('unlocked_at')) {
      context.handle(
          _unlockedAtMeta,
          unlockedAt.isAcceptableOrUnknown(
              data['unlocked_at']!, _unlockedAtMeta));
    }
    if (data.containsKey('unlocked')) {
      context.handle(_unlockedMeta,
          unlocked.isAcceptableOrUnknown(data['unlocked']!, _unlockedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Achievement map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Achievement(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      code: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}code'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
      unlockedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}unlocked_at']),
      unlocked: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}unlocked'])!,
    );
  }

  @override
  $AchievementsTable createAlias(String alias) {
    return $AchievementsTable(attachedDatabase, alias);
  }
}

class Achievement extends DataClass implements Insertable<Achievement> {
  final int id;
  final String code;
  final String title;
  final String description;
  final DateTime? unlockedAt;
  final bool unlocked;
  const Achievement(
      {required this.id,
      required this.code,
      required this.title,
      required this.description,
      this.unlockedAt,
      required this.unlocked});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['code'] = Variable<String>(code);
    map['title'] = Variable<String>(title);
    map['description'] = Variable<String>(description);
    if (!nullToAbsent || unlockedAt != null) {
      map['unlocked_at'] = Variable<DateTime>(unlockedAt);
    }
    map['unlocked'] = Variable<bool>(unlocked);
    return map;
  }

  AchievementsCompanion toCompanion(bool nullToAbsent) {
    return AchievementsCompanion(
      id: Value(id),
      code: Value(code),
      title: Value(title),
      description: Value(description),
      unlockedAt: unlockedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(unlockedAt),
      unlocked: Value(unlocked),
    );
  }

  factory Achievement.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Achievement(
      id: serializer.fromJson<int>(json['id']),
      code: serializer.fromJson<String>(json['code']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String>(json['description']),
      unlockedAt: serializer.fromJson<DateTime?>(json['unlockedAt']),
      unlocked: serializer.fromJson<bool>(json['unlocked']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'code': serializer.toJson<String>(code),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String>(description),
      'unlockedAt': serializer.toJson<DateTime?>(unlockedAt),
      'unlocked': serializer.toJson<bool>(unlocked),
    };
  }

  Achievement copyWith(
          {int? id,
          String? code,
          String? title,
          String? description,
          Value<DateTime?> unlockedAt = const Value.absent(),
          bool? unlocked}) =>
      Achievement(
        id: id ?? this.id,
        code: code ?? this.code,
        title: title ?? this.title,
        description: description ?? this.description,
        unlockedAt: unlockedAt.present ? unlockedAt.value : this.unlockedAt,
        unlocked: unlocked ?? this.unlocked,
      );
  Achievement copyWithCompanion(AchievementsCompanion data) {
    return Achievement(
      id: data.id.present ? data.id.value : this.id,
      code: data.code.present ? data.code.value : this.code,
      title: data.title.present ? data.title.value : this.title,
      description:
          data.description.present ? data.description.value : this.description,
      unlockedAt:
          data.unlockedAt.present ? data.unlockedAt.value : this.unlockedAt,
      unlocked: data.unlocked.present ? data.unlocked.value : this.unlocked,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Achievement(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('unlockedAt: $unlockedAt, ')
          ..write('unlocked: $unlocked')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, code, title, description, unlockedAt, unlocked);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Achievement &&
          other.id == this.id &&
          other.code == this.code &&
          other.title == this.title &&
          other.description == this.description &&
          other.unlockedAt == this.unlockedAt &&
          other.unlocked == this.unlocked);
}

class AchievementsCompanion extends UpdateCompanion<Achievement> {
  final Value<int> id;
  final Value<String> code;
  final Value<String> title;
  final Value<String> description;
  final Value<DateTime?> unlockedAt;
  final Value<bool> unlocked;
  const AchievementsCompanion({
    this.id = const Value.absent(),
    this.code = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.unlockedAt = const Value.absent(),
    this.unlocked = const Value.absent(),
  });
  AchievementsCompanion.insert({
    this.id = const Value.absent(),
    required String code,
    required String title,
    required String description,
    this.unlockedAt = const Value.absent(),
    this.unlocked = const Value.absent(),
  })  : code = Value(code),
        title = Value(title),
        description = Value(description);
  static Insertable<Achievement> custom({
    Expression<int>? id,
    Expression<String>? code,
    Expression<String>? title,
    Expression<String>? description,
    Expression<DateTime>? unlockedAt,
    Expression<bool>? unlocked,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (code != null) 'code': code,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (unlockedAt != null) 'unlocked_at': unlockedAt,
      if (unlocked != null) 'unlocked': unlocked,
    });
  }

  AchievementsCompanion copyWith(
      {Value<int>? id,
      Value<String>? code,
      Value<String>? title,
      Value<String>? description,
      Value<DateTime?>? unlockedAt,
      Value<bool>? unlocked}) {
    return AchievementsCompanion(
      id: id ?? this.id,
      code: code ?? this.code,
      title: title ?? this.title,
      description: description ?? this.description,
      unlockedAt: unlockedAt ?? this.unlockedAt,
      unlocked: unlocked ?? this.unlocked,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (unlockedAt.present) {
      map['unlocked_at'] = Variable<DateTime>(unlockedAt.value);
    }
    if (unlocked.present) {
      map['unlocked'] = Variable<bool>(unlocked.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AchievementsCompanion(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('unlockedAt: $unlockedAt, ')
          ..write('unlocked: $unlocked')
          ..write(')'))
        .toString();
  }
}

class $NotificationPrefsTable extends NotificationPrefs
    with TableInfo<$NotificationPrefsTable, NotificationPref> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NotificationPrefsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
      'key', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _bodyMeta = const VerificationMeta('body');
  @override
  late final GeneratedColumn<String> body = GeneratedColumn<String>(
      'body', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _timeHhMmMeta =
      const VerificationMeta('timeHhMm');
  @override
  late final GeneratedColumn<String> timeHhMm = GeneratedColumn<String>(
      'time_hh_mm', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _enabledMeta =
      const VerificationMeta('enabled');
  @override
  late final GeneratedColumn<bool> enabled = GeneratedColumn<bool>(
      'enabled', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("enabled" IN (0, 1))'),
      defaultValue: const Constant(true));
  @override
  List<GeneratedColumn> get $columns =>
      [id, key, title, body, timeHhMm, enabled];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'notification_prefs';
  @override
  VerificationContext validateIntegrity(Insertable<NotificationPref> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('key')) {
      context.handle(
          _keyMeta, key.isAcceptableOrUnknown(data['key']!, _keyMeta));
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('body')) {
      context.handle(
          _bodyMeta, body.isAcceptableOrUnknown(data['body']!, _bodyMeta));
    } else if (isInserting) {
      context.missing(_bodyMeta);
    }
    if (data.containsKey('time_hh_mm')) {
      context.handle(_timeHhMmMeta,
          timeHhMm.isAcceptableOrUnknown(data['time_hh_mm']!, _timeHhMmMeta));
    } else if (isInserting) {
      context.missing(_timeHhMmMeta);
    }
    if (data.containsKey('enabled')) {
      context.handle(_enabledMeta,
          enabled.isAcceptableOrUnknown(data['enabled']!, _enabledMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  NotificationPref map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NotificationPref(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      key: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}key'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      body: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}body'])!,
      timeHhMm: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}time_hh_mm'])!,
      enabled: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}enabled'])!,
    );
  }

  @override
  $NotificationPrefsTable createAlias(String alias) {
    return $NotificationPrefsTable(attachedDatabase, alias);
  }
}

class NotificationPref extends DataClass
    implements Insertable<NotificationPref> {
  final int id;
  final String key;
  final String title;
  final String body;
  final String timeHhMm;
  final bool enabled;
  const NotificationPref(
      {required this.id,
      required this.key,
      required this.title,
      required this.body,
      required this.timeHhMm,
      required this.enabled});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['key'] = Variable<String>(key);
    map['title'] = Variable<String>(title);
    map['body'] = Variable<String>(body);
    map['time_hh_mm'] = Variable<String>(timeHhMm);
    map['enabled'] = Variable<bool>(enabled);
    return map;
  }

  NotificationPrefsCompanion toCompanion(bool nullToAbsent) {
    return NotificationPrefsCompanion(
      id: Value(id),
      key: Value(key),
      title: Value(title),
      body: Value(body),
      timeHhMm: Value(timeHhMm),
      enabled: Value(enabled),
    );
  }

  factory NotificationPref.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NotificationPref(
      id: serializer.fromJson<int>(json['id']),
      key: serializer.fromJson<String>(json['key']),
      title: serializer.fromJson<String>(json['title']),
      body: serializer.fromJson<String>(json['body']),
      timeHhMm: serializer.fromJson<String>(json['timeHhMm']),
      enabled: serializer.fromJson<bool>(json['enabled']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'key': serializer.toJson<String>(key),
      'title': serializer.toJson<String>(title),
      'body': serializer.toJson<String>(body),
      'timeHhMm': serializer.toJson<String>(timeHhMm),
      'enabled': serializer.toJson<bool>(enabled),
    };
  }

  NotificationPref copyWith(
          {int? id,
          String? key,
          String? title,
          String? body,
          String? timeHhMm,
          bool? enabled}) =>
      NotificationPref(
        id: id ?? this.id,
        key: key ?? this.key,
        title: title ?? this.title,
        body: body ?? this.body,
        timeHhMm: timeHhMm ?? this.timeHhMm,
        enabled: enabled ?? this.enabled,
      );
  NotificationPref copyWithCompanion(NotificationPrefsCompanion data) {
    return NotificationPref(
      id: data.id.present ? data.id.value : this.id,
      key: data.key.present ? data.key.value : this.key,
      title: data.title.present ? data.title.value : this.title,
      body: data.body.present ? data.body.value : this.body,
      timeHhMm: data.timeHhMm.present ? data.timeHhMm.value : this.timeHhMm,
      enabled: data.enabled.present ? data.enabled.value : this.enabled,
    );
  }

  @override
  String toString() {
    return (StringBuffer('NotificationPref(')
          ..write('id: $id, ')
          ..write('key: $key, ')
          ..write('title: $title, ')
          ..write('body: $body, ')
          ..write('timeHhMm: $timeHhMm, ')
          ..write('enabled: $enabled')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, key, title, body, timeHhMm, enabled);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NotificationPref &&
          other.id == this.id &&
          other.key == this.key &&
          other.title == this.title &&
          other.body == this.body &&
          other.timeHhMm == this.timeHhMm &&
          other.enabled == this.enabled);
}

class NotificationPrefsCompanion extends UpdateCompanion<NotificationPref> {
  final Value<int> id;
  final Value<String> key;
  final Value<String> title;
  final Value<String> body;
  final Value<String> timeHhMm;
  final Value<bool> enabled;
  const NotificationPrefsCompanion({
    this.id = const Value.absent(),
    this.key = const Value.absent(),
    this.title = const Value.absent(),
    this.body = const Value.absent(),
    this.timeHhMm = const Value.absent(),
    this.enabled = const Value.absent(),
  });
  NotificationPrefsCompanion.insert({
    this.id = const Value.absent(),
    required String key,
    required String title,
    required String body,
    required String timeHhMm,
    this.enabled = const Value.absent(),
  })  : key = Value(key),
        title = Value(title),
        body = Value(body),
        timeHhMm = Value(timeHhMm);
  static Insertable<NotificationPref> custom({
    Expression<int>? id,
    Expression<String>? key,
    Expression<String>? title,
    Expression<String>? body,
    Expression<String>? timeHhMm,
    Expression<bool>? enabled,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (key != null) 'key': key,
      if (title != null) 'title': title,
      if (body != null) 'body': body,
      if (timeHhMm != null) 'time_hh_mm': timeHhMm,
      if (enabled != null) 'enabled': enabled,
    });
  }

  NotificationPrefsCompanion copyWith(
      {Value<int>? id,
      Value<String>? key,
      Value<String>? title,
      Value<String>? body,
      Value<String>? timeHhMm,
      Value<bool>? enabled}) {
    return NotificationPrefsCompanion(
      id: id ?? this.id,
      key: key ?? this.key,
      title: title ?? this.title,
      body: body ?? this.body,
      timeHhMm: timeHhMm ?? this.timeHhMm,
      enabled: enabled ?? this.enabled,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (body.present) {
      map['body'] = Variable<String>(body.value);
    }
    if (timeHhMm.present) {
      map['time_hh_mm'] = Variable<String>(timeHhMm.value);
    }
    if (enabled.present) {
      map['enabled'] = Variable<bool>(enabled.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NotificationPrefsCompanion(')
          ..write('id: $id, ')
          ..write('key: $key, ')
          ..write('title: $title, ')
          ..write('body: $body, ')
          ..write('timeHhMm: $timeHhMm, ')
          ..write('enabled: $enabled')
          ..write(')'))
        .toString();
  }
}

class $BackupMetadataTable extends BackupMetadata
    with TableInfo<$BackupMetadataTable, BackupMetadataData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BackupMetadataTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _versionMeta =
      const VerificationMeta('version');
  @override
  late final GeneratedColumn<String> version = GeneratedColumn<String>(
      'version', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _pathMeta = const VerificationMeta('path');
  @override
  late final GeneratedColumn<String> path = GeneratedColumn<String>(
      'path', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [id, version, createdAt, path, notes];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'backup_metadata';
  @override
  VerificationContext validateIntegrity(Insertable<BackupMetadataData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('version')) {
      context.handle(_versionMeta,
          version.isAcceptableOrUnknown(data['version']!, _versionMeta));
    } else if (isInserting) {
      context.missing(_versionMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('path')) {
      context.handle(
          _pathMeta, path.isAcceptableOrUnknown(data['path']!, _pathMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BackupMetadataData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BackupMetadataData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      version: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}version'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      path: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}path']),
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
    );
  }

  @override
  $BackupMetadataTable createAlias(String alias) {
    return $BackupMetadataTable(attachedDatabase, alias);
  }
}

class BackupMetadataData extends DataClass
    implements Insertable<BackupMetadataData> {
  final int id;
  final String version;
  final DateTime createdAt;
  final String? path;
  final String? notes;
  const BackupMetadataData(
      {required this.id,
      required this.version,
      required this.createdAt,
      this.path,
      this.notes});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['version'] = Variable<String>(version);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || path != null) {
      map['path'] = Variable<String>(path);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  BackupMetadataCompanion toCompanion(bool nullToAbsent) {
    return BackupMetadataCompanion(
      id: Value(id),
      version: Value(version),
      createdAt: Value(createdAt),
      path: path == null && nullToAbsent ? const Value.absent() : Value(path),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
    );
  }

  factory BackupMetadataData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BackupMetadataData(
      id: serializer.fromJson<int>(json['id']),
      version: serializer.fromJson<String>(json['version']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      path: serializer.fromJson<String?>(json['path']),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'version': serializer.toJson<String>(version),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'path': serializer.toJson<String?>(path),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  BackupMetadataData copyWith(
          {int? id,
          String? version,
          DateTime? createdAt,
          Value<String?> path = const Value.absent(),
          Value<String?> notes = const Value.absent()}) =>
      BackupMetadataData(
        id: id ?? this.id,
        version: version ?? this.version,
        createdAt: createdAt ?? this.createdAt,
        path: path.present ? path.value : this.path,
        notes: notes.present ? notes.value : this.notes,
      );
  BackupMetadataData copyWithCompanion(BackupMetadataCompanion data) {
    return BackupMetadataData(
      id: data.id.present ? data.id.value : this.id,
      version: data.version.present ? data.version.value : this.version,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      path: data.path.present ? data.path.value : this.path,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BackupMetadataData(')
          ..write('id: $id, ')
          ..write('version: $version, ')
          ..write('createdAt: $createdAt, ')
          ..write('path: $path, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, version, createdAt, path, notes);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BackupMetadataData &&
          other.id == this.id &&
          other.version == this.version &&
          other.createdAt == this.createdAt &&
          other.path == this.path &&
          other.notes == this.notes);
}

class BackupMetadataCompanion extends UpdateCompanion<BackupMetadataData> {
  final Value<int> id;
  final Value<String> version;
  final Value<DateTime> createdAt;
  final Value<String?> path;
  final Value<String?> notes;
  const BackupMetadataCompanion({
    this.id = const Value.absent(),
    this.version = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.path = const Value.absent(),
    this.notes = const Value.absent(),
  });
  BackupMetadataCompanion.insert({
    this.id = const Value.absent(),
    required String version,
    required DateTime createdAt,
    this.path = const Value.absent(),
    this.notes = const Value.absent(),
  })  : version = Value(version),
        createdAt = Value(createdAt);
  static Insertable<BackupMetadataData> custom({
    Expression<int>? id,
    Expression<String>? version,
    Expression<DateTime>? createdAt,
    Expression<String>? path,
    Expression<String>? notes,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (version != null) 'version': version,
      if (createdAt != null) 'created_at': createdAt,
      if (path != null) 'path': path,
      if (notes != null) 'notes': notes,
    });
  }

  BackupMetadataCompanion copyWith(
      {Value<int>? id,
      Value<String>? version,
      Value<DateTime>? createdAt,
      Value<String?>? path,
      Value<String?>? notes}) {
    return BackupMetadataCompanion(
      id: id ?? this.id,
      version: version ?? this.version,
      createdAt: createdAt ?? this.createdAt,
      path: path ?? this.path,
      notes: notes ?? this.notes,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (version.present) {
      map['version'] = Variable<String>(version.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (path.present) {
      map['path'] = Variable<String>(path.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BackupMetadataCompanion(')
          ..write('id: $id, ')
          ..write('version: $version, ')
          ..write('createdAt: $createdAt, ')
          ..write('path: $path, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ProfilesTable profiles = $ProfilesTable(this);
  late final $AppSettingsTable appSettings = $AppSettingsTable(this);
  late final $GoalsTable goals = $GoalsTable(this);
  late final $RoadmapMonthsTable roadmapMonths = $RoadmapMonthsTable(this);
  late final $ScheduleBlocksTable scheduleBlocks = $ScheduleBlocksTable(this);
  late final $ScheduleHistoryTable scheduleHistory =
      $ScheduleHistoryTable(this);
  late final $TasksTable tasks = $TasksTable(this);
  late final $ExercisesTable exercises = $ExercisesTable(this);
  late final $WorkoutSessionsTable workoutSessions =
      $WorkoutSessionsTable(this);
  late final $WorkoutSetsTable workoutSets = $WorkoutSetsTable(this);
  late final $MeasurementsTable measurements = $MeasurementsTable(this);
  late final $NutritionGuidesTable nutritionGuides =
      $NutritionGuidesTable(this);
  late final $EnglishLessonsTable englishLessons = $EnglishLessonsTable(this);
  late final $VocabEntriesTable vocabEntries = $VocabEntriesTable(this);
  late final $EnglishSessionsTable englishSessions =
      $EnglishSessionsTable(this);
  late final $EnglishAssessmentsTable englishAssessments =
      $EnglishAssessmentsTable(this);
  late final $RepairLessonsTable repairLessons = $RepairLessonsTable(this);
  late final $ComponentsTable components = $ComponentsTable(this);
  late final $EquipmentItemsTable equipmentItems = $EquipmentItemsTable(this);
  late final $RepairExercisesTable repairExercises =
      $RepairExercisesTable(this);
  late final $MeasurementNotebookTable measurementNotebook =
      $MeasurementNotebookTable(this);
  late final $RepairCasesTable repairCases = $RepairCasesTable(this);
  late final $AppearanceRoutinesTable appearanceRoutines =
      $AppearanceRoutinesTable(this);
  late final $AppearanceProductsTable appearanceProducts =
      $AppearanceProductsTable(this);
  late final $AppearancePhotosTable appearancePhotos =
      $AppearancePhotosTable(this);
  late final $GroomingRecordsTable groomingRecords =
      $GroomingRecordsTable(this);
  late final $ReviewsTable reviews = $ReviewsTable(this);
  late final $AchievementsTable achievements = $AchievementsTable(this);
  late final $NotificationPrefsTable notificationPrefs =
      $NotificationPrefsTable(this);
  late final $BackupMetadataTable backupMetadata = $BackupMetadataTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        profiles,
        appSettings,
        goals,
        roadmapMonths,
        scheduleBlocks,
        scheduleHistory,
        tasks,
        exercises,
        workoutSessions,
        workoutSets,
        measurements,
        nutritionGuides,
        englishLessons,
        vocabEntries,
        englishSessions,
        englishAssessments,
        repairLessons,
        components,
        equipmentItems,
        repairExercises,
        measurementNotebook,
        repairCases,
        appearanceRoutines,
        appearanceProducts,
        appearancePhotos,
        groomingRecords,
        reviews,
        achievements,
        notificationPrefs,
        backupMetadata
      ];
}

typedef $$ProfilesTableCreateCompanionBuilder = ProfilesCompanion Function({
  Value<int> id,
  Value<String> wakeUp,
  Value<String> sleepTime,
  Value<int> dailyDevMinutes,
  Value<String> trainingLocation,
  Value<String> englishLevel,
  Value<String> englishTarget,
  Value<String> repairLevel,
  Value<String> equipmentNotes,
  Value<String> nutritionBudget,
  Value<String> skincareStatus,
  Value<String> trainingStyle,
  Value<String> language,
  Value<String> currency,
  Value<String?> notes,
  Value<DateTime> updatedAt,
});
typedef $$ProfilesTableUpdateCompanionBuilder = ProfilesCompanion Function({
  Value<int> id,
  Value<String> wakeUp,
  Value<String> sleepTime,
  Value<int> dailyDevMinutes,
  Value<String> trainingLocation,
  Value<String> englishLevel,
  Value<String> englishTarget,
  Value<String> repairLevel,
  Value<String> equipmentNotes,
  Value<String> nutritionBudget,
  Value<String> skincareStatus,
  Value<String> trainingStyle,
  Value<String> language,
  Value<String> currency,
  Value<String?> notes,
  Value<DateTime> updatedAt,
});

class $$ProfilesTableFilterComposer
    extends Composer<_$AppDatabase, $ProfilesTable> {
  $$ProfilesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get wakeUp => $composableBuilder(
      column: $table.wakeUp, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get sleepTime => $composableBuilder(
      column: $table.sleepTime, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get dailyDevMinutes => $composableBuilder(
      column: $table.dailyDevMinutes,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get trainingLocation => $composableBuilder(
      column: $table.trainingLocation,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get englishLevel => $composableBuilder(
      column: $table.englishLevel, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get englishTarget => $composableBuilder(
      column: $table.englishTarget, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get repairLevel => $composableBuilder(
      column: $table.repairLevel, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get equipmentNotes => $composableBuilder(
      column: $table.equipmentNotes,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nutritionBudget => $composableBuilder(
      column: $table.nutritionBudget,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get skincareStatus => $composableBuilder(
      column: $table.skincareStatus,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get trainingStyle => $composableBuilder(
      column: $table.trainingStyle, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get language => $composableBuilder(
      column: $table.language, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get currency => $composableBuilder(
      column: $table.currency, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$ProfilesTableOrderingComposer
    extends Composer<_$AppDatabase, $ProfilesTable> {
  $$ProfilesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get wakeUp => $composableBuilder(
      column: $table.wakeUp, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get sleepTime => $composableBuilder(
      column: $table.sleepTime, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get dailyDevMinutes => $composableBuilder(
      column: $table.dailyDevMinutes,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get trainingLocation => $composableBuilder(
      column: $table.trainingLocation,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get englishLevel => $composableBuilder(
      column: $table.englishLevel,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get englishTarget => $composableBuilder(
      column: $table.englishTarget,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get repairLevel => $composableBuilder(
      column: $table.repairLevel, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get equipmentNotes => $composableBuilder(
      column: $table.equipmentNotes,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nutritionBudget => $composableBuilder(
      column: $table.nutritionBudget,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get skincareStatus => $composableBuilder(
      column: $table.skincareStatus,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get trainingStyle => $composableBuilder(
      column: $table.trainingStyle,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get language => $composableBuilder(
      column: $table.language, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get currency => $composableBuilder(
      column: $table.currency, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$ProfilesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProfilesTable> {
  $$ProfilesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get wakeUp =>
      $composableBuilder(column: $table.wakeUp, builder: (column) => column);

  GeneratedColumn<String> get sleepTime =>
      $composableBuilder(column: $table.sleepTime, builder: (column) => column);

  GeneratedColumn<int> get dailyDevMinutes => $composableBuilder(
      column: $table.dailyDevMinutes, builder: (column) => column);

  GeneratedColumn<String> get trainingLocation => $composableBuilder(
      column: $table.trainingLocation, builder: (column) => column);

  GeneratedColumn<String> get englishLevel => $composableBuilder(
      column: $table.englishLevel, builder: (column) => column);

  GeneratedColumn<String> get englishTarget => $composableBuilder(
      column: $table.englishTarget, builder: (column) => column);

  GeneratedColumn<String> get repairLevel => $composableBuilder(
      column: $table.repairLevel, builder: (column) => column);

  GeneratedColumn<String> get equipmentNotes => $composableBuilder(
      column: $table.equipmentNotes, builder: (column) => column);

  GeneratedColumn<String> get nutritionBudget => $composableBuilder(
      column: $table.nutritionBudget, builder: (column) => column);

  GeneratedColumn<String> get skincareStatus => $composableBuilder(
      column: $table.skincareStatus, builder: (column) => column);

  GeneratedColumn<String> get trainingStyle => $composableBuilder(
      column: $table.trainingStyle, builder: (column) => column);

  GeneratedColumn<String> get language =>
      $composableBuilder(column: $table.language, builder: (column) => column);

  GeneratedColumn<String> get currency =>
      $composableBuilder(column: $table.currency, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$ProfilesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ProfilesTable,
    Profile,
    $$ProfilesTableFilterComposer,
    $$ProfilesTableOrderingComposer,
    $$ProfilesTableAnnotationComposer,
    $$ProfilesTableCreateCompanionBuilder,
    $$ProfilesTableUpdateCompanionBuilder,
    (Profile, BaseReferences<_$AppDatabase, $ProfilesTable, Profile>),
    Profile,
    PrefetchHooks Function()> {
  $$ProfilesTableTableManager(_$AppDatabase db, $ProfilesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProfilesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProfilesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProfilesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> wakeUp = const Value.absent(),
            Value<String> sleepTime = const Value.absent(),
            Value<int> dailyDevMinutes = const Value.absent(),
            Value<String> trainingLocation = const Value.absent(),
            Value<String> englishLevel = const Value.absent(),
            Value<String> englishTarget = const Value.absent(),
            Value<String> repairLevel = const Value.absent(),
            Value<String> equipmentNotes = const Value.absent(),
            Value<String> nutritionBudget = const Value.absent(),
            Value<String> skincareStatus = const Value.absent(),
            Value<String> trainingStyle = const Value.absent(),
            Value<String> language = const Value.absent(),
            Value<String> currency = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              ProfilesCompanion(
            id: id,
            wakeUp: wakeUp,
            sleepTime: sleepTime,
            dailyDevMinutes: dailyDevMinutes,
            trainingLocation: trainingLocation,
            englishLevel: englishLevel,
            englishTarget: englishTarget,
            repairLevel: repairLevel,
            equipmentNotes: equipmentNotes,
            nutritionBudget: nutritionBudget,
            skincareStatus: skincareStatus,
            trainingStyle: trainingStyle,
            language: language,
            currency: currency,
            notes: notes,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> wakeUp = const Value.absent(),
            Value<String> sleepTime = const Value.absent(),
            Value<int> dailyDevMinutes = const Value.absent(),
            Value<String> trainingLocation = const Value.absent(),
            Value<String> englishLevel = const Value.absent(),
            Value<String> englishTarget = const Value.absent(),
            Value<String> repairLevel = const Value.absent(),
            Value<String> equipmentNotes = const Value.absent(),
            Value<String> nutritionBudget = const Value.absent(),
            Value<String> skincareStatus = const Value.absent(),
            Value<String> trainingStyle = const Value.absent(),
            Value<String> language = const Value.absent(),
            Value<String> currency = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              ProfilesCompanion.insert(
            id: id,
            wakeUp: wakeUp,
            sleepTime: sleepTime,
            dailyDevMinutes: dailyDevMinutes,
            trainingLocation: trainingLocation,
            englishLevel: englishLevel,
            englishTarget: englishTarget,
            repairLevel: repairLevel,
            equipmentNotes: equipmentNotes,
            nutritionBudget: nutritionBudget,
            skincareStatus: skincareStatus,
            trainingStyle: trainingStyle,
            language: language,
            currency: currency,
            notes: notes,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ProfilesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ProfilesTable,
    Profile,
    $$ProfilesTableFilterComposer,
    $$ProfilesTableOrderingComposer,
    $$ProfilesTableAnnotationComposer,
    $$ProfilesTableCreateCompanionBuilder,
    $$ProfilesTableUpdateCompanionBuilder,
    (Profile, BaseReferences<_$AppDatabase, $ProfilesTable, Profile>),
    Profile,
    PrefetchHooks Function()>;
typedef $$AppSettingsTableCreateCompanionBuilder = AppSettingsCompanion
    Function({
  Value<int> id,
  Value<bool> notificationsEnabled,
  Value<bool> notificationPermissionGranted,
  Value<String> reminderWake,
  Value<String> reminderFitness,
  Value<String> reminderEnglish1,
  Value<String> reminderRepairTheory,
  Value<String> reminderEnglish2,
  Value<String> reminderRepairPractical,
  Value<String> reminderAppearance,
  Value<String> reminderSleep,
  Value<String> themeMode,
  Value<DateTime> updatedAt,
});
typedef $$AppSettingsTableUpdateCompanionBuilder = AppSettingsCompanion
    Function({
  Value<int> id,
  Value<bool> notificationsEnabled,
  Value<bool> notificationPermissionGranted,
  Value<String> reminderWake,
  Value<String> reminderFitness,
  Value<String> reminderEnglish1,
  Value<String> reminderRepairTheory,
  Value<String> reminderEnglish2,
  Value<String> reminderRepairPractical,
  Value<String> reminderAppearance,
  Value<String> reminderSleep,
  Value<String> themeMode,
  Value<DateTime> updatedAt,
});

class $$AppSettingsTableFilterComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get notificationsEnabled => $composableBuilder(
      column: $table.notificationsEnabled,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get notificationPermissionGranted => $composableBuilder(
      column: $table.notificationPermissionGranted,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get reminderWake => $composableBuilder(
      column: $table.reminderWake, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get reminderFitness => $composableBuilder(
      column: $table.reminderFitness,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get reminderEnglish1 => $composableBuilder(
      column: $table.reminderEnglish1,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get reminderRepairTheory => $composableBuilder(
      column: $table.reminderRepairTheory,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get reminderEnglish2 => $composableBuilder(
      column: $table.reminderEnglish2,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get reminderRepairPractical => $composableBuilder(
      column: $table.reminderRepairPractical,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get reminderAppearance => $composableBuilder(
      column: $table.reminderAppearance,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get reminderSleep => $composableBuilder(
      column: $table.reminderSleep, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get themeMode => $composableBuilder(
      column: $table.themeMode, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$AppSettingsTableOrderingComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get notificationsEnabled => $composableBuilder(
      column: $table.notificationsEnabled,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get notificationPermissionGranted => $composableBuilder(
      column: $table.notificationPermissionGranted,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get reminderWake => $composableBuilder(
      column: $table.reminderWake,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get reminderFitness => $composableBuilder(
      column: $table.reminderFitness,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get reminderEnglish1 => $composableBuilder(
      column: $table.reminderEnglish1,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get reminderRepairTheory => $composableBuilder(
      column: $table.reminderRepairTheory,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get reminderEnglish2 => $composableBuilder(
      column: $table.reminderEnglish2,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get reminderRepairPractical => $composableBuilder(
      column: $table.reminderRepairPractical,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get reminderAppearance => $composableBuilder(
      column: $table.reminderAppearance,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get reminderSleep => $composableBuilder(
      column: $table.reminderSleep,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get themeMode => $composableBuilder(
      column: $table.themeMode, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$AppSettingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<bool> get notificationsEnabled => $composableBuilder(
      column: $table.notificationsEnabled, builder: (column) => column);

  GeneratedColumn<bool> get notificationPermissionGranted => $composableBuilder(
      column: $table.notificationPermissionGranted,
      builder: (column) => column);

  GeneratedColumn<String> get reminderWake => $composableBuilder(
      column: $table.reminderWake, builder: (column) => column);

  GeneratedColumn<String> get reminderFitness => $composableBuilder(
      column: $table.reminderFitness, builder: (column) => column);

  GeneratedColumn<String> get reminderEnglish1 => $composableBuilder(
      column: $table.reminderEnglish1, builder: (column) => column);

  GeneratedColumn<String> get reminderRepairTheory => $composableBuilder(
      column: $table.reminderRepairTheory, builder: (column) => column);

  GeneratedColumn<String> get reminderEnglish2 => $composableBuilder(
      column: $table.reminderEnglish2, builder: (column) => column);

  GeneratedColumn<String> get reminderRepairPractical => $composableBuilder(
      column: $table.reminderRepairPractical, builder: (column) => column);

  GeneratedColumn<String> get reminderAppearance => $composableBuilder(
      column: $table.reminderAppearance, builder: (column) => column);

  GeneratedColumn<String> get reminderSleep => $composableBuilder(
      column: $table.reminderSleep, builder: (column) => column);

  GeneratedColumn<String> get themeMode =>
      $composableBuilder(column: $table.themeMode, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$AppSettingsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $AppSettingsTable,
    AppSetting,
    $$AppSettingsTableFilterComposer,
    $$AppSettingsTableOrderingComposer,
    $$AppSettingsTableAnnotationComposer,
    $$AppSettingsTableCreateCompanionBuilder,
    $$AppSettingsTableUpdateCompanionBuilder,
    (AppSetting, BaseReferences<_$AppDatabase, $AppSettingsTable, AppSetting>),
    AppSetting,
    PrefetchHooks Function()> {
  $$AppSettingsTableTableManager(_$AppDatabase db, $AppSettingsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppSettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppSettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppSettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<bool> notificationsEnabled = const Value.absent(),
            Value<bool> notificationPermissionGranted = const Value.absent(),
            Value<String> reminderWake = const Value.absent(),
            Value<String> reminderFitness = const Value.absent(),
            Value<String> reminderEnglish1 = const Value.absent(),
            Value<String> reminderRepairTheory = const Value.absent(),
            Value<String> reminderEnglish2 = const Value.absent(),
            Value<String> reminderRepairPractical = const Value.absent(),
            Value<String> reminderAppearance = const Value.absent(),
            Value<String> reminderSleep = const Value.absent(),
            Value<String> themeMode = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              AppSettingsCompanion(
            id: id,
            notificationsEnabled: notificationsEnabled,
            notificationPermissionGranted: notificationPermissionGranted,
            reminderWake: reminderWake,
            reminderFitness: reminderFitness,
            reminderEnglish1: reminderEnglish1,
            reminderRepairTheory: reminderRepairTheory,
            reminderEnglish2: reminderEnglish2,
            reminderRepairPractical: reminderRepairPractical,
            reminderAppearance: reminderAppearance,
            reminderSleep: reminderSleep,
            themeMode: themeMode,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<bool> notificationsEnabled = const Value.absent(),
            Value<bool> notificationPermissionGranted = const Value.absent(),
            Value<String> reminderWake = const Value.absent(),
            Value<String> reminderFitness = const Value.absent(),
            Value<String> reminderEnglish1 = const Value.absent(),
            Value<String> reminderRepairTheory = const Value.absent(),
            Value<String> reminderEnglish2 = const Value.absent(),
            Value<String> reminderRepairPractical = const Value.absent(),
            Value<String> reminderAppearance = const Value.absent(),
            Value<String> reminderSleep = const Value.absent(),
            Value<String> themeMode = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              AppSettingsCompanion.insert(
            id: id,
            notificationsEnabled: notificationsEnabled,
            notificationPermissionGranted: notificationPermissionGranted,
            reminderWake: reminderWake,
            reminderFitness: reminderFitness,
            reminderEnglish1: reminderEnglish1,
            reminderRepairTheory: reminderRepairTheory,
            reminderEnglish2: reminderEnglish2,
            reminderRepairPractical: reminderRepairPractical,
            reminderAppearance: reminderAppearance,
            reminderSleep: reminderSleep,
            themeMode: themeMode,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$AppSettingsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $AppSettingsTable,
    AppSetting,
    $$AppSettingsTableFilterComposer,
    $$AppSettingsTableOrderingComposer,
    $$AppSettingsTableAnnotationComposer,
    $$AppSettingsTableCreateCompanionBuilder,
    $$AppSettingsTableUpdateCompanionBuilder,
    (AppSetting, BaseReferences<_$AppDatabase, $AppSettingsTable, AppSetting>),
    AppSetting,
    PrefetchHooks Function()>;
typedef $$GoalsTableCreateCompanionBuilder = GoalsCompanion Function({
  required String id,
  required String title,
  required String description,
  required int sortOrder,
  Value<double> progress,
  Value<int> rowid,
});
typedef $$GoalsTableUpdateCompanionBuilder = GoalsCompanion Function({
  Value<String> id,
  Value<String> title,
  Value<String> description,
  Value<int> sortOrder,
  Value<double> progress,
  Value<int> rowid,
});

class $$GoalsTableFilterComposer extends Composer<_$AppDatabase, $GoalsTable> {
  $$GoalsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get sortOrder => $composableBuilder(
      column: $table.sortOrder, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get progress => $composableBuilder(
      column: $table.progress, builder: (column) => ColumnFilters(column));
}

class $$GoalsTableOrderingComposer
    extends Composer<_$AppDatabase, $GoalsTable> {
  $$GoalsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sortOrder => $composableBuilder(
      column: $table.sortOrder, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get progress => $composableBuilder(
      column: $table.progress, builder: (column) => ColumnOrderings(column));
}

class $$GoalsTableAnnotationComposer
    extends Composer<_$AppDatabase, $GoalsTable> {
  $$GoalsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<double> get progress =>
      $composableBuilder(column: $table.progress, builder: (column) => column);
}

class $$GoalsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $GoalsTable,
    Goal,
    $$GoalsTableFilterComposer,
    $$GoalsTableOrderingComposer,
    $$GoalsTableAnnotationComposer,
    $$GoalsTableCreateCompanionBuilder,
    $$GoalsTableUpdateCompanionBuilder,
    (Goal, BaseReferences<_$AppDatabase, $GoalsTable, Goal>),
    Goal,
    PrefetchHooks Function()> {
  $$GoalsTableTableManager(_$AppDatabase db, $GoalsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GoalsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GoalsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GoalsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String> description = const Value.absent(),
            Value<int> sortOrder = const Value.absent(),
            Value<double> progress = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              GoalsCompanion(
            id: id,
            title: title,
            description: description,
            sortOrder: sortOrder,
            progress: progress,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String title,
            required String description,
            required int sortOrder,
            Value<double> progress = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              GoalsCompanion.insert(
            id: id,
            title: title,
            description: description,
            sortOrder: sortOrder,
            progress: progress,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$GoalsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $GoalsTable,
    Goal,
    $$GoalsTableFilterComposer,
    $$GoalsTableOrderingComposer,
    $$GoalsTableAnnotationComposer,
    $$GoalsTableCreateCompanionBuilder,
    $$GoalsTableUpdateCompanionBuilder,
    (Goal, BaseReferences<_$AppDatabase, $GoalsTable, Goal>),
    Goal,
    PrefetchHooks Function()>;
typedef $$RoadmapMonthsTableCreateCompanionBuilder = RoadmapMonthsCompanion
    Function({
  Value<int> id,
  required int monthIndex,
  required int quarter,
  required String title,
  required String focus,
  required String objectives,
  required DateTime startDate,
  required DateTime endDate,
});
typedef $$RoadmapMonthsTableUpdateCompanionBuilder = RoadmapMonthsCompanion
    Function({
  Value<int> id,
  Value<int> monthIndex,
  Value<int> quarter,
  Value<String> title,
  Value<String> focus,
  Value<String> objectives,
  Value<DateTime> startDate,
  Value<DateTime> endDate,
});

class $$RoadmapMonthsTableFilterComposer
    extends Composer<_$AppDatabase, $RoadmapMonthsTable> {
  $$RoadmapMonthsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get monthIndex => $composableBuilder(
      column: $table.monthIndex, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get quarter => $composableBuilder(
      column: $table.quarter, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get focus => $composableBuilder(
      column: $table.focus, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get objectives => $composableBuilder(
      column: $table.objectives, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get startDate => $composableBuilder(
      column: $table.startDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get endDate => $composableBuilder(
      column: $table.endDate, builder: (column) => ColumnFilters(column));
}

class $$RoadmapMonthsTableOrderingComposer
    extends Composer<_$AppDatabase, $RoadmapMonthsTable> {
  $$RoadmapMonthsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get monthIndex => $composableBuilder(
      column: $table.monthIndex, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get quarter => $composableBuilder(
      column: $table.quarter, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get focus => $composableBuilder(
      column: $table.focus, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get objectives => $composableBuilder(
      column: $table.objectives, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get startDate => $composableBuilder(
      column: $table.startDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get endDate => $composableBuilder(
      column: $table.endDate, builder: (column) => ColumnOrderings(column));
}

class $$RoadmapMonthsTableAnnotationComposer
    extends Composer<_$AppDatabase, $RoadmapMonthsTable> {
  $$RoadmapMonthsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get monthIndex => $composableBuilder(
      column: $table.monthIndex, builder: (column) => column);

  GeneratedColumn<int> get quarter =>
      $composableBuilder(column: $table.quarter, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get focus =>
      $composableBuilder(column: $table.focus, builder: (column) => column);

  GeneratedColumn<String> get objectives => $composableBuilder(
      column: $table.objectives, builder: (column) => column);

  GeneratedColumn<DateTime> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => column);

  GeneratedColumn<DateTime> get endDate =>
      $composableBuilder(column: $table.endDate, builder: (column) => column);
}

class $$RoadmapMonthsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $RoadmapMonthsTable,
    RoadmapMonth,
    $$RoadmapMonthsTableFilterComposer,
    $$RoadmapMonthsTableOrderingComposer,
    $$RoadmapMonthsTableAnnotationComposer,
    $$RoadmapMonthsTableCreateCompanionBuilder,
    $$RoadmapMonthsTableUpdateCompanionBuilder,
    (
      RoadmapMonth,
      BaseReferences<_$AppDatabase, $RoadmapMonthsTable, RoadmapMonth>
    ),
    RoadmapMonth,
    PrefetchHooks Function()> {
  $$RoadmapMonthsTableTableManager(_$AppDatabase db, $RoadmapMonthsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RoadmapMonthsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RoadmapMonthsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RoadmapMonthsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> monthIndex = const Value.absent(),
            Value<int> quarter = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String> focus = const Value.absent(),
            Value<String> objectives = const Value.absent(),
            Value<DateTime> startDate = const Value.absent(),
            Value<DateTime> endDate = const Value.absent(),
          }) =>
              RoadmapMonthsCompanion(
            id: id,
            monthIndex: monthIndex,
            quarter: quarter,
            title: title,
            focus: focus,
            objectives: objectives,
            startDate: startDate,
            endDate: endDate,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int monthIndex,
            required int quarter,
            required String title,
            required String focus,
            required String objectives,
            required DateTime startDate,
            required DateTime endDate,
          }) =>
              RoadmapMonthsCompanion.insert(
            id: id,
            monthIndex: monthIndex,
            quarter: quarter,
            title: title,
            focus: focus,
            objectives: objectives,
            startDate: startDate,
            endDate: endDate,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$RoadmapMonthsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $RoadmapMonthsTable,
    RoadmapMonth,
    $$RoadmapMonthsTableFilterComposer,
    $$RoadmapMonthsTableOrderingComposer,
    $$RoadmapMonthsTableAnnotationComposer,
    $$RoadmapMonthsTableCreateCompanionBuilder,
    $$RoadmapMonthsTableUpdateCompanionBuilder,
    (
      RoadmapMonth,
      BaseReferences<_$AppDatabase, $RoadmapMonthsTable, RoadmapMonth>
    ),
    RoadmapMonth,
    PrefetchHooks Function()>;
typedef $$ScheduleBlocksTableCreateCompanionBuilder = ScheduleBlocksCompanion
    Function({
  Value<int> id,
  required String date,
  required String startTime,
  required String endTime,
  required String title,
  Value<String?> goalId,
  Value<String> status,
  Value<String?> notes,
  Value<int> sortOrder,
  Value<DateTime> updatedAt,
});
typedef $$ScheduleBlocksTableUpdateCompanionBuilder = ScheduleBlocksCompanion
    Function({
  Value<int> id,
  Value<String> date,
  Value<String> startTime,
  Value<String> endTime,
  Value<String> title,
  Value<String?> goalId,
  Value<String> status,
  Value<String?> notes,
  Value<int> sortOrder,
  Value<DateTime> updatedAt,
});

class $$ScheduleBlocksTableFilterComposer
    extends Composer<_$AppDatabase, $ScheduleBlocksTable> {
  $$ScheduleBlocksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get startTime => $composableBuilder(
      column: $table.startTime, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get endTime => $composableBuilder(
      column: $table.endTime, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get goalId => $composableBuilder(
      column: $table.goalId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get sortOrder => $composableBuilder(
      column: $table.sortOrder, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$ScheduleBlocksTableOrderingComposer
    extends Composer<_$AppDatabase, $ScheduleBlocksTable> {
  $$ScheduleBlocksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get startTime => $composableBuilder(
      column: $table.startTime, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get endTime => $composableBuilder(
      column: $table.endTime, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get goalId => $composableBuilder(
      column: $table.goalId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sortOrder => $composableBuilder(
      column: $table.sortOrder, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$ScheduleBlocksTableAnnotationComposer
    extends Composer<_$AppDatabase, $ScheduleBlocksTable> {
  $$ScheduleBlocksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get startTime =>
      $composableBuilder(column: $table.startTime, builder: (column) => column);

  GeneratedColumn<String> get endTime =>
      $composableBuilder(column: $table.endTime, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get goalId =>
      $composableBuilder(column: $table.goalId, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$ScheduleBlocksTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ScheduleBlocksTable,
    ScheduleBlock,
    $$ScheduleBlocksTableFilterComposer,
    $$ScheduleBlocksTableOrderingComposer,
    $$ScheduleBlocksTableAnnotationComposer,
    $$ScheduleBlocksTableCreateCompanionBuilder,
    $$ScheduleBlocksTableUpdateCompanionBuilder,
    (
      ScheduleBlock,
      BaseReferences<_$AppDatabase, $ScheduleBlocksTable, ScheduleBlock>
    ),
    ScheduleBlock,
    PrefetchHooks Function()> {
  $$ScheduleBlocksTableTableManager(
      _$AppDatabase db, $ScheduleBlocksTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ScheduleBlocksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ScheduleBlocksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ScheduleBlocksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> date = const Value.absent(),
            Value<String> startTime = const Value.absent(),
            Value<String> endTime = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String?> goalId = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<int> sortOrder = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              ScheduleBlocksCompanion(
            id: id,
            date: date,
            startTime: startTime,
            endTime: endTime,
            title: title,
            goalId: goalId,
            status: status,
            notes: notes,
            sortOrder: sortOrder,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String date,
            required String startTime,
            required String endTime,
            required String title,
            Value<String?> goalId = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<int> sortOrder = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              ScheduleBlocksCompanion.insert(
            id: id,
            date: date,
            startTime: startTime,
            endTime: endTime,
            title: title,
            goalId: goalId,
            status: status,
            notes: notes,
            sortOrder: sortOrder,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ScheduleBlocksTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ScheduleBlocksTable,
    ScheduleBlock,
    $$ScheduleBlocksTableFilterComposer,
    $$ScheduleBlocksTableOrderingComposer,
    $$ScheduleBlocksTableAnnotationComposer,
    $$ScheduleBlocksTableCreateCompanionBuilder,
    $$ScheduleBlocksTableUpdateCompanionBuilder,
    (
      ScheduleBlock,
      BaseReferences<_$AppDatabase, $ScheduleBlocksTable, ScheduleBlock>
    ),
    ScheduleBlock,
    PrefetchHooks Function()>;
typedef $$ScheduleHistoryTableCreateCompanionBuilder = ScheduleHistoryCompanion
    Function({
  Value<int> id,
  required int blockId,
  required String previousStatus,
  required String newStatus,
  Value<String?> reason,
  Value<DateTime> changedAt,
});
typedef $$ScheduleHistoryTableUpdateCompanionBuilder = ScheduleHistoryCompanion
    Function({
  Value<int> id,
  Value<int> blockId,
  Value<String> previousStatus,
  Value<String> newStatus,
  Value<String?> reason,
  Value<DateTime> changedAt,
});

class $$ScheduleHistoryTableFilterComposer
    extends Composer<_$AppDatabase, $ScheduleHistoryTable> {
  $$ScheduleHistoryTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get blockId => $composableBuilder(
      column: $table.blockId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get previousStatus => $composableBuilder(
      column: $table.previousStatus,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get newStatus => $composableBuilder(
      column: $table.newStatus, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get reason => $composableBuilder(
      column: $table.reason, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get changedAt => $composableBuilder(
      column: $table.changedAt, builder: (column) => ColumnFilters(column));
}

class $$ScheduleHistoryTableOrderingComposer
    extends Composer<_$AppDatabase, $ScheduleHistoryTable> {
  $$ScheduleHistoryTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get blockId => $composableBuilder(
      column: $table.blockId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get previousStatus => $composableBuilder(
      column: $table.previousStatus,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get newStatus => $composableBuilder(
      column: $table.newStatus, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get reason => $composableBuilder(
      column: $table.reason, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get changedAt => $composableBuilder(
      column: $table.changedAt, builder: (column) => ColumnOrderings(column));
}

class $$ScheduleHistoryTableAnnotationComposer
    extends Composer<_$AppDatabase, $ScheduleHistoryTable> {
  $$ScheduleHistoryTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get blockId =>
      $composableBuilder(column: $table.blockId, builder: (column) => column);

  GeneratedColumn<String> get previousStatus => $composableBuilder(
      column: $table.previousStatus, builder: (column) => column);

  GeneratedColumn<String> get newStatus =>
      $composableBuilder(column: $table.newStatus, builder: (column) => column);

  GeneratedColumn<String> get reason =>
      $composableBuilder(column: $table.reason, builder: (column) => column);

  GeneratedColumn<DateTime> get changedAt =>
      $composableBuilder(column: $table.changedAt, builder: (column) => column);
}

class $$ScheduleHistoryTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ScheduleHistoryTable,
    ScheduleHistoryData,
    $$ScheduleHistoryTableFilterComposer,
    $$ScheduleHistoryTableOrderingComposer,
    $$ScheduleHistoryTableAnnotationComposer,
    $$ScheduleHistoryTableCreateCompanionBuilder,
    $$ScheduleHistoryTableUpdateCompanionBuilder,
    (
      ScheduleHistoryData,
      BaseReferences<_$AppDatabase, $ScheduleHistoryTable, ScheduleHistoryData>
    ),
    ScheduleHistoryData,
    PrefetchHooks Function()> {
  $$ScheduleHistoryTableTableManager(
      _$AppDatabase db, $ScheduleHistoryTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ScheduleHistoryTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ScheduleHistoryTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ScheduleHistoryTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> blockId = const Value.absent(),
            Value<String> previousStatus = const Value.absent(),
            Value<String> newStatus = const Value.absent(),
            Value<String?> reason = const Value.absent(),
            Value<DateTime> changedAt = const Value.absent(),
          }) =>
              ScheduleHistoryCompanion(
            id: id,
            blockId: blockId,
            previousStatus: previousStatus,
            newStatus: newStatus,
            reason: reason,
            changedAt: changedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int blockId,
            required String previousStatus,
            required String newStatus,
            Value<String?> reason = const Value.absent(),
            Value<DateTime> changedAt = const Value.absent(),
          }) =>
              ScheduleHistoryCompanion.insert(
            id: id,
            blockId: blockId,
            previousStatus: previousStatus,
            newStatus: newStatus,
            reason: reason,
            changedAt: changedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ScheduleHistoryTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ScheduleHistoryTable,
    ScheduleHistoryData,
    $$ScheduleHistoryTableFilterComposer,
    $$ScheduleHistoryTableOrderingComposer,
    $$ScheduleHistoryTableAnnotationComposer,
    $$ScheduleHistoryTableCreateCompanionBuilder,
    $$ScheduleHistoryTableUpdateCompanionBuilder,
    (
      ScheduleHistoryData,
      BaseReferences<_$AppDatabase, $ScheduleHistoryTable, ScheduleHistoryData>
    ),
    ScheduleHistoryData,
    PrefetchHooks Function()>;
typedef $$TasksTableCreateCompanionBuilder = TasksCompanion Function({
  Value<int> id,
  required String date,
  required String goalId,
  required String title,
  Value<String?> description,
  Value<String> status,
  Value<bool> isDayOne,
  Value<int> sortOrder,
  Value<DateTime?> completedAt,
});
typedef $$TasksTableUpdateCompanionBuilder = TasksCompanion Function({
  Value<int> id,
  Value<String> date,
  Value<String> goalId,
  Value<String> title,
  Value<String?> description,
  Value<String> status,
  Value<bool> isDayOne,
  Value<int> sortOrder,
  Value<DateTime?> completedAt,
});

class $$TasksTableFilterComposer extends Composer<_$AppDatabase, $TasksTable> {
  $$TasksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get goalId => $composableBuilder(
      column: $table.goalId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isDayOne => $composableBuilder(
      column: $table.isDayOne, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get sortOrder => $composableBuilder(
      column: $table.sortOrder, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
      column: $table.completedAt, builder: (column) => ColumnFilters(column));
}

class $$TasksTableOrderingComposer
    extends Composer<_$AppDatabase, $TasksTable> {
  $$TasksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get goalId => $composableBuilder(
      column: $table.goalId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isDayOne => $composableBuilder(
      column: $table.isDayOne, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sortOrder => $composableBuilder(
      column: $table.sortOrder, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
      column: $table.completedAt, builder: (column) => ColumnOrderings(column));
}

class $$TasksTableAnnotationComposer
    extends Composer<_$AppDatabase, $TasksTable> {
  $$TasksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get goalId =>
      $composableBuilder(column: $table.goalId, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<bool> get isDayOne =>
      $composableBuilder(column: $table.isDayOne, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
      column: $table.completedAt, builder: (column) => column);
}

class $$TasksTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TasksTable,
    Task,
    $$TasksTableFilterComposer,
    $$TasksTableOrderingComposer,
    $$TasksTableAnnotationComposer,
    $$TasksTableCreateCompanionBuilder,
    $$TasksTableUpdateCompanionBuilder,
    (Task, BaseReferences<_$AppDatabase, $TasksTable, Task>),
    Task,
    PrefetchHooks Function()> {
  $$TasksTableTableManager(_$AppDatabase db, $TasksTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TasksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TasksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TasksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> date = const Value.absent(),
            Value<String> goalId = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<bool> isDayOne = const Value.absent(),
            Value<int> sortOrder = const Value.absent(),
            Value<DateTime?> completedAt = const Value.absent(),
          }) =>
              TasksCompanion(
            id: id,
            date: date,
            goalId: goalId,
            title: title,
            description: description,
            status: status,
            isDayOne: isDayOne,
            sortOrder: sortOrder,
            completedAt: completedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String date,
            required String goalId,
            required String title,
            Value<String?> description = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<bool> isDayOne = const Value.absent(),
            Value<int> sortOrder = const Value.absent(),
            Value<DateTime?> completedAt = const Value.absent(),
          }) =>
              TasksCompanion.insert(
            id: id,
            date: date,
            goalId: goalId,
            title: title,
            description: description,
            status: status,
            isDayOne: isDayOne,
            sortOrder: sortOrder,
            completedAt: completedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$TasksTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $TasksTable,
    Task,
    $$TasksTableFilterComposer,
    $$TasksTableOrderingComposer,
    $$TasksTableAnnotationComposer,
    $$TasksTableCreateCompanionBuilder,
    $$TasksTableUpdateCompanionBuilder,
    (Task, BaseReferences<_$AppDatabase, $TasksTable, Task>),
    Task,
    PrefetchHooks Function()>;
typedef $$ExercisesTableCreateCompanionBuilder = ExercisesCompanion Function({
  Value<int> id,
  required String name,
  required String category,
  required String instructions,
  Value<int> defaultSets,
  Value<String> defaultReps,
  Value<int> restSeconds,
  Value<bool> beginnerSafe,
});
typedef $$ExercisesTableUpdateCompanionBuilder = ExercisesCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<String> category,
  Value<String> instructions,
  Value<int> defaultSets,
  Value<String> defaultReps,
  Value<int> restSeconds,
  Value<bool> beginnerSafe,
});

class $$ExercisesTableFilterComposer
    extends Composer<_$AppDatabase, $ExercisesTable> {
  $$ExercisesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get instructions => $composableBuilder(
      column: $table.instructions, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get defaultSets => $composableBuilder(
      column: $table.defaultSets, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get defaultReps => $composableBuilder(
      column: $table.defaultReps, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get restSeconds => $composableBuilder(
      column: $table.restSeconds, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get beginnerSafe => $composableBuilder(
      column: $table.beginnerSafe, builder: (column) => ColumnFilters(column));
}

class $$ExercisesTableOrderingComposer
    extends Composer<_$AppDatabase, $ExercisesTable> {
  $$ExercisesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get instructions => $composableBuilder(
      column: $table.instructions,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get defaultSets => $composableBuilder(
      column: $table.defaultSets, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get defaultReps => $composableBuilder(
      column: $table.defaultReps, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get restSeconds => $composableBuilder(
      column: $table.restSeconds, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get beginnerSafe => $composableBuilder(
      column: $table.beginnerSafe,
      builder: (column) => ColumnOrderings(column));
}

class $$ExercisesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExercisesTable> {
  $$ExercisesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get instructions => $composableBuilder(
      column: $table.instructions, builder: (column) => column);

  GeneratedColumn<int> get defaultSets => $composableBuilder(
      column: $table.defaultSets, builder: (column) => column);

  GeneratedColumn<String> get defaultReps => $composableBuilder(
      column: $table.defaultReps, builder: (column) => column);

  GeneratedColumn<int> get restSeconds => $composableBuilder(
      column: $table.restSeconds, builder: (column) => column);

  GeneratedColumn<bool> get beginnerSafe => $composableBuilder(
      column: $table.beginnerSafe, builder: (column) => column);
}

class $$ExercisesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ExercisesTable,
    Exercise,
    $$ExercisesTableFilterComposer,
    $$ExercisesTableOrderingComposer,
    $$ExercisesTableAnnotationComposer,
    $$ExercisesTableCreateCompanionBuilder,
    $$ExercisesTableUpdateCompanionBuilder,
    (Exercise, BaseReferences<_$AppDatabase, $ExercisesTable, Exercise>),
    Exercise,
    PrefetchHooks Function()> {
  $$ExercisesTableTableManager(_$AppDatabase db, $ExercisesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExercisesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExercisesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExercisesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> category = const Value.absent(),
            Value<String> instructions = const Value.absent(),
            Value<int> defaultSets = const Value.absent(),
            Value<String> defaultReps = const Value.absent(),
            Value<int> restSeconds = const Value.absent(),
            Value<bool> beginnerSafe = const Value.absent(),
          }) =>
              ExercisesCompanion(
            id: id,
            name: name,
            category: category,
            instructions: instructions,
            defaultSets: defaultSets,
            defaultReps: defaultReps,
            restSeconds: restSeconds,
            beginnerSafe: beginnerSafe,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            required String category,
            required String instructions,
            Value<int> defaultSets = const Value.absent(),
            Value<String> defaultReps = const Value.absent(),
            Value<int> restSeconds = const Value.absent(),
            Value<bool> beginnerSafe = const Value.absent(),
          }) =>
              ExercisesCompanion.insert(
            id: id,
            name: name,
            category: category,
            instructions: instructions,
            defaultSets: defaultSets,
            defaultReps: defaultReps,
            restSeconds: restSeconds,
            beginnerSafe: beginnerSafe,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ExercisesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ExercisesTable,
    Exercise,
    $$ExercisesTableFilterComposer,
    $$ExercisesTableOrderingComposer,
    $$ExercisesTableAnnotationComposer,
    $$ExercisesTableCreateCompanionBuilder,
    $$ExercisesTableUpdateCompanionBuilder,
    (Exercise, BaseReferences<_$AppDatabase, $ExercisesTable, Exercise>),
    Exercise,
    PrefetchHooks Function()>;
typedef $$WorkoutSessionsTableCreateCompanionBuilder = WorkoutSessionsCompanion
    Function({
  Value<int> id,
  required String date,
  required String planName,
  Value<String> status,
  Value<int?> durationMinutes,
  Value<String?> notes,
  Value<DateTime?> completedAt,
});
typedef $$WorkoutSessionsTableUpdateCompanionBuilder = WorkoutSessionsCompanion
    Function({
  Value<int> id,
  Value<String> date,
  Value<String> planName,
  Value<String> status,
  Value<int?> durationMinutes,
  Value<String?> notes,
  Value<DateTime?> completedAt,
});

class $$WorkoutSessionsTableFilterComposer
    extends Composer<_$AppDatabase, $WorkoutSessionsTable> {
  $$WorkoutSessionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get planName => $composableBuilder(
      column: $table.planName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get durationMinutes => $composableBuilder(
      column: $table.durationMinutes,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
      column: $table.completedAt, builder: (column) => ColumnFilters(column));
}

class $$WorkoutSessionsTableOrderingComposer
    extends Composer<_$AppDatabase, $WorkoutSessionsTable> {
  $$WorkoutSessionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get planName => $composableBuilder(
      column: $table.planName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get durationMinutes => $composableBuilder(
      column: $table.durationMinutes,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
      column: $table.completedAt, builder: (column) => ColumnOrderings(column));
}

class $$WorkoutSessionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $WorkoutSessionsTable> {
  $$WorkoutSessionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get planName =>
      $composableBuilder(column: $table.planName, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get durationMinutes => $composableBuilder(
      column: $table.durationMinutes, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
      column: $table.completedAt, builder: (column) => column);
}

class $$WorkoutSessionsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $WorkoutSessionsTable,
    WorkoutSession,
    $$WorkoutSessionsTableFilterComposer,
    $$WorkoutSessionsTableOrderingComposer,
    $$WorkoutSessionsTableAnnotationComposer,
    $$WorkoutSessionsTableCreateCompanionBuilder,
    $$WorkoutSessionsTableUpdateCompanionBuilder,
    (
      WorkoutSession,
      BaseReferences<_$AppDatabase, $WorkoutSessionsTable, WorkoutSession>
    ),
    WorkoutSession,
    PrefetchHooks Function()> {
  $$WorkoutSessionsTableTableManager(
      _$AppDatabase db, $WorkoutSessionsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WorkoutSessionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WorkoutSessionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WorkoutSessionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> date = const Value.absent(),
            Value<String> planName = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<int?> durationMinutes = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<DateTime?> completedAt = const Value.absent(),
          }) =>
              WorkoutSessionsCompanion(
            id: id,
            date: date,
            planName: planName,
            status: status,
            durationMinutes: durationMinutes,
            notes: notes,
            completedAt: completedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String date,
            required String planName,
            Value<String> status = const Value.absent(),
            Value<int?> durationMinutes = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<DateTime?> completedAt = const Value.absent(),
          }) =>
              WorkoutSessionsCompanion.insert(
            id: id,
            date: date,
            planName: planName,
            status: status,
            durationMinutes: durationMinutes,
            notes: notes,
            completedAt: completedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$WorkoutSessionsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $WorkoutSessionsTable,
    WorkoutSession,
    $$WorkoutSessionsTableFilterComposer,
    $$WorkoutSessionsTableOrderingComposer,
    $$WorkoutSessionsTableAnnotationComposer,
    $$WorkoutSessionsTableCreateCompanionBuilder,
    $$WorkoutSessionsTableUpdateCompanionBuilder,
    (
      WorkoutSession,
      BaseReferences<_$AppDatabase, $WorkoutSessionsTable, WorkoutSession>
    ),
    WorkoutSession,
    PrefetchHooks Function()>;
typedef $$WorkoutSetsTableCreateCompanionBuilder = WorkoutSetsCompanion
    Function({
  Value<int> id,
  required int sessionId,
  required int exerciseId,
  required int setNumber,
  required String targetReps,
  Value<String?> actualReps,
  Value<double?> weightKg,
  Value<bool> completed,
  Value<bool> isPr,
});
typedef $$WorkoutSetsTableUpdateCompanionBuilder = WorkoutSetsCompanion
    Function({
  Value<int> id,
  Value<int> sessionId,
  Value<int> exerciseId,
  Value<int> setNumber,
  Value<String> targetReps,
  Value<String?> actualReps,
  Value<double?> weightKg,
  Value<bool> completed,
  Value<bool> isPr,
});

class $$WorkoutSetsTableFilterComposer
    extends Composer<_$AppDatabase, $WorkoutSetsTable> {
  $$WorkoutSetsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get sessionId => $composableBuilder(
      column: $table.sessionId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get exerciseId => $composableBuilder(
      column: $table.exerciseId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get setNumber => $composableBuilder(
      column: $table.setNumber, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get targetReps => $composableBuilder(
      column: $table.targetReps, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get actualReps => $composableBuilder(
      column: $table.actualReps, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get weightKg => $composableBuilder(
      column: $table.weightKg, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get completed => $composableBuilder(
      column: $table.completed, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isPr => $composableBuilder(
      column: $table.isPr, builder: (column) => ColumnFilters(column));
}

class $$WorkoutSetsTableOrderingComposer
    extends Composer<_$AppDatabase, $WorkoutSetsTable> {
  $$WorkoutSetsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sessionId => $composableBuilder(
      column: $table.sessionId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get exerciseId => $composableBuilder(
      column: $table.exerciseId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get setNumber => $composableBuilder(
      column: $table.setNumber, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get targetReps => $composableBuilder(
      column: $table.targetReps, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get actualReps => $composableBuilder(
      column: $table.actualReps, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get weightKg => $composableBuilder(
      column: $table.weightKg, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get completed => $composableBuilder(
      column: $table.completed, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isPr => $composableBuilder(
      column: $table.isPr, builder: (column) => ColumnOrderings(column));
}

class $$WorkoutSetsTableAnnotationComposer
    extends Composer<_$AppDatabase, $WorkoutSetsTable> {
  $$WorkoutSetsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get sessionId =>
      $composableBuilder(column: $table.sessionId, builder: (column) => column);

  GeneratedColumn<int> get exerciseId => $composableBuilder(
      column: $table.exerciseId, builder: (column) => column);

  GeneratedColumn<int> get setNumber =>
      $composableBuilder(column: $table.setNumber, builder: (column) => column);

  GeneratedColumn<String> get targetReps => $composableBuilder(
      column: $table.targetReps, builder: (column) => column);

  GeneratedColumn<String> get actualReps => $composableBuilder(
      column: $table.actualReps, builder: (column) => column);

  GeneratedColumn<double> get weightKg =>
      $composableBuilder(column: $table.weightKg, builder: (column) => column);

  GeneratedColumn<bool> get completed =>
      $composableBuilder(column: $table.completed, builder: (column) => column);

  GeneratedColumn<bool> get isPr =>
      $composableBuilder(column: $table.isPr, builder: (column) => column);
}

class $$WorkoutSetsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $WorkoutSetsTable,
    WorkoutSet,
    $$WorkoutSetsTableFilterComposer,
    $$WorkoutSetsTableOrderingComposer,
    $$WorkoutSetsTableAnnotationComposer,
    $$WorkoutSetsTableCreateCompanionBuilder,
    $$WorkoutSetsTableUpdateCompanionBuilder,
    (WorkoutSet, BaseReferences<_$AppDatabase, $WorkoutSetsTable, WorkoutSet>),
    WorkoutSet,
    PrefetchHooks Function()> {
  $$WorkoutSetsTableTableManager(_$AppDatabase db, $WorkoutSetsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WorkoutSetsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WorkoutSetsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WorkoutSetsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> sessionId = const Value.absent(),
            Value<int> exerciseId = const Value.absent(),
            Value<int> setNumber = const Value.absent(),
            Value<String> targetReps = const Value.absent(),
            Value<String?> actualReps = const Value.absent(),
            Value<double?> weightKg = const Value.absent(),
            Value<bool> completed = const Value.absent(),
            Value<bool> isPr = const Value.absent(),
          }) =>
              WorkoutSetsCompanion(
            id: id,
            sessionId: sessionId,
            exerciseId: exerciseId,
            setNumber: setNumber,
            targetReps: targetReps,
            actualReps: actualReps,
            weightKg: weightKg,
            completed: completed,
            isPr: isPr,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int sessionId,
            required int exerciseId,
            required int setNumber,
            required String targetReps,
            Value<String?> actualReps = const Value.absent(),
            Value<double?> weightKg = const Value.absent(),
            Value<bool> completed = const Value.absent(),
            Value<bool> isPr = const Value.absent(),
          }) =>
              WorkoutSetsCompanion.insert(
            id: id,
            sessionId: sessionId,
            exerciseId: exerciseId,
            setNumber: setNumber,
            targetReps: targetReps,
            actualReps: actualReps,
            weightKg: weightKg,
            completed: completed,
            isPr: isPr,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$WorkoutSetsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $WorkoutSetsTable,
    WorkoutSet,
    $$WorkoutSetsTableFilterComposer,
    $$WorkoutSetsTableOrderingComposer,
    $$WorkoutSetsTableAnnotationComposer,
    $$WorkoutSetsTableCreateCompanionBuilder,
    $$WorkoutSetsTableUpdateCompanionBuilder,
    (WorkoutSet, BaseReferences<_$AppDatabase, $WorkoutSetsTable, WorkoutSet>),
    WorkoutSet,
    PrefetchHooks Function()>;
typedef $$MeasurementsTableCreateCompanionBuilder = MeasurementsCompanion
    Function({
  Value<int> id,
  required String date,
  Value<double?> weightKg,
  Value<double?> waistCm,
  Value<int?> pushUps,
  Value<int?> squats,
  Value<int?> plankSeconds,
  Value<String?> resistanceNotes,
  Value<double?> consistencyScore,
  Value<String?> photoPath,
  Value<String?> notes,
});
typedef $$MeasurementsTableUpdateCompanionBuilder = MeasurementsCompanion
    Function({
  Value<int> id,
  Value<String> date,
  Value<double?> weightKg,
  Value<double?> waistCm,
  Value<int?> pushUps,
  Value<int?> squats,
  Value<int?> plankSeconds,
  Value<String?> resistanceNotes,
  Value<double?> consistencyScore,
  Value<String?> photoPath,
  Value<String?> notes,
});

class $$MeasurementsTableFilterComposer
    extends Composer<_$AppDatabase, $MeasurementsTable> {
  $$MeasurementsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get weightKg => $composableBuilder(
      column: $table.weightKg, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get waistCm => $composableBuilder(
      column: $table.waistCm, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get pushUps => $composableBuilder(
      column: $table.pushUps, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get squats => $composableBuilder(
      column: $table.squats, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get plankSeconds => $composableBuilder(
      column: $table.plankSeconds, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get resistanceNotes => $composableBuilder(
      column: $table.resistanceNotes,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get consistencyScore => $composableBuilder(
      column: $table.consistencyScore,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get photoPath => $composableBuilder(
      column: $table.photoPath, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));
}

class $$MeasurementsTableOrderingComposer
    extends Composer<_$AppDatabase, $MeasurementsTable> {
  $$MeasurementsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get weightKg => $composableBuilder(
      column: $table.weightKg, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get waistCm => $composableBuilder(
      column: $table.waistCm, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get pushUps => $composableBuilder(
      column: $table.pushUps, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get squats => $composableBuilder(
      column: $table.squats, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get plankSeconds => $composableBuilder(
      column: $table.plankSeconds,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get resistanceNotes => $composableBuilder(
      column: $table.resistanceNotes,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get consistencyScore => $composableBuilder(
      column: $table.consistencyScore,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get photoPath => $composableBuilder(
      column: $table.photoPath, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));
}

class $$MeasurementsTableAnnotationComposer
    extends Composer<_$AppDatabase, $MeasurementsTable> {
  $$MeasurementsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<double> get weightKg =>
      $composableBuilder(column: $table.weightKg, builder: (column) => column);

  GeneratedColumn<double> get waistCm =>
      $composableBuilder(column: $table.waistCm, builder: (column) => column);

  GeneratedColumn<int> get pushUps =>
      $composableBuilder(column: $table.pushUps, builder: (column) => column);

  GeneratedColumn<int> get squats =>
      $composableBuilder(column: $table.squats, builder: (column) => column);

  GeneratedColumn<int> get plankSeconds => $composableBuilder(
      column: $table.plankSeconds, builder: (column) => column);

  GeneratedColumn<String> get resistanceNotes => $composableBuilder(
      column: $table.resistanceNotes, builder: (column) => column);

  GeneratedColumn<double> get consistencyScore => $composableBuilder(
      column: $table.consistencyScore, builder: (column) => column);

  GeneratedColumn<String> get photoPath =>
      $composableBuilder(column: $table.photoPath, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);
}

class $$MeasurementsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $MeasurementsTable,
    Measurement,
    $$MeasurementsTableFilterComposer,
    $$MeasurementsTableOrderingComposer,
    $$MeasurementsTableAnnotationComposer,
    $$MeasurementsTableCreateCompanionBuilder,
    $$MeasurementsTableUpdateCompanionBuilder,
    (
      Measurement,
      BaseReferences<_$AppDatabase, $MeasurementsTable, Measurement>
    ),
    Measurement,
    PrefetchHooks Function()> {
  $$MeasurementsTableTableManager(_$AppDatabase db, $MeasurementsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MeasurementsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MeasurementsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MeasurementsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> date = const Value.absent(),
            Value<double?> weightKg = const Value.absent(),
            Value<double?> waistCm = const Value.absent(),
            Value<int?> pushUps = const Value.absent(),
            Value<int?> squats = const Value.absent(),
            Value<int?> plankSeconds = const Value.absent(),
            Value<String?> resistanceNotes = const Value.absent(),
            Value<double?> consistencyScore = const Value.absent(),
            Value<String?> photoPath = const Value.absent(),
            Value<String?> notes = const Value.absent(),
          }) =>
              MeasurementsCompanion(
            id: id,
            date: date,
            weightKg: weightKg,
            waistCm: waistCm,
            pushUps: pushUps,
            squats: squats,
            plankSeconds: plankSeconds,
            resistanceNotes: resistanceNotes,
            consistencyScore: consistencyScore,
            photoPath: photoPath,
            notes: notes,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String date,
            Value<double?> weightKg = const Value.absent(),
            Value<double?> waistCm = const Value.absent(),
            Value<int?> pushUps = const Value.absent(),
            Value<int?> squats = const Value.absent(),
            Value<int?> plankSeconds = const Value.absent(),
            Value<String?> resistanceNotes = const Value.absent(),
            Value<double?> consistencyScore = const Value.absent(),
            Value<String?> photoPath = const Value.absent(),
            Value<String?> notes = const Value.absent(),
          }) =>
              MeasurementsCompanion.insert(
            id: id,
            date: date,
            weightKg: weightKg,
            waistCm: waistCm,
            pushUps: pushUps,
            squats: squats,
            plankSeconds: plankSeconds,
            resistanceNotes: resistanceNotes,
            consistencyScore: consistencyScore,
            photoPath: photoPath,
            notes: notes,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$MeasurementsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $MeasurementsTable,
    Measurement,
    $$MeasurementsTableFilterComposer,
    $$MeasurementsTableOrderingComposer,
    $$MeasurementsTableAnnotationComposer,
    $$MeasurementsTableCreateCompanionBuilder,
    $$MeasurementsTableUpdateCompanionBuilder,
    (
      Measurement,
      BaseReferences<_$AppDatabase, $MeasurementsTable, Measurement>
    ),
    Measurement,
    PrefetchHooks Function()>;
typedef $$NutritionGuidesTableCreateCompanionBuilder = NutritionGuidesCompanion
    Function({
  Value<int> id,
  required String title,
  required String content,
  required String category,
});
typedef $$NutritionGuidesTableUpdateCompanionBuilder = NutritionGuidesCompanion
    Function({
  Value<int> id,
  Value<String> title,
  Value<String> content,
  Value<String> category,
});

class $$NutritionGuidesTableFilterComposer
    extends Composer<_$AppDatabase, $NutritionGuidesTable> {
  $$NutritionGuidesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get content => $composableBuilder(
      column: $table.content, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnFilters(column));
}

class $$NutritionGuidesTableOrderingComposer
    extends Composer<_$AppDatabase, $NutritionGuidesTable> {
  $$NutritionGuidesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get content => $composableBuilder(
      column: $table.content, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnOrderings(column));
}

class $$NutritionGuidesTableAnnotationComposer
    extends Composer<_$AppDatabase, $NutritionGuidesTable> {
  $$NutritionGuidesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);
}

class $$NutritionGuidesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $NutritionGuidesTable,
    NutritionGuide,
    $$NutritionGuidesTableFilterComposer,
    $$NutritionGuidesTableOrderingComposer,
    $$NutritionGuidesTableAnnotationComposer,
    $$NutritionGuidesTableCreateCompanionBuilder,
    $$NutritionGuidesTableUpdateCompanionBuilder,
    (
      NutritionGuide,
      BaseReferences<_$AppDatabase, $NutritionGuidesTable, NutritionGuide>
    ),
    NutritionGuide,
    PrefetchHooks Function()> {
  $$NutritionGuidesTableTableManager(
      _$AppDatabase db, $NutritionGuidesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$NutritionGuidesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$NutritionGuidesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$NutritionGuidesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String> content = const Value.absent(),
            Value<String> category = const Value.absent(),
          }) =>
              NutritionGuidesCompanion(
            id: id,
            title: title,
            content: content,
            category: category,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String title,
            required String content,
            required String category,
          }) =>
              NutritionGuidesCompanion.insert(
            id: id,
            title: title,
            content: content,
            category: category,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$NutritionGuidesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $NutritionGuidesTable,
    NutritionGuide,
    $$NutritionGuidesTableFilterComposer,
    $$NutritionGuidesTableOrderingComposer,
    $$NutritionGuidesTableAnnotationComposer,
    $$NutritionGuidesTableCreateCompanionBuilder,
    $$NutritionGuidesTableUpdateCompanionBuilder,
    (
      NutritionGuide,
      BaseReferences<_$AppDatabase, $NutritionGuidesTable, NutritionGuide>
    ),
    NutritionGuide,
    PrefetchHooks Function()>;
typedef $$EnglishLessonsTableCreateCompanionBuilder = EnglishLessonsCompanion
    Function({
  Value<int> id,
  required int monthIndex,
  required int weekIndex,
  required String theme,
  required String grammarFocus,
  required String vocabFocus,
  required String content,
});
typedef $$EnglishLessonsTableUpdateCompanionBuilder = EnglishLessonsCompanion
    Function({
  Value<int> id,
  Value<int> monthIndex,
  Value<int> weekIndex,
  Value<String> theme,
  Value<String> grammarFocus,
  Value<String> vocabFocus,
  Value<String> content,
});

class $$EnglishLessonsTableFilterComposer
    extends Composer<_$AppDatabase, $EnglishLessonsTable> {
  $$EnglishLessonsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get monthIndex => $composableBuilder(
      column: $table.monthIndex, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get weekIndex => $composableBuilder(
      column: $table.weekIndex, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get theme => $composableBuilder(
      column: $table.theme, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get grammarFocus => $composableBuilder(
      column: $table.grammarFocus, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get vocabFocus => $composableBuilder(
      column: $table.vocabFocus, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get content => $composableBuilder(
      column: $table.content, builder: (column) => ColumnFilters(column));
}

class $$EnglishLessonsTableOrderingComposer
    extends Composer<_$AppDatabase, $EnglishLessonsTable> {
  $$EnglishLessonsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get monthIndex => $composableBuilder(
      column: $table.monthIndex, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get weekIndex => $composableBuilder(
      column: $table.weekIndex, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get theme => $composableBuilder(
      column: $table.theme, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get grammarFocus => $composableBuilder(
      column: $table.grammarFocus,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get vocabFocus => $composableBuilder(
      column: $table.vocabFocus, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get content => $composableBuilder(
      column: $table.content, builder: (column) => ColumnOrderings(column));
}

class $$EnglishLessonsTableAnnotationComposer
    extends Composer<_$AppDatabase, $EnglishLessonsTable> {
  $$EnglishLessonsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get monthIndex => $composableBuilder(
      column: $table.monthIndex, builder: (column) => column);

  GeneratedColumn<int> get weekIndex =>
      $composableBuilder(column: $table.weekIndex, builder: (column) => column);

  GeneratedColumn<String> get theme =>
      $composableBuilder(column: $table.theme, builder: (column) => column);

  GeneratedColumn<String> get grammarFocus => $composableBuilder(
      column: $table.grammarFocus, builder: (column) => column);

  GeneratedColumn<String> get vocabFocus => $composableBuilder(
      column: $table.vocabFocus, builder: (column) => column);

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);
}

class $$EnglishLessonsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $EnglishLessonsTable,
    EnglishLesson,
    $$EnglishLessonsTableFilterComposer,
    $$EnglishLessonsTableOrderingComposer,
    $$EnglishLessonsTableAnnotationComposer,
    $$EnglishLessonsTableCreateCompanionBuilder,
    $$EnglishLessonsTableUpdateCompanionBuilder,
    (
      EnglishLesson,
      BaseReferences<_$AppDatabase, $EnglishLessonsTable, EnglishLesson>
    ),
    EnglishLesson,
    PrefetchHooks Function()> {
  $$EnglishLessonsTableTableManager(
      _$AppDatabase db, $EnglishLessonsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EnglishLessonsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EnglishLessonsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EnglishLessonsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> monthIndex = const Value.absent(),
            Value<int> weekIndex = const Value.absent(),
            Value<String> theme = const Value.absent(),
            Value<String> grammarFocus = const Value.absent(),
            Value<String> vocabFocus = const Value.absent(),
            Value<String> content = const Value.absent(),
          }) =>
              EnglishLessonsCompanion(
            id: id,
            monthIndex: monthIndex,
            weekIndex: weekIndex,
            theme: theme,
            grammarFocus: grammarFocus,
            vocabFocus: vocabFocus,
            content: content,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int monthIndex,
            required int weekIndex,
            required String theme,
            required String grammarFocus,
            required String vocabFocus,
            required String content,
          }) =>
              EnglishLessonsCompanion.insert(
            id: id,
            monthIndex: monthIndex,
            weekIndex: weekIndex,
            theme: theme,
            grammarFocus: grammarFocus,
            vocabFocus: vocabFocus,
            content: content,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$EnglishLessonsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $EnglishLessonsTable,
    EnglishLesson,
    $$EnglishLessonsTableFilterComposer,
    $$EnglishLessonsTableOrderingComposer,
    $$EnglishLessonsTableAnnotationComposer,
    $$EnglishLessonsTableCreateCompanionBuilder,
    $$EnglishLessonsTableUpdateCompanionBuilder,
    (
      EnglishLesson,
      BaseReferences<_$AppDatabase, $EnglishLessonsTable, EnglishLesson>
    ),
    EnglishLesson,
    PrefetchHooks Function()>;
typedef $$VocabEntriesTableCreateCompanionBuilder = VocabEntriesCompanion
    Function({
  Value<int> id,
  required String word,
  required String meaning,
  Value<String?> example,
  required String date,
  Value<int> revisionCount,
  Value<DateTime?> lastReviewed,
});
typedef $$VocabEntriesTableUpdateCompanionBuilder = VocabEntriesCompanion
    Function({
  Value<int> id,
  Value<String> word,
  Value<String> meaning,
  Value<String?> example,
  Value<String> date,
  Value<int> revisionCount,
  Value<DateTime?> lastReviewed,
});

class $$VocabEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $VocabEntriesTable> {
  $$VocabEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get word => $composableBuilder(
      column: $table.word, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get meaning => $composableBuilder(
      column: $table.meaning, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get example => $composableBuilder(
      column: $table.example, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get revisionCount => $composableBuilder(
      column: $table.revisionCount, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastReviewed => $composableBuilder(
      column: $table.lastReviewed, builder: (column) => ColumnFilters(column));
}

class $$VocabEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $VocabEntriesTable> {
  $$VocabEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get word => $composableBuilder(
      column: $table.word, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get meaning => $composableBuilder(
      column: $table.meaning, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get example => $composableBuilder(
      column: $table.example, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get revisionCount => $composableBuilder(
      column: $table.revisionCount,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastReviewed => $composableBuilder(
      column: $table.lastReviewed,
      builder: (column) => ColumnOrderings(column));
}

class $$VocabEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $VocabEntriesTable> {
  $$VocabEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get word =>
      $composableBuilder(column: $table.word, builder: (column) => column);

  GeneratedColumn<String> get meaning =>
      $composableBuilder(column: $table.meaning, builder: (column) => column);

  GeneratedColumn<String> get example =>
      $composableBuilder(column: $table.example, builder: (column) => column);

  GeneratedColumn<String> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<int> get revisionCount => $composableBuilder(
      column: $table.revisionCount, builder: (column) => column);

  GeneratedColumn<DateTime> get lastReviewed => $composableBuilder(
      column: $table.lastReviewed, builder: (column) => column);
}

class $$VocabEntriesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $VocabEntriesTable,
    VocabEntry,
    $$VocabEntriesTableFilterComposer,
    $$VocabEntriesTableOrderingComposer,
    $$VocabEntriesTableAnnotationComposer,
    $$VocabEntriesTableCreateCompanionBuilder,
    $$VocabEntriesTableUpdateCompanionBuilder,
    (VocabEntry, BaseReferences<_$AppDatabase, $VocabEntriesTable, VocabEntry>),
    VocabEntry,
    PrefetchHooks Function()> {
  $$VocabEntriesTableTableManager(_$AppDatabase db, $VocabEntriesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$VocabEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$VocabEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$VocabEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> word = const Value.absent(),
            Value<String> meaning = const Value.absent(),
            Value<String?> example = const Value.absent(),
            Value<String> date = const Value.absent(),
            Value<int> revisionCount = const Value.absent(),
            Value<DateTime?> lastReviewed = const Value.absent(),
          }) =>
              VocabEntriesCompanion(
            id: id,
            word: word,
            meaning: meaning,
            example: example,
            date: date,
            revisionCount: revisionCount,
            lastReviewed: lastReviewed,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String word,
            required String meaning,
            Value<String?> example = const Value.absent(),
            required String date,
            Value<int> revisionCount = const Value.absent(),
            Value<DateTime?> lastReviewed = const Value.absent(),
          }) =>
              VocabEntriesCompanion.insert(
            id: id,
            word: word,
            meaning: meaning,
            example: example,
            date: date,
            revisionCount: revisionCount,
            lastReviewed: lastReviewed,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$VocabEntriesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $VocabEntriesTable,
    VocabEntry,
    $$VocabEntriesTableFilterComposer,
    $$VocabEntriesTableOrderingComposer,
    $$VocabEntriesTableAnnotationComposer,
    $$VocabEntriesTableCreateCompanionBuilder,
    $$VocabEntriesTableUpdateCompanionBuilder,
    (VocabEntry, BaseReferences<_$AppDatabase, $VocabEntriesTable, VocabEntry>),
    VocabEntry,
    PrefetchHooks Function()>;
typedef $$EnglishSessionsTableCreateCompanionBuilder = EnglishSessionsCompanion
    Function({
  Value<int> id,
  required String date,
  required int sessionNumber,
  Value<int> grammarMinutes,
  Value<int> vocabMinutes,
  Value<int> listeningMinutes,
  Value<int> readingMinutes,
  Value<int> speakingMinutes,
  Value<int> writingMinutes,
  Value<String?> notes,
  Value<String> status,
});
typedef $$EnglishSessionsTableUpdateCompanionBuilder = EnglishSessionsCompanion
    Function({
  Value<int> id,
  Value<String> date,
  Value<int> sessionNumber,
  Value<int> grammarMinutes,
  Value<int> vocabMinutes,
  Value<int> listeningMinutes,
  Value<int> readingMinutes,
  Value<int> speakingMinutes,
  Value<int> writingMinutes,
  Value<String?> notes,
  Value<String> status,
});

class $$EnglishSessionsTableFilterComposer
    extends Composer<_$AppDatabase, $EnglishSessionsTable> {
  $$EnglishSessionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get sessionNumber => $composableBuilder(
      column: $table.sessionNumber, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get grammarMinutes => $composableBuilder(
      column: $table.grammarMinutes,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get vocabMinutes => $composableBuilder(
      column: $table.vocabMinutes, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get listeningMinutes => $composableBuilder(
      column: $table.listeningMinutes,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get readingMinutes => $composableBuilder(
      column: $table.readingMinutes,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get speakingMinutes => $composableBuilder(
      column: $table.speakingMinutes,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get writingMinutes => $composableBuilder(
      column: $table.writingMinutes,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));
}

class $$EnglishSessionsTableOrderingComposer
    extends Composer<_$AppDatabase, $EnglishSessionsTable> {
  $$EnglishSessionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sessionNumber => $composableBuilder(
      column: $table.sessionNumber,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get grammarMinutes => $composableBuilder(
      column: $table.grammarMinutes,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get vocabMinutes => $composableBuilder(
      column: $table.vocabMinutes,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get listeningMinutes => $composableBuilder(
      column: $table.listeningMinutes,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get readingMinutes => $composableBuilder(
      column: $table.readingMinutes,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get speakingMinutes => $composableBuilder(
      column: $table.speakingMinutes,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get writingMinutes => $composableBuilder(
      column: $table.writingMinutes,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));
}

class $$EnglishSessionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $EnglishSessionsTable> {
  $$EnglishSessionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<int> get sessionNumber => $composableBuilder(
      column: $table.sessionNumber, builder: (column) => column);

  GeneratedColumn<int> get grammarMinutes => $composableBuilder(
      column: $table.grammarMinutes, builder: (column) => column);

  GeneratedColumn<int> get vocabMinutes => $composableBuilder(
      column: $table.vocabMinutes, builder: (column) => column);

  GeneratedColumn<int> get listeningMinutes => $composableBuilder(
      column: $table.listeningMinutes, builder: (column) => column);

  GeneratedColumn<int> get readingMinutes => $composableBuilder(
      column: $table.readingMinutes, builder: (column) => column);

  GeneratedColumn<int> get speakingMinutes => $composableBuilder(
      column: $table.speakingMinutes, builder: (column) => column);

  GeneratedColumn<int> get writingMinutes => $composableBuilder(
      column: $table.writingMinutes, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);
}

class $$EnglishSessionsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $EnglishSessionsTable,
    EnglishSession,
    $$EnglishSessionsTableFilterComposer,
    $$EnglishSessionsTableOrderingComposer,
    $$EnglishSessionsTableAnnotationComposer,
    $$EnglishSessionsTableCreateCompanionBuilder,
    $$EnglishSessionsTableUpdateCompanionBuilder,
    (
      EnglishSession,
      BaseReferences<_$AppDatabase, $EnglishSessionsTable, EnglishSession>
    ),
    EnglishSession,
    PrefetchHooks Function()> {
  $$EnglishSessionsTableTableManager(
      _$AppDatabase db, $EnglishSessionsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EnglishSessionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EnglishSessionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EnglishSessionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> date = const Value.absent(),
            Value<int> sessionNumber = const Value.absent(),
            Value<int> grammarMinutes = const Value.absent(),
            Value<int> vocabMinutes = const Value.absent(),
            Value<int> listeningMinutes = const Value.absent(),
            Value<int> readingMinutes = const Value.absent(),
            Value<int> speakingMinutes = const Value.absent(),
            Value<int> writingMinutes = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<String> status = const Value.absent(),
          }) =>
              EnglishSessionsCompanion(
            id: id,
            date: date,
            sessionNumber: sessionNumber,
            grammarMinutes: grammarMinutes,
            vocabMinutes: vocabMinutes,
            listeningMinutes: listeningMinutes,
            readingMinutes: readingMinutes,
            speakingMinutes: speakingMinutes,
            writingMinutes: writingMinutes,
            notes: notes,
            status: status,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String date,
            required int sessionNumber,
            Value<int> grammarMinutes = const Value.absent(),
            Value<int> vocabMinutes = const Value.absent(),
            Value<int> listeningMinutes = const Value.absent(),
            Value<int> readingMinutes = const Value.absent(),
            Value<int> speakingMinutes = const Value.absent(),
            Value<int> writingMinutes = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<String> status = const Value.absent(),
          }) =>
              EnglishSessionsCompanion.insert(
            id: id,
            date: date,
            sessionNumber: sessionNumber,
            grammarMinutes: grammarMinutes,
            vocabMinutes: vocabMinutes,
            listeningMinutes: listeningMinutes,
            readingMinutes: readingMinutes,
            speakingMinutes: speakingMinutes,
            writingMinutes: writingMinutes,
            notes: notes,
            status: status,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$EnglishSessionsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $EnglishSessionsTable,
    EnglishSession,
    $$EnglishSessionsTableFilterComposer,
    $$EnglishSessionsTableOrderingComposer,
    $$EnglishSessionsTableAnnotationComposer,
    $$EnglishSessionsTableCreateCompanionBuilder,
    $$EnglishSessionsTableUpdateCompanionBuilder,
    (
      EnglishSession,
      BaseReferences<_$AppDatabase, $EnglishSessionsTable, EnglishSession>
    ),
    EnglishSession,
    PrefetchHooks Function()>;
typedef $$EnglishAssessmentsTableCreateCompanionBuilder
    = EnglishAssessmentsCompanion Function({
  Value<int> id,
  required String date,
  required String type,
  required int score,
  Value<int> maxScore,
  Value<String?> notes,
  Value<String?> writingSample,
  Value<String?> recordingPath,
});
typedef $$EnglishAssessmentsTableUpdateCompanionBuilder
    = EnglishAssessmentsCompanion Function({
  Value<int> id,
  Value<String> date,
  Value<String> type,
  Value<int> score,
  Value<int> maxScore,
  Value<String?> notes,
  Value<String?> writingSample,
  Value<String?> recordingPath,
});

class $$EnglishAssessmentsTableFilterComposer
    extends Composer<_$AppDatabase, $EnglishAssessmentsTable> {
  $$EnglishAssessmentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get score => $composableBuilder(
      column: $table.score, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get maxScore => $composableBuilder(
      column: $table.maxScore, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get writingSample => $composableBuilder(
      column: $table.writingSample, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get recordingPath => $composableBuilder(
      column: $table.recordingPath, builder: (column) => ColumnFilters(column));
}

class $$EnglishAssessmentsTableOrderingComposer
    extends Composer<_$AppDatabase, $EnglishAssessmentsTable> {
  $$EnglishAssessmentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get score => $composableBuilder(
      column: $table.score, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get maxScore => $composableBuilder(
      column: $table.maxScore, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get writingSample => $composableBuilder(
      column: $table.writingSample,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get recordingPath => $composableBuilder(
      column: $table.recordingPath,
      builder: (column) => ColumnOrderings(column));
}

class $$EnglishAssessmentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $EnglishAssessmentsTable> {
  $$EnglishAssessmentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<int> get score =>
      $composableBuilder(column: $table.score, builder: (column) => column);

  GeneratedColumn<int> get maxScore =>
      $composableBuilder(column: $table.maxScore, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<String> get writingSample => $composableBuilder(
      column: $table.writingSample, builder: (column) => column);

  GeneratedColumn<String> get recordingPath => $composableBuilder(
      column: $table.recordingPath, builder: (column) => column);
}

class $$EnglishAssessmentsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $EnglishAssessmentsTable,
    EnglishAssessment,
    $$EnglishAssessmentsTableFilterComposer,
    $$EnglishAssessmentsTableOrderingComposer,
    $$EnglishAssessmentsTableAnnotationComposer,
    $$EnglishAssessmentsTableCreateCompanionBuilder,
    $$EnglishAssessmentsTableUpdateCompanionBuilder,
    (
      EnglishAssessment,
      BaseReferences<_$AppDatabase, $EnglishAssessmentsTable, EnglishAssessment>
    ),
    EnglishAssessment,
    PrefetchHooks Function()> {
  $$EnglishAssessmentsTableTableManager(
      _$AppDatabase db, $EnglishAssessmentsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EnglishAssessmentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EnglishAssessmentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EnglishAssessmentsTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> date = const Value.absent(),
            Value<String> type = const Value.absent(),
            Value<int> score = const Value.absent(),
            Value<int> maxScore = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<String?> writingSample = const Value.absent(),
            Value<String?> recordingPath = const Value.absent(),
          }) =>
              EnglishAssessmentsCompanion(
            id: id,
            date: date,
            type: type,
            score: score,
            maxScore: maxScore,
            notes: notes,
            writingSample: writingSample,
            recordingPath: recordingPath,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String date,
            required String type,
            required int score,
            Value<int> maxScore = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<String?> writingSample = const Value.absent(),
            Value<String?> recordingPath = const Value.absent(),
          }) =>
              EnglishAssessmentsCompanion.insert(
            id: id,
            date: date,
            type: type,
            score: score,
            maxScore: maxScore,
            notes: notes,
            writingSample: writingSample,
            recordingPath: recordingPath,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$EnglishAssessmentsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $EnglishAssessmentsTable,
    EnglishAssessment,
    $$EnglishAssessmentsTableFilterComposer,
    $$EnglishAssessmentsTableOrderingComposer,
    $$EnglishAssessmentsTableAnnotationComposer,
    $$EnglishAssessmentsTableCreateCompanionBuilder,
    $$EnglishAssessmentsTableUpdateCompanionBuilder,
    (
      EnglishAssessment,
      BaseReferences<_$AppDatabase, $EnglishAssessmentsTable, EnglishAssessment>
    ),
    EnglishAssessment,
    PrefetchHooks Function()>;
typedef $$RepairLessonsTableCreateCompanionBuilder = RepairLessonsCompanion
    Function({
  Value<int> id,
  required int monthIndex,
  required String title,
  required String content,
  required String lessonType,
  Value<bool> requiresEquipment,
  Value<String?> requiredEquipment,
  Value<bool> safetyCritical,
});
typedef $$RepairLessonsTableUpdateCompanionBuilder = RepairLessonsCompanion
    Function({
  Value<int> id,
  Value<int> monthIndex,
  Value<String> title,
  Value<String> content,
  Value<String> lessonType,
  Value<bool> requiresEquipment,
  Value<String?> requiredEquipment,
  Value<bool> safetyCritical,
});

class $$RepairLessonsTableFilterComposer
    extends Composer<_$AppDatabase, $RepairLessonsTable> {
  $$RepairLessonsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get monthIndex => $composableBuilder(
      column: $table.monthIndex, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get content => $composableBuilder(
      column: $table.content, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get lessonType => $composableBuilder(
      column: $table.lessonType, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get requiresEquipment => $composableBuilder(
      column: $table.requiresEquipment,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get requiredEquipment => $composableBuilder(
      column: $table.requiredEquipment,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get safetyCritical => $composableBuilder(
      column: $table.safetyCritical,
      builder: (column) => ColumnFilters(column));
}

class $$RepairLessonsTableOrderingComposer
    extends Composer<_$AppDatabase, $RepairLessonsTable> {
  $$RepairLessonsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get monthIndex => $composableBuilder(
      column: $table.monthIndex, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get content => $composableBuilder(
      column: $table.content, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get lessonType => $composableBuilder(
      column: $table.lessonType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get requiresEquipment => $composableBuilder(
      column: $table.requiresEquipment,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get requiredEquipment => $composableBuilder(
      column: $table.requiredEquipment,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get safetyCritical => $composableBuilder(
      column: $table.safetyCritical,
      builder: (column) => ColumnOrderings(column));
}

class $$RepairLessonsTableAnnotationComposer
    extends Composer<_$AppDatabase, $RepairLessonsTable> {
  $$RepairLessonsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get monthIndex => $composableBuilder(
      column: $table.monthIndex, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<String> get lessonType => $composableBuilder(
      column: $table.lessonType, builder: (column) => column);

  GeneratedColumn<bool> get requiresEquipment => $composableBuilder(
      column: $table.requiresEquipment, builder: (column) => column);

  GeneratedColumn<String> get requiredEquipment => $composableBuilder(
      column: $table.requiredEquipment, builder: (column) => column);

  GeneratedColumn<bool> get safetyCritical => $composableBuilder(
      column: $table.safetyCritical, builder: (column) => column);
}

class $$RepairLessonsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $RepairLessonsTable,
    RepairLesson,
    $$RepairLessonsTableFilterComposer,
    $$RepairLessonsTableOrderingComposer,
    $$RepairLessonsTableAnnotationComposer,
    $$RepairLessonsTableCreateCompanionBuilder,
    $$RepairLessonsTableUpdateCompanionBuilder,
    (
      RepairLesson,
      BaseReferences<_$AppDatabase, $RepairLessonsTable, RepairLesson>
    ),
    RepairLesson,
    PrefetchHooks Function()> {
  $$RepairLessonsTableTableManager(_$AppDatabase db, $RepairLessonsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RepairLessonsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RepairLessonsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RepairLessonsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> monthIndex = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String> content = const Value.absent(),
            Value<String> lessonType = const Value.absent(),
            Value<bool> requiresEquipment = const Value.absent(),
            Value<String?> requiredEquipment = const Value.absent(),
            Value<bool> safetyCritical = const Value.absent(),
          }) =>
              RepairLessonsCompanion(
            id: id,
            monthIndex: monthIndex,
            title: title,
            content: content,
            lessonType: lessonType,
            requiresEquipment: requiresEquipment,
            requiredEquipment: requiredEquipment,
            safetyCritical: safetyCritical,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int monthIndex,
            required String title,
            required String content,
            required String lessonType,
            Value<bool> requiresEquipment = const Value.absent(),
            Value<String?> requiredEquipment = const Value.absent(),
            Value<bool> safetyCritical = const Value.absent(),
          }) =>
              RepairLessonsCompanion.insert(
            id: id,
            monthIndex: monthIndex,
            title: title,
            content: content,
            lessonType: lessonType,
            requiresEquipment: requiresEquipment,
            requiredEquipment: requiredEquipment,
            safetyCritical: safetyCritical,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$RepairLessonsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $RepairLessonsTable,
    RepairLesson,
    $$RepairLessonsTableFilterComposer,
    $$RepairLessonsTableOrderingComposer,
    $$RepairLessonsTableAnnotationComposer,
    $$RepairLessonsTableCreateCompanionBuilder,
    $$RepairLessonsTableUpdateCompanionBuilder,
    (
      RepairLesson,
      BaseReferences<_$AppDatabase, $RepairLessonsTable, RepairLesson>
    ),
    RepairLesson,
    PrefetchHooks Function()>;
typedef $$ComponentsTableCreateCompanionBuilder = ComponentsCompanion Function({
  Value<int> id,
  required String name,
  required String description,
  Value<String?> typicalValues,
  Value<String?> notes,
});
typedef $$ComponentsTableUpdateCompanionBuilder = ComponentsCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<String> description,
  Value<String?> typicalValues,
  Value<String?> notes,
});

class $$ComponentsTableFilterComposer
    extends Composer<_$AppDatabase, $ComponentsTable> {
  $$ComponentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get typicalValues => $composableBuilder(
      column: $table.typicalValues, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));
}

class $$ComponentsTableOrderingComposer
    extends Composer<_$AppDatabase, $ComponentsTable> {
  $$ComponentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get typicalValues => $composableBuilder(
      column: $table.typicalValues,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));
}

class $$ComponentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ComponentsTable> {
  $$ComponentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<String> get typicalValues => $composableBuilder(
      column: $table.typicalValues, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);
}

class $$ComponentsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ComponentsTable,
    Component,
    $$ComponentsTableFilterComposer,
    $$ComponentsTableOrderingComposer,
    $$ComponentsTableAnnotationComposer,
    $$ComponentsTableCreateCompanionBuilder,
    $$ComponentsTableUpdateCompanionBuilder,
    (Component, BaseReferences<_$AppDatabase, $ComponentsTable, Component>),
    Component,
    PrefetchHooks Function()> {
  $$ComponentsTableTableManager(_$AppDatabase db, $ComponentsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ComponentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ComponentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ComponentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> description = const Value.absent(),
            Value<String?> typicalValues = const Value.absent(),
            Value<String?> notes = const Value.absent(),
          }) =>
              ComponentsCompanion(
            id: id,
            name: name,
            description: description,
            typicalValues: typicalValues,
            notes: notes,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            required String description,
            Value<String?> typicalValues = const Value.absent(),
            Value<String?> notes = const Value.absent(),
          }) =>
              ComponentsCompanion.insert(
            id: id,
            name: name,
            description: description,
            typicalValues: typicalValues,
            notes: notes,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ComponentsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ComponentsTable,
    Component,
    $$ComponentsTableFilterComposer,
    $$ComponentsTableOrderingComposer,
    $$ComponentsTableAnnotationComposer,
    $$ComponentsTableCreateCompanionBuilder,
    $$ComponentsTableUpdateCompanionBuilder,
    (Component, BaseReferences<_$AppDatabase, $ComponentsTable, Component>),
    Component,
    PrefetchHooks Function()>;
typedef $$EquipmentItemsTableCreateCompanionBuilder = EquipmentItemsCompanion
    Function({
  Value<int> id,
  required String name,
  Value<bool> owned,
  Value<String?> notes,
  Value<DateTime?> acquiredAt,
});
typedef $$EquipmentItemsTableUpdateCompanionBuilder = EquipmentItemsCompanion
    Function({
  Value<int> id,
  Value<String> name,
  Value<bool> owned,
  Value<String?> notes,
  Value<DateTime?> acquiredAt,
});

class $$EquipmentItemsTableFilterComposer
    extends Composer<_$AppDatabase, $EquipmentItemsTable> {
  $$EquipmentItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get owned => $composableBuilder(
      column: $table.owned, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get acquiredAt => $composableBuilder(
      column: $table.acquiredAt, builder: (column) => ColumnFilters(column));
}

class $$EquipmentItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $EquipmentItemsTable> {
  $$EquipmentItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get owned => $composableBuilder(
      column: $table.owned, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get acquiredAt => $composableBuilder(
      column: $table.acquiredAt, builder: (column) => ColumnOrderings(column));
}

class $$EquipmentItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $EquipmentItemsTable> {
  $$EquipmentItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<bool> get owned =>
      $composableBuilder(column: $table.owned, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get acquiredAt => $composableBuilder(
      column: $table.acquiredAt, builder: (column) => column);
}

class $$EquipmentItemsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $EquipmentItemsTable,
    EquipmentItem,
    $$EquipmentItemsTableFilterComposer,
    $$EquipmentItemsTableOrderingComposer,
    $$EquipmentItemsTableAnnotationComposer,
    $$EquipmentItemsTableCreateCompanionBuilder,
    $$EquipmentItemsTableUpdateCompanionBuilder,
    (
      EquipmentItem,
      BaseReferences<_$AppDatabase, $EquipmentItemsTable, EquipmentItem>
    ),
    EquipmentItem,
    PrefetchHooks Function()> {
  $$EquipmentItemsTableTableManager(
      _$AppDatabase db, $EquipmentItemsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EquipmentItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EquipmentItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EquipmentItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<bool> owned = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<DateTime?> acquiredAt = const Value.absent(),
          }) =>
              EquipmentItemsCompanion(
            id: id,
            name: name,
            owned: owned,
            notes: notes,
            acquiredAt: acquiredAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            Value<bool> owned = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<DateTime?> acquiredAt = const Value.absent(),
          }) =>
              EquipmentItemsCompanion.insert(
            id: id,
            name: name,
            owned: owned,
            notes: notes,
            acquiredAt: acquiredAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$EquipmentItemsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $EquipmentItemsTable,
    EquipmentItem,
    $$EquipmentItemsTableFilterComposer,
    $$EquipmentItemsTableOrderingComposer,
    $$EquipmentItemsTableAnnotationComposer,
    $$EquipmentItemsTableCreateCompanionBuilder,
    $$EquipmentItemsTableUpdateCompanionBuilder,
    (
      EquipmentItem,
      BaseReferences<_$AppDatabase, $EquipmentItemsTable, EquipmentItem>
    ),
    EquipmentItem,
    PrefetchHooks Function()>;
typedef $$RepairExercisesTableCreateCompanionBuilder = RepairExercisesCompanion
    Function({
  Value<int> id,
  required String title,
  required String instructions,
  Value<bool> locked,
  Value<String?> requiredEquipment,
  Value<String?> safetyNotes,
});
typedef $$RepairExercisesTableUpdateCompanionBuilder = RepairExercisesCompanion
    Function({
  Value<int> id,
  Value<String> title,
  Value<String> instructions,
  Value<bool> locked,
  Value<String?> requiredEquipment,
  Value<String?> safetyNotes,
});

class $$RepairExercisesTableFilterComposer
    extends Composer<_$AppDatabase, $RepairExercisesTable> {
  $$RepairExercisesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get instructions => $composableBuilder(
      column: $table.instructions, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get locked => $composableBuilder(
      column: $table.locked, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get requiredEquipment => $composableBuilder(
      column: $table.requiredEquipment,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get safetyNotes => $composableBuilder(
      column: $table.safetyNotes, builder: (column) => ColumnFilters(column));
}

class $$RepairExercisesTableOrderingComposer
    extends Composer<_$AppDatabase, $RepairExercisesTable> {
  $$RepairExercisesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get instructions => $composableBuilder(
      column: $table.instructions,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get locked => $composableBuilder(
      column: $table.locked, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get requiredEquipment => $composableBuilder(
      column: $table.requiredEquipment,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get safetyNotes => $composableBuilder(
      column: $table.safetyNotes, builder: (column) => ColumnOrderings(column));
}

class $$RepairExercisesTableAnnotationComposer
    extends Composer<_$AppDatabase, $RepairExercisesTable> {
  $$RepairExercisesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get instructions => $composableBuilder(
      column: $table.instructions, builder: (column) => column);

  GeneratedColumn<bool> get locked =>
      $composableBuilder(column: $table.locked, builder: (column) => column);

  GeneratedColumn<String> get requiredEquipment => $composableBuilder(
      column: $table.requiredEquipment, builder: (column) => column);

  GeneratedColumn<String> get safetyNotes => $composableBuilder(
      column: $table.safetyNotes, builder: (column) => column);
}

class $$RepairExercisesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $RepairExercisesTable,
    RepairExercise,
    $$RepairExercisesTableFilterComposer,
    $$RepairExercisesTableOrderingComposer,
    $$RepairExercisesTableAnnotationComposer,
    $$RepairExercisesTableCreateCompanionBuilder,
    $$RepairExercisesTableUpdateCompanionBuilder,
    (
      RepairExercise,
      BaseReferences<_$AppDatabase, $RepairExercisesTable, RepairExercise>
    ),
    RepairExercise,
    PrefetchHooks Function()> {
  $$RepairExercisesTableTableManager(
      _$AppDatabase db, $RepairExercisesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RepairExercisesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RepairExercisesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RepairExercisesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String> instructions = const Value.absent(),
            Value<bool> locked = const Value.absent(),
            Value<String?> requiredEquipment = const Value.absent(),
            Value<String?> safetyNotes = const Value.absent(),
          }) =>
              RepairExercisesCompanion(
            id: id,
            title: title,
            instructions: instructions,
            locked: locked,
            requiredEquipment: requiredEquipment,
            safetyNotes: safetyNotes,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String title,
            required String instructions,
            Value<bool> locked = const Value.absent(),
            Value<String?> requiredEquipment = const Value.absent(),
            Value<String?> safetyNotes = const Value.absent(),
          }) =>
              RepairExercisesCompanion.insert(
            id: id,
            title: title,
            instructions: instructions,
            locked: locked,
            requiredEquipment: requiredEquipment,
            safetyNotes: safetyNotes,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$RepairExercisesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $RepairExercisesTable,
    RepairExercise,
    $$RepairExercisesTableFilterComposer,
    $$RepairExercisesTableOrderingComposer,
    $$RepairExercisesTableAnnotationComposer,
    $$RepairExercisesTableCreateCompanionBuilder,
    $$RepairExercisesTableUpdateCompanionBuilder,
    (
      RepairExercise,
      BaseReferences<_$AppDatabase, $RepairExercisesTable, RepairExercise>
    ),
    RepairExercise,
    PrefetchHooks Function()>;
typedef $$MeasurementNotebookTableCreateCompanionBuilder
    = MeasurementNotebookCompanion Function({
  Value<int> id,
  required String date,
  required String point,
  required String value,
  Value<String?> unit,
  Value<String?> notes,
  Value<bool> unpoweredOnly,
});
typedef $$MeasurementNotebookTableUpdateCompanionBuilder
    = MeasurementNotebookCompanion Function({
  Value<int> id,
  Value<String> date,
  Value<String> point,
  Value<String> value,
  Value<String?> unit,
  Value<String?> notes,
  Value<bool> unpoweredOnly,
});

class $$MeasurementNotebookTableFilterComposer
    extends Composer<_$AppDatabase, $MeasurementNotebookTable> {
  $$MeasurementNotebookTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get point => $composableBuilder(
      column: $table.point, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get value => $composableBuilder(
      column: $table.value, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get unit => $composableBuilder(
      column: $table.unit, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get unpoweredOnly => $composableBuilder(
      column: $table.unpoweredOnly, builder: (column) => ColumnFilters(column));
}

class $$MeasurementNotebookTableOrderingComposer
    extends Composer<_$AppDatabase, $MeasurementNotebookTable> {
  $$MeasurementNotebookTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get point => $composableBuilder(
      column: $table.point, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get value => $composableBuilder(
      column: $table.value, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get unit => $composableBuilder(
      column: $table.unit, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get unpoweredOnly => $composableBuilder(
      column: $table.unpoweredOnly,
      builder: (column) => ColumnOrderings(column));
}

class $$MeasurementNotebookTableAnnotationComposer
    extends Composer<_$AppDatabase, $MeasurementNotebookTable> {
  $$MeasurementNotebookTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get point =>
      $composableBuilder(column: $table.point, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  GeneratedColumn<String> get unit =>
      $composableBuilder(column: $table.unit, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<bool> get unpoweredOnly => $composableBuilder(
      column: $table.unpoweredOnly, builder: (column) => column);
}

class $$MeasurementNotebookTableTableManager extends RootTableManager<
    _$AppDatabase,
    $MeasurementNotebookTable,
    MeasurementNotebookData,
    $$MeasurementNotebookTableFilterComposer,
    $$MeasurementNotebookTableOrderingComposer,
    $$MeasurementNotebookTableAnnotationComposer,
    $$MeasurementNotebookTableCreateCompanionBuilder,
    $$MeasurementNotebookTableUpdateCompanionBuilder,
    (
      MeasurementNotebookData,
      BaseReferences<_$AppDatabase, $MeasurementNotebookTable,
          MeasurementNotebookData>
    ),
    MeasurementNotebookData,
    PrefetchHooks Function()> {
  $$MeasurementNotebookTableTableManager(
      _$AppDatabase db, $MeasurementNotebookTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MeasurementNotebookTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MeasurementNotebookTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MeasurementNotebookTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> date = const Value.absent(),
            Value<String> point = const Value.absent(),
            Value<String> value = const Value.absent(),
            Value<String?> unit = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<bool> unpoweredOnly = const Value.absent(),
          }) =>
              MeasurementNotebookCompanion(
            id: id,
            date: date,
            point: point,
            value: value,
            unit: unit,
            notes: notes,
            unpoweredOnly: unpoweredOnly,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String date,
            required String point,
            required String value,
            Value<String?> unit = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<bool> unpoweredOnly = const Value.absent(),
          }) =>
              MeasurementNotebookCompanion.insert(
            id: id,
            date: date,
            point: point,
            value: value,
            unit: unit,
            notes: notes,
            unpoweredOnly: unpoweredOnly,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$MeasurementNotebookTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $MeasurementNotebookTable,
    MeasurementNotebookData,
    $$MeasurementNotebookTableFilterComposer,
    $$MeasurementNotebookTableOrderingComposer,
    $$MeasurementNotebookTableAnnotationComposer,
    $$MeasurementNotebookTableCreateCompanionBuilder,
    $$MeasurementNotebookTableUpdateCompanionBuilder,
    (
      MeasurementNotebookData,
      BaseReferences<_$AppDatabase, $MeasurementNotebookTable,
          MeasurementNotebookData>
    ),
    MeasurementNotebookData,
    PrefetchHooks Function()>;
typedef $$RepairCasesTableCreateCompanionBuilder = RepairCasesCompanion
    Function({
  Value<int> id,
  required String date,
  required String model,
  required String symptoms,
  Value<String?> diagnosis,
  Value<String?> workflow,
  Value<String?> parts,
  Value<String?> outcome,
  Value<String?> photoPath,
  Value<String?> notes,
});
typedef $$RepairCasesTableUpdateCompanionBuilder = RepairCasesCompanion
    Function({
  Value<int> id,
  Value<String> date,
  Value<String> model,
  Value<String> symptoms,
  Value<String?> diagnosis,
  Value<String?> workflow,
  Value<String?> parts,
  Value<String?> outcome,
  Value<String?> photoPath,
  Value<String?> notes,
});

class $$RepairCasesTableFilterComposer
    extends Composer<_$AppDatabase, $RepairCasesTable> {
  $$RepairCasesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get model => $composableBuilder(
      column: $table.model, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get symptoms => $composableBuilder(
      column: $table.symptoms, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get diagnosis => $composableBuilder(
      column: $table.diagnosis, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get workflow => $composableBuilder(
      column: $table.workflow, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get parts => $composableBuilder(
      column: $table.parts, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get outcome => $composableBuilder(
      column: $table.outcome, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get photoPath => $composableBuilder(
      column: $table.photoPath, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));
}

class $$RepairCasesTableOrderingComposer
    extends Composer<_$AppDatabase, $RepairCasesTable> {
  $$RepairCasesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get model => $composableBuilder(
      column: $table.model, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get symptoms => $composableBuilder(
      column: $table.symptoms, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get diagnosis => $composableBuilder(
      column: $table.diagnosis, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get workflow => $composableBuilder(
      column: $table.workflow, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get parts => $composableBuilder(
      column: $table.parts, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get outcome => $composableBuilder(
      column: $table.outcome, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get photoPath => $composableBuilder(
      column: $table.photoPath, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));
}

class $$RepairCasesTableAnnotationComposer
    extends Composer<_$AppDatabase, $RepairCasesTable> {
  $$RepairCasesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get model =>
      $composableBuilder(column: $table.model, builder: (column) => column);

  GeneratedColumn<String> get symptoms =>
      $composableBuilder(column: $table.symptoms, builder: (column) => column);

  GeneratedColumn<String> get diagnosis =>
      $composableBuilder(column: $table.diagnosis, builder: (column) => column);

  GeneratedColumn<String> get workflow =>
      $composableBuilder(column: $table.workflow, builder: (column) => column);

  GeneratedColumn<String> get parts =>
      $composableBuilder(column: $table.parts, builder: (column) => column);

  GeneratedColumn<String> get outcome =>
      $composableBuilder(column: $table.outcome, builder: (column) => column);

  GeneratedColumn<String> get photoPath =>
      $composableBuilder(column: $table.photoPath, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);
}

class $$RepairCasesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $RepairCasesTable,
    RepairCase,
    $$RepairCasesTableFilterComposer,
    $$RepairCasesTableOrderingComposer,
    $$RepairCasesTableAnnotationComposer,
    $$RepairCasesTableCreateCompanionBuilder,
    $$RepairCasesTableUpdateCompanionBuilder,
    (RepairCase, BaseReferences<_$AppDatabase, $RepairCasesTable, RepairCase>),
    RepairCase,
    PrefetchHooks Function()> {
  $$RepairCasesTableTableManager(_$AppDatabase db, $RepairCasesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RepairCasesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RepairCasesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RepairCasesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> date = const Value.absent(),
            Value<String> model = const Value.absent(),
            Value<String> symptoms = const Value.absent(),
            Value<String?> diagnosis = const Value.absent(),
            Value<String?> workflow = const Value.absent(),
            Value<String?> parts = const Value.absent(),
            Value<String?> outcome = const Value.absent(),
            Value<String?> photoPath = const Value.absent(),
            Value<String?> notes = const Value.absent(),
          }) =>
              RepairCasesCompanion(
            id: id,
            date: date,
            model: model,
            symptoms: symptoms,
            diagnosis: diagnosis,
            workflow: workflow,
            parts: parts,
            outcome: outcome,
            photoPath: photoPath,
            notes: notes,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String date,
            required String model,
            required String symptoms,
            Value<String?> diagnosis = const Value.absent(),
            Value<String?> workflow = const Value.absent(),
            Value<String?> parts = const Value.absent(),
            Value<String?> outcome = const Value.absent(),
            Value<String?> photoPath = const Value.absent(),
            Value<String?> notes = const Value.absent(),
          }) =>
              RepairCasesCompanion.insert(
            id: id,
            date: date,
            model: model,
            symptoms: symptoms,
            diagnosis: diagnosis,
            workflow: workflow,
            parts: parts,
            outcome: outcome,
            photoPath: photoPath,
            notes: notes,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$RepairCasesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $RepairCasesTable,
    RepairCase,
    $$RepairCasesTableFilterComposer,
    $$RepairCasesTableOrderingComposer,
    $$RepairCasesTableAnnotationComposer,
    $$RepairCasesTableCreateCompanionBuilder,
    $$RepairCasesTableUpdateCompanionBuilder,
    (RepairCase, BaseReferences<_$AppDatabase, $RepairCasesTable, RepairCase>),
    RepairCase,
    PrefetchHooks Function()>;
typedef $$AppearanceRoutinesTableCreateCompanionBuilder
    = AppearanceRoutinesCompanion Function({
  Value<int> id,
  required String date,
  required String routineType,
  required String checklistJson,
  Value<String> status,
  Value<DateTime?> completedAt,
});
typedef $$AppearanceRoutinesTableUpdateCompanionBuilder
    = AppearanceRoutinesCompanion Function({
  Value<int> id,
  Value<String> date,
  Value<String> routineType,
  Value<String> checklistJson,
  Value<String> status,
  Value<DateTime?> completedAt,
});

class $$AppearanceRoutinesTableFilterComposer
    extends Composer<_$AppDatabase, $AppearanceRoutinesTable> {
  $$AppearanceRoutinesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get routineType => $composableBuilder(
      column: $table.routineType, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get checklistJson => $composableBuilder(
      column: $table.checklistJson, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
      column: $table.completedAt, builder: (column) => ColumnFilters(column));
}

class $$AppearanceRoutinesTableOrderingComposer
    extends Composer<_$AppDatabase, $AppearanceRoutinesTable> {
  $$AppearanceRoutinesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get routineType => $composableBuilder(
      column: $table.routineType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get checklistJson => $composableBuilder(
      column: $table.checklistJson,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
      column: $table.completedAt, builder: (column) => ColumnOrderings(column));
}

class $$AppearanceRoutinesTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppearanceRoutinesTable> {
  $$AppearanceRoutinesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get routineType => $composableBuilder(
      column: $table.routineType, builder: (column) => column);

  GeneratedColumn<String> get checklistJson => $composableBuilder(
      column: $table.checklistJson, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
      column: $table.completedAt, builder: (column) => column);
}

class $$AppearanceRoutinesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $AppearanceRoutinesTable,
    AppearanceRoutine,
    $$AppearanceRoutinesTableFilterComposer,
    $$AppearanceRoutinesTableOrderingComposer,
    $$AppearanceRoutinesTableAnnotationComposer,
    $$AppearanceRoutinesTableCreateCompanionBuilder,
    $$AppearanceRoutinesTableUpdateCompanionBuilder,
    (
      AppearanceRoutine,
      BaseReferences<_$AppDatabase, $AppearanceRoutinesTable, AppearanceRoutine>
    ),
    AppearanceRoutine,
    PrefetchHooks Function()> {
  $$AppearanceRoutinesTableTableManager(
      _$AppDatabase db, $AppearanceRoutinesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppearanceRoutinesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppearanceRoutinesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppearanceRoutinesTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> date = const Value.absent(),
            Value<String> routineType = const Value.absent(),
            Value<String> checklistJson = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<DateTime?> completedAt = const Value.absent(),
          }) =>
              AppearanceRoutinesCompanion(
            id: id,
            date: date,
            routineType: routineType,
            checklistJson: checklistJson,
            status: status,
            completedAt: completedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String date,
            required String routineType,
            required String checklistJson,
            Value<String> status = const Value.absent(),
            Value<DateTime?> completedAt = const Value.absent(),
          }) =>
              AppearanceRoutinesCompanion.insert(
            id: id,
            date: date,
            routineType: routineType,
            checklistJson: checklistJson,
            status: status,
            completedAt: completedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$AppearanceRoutinesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $AppearanceRoutinesTable,
    AppearanceRoutine,
    $$AppearanceRoutinesTableFilterComposer,
    $$AppearanceRoutinesTableOrderingComposer,
    $$AppearanceRoutinesTableAnnotationComposer,
    $$AppearanceRoutinesTableCreateCompanionBuilder,
    $$AppearanceRoutinesTableUpdateCompanionBuilder,
    (
      AppearanceRoutine,
      BaseReferences<_$AppDatabase, $AppearanceRoutinesTable, AppearanceRoutine>
    ),
    AppearanceRoutine,
    PrefetchHooks Function()>;
typedef $$AppearanceProductsTableCreateCompanionBuilder
    = AppearanceProductsCompanion Function({
  Value<int> id,
  required String name,
  required String category,
  Value<String?> brand,
  Value<double?> priceMad,
  Value<bool> owned,
  Value<String?> notes,
});
typedef $$AppearanceProductsTableUpdateCompanionBuilder
    = AppearanceProductsCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<String> category,
  Value<String?> brand,
  Value<double?> priceMad,
  Value<bool> owned,
  Value<String?> notes,
});

class $$AppearanceProductsTableFilterComposer
    extends Composer<_$AppDatabase, $AppearanceProductsTable> {
  $$AppearanceProductsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get brand => $composableBuilder(
      column: $table.brand, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get priceMad => $composableBuilder(
      column: $table.priceMad, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get owned => $composableBuilder(
      column: $table.owned, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));
}

class $$AppearanceProductsTableOrderingComposer
    extends Composer<_$AppDatabase, $AppearanceProductsTable> {
  $$AppearanceProductsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get brand => $composableBuilder(
      column: $table.brand, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get priceMad => $composableBuilder(
      column: $table.priceMad, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get owned => $composableBuilder(
      column: $table.owned, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));
}

class $$AppearanceProductsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppearanceProductsTable> {
  $$AppearanceProductsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get brand =>
      $composableBuilder(column: $table.brand, builder: (column) => column);

  GeneratedColumn<double> get priceMad =>
      $composableBuilder(column: $table.priceMad, builder: (column) => column);

  GeneratedColumn<bool> get owned =>
      $composableBuilder(column: $table.owned, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);
}

class $$AppearanceProductsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $AppearanceProductsTable,
    AppearanceProduct,
    $$AppearanceProductsTableFilterComposer,
    $$AppearanceProductsTableOrderingComposer,
    $$AppearanceProductsTableAnnotationComposer,
    $$AppearanceProductsTableCreateCompanionBuilder,
    $$AppearanceProductsTableUpdateCompanionBuilder,
    (
      AppearanceProduct,
      BaseReferences<_$AppDatabase, $AppearanceProductsTable, AppearanceProduct>
    ),
    AppearanceProduct,
    PrefetchHooks Function()> {
  $$AppearanceProductsTableTableManager(
      _$AppDatabase db, $AppearanceProductsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppearanceProductsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppearanceProductsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppearanceProductsTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> category = const Value.absent(),
            Value<String?> brand = const Value.absent(),
            Value<double?> priceMad = const Value.absent(),
            Value<bool> owned = const Value.absent(),
            Value<String?> notes = const Value.absent(),
          }) =>
              AppearanceProductsCompanion(
            id: id,
            name: name,
            category: category,
            brand: brand,
            priceMad: priceMad,
            owned: owned,
            notes: notes,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            required String category,
            Value<String?> brand = const Value.absent(),
            Value<double?> priceMad = const Value.absent(),
            Value<bool> owned = const Value.absent(),
            Value<String?> notes = const Value.absent(),
          }) =>
              AppearanceProductsCompanion.insert(
            id: id,
            name: name,
            category: category,
            brand: brand,
            priceMad: priceMad,
            owned: owned,
            notes: notes,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$AppearanceProductsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $AppearanceProductsTable,
    AppearanceProduct,
    $$AppearanceProductsTableFilterComposer,
    $$AppearanceProductsTableOrderingComposer,
    $$AppearanceProductsTableAnnotationComposer,
    $$AppearanceProductsTableCreateCompanionBuilder,
    $$AppearanceProductsTableUpdateCompanionBuilder,
    (
      AppearanceProduct,
      BaseReferences<_$AppDatabase, $AppearanceProductsTable, AppearanceProduct>
    ),
    AppearanceProduct,
    PrefetchHooks Function()>;
typedef $$AppearancePhotosTableCreateCompanionBuilder
    = AppearancePhotosCompanion Function({
  Value<int> id,
  required String date,
  required String angle,
  required String filePath,
  Value<String?> notes,
});
typedef $$AppearancePhotosTableUpdateCompanionBuilder
    = AppearancePhotosCompanion Function({
  Value<int> id,
  Value<String> date,
  Value<String> angle,
  Value<String> filePath,
  Value<String?> notes,
});

class $$AppearancePhotosTableFilterComposer
    extends Composer<_$AppDatabase, $AppearancePhotosTable> {
  $$AppearancePhotosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get angle => $composableBuilder(
      column: $table.angle, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get filePath => $composableBuilder(
      column: $table.filePath, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));
}

class $$AppearancePhotosTableOrderingComposer
    extends Composer<_$AppDatabase, $AppearancePhotosTable> {
  $$AppearancePhotosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get angle => $composableBuilder(
      column: $table.angle, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get filePath => $composableBuilder(
      column: $table.filePath, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));
}

class $$AppearancePhotosTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppearancePhotosTable> {
  $$AppearancePhotosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get angle =>
      $composableBuilder(column: $table.angle, builder: (column) => column);

  GeneratedColumn<String> get filePath =>
      $composableBuilder(column: $table.filePath, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);
}

class $$AppearancePhotosTableTableManager extends RootTableManager<
    _$AppDatabase,
    $AppearancePhotosTable,
    AppearancePhoto,
    $$AppearancePhotosTableFilterComposer,
    $$AppearancePhotosTableOrderingComposer,
    $$AppearancePhotosTableAnnotationComposer,
    $$AppearancePhotosTableCreateCompanionBuilder,
    $$AppearancePhotosTableUpdateCompanionBuilder,
    (
      AppearancePhoto,
      BaseReferences<_$AppDatabase, $AppearancePhotosTable, AppearancePhoto>
    ),
    AppearancePhoto,
    PrefetchHooks Function()> {
  $$AppearancePhotosTableTableManager(
      _$AppDatabase db, $AppearancePhotosTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppearancePhotosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppearancePhotosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppearancePhotosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> date = const Value.absent(),
            Value<String> angle = const Value.absent(),
            Value<String> filePath = const Value.absent(),
            Value<String?> notes = const Value.absent(),
          }) =>
              AppearancePhotosCompanion(
            id: id,
            date: date,
            angle: angle,
            filePath: filePath,
            notes: notes,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String date,
            required String angle,
            required String filePath,
            Value<String?> notes = const Value.absent(),
          }) =>
              AppearancePhotosCompanion.insert(
            id: id,
            date: date,
            angle: angle,
            filePath: filePath,
            notes: notes,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$AppearancePhotosTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $AppearancePhotosTable,
    AppearancePhoto,
    $$AppearancePhotosTableFilterComposer,
    $$AppearancePhotosTableOrderingComposer,
    $$AppearancePhotosTableAnnotationComposer,
    $$AppearancePhotosTableCreateCompanionBuilder,
    $$AppearancePhotosTableUpdateCompanionBuilder,
    (
      AppearancePhoto,
      BaseReferences<_$AppDatabase, $AppearancePhotosTable, AppearancePhoto>
    ),
    AppearancePhoto,
    PrefetchHooks Function()>;
typedef $$GroomingRecordsTableCreateCompanionBuilder = GroomingRecordsCompanion
    Function({
  Value<int> id,
  required String date,
  required String type,
  required String details,
  Value<String?> condition,
});
typedef $$GroomingRecordsTableUpdateCompanionBuilder = GroomingRecordsCompanion
    Function({
  Value<int> id,
  Value<String> date,
  Value<String> type,
  Value<String> details,
  Value<String?> condition,
});

class $$GroomingRecordsTableFilterComposer
    extends Composer<_$AppDatabase, $GroomingRecordsTable> {
  $$GroomingRecordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get details => $composableBuilder(
      column: $table.details, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get condition => $composableBuilder(
      column: $table.condition, builder: (column) => ColumnFilters(column));
}

class $$GroomingRecordsTableOrderingComposer
    extends Composer<_$AppDatabase, $GroomingRecordsTable> {
  $$GroomingRecordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get details => $composableBuilder(
      column: $table.details, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get condition => $composableBuilder(
      column: $table.condition, builder: (column) => ColumnOrderings(column));
}

class $$GroomingRecordsTableAnnotationComposer
    extends Composer<_$AppDatabase, $GroomingRecordsTable> {
  $$GroomingRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get details =>
      $composableBuilder(column: $table.details, builder: (column) => column);

  GeneratedColumn<String> get condition =>
      $composableBuilder(column: $table.condition, builder: (column) => column);
}

class $$GroomingRecordsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $GroomingRecordsTable,
    GroomingRecord,
    $$GroomingRecordsTableFilterComposer,
    $$GroomingRecordsTableOrderingComposer,
    $$GroomingRecordsTableAnnotationComposer,
    $$GroomingRecordsTableCreateCompanionBuilder,
    $$GroomingRecordsTableUpdateCompanionBuilder,
    (
      GroomingRecord,
      BaseReferences<_$AppDatabase, $GroomingRecordsTable, GroomingRecord>
    ),
    GroomingRecord,
    PrefetchHooks Function()> {
  $$GroomingRecordsTableTableManager(
      _$AppDatabase db, $GroomingRecordsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GroomingRecordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GroomingRecordsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GroomingRecordsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> date = const Value.absent(),
            Value<String> type = const Value.absent(),
            Value<String> details = const Value.absent(),
            Value<String?> condition = const Value.absent(),
          }) =>
              GroomingRecordsCompanion(
            id: id,
            date: date,
            type: type,
            details: details,
            condition: condition,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String date,
            required String type,
            required String details,
            Value<String?> condition = const Value.absent(),
          }) =>
              GroomingRecordsCompanion.insert(
            id: id,
            date: date,
            type: type,
            details: details,
            condition: condition,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$GroomingRecordsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $GroomingRecordsTable,
    GroomingRecord,
    $$GroomingRecordsTableFilterComposer,
    $$GroomingRecordsTableOrderingComposer,
    $$GroomingRecordsTableAnnotationComposer,
    $$GroomingRecordsTableCreateCompanionBuilder,
    $$GroomingRecordsTableUpdateCompanionBuilder,
    (
      GroomingRecord,
      BaseReferences<_$AppDatabase, $GroomingRecordsTable, GroomingRecord>
    ),
    GroomingRecord,
    PrefetchHooks Function()>;
typedef $$ReviewsTableCreateCompanionBuilder = ReviewsCompanion Function({
  Value<int> id,
  required String date,
  required String type,
  required String content,
  Value<double?> consistencyScore,
  Value<double?> achievementScore,
});
typedef $$ReviewsTableUpdateCompanionBuilder = ReviewsCompanion Function({
  Value<int> id,
  Value<String> date,
  Value<String> type,
  Value<String> content,
  Value<double?> consistencyScore,
  Value<double?> achievementScore,
});

class $$ReviewsTableFilterComposer
    extends Composer<_$AppDatabase, $ReviewsTable> {
  $$ReviewsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get content => $composableBuilder(
      column: $table.content, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get consistencyScore => $composableBuilder(
      column: $table.consistencyScore,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get achievementScore => $composableBuilder(
      column: $table.achievementScore,
      builder: (column) => ColumnFilters(column));
}

class $$ReviewsTableOrderingComposer
    extends Composer<_$AppDatabase, $ReviewsTable> {
  $$ReviewsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get content => $composableBuilder(
      column: $table.content, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get consistencyScore => $composableBuilder(
      column: $table.consistencyScore,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get achievementScore => $composableBuilder(
      column: $table.achievementScore,
      builder: (column) => ColumnOrderings(column));
}

class $$ReviewsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ReviewsTable> {
  $$ReviewsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<double> get consistencyScore => $composableBuilder(
      column: $table.consistencyScore, builder: (column) => column);

  GeneratedColumn<double> get achievementScore => $composableBuilder(
      column: $table.achievementScore, builder: (column) => column);
}

class $$ReviewsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ReviewsTable,
    Review,
    $$ReviewsTableFilterComposer,
    $$ReviewsTableOrderingComposer,
    $$ReviewsTableAnnotationComposer,
    $$ReviewsTableCreateCompanionBuilder,
    $$ReviewsTableUpdateCompanionBuilder,
    (Review, BaseReferences<_$AppDatabase, $ReviewsTable, Review>),
    Review,
    PrefetchHooks Function()> {
  $$ReviewsTableTableManager(_$AppDatabase db, $ReviewsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ReviewsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ReviewsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ReviewsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> date = const Value.absent(),
            Value<String> type = const Value.absent(),
            Value<String> content = const Value.absent(),
            Value<double?> consistencyScore = const Value.absent(),
            Value<double?> achievementScore = const Value.absent(),
          }) =>
              ReviewsCompanion(
            id: id,
            date: date,
            type: type,
            content: content,
            consistencyScore: consistencyScore,
            achievementScore: achievementScore,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String date,
            required String type,
            required String content,
            Value<double?> consistencyScore = const Value.absent(),
            Value<double?> achievementScore = const Value.absent(),
          }) =>
              ReviewsCompanion.insert(
            id: id,
            date: date,
            type: type,
            content: content,
            consistencyScore: consistencyScore,
            achievementScore: achievementScore,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ReviewsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ReviewsTable,
    Review,
    $$ReviewsTableFilterComposer,
    $$ReviewsTableOrderingComposer,
    $$ReviewsTableAnnotationComposer,
    $$ReviewsTableCreateCompanionBuilder,
    $$ReviewsTableUpdateCompanionBuilder,
    (Review, BaseReferences<_$AppDatabase, $ReviewsTable, Review>),
    Review,
    PrefetchHooks Function()>;
typedef $$AchievementsTableCreateCompanionBuilder = AchievementsCompanion
    Function({
  Value<int> id,
  required String code,
  required String title,
  required String description,
  Value<DateTime?> unlockedAt,
  Value<bool> unlocked,
});
typedef $$AchievementsTableUpdateCompanionBuilder = AchievementsCompanion
    Function({
  Value<int> id,
  Value<String> code,
  Value<String> title,
  Value<String> description,
  Value<DateTime?> unlockedAt,
  Value<bool> unlocked,
});

class $$AchievementsTableFilterComposer
    extends Composer<_$AppDatabase, $AchievementsTable> {
  $$AchievementsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get code => $composableBuilder(
      column: $table.code, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get unlockedAt => $composableBuilder(
      column: $table.unlockedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get unlocked => $composableBuilder(
      column: $table.unlocked, builder: (column) => ColumnFilters(column));
}

class $$AchievementsTableOrderingComposer
    extends Composer<_$AppDatabase, $AchievementsTable> {
  $$AchievementsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get code => $composableBuilder(
      column: $table.code, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get unlockedAt => $composableBuilder(
      column: $table.unlockedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get unlocked => $composableBuilder(
      column: $table.unlocked, builder: (column) => ColumnOrderings(column));
}

class $$AchievementsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AchievementsTable> {
  $$AchievementsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<DateTime> get unlockedAt => $composableBuilder(
      column: $table.unlockedAt, builder: (column) => column);

  GeneratedColumn<bool> get unlocked =>
      $composableBuilder(column: $table.unlocked, builder: (column) => column);
}

class $$AchievementsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $AchievementsTable,
    Achievement,
    $$AchievementsTableFilterComposer,
    $$AchievementsTableOrderingComposer,
    $$AchievementsTableAnnotationComposer,
    $$AchievementsTableCreateCompanionBuilder,
    $$AchievementsTableUpdateCompanionBuilder,
    (
      Achievement,
      BaseReferences<_$AppDatabase, $AchievementsTable, Achievement>
    ),
    Achievement,
    PrefetchHooks Function()> {
  $$AchievementsTableTableManager(_$AppDatabase db, $AchievementsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AchievementsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AchievementsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AchievementsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> code = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String> description = const Value.absent(),
            Value<DateTime?> unlockedAt = const Value.absent(),
            Value<bool> unlocked = const Value.absent(),
          }) =>
              AchievementsCompanion(
            id: id,
            code: code,
            title: title,
            description: description,
            unlockedAt: unlockedAt,
            unlocked: unlocked,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String code,
            required String title,
            required String description,
            Value<DateTime?> unlockedAt = const Value.absent(),
            Value<bool> unlocked = const Value.absent(),
          }) =>
              AchievementsCompanion.insert(
            id: id,
            code: code,
            title: title,
            description: description,
            unlockedAt: unlockedAt,
            unlocked: unlocked,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$AchievementsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $AchievementsTable,
    Achievement,
    $$AchievementsTableFilterComposer,
    $$AchievementsTableOrderingComposer,
    $$AchievementsTableAnnotationComposer,
    $$AchievementsTableCreateCompanionBuilder,
    $$AchievementsTableUpdateCompanionBuilder,
    (
      Achievement,
      BaseReferences<_$AppDatabase, $AchievementsTable, Achievement>
    ),
    Achievement,
    PrefetchHooks Function()>;
typedef $$NotificationPrefsTableCreateCompanionBuilder
    = NotificationPrefsCompanion Function({
  Value<int> id,
  required String key,
  required String title,
  required String body,
  required String timeHhMm,
  Value<bool> enabled,
});
typedef $$NotificationPrefsTableUpdateCompanionBuilder
    = NotificationPrefsCompanion Function({
  Value<int> id,
  Value<String> key,
  Value<String> title,
  Value<String> body,
  Value<String> timeHhMm,
  Value<bool> enabled,
});

class $$NotificationPrefsTableFilterComposer
    extends Composer<_$AppDatabase, $NotificationPrefsTable> {
  $$NotificationPrefsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get key => $composableBuilder(
      column: $table.key, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get body => $composableBuilder(
      column: $table.body, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get timeHhMm => $composableBuilder(
      column: $table.timeHhMm, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get enabled => $composableBuilder(
      column: $table.enabled, builder: (column) => ColumnFilters(column));
}

class $$NotificationPrefsTableOrderingComposer
    extends Composer<_$AppDatabase, $NotificationPrefsTable> {
  $$NotificationPrefsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get key => $composableBuilder(
      column: $table.key, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get body => $composableBuilder(
      column: $table.body, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get timeHhMm => $composableBuilder(
      column: $table.timeHhMm, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get enabled => $composableBuilder(
      column: $table.enabled, builder: (column) => ColumnOrderings(column));
}

class $$NotificationPrefsTableAnnotationComposer
    extends Composer<_$AppDatabase, $NotificationPrefsTable> {
  $$NotificationPrefsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get body =>
      $composableBuilder(column: $table.body, builder: (column) => column);

  GeneratedColumn<String> get timeHhMm =>
      $composableBuilder(column: $table.timeHhMm, builder: (column) => column);

  GeneratedColumn<bool> get enabled =>
      $composableBuilder(column: $table.enabled, builder: (column) => column);
}

class $$NotificationPrefsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $NotificationPrefsTable,
    NotificationPref,
    $$NotificationPrefsTableFilterComposer,
    $$NotificationPrefsTableOrderingComposer,
    $$NotificationPrefsTableAnnotationComposer,
    $$NotificationPrefsTableCreateCompanionBuilder,
    $$NotificationPrefsTableUpdateCompanionBuilder,
    (
      NotificationPref,
      BaseReferences<_$AppDatabase, $NotificationPrefsTable, NotificationPref>
    ),
    NotificationPref,
    PrefetchHooks Function()> {
  $$NotificationPrefsTableTableManager(
      _$AppDatabase db, $NotificationPrefsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$NotificationPrefsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$NotificationPrefsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$NotificationPrefsTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> key = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String> body = const Value.absent(),
            Value<String> timeHhMm = const Value.absent(),
            Value<bool> enabled = const Value.absent(),
          }) =>
              NotificationPrefsCompanion(
            id: id,
            key: key,
            title: title,
            body: body,
            timeHhMm: timeHhMm,
            enabled: enabled,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String key,
            required String title,
            required String body,
            required String timeHhMm,
            Value<bool> enabled = const Value.absent(),
          }) =>
              NotificationPrefsCompanion.insert(
            id: id,
            key: key,
            title: title,
            body: body,
            timeHhMm: timeHhMm,
            enabled: enabled,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$NotificationPrefsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $NotificationPrefsTable,
    NotificationPref,
    $$NotificationPrefsTableFilterComposer,
    $$NotificationPrefsTableOrderingComposer,
    $$NotificationPrefsTableAnnotationComposer,
    $$NotificationPrefsTableCreateCompanionBuilder,
    $$NotificationPrefsTableUpdateCompanionBuilder,
    (
      NotificationPref,
      BaseReferences<_$AppDatabase, $NotificationPrefsTable, NotificationPref>
    ),
    NotificationPref,
    PrefetchHooks Function()>;
typedef $$BackupMetadataTableCreateCompanionBuilder = BackupMetadataCompanion
    Function({
  Value<int> id,
  required String version,
  required DateTime createdAt,
  Value<String?> path,
  Value<String?> notes,
});
typedef $$BackupMetadataTableUpdateCompanionBuilder = BackupMetadataCompanion
    Function({
  Value<int> id,
  Value<String> version,
  Value<DateTime> createdAt,
  Value<String?> path,
  Value<String?> notes,
});

class $$BackupMetadataTableFilterComposer
    extends Composer<_$AppDatabase, $BackupMetadataTable> {
  $$BackupMetadataTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get version => $composableBuilder(
      column: $table.version, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get path => $composableBuilder(
      column: $table.path, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));
}

class $$BackupMetadataTableOrderingComposer
    extends Composer<_$AppDatabase, $BackupMetadataTable> {
  $$BackupMetadataTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get version => $composableBuilder(
      column: $table.version, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get path => $composableBuilder(
      column: $table.path, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));
}

class $$BackupMetadataTableAnnotationComposer
    extends Composer<_$AppDatabase, $BackupMetadataTable> {
  $$BackupMetadataTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get path =>
      $composableBuilder(column: $table.path, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);
}

class $$BackupMetadataTableTableManager extends RootTableManager<
    _$AppDatabase,
    $BackupMetadataTable,
    BackupMetadataData,
    $$BackupMetadataTableFilterComposer,
    $$BackupMetadataTableOrderingComposer,
    $$BackupMetadataTableAnnotationComposer,
    $$BackupMetadataTableCreateCompanionBuilder,
    $$BackupMetadataTableUpdateCompanionBuilder,
    (
      BackupMetadataData,
      BaseReferences<_$AppDatabase, $BackupMetadataTable, BackupMetadataData>
    ),
    BackupMetadataData,
    PrefetchHooks Function()> {
  $$BackupMetadataTableTableManager(
      _$AppDatabase db, $BackupMetadataTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BackupMetadataTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BackupMetadataTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BackupMetadataTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> version = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<String?> path = const Value.absent(),
            Value<String?> notes = const Value.absent(),
          }) =>
              BackupMetadataCompanion(
            id: id,
            version: version,
            createdAt: createdAt,
            path: path,
            notes: notes,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String version,
            required DateTime createdAt,
            Value<String?> path = const Value.absent(),
            Value<String?> notes = const Value.absent(),
          }) =>
              BackupMetadataCompanion.insert(
            id: id,
            version: version,
            createdAt: createdAt,
            path: path,
            notes: notes,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$BackupMetadataTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $BackupMetadataTable,
    BackupMetadataData,
    $$BackupMetadataTableFilterComposer,
    $$BackupMetadataTableOrderingComposer,
    $$BackupMetadataTableAnnotationComposer,
    $$BackupMetadataTableCreateCompanionBuilder,
    $$BackupMetadataTableUpdateCompanionBuilder,
    (
      BackupMetadataData,
      BaseReferences<_$AppDatabase, $BackupMetadataTable, BackupMetadataData>
    ),
    BackupMetadataData,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ProfilesTableTableManager get profiles =>
      $$ProfilesTableTableManager(_db, _db.profiles);
  $$AppSettingsTableTableManager get appSettings =>
      $$AppSettingsTableTableManager(_db, _db.appSettings);
  $$GoalsTableTableManager get goals =>
      $$GoalsTableTableManager(_db, _db.goals);
  $$RoadmapMonthsTableTableManager get roadmapMonths =>
      $$RoadmapMonthsTableTableManager(_db, _db.roadmapMonths);
  $$ScheduleBlocksTableTableManager get scheduleBlocks =>
      $$ScheduleBlocksTableTableManager(_db, _db.scheduleBlocks);
  $$ScheduleHistoryTableTableManager get scheduleHistory =>
      $$ScheduleHistoryTableTableManager(_db, _db.scheduleHistory);
  $$TasksTableTableManager get tasks =>
      $$TasksTableTableManager(_db, _db.tasks);
  $$ExercisesTableTableManager get exercises =>
      $$ExercisesTableTableManager(_db, _db.exercises);
  $$WorkoutSessionsTableTableManager get workoutSessions =>
      $$WorkoutSessionsTableTableManager(_db, _db.workoutSessions);
  $$WorkoutSetsTableTableManager get workoutSets =>
      $$WorkoutSetsTableTableManager(_db, _db.workoutSets);
  $$MeasurementsTableTableManager get measurements =>
      $$MeasurementsTableTableManager(_db, _db.measurements);
  $$NutritionGuidesTableTableManager get nutritionGuides =>
      $$NutritionGuidesTableTableManager(_db, _db.nutritionGuides);
  $$EnglishLessonsTableTableManager get englishLessons =>
      $$EnglishLessonsTableTableManager(_db, _db.englishLessons);
  $$VocabEntriesTableTableManager get vocabEntries =>
      $$VocabEntriesTableTableManager(_db, _db.vocabEntries);
  $$EnglishSessionsTableTableManager get englishSessions =>
      $$EnglishSessionsTableTableManager(_db, _db.englishSessions);
  $$EnglishAssessmentsTableTableManager get englishAssessments =>
      $$EnglishAssessmentsTableTableManager(_db, _db.englishAssessments);
  $$RepairLessonsTableTableManager get repairLessons =>
      $$RepairLessonsTableTableManager(_db, _db.repairLessons);
  $$ComponentsTableTableManager get components =>
      $$ComponentsTableTableManager(_db, _db.components);
  $$EquipmentItemsTableTableManager get equipmentItems =>
      $$EquipmentItemsTableTableManager(_db, _db.equipmentItems);
  $$RepairExercisesTableTableManager get repairExercises =>
      $$RepairExercisesTableTableManager(_db, _db.repairExercises);
  $$MeasurementNotebookTableTableManager get measurementNotebook =>
      $$MeasurementNotebookTableTableManager(_db, _db.measurementNotebook);
  $$RepairCasesTableTableManager get repairCases =>
      $$RepairCasesTableTableManager(_db, _db.repairCases);
  $$AppearanceRoutinesTableTableManager get appearanceRoutines =>
      $$AppearanceRoutinesTableTableManager(_db, _db.appearanceRoutines);
  $$AppearanceProductsTableTableManager get appearanceProducts =>
      $$AppearanceProductsTableTableManager(_db, _db.appearanceProducts);
  $$AppearancePhotosTableTableManager get appearancePhotos =>
      $$AppearancePhotosTableTableManager(_db, _db.appearancePhotos);
  $$GroomingRecordsTableTableManager get groomingRecords =>
      $$GroomingRecordsTableTableManager(_db, _db.groomingRecords);
  $$ReviewsTableTableManager get reviews =>
      $$ReviewsTableTableManager(_db, _db.reviews);
  $$AchievementsTableTableManager get achievements =>
      $$AchievementsTableTableManager(_db, _db.achievements);
  $$NotificationPrefsTableTableManager get notificationPrefs =>
      $$NotificationPrefsTableTableManager(_db, _db.notificationPrefs);
  $$BackupMetadataTableTableManager get backupMetadata =>
      $$BackupMetadataTableTableManager(_db, _db.backupMetadata);
}
