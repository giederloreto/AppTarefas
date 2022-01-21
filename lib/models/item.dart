class Item {
  late String title;
  bool? done;

  Item({required this.title, this.done});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['title'] = title;
    data['done'] = done;
    return data;
  }

  Item.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    done = json['done'];
  }
}
