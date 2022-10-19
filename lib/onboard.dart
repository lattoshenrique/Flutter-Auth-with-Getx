import 'package:flutter_auth_getx/core/authentication_manager.dart';
import 'package:flutter_auth_getx/home_view.dart';
import 'package:flutter_auth_getx/repo/login_view.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnBoard extends StatelessWidget {
  const OnBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthenticationManager _authManager = Get.find();

    return Obx(() {
      return _authManager.isLogged.value ? HomeView() : LoginView();
    });
  }
}
