import 'package:sqflite_demo/data/rest_data.dart';
import 'package:sqflite_demo/models/user.dart';


abstract class LoginPageContract{
  void onLoginSuccess(User user);
  void onLoginError(String error);
}

class LoginPagePresenter{
  
  LoginPageContract _view;
  RestData api = new RestData();
  
  LoginPagePresenter(this._view);
  
  doLogin(String username,String password){
    api.login(username, password)
        .then((User user)=>_view.onLoginSuccess(user))
        .catchError((error)=>_view.onLoginError(error));
  }
}