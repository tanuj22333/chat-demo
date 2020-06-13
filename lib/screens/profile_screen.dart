import 'package:chatapp/blocs/profile_bloc.dart';
import 'package:chatapp/http_states.dart';
import 'package:chatapp/models/profile_res.dart';
import 'package:chatapp/widgets/zero_size_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profile")),
      body: ProfileScreenContent(),
    );
  }
}

class ProfileScreenContent extends StatefulWidget {
  const ProfileScreenContent({Key key}) : super(key: key);

  @override
  _ProfileScreenContentState createState() => _ProfileScreenContentState();
}

class _ProfileScreenContentState extends State<ProfileScreenContent> {
  ProfileBloc _profileBloc;

  @override
  void initState() {
    super.initState();
    _profileBloc = ProfileBloc();
    _profileBloc.loadProfileData();
  }

  @override
  void dispose() {
    _profileBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _profileBloc,
      child: ProfileState(),
    );
  }
}

class ProfileState extends StatelessWidget {
  const ProfileState({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, HttpState>(
      builder: (context, httpState) {
        if (httpState is LoadingState) {
          return AppLoader();
        } else if (httpState is ProfileDataLoadSuccess) {
          return ProfileContent(httpState.userProfile);
        }
        return ZeroSizeContainer();
      },
      listener: (context, httpState) {
        if (httpState is LocalErrorState) {
          showErrorSnackBar(context);
        }
      },
    );
  }
}

class ProfileContent extends StatelessWidget {
  final Profile userProfile;

  const ProfileContent(this.userProfile, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.person, size: 62),
          const SizedBox(height: 18),
          Text("First Name: ${userProfile.firstName}"),
          const SizedBox(height: 18),
          Text("Last Name: ${userProfile.lastName}"),
          const SizedBox(height: 18),
          RaisedButton(
            onPressed: () {
              BlocProvider.of<ProfileBloc>(context).loadProfileData();
            },
            padding: EdgeInsets.symmetric(horizontal: 44, vertical: 8),
            color: Theme.of(context).accentColor,
            textColor: Colors.white,
            child: Text("Refresh"),
          )
        ],
      ),
    );
  }
}

class AppLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}

void showErrorSnackBar(BuildContext context) {
  Scaffold.of(context).showSnackBar(SnackBar(
    content: Text("Something went wrong!"),
  ));
}
