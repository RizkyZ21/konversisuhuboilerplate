import 'package:boilerplate/core/stores/error/error_store.dart';
import 'package:boilerplate/core/stores/form/form_store.dart';
import 'package:boilerplate/domain/usecase/user/is_logged_in_usecase.dart';
import 'package:boilerplate/domain/usecase/user/save_login_in_status_usecase.dart';
import 'package:mobx/mobx.dart';

import '../../../domain/entity/user/user.dart';
import '../../../domain/usecase/user/login_usecase.dart';

part 'login_store.g.dart';

class UserStore = _UserStore with _$UserStore;

abstract class _UserStore with Store {
  _UserStore(
    this._isLoggedInUseCase,
    this._saveLoginStatusUseCase,
    this._loginUseCase,
    this.formErrorStore,
    this.errorStore,
  ) {
    _setupDisposers();

    _isLoggedInUseCase
        .call(
      params: null,
    )
        .then((value) {
      isLoggedIn = value;
    });
  }

  final IsLoggedInUseCase _isLoggedInUseCase;

  final SaveLoginStatusUseCase _saveLoginStatusUseCase;

  final LoginUseCase _loginUseCase;

  final FormErrorStore formErrorStore;

  final ErrorStore errorStore;

  late List<ReactionDisposer> _disposers;

  void _setupDisposers() {
    _disposers = [
      reaction(
        (_) => success,
        (_) => success = false,
        delay: 200,
      ),
    ];
  }

  static ObservableFuture<User?> emptyLoginResponse = ObservableFuture.value(
    null,
  );

  bool isLoggedIn = false;

  @observable
  bool success = false;

  @observable
  ObservableFuture<User?> loginFuture = emptyLoginResponse;

  @computed
  bool get isLoading {
    return loginFuture.status == FutureStatus.pending;
  }

  @action
  Future login(
    String email,
    String password,
  ) async {
    try {
      final params = LoginParams(
        username: email,
        password: password,
      );

      final future = _loginUseCase.call(
        params: params,
      );

      loginFuture = ObservableFuture(
        future,
      );

      final value = await future;

      if (value != null) {
        await _saveLoginStatusUseCase.call(
          params: true,
        );

        isLoggedIn = true;

        success = true;
      }
    } catch (e) {
      errorStore.errorMessage = e.toString().replaceAll(
            "Exception: ",
            "",
          );

      isLoggedIn = false;

      success = false;
    }
  }

  logout() async {
    isLoggedIn = false;

    await _saveLoginStatusUseCase.call(
      params: false,
    );
  }

  void dispose() {
    for (final d in _disposers) {
      d();
    }
  }
}
