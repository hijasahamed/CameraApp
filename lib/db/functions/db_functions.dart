import 'package:camera_app/db/model/db_model.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

ValueNotifier<List<Imagemodel>> imageNotifier =ValueNotifier([]);

late Database db;

Future<void> initializeDatabase()async{
  db=await openDatabase(
    'photos.db',
    version: 1,
    onCreate: (Database db,int version)async {
      await db.execute('CREATE TABLE photos(id INTEGER PRIMARY KEY,image TEXT)'); 
    },
  );
}

Future<void> addImage(Imagemodel value)async{
  await db.rawInsert('INSERT INTO photos(image)VALUES(?)',[value.image]);
  getImage();
}

Future<void> getImage()async{
  final _values= await db.rawQuery('SELECT * FROM photos');
  imageNotifier.value.clear();
  _values.forEach((map) {
    final images=Imagemodel.fromMap(map);
    imageNotifier.value.add(images);
    } 
  );
  imageNotifier.notifyListeners();
}

Future<void> deletePhoto(int id)async{
  db.delete('photos',where: 'id=?',whereArgs: [id]);
  getImage();
}
