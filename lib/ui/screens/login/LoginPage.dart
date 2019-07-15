import 'package:coromandel_mobile/ui/screens/home/home_scaffold_view.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

// ignore: mixin_inherits_from_not_object
class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  AnimationController _iconAnimationController;
  Animation<double> _iconAnimation;

  @override
  void initState() {
    super.initState();
    _iconAnimationController = new AnimationController(
        vsync: this, duration: new Duration(milliseconds: 1500));

    _iconAnimation = new CurvedAnimation(
        parent: _iconAnimationController, curve: Curves.easeIn);
    _iconAnimation.addListener(() => this.setState(() {}));
    _iconAnimationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: Colors.black12,
        body: new Stack(
          fit: StackFit.expand,
          children: <Widget>[
            new Image(
              image: new AssetImage('assets/images/carousel_gallery_4.jpg'),
              fit: BoxFit.cover,
//            color: Colors.black54,
//            colorBlendMode: BlendMode.darken,
            ),
            new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Image(
                    image: new AssetImage('assets/images/splash_logo.png'),
                    height: _iconAnimation.value * 275,
                    width: _iconAnimation.value * 275,
                  ),
                  new Form(
                    child: new Theme(
                      data: new ThemeData(
                          brightness: Brightness.dark,
                          primarySwatch: Colors.teal,
                          inputDecorationTheme: new InputDecorationTheme(
                              labelStyle: new TextStyle(
                                  color: Colors.tealAccent, fontSize: 18.0))),
                      child: new Container(
                        padding: const EdgeInsets.all(40.0),
                        child: new Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            new TextFormField(
                              decoration: new InputDecoration(
                                labelText: "Enter Email",
                              ),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter your email.';
                                }
                              },
                              keyboardType: TextInputType.emailAddress,
                            ),
                            new TextFormField(
                              decoration: new InputDecoration(
                                labelText: "Enter Password",
                              ),
                              keyboardType: TextInputType.text,
                              obscureText: true,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter your password.';
                                }
                              },
                            ),
                            new Padding(
                                padding: const EdgeInsets.only(top: 40.0)),
                            new MaterialButton(
                              height: 40.0,
                              minWidth: 100.0,
                              onPressed: () {
                                NavigateToHomePage(context);
                              },
                              color: Colors.orangeAccent,
                              child: new Icon(Icons.forward),
                              splashColor: Colors.redAccent,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ]),
          ],
        ));
  }

  void NavigateToHomePage(BuildContext context) {
    Navigator.of(context).push(new MaterialPageRoute(
        builder: (BuildContext context) => new HomeScaffold()));
  }
}
