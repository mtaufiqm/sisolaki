// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

  // uuid text pk
  // user text [not null]
  // title text [not null]
  // desc text [not null]
  // created_at text

class Report {
  String? uuid;
  String user;
  String title;
  String desc;
  String? created_at;
  Report({
    this.uuid,
    required this.user,
    required this.title,
    required this.desc,
    this.created_at,
  });

  Report copyWith({
    String? uuid,
    String? user,
    String? title,
    String? desc,
    String? created_at,
  }) {
    return Report(
      uuid: uuid ?? this.uuid,
      user: user ?? this.user,
      title: title ?? this.title,
      desc: desc ?? this.desc,
      created_at: created_at ?? this.created_at,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'uuid': uuid,
      'user': user,
      'title': title,
      'desc': desc,
      'created_at': created_at,
    };
  }

  factory Report.fromJson(Map<String, dynamic> map) {
    return Report(
      uuid: map['uuid'] != null ? map['uuid'] as String : null,
      user: map['user'] as String,
      title: map['title'] as String,
      desc: map['desc'] as String,
      created_at: map['created_at'] != null ? map['created_at'] as String : null,
    );
  }

  factory Report.fromDb(Map<String, dynamic> map) {
    return Report(
      uuid: map['uuid'] != null ? map['uuid'] as String : null,
      user: map['user'] as String,
      title: map['title'] as String,
      desc: map['desc'] as String,
      created_at: map['created_at'] != null ? map['created_at'] as String : null,
    );
  }

  factory Report.fromDbPrefix(Map<String, dynamic> map, String prefix) {
    return Report(
      uuid: map['${prefix}_uuid'] != null ? map['${prefix}_uuid'] as String : null,
      user: map['${prefix}_user'] as String,
      title: map['${prefix}_title'] as String,
      desc: map['${prefix}_desc'] as String,
      created_at: map['${prefix}_created_at'] != null ? map['${prefix}_created_at'] as String : null,
    );
  }

  @override
  String toString() {
    return 'Report(uuid: $uuid, user: $user, title: $title, desc: $desc, created_at: $created_at)';
  }

  @override
  bool operator ==(covariant Report other) {
    if (identical(this, other)) return true;
    return 
      other.uuid == uuid &&
      other.user == user &&
      other.title == title &&
      other.desc == desc &&
      other.created_at == created_at;
  }
}