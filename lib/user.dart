

class User {

  static String table = 'user_items';

  String name;

  User(
      { this.name,
        });

  factory User.fromJson(Map<String, dynamic> json) => new User(
    name: json["name"]
  );

  Map<String, dynamic> toJson() => {
    "name": name,
  };

}
