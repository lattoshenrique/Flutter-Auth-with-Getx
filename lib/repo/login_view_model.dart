import 'package:flutter_auth_getx/core/authentication_manager.dart';
import 'package:flutter_auth_getx/repo/model/login_request_model.dart';
import 'package:flutter_auth_getx/repo/service/login_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginViewModel extends GetxController {
  late final LoginService _loginService;
  late final AuthenticationManager _authManager;

  @override
  void onInit() {
    super.onInit();
    _loginService = Get.put(LoginService());
    _authManager = Get.find();
  }

  Future<void> loginUser(String username, String password) async {
    final response = await _loginService
        .fetchLogin(LoginRequestModel(username: username, password: password));

    if (response != null) {
      _authManager.login(response.token);
    } else {
      Get.defaultDialog(
          title: 'Opa...',
          middleText: 'Usuário e/ou Senha inválidos!',
          textConfirm: 'Tentar novamente',
          confirmTextColor: Colors.white,
          onConfirm: () {
            Get.back();
          });
    }
  }
}
