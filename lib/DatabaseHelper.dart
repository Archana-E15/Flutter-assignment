// // DatabaseHelper.dart
// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';
// import 'model.dart';
// class DatabaseHelper {
//   Database? _database;

//   Future<Database> get database async {
//     if (_database != null) return _database!;
//     _database = await openDatabase(
//       join(await getDatabasesPath(), 'items.db'),
//       onCreate: (db, version) {
//         return db.execute(
//           "CREATE TABLE items(id INTEGER PRIMARY KEY, name TEXT)",
//         );
//       },
//       version: 1,
//     );
//     return _database!;
//   }

//   Future<void> insertItem(Stock item) async {
//     final db = await database;
//     await db.insert('items', item.toJson());
//   }

//   Future<List<Stock>> getItems() async {
//     final db = await database;
//     final List<Map<String, dynamic>> maps = await db.query('items');
//     return List.generate(maps.length, (i) {
//       return Stock(
//         symbol: maps[i]['symbol'],
//         name: maps[i]['name'],
//         type: maps[i]['type'],
//     region:  maps[i]['region'],
//     marketOpen: maps[i]['marketOpen'],
//     marketClose: maps[i]['marketClose'],
//     timezone: maps[i]['timezone'],
//     currency:  maps[i]['currency'],
//     matchScore:  maps[i]['matchScore'],
//       );
//     });
//   }

//   insertStock(Stock stock) {}
// }

// // import 'package:sqflite/sqflite.dart';
// // import 'package:path/path.dart';

// // class StockDatabase {
// //   Database? _database;

// //   Future open() async {
// //     if (_database == null) {
// //       _database = await openDatabase(
// //         join(await getDatabasesPath(), 'stocks.db'),
// //         version: 1,
// //         onCreate: (db, version) {
// //           db.execute('''
// //             CREATE TABLE stocks(
// //               id INTEGER PRIMARY KEY AUTOINCREMENT,
// //               symbol TEXT,
// //               name TEXT
// //             )
// //           ''');
// //         },
// //       );
// //     }
// //   }

// //   Future<int> insertStock(Stock stock) async {
// //     await open();
// //     return await _database!.insert('stocks', stock.toJson());
// //   }

// //   Future<List<Stock>> getStocks() async {
// //     await open();
// //     final List<Map<String, dynamic>> maps = await _database!.query('stocks');
// //     return List.generate(maps.length, (i) {
// //       return Stock(
// //        symbol: maps[i]['symbol'],
// //         name: maps[i]['name'],
// //         type: maps[i]['type'],
// //     region:  maps[i]['region'],
// //     marketOpen: maps[i]['marketOpen'],
// //     marketClose: maps[i]['marketClose'],
// //     timezone: maps[i]['timezone'],
// //     currency:  maps[i]['currency'],
// //     matchScore:  maps[i]['matchScore'],
// //       );
// //     });
// //   }

// //   Future<void> deleteStock(int id) async {
// //     await open();
// //     await _database!.delete('stocks', where: 'id = ?', whereArgs: [id]);
// //   }
// // }

// // class Stock {
// //   int id;
// //   String symbol;
// //   String name;

// //   Stock({this.id, this.symbol, this.name});

// //   Map<String, dynamic> toMap() {
// //     return {'symbol': symbol, 'name': name};
// //   }
// // }


import 'package:sqflite/sqflite.dart';
import 'package:stock_watchlist/model.dart';

class DatabaseHelper {
  Database? _database;

Future openDatabase(String s, {required Future<Null> Function(Database db, int version) onCreate, required int version}) async {
  final dbPath = await getDatabasesPath(); // Get the path to the directory where databases are stored.
  _database = await openDatabase(
    '$dbPath/stocks.db', // Specify the full path to the database file.
    version: 1,
    onCreate: (Database db, int version) async {
      await db.execute('''CREATE TABLE stocks(
symbol String , name String, type String, region String,
          marketOpen String, marketClose String ,timezone String
           ,currency String, matchScore String)''');
    },
  );
}

  Future insertStock(Stock stock) async {
  return  await _database?.insert('stocks', stock.toJson());
  }

  Future<List<Stock>> getStocks() async {
    final List<Map<String, dynamic>> maps = await _database!.query('stocks');
    return List.generate(maps.length, (i) {
      return Stock(
       symbol: maps[i]['symbol'],
        name: maps[i]['name'],
        type: maps[i]['type'],
    region:  maps[i]['region'],
    marketOpen: maps[i]['marketOpen'],
    marketClose: maps[i]['marketClose'],
    timezone: maps[i]['timezone'],
    currency:  maps[i]['currency'],
    matchScore:  maps[i]['matchScore'],
      );
    });
  }

  Future<void> deleteStock(int id) async {
    await _database!.delete('stocks', where: 'id = ?', whereArgs: [id]);
  }
}
