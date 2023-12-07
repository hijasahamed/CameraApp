
class Imagemodel{

  int? id;
  final String image;


  Imagemodel(
    {this.id,
    required this.image
    }
  );


  static Imagemodel fromMap(Map<String, Object?> map) {
    final id=map['id'] as int;
    final image=map['image'] as String;

    return Imagemodel(id:id, image: image);
  }
}