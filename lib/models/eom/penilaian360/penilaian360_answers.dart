// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Penilaian360Answers {
  String? uuid;
  String penilaian360;
  String question;
  int value;
  Penilaian360Answers({
    this.uuid,
    required this.penilaian360,
    required this.question,
    required this.value,
  });

  Penilaian360Answers copyWith({
    String? uuid,
    String? penilaian360,
    String? question,
    int? value,
  }) {
    return Penilaian360Answers(
      uuid: uuid ?? this.uuid,
      penilaian360: penilaian360 ?? this.penilaian360,
      question: question ?? this.question,
      value: value ?? this.value,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'uuid': uuid,
      'penilaian360': penilaian360,
      'question': question,
      'value': value,
    };
  }

  factory Penilaian360Answers.fromJson(Map<String, dynamic> map) {
    return Penilaian360Answers(
      uuid: map['uuid'] != null ? map['uuid'] as String : null,
      penilaian360: map['penilaian360'] as String,
      question: map['question'] as String,
      value: map['value'] as int,
    );
  }


  @override
  String toString() {
    return 'Penilaian360Answers(uuid: $uuid, penilaian360: $penilaian360, question: $question, value: $value)';
  }

  @override
  bool operator ==(covariant Penilaian360Answers other) {
    if (identical(this, other)) return true;
  
    return 
      other.uuid == uuid &&
      other.penilaian360 == penilaian360 &&
      other.question == question &&
      other.value == value;
  }

}
