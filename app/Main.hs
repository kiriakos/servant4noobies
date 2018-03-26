module Main where

import Lib (app)
import Network.Wai.Handler.Warp (run)

main :: IO ()
main = run 8080 app

