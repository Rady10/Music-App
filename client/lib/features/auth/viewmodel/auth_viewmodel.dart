import 'package:fpdart/fpdart.dart';
import 'package:music/core/providers/current_user_notifier.dart';
import 'package:music/core/models/user_model.dart';
import 'package:music/features/auth/repositories/auth_local_repository.dart';
import 'package:music/features/auth/repositories/auth_remote_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_viewmodel.g.dart';

@riverpod
class AuthViewmodel extends _$AuthViewmodel{

  late AuthRemoteRepository _authRemoteRepository;
  late AuthLocalRepository _authLocalRepository;
  late CurrentUserNotifier _currentUserNotifier;

  @override
  AsyncValue<UserModel>? build(){
    _authRemoteRepository = ref.watch(authRemoteRepositoryProvider);
    _authLocalRepository = ref.watch(authLocalRepositoryProvider);
    _currentUserNotifier = ref.watch(currentUserNotifierProvider.notifier);
    return null;
  }

  Future<void> initSharedPrefernces() async{
    await _authLocalRepository.init();
  }

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {

    state = const AsyncValue.loading();

    final res = await _authRemoteRepository.signup(
      name: name, 
      email: email, 
      password: password
    );
    final val = switch(res){
      Left(value: final l ) => state = AsyncValue.error(l.message, StackTrace.current),
      Right(value : final r) => state = AsyncValue.data(r)
    };
    print(val);
  }


  Future<void> loginUser({
    required String email,
    required String password,
  }) async {

    state = const AsyncValue.loading();

    final res = await _authRemoteRepository.login(
      email: email, 
      password: password
    );

    final val = switch(res){
      Left(value : final l) => state = AsyncValue.error(l.message, StackTrace.current),
      Right(value : final r) => _loginSuccess(r)
    };
    print(val);

  }

  AsyncValue<UserModel>? _loginSuccess(UserModel user){
    _authLocalRepository.setToken(user.token);
    _currentUserNotifier.addUser(user);
    return state = AsyncValue.data(user);
  }

  Future<UserModel?> getData() async{
    state = const AsyncValue.loading();
    final token = _authLocalRepository.getToken();
    if (token != null){
      final res = await _authRemoteRepository.getCurrentUserData(token);
      final val = switch(res){
        Left(value: final l) => state = AsyncValue.error(l.message, StackTrace.current),
        Right(value : final r) => state = _getDateSuccess(r)
      };
      return val.value;
    }
    return null;
  }

  AsyncValue<UserModel> _getDateSuccess(UserModel user){
    _currentUserNotifier.addUser(user);
    return state = AsyncValue.data(user);
  }
}