// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:collection/collection.dart';

import 'package:bpssulsel/models/eom/eom_candidate.dart';
import 'package:bpssulsel/models/eom/penilaian360/penilaian360_questions.dart';
import 'package:bpssulsel/models/pegawai.dart';

class EomPenilaian360 {
  String? uuid;
  String penilaian;
  String voter;
  String candidate;
  double value;
  bool is_complete;
  String? created_at;
  String last_updated;
  EomPenilaian360({
    this.uuid,
    required this.penilaian,
    required this.voter,
    required this.candidate,
    required this.value,
    required this.is_complete,
    this.created_at,
    required this.last_updated,
  });

  EomPenilaian360 copyWith({
    String? uuid,
    String? penilaian,
    String? voter,
    String? candidate,
    double? value,
    bool? is_complete,
    String? created_at,
    String? last_updated,
  }) {
    return EomPenilaian360(
      uuid: uuid ?? this.uuid,
      penilaian: penilaian ?? this.penilaian,
      voter: voter ?? this.voter,
      candidate: candidate ?? this.candidate,
      value: value ?? this.value,
      is_complete: is_complete ?? this.is_complete,
      created_at: created_at ?? this.created_at,
      last_updated: last_updated ?? this.last_updated,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'uuid': uuid,
      'penilaian': penilaian,
      'voter': voter,
      'candidate': candidate,
      'value': value,
      'is_complete': is_complete,
      'created_at': created_at,
      'last_updated': last_updated,
    };
  }

  factory EomPenilaian360.fromJson(Map<String, dynamic> map) {
    return EomPenilaian360(
      uuid: map['uuid'] != null ? map['uuid'] as String : null,
      penilaian: map['penilaian'] as String,
      voter: map['voter'] as String,
      candidate: map['candidate'] as String,
      value: map['value'] as double,
      is_complete: map['is_complete'] as bool,
      created_at: map['created_at'] != null ? map['created_at'] as String : null,
      last_updated: map['last_updated'] as String,
    );
  }
  
  @override
  String toString() {
    return 'EomPenilaian360(uuid: $uuid, penilaian: $penilaian, voter: $voter, candidate: $candidate, value: $value, is_complete: $is_complete, created_at: $created_at, last_updated: $last_updated)';
  }

  @override
  bool operator ==(covariant EomPenilaian360 other) {
    if (identical(this, other)) return true;
  
    return 
      other.uuid == uuid &&
      other.penilaian == penilaian &&
      other.voter == voter &&
      other.candidate == candidate &&
      other.value == value &&
      other.is_complete == is_complete &&
      other.created_at == created_at &&
      other.last_updated == last_updated;
  }

  @override
  int get hashCode {
    return uuid.hashCode ^
      penilaian.hashCode ^
      voter.hashCode ^
      candidate.hashCode ^
      value.hashCode ^
      is_complete.hashCode ^
      created_at.hashCode ^
      last_updated.hashCode;
  }
}

class EomPenilaian360Details {
  String? uuid;
  String penilaian;
  PegawaiDetails? voter;
  EomCandidateDetails? candidate;
  double value;
  bool is_complete;
  String? created_at;
  String last_updated;
  EomPenilaian360Details({
    this.uuid,
    required this.penilaian,
    this.voter,
    this.candidate,
    required this.value,
    required this.is_complete,
    this.created_at,
    required this.last_updated,
  });

  EomPenilaian360Details copyWith({
    String? uuid,
    String? penilaian,
    PegawaiDetails? voter,
    EomCandidateDetails? candidate,
    double? value,
    bool? is_complete,
    String? created_at,
    String? last_updated,
  }) {
    return EomPenilaian360Details(
      uuid: uuid ?? this.uuid,
      penilaian: penilaian ?? this.penilaian,
      voter: voter ?? this.voter,
      candidate: candidate ?? this.candidate,
      value: value ?? this.value,
      is_complete: is_complete ?? this.is_complete,
      created_at: created_at ?? this.created_at,
      last_updated: last_updated ?? this.last_updated,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'uuid': uuid,
      'penilaian': penilaian,
      'voter': voter?.toJson(),
      'candidate': candidate?.toJson(),
      'value': value,
      'is_complete': is_complete,
      'created_at': created_at,
      'last_updated': last_updated,
    };
  }

  factory EomPenilaian360Details.fromJson(Map<String, dynamic> map) {
    return EomPenilaian360Details(
      uuid: map['uuid'] != null ? map['uuid'] as String : null,
      penilaian: map['penilaian'] as String,
      voter: map['voter'] != null ? PegawaiDetails.fromJson(map['voter'] as Map<String,dynamic>) : null,
      candidate: map['candidate'] != null ? EomCandidateDetails.fromJson(map['candidate'] as Map<String,dynamic>) : null,
      value: map['value'] as double,
      is_complete: map['is_complete'] as bool,
      created_at: map['created_at'] != null ? map['created_at'] as String : null,
      last_updated: map['last_updated'] as String,
    );
  }

  factory EomPenilaian360Details.fromDb(Map<String, dynamic> map) {
    return EomPenilaian360Details(
      uuid: map['uuid'] != null ? map['uuid'] as String : null,
      penilaian: map['penilaian'] as String,
      voter: null,
      candidate: null,
      value: map['value'] as double,
      is_complete: map['is_complete'] as bool,
      created_at: map['created_at'] != null ? map['created_at'] as String : null,
      last_updated: map['last_updated'] as String,
    );
  }

  @override
  String toString() {
    return 'EomPenilaian360Details(uuid: $uuid, penilaian: $penilaian, voter: $voter, candidate: $candidate, value: $value, is_complete: $is_complete, created_at: $created_at, last_updated: $last_updated)';
  }

  @override
  bool operator ==(covariant EomPenilaian360Details other) {
    if (identical(this, other)) return true;
  
    return 
      other.uuid == uuid &&
      other.penilaian == penilaian &&
      other.voter == voter &&
      other.candidate == candidate &&
      other.value == value &&
      other.is_complete == is_complete &&
      other.created_at == created_at &&
      other.last_updated == last_updated;
  }

  @override
  int get hashCode {
    return uuid.hashCode ^
      penilaian.hashCode ^
      voter.hashCode ^
      candidate.hashCode ^
      value.hashCode ^
      is_complete.hashCode ^
      created_at.hashCode ^
      last_updated.hashCode;
  }
}


class Penilaian360WithQuestions {
  EomPenilaian360Details penilaian360;
  List<Penilaian360QuestionsAnswer> questions_answer;
  Penilaian360WithQuestions({
    required this.penilaian360,
    required this.questions_answer,
  });

  Penilaian360WithQuestions copyWith({
    EomPenilaian360Details? penilaian360,
    List<Penilaian360QuestionsAnswer>? questions_answer,
  }) {
    return Penilaian360WithQuestions(
      penilaian360: penilaian360 ?? this.penilaian360,
      questions_answer: questions_answer ?? this.questions_answer,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'penilaian360': penilaian360.toJson(),
      'questions_answer': questions_answer.map((x) => x.toJson()).toList(),
    };
  }

  factory Penilaian360WithQuestions.fromJson(Map<String, dynamic> map) {
    return Penilaian360WithQuestions(
      penilaian360: EomPenilaian360Details.fromJson(map['penilaian360'] as Map<String,dynamic>),
      questions_answer: List<Penilaian360QuestionsAnswer>.from((map['questions_answer'] as List<dynamic>).map<Penilaian360QuestionsAnswer>((x) => Penilaian360QuestionsAnswer.fromJson(x as Map<String,dynamic>),),),
    );
  }

  @override
  String toString() => 'Penilaian360WithQuestions(penilaian360: $penilaian360, questions_answer: $questions_answer)';

}
