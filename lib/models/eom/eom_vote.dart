// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

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
  String is_complete;
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
    String? is_complete,
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
      is_complete: map['is_complete'] as String,
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

}
