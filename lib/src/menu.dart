import 'dart:async';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

enum _MenuOptions {
  navigationDelgate,
  userAgent,
}

class Menu extends StatelessWidget {
  const Menu({required this.controller, Key? key}) : super(key: key);

  final Completer<WebViewController> controller;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WebViewController>(
      future: controller.future,
      builder: (context, controller){
        return PopupMenuButton<_MenuOptions>(
            onSelected: (value) async {
              switch(value) {
                case _MenuOptions.navigationDelgate:
                  controller.data!.loadUrl('https://youtube.com');
                  break;

                case _MenuOptions.userAgent:
                  final userAgent = await controller.data!.runJavascriptReturningResult('navigator.userAgent');
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(userAgent),
                  ));
                  break;
              }
            },
          itemBuilder: (context) => [
            const PopupMenuItem<_MenuOptions>(
              value: _MenuOptions.navigationDelgate,
                child: Text('Navigate to Youtube'),
            ),
            const PopupMenuItem<_MenuOptions>(
              value: _MenuOptions.userAgent,
              child: Text('Show user-agent'),
            ),
          ],
        );
      },
    );
  }
}