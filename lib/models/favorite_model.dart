class FavoriteModel {
  int? courseId;
  String? courseName;
  String? courseImage;
  int? rating;
  String? autherName;
  Section? section;
  num? price;

  FavoriteModel(
      {this.courseId,
      this.courseName,
      this.courseImage,
      this.rating,
      this.autherName,
      this.section,
      this.price});

  FavoriteModel.fromJson(Map<String, dynamic> json) {
    courseId = json['course_id'];
    courseName = json['course_name'];
    courseImage = json['course_image'];
    rating = json['rating'];
    autherName = json['auther_name'];
    section =
        json['section'] != null ? new Section.fromJson(json['section']) : null;
    price = json['price'];
  }
}

class Section {
  int? id;
  String? name;
  int? amountPerc;
  bool? isActive;

  Section({this.id, this.name, this.amountPerc, this.isActive});

  Section.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    amountPerc = json['amount_perc'];
    isActive = json['is_active'];
  }
}
