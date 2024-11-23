class Status{
  Status({
    this.statusID = 0,
    this.statusName = "",
});

   int statusID;
   String statusName;

  factory Status.fromJson(Map<String,dynamic>json)=>Status(
    statusID: json ["statusID"],
    statusName: json ["statusName"],
  );
  Map<String,dynamic> toJson() => {
    "statusID":statusID,
    "statusName": statusName,
  };
}