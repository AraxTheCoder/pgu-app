class Info{
  String? date;
  String? content;

  Info(this.date, this.content);

  Info.fromJson(Map<String, dynamic> json){
    date = json["date"];
    content = json["content"];
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'content': content,
    };
  }
}