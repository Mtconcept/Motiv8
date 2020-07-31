class QuoteOfTheDay {
  QuoteOfTheDay({this.text, this.author, this.id});

  String text;
  String author;
  int id;

  factory QuoteOfTheDay.fromJson(Map<String, dynamic> json) =>
      QuoteOfTheDay(text: json["body"], author: json["author"], id: json["id"]);

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      'author': author,
      'text': text,
    };
  }
}
 