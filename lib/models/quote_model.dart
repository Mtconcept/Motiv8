// class QuoteList {
//   final List<QuoteCategory> quoteList;

//   QuoteList({this.quoteList});

//   factory QuoteList.fromJson(List<dynamic> json) {
//     List<QuoteCategory> quoteList = List<QuoteCategory>();

//     quoteList = json.map((e) => QuoteCategory.fromJson(e)).toList();
//     return QuoteList(quoteList: quoteList);
//   }
// }


// class QuoteCategory {
//   final String text;
//   final String author;

//   QuoteCategory({
//     this.text,
//     this.author,
//   });

//   factory QuoteCategory.fromJson(Map<String, dynamic> json) => QuoteCategory(
//         text: json["text"],
//         author: json["author"] == null ? null : json["author"],
//       );
// }

