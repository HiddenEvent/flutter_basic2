import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter_basic2/src/saved.dart';

class RandomList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RandomListState(); // 한줄짜리 return을 갖는
// 함수는 => 대체 가능
}

class _RandomListState extends State<RandomList> {
  final List<WordPair> _suggestions = <WordPair>[]; //리스트 중복값 가능
  final Set<WordPair> _saved = Set<WordPair>(); //Set은 리스트와 비슷함 중복값 불가능
  @override
  Widget build(BuildContext context) {
    final randomWord = WordPair.random();
    return Scaffold(
        appBar: AppBar(
          title: Text("naming app"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.list),
              onPressed: () { //화면 전환 부분!
                //Navigator 오브젝트를 이용해서 다른 페이지로 이동
                Navigator.of(context).push(
                  //SavedList 페이지에 _saved변수를 파라미터로 넘겨주는 부분
                  MaterialPageRoute(builder: (context)=>SavedList(saved:_saved))
                );
              },
            )
          ],
        ),
        // ignore: missing_return
        body: _buildList());
  }

  Widget _buildList() {
    return ListView.builder(itemBuilder: (context, index) {
      //0,2,4,6,8 = 진짜 인덱스 를 말한다.
      //1,3,5,7,9 = 선을 그릴때 사용함
      if (index.isOdd) {
        return Divider();
      }

      var realIndex = index ~/ 2; // ~/ 몫을 구하는 연산자

      if (realIndex >= _suggestions.length) {
        _suggestions.addAll(generateWordPairs().take(10));
      }

      return _buildRow(_suggestions[realIndex]);
    });
    //ListView.Builder는 리스트 객체를 생성해서 가져와주는 함수
  }

  Widget _buildRow(WordPair pair) {
    final bool alreadySaved = _saved.contains(pair); // 단어가 있냐 없냐를 boolean으로 리턴

    return ListTile(
      title: Text(
        pair.asPascalCase,
        textScaleFactor: 1.5,
      ),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: Colors.pink,
      ),
      onTap: () {
        setState(() {
          // 실시간 반영이라고 생각하면된다.
          if (alreadySaved)
            _saved.remove(pair);
          else
            _saved.add(pair);

          print(_saved);
        });
      },
    );
  }
//trailing 꼬리에 달린다.
}
