// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:collection/collection.dart';

import 'package:bpssulsel/models/pegawai.dart';

class Tim {
  String? uuid;
  String title;
  String desc;
  Tim({
    this.uuid,
    required this.title,
    required this.desc,
  });

  Tim copyWith({
    String? uuid,
    String? title,
    String? desc,
  }) {
    return Tim(
      uuid: uuid ?? this.uuid,
      title: title ?? this.title,
      desc: desc ?? this.desc,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'uuid': uuid,
      'title': title,
      'desc': desc,
    };
  }

  factory Tim.fromJson(Map<String, dynamic> map) {
    return Tim(
      uuid: map['uuid'] != null ? map['uuid'] as String : null,
      title: map['title'] as String,
      desc: map['desc'] as String,
    );
  }

  @override
  String toString() => 'Tim(uuid: $uuid, title: $title, desc: $desc)';

  @override
  bool operator ==(covariant Tim other) {
    if (identical(this, other)) return true;
  
    return 
      other.uuid == uuid &&
      other.title == title &&
      other.desc == desc;
  }
}

class TimWithPegawai {
  String? uuid;
  String title;
  String desc;
  List<Pegawai> pegawai = [];
  TimWithPegawai({
    this.uuid,
    required this.title,
    required this.desc,
    required this.pegawai,
  });

  TimWithPegawai copyWith({
    String? uuid,
    String? title,
    String? desc,
    List<Pegawai>? pegawai,
  }) {
    return TimWithPegawai(
      uuid: uuid ?? this.uuid,
      title: title ?? this.title,
      desc: desc ?? this.desc,
      pegawai: pegawai ?? this.pegawai,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'uuid': uuid,
      'title': title,
      'desc': desc,
      'pegawai': pegawai.map((x) => x.toJson()).toList(),
    };
  }

  factory TimWithPegawai.fromJson(Map<String, dynamic> map) {
    return TimWithPegawai(
      uuid: map['uuid'] != null ? map['uuid'] as String : null,
      title: map['title'] as String,
      desc: map['desc'] as String,
      pegawai: List<Pegawai>.from((map['pegawai'] as List<dynamic>).map<Pegawai>((x) => Pegawai.fromJson(x as Map<String,dynamic>))),
    );
  }

  @override
  String toString() {
    return 'TimWithPegawai(uuid: $uuid, title: $title, desc: $desc, pegawai: $pegawai)';
  }

  @override
  bool operator ==(covariant TimWithPegawai other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;
    return 
      other.uuid == uuid &&
      other.title == title &&
      other.desc == desc &&
      listEquals(other.pegawai, pegawai);
  }
}

class TimDetails {
  String? tim_uuid;
  String tim_title;
  String tim_desc;
  TimDetails({
    this.tim_uuid,
    required this.tim_title,
    required this.tim_desc,
  });

  TimDetails copyWith({
    String? tim_uuid,
    String? tim_title,
    String? tim_desc,
  }) {
    return TimDetails(
      tim_uuid: tim_uuid ?? this.tim_uuid,
      tim_title: tim_title ?? this.tim_title,
      tim_desc: tim_desc ?? this.tim_desc,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'tim_uuid': tim_uuid,
      'tim_title': tim_title,
      'tim_desc': tim_desc,
    };
  }

  factory TimDetails.fromJson(Map<String, dynamic> map) {
    return TimDetails(
      tim_uuid: map['tim_uuid'] != null ? map['tim_uuid'] as String : null,
      tim_title: map['tim_title'] as String,
      tim_desc: map['tim_desc'] as String,
    );
  }

  @override
  String toString() => 'TimDetails(tim_uuid: $tim_uuid, tim_title: $tim_title, tim_desc: $tim_desc)';

  @override
  bool operator ==(covariant TimDetails other) {
    if (identical(this, other)) return true;
  
    return 
      other.tim_uuid == tim_uuid &&
      other.tim_title == tim_title &&
      other.tim_desc == tim_desc;
  }

  @override
  int get hashCode => tim_uuid.hashCode ^ tim_title.hashCode ^ tim_desc.hashCode;
}
