// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

//0 : AKTIF
//1 : PENSIUN
//2 : PINDAH
class StatusPegawai {
  int? id;
  String desc;
  StatusPegawai({
    this.id,
    required this.desc,
  });

  StatusPegawai copyWith({
    int? id,
    String? desc,
  }) {
    return StatusPegawai(
      id: id ?? this.id,
      desc: desc ?? this.desc,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'desc': desc,
    };
  }

  factory StatusPegawai.fromJson(Map<String, dynamic> map) {
    return StatusPegawai(
      id: map['id'] != null ? map['id'] as int : null,
      desc: map['desc'] as String,
    );
  }

  @override
  String toString() => 'StatusPegawai(id: $id, desc: $desc)';

  @override
  bool operator ==(covariant StatusPegawai other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.desc == desc;
  }
}
