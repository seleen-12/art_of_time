class User {
  User({
    this.id = "",
    this.name= "",
    this.phone = "",
    this.note = "",
    this.Address = "",
  });

  String id;
  String name;
  String note;
  String phone;
  String Address;

  factory User.fromJson(Map<String,dynamic> json)=>User(
  id: json ["id"],
  name: json["name"],
  phone: json["phine"],
  note: json["note"],
  Address: json["Address"],
  );
  Map<String,dynamic>toJson() => {
    "id": id,
    "name": name,
    "phone": phone,
    "note": note,
    "Address": Address,
  };
}