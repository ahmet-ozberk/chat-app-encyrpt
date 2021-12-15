import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  AuthForm(this.submitFn,this.isLoading);
  final bool isLoading;
  final void Function(
    String email,
    String password,
    String userName,
    bool isLogin,
  ) submitFn;
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLogin = true;
  String _email = '';
  String _password = '';
  String _username = '';
  void _trySubmit() {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState!.save();
      widget.submitFn(
        _email.trim(),
        _password.trim(),
        _username.trim(),
        _isLogin,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    key: ValueKey('email'),
                    validator: (value) {
                      if (value!.isEmpty ||
                          value == null ||
                          !value.contains('@')) {
                        return 'Lütfen mail adresinizi giriniz';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                    ),
                    onSaved: (value) {
                      setState(() {
                        _email = value!;
                      });
                    },
                  ),
                  if (!_isLogin)
                    TextFormField(
                      key: ValueKey('username'),
                      validator: (value) {
                        if (value!.isEmpty || value == null) {
                          return 'Lütfen kullanıcı adınızı giriniz';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Kullanıcı Adı',
                      ),
                      onSaved: (value) {
                        setState(() {
                          _username = value!;
                        });
                      },
                    ),
                  TextFormField(
                    key: ValueKey('password'),
                    validator: (value) {
                      if (value!.isEmpty || value == null || value.length < 6) {
                        return 'Lütfen şifrenizi en az 6 karakter olarak giriniz';
                      }
                      return null;
                    },
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Parola',
                    ),
                    onSaved: (value) {
                      setState(() {
                        _password = value!;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  if(widget.isLoading)
                    CircularProgressIndicator(),
                  if(!widget.isLoading)
                    ElevatedButton(
                      child: Text(_isLogin ? 'Giriş Yap' : 'Kayıt Ol'),
                      onPressed: _trySubmit,
                    ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextButton(
                    child: Text(_isLogin ? 'Kayıt Ol' : 'Giriş Yap'),
                    onPressed: () {
                      setState(() {
                        _isLogin = !_isLogin;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
