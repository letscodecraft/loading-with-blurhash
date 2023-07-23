import 'dart:math';
import 'dart:ui';

import 'package:blurhash_loading/features/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:feather_icons/feather_icons.dart';
import '../domain/post_model.dart';

class CardPost extends StatelessWidget {
  final PostModel post;

  const CardPost({required this.post, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 460,
      margin: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildAuthorView(context),

          Expanded(child: _buildImageCover()),
          SizedBox(height: 10),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: kEdgeSpacing),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildIconsSection(),
                SizedBox(height: 10),
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: "${post.user.name} ",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontWeight: FontWeight.w600)),
                  TextSpan(text: post.caption)
                ]))
              ],
            ),
          )

          // _buildImageGradient(),
        ],
      ),
    );
  }

  Widget _buildImageCover() {
    return ClipRRect(
      child: Stack(children: [
        BlurHash(
          imageFit: BoxFit.cover,
          hash: post.pictureHash,
        ),
        Image.network(
          post.picture,
          width: double.infinity,
          fit: BoxFit.cover,
          loadingBuilder: (_, child, ImageChunkEvent? loadingProgress) {
            if (loadingProgress == null) return child;
            return Center(
              child: SizedBox(
                height: 55,
                width: 55,
                child: CircularProgressIndicator(
                  color: Colors.white.withOpacity(0.8),
                  strokeWidth: 1.2,
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                      : null,
                ),
              ),
            );
          },
        )
      ]),
    );
  }

  Container _buildAuthorView(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
          left: kEdgeSpacing, right: kEdgeSpacing, top: 20, bottom: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.network(
                        post.user.image,
                        width: 32,
                        height: 32,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      post.user.name,
                    ),
                  ],
                ),
                Text(
                  "⋮",
                  style: Theme.of(context).textTheme.headlineSmall,
                )
              ],
            ),
          ),
          // const SizedBox(height: 12),
          // Text(
          //   post.caption,
          //   maxLines: 2,
          //   overflow: TextOverflow.ellipsis,
          // ),
          // const SizedBox(height: 2),
        ],
      ),
    );
  }
}

class _buildIconsSection extends StatelessWidget {
  const _buildIconsSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.favorite_border_sharp, size: 30),
            SizedBox(width: 15),
            Transform.rotate(
                angle: -pi / 2,
                child: Icon(FeatherIcons.messageCircle, size: 28)),
            SizedBox(width: 15),
            Icon(FeatherIcons.send, size: 28)
          ],
        ),
        Icon(
          FeatherIcons.bookmark,
          size: 28,
        )
      ],
    );
  }
}
