import 'package:mysql1/mysql1.dart';
import '../Models/Task.dart';
import '../Models/User.dart';

var _conn;

Future<void> connectToDB() async {
  var settings = new ConnectionSettings(
      host: '10.0.2.2',
      port: 3306,
      user: 'root',
      db: 'seleen_12'
  );

  _conn = await MySqlConnection.connect(settings);
}

Future<void> showUsers() async {

  connectToDB();

  var results = await _conn.query(
    'select * from users',);
  for (var row in results) {
    print('userID: ${row[0]}, firstName: ${row[1]} lastName: ${row[2]}');
  }
}

Future<void> insertUser(User user) async {

  connectToDB();

  var result = await _conn.query(
      'insert into users (email, password, fullName, gender, type, religion, birthDate) values (?, ?, ?, ?, ?, ?, ?)',
      [user.email, user.password, user.fullName]);
  print('Inserted row id=${result.insertId}');
  await _conn.close();
}

Future<void> insertTask(Task task) async {

  connectToDB();

  var result = await _conn.query(
      'insert into users (taskName, howLong) values (?, ?, ?)',
      [task.taskName, task.howLong]);
  print('Inserted row insertTask id=${result.insertId}');
  await _conn.close();
}

Future<User> checkLogin(User user) async {

  connectToDB();

  var result = await _conn.query(
      'select * from users where password= ?', [user.password]);
  await _conn.close();
  return result;
}