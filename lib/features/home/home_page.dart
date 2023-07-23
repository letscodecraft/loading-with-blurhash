import 'package:blurhash_loading/features/home/widgets/post_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'bloc/post_cubit.dart';

const double kEdgeSpacing = 15;

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: Colors.black,
            expandedHeight: 80,
            leadingWidth: 200,
            leading: Padding(
              padding: const EdgeInsets.only(left: kEdgeSpacing),
              child: Text('Instagram',
                  style: Theme
                      .of(context)
                      .textTheme
                      .headlineLarge
                      ?.copyWith(fontFamily: 'Billabong', color: Colors.white)),
            ),
            flexibleSpace: const FlexibleSpaceBar(
              title: SizedBox.shrink(),
            ),
            actions: const [
              Icon(Icons.favorite_outline_rounded, size: 30),
              SizedBox(width: 13),
              Padding(
                  padding: const EdgeInsets.only(right: kEdgeSpacing),
                  child: Icon(FontAwesomeIcons.facebookMessenger))
            ],
          ),
          BlocProvider(
            create: (context) =>
            PostCubit()
              ..getPosts(),
            child: BlocBuilder<PostCubit, PostState>(
              builder: (context, state) {
                if (state is PostError) {
                  return SliverFillRemaining(
                      child: Center(child: Text(state.message)));
                } else if (state is PostLoaded) {
                  final posts = state.posts;

                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                          (context, index) {
                        final post = posts[index];
                        return CardPost(post: post);
                      },
                      childCount: posts.length,
                    ),
                  );
                } else {
                  return const SliverFillRemaining(
                      child: Center(child: CircularProgressIndicator()));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
