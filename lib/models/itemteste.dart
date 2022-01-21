import 'dart:convert';

class Itemteste {
  String title;
  bool? done;

  Itemteste({
    required this.title,
    this.done,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'done': done,
    };
  }

  factory Itemteste.fromMap(Map<String, dynamic> map) {
    return Itemteste(
      title: map['title'] ?? '',
      done: map['done'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Itemteste.fromJson(String source) =>
      Itemteste.fromMap(json.decode(source));
}
