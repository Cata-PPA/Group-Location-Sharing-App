import 'package:group_gps_chat_app/src/actions/index.dart';
import 'package:group_gps_chat_app/src/models/index.dart';
import 'package:redux/redux.dart';

Reducer<LocationState> locationReducer = combineReducers(<Reducer<LocationState>>[
  TypedReducer<LocationState, OnLocationsEvent>(_onLocationsEvent),
]);

LocationState _onLocationsEvent(LocationState state, OnLocationsEvent action) {
  return state.copyWith(locations: action.locations);
}
