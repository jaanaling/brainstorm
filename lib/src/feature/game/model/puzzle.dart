// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

enum PuzzleStatus { locked, unlocked, completed, failed }

enum PuzzleType {
  sumOfNumbers,
  logicalSequence,
  mathEquation,
  symbolicAnagram,
  cipherCode,
}

class Puzzle extends Equatable {
  final String id;
  final int level;
  final int difficulty;
  final PuzzleType type;
  final String instructions;
  final dynamic data;
  final List<String> hints;
  final dynamic solution;
  final int attempts;
  final int coinsReward;
  final int scoreReward;
  final PuzzleStatus status;

  const Puzzle({
    required this.id,
    required this.level,
    required this.difficulty,
    required this.type,
    required this.instructions,
    required this.data,
    required this.hints,
    required this.solution,
    required this.attempts,
    required this.coinsReward,
    required this.scoreReward,
    required this.status,
  });

  Puzzle copyWith({
    String? id,
    int? level,
    int? difficulty,
    PuzzleType? type,
    String? instructions,
    dynamic data,
    List<String>? hints,
    dynamic solution,
    int? attempts,
    int? coinsReward,
    int? scoreReward,
    PuzzleStatus? status,
  }) {
    return Puzzle(
      id: id ?? this.id,
      level: level ?? this.level,
      difficulty: difficulty ?? this.difficulty,
      type: type ?? this.type,
      instructions: instructions ?? this.instructions,
      data: data ?? this.data,
      hints: hints ?? this.hints,
      solution: solution ?? this.solution,
      attempts: attempts ?? this.attempts,
      coinsReward: coinsReward ?? this.coinsReward,
      scoreReward: scoreReward ?? this.scoreReward,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'level': level,
      'difficulty': difficulty,
      'type': type.name,
      'instructions': instructions,
      'data': data,
      'hints': hints,
      'solution': solution,
      'attempts': attempts,
      'coins_reward': coinsReward,
      'score_reward': scoreReward,
      'status': status.name,
    };
  }

  factory Puzzle.fromMap(Map<String, dynamic> map) {
    return Puzzle(
      id: map['id'] as String,
      level: map['level'] == null? 0 : map['level'] as int,
      difficulty: map['difficulty'] == null ? 0 : map['difficulty'] as int,
      type: PuzzleType.values.firstWhere((e) => e.name == map['type']),
      instructions: map['instructions'] as String,
      data: map['data'] as dynamic,
      hints: List<String>.from(map['hints'] as List<dynamic>),
      solution: map['solution'] as dynamic,
      attempts: map['attempts'] as int,
      coinsReward: map['coins_reward'] as int,
      scoreReward: map['score_reward'] as int,
      status:map['status'] == null ? PuzzleStatus.unlocked : PuzzleStatus.values.firstWhere((e) => e.name == map['status']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Puzzle.fromJson(String source) =>
      Puzzle.fromMap(json.decode(source) as Map<String, dynamic>);



  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      id,
      level,
      difficulty,
      type,
      instructions,
      data,
      hints,
      solution,
      attempts,
      coinsReward,
      scoreReward,
      status,
    ];
  }
}
