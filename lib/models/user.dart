class User {
  String? id;
  String? name;
  String? email;
  String? email_verified_at;
  String? password;
  String? remember_token;
  String? created_at;
  String? updated_at;
  String? img_url;
  String? code_ami;

  User(
      {this.id,
      this.name,
      this.email,
      this.email_verified_at,
      this.password,
      this.remember_token,
      this.created_at,
      this.updated_at,
      this.img_url,
      this.code_ami});
      
  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'] as String,
        name: json['name'] as String,
        email: json['email'] as String,
        email_verified_at: json['email_verified_at'] as String,
        password: json['password'] as String,
        remember_token: json['remember_token'] as String,
        created_at: json['created_at'] as String,
        updated_at: json['updated_at'] as String,
        img_url: json['img_url'] as String,
        code_ami: json['code_ami'] as String
      );
}
