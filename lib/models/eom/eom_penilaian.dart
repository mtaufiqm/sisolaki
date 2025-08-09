// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class EomPenilaian {
  String? uuid;
  String? desc;
  String periode;
  String start_date;
  String end_date;
  int status;
  String? created_at;
  String? last_updated;
  EomPenilaian({
    this.uuid,
    this.desc,
    required this.periode,
    required this.start_date,
    required this.end_date,
    required this.status,
    this.created_at,
    this.last_updated,
  });

  EomPenilaian copyWith({
    String? uuid,
    String? desc,
    String? periode,
    String? start_date,
    String? end_date,
    int? status,
    String? created_at,
    String? last_updated,
  }) {
    return EomPenilaian(
      uuid: uuid ?? this.uuid,
      desc: desc ?? this.desc,
      periode: periode ?? this.periode,
      start_date: start_date ?? this.start_date,
      end_date: end_date ?? this.end_date,
      status: status ?? this.status,
      created_at: created_at ?? this.created_at,
      last_updated: last_updated ?? this.last_updated,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'uuid': uuid,
      'desc': desc,
      'periode': periode,
      'start_date': start_date,
      'end_date': end_date,
      'status': status,
      'created_at': created_at,
      'last_updated': last_updated,
    };
  }

  factory EomPenilaian.fromJson(Map<String, dynamic> map) {
    return EomPenilaian(
      uuid: map['uuid'] != null ? map['uuid'] as String : null,
      desc: map['desc'] != null ? map['desc'] as String : null,
      periode: map['periode'] as String,
      start_date: map['start_date'] as String,
      end_date: map['end_date'] as String,
      status: map['status'] as int,
      created_at: map['created_at'] != null ? map['created_at'] as String : null,
      last_updated: map['last_updated'] != null ? map['last_updated'] as String : null,
    );
  }

  @override
  String toString() {
    return 'EomPenilaian(uuid: $uuid, desc: $desc, periode: $periode, start_date: $start_date, end_date: $end_date, status: $status, created_at: $created_at, last_updated: $last_updated)';
  }

  @override
  bool operator ==(covariant EomPenilaian other) {
    if (identical(this, other)) return true;
  
    return 
      other.uuid == uuid &&
      other.desc == desc &&
      other.periode == periode &&
      other.start_date == start_date &&
      other.end_date == end_date &&
      other.status == status &&
      other.created_at == created_at &&
      other.last_updated == last_updated;
  }

  @override
  int get hashCode {
    return uuid.hashCode ^
      desc.hashCode ^
      periode.hashCode ^
      start_date.hashCode ^
      end_date.hashCode ^
      status.hashCode ^
      created_at.hashCode ^
      last_updated.hashCode;
  }
}
