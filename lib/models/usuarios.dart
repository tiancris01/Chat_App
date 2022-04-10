class usuarios {
  String uid;
  String name;
  String email;
  bool onlineStatus;

  usuarios({
    required this.uid,
    this.name = "",
    this.email = "",
    this.onlineStatus = false,
  });
}
