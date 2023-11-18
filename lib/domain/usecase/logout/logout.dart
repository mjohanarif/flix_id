import 'package:flix_id/data/repository/repository.dart';
import 'package:flix_id/domain/entities/entities.dart';
import 'package:flix_id/domain/usecase/usecase.dart';

class Logout implements UseCase<Result<void>, void> {
  final AuthenticationRepostirory _authenticationRepostirory;

  Logout({
    required AuthenticationRepostirory authenticationRepostirory,
  }) : _authenticationRepostirory = authenticationRepostirory;

  @override
  Future<Result<void>> call(void params) {
    return _authenticationRepostirory.logout();
  }
}
