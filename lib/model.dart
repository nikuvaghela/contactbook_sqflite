import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class model
{
    Future<Database> createdatabase()
    async {
        // Create Database
        // Create Table

        // Get a location using getDatabasesPath
        var databasesPath = await getDatabasesPath();
        String path = join(databasesPath, 'demo.db');
        print("Database path : $databasesPath");
        // open the database
        Database database = await openDatabase(path, version: 1,
            onCreate: (Database db, int version) async {
                // When creating the db, create the table
                await db.execute(
                    'CREATE TABLE contactbook (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, contact TEXT)');
            });
        print("Data base : $database");
        return database;
    }


}