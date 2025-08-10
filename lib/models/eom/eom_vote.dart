// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:bpssulsel/models/pegawai.dart';

  // uuid text pk
  // penilaian text [not null]
  // voter text [not null]
  // choice1 text [not null]
  // choice2 text [not null]
  // created_at text [not null]
  // last_updated text [not null]
  // is_complete boolean
class EomVote {
  String? uuid;
  String penilaian;
  String voter;
  String? choice1;
  String? choice2;
  String? created_at;
  String? last_updated;
  bool is_complete;
  EomVote({
    this.uuid,
    required this.penilaian,
    required this.voter,
    this.choice1,
    this.choice2,
    this.created_at,
    this.last_updated,
    required this.is_complete,
  });

  EomVote copyWith({
    String? uuid,
    String? penilaian,
    String? voter,
    String? choice1,
    String? choice2,
    String? created_at,
    String? last_updated,
    bool? is_complete,
  }) {
    return EomVote(
      uuid: uuid ?? this.uuid,
      penilaian: penilaian ?? this.penilaian,
      voter: voter ?? this.voter,
      choice1: choice1 ?? this.choice1,
      choice2: choice2 ?? this.choice2,
      created_at: created_at ?? this.created_at,
      last_updated: last_updated ?? this.last_updated,
      is_complete: is_complete ?? this.is_complete,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'uuid': uuid,
      'penilaian': penilaian,
      'voter': voter,
      'choice1': choice1,
      'choice2': choice2,
      'created_at': created_at,
      'last_updated': last_updated,
      'is_complete': is_complete,
    };
  }

  factory EomVote.fromJson(Map<String, dynamic> map) {
    return EomVote(
      uuid: map['uuid'] != null ? map['uuid'] as String : null,
      penilaian: map['penilaian'] as String,
      voter: map['voter'] as String,
      choice1: map['choice1'] != null ? map['choice1'] as String : null,
      choice2: map['choice2'] != null ? map['choice2'] as String : null,
      created_at: map['created_at'] != null ? map['created_at'] as String : null,
      last_updated: map['last_updated'] != null ? map['last_updated'] as String : null,
      is_complete: map['is_complete'] as bool,
    );
  }

  @override
  String toString() {
    return 'EomVote(uuid: $uuid, penilaian: $penilaian, voter: $voter, choice1: $choice1, choice2: $choice2, created_at: $created_at, last_updated: $last_updated, is_complete: $is_complete)';
  }

  @override
  bool operator ==(covariant EomVote other) {
    if (identical(this, other)) return true;
  
    return 
      other.uuid == uuid &&
      other.penilaian == penilaian &&
      other.voter == voter &&
      other.choice1 == choice1 &&
      other.choice2 == choice2 &&
      other.created_at == created_at &&
      other.last_updated == last_updated &&
      other.is_complete == is_complete;
  }

  @override
  int get hashCode {
    return uuid.hashCode ^
      penilaian.hashCode ^
      voter.hashCode ^
      choice1.hashCode ^
      choice2.hashCode ^
      created_at.hashCode ^
      last_updated.hashCode ^
      is_complete.hashCode;
  }
}


class EomVoteDetails {
  String? uuid;
  String penilaian;
  Pegawai? voter;
  Pegawai? choice1;
  Pegawai? choice2;
  String? created_at;
  String? last_updated;
  bool is_complete;
  EomVoteDetails({
    this.uuid,
    required this.penilaian,
    this.voter,
    this.choice1,
    this.choice2,
    this.created_at,
    this.last_updated,
    required this.is_complete,
  });

  EomVoteDetails copyWith({
    String? uuid,
    String? penilaian,
    Pegawai? voter,
    Pegawai? choice1,
    Pegawai? choice2,
    String? created_at,
    String? last_updated,
    bool? is_complete,
  }) {
    return EomVoteDetails(
      uuid: uuid ?? this.uuid,
      penilaian: penilaian ?? this.penilaian,
      voter: voter ?? this.voter,
      choice1: choice1 ?? this.choice1,
      choice2: choice2 ?? this.choice2,
      created_at: created_at ?? this.created_at,
      last_updated: last_updated ?? this.last_updated,
      is_complete: is_complete ?? this.is_complete,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'uuid': uuid,
      'penilaian': penilaian,
      'voter': voter?.toJson(),
      'choice1': choice1?.toJson(),
      'choice2': choice2?.toJson(),
      'created_at': created_at,
      'last_updated': last_updated,
      'is_complete': is_complete,
    };
  }

  factory EomVoteDetails.fromJson(Map<String, dynamic> map) {
    return EomVoteDetails(
      uuid: map['uuid'] != null ? map['uuid'] as String : null,
      penilaian: map['penilaian'] as String,
      voter: map['voter'] != null ? Pegawai.fromJson(map['voter'] as Map<String,dynamic>) : null,
      choice1: map['choice1'] != null ? Pegawai.fromJson(map['choice1'] as Map<String,dynamic>) : null,
      choice2: map['choice2'] != null ? Pegawai.fromJson(map['choice2'] as Map<String,dynamic>) : null,
      created_at: map['created_at'] != null ? map['created_at'] as String : null,
      last_updated: map['last_updated'] != null ? map['last_updated'] as String : null,
      is_complete: map['is_complete'] as bool,
    );
  }

  factory EomVoteDetails.fromDb(Map<String, dynamic> map) {
    return EomVoteDetails(
      uuid: map['uuid'] != null ? map['uuid'] as String : null,
      penilaian: map['penilaian'] as String,
      voter: null,
      choice1: null,
      choice2: null,
      created_at: map['created_at'] != null ? map['created_at'] as String : null,
      last_updated: map['last_updated'] != null ? map['last_updated'] as String : null,
      is_complete: map['is_complete'] as bool,
    );
  }

  @override
  String toString() {
    return 'EomVoteDetails(uuid: $uuid, penilaian: $penilaian, voter: $voter, choice1: $choice1, choice2: $choice2, created_at: $created_at, last_updated: $last_updated, is_complete: $is_complete)';
  }

  @override
  bool operator ==(covariant EomVoteDetails other) {
    if (identical(this, other)) return true;
  
    return 
      other.uuid == uuid &&
      other.penilaian == penilaian &&
      other.voter == voter &&
      other.choice1 == choice1 &&
      other.choice2 == choice2 &&
      other.created_at == created_at &&
      other.last_updated == last_updated &&
      other.is_complete == is_complete;
  }

  @override
  int get hashCode {
    return uuid.hashCode ^
      penilaian.hashCode ^
      voter.hashCode ^
      choice1.hashCode ^
      choice2.hashCode ^
      created_at.hashCode ^
      last_updated.hashCode ^
      is_complete.hashCode;
  }
}
