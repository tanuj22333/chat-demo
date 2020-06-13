
class Profile {
  final String firstName;
  final String lastName;

  Profile(this.firstName, this.lastName);

  factory Profile.fromJson(Map<String, dynamic> json){
    return Profile(json["firstName"], json["lastName"]);
  }
}