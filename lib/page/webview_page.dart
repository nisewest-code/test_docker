import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../dialog/exit_bottomsheet_dialog.dart';
import '../util/dialog_util.dart';

class WebViewPage extends StatefulWidget {
  const WebViewPage({Key? key, required this.url}) : super(key: key);

  final String url;

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {

  late WebViewController _controller;

  @override
  void initState() {
    super.initState();
    // Enable virtual display.
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () => _willPopCallback(context),
        child: Scaffold(
          appBar: AppBar(
              leading: IconButton(icon:Icon(Icons.arrow_back),
                onPressed:() => _willPopCallback(context),
              )
          ),
          body: WebView(
            initialUrl: widget.url,
            onWebViewCreated: (webViewController){
              _controller = webViewController;
            },
          ),
        ));
  }

  Future<bool> _willPopCallback(BuildContext context) async {
    // WebViewController webViewController = await _controller.;
    bool canNavigate = await _controller.canGoBack();
    if (canNavigate) {
      _controller.goBack();
      return false;
    } else {
      _onWillPop(context);
      return true;
    }
  }

  Future<bool> _onWillPop(BuildContext context) async {
    bool? exitResult = await DialogUtil.showBottomSheet(context, const ExitBottomSheetDialog());
    return exitResult ?? false;
  }
}
