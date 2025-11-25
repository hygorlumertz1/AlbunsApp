import 'package:flutter/material.dart';
import '../models/photo.dart';
import '../services/api_service.dart';
import 'albums_screen.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({Key? key}) : super(key: key);

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  late Future<List<User>> futureUsers;
  String searchTerm = '';

  @override
  void initState() {
    super.initState();
    futureUsers = ApiService.fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Usuários'),
      ),
      body: Column(
        children: [
          // ============================================
          // BARRA DE BUSCA
          // ============================================
          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.grey[300]!,
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    searchTerm = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Buscar por nome...',
                  hintStyle: TextStyle(color: Colors.grey[400]),
                  prefixIcon: const Padding(
                    padding: EdgeInsets.all(12),
                    child: Text('🔍', style: TextStyle(fontSize: 18)),
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ),

          // ============================================
          // LISTA DE USUÁRIOS
          // ============================================
          Expanded(
            child: FutureBuilder<List<User>>(
              future: futureUsers,
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
                      'Erro ao carregar usuários',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(
                    child: Text(
                      'Nenhum usuário encontrado',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  );
                }

                final users = snapshot.data!;
                final filteredUsers = users
                    .where((user) => user.name
                        .toLowerCase()
                        .contains(searchTerm.toLowerCase()))
                    .toList();

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: filteredUsers.length,
                  itemBuilder: (context, index) {
                    final user = filteredUsers[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                AlbumsScreen(user: user),
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
                              // Avatar
                              Container(
                                width: 48,
                                height: 48,
                                decoration: BoxDecoration(
                                  color: Colors.blue[100],
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                child: Center(
                                  child: Text(
                                    user.name.isNotEmpty
                                        ? user.name[0].toUpperCase()
                                        : '?',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue[600],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),

                              // Informações
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      user.name,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      user.email,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      user.company,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey[500],
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // Seta
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
          ),
        ],
      ),
    );
  }
}