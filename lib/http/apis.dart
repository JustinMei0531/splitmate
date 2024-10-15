/**
 * All network interfaces are here.
 */

class Apis {
  static const String baseURL = "http://10.0.2.2:8000/api";

  static const String register = "$baseURL/register"; // User register

  static const String login = "$baseURL/login"; // User login

  static const String userInfo = "$baseURL/user";

  static const String allTenants = "$baseURL/tenants";
}
