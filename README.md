# CLI Chess

A Command Line Interface (CLI) Chess game written in Ruby. This project provides a fully-functional chess game that can be played by two players through the terminal, following the standard rules of chess.

## Features

- Full chess game simulation with standard rules
- Move validation for each piece (king, queen, rook, bishop, knight, and pawn)
- Automatic detection of check and checkmate
- Turn-based play between two human players via the command line

## Getting Started

### Prerequisites

- Ruby (version 2.6 or later)
- Bundler (optional, if using Gemfile for dependencies)

### Installation

1. Clone the repository:

   ```bash
   git clone git@github.com:benzelcurry/chess.git
   ```

2. Navigate to the project directory:

  ```bash
  cd chess
  ```

3. (Optional; not actually necessary) Install any gems

  ```bash
  bundle install
  ```

### Running the game

To start a new game, run the following command:

  ```bash
  ruby lib/main.rb
  ```

Once the game starts, players can take turns entering their moves in standard chess notation (e.g. b3, e4, etc.)

