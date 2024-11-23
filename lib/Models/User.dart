class User{
  User({
    this.userID = 0,
    this.password = "",
    this.phoneNumberOrEmail = "",
    this.name = "",
  });

  int userID;
  String password;
  String phoneNumberOrEmail;
  String name;

  factory User.fromJson(Map<String,dynamic>json)=>User(
    userID: json ["userID"],
    password: json ["password"],
    phoneNumberOrEmail: json ["phoneNumberOrEmail"],
    name: json ["name"],
  );

  Map<String,dynamic> toJson() => {
    "userID": userID,
    "password": password,
    "phoneNumberOrEmail": phoneNumberOrEmail,
    "name": name,
  };
}