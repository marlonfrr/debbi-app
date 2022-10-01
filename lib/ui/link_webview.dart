import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LinkWebView extends StatefulWidget {
  final String accessToken;
  const LinkWebView(this.accessToken, {Key? key}) : super(key: key);

  @override
  State<LinkWebView> createState() => _LinkWebViewState();
}

class _LinkWebViewState extends State<LinkWebView> {
  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl: 'https://widget.belvo.io/?access_token=${widget.accessToken}',
      javascriptMode: JavascriptMode.unrestricted,
      navigationDelegate: (NavigationRequest request) {
        print(request.url);
        if (request.url.startsWith('belvowidget://success')) {
          // TODO handle link succeded
        }
        return NavigationDecision.navigate;
      },
    );
  }
}
