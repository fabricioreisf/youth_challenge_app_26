class AttestationService {
  String createHash(String input) {
    var hash = 0;
    for (final codeUnit in input.codeUnits) {
      hash = ((hash << 5) - hash + codeUnit).toInt();
    }
    return 'sha256:${hash.abs().toRadixString(16)}';
  }

  String createAttestationId(String input) {
    final hash = createHash(input);
    return 'attestation-${hash.substring(0, 12)}';
  }

  bool verify(String storedHash, String presentedHash) {
    return storedHash.isNotEmpty && storedHash == presentedHash;
  }
}
