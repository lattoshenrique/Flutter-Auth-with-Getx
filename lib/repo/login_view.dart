import 'package:flutter_auth_getx/repo/login_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final GlobalKey<FormState> formKey = GlobalKey();
  LoginViewModel _viewModel = Get.put(LoginViewModel());

  TextEditingController userCtr = TextEditingController();
  TextEditingController passwordCtr = TextEditingController();

  @override
  void initState() {
    super.initState();
    userCtr.text = "candidato-seventh";
    passwordCtr.text = "8n5zSrYq";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Entrar'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: loginForm(),
      ),
    );
  }

  Form loginForm() {
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      key: formKey,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        TextFormField(
          controller: userCtr,
          validator: (value) {
            return (value == null || value.isEmpty)
                ? 'Insira um nome de usuário'
                : null;
          },
          decoration: inputDecoration('Usuário', Icons.person),
        ),
        SizedBox(
          height: 8,
        ),
        TextFormField(
          obscureText: true,
          enableSuggestions: false,
          autocorrect: false,
          validator: (value) {
            return (value == null || value.isEmpty) ? 'Insira uma senha' : null;
          },
          controller: passwordCtr,
          decoration: inputDecoration('Senha', Icons.lock),
        ),
        ElevatedButton(
          onPressed: () async {
            if (formKey.currentState?.validate() ?? false) {
              await _viewModel.loginUser(userCtr.text, passwordCtr.text);
            }
          },
          child: Text('Entrar'),
        ),
      ]),
    );
  }

  InputDecoration inputDecoration(String labelText, IconData iconData,
      {String? prefix, String? helperText}) {
    return InputDecoration(
      contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      helperText: helperText,
      labelText: labelText,
      labelStyle: TextStyle(color: Colors.grey),
      fillColor: Colors.grey.shade200,
      filled: true,
      prefixText: prefix,
      prefixIcon: Icon(
        iconData,
        size: 20,
      ),
      prefixIconConstraints: BoxConstraints(minWidth: 60),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Colors.black)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Colors.black)),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Colors.black)),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Colors.black)),
    );
  }
}
