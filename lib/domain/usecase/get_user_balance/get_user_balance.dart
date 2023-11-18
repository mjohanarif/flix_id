import 'package:flix_id/data/repository/repository.dart';
import 'package:flix_id/domain/entities/entities.dart';
import 'package:flix_id/domain/usecase/get_user_balance/get_user_balance_param.dart';
import 'package:flix_id/domain/usecase/usecase.dart';

class GetUserBalance implements UseCase<Result<int>, GetUserBalanceParam> {
  final UserRepostirory _userRepostirory;

  const GetUserBalance({
    required UserRepostirory userRepostirory,
  }) : _userRepostirory = userRepostirory;
  @override
  Future<Result<int>> call(GetUserBalanceParam params) =>
      _userRepostirory.getUserBalance(uid: params.usedId);
}
