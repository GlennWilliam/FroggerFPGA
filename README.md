# Frogger-Inspired Game
This is a classic Frogger-inspired game with two exciting features: Single Player and Multiplayer modes.

## Single Player Mode
In Single Player Mode, your mission is to guide the frog (represented by the green LED) safely to the other side of the screen. Use the following keys to control the frog's movements:

- Press Key3 to move the frog upwards.
- Press Key2 to move the frog to the left.
- Press Key1 to move the frog to the right.
- Press Key0 to move the frog downwards.

Beware! The road is filled with moving traffic represented by red LEDs. These vehicles move unpredictably, so you'll need to navigate carefully to avoid colliding with them. Although the traffic moves slower than your frog, it's still a challenge to dodge them.

The traffic patterns are randomly generated, adding an element of unpredictability and excitement to the game.

You need to successfully guide your frog across the road and reach the other side three times to win the game. Each successful crossing earns you a point, which is displayed on the HEX9 segment display.

If your frog collides with any of the traffic, it will respawn back to the starting point, and you'll need to try crossing the road again.

Use SW9 to reset the game.

![image](https://github.com/GlennWilliam/FroggerFPGA/assets/121201497/d3cd7557-f495-4f2a-80b4-1ffa76f27a17)

Looks of the game of single player mode


## 2-Player Mode
Toggle SW1 to activate Multiplayer Mode. In this mode, the LED display will designate Player 1 with a green LED frog and Player 2 with a yellow LED frog. Players can only move their frogs upwards and to the left.

### Player 1 Controls:

- Press Key3 to move upward.
- Press Key2 to move left.

### Player 2 Controls:

- Press Key1 to move upward.
- Press Key0 to move left.

The objective remains unchanged: guide your frog safely to the other side without being hit by oncoming traffic. However, in this mode, you must race against the other player to see who can score three points first. The winner will be shown on an LED board. 

The HEX0 displays the Player 2’s points, and HEX9 displays the Player 1’s points.

If your frog collides with any of the traffic, it will respawn back to the starting point, and you'll need to try crossing the road again.

Use SW9 to reset the game.

![image](https://github.com/GlennWilliam/FroggerFPGA/assets/121201497/180121b7-f9bf-46a4-8d1b-6c55d1a57d53)

Looks of the game of the 2-Player mode

![image](https://github.com/GlennWilliam/FroggerFPGA/assets/121201497/98550101-6e34-4981-9cde-97beb1a38726)

Player 1 wins once they frog has crossed the road 3 times

![image](https://github.com/GlennWilliam/FroggerFPGA/assets/121201497/70405716-723e-41b7-b545-03892bade3e1)

Player 2 wins once they frog has crossed the road 3 times






