# 📱 Aplicativo Mobile - Álbuns e Fotos

## Projeto de Desenvolvimento Mobile - Fase 2

---

## 📋 Sobre o Projeto

Aplicativo mobile desenvolvido em **React Native** para consumo da API gratuita JSONPlaceholder. O app permite visualizar usuários, seus álbuns de fotos e navegar pelas imagens com recursos de busca e filtros.

### 🎯 Funcionalidades Implementadas

#### ✅ Funcionalidades Macro
1. **Listagem de Usuários** - Exibe todos os usuários da API com informações detalhadas
2. **Listagem de Álbuns** - Mostra os álbuns do usuário selecionado
3. **Listagem de Fotos** - Grid de thumbnails das fotos de um álbum específico
4. **Foto Ampliada** - Visualização em tela cheia com título da foto

#### ✅ Funcionalidades Micro
- **Filtro por nome** - Busca em tempo real de usuários
- **Descrição de foto** - Exibição do título completo na tela ampliada
- **Loading states** - Indicadores visuais durante carregamento
- **Navegação intuitiva** - Botões de voltar em todas as telas

---

## 🛠️ Tecnologias Utilizadas

- **React Native** (Plataforma principal)
- **JavaScript/ES6+**
- **Fetch API** para consumo de dados
- **JSONPlaceholder API** (https://jsonplaceholder.typicode.com/)
- **Componentes Nativos**: FlatList, Modal, Image, TouchableOpacity, TextInput

---

## 📂 Estrutura do Projeto

```
AlbunsApp/
├── App.js                 # Arquivo principal com todas as telas
├── package.json           # Dependências do projeto
├── app.json              # Configurações do Expo
├── babel.config.js       # Configuração Babel
├── README.md             # Esta documentação
└── assets/               # Recursos do app
```

---

## 🚀 Como Executar o Projeto

### Pré-requisitos

- Node.js instalado (v14 ou superior)
- npm ou yarn
- Expo CLI (recomendado) ou React Native CLI

### Instalação e Execução

#### Opção 1: Usando Expo (Recomendado)

```bash
# 1. Clone ou extraia o projeto
cd AlbunsApp

# 2. Instale as dependências
npm install

# 3. Inicie o projeto
npx expo start

# 4. Escaneie o QR code com o app Expo Go (Android/iOS)
# Ou pressione 'a' para Android ou 'i' para iOS
```

#### Opção 2: Usando React Native CLI

```bash
# 1. Entre na pasta do projeto
cd AlbunsApp

# 2. Instale as dependências
npm install

# 3. Para Android
npx react-native run-android

# 4. Para iOS (apenas Mac)
npx react-native run-ios
```

---

## 🎨 Fluxo de Navegação

```
┌─────────────────────┐
│  Tela 1: Usuários   │
│  - Lista usuários   │
│  - Campo de busca   │
└──────────┬──────────┘
           │ (clica usuário)
           ↓
┌─────────────────────┐
│  Tela 2: Álbuns     │
│  - Lista álbuns     │
│  - Botão voltar     │
└──────────┬──────────┘
           │ (clica álbum)
           ↓
┌─────────────────────┐
│  Tela 3: Fotos      │
│  - Grid thumbnails  │
│  - Botão voltar     │
└──────────┬──────────┘
           │ (clica foto)
           ↓
┌─────────────────────┐
│ Tela 4: Foto Grande │
│  - Imagem ampliada  │
│  - Título da foto   │
│  - Botão fechar     │
└─────────────────────┘
```

---

## 🔌 Endpoints da API Utilizados

### 1. Buscar Usuários
```
GET https://jsonplaceholder.typicode.com/users
```

### 2. Buscar Álbuns de um Usuário
```
GET https://jsonplaceholder.typicode.com/albums?userId={id}
```

### 3. Buscar Fotos de um Álbum
```
GET https://jsonplaceholder.typicode.com/photos?albumId={id}
```

---

## 📱 Telas do Aplicativo

### Tela 1 - Lista de Usuários
- **Componentes**: Header, SearchBar, FlatList
- **Funcionalidades**: 
  - Busca em tempo real por nome
  - Lista scrollável de usuários
  - Exibe nome, email e empresa
  - Avatar com inicial do nome

### Tela 2 - Álbuns do Usuário
- **Componentes**: Header com botão voltar, FlatList
- **Funcionalidades**:
  - Lista todos os álbuns do usuário selecionado
  - Mostra título do álbum
  - Indica quantidade de fotos (50)

### Tela 3 - Grid de Fotos
- **Componentes**: Header com botão voltar, FlatList (numColumns=3)
- **Funcionalidades**:
  - Grid 3 colunas de thumbnails
  - Imagens carregadas da API
  - Scroll vertical

### Tela 4 - Foto Ampliada
- **Componentes**: Modal, Image
- **Funcionalidades**:
  - Foto em alta resolução
  - Título da foto
  - Botão fechar (X)
  - Fundo preto para destaque

---

## 🎯 Destaques Técnicos

### ✅ Boas Práticas Implementadas

- **Componentização**: Componente Header reutilizável
- **Estado centralizado**: Gerenciamento com useState
- **Hooks do React**: useEffect para chamadas de API
- **Performance**: FlatList para listas grandes
- **UX**: Loading indicators durante requisições
- **Responsividade**: Layout adaptável
- **Tratamento de erros**: try/catch nas requisições
- **Clean Code**: Código bem comentado e organizado

### 🎨 Design

- **Paleta de cores**: 
  - Primária: #2563eb (Azul)
  - Secundária: #7c3aed (Roxo para álbuns)
  - Fundo: #f9fafb (Cinza claro)
  
- **Tipografia**: Sistema padrão com diferentes pesos
- **Espaçamento**: Consistente (8px, 12px, 16px)
- **Elementos**: Bordas arredondadas, sombras sutis

---

## 📝 Observações Importantes

### Conformidade com o Enunciado

✅ **Fase 1**: Protótipo foi desenvolvido e entregue  
✅ **Fase 2**: Implementação completa em React Native  
✅ **API REST**: JSONPlaceholder totalmente integrado  
✅ **Funcionalidades dinâmicas**: Todas implementadas  
✅ **Navegação**: Conforme mapa da Fase 1  
✅ **Componentes**: Estrutura adequada React Native  

### Sobre as Imagens

O JSONPlaceholder já fornece URLs válidas para imagens através dos campos `thumbnailUrl` (150x150) e `url` (600x600). Não foi necessário criar um My JSON Server adicional, pois as imagens da API funcionam perfeitamente.

---

## 🎥 Vídeo Demonstrativo

**Link do YouTube**: [Inserir link do vídeo aqui]

### O que foi demonstrado no vídeo:
- ✅ Tela inicial de usuários
- ✅ Funcionalidade de busca/filtro
- ✅ Navegação para álbuns
- ✅ Seleção de álbum e visualização de fotos
- ✅ Abertura de foto ampliada
- ✅ Navegação de volta (todas as telas)
- ✅ Carregamento de dados da API

---

## 👨‍💻 Autor

**[Seu Nome]**  
Disciplina: Desenvolvimento Mobile  
Instituição: [Sua Instituição]  
Data: Novembro 2025

---

## 📄 Licença

Este projeto foi desenvolvido para fins acadêmicos.

---

## 🆘 Suporte

Em caso de dúvidas sobre a execução do projeto:
1. Verifique se todas as dependências foram instaladas
2. Certifique-se de ter o Node.js versão 14 ou superior
3. Para Expo: Instale o app "Expo Go" no celular
4. Verifique sua conexão com a internet (necessária para API)

---

**Desenvolvido com ❤️ em React Native**