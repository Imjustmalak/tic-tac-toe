import 'package:flutter/material.dart';

class TicTacToeUI extends StatefulWidget {
  @override
  _TicTacToeUIState createState() => _TicTacToeUIState();
}

class _TicTacToeUIState extends State<TicTacToeUI> {
  var grid = List.filled(9, '');
  var winner = "";
  var currentPlayer = 'X';

  var player1Name = "rym";
  var player2Name = "reyuk";
  var player1Score = 0;
  var player2Score = 0;

  void drawXO(int i) {
    if (grid[i] == '') {
      setState(() {
        grid[i] = currentPlayer;
        currentPlayer = currentPlayer == 'X' ? 'O' : 'X';
      });

      findWinner(grid[i]);
    }
  }

  bool checkMove(int i1, int i2, int i3, String sign) {
    if (grid[i1] == sign && grid[i2] == sign && grid[i3] == sign) {
      return true;
    }
    return false;
  }

  void findWinner(String currentSign) {
    if (checkMove(0, 1, 2, currentSign) ||
        checkMove(3, 4, 5, currentSign) ||
        checkMove(6, 7, 8, currentSign) ||
        checkMove(0, 3, 6, currentSign) ||
        checkMove(1, 4, 7, currentSign) ||
        checkMove(2, 5, 8, currentSign) ||
        checkMove(0, 4, 8, currentSign) ||
        checkMove(2, 4, 6, currentSign)) {
      setState(() {
        winner = currentSign == 'X' ? player1Name : player2Name;
        if (winner == player1Name) {
          player1Score += 3;
        } else {
          player2Score += 3;
        }
      });
    } else if (!grid.contains('')) {
      setState(() {
        winner = "No winner";
        player1Score += 1;
        player2Score += 1;
      });
    }
  }

  void reset() {
    setState(() {
      winner = "";
      grid = List.filled(9, '');
      player1Score = 0;
      player2Score = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tic Tac Toe'),
        backgroundColor: Colors.purple, 
      ),
      backgroundColor: Colors.purple, 
      body: Column(
        children: [
          Visibility(
            visible: winner == "" || winner == "No winner",
            maintainState: true,
            maintainAnimation: true,
            child: Expanded(
              child: Center(
                child: GridView.builder(
                  shrinkWrap: true,
                  itemCount: 9,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 4,
                    crossAxisSpacing: 4,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () => drawXO(index),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white, // Set box background color to white
                          border: Border.all(color: Colors.black), // Set box border color to black
                        ),
                        child: Center(
                          child: Text(
                            grid[index],
                            style: TextStyle(fontSize: 40),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          Visibility(
            visible: winner != "" || winner == "No winner",
            maintainState: true,
            maintainAnimation: true,
            child: Expanded(
              child: Center(
                child: Card(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          winner == "No winner"
                              ? Icons.sentiment_neutral
                              : Icons.sentiment_satisfied,
                          size: 100,
                          color: Colors.black,
                        ),
                        SizedBox(height: 20),
                        Text(
                          winner == "No winner"
                              ? "It's a tie!"
                              : 'Congratulations! $winner won the game',
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: reset,
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            onPrimary: Colors.black,
                          ),
                          child: Text(
                            'Restart',
                            style: TextStyle(fontSize: 24),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Text(
                    player1Name,
                    style: TextStyle(fontSize: 24),
                  ),
                  Container(
                    width: 80,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        'X',
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                  ),
                  Text(
                    player1Score.toString(),
                    style: TextStyle(fontSize: 24),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    player2Name,
                    style: TextStyle(fontSize: 24),
                  ),
                  Container(
                    width: 80,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        'O',
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                  ),
                  Text(
                    player2Score.toString(),
                    style: TextStyle(fontSize: 24),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: reset,
            style: ElevatedButton.styleFrom(
              primary: Colors.white,
              onPrimary: Colors.black,
            ),
            child: Text(
              'Reset Game',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic Tac Toe',
      theme: ThemeData(primarySwatch: Colors.purple),
      home: TicTacToeUI(),
    );
  }
}
