class RegisterParam {
  final String name;
  final String email;
  final String password;
  final String? photoUrl;

  const RegisterParam({
    required this.name,
    required this.email,
    required this.password,
    this.photoUrl,
  });
}
