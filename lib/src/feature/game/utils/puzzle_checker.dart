bool checkSumOfNumbers(List<int> chosenNumbers, List<dynamic> correctCombination) {
  // Предполагаем, что порядок не важен, важен состав выбранных чисел.
  // Отсортируем оба списка и сравним.
  chosenNumbers.sort();
  correctCombination.sort();

  if (chosenNumbers.length != correctCombination.length) return false;
  for (int i = 0; i < chosenNumbers.length; i++) {
    if (chosenNumbers[i] != correctCombination[i]) return false;
  }
  return true;
}


bool checkLogicalSequenceNext(int chosenValue, int correctNextValue) {
  return chosenValue == correctNextValue;
}

bool checkMatchingTask(Map<String, String> userMatches, Map<String, String> correctMatches) {
  if (userMatches.length != correctMatches.length) return false;
  for (var key in correctMatches.keys) {
    if (!userMatches.containsKey(key)) return false;
    if (userMatches[key] != correctMatches[key]) return false;
  }
  return true;
}

bool checkFifteenPuzzleSolution(List<int> userArrangement, List<int> correctArrangement) {
  if (userArrangement.length != correctArrangement.length) return false;
  for (int i = 0; i < userArrangement.length; i++) {
    if (userArrangement[i] != correctArrangement[i]) return false;
  }
  return true;
}

bool checkMatchingPairs(List<List<int>> userPairs, List<List<int>> correctPairs) {
  List<List<int>> sortPairs(List<List<int>> pairs) {
    return pairs.map((p) {
      var sortedP = List<int>.from(p)..sort();
      return sortedP;
    }).toList()..sort((a, b) => a.first.compareTo(b.first));
  }

  var sortedUser = sortPairs(userPairs);
  var sortedCorrect = sortPairs(correctPairs);

  if (sortedUser.length != sortedCorrect.length) return false;
  for (int i = 0; i < sortedUser.length; i++) {
    if (sortedUser[i].length != sortedCorrect[i].length) return false;
    for (int j = 0; j < sortedUser[i].length; j++) {
      if (sortedUser[i][j] != sortedCorrect[i][j]) return false;
    }
  }
  return true;
}

bool checkMathEquation(int userAnswer, int correctAnswer) {
  return userAnswer == correctAnswer;
}

bool checkAnagramSolution(String userSolution, String validWords) {
  return validWords ==userSolution;
}

bool checkTowerOfHanoiSolution(List<List<int>> finalState, List<List<int>> goalState) {
  if (finalState.length != goalState.length) return false;
  for (int i = 0; i < finalState.length; i++) {
    if (finalState[i].length != goalState[i].length) return false;
    for (int j = 0; j < finalState[i].length; j++) {
      if (finalState[i][j] != goalState[i][j]) return false;
    }
  }
  return true;
}

bool checkLogicalPuzzle(List<String> userArrangement, List<String> correctArrangement) {
  if (userArrangement.length != correctArrangement.length) return false;
  for (int i = 0; i < userArrangement.length; i++) {
    if (userArrangement[i] != correctArrangement[i]) return false;
  }
  return true;
}

bool checkCipherSolution(String userSolution, String correctDecodedMessage) {
  return userSolution == correctDecodedMessage;
}
