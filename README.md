# Challenge

O desafio proposto tratava-se de encontrar a quantidade de ocorrências de uma palavra em uma matriz de letras.

# Inicio

Para começar, utilizei o python para prototipar o algoritmo que resolve o problema.
Basicamente minha ideia é verificar todas as oitos direções possíveis quando encontrar a primeira letra da palavra desejada.

Inicialmente criei algumas funções específicas para cada direção mais as funções que verificam as restrições da matriz (linha e coluna).
```
def restricao_linha(i:int):
    return 0 <= i < linhas
```
```
def restricao_coluna(j:int):
    return 0 <= j < colunas
```
```
def check_horizontal_right(i:int,j:int):
    z = 1
    x = i
    y = j + 1
    word:str = matriz[i][j]
    while restricao_coluna(y) and len(word) < len(target):
        if matriz[x][y] == target[z]:
            word += matriz[x][y]
            z += 1
            y += 1
        else:
            break
    if(word == target):
        global contador
        contador += 1
```
```
def check_horizontal_left(i:int,j:int):
    z = 1
    word:str = matriz[i][j]
    x = i
    y = j - 1
    while restricao_coluna(y) and len(word) < len(target):
        if matriz[x][y] == target[z]:
            word += matriz[x][y]
            z += 1
            y -= 1
        else:
            break

    if word == target:
        global contador
        contador += 1
```
```
def check_vertical_down(i:int,j:int):
    z = 1
    x = i + 1
    y = j
    word:str = matriz[i][j]
    while restricao_linha(x) and len(word) < len(target):
        if matriz[x][y] == target[z]:
            word += matriz[x][y]
            z += 1
            x += 1
        else:
            break
    if word == target:
        global contador
        contador += 1
```
```
def check_vertical_up(i:int,j:int):
    z = 1
    word: str = matriz[i][j]
    x = i - 1
    y = j
    while restricao_linha(x) and len(word) < len(target):
        if matriz[x][y] == target[z]:
            word += matriz[x][y]
            z += 1
            x -= 1
        else:
            break
    if word == target:
        global contador
        contador += 1
```

Observando as funções percebi que apenas o valor que icrementamos as variáveis x e y mudavam (as restrições de coluna e linha podem permanecer as mesmas), logo poderíamos simplificar a solução para apenas uma função: 
```
def search_in_direction(i, j, dx, dy):
    global contador
    z = 1
    word = matriz[i][j]
    
    x = i + dx 
    y = j + dy

    while restricao_linha(x) and restricao_coluna(y) and len(word) < len(target):
        if matriz[x][y].lower() == target[z]:
            word += matriz[x][y].lower()
            z += 1
            x += dx  
            y += dy
        else:
            break
            
    if word == target:
        contador += 1
```
```
Onde dx e dy pertencem a lista [
    [0, 1], // right
    [0, -1], // left
    [1, 0], // down
    [-1, 0], // up
    [1, 1], // down-right
    [1, -1], // down-left
    [-1, 1], // up-right
    [-1, -1], // up-left
  ]
```
Em dart nossa solução se torna:

```
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
  ```



