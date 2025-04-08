class User{
  User({
    this.userID = 0,
    this.password = "",
    this.email = "",
    this.fullName = "",
  });

  int userID;
  String password;
  String email;
  String fullName;

  factory User.fromJson(Map<String,dynamic>json)=>User(
    userID: json ["userID"],
    password: json ["password"],
    email: json ["email"],
    fullName: json ["fullName"],
  );

  Map<String,dynamic> toJson() => {
    "userID": userID,
    "password": password,
    "email": email,
    "fullName": fullName,
  };
}