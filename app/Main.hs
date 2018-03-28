module Main where

import Lib (app)
import Network.Wai.Handler.Warp (run)
import DB

main :: IO ()
main = do
    pool <- createPool
    migrate pool
    run 8080 $ app pool

