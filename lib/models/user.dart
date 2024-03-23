class User {
  int? id;
  String? name;
  String? email;
  String? email_verified_at;
  String? created_at;
  String? updated_at;

  User(
      {this.id,
      this.name,
      this.email,
      this.email_verified_at,
      this.created_at,
      this.updated_at});
      
  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'] as int,
        name: json['name'] as String,
        email: json['email'] as String,
        email_verified_at: json['email_verified_at'] as String?,
        created_at: json['created_at'] as String,
        updated_at: json['updated_at'] as String,
      );
}
