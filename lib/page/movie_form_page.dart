import 'package:ets/db/movie_db.dart';
import 'package:ets/model/movie.dart';
import 'package:ets/widget/movie_form.dart';
import 'package:flutter/material.dart';

class MovieFormPage extends StatefulWidget {
  final Movie? movie;
  const MovieFormPage({super.key, this.movie});

  @override
  State<MovieFormPage> createState() => _MovieFormPageState();
}

class _MovieFormPageState extends State<MovieFormPage> {
  final _formKey = GlobalKey<FormState>();
  late String title;
  late String description;
  late String imageUrl;

  @override
  void initState() {
    super.initState();

    title = widget.movie?.title ?? '';
    description = widget.movie?.description ?? '';
    imageUrl = widget.movie?.imageUrl ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [buildButton()],
      ),
      body: Form(
        key: _formKey,
        child: MovieForm(
          title: title,
          description: description,
          imageUrl: imageUrl,
          onChangedTitle: (title) => setState(() => this.title = title),
          onChangedDescription: (description) =>
              setState(() => this.description = description),
          onChangedImageUrl: (imageUrl) =>
              setState(() => this.imageUrl = imageUrl),
        ),
      ),
    );
  }

  Widget buildButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: ElevatedButton(
        onPressed: handleSave,
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue.shade100,
            foregroundColor: Colors.black),
        child: const Text('Save'),
      ),
    );
  }

  void handleSave() async {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (isValid) {
      final isUpdating = widget.movie != null;

      if (isUpdating) {
        updateMovie();
      } else {
        createMovie();
      }

      if (!mounted) return;
      Navigator.of(context).pop();
    }
  }

  Future createMovie() async {
    final movie = Movie(
      title: title,
      description: description,
      imageUrl: imageUrl,
      createdAt: DateTime.now(),
    );

    await MovieDB.instance.create(movie);
  }

  Future updateMovie() async {
    final movie = widget.movie!.copy(
      title: title,
      description: description,
      imageUrl: imageUrl,
    );

    await MovieDB.instance.update(movie);
  }
}
