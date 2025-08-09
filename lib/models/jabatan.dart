// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Jabatan {
  int? id;
  String desc;
  Jabatan({
    this.id,
    required this.desc,
  });

  Jabatan copyWith({
    int? id,
    String? desc,
  }) {
    return Jabatan(
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

  factory Jabatan.fromJson(Map<String, dynamic> map) {
    return Jabatan(
      id: map['id'] != null ? map['id'] as int : null,
      desc: map['desc'] as String,
    );
  }

  @override
  String toString() => 'Jabatan(id: $id, desc: $desc)';

  @override
  bool operator ==(covariant Jabatan other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.desc == desc;
  }

}
