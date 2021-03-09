import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sentiment_analysis/providers/sentimentapi.dart';

// final sentimentApi = ChangeNotifierProvider<SentimentApi>((ref) {
//   return SentimentApi();
// });
final sentimentApi = StateNotifierProvider<SentimentApiStateNotifier>((ref) {
  return SentimentApiStateNotifier();
});

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  bool _loading = true;
  final _textFieldController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    double _deviceFontSize = MediaQuery.of(context).textScaleFactor;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  Color(0xFFe100ff),
                  Color(0xFF8E2DE2),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.004, 1])),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          height: deviceSize.height,
          width: deviceSize.width,
          child: SingleChildScrollView(
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              //  mainAxisAlignment: MainAxisAlignment.,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 4.5,
                ),
                Text(
                  'Sentiment Analysis',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: _deviceFontSize * 25),
                ),
                SizedBox(
                  height: 40,
                ),
                Container(
                  padding: EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Column(
                      children: [
                        SentimentTextField(
                            loading: _loading,
                            textFieldController: _textFieldController)
                      ],
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          context
                              .read(sentimentApi)
                              .getSentiment(_textFieldController.text);
                          // setState(() {
                          //   _loading = false;
                          // });
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width - 180,
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(
                              horizontal: 24, vertical: 17),
                          decoration: BoxDecoration(
                              color: Color(0xFF56ab2f),
                              borderRadius: BorderRadius.circular(6)),
                          child: Text(
                            'Find Emotions',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: _deviceFontSize * 15),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      PredictionTextWidget()
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PredictionTextWidget extends ConsumerWidget {
  const PredictionTextWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final sentiment = watch(sentimentApi.state);
    double _deviceFontSize = MediaQuery.of(context).textScaleFactor;

    return sentiment == 'L'
        ? CircularProgressIndicator()
        : Text(
            '$sentiment',
            style:
                TextStyle(color: Colors.black, fontSize: _deviceFontSize * 25),
          );
  }
}

class SentimentTextField extends StatelessWidget {
  const SentimentTextField({
    Key? key,
    required bool loading,
    required TextEditingController textFieldController,
  })   : _loading = loading,
        _textFieldController = textFieldController,
        super(key: key);

  final bool _loading;
  final TextEditingController _textFieldController;

  @override
  Widget build(BuildContext context) {
    double _deviceFontSize = MediaQuery.of(context).textScaleFactor;

    return Container(
      child: _loading
          ? Container(
              child: Column(
                children: [
                  TextField(
                    controller: _textFieldController,
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w600),
                    decoration: InputDecoration(
                        labelStyle: TextStyle(
                          color: Colors.black,
                          fontSize: _deviceFontSize * 15,
                        ),
                        labelText: 'Enter a search term: '),
                  ),
                  SizedBox(
                    height: 30,
                  )
                ],
              ),
              width: 300,
            )
          : Container(),
    );
  }
}
