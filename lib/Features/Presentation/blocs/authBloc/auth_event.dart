/* Events are nothing but different 
actions (button click, submit, etc) 
triggered by the user from UI. 
It contains information about the action 
and gives it to the Bloc to handle. */
import 'package:equatable/equatable.dart';
 
 

abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}


// Anonymous sign in
class SignInAnonymouslyRequested extends AuthEvent {}



// When the user signing in with email and password this event is called and the [AuthRepository] is called to sign in the user
class SignInRequested extends AuthEvent {
  final String email;
  final String password;

  SignInRequested(this.email, this.password);
}

// When the user signing up with email and password this event is called and the [AuthRepository] is called to sign up the user
class UpdateProfileRequested extends AuthEvent {
  final String uid;
  final String userName;

  UpdateProfileRequested({required  this.uid,required  this.userName});
}

// When the user signing in with google this event is called and the [AuthRepository] is called to sign in the user
class GoogleSignInRequested extends AuthEvent {}

// When the user signing out this event is called and the [AuthRepository] is called to sign out the user
class SignOutRequested extends AuthEvent {}


