// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:collection/collection.dart';

import 'package:bpssulsel/models/eom/penilaian360/eom_penilaian360.dart';
import 'package:bpssulsel/models/eom/penilaian360/penilaian360_answers.dart';

class Penilaian360SubmitResponse {
  EomPenilaian360 penilaian360;
  List<Penilaian360Answers> answers;
  Penilaian360SubmitResponse({
    required this.penilaian360,
    required this.answers,
  });

  Penilaian360SubmitResponse copyWith({
    EomPenilaian360? penilaian360,
    List<Penilaian360Answers>? answers,
  }) {
    return Penilaian360SubmitResponse(
      penilaian360: penilaian360 ?? this.penilaian360,
      answers: answers ?? this.answers,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'penilaian360': penilaian360.toJson(),
      'answers': answers.map((x) => x.toJson()).toList(),
    };
  }

  factory Penilaian360SubmitResponse.fromJson(Map<String, dynamic> map) {
    return Penilaian360SubmitResponse(
      penilaian360: EomPenilaian360.fromJson(map['penilaian360'] as Map<String,dynamic>),
      answers: List<Penilaian360Answers>.from((map['answers'] as List<dynamic>).map<Penilaian360Answers>((x) => Penilaian360Answers.fromJson(x as Map<String,dynamic>))),
    );
  }

  @override
  String toString() => 'Penilaian360SubmitResponse(penilaian360: $penilaian360, answers: $answers)';

  @override
  bool operator ==(covariant Penilaian360SubmitResponse other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;
  
    return 
      other.penilaian360 == penilaian360 &&
      listEquals(other.answers, answers);
  }

  @override
  int get hashCode => penilaian360.hashCode ^ answers.hashCode;
}
