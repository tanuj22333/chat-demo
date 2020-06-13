import 'package:chatapp/http_events.dart';
import 'package:chatapp/http_states.dart';
import 'package:chatapp/models/profile_res.dart';
import 'package:chatapp/repo/data_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileBloc extends Bloc<HttpEvent, HttpState> {
  @override
  HttpState get initialState {
    return LoadingState();
  }

  @override
  Stream<HttpState> mapEventToState(HttpEvent event) async* {
    if (event is LoadProfileData) {
      yield LoadingState();
      Profile userProfile = await DataRepo.loadProfileData();
      yield ProfileDataLoadSuccess(userProfile);
    }
  }

  void loadProfileData() {
    add(LoadProfileData());
  }
}

class LoadProfileData extends HttpEvent {}

class ProfileDataLoadSuccess extends SuccessState {
  final Profile userProfile;

  ProfileDataLoadSuccess(this.userProfile);
}
