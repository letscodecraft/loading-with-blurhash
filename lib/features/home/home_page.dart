import 'package:blurhash_loading/features/home/widgets/post_card.dart';
import 'package:blurhash_loading/features/home/widgets/story_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'bloc/post_cubit.dart';

const double kEdgeSpacing = 15;

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> storyImages = [
      'https://media.istockphoto.com/id/1289220545/photo/beautiful-woman-smiling-with-crossed-arms.jpg?s=612x612&w=0&k=20&c=qmOTkGstKj1qN0zPVWj-n28oRA6_BHQN8uVLIXg0TF8=',
      "https://burst.shopifycdn.com/photos/dark-haired-man-in-brown-leather-jacket.jpg?width=1200&format=pjpg&exif=1&iptc=1",
      "https://img.freepik.com/premium-vector/autumn-mountains-landscape-with-tree-silhouettes-river-sunset_148087-293.jpg?w=2000",
      "https://media.photographycourse.net/wp-content/uploads/2014/11/08164934/Landscape-Photography-steps.jpg",
      "https://images.unsplash.com/photo-1545912453-3d32e20f72bf?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OHx8YmVhdXRpZnVsJTIwd29tYW58ZW58MHx8MHx8fDA%3D&w=1000&q=80"
    ];
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
                  style: Theme.of(context)
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
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox(
                  height: 90,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: storyImages.length,
                    itemBuilder: (context, index) {
                      return StoryWidget(
                        storyImage: storyImages[index],
                        index: index,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          BlocProvider(
            create: (context) => PostCubit()..getPosts(),
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
