class Places {
  List image;
  String name;
  List type;
  // String photo;
  Places({this.image, this.name, this.type});

  factory Places.fromJson(Map<String, dynamic> json) {
    return Places(
      image: json["photos"],
      name: json["name"],
      type: json["types"],
    );
  }
}
