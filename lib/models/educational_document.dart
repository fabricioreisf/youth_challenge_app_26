class EducationalDocument {
  EducationalDocument({
    required this.id,
    required this.studentId,
    required this.type,
    required this.title,
    required this.fileName,
    required this.hash,
    required this.attestationId,
    required this.status,
    required this.createdAt,
  });

  final String id;
  final String studentId;
  final String type;
  final String title;
  final String fileName;
  final String hash;
  final String attestationId;
  final String status;
  final DateTime createdAt;
}
