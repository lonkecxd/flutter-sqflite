import 'dart:async';

class NetworkUtil {
  //Dart单例模式
  static NetworkUtil _instance = new NetworkUtil.internal();
  NetworkUtil.internal();
  factory NetworkUtil() => _instance;

  Future<dynamic> get(){
    return null;
  }
}