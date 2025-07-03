class UserBookDTO {
  final int? id;
  final int userId;
  final int bookId;
  final String status;

  UserBookDTO({
    this.id,
    required this.userId,
    required this.bookId,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': userId,
      'book_id': bookId,
      'status': status,
    };
  }
}