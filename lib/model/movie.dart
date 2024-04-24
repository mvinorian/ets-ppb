class MovieField {
  static const id = 'id';
  static const title = 'title';
  static const description = 'description';
  static const createdAt = 'created_at';
  static const imageUrl = 'image_url';
  static const values = [id, title, description, createdAt, imageUrl];
  static final mock = [
    Movie(
      id: 1,
      title: 'The Lion King',
      description: 'This is lion king',
      createdAt: DateTime(2021, 10, 10),
      imageUrl:
          'https://m.media-amazon.com/images/M/MV5BMjIwMjE1Nzc4NV5BMl5BanBnXkFtZTgwNDg4OTA1NzM@._V1_SX300.jpg',
    ),
    Movie(
      id: 2,
      title: 'Mowgli: Legend of the Jungle',
      description: 'This is Mowgli: Legend of the Jungle',
      createdAt: DateTime(2018, 12, 12),
      imageUrl:
          'https://m.media-amazon.com/images/M/MV5BMjMzODc2NzU5MV5BMl5BanBnXkFtZTgwNTMwMTE3NjM@._V1_SX300.jpg',
    ),
    Movie(
      id: 3,
      title: 'Doctor Strange',
      description: 'This is Doctor Strange',
      createdAt: DateTime(2020, 8, 8),
      imageUrl:
          'https://m.media-amazon.com/images/M/MV5BNjgwNzAzNjk1Nl5BMl5BanBnXkFtZTgwMzQ2NjI1OTE@._V1_SX300.jpg',
    ),
  ];
}

class Movie {
  final int? id;
  final String title;
  final String description;
  final DateTime createdAt;
  final String imageUrl;

  Movie({
    this.id,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.imageUrl,
  });

  Movie.fromJson(Map<String, dynamic> json)
      : this(
          id: json[MovieField.id],
          title: json[MovieField.title],
          description: json[MovieField.description],
          createdAt: DateTime.parse(json[MovieField.createdAt]),
          imageUrl: json[MovieField.imageUrl],
        );

  Map<String, Object?> toJson() {
    return {
      MovieField.id: id,
      MovieField.title: title,
      MovieField.description: description,
      MovieField.createdAt: createdAt.toIso8601String(),
      MovieField.imageUrl: imageUrl,
    };
  }

  Movie copy({
    int? id,
    String? title,
    String? description,
    DateTime? createdAt,
    String? imageUrl,
  }) {
    return Movie(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
