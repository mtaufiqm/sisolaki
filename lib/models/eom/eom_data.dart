// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:bpssulsel/models/eom/eom_candidate.dart';

  // uuid text pk
  // candidate text 
  // kjk double [not null,default:0.0]
  // vote integer [not null,default:0]
  // ckp double [not null, default:0.0]
  // created_at text
  // last_updated text
class EomData {
  String? uuid;
  String candidate;
  double kjk;
  int vote;
  double ckp;
  String? created_at;
  String? last_updated;
  EomData({
    this.uuid,
    required this.candidate,
    required this.kjk,
    required this.vote,
    required this.ckp,
    this.created_at,
    this.last_updated,
  });

  EomData copyWith({
    String? uuid,
    String? candidate,
    double? kjk,
    int? vote,
    double? ckp,
    String? created_at,
    String? last_updated,
  }) {
    return EomData(
      uuid: uuid ?? this.uuid,
      candidate: candidate ?? this.candidate,
      kjk: kjk ?? this.kjk,
      vote: vote ?? this.vote,
      ckp: ckp ?? this.ckp,
      created_at: created_at ?? this.created_at,
      last_updated: last_updated ?? this.last_updated,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'uuid': uuid,
      'candidate': candidate,
      'kjk': kjk,
      'vote': vote,
      'ckp': ckp,
      'created_at': created_at,
      'last_updated': last_updated,
    };
  }

  factory EomData.fromJson(Map<String, dynamic> map) {
    return EomData(
      uuid: map['uuid'] != null ? map['uuid'] as String : null,
      candidate: map['candidate'] as String,
      kjk: map['kjk'] as double,
      vote: map['vote'] as int,
      ckp: map['ckp'] as double,
      created_at: map['created_at'] != null ? map['created_at'] as String : null,
      last_updated: map['last_updated'] != null ? map['last_updated'] as String : null,
    );
  }

  factory EomData.fromDb(Map<String, dynamic> map) {
    return EomData(
      uuid: map['uuid'] != null ? map['uuid'] as String : null,
      candidate: map['candidate'] as String,
      kjk: map['kjk'] as double,
      vote: map['vote'] as int,
      ckp: map['ckp'] as double,
      created_at: map['created_at'] != null ? map['created_at'] as String : null,
      last_updated: map['last_updated'] != null ? map['last_updated'] as String : null,
    );
  }

  factory EomData.fromDbPrefix(Map<String, dynamic> map, String prefix) {
    return EomData(
      uuid: map['${prefix}_uuid'] != null ? map['${prefix}_uuid'] as String : null,
      candidate: map['${prefix}_candidate'] as String,
      kjk: map['${prefix}_kjk'] as double,
      vote: map['${prefix}_vote'] as int,
      ckp: map['${prefix}_ckp'] as double,
      created_at: map['${prefix}_created_at'] != null ? map['${prefix}_created_at'] as String : null,
      last_updated: map['${prefix}_last_updated'] != null ? map['${prefix}_last_updated'] as String : null,
    );
  }

  @override
  String toString() {
    return 'EomData(uuid: $uuid, candidate: $candidate, kjk: $kjk, vote: $vote, ckp: $ckp, created_at: $created_at, last_updated: $last_updated)';
  }

  @override
  bool operator ==(covariant EomData other) {
    if (identical(this, other)) return true;
  
    return 
      other.uuid == uuid &&
      other.candidate == candidate &&
      other.kjk == kjk &&
      other.vote == vote &&
      other.ckp == ckp &&
      other.created_at == created_at &&
      other.last_updated == last_updated;
  }

  @override
  int get hashCode {
    return uuid.hashCode ^
      candidate.hashCode ^
      kjk.hashCode ^
      vote.hashCode ^
      ckp.hashCode ^
      created_at.hashCode ^
      last_updated.hashCode;
  }
}

class VoteResult {
  EomCandidateDetails candidate;
  double kjk;
  double ckp;
  int vote;
  double penilaian360;
  double average;
  VoteResult({
    required this.candidate,
    required this.kjk,
    required this.ckp,
    required this.vote,
    required this.penilaian360,
    required this.average,
  });

  VoteResult copyWith({
    EomCandidateDetails? candidate,
    double? kjk,
    double? ckp,
    int? vote,
    double? penilaian360,
    double? average,
  }) {
    return VoteResult(
      candidate: candidate ?? this.candidate,
      kjk: kjk ?? this.kjk,
      ckp: ckp ?? this.ckp,
      vote: vote ?? this.vote,
      penilaian360: penilaian360 ?? this.penilaian360,
      average: average ?? this.average,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'candidate': candidate.toJson(),
      'kjk': kjk,
      'ckp': ckp,
      'vote': vote,
      'penilaian360': penilaian360,
      'average': average,
    };
  }

  factory VoteResult.fromJson(Map<String, dynamic> map) {
    return VoteResult(
      candidate: EomCandidateDetails.fromJson(map['candidate'] as Map<String,dynamic>),
      kjk: map['kjk'] as double,
      ckp: map['ckp'] as double,
      vote: map['vote'] as int,
      penilaian360: map['penilaian360'] as double,
      average: map['average'] as double,
    );
  }


  @override
  String toString() {
    return 'VoteResult(candidate: $candidate, kjk: $kjk, ckp: $ckp, vote: $vote, penilaian360: $penilaian360, average: $average)';
  }

  @override
  bool operator ==(covariant VoteResult other) {
    if (identical(this, other)) return true;
  
    return 
      other.candidate == candidate &&
      other.kjk == kjk &&
      other.ckp == ckp &&
      other.vote == vote &&
      other.penilaian360 == penilaian360 &&
      other.average == average;
  }

  @override
  int get hashCode {
    return candidate.hashCode ^
      kjk.hashCode ^
      ckp.hashCode ^
      vote.hashCode ^
      penilaian360.hashCode ^
      average.hashCode;
  }
}
