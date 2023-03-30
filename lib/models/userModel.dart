class UserModel {
  String uid;
 List<String> userInfo;
  String personalImageUrl;

  UserModel(
    this.uid, {
    this.userInfo,
    this.personalImageUrl,
  });
}
