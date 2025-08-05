class UserBookDTO {
  final String? id;
  final String userId;
  final String bookId;
  final String status;
  final int? rating;
  final String? review;
  final DateTime? startDate;
  final DateTime? finishDate;
  final bool isFavorite;

  UserBookDTO({
    this.id,
    required this.userId,
    required this.bookId,
    required this.status,
    this.rating,
    this.review,
    this.startDate,
    this.finishDate,
    this.isFavorite = false,
  });

  factory UserBookDTO.fromMap(Map<String, dynamic> map) {
    return UserBookDTO(
      id: map['id'] as String?,
      userId: map['user_id'] as String,
      bookId: map['book_id'] as String,
      status: map['status'] as String,
      rating: map['rating'] as int?,
      review: map['review'] as String?,
      startDate: map['start_date'] != null ? DateTime.parse(map['start_date']) : null,
      finishDate: map['finish_date'] != null ? DateTime.parse(map['finish_date']) : null,
      isFavorite: map['is_favorite'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'user_id': userId,
      'book_id': bookId,
      'status': status,
      'is_favorite': isFavorite,
    };
    
    if (id != null) map['id'] = id;
    if (rating != null) map['rating'] = rating;
    if (review != null) map['review'] = review;
    if (startDate != null) map['start_date'] = startDate!.toIso8601String().split('T')[0];
    if (finishDate != null) map['finish_date'] = finishDate!.toIso8601String().split('T')[0];
    
    return map;
  }

  UserBookDTO copyWith({
    String? id,
    String? userId,
    String? bookId,
    String? status,
    int? rating,
    String? review,
    DateTime? startDate,
    DateTime? finishDate,
    bool? isFavorite,
  }) {
    return UserBookDTO(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      bookId: bookId ?? this.bookId,
      status: status ?? this.status,
      rating: rating ?? this.rating,
      review: review ?? this.review,
      startDate: startDate ?? this.startDate,
      finishDate: finishDate ?? this.finishDate,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}