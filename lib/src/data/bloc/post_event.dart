part of 'post_bloc.dart';

abstract class PostEvent extends Equatable {
  const PostEvent();
}

class FetchPosts extends PostEvent {
  final int pageNumber;
  FetchPosts({@required this.pageNumber});

  @override
  List<Object> get props => [pageNumber];
}
