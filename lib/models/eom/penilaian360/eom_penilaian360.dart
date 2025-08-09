// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

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
