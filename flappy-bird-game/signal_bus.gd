extends Node

# Singleton - every node in the game can emit and recieve these signals
# This allows nodes from different scenes to communicate with each other

signal bird_hit_pipe
signal crashed
signal point_scored
signal startgame
