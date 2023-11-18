import 'dart:io';

import 'package:flix_id/domain/entities/entities.dart';

class UploadProfilePictureParam {
  final File imageFile;
  final User user;

  const UploadProfilePictureParam({
    required this.imageFile,
    required this.user,
  });
}
