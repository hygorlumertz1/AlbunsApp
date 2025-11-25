import 'package:flutter/material.dart';
import '../models/photo.dart';
import '../services/api_service.dart';
import 'photo_detail_screen.dart';

class PhotosScreen extends StatefulWidget {
  final Album album;

  const PhotosScreen({
    Key? key,
    required this.album,
  }) : super(key: key);

  @override
  State<PhotosScreen> createState() => _PhotosScreenState();
}

class _PhotosScreenState extends State<PhotosScreen> {
  late Future<List<Photo>> futurePhotos;

  @override
  void initState() {
    super.initState();
    futurePhotos = ApiService.fetchPhotos(widget.album.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.album.title),
      ),
      body: FutureBuilder<List<Photo>>(
        future: futurePhotos,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  Colors.blue[600]!,
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Erro ao carregar fotos',
                style: TextStyle(color: Colors.grey[600]),
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                'Nenhuma foto encontrada',
                style: TextStyle(color: Colors.grey[600]),
              ),
            );
          }

          final photos = snapshot.data!;

          return GridView.builder(
            padding: const EdgeInsets.all(8),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: photos.length,
            itemBuilder: (context, index) {
              final photo = photos[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          PhotoDetailScreen(photo: photo),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey[200],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8),
                          ),
                          child: Image.network(
                            photo.thumbnailUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: Colors.grey[300],
                                child: const Icon(Icons.broken_image),
                              );
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4),
                        child: Text(
                          photo.titulo.isNotEmpty
                              ? photo.titulo
                              : 'Sem título',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black87,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}