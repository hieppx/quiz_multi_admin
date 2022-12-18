class Course {
  String? id;
  String? title;
  int? active;

  Course({
    this.id,
    this.title,
    this.active
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['ID'],
      title: json['title'],
      active: int.parse(json['active'])
    );
  }
}
