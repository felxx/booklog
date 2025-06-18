class BookDTO {
  final int? id;
  final String title;
  final String author;
  final int year;
  final String isbn;

  BookDTO({
    this.id,
    required this.title,
    required this.author,
    required this.year,
    required this.isbn,
  });

  factory BookDTO.fromMap(Map<String, dynamic> map) {
    return BookDTO(
      id: map['id'] as int?,
      title: map['title'] as String,
      author: map['author'] as String,
      year: map['year'] as int,
      isbn: map['isbn'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'year': year,
      'isbn': isbn,
    };
  }

  BookDTO copyWith({
    int? id,
    String? title,
    String? author,
    int? year,
    String? isbn,
  }) {
    return BookDTO(
      id: id ?? this.id,
      title: title ?? this.title,
      author: author ?? this.author,
      year: year ?? this.year,
      isbn: isbn ?? this.isbn,
    );
  }
}