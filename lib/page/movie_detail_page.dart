import 'package:ets/db/movie_db.dart';
import 'package:ets/model/movie.dart';
import 'package:ets/page/movie_form_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MovieDetailPage extends StatefulWidget {
  final int id;

  const MovieDetailPage({
    super.key,
    required this.id,
  });

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  late Movie movie;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshMovie();
  }

  Future refreshMovie() async {
    setState(() => isLoading = true);

    movie = await MovieDB.instance.getById(widget.id);

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [editButton(), deleteButton()],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(8),
              child: ListView(
                children: [
                  Image.network(movie.imageUrl),
                  Text(
                    movie.title,
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    DateFormat.yMMMd().format(movie.createdAt),
                    style: const TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    movie.description,
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
    );
  }

  Widget editButton() {
    return IconButton(
        icon: const Icon(Icons.edit_outlined),
        onPressed: () async {
          if (isLoading) return;

          await Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => MovieFormPage(movie: movie),
          ));

          refreshMovie();
        });
  }

  Widget deleteButton() {
    return IconButton(
      icon: const Icon(Icons.delete),
      onPressed: () async {
        await MovieDB.instance.delete(widget.id);

        if (!mounted) return;

        Navigator.of(context).pop();
      },
    );
  }
}
