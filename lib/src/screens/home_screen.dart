import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paginated_list_app/src/data/bloc/post_bloc.dart';
import 'package:paginated_list_app/src/data/models/posts.dart';
import 'package:paginated_list_app/src/data/repositories/posts.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Paginated ListView'),
      ),
      body: BlocProvider(
        create: (context) => PostBloc(
          repository: PostsRepository(),
        ),
        child: HomeScreenBuilder(),
      ),
    );
  }
}

class HomeScreenBuilder extends StatefulWidget {
  @override
  _HomeScreenBuilderState createState() => _HomeScreenBuilderState();
}

class _HomeScreenBuilderState extends State<HomeScreenBuilder> {
  int pageNumber;
  Posts posts;

  bool initial = true;

  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    pageNumber = 1;
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        getMorePosts(context);
      }
    });
    super.initState();
  }

  getMorePosts(BuildContext context) {
    pageNumber += 1;
    if (posts.meta.pageCount != pageNumber) {
      BlocProvider.of<PostBloc>(context)
          .add(FetchPosts(pageNumber: pageNumber));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PostBloc, PostState>(
      bloc: BlocProvider.of<PostBloc>(context),
      listener: (context, state) {
        if (state is Error) {
          showDialog(
            context: context,
            child: AlertDialog(
              title: Text('Error'),
              content: Text(state.message),
              actions: <Widget>[
                FlatButton(
                  child: Text('OK'),
                  onPressed: () => Navigator.of(context).maybePop(),
                ),
              ],
            ),
          );
        }
      },
      child: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          if (state is PostInitial) {
            BlocProvider.of<PostBloc>(context)
                .add(FetchPosts(pageNumber: pageNumber));
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is Loaded) {
            if (initial) {
              posts = state.posts;
              initial = false;
            } else {
              posts.result.addAll(state.posts.result);
            }
            return _buildLoadedUI();
          }
          return _buildLoadedUI();
        },
      ),
    );
  }

  Widget _buildLoadedUI() {
    return ListView.builder(
      controller: _scrollController,
      itemCount: posts.result.length,
      itemBuilder: (context, index) {
        if (index == posts.result.length - 1) {
          return Center(child: CircularProgressIndicator());
        }
        return ListTile(
          title: Text(posts.result[index].title),
        );
      },
    );
  }
}
