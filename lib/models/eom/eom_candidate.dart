// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:bpssulsel/models/eom/eom_data.dart';
import 'package:bpssulsel/models/pegawai.dart';
import 'package:bpssulsel/models/tim.dart';

class EomCandidate {
  String? uuid;
  String penilaian;
  int order;
  String? tim;
  String pegawai;
  EomCandidate({
    this.uuid,
    required this.penilaian,
    required this.order,
    this.tim,
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
      tim: map['tim'] != null ? map['tim'] as String : null,
      pegawai: map['pegawai'] as String,
    );
  }

  factory EomCandidate.fromDb(Map<String, dynamic> map) {
    return EomCandidate(
      uuid: map['uuid'] != null ? map['uuid'] as String : null,
      penilaian: map['penilaian'] as String,
      order: map['order'] as int,
      tim: map['tim'] != null ? map['tim'] as String : null,
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

  @override
  int get hashCode {
    return uuid.hashCode ^
      penilaian.hashCode ^
      order.hashCode ^
      tim.hashCode ^
      pegawai.hashCode;
  }
}

class EomCandidateWithData {
  String? uuid;
  String penilaian;
  int order;
  String? tim;
  String pegawai;
  EomData? data;
  EomCandidateWithData({
    this.uuid,
    required this.penilaian,
    required this.order,
    this.tim,
    required this.pegawai,
    this.data,
  });

  EomCandidateWithData copyWith({
    String? uuid,
    String? penilaian,
    int? order,
    String? tim,
    String? pegawai,
    EomData? data,
  }) {
    return EomCandidateWithData(
      uuid: uuid ?? this.uuid,
      penilaian: penilaian ?? this.penilaian,
      order: order ?? this.order,
      tim: tim ?? this.tim,
      pegawai: pegawai ?? this.pegawai,
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'uuid': uuid,
      'penilaian': penilaian,
      'order': order,
      'tim': tim,
      'pegawai': pegawai,
      'data': data?.toJson(),
    };
  }

  factory EomCandidateWithData.fromJson(Map<String, dynamic> map) {
    return EomCandidateWithData(
      uuid: map['uuid'] != null ? map['uuid'] as String : null,
      penilaian: map['penilaian'] as String,
      order: map['order'] as int,
      tim: map['tim'] != null ? map['tim'] as String : null,
      pegawai: map['pegawai'] as String,
      data: map['data'] != null ? EomData.fromJson(map['data'] as Map<String,dynamic>) : null,
    );
  }

  factory EomCandidateWithData.fromDb(Map<String, dynamic> map) {
    return EomCandidateWithData(
      uuid: map['uuid'] != null ? map['uuid'] as String : null,
      penilaian: map['penilaian'] as String,
      order: map['order'] as int,
      tim: map['tim'] != null ? map['tim'] as String : null,
      pegawai: map['pegawai'] as String,
      data: null,
    );
  }

  factory EomCandidateWithData.fromDbPrefix(Map<String, dynamic> map, String prefix) {
    return EomCandidateWithData(
      uuid: map['${prefix}_uuid'] != null ? map['${prefix}_uuid'] as String : null,
      penilaian: map['${prefix}_penilaian'] as String,
      order: map['${prefix}_order'] as int,
      tim: map['${prefix}_tim'] != null ? map['${prefix}_tim'] as String : null,
      pegawai: map['${prefix}_pegawai'] as String,
      data: null,
    );
  }

  @override
  String toString() {
    return 'EomCandidateWithData(uuid: $uuid, penilaian: $penilaian, order: $order, tim: $tim, pegawai: $pegawai, data: $data)';
  }

  @override
  bool operator ==(covariant EomCandidateWithData other) {
    if (identical(this, other)) return true;
  
    return 
      other.uuid == uuid &&
      other.penilaian == penilaian &&
      other.order == order &&
      other.tim == tim &&
      other.pegawai == pegawai &&
      other.data == data;
  }
}

class EomCandidateDetails {
  String? uuid;
  String penilaian;
  int order;
  TimDetails? tim;
  PegawaiDetails? pegawai;
  EomData? data;
  EomCandidateDetails({
    this.uuid,
    required this.penilaian,
    required this.order,
    this.tim,
    this.pegawai,
    this.data,
  });

  EomCandidateDetails copyWith({
    String? uuid,
    String? penilaian,
    int? order,
    TimDetails? tim,
    PegawaiDetails? pegawai,
    EomData? data,
  }) {
    return EomCandidateDetails(
      uuid: uuid ?? this.uuid,
      penilaian: penilaian ?? this.penilaian,
      order: order ?? this.order,
      tim: tim ?? this.tim,
      pegawai: pegawai ?? this.pegawai,
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'uuid': uuid,
      'penilaian': penilaian,
      'order': order,
      'tim': tim?.toJson(),
      'pegawai': pegawai?.toJson(),
      'data': data?.toJson(),
    };
  }

  factory EomCandidateDetails.fromJson(Map<String, dynamic> map) {
    return EomCandidateDetails(
      uuid: map['uuid'] != null ? map['uuid'] as String : null,
      penilaian: map['penilaian'] as String,
      order: map['order'] as int,
      tim: map['tim'] != null ? TimDetails.fromJson(map['tim'] as Map<String,dynamic>) : null,
      pegawai: map['pegawai'] != null ? PegawaiDetails.fromJson(map['pegawai'] as Map<String,dynamic>) : null,
      data: map['data'] != null ? EomData.fromJson(map['data'] as Map<String,dynamic>) : null,
    );
  }

  factory EomCandidateDetails.fromDb(Map<String, dynamic> map) {
    return EomCandidateDetails(
      uuid: map['uuid'] != null ? map['uuid'] as String : null,
      penilaian: map['penilaian'] as String,
      order: map['order'] as int,
      tim: null,
      pegawai: null,
      data: null
    );
  }

  factory EomCandidateDetails.fromDbPrefix(Map<String, dynamic> map, String prefix) {
    return EomCandidateDetails(
      uuid: map['${prefix}_uuid'] != null ? map['${prefix}_uuid'] as String : null,
      penilaian: map['${prefix}_penilaian'] as String,
      order: map['${prefix}_order'] as int,
      tim: null,
      pegawai: null,
      data: null
    );
  }

  @override
  String toString() {
    return 'EomCandidateDetails(uuid: $uuid, penilaian: $penilaian, order: $order, tim: $tim, pegawai: $pegawai, data: $data)';
  }

  @override
  bool operator ==(covariant EomCandidateDetails other) {
    if (identical(this, other)) return true;
  
    return 
      other.uuid == uuid &&
      other.penilaian == penilaian &&
      other.order == order &&
      other.tim == tim &&
      other.pegawai == pegawai &&
      other.data == data;
  }
}

