import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:storedgev2/models/item/item.dart';

class ItemRepository {
  ItemRepository(this._itemRef, this._storageRef);

  final CollectionReference<Item> _itemRef;
  final Reference _storageRef;

  Future<void> addItem({
    required Item item,
    required List<TempImage> files,
  }) async {
    try {
      final document = _itemRef.doc();
      final allImages = await _uploadFiles(files, document.id);
      await document.set(item.copyWith(image: allImages));
      log('Item added successfully!');
    } catch (e, stackTrace) {
      _logError('add item', e, stackTrace);
      rethrow;
    }
  }

  Future<void> updateItem({
    required Item item,
    required List<TempImage> files,
  }) async {
    try {
      final document = _itemRef.doc(item.id);
      final existingUrls = files.where((file) => !file.isFile).map((file) => file.imageUrl!).toSet();

      await _deleteUnusedImages(item.image, existingUrls);
      final allImages = await _uploadFiles(files, document.id, existingUrls);
      await document.set(item.copyWith(image: allImages));
      log('Item updated successfully!');
    } catch (e, stackTrace) {
      _logError('update item', e, stackTrace);
      rethrow;
    }
  }

  Future<void> deleteItem({
    required String id,
  }) async {
    try {
      await _deleteAllFiles(id);
      await _itemRef.doc(id).delete();
      log('Item successfully deleted!');
    } catch (e, stackTrace) {
      _logError('delete item', e, stackTrace);
      rethrow;
    }
  }

  Future<List<String>> _uploadFiles(List<TempImage> files, String documentId, [Set<String>? existingUrls]) async {
    return await Future.wait(files.map((file) async {
      if (!file.isFile) return file.imageUrl!;
      final index = files.indexOf(file);
      return await _uploadFile(file.exportData!.croppedFile!, documentId, index);
    }));
  }

  Future<void> _deleteUnusedImages(List<String> oldImages, Set<String> newUrls) async {
    for (final img in oldImages.where((img) => !newUrls.contains(img))) {
      try {
        await _storageRef.storage.refFromURL(img).delete();
        log('Deleted: $img');
      } catch (e) {
        log('Failed to delete: $img, error: $e');
      }
    }
  }

  Future<void> _deleteAllFiles(String documentId) async {
    try {
      final storageFolder = await _storageRef.child(documentId).listAll();
      for (final fileRef in storageFolder.items) {
        await fileRef.delete();
        log('Deleted file: ${fileRef.fullPath}');
      }
    } catch (e) {
      log('Failed to delete files in folder: $documentId, error: $e');
    }
  }

  Future<String> _uploadFile(File file, String documentId, int index) async {
    final snapshot = await _storageRef.child(documentId).child('$index').putFile(file);
    return await snapshot.ref.getDownloadURL();
  }

  void _logError(String action, Object e, StackTrace stackTrace) {
    log('Failed to $action: $e');
    log('Stack trace: $stackTrace');
  }
}

