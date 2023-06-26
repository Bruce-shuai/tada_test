class User {
  String? name;
  String? email;
  String? uid;
  String? profilePhoto;

  User({
    this.name,
    this.email,
    this.uid,
    this.profilePhoto,
  });

  // 将对象序列化成 JSON 数据，以便于在网络请求等场景下传输数据或持久化存储数据
  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'uid': uid,
        'profilePhoto': profilePhoto,
      };
}
