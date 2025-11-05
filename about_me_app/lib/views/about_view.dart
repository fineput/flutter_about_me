import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AboutView extends StatelessWidget {
  final String name;
  final String description;

  const AboutView({
    super.key,
    required this.name,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          description,
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
