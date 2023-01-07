import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
part 'category.g.dart';

@HiveType(typeId: 1)
class Category extends HiveObject {
  @HiveField(0)
  final String category;
  @HiveField(1)
  final String id;
  
  Category({
    required this.category,
  }) : id = const Uuid().v4();
}
