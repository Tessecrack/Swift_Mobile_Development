//
//  main.swift
//  Tesy
//
//  Created by student on 01.10.2020.
//

import Foundation
let game = TicTacToe(fieldSize: 9)
game.delegate = TicTacToeStepper()
print("Ivan: X")
print("Sirozu: 0")
game.join(player: TicTacToePlayer(name: "Ivan", type: "X"))
game.join(player: TicTacToePlayer(name: "Sirozu", type: "0"))

game.play()

