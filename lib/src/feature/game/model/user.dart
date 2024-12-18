// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int id;
  final String name;
  final int points;
  final int coins;
  final int hints;
  final List<String> unlockedAchievements;
  final List<String> completedPuzzles;

  const User({
    required this.id,
    required this.name,
    required this.points,
    required this.coins,
    required this.hints,
    required this.unlockedAchievements,
    required this.completedPuzzles,
  });

  User copyWith({
    int? id,
    String? name,
    int? points,
    int? coins,
    int? hints,
    List<String>? unlockedAchievements,
    List<String>? completedPuzzles,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      points: points ?? this.points,
      coins: coins ?? this.coins,
      hints: hints ?? this.hints,
      unlockedAchievements: unlockedAchievements ?? this.unlockedAchievements,
      completedPuzzles: completedPuzzles ?? this.completedPuzzles,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'points': points,
      'coins': coins,
      'hints': hints,
      'unlockedAchievements': unlockedAchievements,
      'completedPuzzles': completedPuzzles,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as int,
      name: map['name'] as String,
      points: map['points'] as int,
      coins: map['coins'] as int,
      hints: map['hints'] as int,
      unlockedAchievements: map['unlockedAchievements'] == null
          ? []
          : List<String>.from(map['unlockedAchievements'] as List<dynamic>),
      completedPuzzles: map['completedPuzzles'] == null
          ? []
          : List<String>.from(map['completedPuzzles'] as List<dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      name,
      points,
      coins,
      hints,
      unlockedAchievements,
      completedPuzzles,
    ];
  }
}
