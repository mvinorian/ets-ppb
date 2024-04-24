import 'package:ets/model/movie.dart';
import 'package:flutter/material.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;

  const MovieCard(this.movie, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Column(
          children: <Widget>[
            Image.network(movie.imageUrl),
            Text(movie.title),
            Text(movie.description),
          ],
        ),
      ),
    );
  }
}
