// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:bpssulsel/models/pegawai.dart';
import 'package:bpssulsel/models/tim.dart';

class EomCandidate {
  String? uuid;
  String penilaian;
  int order;
  String tim;
  String pegawai;
  EomCandidate({
    this.uuid,
    required this.penilaian,
    required this.order,
    required this.tim,
    required this.pegawai,
  });

  EomCandidate copyWith({
    String? uuid,
    String? penilaian,
    int? order,
    String? tim,
    String? pegawai,
  }) {
    return EomCandidate(
      uuid: uuid ?? this.uuid,
      penilaian: penilaian ?? this.penilaian,
      order: order ?? this.order,
      tim: tim ?? this.tim,
      pegawai: pegawai ?? this.pegawai,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'uuid': uuid,
      'penilaian': penilaian,
      'order': order,
      'tim': tim,
      'pegawai': pegawai,
    };
  }

  factory EomCandidate.fromJson(Map<String, dynamic> map) {
    return EomCandidate(
      uuid: map['uuid'] != null ? map['uuid'] as String : null,
      penilaian: map['penilaian'] as String,
      order: map['order'] as int,
      tim: map['tim'] as String,
      pegawai: map['pegawai'] as String,
    );
  }

  @override
  String toString() {
    return 'EomCandidate(uuid: $uuid, penilaian: $penilaian, order: $order, tim: $tim, pegawai: $pegawai)';
  }

  @override
  bool operator ==(covariant EomCandidate other) {
    if (identical(this, other)) return true;
  
    return 
      other.uuid == uuid &&
      other.penilaian == penilaian &&
      other.order == order &&
      other.tim == tim &&
      other.pegawai == pegawai;
  }
}

class EomCandidateDetails {
  String? uuid;
  String penilaian;
  int order;
  TimDetails? tim;
  PegawaiDetails? pegawai;
  EomCandidateDetails({
    this.uuid,
    required this.penilaian,
    required this.order,
    this.tim,
    this.pegawai,
  });

  EomCandidateDetails copyWith({
    String? uuid,
    String? penilaian,
    int? order,
    TimDetails? tim,
    PegawaiDetails? pegawai,
  }) {
    return EomCandidateDetails(
      uuid: uuid ?? this.uuid,
      penilaian: penilaian ?? this.penilaian,
      order: order ?? this.order,
      tim: tim ?? this.tim,
      pegawai: pegawai ?? this.pegawai,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'uuid': uuid,
      'penilaian': penilaian,
      'order': order,
      'tim': tim?.toJson(),
      'pegawai': pegawai?.toJson(),
    };
  }

  factory EomCandidateDetails.fromJson(Map<String, dynamic> map) {
    return EomCandidateDetails(
      uuid: map['uuid'] != null ? map['uuid'] as String : null,
      penilaian: map['penilaian'] as String,
      order: map['order'] as int,
      tim: map['tim'] != null ? TimDetails.fromJson(map['tim'] as Map<String,dynamic>) : null,
      pegawai: map['pegawai'] != null ? PegawaiDetails.fromJson(map['pegawai'] as Map<String,dynamic>) : null,
    );
  }

  @override
  String toString() {
    return 'EomCandidateDetails(uuid: $uuid, penilaian: $penilaian, order: $order, tim: $tim, pegawai: $pegawai)';
  }

  @override
  bool operator ==(covariant EomCandidateDetails other) {
    if (identical(this, other)) return true;
  
    return 
      other.uuid == uuid &&
      other.penilaian == penilaian &&
      other.order == order &&
      other.tim == tim &&
      other.pegawai == pegawai;
  }

}
