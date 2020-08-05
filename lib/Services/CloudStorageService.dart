import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class CloudStorageService {
  final String famCode;
  final String uid;

  CloudStorageService({this.famCode, this.uid});

  StorageReference imageRef = FirebaseStorage.instance.ref().child("Families");
  StorageReference userRef = FirebaseStorage.instance.ref().child("Users");

  String capitalize(String string) {
    if (string == null) {
      throw ArgumentError("string: $string");
    }

    if (string.isEmpty) {
      return string;
    }

    return string[0].toUpperCase() + string.substring(1).toLowerCase();
  }

  StorageReference Imagesref(String name) {
    return imageRef.child(famCode).child("Images").child(capitalize(name));
  }

  StorageReference Recipesref(String recipeCode, File file) {
    return imageRef
        .child(famCode)
        .child("Recipes")
        .child(capitalize(recipeCode));
  }

  Future deleteImage(String id) async {
    return await imageRef.child(famCode).child("Images").child(id).delete();
  }

  Future deleteProfileImg() async {
    try {
      return await userRef.child(uid).delete();
    } catch (e) {
      print("Unable to delete.\nReason:  " + e.toString());
      return null;
    }
  }

  Future deleteRecipes(String id) async {
    return await imageRef.child(famCode).child("Recipes").child(id).delete();
  }

  Future deleteAllFamilyImages() async {
    if (await imageRef.child(famCode).child("Images").getName() != null) {
      print(await imageRef.child(famCode).child("Images").getPath());
      await imageRef.child(famCode).child("Images").delete();
    }

    if (await imageRef.child(famCode).child("Recipes").getName() != null) {
      print(await imageRef.child(famCode).child("Recipes").getName());
      await imageRef.child(famCode).child("Recipes").delete();
    }
  }

  Future deleteAllFamilyRecipes() async {
    if (await imageRef.child(famCode).child("Recipes").getName() != null) {
      print(await imageRef.child(famCode).child("Recipes").getPath());
      await imageRef.child(famCode).child("Recipes").delete();
    }

    if (await imageRef.child(famCode).child("Recipes").getName() != null) {
      print(await imageRef.child(famCode).child("Recipes").getName());
      await imageRef.child(famCode).child("Recipes").delete();
    }
  }

  StorageReference uploadProfileImgRef() {
    return userRef.child(uid);
  }
}
