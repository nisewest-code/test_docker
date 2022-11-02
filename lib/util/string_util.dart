import 'package:test_docker/util/storage.dart';

class StringUtil{
  static Future<String?> getPath(){
    return Storage.getValue("path");
  }

  static Future<void> setPath(String path){
    return Storage.setValue("path", path);
  }
}