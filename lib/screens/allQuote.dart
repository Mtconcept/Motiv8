import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:motiv8/constants/colors.dart';
import 'package:share/share.dart';

class AllQuotes extends StatefulWidget {
  @override
  _AllQuotesState createState() => _AllQuotesState();
}

class _AllQuotesState extends State<AllQuotes> {
  void getQuotes() async {
    final response = await http.get('https://type.fit/api/quotes');
    if (response.statusCode == 200) {
      setState(() {
        String data = response.body;
        quoteList = json.decode(data);
      });
    } else {
      print(response.statusCode);
    }
  }

  bool addedFav = false;
  List quoteList = [];

  @override
  void initState() {
    super.initState();
    getQuotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Coloors.kPrimaryColors,
      appBar: appBarProp(),
      body: ListView.builder(
          itemCount: quoteList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              child: Card(
                color: Coloors.kPrimaryColors,
                elevation: 5,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${quoteList[index]["text"]}',
                                  softWrap: true,
                                  textWidthBasis: TextWidthBasis.longestLine,
                                  style: TextStyle(
                                      color: Coloors.kWhite, fontSize: 20),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  '${quoteList[index]["author"]}',
                                  style: TextStyle(
                                      color: Coloors.kBtnColor, fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                              color: Coloors.kBtnColor,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(90))),
                                  child: Image.asset('name'),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                            icon: Icon(
                              Icons.share,
                              color: Coloors.kBtnColor,
                            ),
                            onPressed: () {
                              Share.share(
                                quoteList[index]["text"],
                                subject: 'Read A quote Today',
                              );
                            }),
                        IconButton(
                            icon: Icon(
                              Icons.favorite_border,
                              color: Coloors.kBtnColor,
                            ),
                            onPressed: () {})
                      ],
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }

  Widget appBarProp() {
    return AppBar(
      elevation: 0,
      centerTitle: true,
      title: RichText(
        text: TextSpan(
          children: [
            TextSpan(
                text: 'Motiv',
                style: GoogleFonts.playfairDisplay(
                    color: Coloors.kWhite,
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
            TextSpan(
                text: '8',
                style: GoogleFonts.playfairDisplay(
                    color: Coloors.kBtnColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold))
          ],
        ),
      ),
      backgroundColor: Coloors.kPrimaryColors,
    );
  }
}
