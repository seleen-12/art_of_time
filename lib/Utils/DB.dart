import 'package:mysql1/mysql1.dart';

var _conn;

void main(){
  showUsers();
  insertUser("Seleen","123","Seleen");
}




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

  // Query the database using a parameterized query
  var results = await _conn.query(
    'select * from users',);
  for (var row in results) {
    print('userID: ${row[0]}, firstName: ${row[1]} lastName: ${row[2]}');
  }
}



Future<void> insertUser(firstName,LastName,Password) async {
  var settings =new ConnectionSettings(
    host: '10.0.2.2',
    port: 3306,
   user: 'root',
    db: 'seleen_12'
  );
  var conn =await MySqlConnection.connect(settings);

  var result = await _conn.query(
      'insert into users (firstName, password, lastName) values (?, ?, ?)',
        [firstName, LastName, Password]);
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



////////////////////////////////////////////////////////////////////////////////////////////////
