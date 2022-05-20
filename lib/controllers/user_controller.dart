import 'package:food_deli/data/repository/user_repo.dart';
import 'package:food_deli/models/response_model.dart';
import 'package:food_deli/models/user_model.dart';
import 'package:get/get.dart';

class UserController extends GetxController implements GetxService {
  final UserRepo userRepo;

  UserController({
    required this.userRepo,
  });

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  late UserModel _userModel;
  UserModel get userModel => _userModel;

  Future<ResponseModel> getUserInfo() async {
    ResponseModel _responseModel;
    Response response = await userRepo.getUserInfo();
    print(response.statusCode.toString());

    if (response.statusCode == 200) {
      // Success
      print('success to get user info');
      print(response.body);
      _userModel = UserModel.fromJson(response.body);
      _responseModel = ResponseModel(true, 'successfully');
      _isLoading = true;
    } else {
      // Fail
      print('no user info');
      _responseModel = ResponseModel(false, response.statusText!);
    }
    update();
    return _responseModel;
  }
}
