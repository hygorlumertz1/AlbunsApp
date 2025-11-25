class Photo {
  final int id;
  final int albumId;
  final String titulo;
  final String url;
  final String thumbnailUrl;

  Photo({
    required this.id,
    required this.albumId,
    required this.titulo,
    required this.url,
    required this.thumbnailUrl,
  });

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      id: json['id'] ?? 0,
      albumId: json['albumId'] ?? 0,
      titulo: json['titulo'] ?? json['title'] ?? 'Sem título',
      url: json['url'] ?? '',
      thumbnailUrl: json['thumbnailUrl'] ?? '',
    );
  }
}

class Album {
  final int id;
  final int userId;
  final String title;

  Album({
    required this.id,
    required this.userId,
    required this.title,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      id: json['id'] ?? 0,
      userId: json['userId'] ?? 0,
      title: json['title'] ?? 'Sem título',
    );
  }
}

class User {
  final int id;
  final String name;
  final String email;
  final String company;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.company,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? 0,
      name: json['name'] ?? 'Sem nome',
      email: json['email'] ?? 'Sem email',
      company: json['company']?['name'] ?? 'Sem empresa',
    );
  }
}