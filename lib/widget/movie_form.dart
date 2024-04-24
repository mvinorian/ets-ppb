import 'package:flutter/material.dart';

class MovieForm extends StatelessWidget {
  final String? title;
  final String? description;
  final String? imageUrl;
  final ValueChanged<String> onChangedTitle;
  final ValueChanged<String> onChangedDescription;
  final ValueChanged<String> onChangedImageUrl;

  const MovieForm({
    super.key,
    this.title = '',
    this.description = '',
    this.imageUrl = '',
    required this.onChangedTitle,
    required this.onChangedDescription,
    required this.onChangedImageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            buildTitle(),
            const SizedBox(height: 8),
            buildDescription(),
            const SizedBox(height: 8),
            buildImageUrl(),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget buildTitle() {
    return TextFormField(
      maxLines: 1,
      initialValue: title ?? '',
      style: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 12,
      ),
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Title',
        hintStyle: TextStyle(color: Colors.black38),
      ),
      validator: (value) =>
          value != null && value.isEmpty ? 'The title cannot be empty' : null,
      onChanged: onChangedTitle,
    );
  }

  Widget buildDescription() {
    return TextFormField(
      maxLines: 5,
      initialValue: description ?? '',
      style: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 12,
      ),
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Description',
        hintStyle: TextStyle(color: Colors.black38),
      ),
      validator: (value) => value != null && value.isEmpty
          ? 'The description cannot be empty'
          : null,
      onChanged: onChangedDescription,
    );
  }

  Widget buildImageUrl() {
    return TextFormField(
      maxLines: 1,
      initialValue: imageUrl ?? '',
      style: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 12,
      ),
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Image Url',
        hintStyle: TextStyle(color: Colors.black38),
      ),
      validator: (value) => value != null && value.isEmpty
          ? 'The image url cannot be empty'
          : null,
      onChanged: onChangedImageUrl,
    );
  }
}
