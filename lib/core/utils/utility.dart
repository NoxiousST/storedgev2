import 'dart:io';

Future<File> changeFileName(File file, String name) {
  var path = file.path;
  var lastSeparator = path.lastIndexOf(Platform.pathSeparator);
  var newPath = path.substring(0, lastSeparator + 1) + name;
  return file.rename(newPath);
}
