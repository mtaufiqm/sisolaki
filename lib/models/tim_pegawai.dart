// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:bpssulsel/models/pegawai.dart';
import 'package:bpssulsel/models/tim.dart';

class TimPegawai {
  String? uuid;
  Tim? tim;
  Pegawai? pegawai;
  int tim_role;
  TimPegawai({
    this.uuid,
    this.tim,
    this.pegawai,
    required this.tim_role,
  });

  TimPegawai copyWith({
    String? uuid,
    Tim? tim,
    Pegawai? pegawai,
    int? tim_role,
  }) {
    return TimPegawai(
      uuid: uuid ?? this.uuid,
      tim: tim ?? this.tim,
      pegawai: pegawai ?? this.pegawai,
      tim_role: tim_role ?? this.tim_role,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'uuid': uuid,
      'tim': tim?.toJson(),
      'pegawai': pegawai?.toJson(),
      'tim_role': tim_role,
    };
  }

  factory TimPegawai.fromJson(Map<String, dynamic> map) {
    return TimPegawai(
      uuid: map['uuid'] != null ? map['uuid'] as String : null,
      tim: map['tim'] != null ? Tim.fromJson(map['tim'] as Map<String,dynamic>) : null,
      pegawai: map['pegawai'] != null ? Pegawai.fromJson(map['pegawai'] as Map<String,dynamic>) : null,
      tim_role: map['tim_role'] as int,
    );
  }

  factory TimPegawai.fromDb(Map<String, dynamic> map) {
    return TimPegawai(
      uuid: map['uuid'] != null ? map['uuid'] as String : null,
      tim: null,
      pegawai: null,
      tim_role: map['tim_role'] as int,
    );
  }

  @override
  String toString() {
    return 'TimPegawai(uuid: $uuid, tim: $tim, pegawai: $pegawai, tim_role: $tim_role)';
  }

  @override
  bool operator ==(covariant TimPegawai other) {
    if (identical(this, other)) return true;
  
    return 
      other.uuid == uuid &&
      other.tim == tim &&
      other.pegawai == pegawai &&
      other.tim_role == tim_role;
  }

  @override
  int get hashCode {
    return uuid.hashCode ^
      tim.hashCode ^
      pegawai.hashCode ^
      tim_role.hashCode;
  }
}
