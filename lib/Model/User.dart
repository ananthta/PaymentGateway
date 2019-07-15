import 'package:coromandel_mobile/Model/dto/AddressVerification/AddressDto.dart';
/* User class is a singleton, that holds key information about a User
This information is the User's address, emails, and other preferences
* */
class User {
  static final User instance = new User._internal();

  AddressDto address;

  factory User() {
    return instance;
  }

  User._internal() {
    address = new AddressDto();
  }
}
