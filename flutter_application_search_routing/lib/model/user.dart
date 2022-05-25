// done
class User {
  final int id;
  final String login;
  final String avatar_url;

  const User({
    required this.id,
    required this.login,
    required this.avatar_url,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'],
        login: json['login'],
        avatar_url: json['avatar_url'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'login': login,
        'avatar_url': avatar_url,
      };
}
