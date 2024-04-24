import 'package:ets/db/movie_db.dart';
import 'package:ets/model/movie.dart';
import 'package:ets/page/movie_detail_page.dart';
import 'package:ets/page/movie_form_page.dart';
import 'package:ets/widget/movie_card.dart';
import 'package:flutter/material.dart';

class MoviesPage extends StatefulWidget {
  const MoviesPage({super.key});

  @override
  State<MoviesPage> createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage> {
  late List<Movie> movies;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshMovies();
  }

  @override
  void dispose() {
    MovieDB.instance.close();
    super.dispose();
  }

  Future refreshMovies() async {
    setState(() => isLoading = true);

    movies = await MovieDB.instance.getAll();

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Movies')),
      body: Center(
        child: isLoading
            ? const CircularProgressIndicator()
            : movies.isEmpty
                ? const Text('No Movies')
                : buildMovies(),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue.shade100,
        child: const Icon(Icons.add),
        onPressed: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const MovieFormPage()),
          );

          refreshMovies();
        },
      ),
    );
  }

  Widget buildMovies() {
    return ListView(
      padding: const EdgeInsets.all(8),
      children: movies
          .map((movie) => GestureDetector(
              onTap: () async {
                await Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => MovieDetailPage(id: movie.id!),
                ));

                refreshMovies();
              },
              child: MovieCard(movie)))
          .toList(),
    );
  }
}
