import 'dart:async';
import 'package:ganohesap/main.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper{
  Database _db;

  Future<Database> get db async {
    if(_db==null){
      _db=await initializeDb();
    }
    return _db;
  }
  
  Future <Database> initializeDb()  async{
    String dbPath=join(await getDatabasesPath(),"tumDersler.db");
    var derslerDb= await openDatabase(dbPath, version: 1, onCreate: createDb);
    return derslerDb;
  }

 void createDb(Database db, int version) async{
    await db.execute("Create table tumDersler(id integer primary key, ad text, harfDegeri float, kredi int)");
  }

  Future<List<Ders>> getDersler() async{
    Database db= await this.db;
    var result = await db.query("tumDersler");
    return List.generate(result.length, (i){
      return Ders.fromMap(result[i]);
    });
  }

  Future<int> insert(Ders ders) async{
    Database db= await this.db;
    var result= await db.insert("tumDersler", ders.toMap());
    return result;
  }
  Future<int> delete(int id) async{
    Database db= await this.db;
    var result= await db.rawDelete("delete from tumDersler where id=$id");
    return result;
  }
  Future<int> update(Ders ders) async{
    Database db= await this.db;
    var result= await db.update("tumDersler", ders.toMap(), where:"id=?", whereArgs: [ders.id]);
    return result;
  }
}