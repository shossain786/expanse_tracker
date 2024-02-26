import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

final dateFormatter = DateFormat.yMd();

enum Categories { food, travel, leisure, work }

const categoryIcons = {
  Categories.food: Icons.lunch_dining,
  Categories.travel: Icons.flight,
  Categories.leisure: Icons.timelapse,
  Categories.work: Icons.work,
};

class Expanse {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Categories category;

  Expanse(
      {required this.title,
      required this.amount,
      required this.date,
      required this.category})
      : id = uuid.v4();

  String get formattedDate {
    return dateFormatter.format(date);
  }
}
