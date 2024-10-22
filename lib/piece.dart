import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_tetris/GameBoard.dart';
import 'package:flutter_tetris/values.dart';

class Piece {
  Tetromino type;

  Piece({required this.type});

  List<int> position = [];

  // color of tetris
  Color get color {
    return tetrominoColors[type] ?? Colors.white;
  }

  // generate integers
  void initializePiece() {
    switch (type) {
      case Tetromino.L:
        position = [-26, -16, -6, -5];
      case Tetromino.J:
        position = [-25, -15, -5, -6];
      case Tetromino.I:
        position = [-4, -5, -6, -7];
      case Tetromino.O:
        position = [-15, -16, -5, -6];
      case Tetromino.S:
        position = [-15, -14, -6, -5];
      case Tetromino.Z:
        position = [-17, -16, -6, -5];
      case Tetromino.T:
        position = [-26, -16, -6, -15];
      default:
    }
  }

  // move piece
  void movePiece(Direction direction) {
    switch (direction) {
      case Direction.down:
        for (int i = 0; i < position.length; i++) {
          position[i] += rowLength;
        }
      case Direction.left:
        for (int i = 0; i < position.length; i++) {
          position[i] -= 1;
        }
      case Direction.right:
        for (int i = 0; i < position.length; i++) {
          position[i] += 1;
        }
      default:
    }
  }

  // rotate piece
  int rotationState = 1;
  void rotatePiece() {
    List<int> newPosition = [];

    // rotate the piece on it's type
    switch (type) {
      // L
      case Tetromino.L:
        switch (rotationState) {
          case 0:
            // get the new position
            newPosition = [
              position[1] - rowLength,
              position[1],
              position[1] + rowLength,
              position[1] + rowLength + 1
            ];
            // check if is a valid position
            if (piecePositionIsValid(newPosition)) {
              // update position
              position = newPosition;
              //update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 1:
            // get the new position
            newPosition = [
              position[1] - 1,
              position[1],
              position[1] + 1,
              position[1] + rowLength - 1
            ];
            // check if is a valid position
            if (piecePositionIsValid(newPosition)) {
              // update position
              position = newPosition;
              //update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 2:
            // get the new position
            newPosition = [
              position[1] + rowLength,
              position[1],
              position[1] - rowLength,
              position[1] - rowLength - 1
            ];
            // check if is a valid position
            if (piecePositionIsValid(newPosition)) {
              // update position
              position = newPosition;
              //update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 3:
            // get the new position
            newPosition = [
              position[1] - rowLength + 1,
              position[1],
              position[1] + 1,
              position[1] - 1
            ];
            // check if is a valid position
            if (piecePositionIsValid(newPosition)) {
              // update position
              position = newPosition;
              //update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
        }
        break;
      // J
      case Tetromino.J:
        switch (rotationState) {
          case 0:
            // get the new position
            newPosition = [
              position[1] - rowLength,
              position[1],
              position[1] + rowLength,
              position[1] + rowLength - 1
            ];
            // check if is a valid position
            if (piecePositionIsValid(newPosition)) {
              // update position
              position = newPosition;
              //update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 1:
            // get the new position
            newPosition = [
              position[1] - rowLength - 1,
              position[1],
              position[1] - 1,
              position[1] + 1
            ];
            // check if is a valid position
            if (piecePositionIsValid(newPosition)) {
              // update position
              position = newPosition;
              //update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 2:
            // get the new position
            newPosition = [
              position[1] + rowLength,
              position[1],
              position[1] - rowLength,
              position[1] - rowLength + 1
            ];
            // check if is a valid position
            if (piecePositionIsValid(newPosition)) {
              // update position
              position = newPosition;
              //update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 3:
            // get the new position
            newPosition = [
              position[1] + 1,
              position[1],
              position[1] - 1,
              position[1] + rowLength + 1
            ];
            // check if is a valid position
            if (piecePositionIsValid(newPosition)) {
              // update position
              position = newPosition;
              //update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
        }
        break;
      // I
      case Tetromino.I:
        switch (rotationState) {
          case 0:
            // get the new position
            newPosition = [
              position[1] - 1,
              position[1],
              position[1] + 1,
              position[1] + 2
            ];
            // check if is a valid position
            if (piecePositionIsValid(newPosition)) {
              // update position
              position = newPosition;
              //update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 1:
            // get the new position
            newPosition = [
              position[1] - rowLength,
              position[1],
              position[1] - rowLength,
              position[1] + 1 * rowLength
            ];
            // check if is a valid position
            if (piecePositionIsValid(newPosition)) {
              // update position
              position = newPosition;
              //update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 2:
            // get the new position
            newPosition = [
              position[1] + 1,
              position[1],
              position[1] - 1,
              position[1] - 2
            ];
            // check if is a valid position
            if (piecePositionIsValid(newPosition)) {
              // update position
              position = newPosition;
              //update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 3:
            // get the new position
            newPosition = [
              position[1] + rowLength,
              position[1],
              position[1] - rowLength,
              position[1] - 2 * rowLength
            ];
            // check if is a valid position
            if (piecePositionIsValid(newPosition)) {
              // update position
              position = newPosition;
              //update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
        }
        break;
      // O
      case Tetromino.O:
        // no tiene rotacion
        break;
      // S
      case Tetromino.S:
        switch (rotationState) {
          case 0:
            // get the new position
            newPosition = [
              position[1],
              position[1] + 1,
              position[1] + rowLength - 1,
              position[1] + rowLength
            ];
            // check if is a valid position
            if (piecePositionIsValid(newPosition)) {
              // update position
              position = newPosition;
              //update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 1:
            // get the new position
            newPosition = [
              position[0] - rowLength,
              position[0],
              position[0] + 1,
              position[0] + rowLength + 1
            ];
            // check if is a valid position
            if (piecePositionIsValid(newPosition)) {
              // update position
              position = newPosition;
              //update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 2:
            // get the new position
            newPosition = [
              position[1],
              position[1] + 1,
              position[1] + rowLength - 1,
              position[1] + rowLength
            ];
            // check if is a valid position
            if (piecePositionIsValid(newPosition)) {
              // update position
              position = newPosition;
              //update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 3:
            // get the new position
            newPosition = [
              position[0] - rowLength,
              position[0],
              position[0] + 1,
              position[0] + rowLength + 1
            ];
            // check if is a valid position
            if (piecePositionIsValid(newPosition)) {
              // update position
              position = newPosition;
              //update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
        }
        break;
      // Z
      case Tetromino.Z:
        switch (rotationState) {
          case 0:
            // get the new position
            newPosition = [
              position[0] + rowLength - 2,
              position[1],
              position[2] + rowLength - 1,
              position[3] + 1
            ];
            // check if is a valid position
            if (piecePositionIsValid(newPosition)) {
              // update position
              position = newPosition;
              //update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 1:
            // get the new position
            newPosition = [
              position[0] - rowLength + 2,
              position[1],
              position[2] - rowLength + 1,
              position[3] - 1
            ];
            // check if is a valid position
            if (piecePositionIsValid(newPosition)) {
              // update position
              position = newPosition;
              //update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 2:
            // get the new position
            newPosition = [
              position[0] + rowLength - 2,
              position[1],
              position[2] + rowLength - 1,
              position[3] + 1
            ];
            // check if is a valid position
            if (piecePositionIsValid(newPosition)) {
              // update position
              position = newPosition;
              //update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 3:
            // get the new position
            newPosition = [
              position[0] - rowLength + 2,
              position[1],
              position[2] - rowLength + 1,
              position[3] - 1
            ];
            // check if is a valid position
            if (piecePositionIsValid(newPosition)) {
              // update position
              position = newPosition;
              //update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
        }
        break;
      // T
      case Tetromino.T:
        switch (rotationState) {
          case 0:
            // get the new position
            newPosition = [
              position[2] - rowLength,
              position[2],
              position[2] + 1,
              position[2] + rowLength
            ];
            // check if is a valid position
            if (piecePositionIsValid(newPosition)) {
              // update position
              position = newPosition;
              //update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 1:
            // get the new position
            newPosition = [
              position[1] - 1,
              position[1],
              position[1] + 1,
              position[1] + rowLength
            ];
            // check if is a valid position
            if (piecePositionIsValid(newPosition)) {
              // update position
              position = newPosition;
              //update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 2:
            // get the new position
            newPosition = [
              position[1] - rowLength,
              position[1] - 1,
              position[1],
              position[1] + rowLength
            ];
            // check if is a valid position
            if (piecePositionIsValid(newPosition)) {
              // update position
              position = newPosition;
              //update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 3:
            // get the new position
            newPosition = [
              position[2] - rowLength,
              position[2] - 1,
              position[2],
              position[2] + 1
            ];
            // check if is a valid position
            if (piecePositionIsValid(newPosition)) {
              // update position
              position = newPosition;
              //update rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
        }
        break;
      default:
    }
  }

  // check if valid position
  bool positionIsValid(int position) {
    //get the row and col of position
    int row = (position / rowLength).floor();
    int col = position % rowLength;

    //if the position is taken, return false
    if (row < 0 || col < 0 || gameBoard[row][col] != null) {
      return false;
    } else {
      return true;
    }
  }

  // if piece is valid position
  bool piecePositionIsValid(List<int> piecePosition) {
    bool firsColOccupied = false;
    bool lastColOccupied = false;

    for (int pos in piecePosition) {
      if (!positionIsValid(pos)) {
        return false;
      }
      //get the col of position
      int col = pos % rowLength;

      //check if the first or last column is ocuppied
      if (col == 0) {
        firsColOccupied = true;
      }
      if (col == rowLength - 1) {
        lastColOccupied = true;
      }
    }
    //if there is a piece in the first col and last col, it is going thourh the wall
    return !(firsColOccupied && lastColOccupied);
  }
}
