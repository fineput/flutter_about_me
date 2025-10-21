import '../models/user_model.dart';

class UserViewModel {
  final UserModel user = UserModel(
    name: 'Олефіренко Ярослав',
    bio: 'Працюю у техпідтримці, цікавлюсь Python і створенням ігор.',
    hobby: 'Програмування, геймінг, спорт',
    imageUrl: 'https://www.pinterest.com/pin/582231058108463613/', // заміни на свою фотку або будь-яке посилання
  );
}
