import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../models/api_response.dart';
import '../models/posts.dart';
import '../repositories/posts.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostsRepository repository;

  PostBloc({@required this.repository});

  @override
  PostState get initialState => PostInitial();

  @override
  Stream<PostState> mapEventToState(
    PostEvent event,
  ) async* {
    if (event is FetchPosts) {
      final result = await repository.getPosts(event.pageNumber);
      switch (result.status) {
        case Status.COMPLETED:
          yield Loaded(posts: result.data);
          break;
        case Status.ERROR:
          yield Error(message: result.message);
          break;
      }
    }
  }
}
