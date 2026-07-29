class VerificationRecord {
  VerificationRecord({
    required this.documentId,
    required this.attestationId,
    required this.hash,
    required this.verifiedAt,
    required this.isValid,
  });

  final String documentId;
  final String attestationId;
  final String hash;
  final DateTime verifiedAt;
  final bool isValid;
}
