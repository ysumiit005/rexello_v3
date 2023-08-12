import 'package:flutter/material.dart';

class User {
  final int id;
  final String name;
  late final String image;
  final String weight;
  final String description;

  User({
    required this.id,
    required this.name,
    required this.image,
    required this.weight,
    required this.description,
  });
}
