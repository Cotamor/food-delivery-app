import 'package:food_deli/data/repository/auth_repo.dart';
import 'package:food_deli/models/response_model.dart';
import 'package:food_deli/models/sign_up_body_model.dart';
import 'package:get/get.dart';

class AuthController extends GetxController implements GetxService {
  final AuthRepo authRepo;

  AuthController({
    required this.authRepo,
  });

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<ResponseModel> registration(SignUpBody singUpBody) async {
    _isLoading = true;
    update();
    Response response = await authRepo.registration(singUpBody);
    late ResponseModel responseModel;

    if (response.statusCode == 200) {
      // Success
      authRepo.saveUserToken(response.body['token']);
      responseModel = ResponseModel(true, response.body['token']);
    } else {
      // Fail
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> login(String phone, String password) async {
    _isLoading = true;
    update();
    Response response = await authRepo.login(phone, password);
    late ResponseModel responseModel;

    if (response.statusCode == 200) {
      // Success
      authRepo.saveUserToken(response.body['token']);
      print('my token is ${response.body['token']}');
      responseModel = ResponseModel(true, response.body['token']);
    } else {
      // Fail
      print('big fail');
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  void saveUserNumberAndPassword(String number, String password) {
    authRepo.saveUserNumberAndPassword(number, password);
  }

  bool userLoggedIn() {
    return authRepo.userLoggedin();
  }

  bool clearShearedData() {
    return authRepo.clearSharedData();
  }
}
