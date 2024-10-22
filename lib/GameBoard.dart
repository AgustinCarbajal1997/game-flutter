import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_tetris/piece.dart';
import 'package:flutter_tetris/pixel.dart';
import 'package:flutter_tetris/values.dart';

/*

  GAME BOARD
  this is a 2x2 grid with null representing an empty space
  A non empty space will have the color to represent the landed pieces
 */

//create gameboard
List<List<Tetromino?>> gameBoard =
    List.generate(colLength, (i) => List.generate(rowLength, (j) => null));

class GameBoard extends StatefulWidget {
  const GameBoard({super.key});

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  //grid dimensions
  int rowLength = 10;
  int colLength = 15;

  //current tetris piece
  Piece currentPiece = Piece(type: Tetromino.T);

  //current score
  int currentScore = 0;

  @override
  @override
  void initState() {
    super.initState();
    //start game when app start
    startGame();
  }

  void startGame() {
    currentPiece.initializePiece();

    //frame refresh rate
    Duration frameRate = const Duration(milliseconds: 400);
    gameLoop(frameRate);
  }

  void gameLoop(Duration framerate) {
    Timer.periodic(framerate, (timer) {
      setState(() {
        //clear the lines
        clearLines();
        //check landing
        checkLanding();

        //move current piece down
        currentPiece.movePiece(Direction.down);
      });
    });
  }

  // check for collision detection
  bool checkCollision(Direction direction) {
    // loop through all direction index
    for (int i = 0; i < currentPiece.position.length; i++) {
      // calculate the index of the current piece
      int row = (currentPiece.position[i] / rowLength).floor();
      int col = (currentPiece.position[i] % rowLength);

      // directions
      if (direction == Direction.down) {
        row++;
      } else if (direction == Direction.right) {
        col++;
      } else if (direction == Direction.left) {
        col--;
      }

      // check for collisions with boundaries
      if (col < 0 || col >= rowLength || row >= colLength) {
        return true;
      }

      // check for collisions with other landed pieces
      if (row >= 0 && gameBoard[row][col] != null) {
        return true;
      }
    }
    // if there is no collision return false
    return false;
  }

  void checkLanding() {
    // if going down is occupied
    if (checkCollision(Direction.down)) {
      for (int i = 0; i < currentPiece.position.length; i++) {
        int row = (currentPiece.position[i] / rowLength).floor();
        int col = currentPiece.position[i] % rowLength;
        if (row >= 0 && col >= 0) {
          gameBoard[row][col] = currentPiece.type;
        }
      }
      //once landed create the next piece
      createNewPiece();
    }
  }

  void createNewPiece() {
    //create random object to generate random tetromino types
    Random rand = Random();

    //create a new piece with random
    Tetromino randomType =
        Tetromino.values[rand.nextInt(Tetromino.values.length)];
    currentPiece = Piece(type: randomType);
    currentPiece.initializePiece();
  }

  //move left
  void moveLeft() {
    //make sure the move is valid before moving there
    if (!checkCollision(Direction.left)) {
      setState(() {
        currentPiece.movePiece(Direction.left);
      });
    }
  }

  //move right
  void moveRight() {
    if (!checkCollision(Direction.right)) {
      setState(() {
        currentPiece.movePiece(Direction.right);
      });
    }
  }

  //rotate piece
  void rotatePiece() {
    setState(() {
      currentPiece.rotatePiece();
    });
  }

  // clear lines
  void clearLines() {
    //step 1: loop through each row of the game board from top
    for (int row = colLength - 1; row >= 0; row--) {
      // step 2: initialize a variable to track  if the row is full
      bool rowIsFull = true;

      // step3: check if the row is full (all columns in the row are filled with the pieces)
      for (int col = 0; col < rowLength; col++) {
        // if there's an empty column, set rowIsFull to false and break the loop
        if (gameBoard[row][col] == null) {
          rowIsFull = false;
          break;
        }
      }
      //step 4: if the row is full, clear the row and shift the rows down
      if (rowIsFull) {
        // step 5: move all rows above the cleared  row down by one position
        for (int r = row; r > 0; r--) {
          //copy the above row to the current row
          gameBoard[r] = List.from(gameBoard[r - 1]);
        }

        //step 6: set the top row to empty
        gameBoard[0] = List.generate(row, (index) => null);

        //step 7: increase the score!
        setState(() {
          currentScore += 1;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            Expanded(
              child: GridView.builder(
                itemCount: rowLength * colLength,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: rowLength),
                itemBuilder: (context, index) {
                  //current piece
                  //get row and col of each index
                  int row = (index / rowLength).floor();
                  int col = index % rowLength;
                  if (currentPiece.position.contains(index)) {
                    return Pixel(
                      child: index,
                      color: currentPiece.color,
                    );
                  }
                  //landed pieces
                  else if (gameBoard[row][col] != null) {
                    final Tetromino? tetrominoType = gameBoard[row][col];
                    return Pixel(
                        color: tetrominoColors[tetrominoType], child: "");
                  }
                  // blank pixel
                  else {
                    return Pixel(
                      child: index,
                      color: Colors.grey[900],
                    );
                  }
                },
              ),
            ),
            Text(
              "Score $currentScore",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //left
                  IconButton(
                      color: Colors.white,
                      onPressed: moveLeft,
                      icon: Icon(Icons.arrow_back_ios_new)),

                  //rotate
                  IconButton(
                      color: Colors.white,
                      onPressed: rotatePiece,
                      icon: Icon(Icons.rotate_right)),
                  //right
                  IconButton(
                      color: Colors.white,
                      onPressed: moveRight,
                      icon: Icon(Icons.arrow_forward_ios)),
                ],
              ),
            )
          ],
        ));
  }
}
