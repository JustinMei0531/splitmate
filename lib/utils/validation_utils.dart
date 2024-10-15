bool isValidEmail(String email) {
  final RegExp reg =
      RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
  return reg.hasMatch(email);
}
