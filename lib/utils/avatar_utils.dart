String getAvatarDisplay(String? username) {
  String result = "";
  if (username!.isEmpty) {
    return "Unknown";
  }
  // Split the username by spaces to extract initials from first and last name
  List<String> nameParts = username!.split(" ");

  for (String part in nameParts) {
    if (part.isNotEmpty && part[0].toUpperCase() == part[0]) {
      result += part[0].toUpperCase(); // Add uppercase initials
    }
  }

  // If result is still empty, fallback to default initials
  if (result.isEmpty && username.isNotEmpty) {
    result = username[0].toUpperCase(); // Use the first letter of the username
  }

  return result;
}
