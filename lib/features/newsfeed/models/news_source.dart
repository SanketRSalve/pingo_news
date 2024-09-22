// ignore_for_file: public_member_api_docs, sort_constructors_first
class Source {
  String id;
  String name;
  Source({
    required this.id,
    required this.name,
  });

  factory Source.fromJson(Map<String, dynamic> json) {
    return Source(id: json['id'] ?? '', name: json["name"]);
  }
}
