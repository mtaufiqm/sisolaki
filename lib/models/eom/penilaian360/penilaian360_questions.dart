// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:bpssulsel/models/eom/penilaian360/penilaian360_answers.dart';

class Penilaian360Questions {
  String? uuid;
  String title;
  String desc;
  int order;
  String tag;
  bool is_active;
  Penilaian360Questions({
    this.uuid,
    required this.title,
    required this.desc,
    required this.order,
    required this.tag,
    required this.is_active,
  });

  Penilaian360Questions copyWith({
    String? uuid,
    String? title,
    String? desc,
    int? order,
    String? tag,
    bool? is_active,
  }) {
    return Penilaian360Questions(
      uuid: uuid ?? this.uuid,
      title: title ?? this.title,
      desc: desc ?? this.desc,
      order: order ?? this.order,
      tag: tag ?? this.tag,
      is_active: is_active ?? this.is_active,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'uuid': uuid,
      'title': title,
      'desc': desc,
      'order': order,
      'tag': tag,
      'is_active': is_active,
    };
  }

  factory Penilaian360Questions.fromJson(Map<String, dynamic> map) {
    return Penilaian360Questions(
      uuid: map['uuid'] != null ? map['uuid'] as String : null,
      title: map['title'] as String,
      desc: map['desc'] as String,
      order: map['order'] as int,
      tag: map['tag'] as String,
      is_active: map['is_active'] as bool,
    );
  }

  @override
  String toString() {
    return 'Penilaian360Questions(uuid: $uuid, title: $title, desc: $desc, order: $order, tag: $tag, is_active: $is_active)';
  }

  @override
  bool operator ==(covariant Penilaian360Questions other) {
    if (identical(this, other)) return true;
  
    return 
      other.uuid == uuid &&
      other.title == title &&
      other.desc == desc &&
      other.order == order &&
      other.tag == tag &&
      other.is_active == is_active;
  }

  @override
  int get hashCode {
    return uuid.hashCode ^
      title.hashCode ^
      desc.hashCode ^
      order.hashCode ^
      tag.hashCode ^
      is_active.hashCode;
  }
}

class Penilaian360QuestionsAnswer {
  String? uuid;
  String title;
  String desc;
  int order;
  String tag;
  bool is_active;
  Penilaian360Answers? answer;
  Penilaian360QuestionsAnswer({
    this.uuid,
    required this.title,
    required this.desc,
    required this.order,
    required this.tag,
    required this.is_active,
    this.answer,
  });

  Penilaian360QuestionsAnswer copyWith({
    String? uuid,
    String? title,
    String? desc,
    int? order,
    String? tag,
    bool? is_active,
    Penilaian360Answers? answer,
  }) {
    return Penilaian360QuestionsAnswer(
      uuid: uuid ?? this.uuid,
      title: title ?? this.title,
      desc: desc ?? this.desc,
      order: order ?? this.order,
      tag: tag ?? this.tag,
      is_active: is_active ?? this.is_active,
      answer: answer ?? this.answer,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'uuid': uuid,
      'title': title,
      'desc': desc,
      'order': order,
      'tag': tag,
      'is_active': is_active,
      'answer': answer?.toJson(),
    };
  }

  factory Penilaian360QuestionsAnswer.fromJson(Map<String, dynamic> map) {
    return Penilaian360QuestionsAnswer(
      uuid: map['uuid'] != null ? map['uuid'] as String : null,
      title: map['title'] as String,
      desc: map['desc'] as String,
      order: map['order'] as int,
      tag: map['tag'] as String,
      is_active: map['is_active'] as bool,
      answer: map['answer'] != null ? Penilaian360Answers.fromJson(map['answer'] as Map<String,dynamic>) : null,
    );
  }

  factory Penilaian360QuestionsAnswer.fromDb(Map<String, dynamic> map) {
    return Penilaian360QuestionsAnswer(
      uuid: map['uuid'] != null ? map['uuid'] as String : null,
      title: map['title'] as String,
      desc: map['desc'] as String,
      order: map['order'] as int,
      tag: map['tag'] as String,
      is_active: map['is_active'] as bool,
      answer: null,
    );
  }

  @override
  String toString() {
    return 'Penilaian360QuestionsAnswer(uuid: $uuid, title: $title, desc: $desc, order: $order, tag: $tag, is_active: $is_active, answer: $answer)';
  }

  @override
  bool operator ==(covariant Penilaian360QuestionsAnswer other) {
    if (identical(this, other)) return true;
  
    return 
      other.uuid == uuid &&
      other.title == title &&
      other.desc == desc &&
      other.order == order &&
      other.tag == tag &&
      other.is_active == is_active &&
      other.answer == answer;
  }

  @override
  int get hashCode {
    return uuid.hashCode ^
      title.hashCode ^
      desc.hashCode ^
      order.hashCode ^
      tag.hashCode ^
      is_active.hashCode ^
      answer.hashCode;
  }
}
