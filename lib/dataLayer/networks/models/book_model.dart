
class BookModel {
  int? count;
  String? next;
  String? previous;
  List<Results>? results;

  BookModel({this.count, this.next, this.previous, this.results});

  BookModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(new Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['next'] = this.next;
    data['previous'] = this.previous;
    if (this.results != null) {
      data['results'] = this.results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
class Results {
  int? id;
  String? title;
  List<Authors>? authors;
  List<String>? summaries;
  Formats? formats;

  Results({this.id, this.title, this.authors, this.summaries, this.formats});

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    if (json['authors'] != null) {
      authors = <Authors>[];
      json['authors'].forEach((v) {
        authors!.add(new Authors.fromJson(v));
      });
    }
    summaries = json['summaries'].cast<String>();

    formats =
        json['formats'] != null ? new Formats.fromJson(json['formats']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    if (this.authors != null) {
      data['authors'] = this.authors!.map((v) => v.toJson()).toList();
    }
    data['summaries'] = this.summaries;

    if (this.formats != null) {
      data['formats'] = this.formats!.toJson();
    }
    return data;
  }
}

class Authors {
  String? name;

  Authors({this.name,});

  Authors.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}

class Formats {

  String? imageJpeg;


  Formats({
    this.imageJpeg,

  });

  Formats.fromJson(Map<String, dynamic> json) {

    imageJpeg = json['image/jpeg'];
 
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['image/jpeg'] = this.imageJpeg;

    return data;
  }
}
