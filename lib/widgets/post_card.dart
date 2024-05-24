import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_instagram_latest/models/user.dart';
import 'package:flutter_instagram_latest/providers/user_provider.dart';
import 'package:flutter_instagram_latest/screens/comments_screen.dart';
import 'package:flutter_instagram_latest/utils/colors.dart';
import 'package:flutter_instagram_latest/utils/utils.dart';
import 'package:flutter_instagram_latest/widgets/like_animation.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../resources/firestore_methods.dart';

class PostCard extends StatefulWidget {
  final snap;
  const PostCard({Key?key, required this.snap}): super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool isLikeAnimating = false;
  int commentLen = 0;

  @override
  void initState(){
    super.initState();
    getComments();
  }
  void getComments() async{
    try{
    QuerySnapshot snap=await FirebaseFirestore.instance.collection('posts').doc(widget.snap['postId']).collection('comments')
        .get();
    commentLen = snap.docs.length;

    }catch(e){
      // showSnackBar(e.toString(), context);
    }
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context).getUser;

    return Container(
      color: mobileBackgroundColor,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Container(padding: const EdgeInsets.symmetric(
            vertical: 4, horizontal: 16,
          ).copyWith(right: 0),
            // HEADER SECTION
            child: Row(
              children: [
                CircleAvatar(
                  radius: 16,
                    backgroundImage: NetworkImage(widget.snap['profImage']),
                ),
                Expanded(child: Padding(padding: const EdgeInsets.only(left: 8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('username', style: TextStyle(fontWeight: FontWeight.bold),),
                  ],
                ),)),
                IconButton(onPressed: (){
                  showDialog(context: context, builder: (context)=>Dialog(
                    child: ListView(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shrinkWrap: true,
                      children: [
                        'Delete'
                      ].map((e) => InkWell(
                        onTap: (){
                          FireStoreMethods().deletePost(widget.snap['postId']);
                          // to remove the dialog box ued .pop()
                          Navigator.of(context).pop();
                        },
                        child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                        child: Text(e),
                      ),)).toList(),
                    ),
                  ));
                }, icon: Icon(Icons.more_vert))
              ],
            ),
            // IMAGE SECTION
            ),

          GestureDetector(
            onDoubleTap: () async {
              await FireStoreMethods().likePost(
                widget.snap['postId'],
                user.uid,
                widget.snap['likes']
              );
              setState(() {
                isLikeAnimating=true;
              });
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height*0.35,
                  width: double.infinity,
                  child: Image.network('https://img.freepik.com/free-photo/woman-bed_144627-41974.jpg?w=1060&t=st=1716450804~exp=1716451404~hmac=310e290af660ead3dbd84f27088a6d2f488058be39dae726c41a59d43e121cac', fit: BoxFit.cover,),
                ),
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: isLikeAnimating? 1:0,
                  child: LikeAnimation(child: const Icon(Icons.favorite, color: Colors.white, size: 100,),
                      isAnimating: isLikeAnimating,
                      duration: const Duration(
                        milliseconds: 400,
                      ),
                      onEnd: (){
                        setState(() {
                          isLikeAnimating=false;
                        });
                      },),
                )
              ],
            ),
          ),


          // LIKE COMMENT SECTION
          Row(
            children: [
              LikeAnimation(
                isAnimating: widget.snap['likes'].contains(user.uid),
                smallLike: true,
                child: IconButton(onPressed: () async {
                  await FireStoreMethods().likePost(
                      widget.snap['postId'],
                      user.uid,
                      widget.snap['likes']
                  );
                },
                    icon: widget.snap['likes'].containes(user.uid)
                    ?Icon(Icons.favorite, color: Colors.red,) : Icon(Icons.favorite_border),
                )),
              IconButton(onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context)=>CommentsScreen(postId: null,))),
                icon: Icon(Icons.comment_outlined, color: Colors.red,),),
              IconButton(onPressed: (){}, icon: Icon(Icons.send, color: Colors.red,),),
              Expanded(child: Align(alignment: Alignment.bottomRight,
              child: IconButton(
                icon: const Icon(Icons.bookmark_border),
                onPressed: (){},
              ),))

            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DefaultTextStyle(
                  style: Theme.of(context).textTheme.subtitle2!.copyWith(
                    fontWeight: FontWeight.w800
                  ),
                    child: Text('${widget.snap['likes'].length} likes',
                      style: Theme.of(context).textTheme.bodyText2,)
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(
                    top: 8
                  ),
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(color: primaryColor),
                      children: [
                        TextSpan(
                          text: widget.snap['username'],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: widget.snap['description']
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: (){},
                  child: Container(
                    child: Text('View all $commentLen comments', style: const TextStyle(
                      fontSize: 16, color: secondaryColor
                    ),),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Text(DateFormat.yMMMd(widget.snap['datePublished'].toDate()) as String, style: const TextStyle(
                      fontSize: 16, color: secondaryColor
                  ),),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
