import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:search_engine_platform/utils/platforms_list.dart';

class search_angine_page extends StatefulWidget {
  const search_angine_page({super.key});

  @override
  State<search_angine_page> createState() => _search_angine_pageState();
}

class _search_angine_pageState extends State<search_angine_page> {
  InAppWebViewController? inAppWebViewController;
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> angine =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return Scaffold(
      appBar: AppBar(
        title: Text(angine['name']),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
        ],
      ),
      body: InAppWebView(
        initialUrlRequest: URLRequest(url: Uri.parse(angine['url'])),
        onLoadStart: (controller, uri) {
          inAppWebViewController = controller;
        },
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            width: 10,
          ),
          FloatingActionButton(
            onPressed: () async {
              await inAppWebViewController?.loadUrl(
                urlRequest: URLRequest(
                  url: Uri.parse(angine['url']),
                ),
              );
            },
            heroTag: "home",
            child: Icon(Icons.home),
          ),
          FloatingActionButton(
            onPressed: () async {
              bookmark.add(await inAppWebViewController?.getUrl());
              print(bookmark);
            },
            heroTag: "bookmark",
            child: Icon(Icons.bookmark_add),
          ),
          FloatingActionButton(
            onPressed: () async {
              if (await inAppWebViewController!.canGoBack()) {
                inAppWebViewController?.goBack();
              }
            },
            heroTag: "back",
            child: Icon(Icons.arrow_back_ios_new_outlined),
          ),
          FloatingActionButton(
            onPressed: () async {
              await inAppWebViewController?.reload();
            },
            heroTag: "refresh",
            child: Icon(Icons.refresh),
          ),
          FloatingActionButton(
            onPressed: () async {
              if (await inAppWebViewController!.canGoForward()) {
                inAppWebViewController?.goForward();
              }
            },
            heroTag: "forward",
            child: Icon(Icons.arrow_forward_ios_outlined),
          ),
        ],
      ),
    );
  }
}
