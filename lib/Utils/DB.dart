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
  // Query the database using a parameterized query
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
      'insert into users (email, phoneNumber, password, fullName) values (?, ?, ?, ?)',
        [user.email, user.phoneNumber, user.password, user.fullName]);
  print('Inserted row id=${result.insertId}');

  //////////
/*
  // Query the database using a parameterized query
  var results = await conn.query(
      'select * from users where userID = ?', [6]);  // [result.insertId]
  for (var row in results) {
    print('Name: ${row[0]}, email: ${row[1]} age: ${row[2]}');
  }
  // Update some data
  await conn.query('update users set firstName=? where userID=?', ['Bob', 5]);
  // Query again database using a parameterized query
  var results2 = await conn.query(
      'select * from users where userID = ?', [result.insertId]);
  for (var row in results2) {
    print('Name: ${row[0]}, email: ${row[1]} age: ${row[2]}');
  }
*/
  // Finally, close the connection
  await _conn.close();
}




Future<void> insertTask(Task task) async {

  connectToDB();

  var result = await _conn.query(
      'insert into users (taskName, howLong) values (?, ?, ?)',
      [task.taskName, task.howLong]);
  print('Inserted row insertTask id=${result.insertId}');
  // Finally, close the connection
  await _conn.close();
}


Future<User> checkLogin(User user) async {

  connectToDB();

  var result = await _conn.query(
      'select * from users where  phoneNumber=? and password= ?', [user.phoneNumber, user.password]);
  // print('Inserted row insertTask id=${result.insertId}');
  // Finally, close the connection
  await _conn.close();
  return result;

}
////////////////////////////////////////////////////////////////////////////////////////////////