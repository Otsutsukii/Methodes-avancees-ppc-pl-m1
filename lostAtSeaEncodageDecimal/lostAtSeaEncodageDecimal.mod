/*********************************************
 * OPL 12.10.0.0 Model
 * Author: HeiligesLicht
 * Creation Date: 5 May 2020 at 14:04:32
 *********************************************/
using CP;

// Nombre de d�placements
int k = ...;

// Range de lignes
range n = 1..8;

// Range de colonnes
range m = 1..8;
 
// La grille a ses lignes invers�es pour faire simple
 int proba[n][m] = ...;
 
// Range des d�placements
 range numMoves = 1..k;
 
// k variables => Les d�placements en question.
 dvar int+ moves[numMoves];
 
// On maximise la somme des probabilit�s pour chaque d�placement.
// Une cellule � la ligne i et colonne j peut �tre encoder comme (move = i * 10 + j)
// Donc, pour obtenir la colonne du d�placement on fait (n % 10) et pour la ligne c'est (n div 10).
 dexpr int total =sum(i in numMoves) proba[moves[i] div 10][moves[i] % 10];
 maximize total;
 
 subject to {
   // Pour chaque d�placement, on s'assure qu'on d�passe pas les limites de la grille.
   // i dans n et j dans m, pour chaque move = i * 10 + j.
   forall(i in numMoves) (moves[i] div 10) in n && (moves[i] % 10) in m;
   
   // Entre deux d�placements d1 et d2:
   // Si le d�placement est vertical: abs(d1-d2) = 10
   // Si le d�placement est horizontal: abs(d1-d2) = 1
   forall(i in numMoves: i > 1) abs(moves[i]-moves[i-1]) == 1 || abs(moves[i]-moves[i-1]) == 10;
   
   // Les d�placements sont uniques. On ne revient pas sur une cellule d�j� visit�e.
   allDifferent(moves);
 }