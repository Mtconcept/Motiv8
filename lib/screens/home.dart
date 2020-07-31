import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:motiv8/constants/colors.dart';
import 'package:motiv8/database_helper.dart';
import 'package:motiv8/models/qodModel.dart';
import 'package:motiv8/screens/allQuote.dart';
import 'package:share/share.dart';

import 'favQuotes.dart';

class QuoteHome extends StatefulWidget {
  @override
  _QuoteHomeState createState() => _QuoteHomeState();
}

class _QuoteHomeState extends State<QuoteHome> {
  bool isChanged = false;
  bool addedFav = false;
  var dbHelper;

  Future<QuoteOfTheDay> getQuote() async {
    final response = await http.get('https://favqs.com/api/qotd');
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      return QuoteOfTheDay.fromJson(data['quote']);
    } else {
      throw Exception(response.statusCode);
    }
  }

  Future<QuoteOfTheDay> quotes;

  @override
  void initState() {
    super.initState();
    quotes = getQuote();
    dbHelper = DbHelper();
    print(quotes);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Coloors.kPrimaryColors,
      drawer: drawerProp(),
      appBar: appBarProp(),
      body: FutureBuilder<QuoteOfTheDay>(
          future: getQuote(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              print(snapshot.data.author);
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 36.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(" Today's Motivation",
                        style: GoogleFonts.lato(
                          fontSize: 16,
                          color: Coloors.kWhite,
                          fontWeight: FontWeight.normal,
                        )),
                    SizedBox(
                      height: 36,
                    ),
                    Text('"',
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 64,
                          color: Coloors.kWhite,
                          fontWeight: FontWeight.bold,
                        )),
                    Text(snapshot.data.text,
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 20,
                          wordSpacing: 1,
                          letterSpacing: 1.5,
                          color: Coloors.kWhite,
                        )),
                    SizedBox(height: 20),
                    Text('Author: ' + snapshot.data.author,
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 16,
                          color: Coloors.kBtnColor,
                          fontWeight: FontWeight.normal,
                        )),
                    SizedBox(height: 100),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                border: Border.all(
                                  color: Coloors.kWhite,
                                ),
                                shape: BoxShape.circle),
                            child: Center(
                              child: IconButton(
                                  icon: Icon(
                                    Icons.share,
                                    color: Coloors.kBtnColor,
                                  ),
                                  onPressed: () {
                                    Share.share(
                                      '${snapshot.data.text}--${snapshot.data.author}',
                                      subject: 'Read A quote Today',
                                    );
                                  }),
                            )),
                        SizedBox(
                          width: 24,
                        ),
                        Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                                color: addedFav
                                    ? Colors.white
                                    : Colors.transparent,
                                border: Border.all(
                                  color: Coloors.kWhite,
                                ),
                                shape: BoxShape.circle),
                            child: Center(
                              child: IconButton(
                                  icon: Icon(
                                    addedFav
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: Coloors.kBtnColor,
                                  ),
                                  onPressed: () {
                                    QuoteOfTheDay qd = QuoteOfTheDay(
                                      id: null,
                                      author: snapshot.data.author,
                                      text: snapshot.data.text,
                                    );
                                    dbHelper.saveQuote(qd);
                                    setState(() {
                                      addedFav = !addedFav;
                                    });
                                    final addedtofav = SnackBar(
                                        backgroundColor: Colors.black,
                                        content: Text(
                                            addedFav
                                                ? 'Successfully Added to Favourite'
                                                : 'Removed from Favourite',
                                            style: GoogleFonts.lato(
                                              fontSize: 18,
                                              color: Coloors.kWhite,
                                            )));
                                    Scaffold.of(context)
                                        .showSnackBar(addedtofav);
                                  }),
                            )),
                      ],
                    )
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              throw 'No Data';
            }
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Coloors.kBtnColor),
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
      actions: [
        IconButton(
            icon: isChanged ? Icon(FeatherIcons.moon) : Icon(FeatherIcons.sun),
            onPressed: () {
              setState(() {
                isChanged = !isChanged;
              });
            })
      ],
    );
  }

  Widget drawerProp() {

    return Drawer(
      elevation: 0,
      child: Column(
        children: [
          Column(
            children: [
              Container(
                height: 200,
                width: double.infinity,
                color: Coloors.kBtnColor,
              ),
              SizedBox(
                height: 36,
              ),
              FlatButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => AllQuotes()));
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.lightbulb_outline,
                      size: 24,
                      color: Coloors.kPrimaryColors.withOpacity(0.5),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Text(
                      'All Motivations',
                      style: TextStyle(
                          fontSize: 16, color: Coloors.kPrimaryColors),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 24,
              ),
              FlatButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => FavouriteQuotes()));
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.favorite_border,
                      size: 24,
                      color: Coloors.kPrimaryColors.withOpacity(0.5),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Text(
                      'Favouite Motivations',
                      style: TextStyle(
                          fontSize: 16, color: Coloors.kPrimaryColors),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 24,
              ),
              FlatButton(
                onPressed: () {},
                child: Row(
                  children: [
                    Icon(
                      Icons.language,
                      size: 24,
                      color: Coloors.kPrimaryColors.withOpacity(0.5),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Text(
                      'Switch Languages',
                      style: TextStyle(
                          fontSize: 16, color: Coloors.kPrimaryColors),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
