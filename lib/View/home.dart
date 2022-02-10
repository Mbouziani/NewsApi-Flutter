// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:news/Controllers/C_news.dart';
import 'package:news/Models/M_news.dart';
import 'package:news/View/webview.dart';

class homePage extends GetWidget {
  @override
  NewsController controller = Get.put(NewsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text(
          "News App",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: FutureBuilder(
        future: controller.getData(),
        builder: (context, AsyncSnapshot snaphshot) {
          ArictlesNews? data = snaphshot.data;

          return snaphshot.hasData
              ? ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: data!.articles?.length,
                  itemBuilder: (context, int index) {
                    try {
                      return GestureDetector(
                        onTap: () {
                          String urlnews = data.articles![index].url.toString();
                          String titles =
                              data.articles![index].title.toString();

                          Get.to(mysiteview(), arguments: [
                            urlnews,
                            titles,
                          ]);
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 2.0),
                          color: Colors.white,
                          child: Column(
                            children: [
                              SizedBox(
                                width: double.infinity,
                                height: 200,
                                child: FadeInImage.assetNetwork(
                                  placeholder:
                                      'assets/images/waiting.gif', //'https://ichef.bbci.co.uk/onesport/cps/800/cpsprodpb/EC80/production/_123144506_snowboard.jpg',
                                  image: data.articles![index].urlToImage
                                      .toString(),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      data.articles![index].title.toString(),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16),
                                    ),
                                    Text(
                                      splitdata(data
                                          .articles![index].publishedAt
                                          .toString()),
                                      style: const TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14),
                                    ),
                                    Text(data.articles![index].description
                                        .toString())
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    } catch (e) {
                      return Container();
                    }
                  })
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  String splitdata(String data) {
    //for date
    var str1 = data; //"date: '2019:04:01'";
    var spliter1 = str1.split('T'); //str.split(':');
    var Date = spliter1[0].trim();
    //print(Date);
    //print(spliter1[1].trim());
    // prefix: "date"

    //for time
    var str2 = spliter1[1].trim(); //"date: '2019:04:01'";
    var spliter2 = str2.split(':'); //str.split(':');
    var Time = spliter2[0].trim() + ':' + spliter2[1].trim(); // prefix: "date"
    //print(Time);
    //String datetime = Date + ' at ' + Time;

    return Time;
  }
}
