class ClassCode{
  String? name;
  String? code;

  ClassCode(this.name, this.code);

  ClassCode.fromJson(Map<String, dynamic> json){
    this.name = json["name"];
    this.code = json["code"];
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'code': code,
    };
  }
}