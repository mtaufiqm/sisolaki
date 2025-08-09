// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class EomStatus {
  int? id;
  String desc;
  EomStatus({
    this.id,
    required this.desc,
  });

  EomStatus copyWith({
    int? id,
    String? desc,
  }) {
    return EomStatus(
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

  factory EomStatus.fromJson(Map<String, dynamic> map) {
    return EomStatus(
      id: map['id'] != null ? map['id'] as int : null,
      desc: map['desc'] as String,
    );
  }

  @override
  String toString() => 'EomStatus(id: $id, desc: $desc)';

  @override
  bool operator ==(covariant EomStatus other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.desc == desc;
  }

}
