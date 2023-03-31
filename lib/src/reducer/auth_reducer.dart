import 'package:group_gps_chat_app/src/actions/index.dart';
import 'package:group_gps_chat_app/src/models/index.dart';
import 'package:redux/redux.dart';

Reducer<AuthState> authReducer = combineReducers(<Reducer<AuthState>>[
  TypedReducer<AuthState, InitializeUserSuccessful>(_initializeUserSuccessful),
  TypedReducer<AuthState, CreateUserSuccessful>(_createUserSuccessful),
  TypedReducer<AuthState, LoginSuccessful>(_loginSuccessful),
]);

AuthState _initializeUserSuccessful(AuthState state, InitializeUserSuccessful action) {
  return state.copyWith(user: action.user);
}

AuthState _createUserSuccessful(AuthState state, CreateUserSuccessful action) {
  return state.copyWith(user: action.user);
}

AuthState _loginSuccessful(AuthState state, LoginSuccessful action) {
  return state.copyWith(user: action.user);
}
