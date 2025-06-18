final _book = '''
CREATE TABLE books (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT NOT NULL,
    author TEXT NOT NULL,
    year INTEGER NOT NULL,
    isbn TEXT NOT NULL UNIQUE
)
''';

final createTables = [_book];

final insertBooks = [
  '''INSERT INTO books (title, author, year, isbn) VALUES ('Dom Casmurro', 'Machado de Assis', 1899, '978-8535914681')''',
  '''INSERT INTO books (title, author, year, isbn) VALUES ('Grande Sertão: Veredas', 'João Guimarães Rosa', 1956, '978-8535910737')''',
  '''INSERT INTO books (title, author, year, isbn) VALUES ('Vidas Secas', 'Graciliano Ramos', 1938, '978-8577990543')''',
  '''INSERT INTO books (title, author, year, isbn) VALUES ('O Cortiço', 'Aluísio Azevedo', 1890, '978-8508111233')''',
  '''INSERT INTO books (title, author, year, isbn) VALUES ('Macunaíma', 'Mário de Andrade', 1928, '978-8503006833')'''
];