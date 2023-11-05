import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testemundowap/domain/entity/user.entity.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer(
      {super.key,
      this.user,
      this.isDarkMode = false,
      this.enabledBackgroundLocalization = false,
      this.changeThemeCallback,
      this.onStartService,
      this.onStartForeground,
      this.onStartBackGround,
      required this.isBackgroundLocalization});

  final User? user;

  final bool isDarkMode;
  final bool enabledBackgroundLocalization;
  final bool isBackgroundLocalization;

  final FutureOr<void> Function(bool value)? changeThemeCallback;

  final FutureOr<void> Function(bool value)? onStartService;
  final FutureOr<void> Function()? onStartForeground;
  final FutureOr<void> Function()? onStartBackGround;

  Future changeConfig(String key, bool value) async {
    final sp = await SharedPreferences.getInstance();
    await sp.setBool(key, value);
  }

  static const switchRowPadding =
      EdgeInsets.symmetric(vertical: 8, horizontal: 16);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Spacer(
            flex: 2,
          ),
          Expanded(
            flex: 3,
            child: UserInformation(
              user: user,
            ),
          ),
          const Spacer(),
          Padding(
            padding: switchRowPadding,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Background"),
                Switch(
                    value: isBackgroundLocalization,
                    onChanged: enabledBackgroundLocalization
                        ? (isBackground) {
                            if (isBackgroundLocalization &&
                                enabledBackgroundLocalization) {
                              onStartForeground?.call();
                            } else if (!isBackgroundLocalization &&
                                enabledBackgroundLocalization) {
                              onStartForeground?.call();
                            }
                          }
                        : null),
                const Text("Foreground"),
              ],
            ),
          ),
          Padding(
            padding: switchRowPadding,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Dark Theme"),
                Switch(value: isDarkMode, onChanged: changeThemeCallback)
              ],
            ),
          ),
          Padding(
            padding: switchRowPadding,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Background Localization"),
                Switch(
                    value: enabledBackgroundLocalization,
                    onChanged: onStartService)
              ],
            ),
          ),
          const Spacer()
        ],
      ),
    );
  }
}

class UserInformation extends StatelessWidget {
  const UserInformation({
    super.key,
    this.user,
  });

  final User? user;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircleAvatar(
            maxRadius: 50,
            child: Icon(
              Icons.person,
              size: 50,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [const Text('Usuário:'), Text(user?.name ?? 'NA')],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [const Text('Perfil:'), Text(user?.profile ?? 'NA')],
          ),
        ],
      ),
    );
  }
}
