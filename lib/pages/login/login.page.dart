import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testemundowap/core/widgets/input/flat.animated.loading.button.input.dart';
import 'package:testemundowap/core/widgets/input/form.input.dart';
import 'package:testemundowap/pages/login/login.controller.dart';

class LoginPage extends GetView<LoginController> {
  LoginPage({super.key});

  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(
              flex: 3,
            ),
            Hero(
                tag: "title",
                child: Text(
                  "Teste Mundo WAP",
                  style: Theme.of(context).textTheme.titleLarge,
                )),
            const Spacer(
              flex: 1,
            ),
            FormImput(
              inputName: 'e-mail',
              controller: emailController,
              validator: (value) {
                if (value != null) {
                  if (value.isEmpty) return "Campo obrigatório";

                  return null;
                } else {
                  return "campo obrigatório";
                }
              },
            ),
            FormImput(
              inputName: 'senha',
              controller: passwordController,
              obscuredText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Campo obrigatório";
                }
                return null;
              },
            ),
            FlatAnimatedLoadingButton(
              onPressed: () async {
                if (_formKey.currentState?.validate() == true) {
                  FocusScope.of(context).unfocus();
                  await controller.login(
                      email: emailController.text,
                      password: passwordController.text);
                }
              },
              label: 'entrar',
            ),
            const Spacer(
              flex: 3,
            )
          ],
        ),
      ),
    );
  }
}
