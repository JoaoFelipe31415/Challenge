class WordSearchService {
  final List<List<int>> _directions = [
    [0, 1], // right
    [0, -1], // left
    [1, 0], // down
    [-1, 0], // up
    [1, 1], // down-right
    [1, -1], // down-left
    [-1, 1], // up-right
    [-1, -1], // up-left
  ];

  int countWord(String word, List<String> matriz) {
    int contador = 0;
    final quantidadeLinhas = matriz.length;
    final quantidadeColunas = matriz[0].trim().length;
    for (int i = 0; i < quantidadeLinhas; i++) {
      for (int j = 0; j < quantidadeColunas; j++) {
        if (matriz[i][j].toLowerCase() == word[0].toLowerCase()) {
          for (var dir in _directions) {
            contador += _searchInDirection(
              i,
              j,
              dir[0],
              dir[1],
              quantidadeLinhas,
              quantidadeColunas,
              matriz,
              word.toLowerCase(),
            );
          }
        }
      }
    }

    return contador;
  }

  int _searchInDirection(
    int i,
    int j,
    int dx,
    int dy,
    int tamanhoLinha,
    int tamanhoColuna,
    List<String> matriz,
    String target,
  ) {
    int z = 1;
    String word = matriz[i][j].toLowerCase();

    int x = i + dx;
    int y = j + dy;

    while (_restricaoLinha(tamanhoLinha, x) &&
        _restricaoColuna(tamanhoColuna, y) &&
        word.length < target.length) {
      if (matriz[x][y].toLowerCase() == target[z].toLowerCase()) {
        word += matriz[x][y].toLowerCase();
        z++;
        x += dx;
        y += dy;
      } else {
        return 0;
      }
    }

    if (word == target) {
      return 1;
    } else {
      return 0;
    }
  }

  bool _restricaoLinha(int quantidadeLinhas, int x) {
    return 0 <= x && x < quantidadeLinhas;
  }

  bool _restricaoColuna(int quantidadeColunas, int y) {
    return 0 <= y && y < quantidadeColunas;
  }
}
