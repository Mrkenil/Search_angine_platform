import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:search_engine_platform/utils/platforms_list.dart';

class select_search_angine_page extends StatefulWidget {
  const select_search_angine_page({super.key});

  @override
  State<select_search_angine_page> createState() =>
      _select_search_angine_pageState();
}

class _select_search_angine_pageState extends State<select_search_angine_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search Angine"),
      ),
      body: StreamBuilder(
        stream: Connectivity().onConnectivityChanged,
        builder: (context, AsyncSnapshot<ConnectivityResult> snapshot) =>
            (snapshot.data == ConnectivityResult.wifi)
                ? Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          margin: EdgeInsets.all(10),
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Select a Platform :",
                            style: TextStyle(
                              fontSize: 26,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 9,
                        child: Container(
                          child: ListView.builder(
                            itemCount: platforms.length,
                            itemBuilder: (context, index) => GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushNamed('search_page',
                                    arguments: platforms[index]);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                margin: EdgeInsets.all(10),
                                height: 100,
                                width: 100,
                                child: Image.network(
                                  platforms[index]['gif'],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : Center(
                    child: Container(
                      child: CircularProgressIndicator(),
                    ),
                  ),
      ),
    );
  }
}
