# Story Game - BASH Script
## Description
This is a story game in questions form, each question has a three choices *a*, *b*, and *c* there’re no rules to say this question has at most or at least a true choice, maybe there’re questions without any true choice and maybe there’re a question with more than one true choice.
## Questions and Ends in the game
All of the questions are stored in *questions.txt* with a specific pattern and all of the possible ends are stored in *ends.txt*. There are no limits to the questions and the possible ends of the game.
## Questions and Ends files structure
### Questions file
1. Question
2. Choices *a*, *b*, and *c*
3. Every choice with a colon and one letter *t* or *f* to detect if that choice is *true* or *false* then space and a message will be displayed if the player chose that choice.
4. A message will be displayed if the player has chosen two choices and both are false.
5. A number of the next question if the player's choice is true.
6. A message will be displayed if the player's answer is false *Not Required* then a colon, then the number of the next question in case the player will go back to another question or will go to another question depends on the story of the game.
* The last question must have its number in the next question if the answer is true or false.
### Ends file
* The structure of this file is very simple *number:message*, this number is the number of end message was written in the questions file.
