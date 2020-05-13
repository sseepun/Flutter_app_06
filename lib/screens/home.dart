import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './movie.dart';
import '../widgets/content_scroll.dart';
import '../models/movie.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController _pageController;

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([
      SystemUiOverlay.bottom,
    ]);
    super.initState();

    _pageController = PageController(
      initialPage: 1, viewportFraction: 0.8,
    );
  }

  Widget _movieSelector(Movie movie, int movieIndex) {
    return AnimatedBuilder(
      animation: _pageController, 
      builder: (BuildContext context, Widget widget) {
        double value = 1;
        if (_pageController.position.haveDimensions) {
          value = _pageController.page - movieIndex;
          value = (1.0 - (value.abs() * 0.3) + 0.05).clamp(0.0, 1.0);
        }
        return Center(
          child: SizedBox(
            width: Curves.easeInOut.transform(value) * MediaQuery.of(context).size.width * 0.9,
            height: Curves.easeInOut.transform(value) * MediaQuery.of(context).size.height * 0.36,
            child: widget,
          ),
        );
      },
      child: GestureDetector(
        onTap: () => Navigator.push(
          context, 
          MaterialPageRoute(
            builder: (_) => MovieScreen(
              movie: movie, movieIndex: movieIndex,
            ),
          )
        ),
        child: Stack(
          children: <Widget>[

            Center(
              child: Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 10, vertical: 20,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, 0.4),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Center(
                  child: Hero(
                    tag: 'movie-'+movieIndex.toString(),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image(
                        image: AssetImage(movie.imageUrl),
                        height: MediaQuery.of(context).size.width * 0.9,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            Positioned(
              left: 0,
              bottom: 0,
              child: Padding(
                padding: EdgeInsets.fromLTRB(30, 0, 30, 40),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9 - 60,
                  child: Text(
                    movie.title.toUpperCase(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Image(
          image: AssetImage('assets/img/netflix_logo.png'),
          width: 120,
        ),
        leading: IconButton(
          onPressed: () => print('Menu'),
          padding: EdgeInsets.only(
            left: 20,
          ),
          icon: Icon(Icons.menu),
          iconSize: 30,
          color: Colors.black,
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () => print('Search'),
            padding: EdgeInsets.only(
              right: 20,
            ),
            icon: Icon(Icons.search),
            iconSize: 30,
            color: Colors.black,
          ),
        ],
      ),

      body: ListView(
        children: <Widget>[

          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.36,
            child: PageView.builder(
              controller: _pageController,
              itemCount: movies.length,
              itemBuilder: (BuildContext conext, int index) {
                return _movieSelector(movies[index], index);
              },
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Container(
              height: 80,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: labels.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 10,
                    ),
                    width: 160,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xFFD45253),
                          Color(0xFF9E1F28),
                        ],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFF9E1F28),
                          offset: Offset(0, 2),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        labels[index].toUpperCase(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.8,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          SizedBox(height: 20,),
          ContentScroll(
            images: myList,
            title: 'My List',
            imageWidth: 150,
            imageHeight: 250,
          ),

          SizedBox(height: 10,),
          ContentScroll(
            images: popular,
            title: 'Popular',
            imageWidth: 150,
            imageHeight: 250,
          ),
          
          SizedBox(height: 20,),

        ],
      ),
    );
  }
}
