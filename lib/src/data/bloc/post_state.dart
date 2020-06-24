part of 'post_bloc.dart';

abstract class PostState extends Equatable {
  const PostState();
}

class PostInitial extends PostState {
  @override
  List<Object> get props => [];
}

class Loaded extends PostState {
  final Posts posts;

  Loaded({@required this.posts});
  @override
  List<Object> get props => [posts];
}

class Error extends PostState {
  final String message;

  Error({@required this.message});
  @override
  List<Object> get props => [message];
}
