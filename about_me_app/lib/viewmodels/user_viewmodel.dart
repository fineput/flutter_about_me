import '../models/user_model.dart';
import '../repositories/user_repository.dart';

class UserViewModel {
  final UserRepository _repository = UserRepository();

  List<UserModel> get users => _repository.getAllUsers();
}
