import 'package:flutter/material.dart';
import 'package:sqflite_demo/data/data_helper.dart';
import 'package:sqflite_demo/models/user.dart';
import 'package:sqflite_demo/pages/login/display_presenter.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> implements LoginPageContract {
  BuildContext _ctx;
  bool _isLoading;
  final formKey = new GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();

  String _username, _password;

  LoginPagePresenter _presenter;

  _LoginPageState() {
    _presenter = new LoginPagePresenter(this);
  }

  void _submit() {
    final form = formKey.currentState;
    if (form.validate()) {
      setState(() {
        _isLoading = true;
        form.save();
        _presenter.doLogin(_username, _password);
      });
    }
  }

  void _showSnackBar(String text) {
    scaffoldKey.currentState.showSnackBar(
      new SnackBar(
        content: Text(text),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _ctx = context;
    var loginBtn = new RaisedButton(
      onPressed: _submit,
      child: Text('Login'),
      color: Colors.blue,
    );

    var loginForm = new Column(
      children: <Widget>[
        Text(
          'Sqflite App Login',
          textScaleFactor: 2.0,
        ),
        Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(10.0),
                child: TextFormField(
                  onSaved: (val) => _username = val,
                  decoration: InputDecoration(
                    labelText: "Username",
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: TextFormField(
                  onSaved: (val) => _password = val,
                  decoration: InputDecoration(
                    labelText: "Password",
                  ),
                ),
              ),
            ],
          ),
        ),
        loginBtn
      ],
    );

    return new Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      key: scaffoldKey,
      body: Container(
        child: Center(
          child: loginForm,
        ),
      ),
    );
  }

  @override
  void onLoginError(String error) {
    // TODO: implement onLoginError
    _showSnackBar(error);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void onLoginSuccess(User user) async {
    // TODO: implement onLoginSuccess
    _showSnackBar(user.toString());
    setState((){
      _isLoading = false;
    });
    var db = new DatabaseHelper();
    await db.saveUser(user);
    Navigator.of(context).pushNamed('/home');
  }
}
