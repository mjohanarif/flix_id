import 'package:flix_id/data/repository/repository.dart';
import 'package:flix_id/domain/entities/entities.dart';
import 'package:flix_id/domain/usecase/upload_profile_picture/upload_profile_picture_param.dart';
import 'package:flix_id/domain/usecase/usecase.dart';

class UploadProfilePicture
    implements UseCase<Result<User>, UploadProfilePictureParam> {
  final UserRepostirory _userRepostirory;

  const UploadProfilePicture({
    required UserRepostirory userRepostirory,
  }) : _userRepostirory = userRepostirory;
  @override
  Future<Result<User>> call(UploadProfilePictureParam params) =>
      _userRepostirory.updateProfilePicture(
        user: params.user,
        imageFile: params.imageFile,
      );
}
