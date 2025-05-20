class Task{
  Task({
    this.taskID = 0,
    this.taskName = "",
    this.howLong = 0,
    this.userID = 0,
    this.statusID = 0,
    this.dateTime = "",
    this.statusName = "",

  });

  int taskID;
  String taskName;
  int howLong;
  int userID;
  int statusID;
  String dateTime;
  String statusName;

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      taskID: json['taskID'],
      taskName: json["taskName"],
      howLong: json["howLong"],
      userID: json["userID"],
      statusID: json["statusID"],
      statusName: json["statusName"],
      dateTime: json["dateTime"],

    );
  }

  Map<String,dynamic> toJson() => {
    "taskID":taskID,
    "taskName": taskName,
    "howLong": howLong,
    "userID": userID,
    "statusID": statusID,
    "statusName": statusName,
    "dateTime": dateTime,
  };
}