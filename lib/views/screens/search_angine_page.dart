import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:search_engine_platform/provider/bookmark_list_provider.dart';
import 'package:search_engine_platform/utils/platforms_list.dart';
import 'package:provider/provider.dart';

class search_angine_page extends StatefulWidget {
  const search_angine_page({super.key});

  @override
  State<search_angine_page> createState() => _search_angine_pageState();
}

class _search_angine_pageState extends State<search_angine_page> {
  InAppWebViewController? inAppWebViewController;
  late PullToRefreshController pullToRefreshController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pullToRefreshController = PullToRefreshController(
      onRefresh: () async {
        await inAppWebViewController?.reload();
      },
      options: PullToRefreshOptions(
        color: Colors.black,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> angine =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return Scaffold(
      appBar: AppBar(
        title: Text(angine['name']),
        centerTitle: true,
        actions: [
          PopupMenuButton(
            icon: Icon(Icons.menu),
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  value: 0,
                  child: Text("switch angine"),
                ),
                PopupMenuItem(
                  value: 1,
                  child: Text("bookmarks"),
                ),
              ];
            },
            onSelected: (val) {
              if (val == 0) {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) => ListView.builder(
                    itemCount: platforms.length,
                    itemBuilder: (context, index) => RadioListTile(
                      value: index,
                      groupValue: Provider.of<list_pro>(context, listen: false)
                          .Group_val,
                      onChanged: (val) async {
                        await inAppWebViewController?.loadUrl(
                          urlRequest: URLRequest(
                            url: Uri.parse(platforms[index]['url']),
                          ),
                        );
                      },
                      title: Text("${platforms[index]['name']}"),
                    ),
                  ),
                );
              } else if (val == 1) {
                showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) => ListView.builder(
                          itemCount:
                              Provider.of<list_pro>(context, listen: true)
                                  .bookmark
                                  .length,
                          itemBuilder: (context, int index) {
                            return ListTile(
                              onTap: () async {
                                await inAppWebViewController?.loadUrl(
                                    urlRequest: URLRequest(
                                        url: Provider.of<list_pro>(context,
                                                listen: false)
                                            .bookmark[index]));
                              },
                              subtitle: Text(
                                "${Provider.of<list_pro>(context, listen: false).bookmark[index]}",
                                overflow: TextOverflow.ellipsis,
                              ),
                              trailing: IconButton(
                                icon: Icon(Icons.close),
                                onPressed: () {
                                  Provider.of<list_pro>(context, listen: false)
                                      .remove_bookmark(Provider.of<list_pro>(
                                              context,
                                              listen: false)
                                          .bookmark[index]);
                                },
                              ),
                            );
                          },
                        ));
              }
            },
          ),
        ],
      ),
      body: InAppWebView(
        pullToRefreshController: pullToRefreshController,
        initialUrlRequest: URLRequest(url: Uri.parse(angine['url'])),
        onLoadStart: (controller, uri) {
          inAppWebViewController = controller;
        },
        onLoadStop: (controller, uri) async {
          await pullToRefreshController.endRefreshing();
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
              Provider.of<list_pro>(context, listen: false)
                  .add_bookmark(await inAppWebViewController?.getUrl());
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
