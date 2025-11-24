// ============================================
// App.js COM REACT NAVIGATION
// ============================================
// TECNOLOGIA ADICIONAL: React Navigation
// Benefícios: Navegação profissional, animações, histórico, deep linking

import React, { useState, useEffect } from 'react';
import {
  StyleSheet,
  Text,
  View,
  FlatList,
  TouchableOpacity,
  TextInput,
  Image,
  ActivityIndicator,
  Modal,
} from 'react-native';
import { NavigationContainer } from '@react-navigation/native';
import { createNativeStackNavigator } from '@react-navigation/native-stack';

const Stack = createNativeStackNavigator();

// ============================================
// TELA 1: Lista de Usuários
// ============================================
function UsersScreen({ navigation }) {
  const [users, setUsers] = useState([]);
  const [searchTerm, setSearchTerm] = useState('');
  const [loading, setLoading] = useState(false);

  useEffect(() => {
    fetchUsers();
  }, []);

  const fetchUsers = async () => {
    setLoading(true);
    try {
      const response = await fetch('https://jsonplaceholder.typicode.com/users');
      const data = await response.json();
      setUsers(data);
    } catch (error) {
      console.error('Erro ao buscar usuários:', error);
    }
    setLoading(false);
  };

  const filteredUsers = users.filter((user) =>
    user.name.toLowerCase().includes(searchTerm.toLowerCase())
  );

  const handleUserSelect = (user) => {
    navigation.navigate('Albums', { user });
  };

  return (
    <View style={styles.container}>
      <View style={styles.searchContainer}>
        <Text style={styles.searchIcon}>🔍</Text>
        <TextInput
          style={styles.searchInput}
          placeholder="Buscar por nome..."
          value={searchTerm}
          onChangeText={setSearchTerm}
          placeholderTextColor="#999"
        />
      </View>

      {loading ? (
        <View style={styles.loadingContainer}>
          <ActivityIndicator size="large" color="#2563eb" />
        </View>
      ) : (
        <FlatList
          data={filteredUsers}
          keyExtractor={(item) => item.id.toString()}
          contentContainerStyle={styles.listContainer}
          renderItem={({ item }) => (
            <TouchableOpacity
              style={styles.userCard}
              onPress={() => handleUserSelect(item)}
            >
              <View style={styles.userAvatar}>
                <Text style={styles.userAvatarText}>
                  {item.name.charAt(0)}
                </Text>
              </View>
              <View style={styles.userInfo}>
                <Text style={styles.userName}>{item.name}</Text>
                <Text style={styles.userEmail}>{item.email}</Text>
                <Text style={styles.userCompany}>{item.company.name}</Text>
              </View>
              <Text style={styles.chevron}>›</Text>
            </TouchableOpacity>
          )}
        />
      )}
    </View>
  );
}

// ============================================
// TELA 2: Lista de Álbuns
// ============================================
function AlbumsScreen({ route, navigation }) {
  const { user } = route.params;
  const [albums, setAlbums] = useState([]);
  const [loading, setLoading] = useState(false);

  useEffect(() => {
    fetchAlbums();
  }, []);

  const fetchAlbums = async () => {
    setLoading(true);
    try {
      const response = await fetch(
        `https://jsonplaceholder.typicode.com/albums?userId=1` // Fixei o id para que todos os usuários vejam os mesmos álbuns da api de albuns, pois a api é limitada a 30 imagens
        
      );
      const data = await response.json();
      setAlbums(data);
    } catch (error) {
      console.error('Erro ao buscar álbuns:', error);
    }
    setLoading(false);
  };

  return (
    <View style={styles.container}>
      {loading ? (
        <View style={styles.loadingContainer}>
          <ActivityIndicator size="large" color="#2563eb" />
        </View>
      ) : (
        <FlatList
          data={albums}
          keyExtractor={(item) => item.id.toString()}
          contentContainerStyle={styles.listContainer}
          renderItem={({ item }) => (
            <TouchableOpacity
              style={styles.albumCard}
              onPress={() => navigation.navigate('Photos', { album: item })}
            >
              <View style={styles.albumIcon}>
                <Text style={styles.albumIconText}>📁</Text>
              </View>
              <View style={styles.albumInfo}>
                <Text style={styles.albumTitle} numberOfLines={2}>
                  {item.title}
                </Text>
                <Text style={styles.albumCount}>3 fotos</Text>
              </View>
              <Text style={styles.chevron}>›</Text>
            </TouchableOpacity>
          )}
        />
      )}
    </View>
  );
}

// ============================================
// TELA 3: Grid de Fotos
// ============================================
function PhotosScreen({ route, navigation }) {
  const { album } = route.params;
  const [photos, setPhotos] = useState([]);
  const [loading, setLoading] = useState(false);

  useEffect(() => {
    fetchPhotos();
  }, []);

  const fetchPhotos = async () => {
    setLoading(true);
    try {
      const response = await fetch(
        `https://my-json-server.typicode.com/hygorlumertz1/albuns-api/fotos?albumId=${album.id}`
    );
      const data = await response.json();
      setPhotos(data);
    } catch (error) {
      console.error('Erro ao buscar fotos:', error);
    }
    setLoading(false);
  };

  return (
    <View style={styles.container}>
      {loading ? (
        <View style={styles.loadingContainer}>
          <ActivityIndicator size="large" color="#2563eb" />
        </View>
      ) : (
        <FlatList
          data={photos}
          keyExtractor={(item) => item.id.toString()}
          numColumns={3}
          contentContainerStyle={styles.photoGridContainer}
          renderItem={({ item }) => (
            <TouchableOpacity
              style={styles.photoThumbnail}
              onPress={() => navigation.navigate('PhotoDetail', { photo: item })}
            >
              <Image
                source={{ uri: item.thumbnailUrl || item.url }}
                style={styles.thumbnailImage}
                resizeMode="cover"
              />
              <Text
                numberOfLines={2}
                style={{
                  fontSize: 12,
                  color: '#111',
                  textAlign: 'center',
                  marginTop: 6,
                  paddingHorizontal: 4,
                }}
              >
                {item.titulo || item.title || 'Sem título'}
              </Text>
            </TouchableOpacity>
          )}
        />
      )}
    </View>
  );
}

// ============================================
// TELA 4: Foto Ampliada
// ============================================
function PhotoDetailScreen({ route, navigation }) {
  const { photo } = route.params;

  return (
    <View style={styles.photoDetailContainer}>
      <View style={styles.photoDetailHeader}>
        <TouchableOpacity
          onPress={() => navigation.goBack()}
          style={styles.closeButton}
        >
          <Text style={styles.closeButtonText}>✕</Text>
        </TouchableOpacity>
        <Text style={styles.photoDetailTitle}>Foto</Text>
        <View style={{ width: 40 }} />
      </View>

      <View style={styles.photoDetailContent}>
        <Image
          source={{ uri: photo.url }}
          style={styles.fullImage}
          resizeMode="contain"
        />
      </View>

      <View style={styles.photoDetailFooter}>
        <Text style={styles.photoTitle}>{photo.titulo || photo.title || 'Sem título'}</Text>
      </View>
    </View>
  );
}

// ============================================
// NAVEGAÇÃO PRINCIPAL
// ============================================
export default function App() {
  return (
    <NavigationContainer>
      <Stack.Navigator
        screenOptions={{
          headerStyle: {
            backgroundColor: '#2563eb',
          },
          headerTintColor: '#fff',
          headerTitleStyle: {
            fontWeight: 'bold',
          },
        }}
      >
        <Stack.Screen
          name="Users"
          component={UsersScreen}
          options={{ title: 'Usuários' }}
        />
        <Stack.Screen
          name="Albums"
          component={AlbumsScreen}
          options={({ route }) => ({ title: `Álbuns de ${route.params.user.name}` })}
        />
        <Stack.Screen
          name="Photos"
          component={PhotosScreen}
          options={({ route }) => ({ title: route.params.album.title })}
        />
        <Stack.Screen
          name="PhotoDetail"
          component={PhotoDetailScreen}
          options={{
            title: 'Foto',
            headerShown: false,
            presentation: 'modal',
          }}
        />
      </Stack.Navigator>
    </NavigationContainer>
  );
}

// ============================================
// ESTILOS (mesmos do anterior)
// ============================================
const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#f9fafb',
  },
  searchContainer: {
    flexDirection: 'row',
    alignItems: 'center',
    backgroundColor: '#fff',
    margin: 16,
    paddingHorizontal: 16,
    paddingVertical: 12,
    borderRadius: 12,
    borderWidth: 1,
    borderColor: '#e5e7eb',
  },
  searchIcon: {
    fontSize: 20,
    marginRight: 8,
  },
  searchInput: {
    flex: 1,
    fontSize: 16,
    color: '#111',
  },
  loadingContainer: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
  },
  listContainer: {
    padding: 16,
  },
  userCard: {
    flexDirection: 'row',
    alignItems: 'center',
    backgroundColor: '#fff',
    padding: 16,
    marginBottom: 12,
    borderRadius: 12,
    borderWidth: 1,
    borderColor: '#e5e7eb',
    elevation: 2,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 1 },
    shadowOpacity: 0.05,
    shadowRadius: 2,
  },
  userAvatar: {
    width: 48,
    height: 48,
    borderRadius: 24,
    backgroundColor: '#dbeafe',
    justifyContent: 'center',
    alignItems: 'center',
    marginRight: 12,
  },
  userAvatarText: {
    fontSize: 20,
    fontWeight: 'bold',
    color: '#2563eb',   
  },
  userInfo: {
    flex: 1,
  },
  userName: {
    fontSize: 16,
    fontWeight: '600',
    color: '#111',
    marginBottom: 4,
  },
  userEmail: {
    fontSize: 14,
    color: '#6b7280',
    marginBottom: 2,
  },
  userCompany: {
    fontSize: 12,
    color: '#9ca3af',
  },
  chevron: {
    fontSize: 24,
    color: '#9ca3af',
    marginLeft: 8,
  },
  albumCard: {
    flexDirection: 'row',
    alignItems: 'center',
    backgroundColor: '#fff',
    padding: 16,
    marginBottom: 12,
    borderRadius: 12,
    borderWidth: 1,
    borderColor: '#e5e7eb',
    elevation: 2,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 1 },
    shadowOpacity: 0.05,
    shadowRadius: 2,
  },
  albumIcon: {
    width: 48,
    height: 48,
    borderRadius: 8,
    backgroundColor: '#ede9fe',
    justifyContent: 'center',
    alignItems: 'center',
    marginRight: 12,
  },
  albumIconText: {
    fontSize: 24,
  },
  albumInfo: {
    flex: 1,
  },
  albumTitle: {
    fontSize: 16,
    fontWeight: '600',
    color: '#111',
    marginBottom: 4,
  },
  albumCount: {
    fontSize: 14,
    color: '#6b7280',
  },
  photoGridContainer: {
    padding: 8,
  },
  photoThumbnail: {
    width: '33.33%',
    aspectRatio: 1,
    padding: 4,
  },
  thumbnailImage: {
    width: '100%',
    height: '100%',
    borderRadius: 8,
    backgroundColor: '#f3f4f6',
  },
  photoDetailContainer: {
    flex: 1,
    backgroundColor: '#000',
  },
  photoDetailHeader: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'space-between',
    backgroundColor: 'rgba(0, 0, 0, 0.8)',
    paddingVertical: 16,
    paddingHorizontal: 16,
    paddingTop: 48,
  },
  closeButton: {
    width: 40,
    height: 40,
    justifyContent: 'center',
    alignItems: 'center',
  },
  closeButtonText: {
    color: '#fff',
    fontSize: 24,
    fontWeight: 'bold',
  },
  photoDetailTitle: {
    color: '#fff',
    fontSize: 16,
    fontWeight: '600',
  },
  photoDetailContent: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    padding: 16,
  },
  fullImage: {
    width: '100%',
    height: '100%',
  },
  photoDetailFooter: {
    backgroundColor: 'rgba(0, 0, 0, 0.8)',
    padding: 16,
  },
  photoTitle: {
    color: '#fff',
    fontSize: 14,
    textAlign: 'center',
  },
});