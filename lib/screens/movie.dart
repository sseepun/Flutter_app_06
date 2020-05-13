import 'package:app_06/widgets/content_scroll.dart';
import 'package:flutter/material.dart';
import '../widgets/circular_clipper.dart';
import '../widgets/content_scroll.dart';
import '../models/movie.dart';

class MovieScreen extends StatefulWidget {
  final Movie movie;
  final int movieIndex;

  MovieScreen({
    this.movie,
    this.movieIndex,
  });

  @override
  _MovieScreenState createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: <Widget>[
          Stack(
            children: <Widget>[

              Container(
                transform: Matrix4.translationValues(0, -50, 0),
                child: Hero(
                  tag: 'movie-'+widget.movieIndex.toString(),
                  child: ClipShadowPath(
                    clipper: CircularClipper(),
                    shadow: Shadow(blurRadius: 20,),
                    child: Image(
                      width: double.infinity,
                      height: 400,
                      image: AssetImage(widget.movie.imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    padding: EdgeInsets.only(
                      left: 20,
                    ),
                    icon: Icon(Icons.arrow_back), 
                    iconSize: 35,
                    color: Colors.black,
                  ),
                  Image(
                    image: AssetImage('assets/img/netflix_logo.png'),
                    width: 120,
                  ),
                  IconButton(
                    onPressed: () => print('Add to favorite'),
                    padding: EdgeInsets.only(
                      right: 20,
                    ),
                    icon: Icon(Icons.favorite_border), 
                    iconSize: 30,
                    color: Colors.black,
                  ),
                ],
              ),

              Positioned(
                bottom: 10,
                left: 0,
                right: 0,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: RawMaterialButton(
                    onPressed: () => print('Paly video'),
                    elevation: 12,
                    padding: EdgeInsets.all(10),
                    shape: CircleBorder(),
                    fillColor: Colors.white,
                    child: Icon(
                      Icons.play_arrow,
                      size: 60,
                      color: Colors.red,
                    ),
                  ),
                ),
              ),

              Positioned(
                bottom: 0,
                left: 10,
                child: IconButton(
                  onPressed: () => print('Add to my list'),
                  icon: Icon(Icons.add),
                  iconSize: 35,
                  color: Colors.black,
                ),
              ),

              Positioned(
                bottom: 0,
                right: 10,
                child: IconButton(
                  onPressed: () => print('Share'),
                  icon: Icon(Icons.share),
                  iconSize: 35,
                  color: Colors.black,
                ),
              ),

            ],
          ),

          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[

                Text(
                  widget.movie.title.toUpperCase(),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10,),
                Text(
                  widget.movie.categories,
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 12,),
                Text(
                  '⭐⭐⭐⭐⭐',
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),

                SizedBox(height: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text(
                          'Year',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 2,),
                        Text(
                          widget.movie.year.toString(),
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Text(
                          'Country',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 2,),
                        Text(
                          widget.movie.country.toString(),
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Text(
                          'Length',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 2,),
                        Text(
                          '${widget.movie.length} min',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              
                SizedBox(height: 25,),
                Container(
                  height: 120,
                  child: SingleChildScrollView(
                    child: Text(
                      widget.movie.description,
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 16,
                        height: 1.45,
                      ),
                    ),
                  ),
                ),
              
              ],
            ),
          ),
          
          SizedBox(height: 10,),
          ContentScroll(
            images: widget.movie.screenshots,
            title: 'Screenshots',
            imageWidth: 250,
            imageHeight: 200,
          ),
          SizedBox(height: 20,),

        ],
      ),
    );
  }
}
