import 'package:flix_id/data/repository/repository.dart';
import 'package:flix_id/domain/entities/entities.dart';
import 'package:flix_id/domain/usecase/register/register_param.dart';
import 'package:flix_id/domain/usecase/usecase.dart';

class Register implements UseCase<Result<User>, RegisterParam> {
  final AuthenticationRepostirory _authenticationRepostirory;
  final UserRepostirory _userRepostirory;

  Register({
    required AuthenticationRepostirory authenticationRepostirory,
    required UserRepostirory userRepostirory,
  })  : _authenticationRepostirory = authenticationRepostirory,
        _userRepostirory = userRepostirory;

  @override
  Future<Result<User>> call(RegisterParam params) async {
    final register = await _authenticationRepostirory.register(
        email: params.email, password: params.password);

    if (register.isSuccess) {
      final response = await _userRepostirory.createUser(
        email: params.email,
        name: params.name,
        uid: register.resultValue!,
        photoUrl: params.photoUrl,
      );

      if (response.isSuccess) {
        return Result.success(response.resultValue!);
      } else {
        return Result.failed('${response.errorMessage}');
      }
    } else {
      return Result.failed('${register.errorMessage}');
    }
  }
}
