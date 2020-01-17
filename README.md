# MemoryGame

A Classic memory game that asks the user to match image pairs. The image set is composed of 50 images provided by Shopify through a JSON endpoint. The game has four modes:

  1: An easy mode where the user is requested to match 10 pairs (Random subset of the original image set).
  
  2: A Normal mode where the user is requested to match 20 pairs.
  
  3: A Hard mode where the user is requested to match 30 pairs.
  
  4: A Very Hard mode where the full image set of 50 images are used to fill up the game grid and the user is requested to match the 50 pairs.

Time elapsed to complete the whole grid is being tracked and compared against the best time acheived to finish the game for each mode.

The screen shots below are from the very hard mode game instance.

![](Start%20Screen.png)

Initial grid when no pairs are matched:
![](No%20Matches%20are%20made%2050%20Pairs%20VeryHard%20mode.png)

Screenshot when the grid is finished
![](Some%20Matches%20are%20made%2050%20pairs%20VeryHard%20mode.png)

Screenshot when the game is finished and all pairs are matched
![](User%20wins%20All%20Matches%20are%20made%2050%20pairs%20VeryHard%20mode.png)

A message to the player logging the time elapsed and showing best time acheived 
![](GameOver%20screen%20VeryHard%20mode.png)
