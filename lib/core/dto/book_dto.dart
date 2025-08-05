class BookDTO {
  final String? id;
  final String title;
  final String author;
  final int? publishedYear;
  final String? isbn;
  final String? description;
  final String? coverUrl;
  final int? pages;
  final String? genre;

  BookDTO({
    this.id,
    required this.title,
    required this.author,
    this.publishedYear,
    this.isbn,
    this.description,
    this.coverUrl,
    this.pages,
    this.genre,
  });

  int get year => publishedYear ?? 0;

  factory BookDTO.fromMap(Map<String, dynamic> map) {
    return BookDTO(
      id: map['id'] as String?,
      title: map['title'] as String,
      author: map['author'] as String,
      publishedYear: map['published_year'] != null 
          ? (map['published_year'] is String 
              ? int.tryParse(map['published_year']) 
              : map['published_year'] as int?)
          : null,
      isbn: map['isbn'] as String?,
      description: map['description'] as String?,
      coverUrl: map['cover_url'] as String?,
      pages: map['pages'] != null 
          ? (map['pages'] is String 
              ? int.tryParse(map['pages']) 
              : map['pages'] as int?)
          : null,
      genre: map['genre'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'title': title,
      'author': author,
    };
    
    if (id != null) map['id'] = id;
    if (publishedYear != null) map['published_year'] = publishedYear;
    if (isbn != null) map['isbn'] = isbn;
    if (description != null) map['description'] = description;
    if (coverUrl != null) map['cover_url'] = coverUrl;
    if (pages != null) map['pages'] = pages;
    if (genre != null) map['genre'] = genre;
    
    return map;
  }

  BookDTO copyWith({
    String? id,
    String? title,
    String? author,
    int? publishedYear,
    String? isbn,
    String? description,
    String? coverUrl,
    int? pages,
    String? genre,
  }) {
    return BookDTO(
      id: id ?? this.id,
      title: title ?? this.title,
      author: author ?? this.author,
      publishedYear: publishedYear ?? this.publishedYear,
      isbn: isbn ?? this.isbn,
      description: description ?? this.description,
      coverUrl: coverUrl ?? this.coverUrl,
      pages: pages ?? this.pages,
      genre: genre ?? this.genre,
    );
  }
}