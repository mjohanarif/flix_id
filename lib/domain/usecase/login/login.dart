import 'package:flix_id/data/repository/repository.dart';
import 'package:flix_id/domain/entities/entities.dart';
import 'package:flix_id/domain/usecase/usecase.dart';

part 'login_params.dart';

class Login implements UseCase<Result<User>, LoginParams> {
  final AuthenticationRepostirory authenticationRepostitory;
  final UserRepostirory userRepository;

  const Login({
    required this.authenticationRepostitory,
    required this.userRepository,
  });

  @override
  Future<Result<User>> call(LoginParams params) async {
    var idResult = await authenticationRepostitory.login(
      email: params.email,
      password: params.password,
    );

    if (idResult is Success) {
      var userResult = await userRepository.getUser(uid: idResult.resultValue!);

      return switch (userResult) {
        Success(value: final user) => Result.success(user),
        Failed(:final message) => Result.failed(message),
      };
    } else {
      return Result.failed(idResult.errorMessage!);
    }
  }
}
