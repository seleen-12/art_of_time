class User{
  User({
    this.userID = 0,
    this.password = "",
    this.email = "",
    this.fullName = "",
    this.gender = "",
    this.type = "",
    this.religion = "",
    this.birthDate = "",
  });

  int userID;
  String password;
  String email;
  String fullName;
  String gender;
  String type;
  String religion;
  String birthDate;

  factory User.fromJson(Map<String,dynamic>json)=>User(
    userID: json ["userID"],
    password: json ["password"],
    email: json ["email"],
    fullName: json ["fullName"],
    gender: json ["gender"],
    type: json ["type"],
    religion: json ["religion"],
    birthDate: json ["birthDate"],

  );

  Map<String,dynamic> toJson() => {
    "userID": userID,
    "password": password,
    "email": email,
    "fullName": fullName,
    "gender": gender,
    "type": type,
    "religion": religion,
    "birthDate": birthDate,
  };
}