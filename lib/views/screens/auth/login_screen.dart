import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:tada_video/constants/color_constants.dart';
import 'package:tada_video/controller/auth_controller.dart';
import 'package:tada_video/generated/l10n.dart';
import '../../../constants/route_constants.dart';
import './privacy_view.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: SvgPicture.asset(
              'assets/page_close.svg',
              width: 26,
            ),
            onPressed: () {
              Get.toNamed(Routes.home);
            },
          ),
          title: Container(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  Get.toNamed(Routes.home);
                },
                child: Text(
                  S.of(context).login_skip,
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w300),
                ),
              )),
        ),
        body: Stack(
          children: [
            LoginForm(
              authController: authController,
            ),
            const Positioned(
                left: 0, right: 0, bottom: 48, child: PrivacyView()),
          ],
        ));
  }
}

class LoginForm extends StatelessWidget {
  final AuthController authController;

  const LoginForm({
    Key? key,
    required this.authController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final commonStyle = ElevatedButton.styleFrom(
      backgroundColor: AppColor.bgGray,
      foregroundColor: Colors.black,
      minimumSize: const Size(double.infinity, 50),
    );

    final List<Map<String, dynamic>> buttons = [
      {
        'icon': const FaIcon(
          FontAwesomeIcons.facebook,
          color: Colors.blue,
        ),
        'label': const Text(
          'Continue with Facebook',
          style: TextStyle(color: Colors.white),
        ),
        'onPressed': () => {},
      },
      {
        'icon': const FaIcon(
          FontAwesomeIcons.google,
          color: Colors.red,
        ),
        'label': const Text(
          'Continue with Google',
          style: TextStyle(color: Colors.white),
        ),
        'onPressed': () async {
          try {
            await authController.googleSignIn();
            if (authController.isSuccess.value) {
              Get.snackbar('Success', 'Login Success');
              Get.toNamed(Routes.home);
            }
          } catch (e) {
            Get.snackbar('Error', e.toString());
          }
        }
      },
      {
        'icon': const FaIcon(
          FontAwesomeIcons.apple,
          color: Colors.white,
        ),
        'label': const Text(
          'Continue with Apple',
          style: TextStyle(color: Colors.white),
        ),
        'onPressed': () => {},
      },
      {
        'icon': const FaIcon(
          FontAwesomeIcons.weixin,
          color: Colors.green,
        ),
        'label': const Text(
          'continue with WeChat',
          style: TextStyle(color: Colors.white),
        ),
        'onPressed': () => {},
      },
    ];
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Logo
          Center(child: Image.asset('assets/login_icon.png')),
          const SizedBox(height: 20),
          // Login
          const Text('Let\'s you in',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              )),
          const SizedBox(height: 30),
          // OAuth
          for (final button in buttons) ...[
            ElevatedButton.icon(
              style: commonStyle,
              icon: button['icon']!,
              label: button['label']!,
              onPressed: button['onPressed']!,
            ),
            const SizedBox(height: 15),
          ],
        ],
      ),
    );
  }
}
