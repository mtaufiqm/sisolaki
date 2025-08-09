// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

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
  double vote;
  double ckp;
  String created_at;
  String last_updated;
  EomData({
    this.uuid,
    required this.candidate,
    required this.kjk,
    required this.vote,
    required this.ckp,
    required this.created_at,
    required this.last_updated,
  });

  EomData copyWith({
    String? uuid,
    String? candidate,
    double? kjk,
    double? vote,
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
      vote: map['vote'] as double,
      ckp: map['ckp'] as double,
      created_at: map['created_at'] as String,
      last_updated: map['last_updated'] as String,
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

}
