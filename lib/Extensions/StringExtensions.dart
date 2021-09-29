extension StringExtensions on String{
  bool startsNumeric(){
    if(this.isEmpty)
      return false;

    return double.tryParse(this.substring(0, 1)) != null;
  }

  bool endsNumeric(){
    if(this.isEmpty)
      return false;

    return double.tryParse(this.substring(this.length - 1)) != null;
  }

  String shortVersion(){
    switch(this){
      case "eigenverantwortliches":
        return "Eva";
    }

    return this;
  }

  String withoutNumbers(){
    String withoutNumbers = "";

    this.runes.forEach((int rune) {
      String character = new String.fromCharCode(rune);

      if(!character.startsNumeric())
        withoutNumbers += character;
    });

    return withoutNumbers;
  }
}