// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CodeModel {
  String uid;
  String title;
  String? coverImg;
  String description;
  String code;
  String author;
  String autherUid;
  String authorImg;
  DateTime createdAt;
  int claps;
  int views;
  CodeModel({
    required this.uid,
    required this.title,
    this.coverImg,
    required this.description,
    required this.code,
    required this.author,
    required this.autherUid,
    required this.authorImg,
    required this.createdAt,
    required this.claps,
    required this.views,
  });

  CodeModel copyWith({
    String? uid,
    String? title,
    String? coverImg,
    String? description,
    String? code,
    String? author,
    String? autherUid,
    String? authorImg,
    DateTime? createdAt,
    int? claps,
    int? views,
  }) {
    return CodeModel(
      uid: uid ?? this.uid,
      title: title ?? this.title,
      coverImg: coverImg ?? this.coverImg,
      description: description ?? this.description,
      code: code ?? this.code,
      author: author ?? this.author,
      autherUid: autherUid ?? this.autherUid,
      authorImg: authorImg ?? this.authorImg,
      createdAt: createdAt ?? this.createdAt,
      claps: claps ?? this.claps,
      views: views ?? this.views,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'title': title,
      'coverImg': coverImg,
      'description': description,
      'code': code,
      'author': author,
      'autherUid': autherUid,
      'authorImg': authorImg,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'claps': claps,
      'views': views,
    };
  }

  factory CodeModel.fromMap(Map<String, dynamic> map) {
    return CodeModel(
      uid: map['uid'] as String,
      title: map['title'] as String,
      coverImg: map['coverImg'] != null ? map['coverImg'] as String : null,
      description: map['description'] as String,
      code: map['code'] as String,
      author: map['author'] as String,
      autherUid: map['autherUid'] as String,
      authorImg: map['authorImg'] as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      claps: map['claps'] as int,
      views: map['views'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory CodeModel.fromJson(String source) =>
      CodeModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CodeModel(uid: $uid, title: $title, coverImg: $coverImg, description: $description, code: $code, author: $author, autherUid: $autherUid, authorImg: $authorImg, createdAt: $createdAt, claps: $claps, views: $views)';
  }

  @override
  bool operator ==(covariant CodeModel other) {
    if (identical(this, other)) return true;

    return other.uid == uid &&
        other.title == title &&
        other.coverImg == coverImg &&
        other.description == description &&
        other.code == code &&
        other.author == author &&
        other.autherUid == autherUid &&
        other.authorImg == authorImg &&
        other.createdAt == createdAt &&
        other.claps == claps &&
        other.views == views;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        title.hashCode ^
        coverImg.hashCode ^
        description.hashCode ^
        code.hashCode ^
        author.hashCode ^
        autherUid.hashCode ^
        authorImg.hashCode ^
        createdAt.hashCode ^
        claps.hashCode ^
        views.hashCode;
  }
}
