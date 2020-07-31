import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:motiv8/constants/colors.dart';
import 'package:motiv8/database_helper.dart';
import 'package:motiv8/models/qodModel.dart';
import 'package:share/share.dart';

class FavouriteQuotes extends StatefulWidget {
  @override
  _FavouriteQuotesState createState() => _FavouriteQuotesState();
}

class _FavouriteQuotesState extends State<FavouriteQuotes> {
  Future<List<QuoteOfTheDay>> favQuotes;
  var dbHelper;

  @override
  void initState() {
    dbHelper = DbHelper();
    fetchFavQuote();
    super.initState();
  }

  fetchFavQuote() {
    setState(() {
      favQuotes = dbHelper.fetchSavedQuote;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Coloors.kPrimaryColors,
        appBar: appBarProp(),
        body: FutureBuilder(
            future: fetchFavQuote(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.lenght > 0) {
                  return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 10),
                          child: Card(
                            color: Coloors.kPrimaryColors,
                            elevation: 5,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              snapshot.data[index].text,
                                              softWrap: true,
                                              textWidthBasis:
                                                  TextWidthBasis.longestLine,
                                              style: TextStyle(
                                                  color: Coloors.kWhite,
                                                  fontSize: 20),
                                            ),
                                            SizedBox(
                                              height: 8,
                                            ),
                                            Text(
                                              snapshot.data[index].author,
                                              style: TextStyle(
                                                  color: Coloors.kBtnColor,
                                                  fontSize: 14),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    IconButton(
                                        icon: Icon(
                                          Icons.share,
                                          color: Coloors.kBtnColor,
                                        ),
                                        onPressed: () {
                                          Share.share(
                                            '',
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
                      });
                }
              } else {
                Text('No Favourites');
              }
              return CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Coloors.kBtnColor),
              );
            }));
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
