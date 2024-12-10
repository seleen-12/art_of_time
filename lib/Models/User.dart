class User{
  User({
    this.userID = 0,
    this.password = "",
    this.phoneNumber = "",
    this.email = "",
    this.fullName = "",
  });

  int userID;
  String password;
  String phoneNumber;
  String email;
  String fullName;


  factory User.fromJson(Map<String,dynamic>json)=>User(
    userID: json ["userID"],
    password: json ["password"],
    phoneNumber: json ["phoneNumber"],
    email: json ["email"],
    fullName: json ["fullName"],
  );

  Map<String,dynamic> toJson() => {
    "userID": userID,
    "password": password,
    "phoneNumber": phoneNumber,
    "email": email,
    "fullName": fullName,
  };
}