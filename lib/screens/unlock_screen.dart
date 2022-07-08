import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qs_ds_app/model/serial_port_utils.dart';
import 'package:qs_ds_app/model/settings_repository.dart';

class UnlockScreen extends StatelessWidget {
  const UnlockScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [
                Color(0xFF676767),
                Color(0xFF676767),
                Color(0xFFA05A5A),
                Color(0xFF676767),
                Color(0xFF676767)
              ],
              begin: FractionalOffset(0, 0),
              end: FractionalOffset(1, 1),
              stops: [0, 0.25, 0.5, 0.75, 1],
              tileMode: TileMode.clamp),
        ),
        child: Center(
          child: SizedBox(
            width: 200,
            // height: 100,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    style: TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white12,
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(
                            color: Colors.transparent,
                            width: 2,
                          )),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            color: Colors.red.withOpacity(0.5),
                            width: 2,
                          )),
                      hintText: 'System password',
                    ),
                    onSubmitted: (password) async {
                      SettingsRepository().unlockPassword.value = password;
                      SerialPortUtils().unlockSession();
                      Navigator.pop(context);
                    },
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z]")),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
