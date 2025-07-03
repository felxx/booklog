const String createUserTable = '''
CREATE TABLE users (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    username TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE,
    password TEXT NOT NULL,
    role TEXT NOT NULL
)
''';

const String createBooksTable = '''
CREATE TABLE books (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT NOT NULL,
    author TEXT NOT NULL,
    year INTEGER NOT NULL,
    isbn TEXT NOT NULL UNIQUE
)
''';

const String createUserBooksTable = '''
CREATE TABLE user_books (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER NOT NULL,
    book_id INTEGER NOT NULL,
    status TEXT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users (id),
    FOREIGN KEY (book_id) REFERENCES books (id),
    UNIQUE (user_id, book_id, status)
)
''';

final List<String> createTables = [
  createUserTable,
  createBooksTable,
  createUserBooksTable,
];

final List<String> initialInserts = [
  '''INSERT INTO books (title, author, year, isbn) VALUES ('Dom Casmurro', 'Machado de Assis', 1899, '978-8535914681')''',
  '''INSERT INTO books (title, author, year, isbn) VALUES ('Grande Sertão: Veredas', 'João Guimarães Rosa', 1956, '978-8535910737')''',
  '''INSERT INTO books (title, author, year, isbn) VALUES ('Vidas Secas', 'Graciliano Ramos', 1938, '978-8577990543')''',
  '''INSERT INTO books (title, author, year, isbn) VALUES ('O Cortiço', 'Aluísio Azevedo', 1890, '978-8508111233')''',
  '''INSERT INTO books (title, author, year, isbn) VALUES ('Macunaíma', 'Mário de Andrade', 1928, '978-8503006833')''',
  '''INSERT INTO users (username, email, password, role) VALUES ('Admin', 'igoradmin123@gmail.com', 'root1234', 'ADMIN')'''
];