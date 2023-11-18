import 'package:flix_id/data/repository/repository.dart';
import 'package:flix_id/domain/entities/entities.dart';
import 'package:flix_id/domain/usecase/usecase.dart';

class GetLoggedInUser implements UseCase<Result<User>, void> {
  final AuthenticationRepostirory _authenticationRepostirory;
  final UserRepostirory _userRepostirory;

  const GetLoggedInUser({
    required AuthenticationRepostirory authenticationRepostirory,
    required UserRepostirory userRepostirory,
  })  : _authenticationRepostirory = authenticationRepostirory,
        _userRepostirory = userRepostirory;

  @override
  Future<Result<User>> call(void params) async {
    String? loggedIn = _authenticationRepostirory.getLoggedInUserId();
    if (loggedIn != null) {
      final response = await _userRepostirory.getUser(uid: loggedIn);

      if (response.isSuccess) {
        return Result.success(response.resultValue!);
      } else {
        return Result.failed(response.errorMessage!);
      }
    } else {
      return const Result.failed('No user logged in');
    }
  }
}
