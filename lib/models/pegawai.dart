// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Pegawai {
  String? uuid;
  String? fullname;
  String? fullname_with_title;
  String? nickname;
  String? nip;
  String? old_nip;
  String? phone_number;
  String username;
  int status_pegawai;
  int jabatan;
  Pegawai({
    this.uuid,
    this.fullname,
    this.fullname_with_title,
    this.nickname,
    this.nip,
    this.old_nip,
    this.phone_number,
    required this.username,
    required this.status_pegawai,
    required this.jabatan,
  });

  Pegawai copyWith({
    String? uuid,
    String? fullname,
    String? fullname_with_title,
    String? nickname,
    String? nip,
    String? old_nip,
    String? phone_number,
    String? username,
    int? status_pegawai,
    int? jabatan,
  }) {
    return Pegawai(
      uuid: uuid ?? this.uuid,
      fullname: fullname ?? this.fullname,
      fullname_with_title: fullname_with_title ?? this.fullname_with_title,
      nickname: nickname ?? this.nickname,
      nip: nip ?? this.nip,
      old_nip: old_nip ?? this.old_nip,
      phone_number: phone_number ?? this.phone_number,
      username: username ?? this.username,
      status_pegawai: status_pegawai ?? this.status_pegawai,
      jabatan: jabatan ?? this.jabatan,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'uuid': uuid,
      'fullname': fullname,
      'fullname_with_title': fullname_with_title,
      'nickname': nickname,
      'nip': nip,
      'old_nip': old_nip,
      'phone_number': phone_number,
      'username': username,
      'status_pegawai': status_pegawai,
      'jabatan': jabatan,
    };
  }

  factory Pegawai.fromJson(Map<String, dynamic> map) {
    return Pegawai(
      uuid: map['uuid'] != null ? map['uuid'] as String : null,
      fullname: map['fullname'] != null ? map['fullname'] as String : null,
      fullname_with_title: map['fullname_with_title'] != null ? map['fullname_with_title'] as String : null,
      nickname: map['nickname'] != null ? map['nickname'] as String : null,
      nip: map['nip'] != null ? map['nip'] as String : null,
      old_nip: map['old_nip'] != null ? map['old_nip'] as String : null,
      phone_number: map['phone_number'] != null ? map['phone_number'] as String : null,
      username: map['username'] as String,
      status_pegawai: map['status_pegawai'] as int,
      jabatan: map['jabatan'] as int,
    );
  }

  factory Pegawai.fromDb(Map<String, dynamic> map) {
    return Pegawai(
      uuid: map['uuid'] != null ? map['uuid'] as String : null,
      fullname: map['fullname'] != null ? map['fullname'] as String : null,
      fullname_with_title: map['fullname_with_title'] != null ? map['fullname_with_title'] as String : null,
      nickname: map['nickname'] != null ? map['nickname'] as String : null,
      nip: map['nip'] != null ? map['nip'] as String : null,
      old_nip: map['old_nip'] != null ? map['old_nip'] as String : null,
      phone_number: map['phone_number'] != null ? map['phone_number'] as String : null,
      username: map['username'] as String,
      status_pegawai: map['status_pegawai'] as int,
      jabatan: map['jabatan'] as int,
    );
  }

  factory Pegawai.fromDbPrefix(Map<String, dynamic> map, String prefix) {
    return Pegawai(
      uuid: map['${prefix}_uuid'] != null ? map['${prefix}_uuid'] as String : null,
      fullname: map['${prefix}_fullname'] != null ? map['${prefix}_fullname'] as String : null,
      fullname_with_title: map['${prefix}_fullname_with_title'] != null ? map['${prefix}_fullname_with_title'] as String : null,
      nickname: map['${prefix}_nickname'] != null ? map['${prefix}_nickname'] as String : null,
      nip: map['${prefix}_nip'] != null ? map['${prefix}_nip'] as String : null,
      old_nip: map['${prefix}_old_nip'] != null ? map['${prefix}_old_nip'] as String : null,
      phone_number: map['${prefix}_phone_number'] != null ? map['${prefix}_phone_number'] as String : null,
      username: map['${prefix}_username'] as String,
      status_pegawai: map['${prefix}_status_pegawai'] as int,
      jabatan: map['${prefix}_jabatan'] as int,
    );
  }

  @override
  String toString() {
    return 'Pegawai(uuid: $uuid, fullname: $fullname, fullname_with_title: $fullname_with_title, nickname: $nickname, nip: $nip, old_nip: $old_nip, phone_number: $phone_number, username: $username, status_pegawai: $status_pegawai, jabatan: $jabatan)';
  }

  @override
  bool operator ==(covariant Pegawai other) {
    if (identical(this, other)) return true;
  
    return 
      other.uuid == uuid &&
      other.fullname == fullname &&
      other.fullname_with_title == fullname_with_title &&
      other.nickname == nickname &&
      other.nip == nip &&
      other.old_nip == old_nip &&
      other.phone_number == phone_number &&
      other.username == username &&
      other.status_pegawai == status_pegawai &&
      other.jabatan == jabatan;
  }
}

class PegawaiDetails {
  String? p_uuid;
  String? p_fullname;
  String? p_fullname_with_title;
  String? p_nickname;
  String? p_nip;
  String? p_old_nip;
  String? p_phone_number;
  String p_username;
  int p_status_pegawai;
  int p_jabatan;
  PegawaiDetails({
    this.p_uuid,
    this.p_fullname,
    this.p_fullname_with_title,
    this.p_nickname,
    this.p_nip,
    this.p_old_nip,
    this.p_phone_number,
    required this.p_username,
    required this.p_status_pegawai,
    required this.p_jabatan,
  });

  PegawaiDetails copyWith({
    String? p_uuid,
    String? p_fullname,
    String? p_fullname_with_title,
    String? p_nickname,
    String? p_nip,
    String? p_old_nip,
    String? p_phone_number,
    String? p_username,
    int? p_status_pegawai,
    int? p_jabatan,
  }) {
    return PegawaiDetails(
      p_uuid: p_uuid ?? this.p_uuid,
      p_fullname: p_fullname ?? this.p_fullname,
      p_fullname_with_title: p_fullname_with_title ?? this.p_fullname_with_title,
      p_nickname: p_nickname ?? this.p_nickname,
      p_nip: p_nip ?? this.p_nip,
      p_old_nip: p_old_nip ?? this.p_old_nip,
      p_phone_number: p_phone_number ?? this.p_phone_number,
      p_username: p_username ?? this.p_username,
      p_status_pegawai: p_status_pegawai ?? this.p_status_pegawai,
      p_jabatan: p_jabatan ?? this.p_jabatan,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'p_uuid': p_uuid,
      'p_fullname': p_fullname,
      'p_fullname_with_title': p_fullname_with_title,
      'p_nickname': p_nickname,
      'p_nip': p_nip,
      'p_old_nip': p_old_nip,
      'p_phone_number': p_phone_number,
      'p_username': p_username,
      'p_status_pegawai': p_status_pegawai,
      'p_jabatan': p_jabatan,
    };
  }

  factory PegawaiDetails.fromJson(Map<String, dynamic> map) {
    return PegawaiDetails(
      p_uuid: map['p_uuid'] != null ? map['p_uuid'] as String : null,
      p_fullname: map['p_fullname'] != null ? map['p_fullname'] as String : null,
      p_fullname_with_title: map['p_fullname_with_title'] != null ? map['p_fullname_with_title'] as String : null,
      p_nickname: map['p_nickname'] != null ? map['p_nickname'] as String : null,
      p_nip: map['p_nip'] != null ? map['p_nip'] as String : null,
      p_old_nip: map['p_old_nip'] != null ? map['p_old_nip'] as String : null,
      p_phone_number: map['p_phone_number'] != null ? map['p_phone_number'] as String : null,
      p_username: map['p_username'] as String,
      p_status_pegawai: map['p_status_pegawai'] as int,
      p_jabatan: map['p_jabatan'] as int,
    );
  }

  @override
  String toString() {
    return 'PegawaiDetails(p_uuid: $p_uuid, p_fullname: $p_fullname, p_fullname_with_title: $p_fullname_with_title, p_nickname: $p_nickname, p_nip: $p_nip, p_old_nip: $p_old_nip, p_phone_number: $p_phone_number, p_username: $p_username, p_status_pegawai: $p_status_pegawai, p_jabatan: $p_jabatan)';
  }

  @override
  bool operator ==(covariant PegawaiDetails other) {
    if (identical(this, other)) return true;
  
    return 
      other.p_uuid == p_uuid &&
      other.p_fullname == p_fullname &&
      other.p_fullname_with_title == p_fullname_with_title &&
      other.p_nickname == p_nickname &&
      other.p_nip == p_nip &&
      other.p_old_nip == p_old_nip &&
      other.p_phone_number == p_phone_number &&
      other.p_username == p_username &&
      other.p_status_pegawai == p_status_pegawai &&
      other.p_jabatan == p_jabatan;
  }

}
