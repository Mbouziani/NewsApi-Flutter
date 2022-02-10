import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class mysiteview extends StatefulWidget {
  const mysiteview({Key? key}) : super(key: key);

  @override
  _mysiteviewState createState() => _mysiteviewState();
}

class _mysiteviewState extends State<mysiteview> {
  late String url;
  late String Title;
  bool isvisible = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }

  getdata() {
    var data = Get.arguments;
    url = data[0];
    Title = data[1];
    print(url);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            Title,
          ),
        ),
        body: Column(
          children: [
            Visibility(
              visible: isvisible,
              child: Container(
                width: double.infinity,
                child: LinearProgressIndicator(
                  minHeight: 3,
                  backgroundColor: Colors.white,
                ),
              ),
            ),
            Expanded(
              child: WebView(
                initialUrl: url,
                javascriptMode: JavascriptMode.unrestricted,
                onPageFinished: (finish) {
                  setState(() {
                    isvisible = false;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
