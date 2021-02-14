import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WorkWebView extends StatefulWidget {
  String _url;
    String text;

  WorkWebView(this._url,this.text);
  @override
  _WorkWebViewState createState() => _WorkWebViewState();
}

class _WorkWebViewState extends State<WorkWebView> {
 final Completer<WebViewController> _controller =
      Completer<WebViewController>();  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(widget.text),
        
       
      ),
      body: WebView(
        initialUrl: widget._url,
        onWebViewCreated: (WebViewController webViewController) {
          _controller.complete(webViewController);
        },
      ),
      
    );
  }

  
}