class DocumentRequest {
  DocumentRequest({
    required this.id,
    required this.studentId,
    required this.requesterSchool,
    required this.reason,
    required this.status,
    required this.guardianConsent,
    required this.createdAt,
  });

  final String id;
  final String studentId;
  final String requesterSchool;
  final String reason;
  final String status;
  final bool guardianConsent;
  final DateTime createdAt;
}
