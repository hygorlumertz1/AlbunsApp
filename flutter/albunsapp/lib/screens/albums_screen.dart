import 'package:flutter/material.dart';
import '../models/photo.dart';
import '../services/api_service.dart';
import 'photos_screen.dart';

class AlbumsScreen extends StatefulWidget {
  final User user;

  const AlbumsScreen({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<AlbumsScreen> createState() => _AlbumsScreenState();
}

class _AlbumsScreenState extends State<AlbumsScreen> {
  late Future<List<Album>> futureAlbums;

  @override
  void initState() {
    super.initState();
    futureAlbums = ApiService.fetchAlbums(widget.user.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Álbuns de ${widget.user.name}'),
      ),
      body: FutureBuilder<List<Album>>(
        future: futureAlbums,
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
                'Erro ao carregar álbuns',
                style: TextStyle(color: Colors.grey[600]),
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                'Nenhum álbum encontrado',
                style: TextStyle(color: Colors.grey[600]),
              ),
            );
          }

          final albums = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            itemCount: albums.length,
            itemBuilder: (context, index) {
              final album = albums[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PhotosScreen(album: album),
                    ),
                  );
                },
                child: Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: Colors.purple[50],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Center(
                            child: Text(
                              '📁',
                              style: TextStyle(fontSize: 24),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                album.title,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '3 fotos',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          '›',
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.grey[400],
                          ),
                        ),
                      ],
                    ),
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