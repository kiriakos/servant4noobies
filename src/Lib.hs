{-# LANGUAGE DataKinds       #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeOperators   #-}


module Lib
    ( app
    ) where

import Data.Aeson
import Data.Aeson.TH
import Network.Wai
import Servant
import Fixtures (cats)
import Types (FullCat)

type API =   "cats" :> Get '[JSON] [FullCat]
--        :<|> "cats" :> ReqBody '[JSON] Cat :> Post '[JSON] FullCat
--        :<|> "cats" :> Capture "id" Int :> ReqBody '[JSON] FullCat :> Put '[JSON] FullCat
--        :<|> "cats" :> Capture "id" Int :> DeleteNoContent '[JSON] NoContent
--        :<|> "cats" :> Capture "id" Int :> Get '[JSON] RelationalCat

server :: Server API
server = getCats
--     :<|> createCat
--     :<|> updateCat
--     :<|> deleteCat
--     :<|> getRelCat 

    where
        getCats :: Handler [FullCat]
        getCats = return cats
--        createCat :: Cat -> Handler FullCat
--        updateCat :: Int -> FullCat -> Handler FullCat
--        deleteCat :: Int -> Handler NoContent
--        getRelCat :: Int -> Handler RelationalCat

        
     

app :: Application
app = serve api server

api :: Proxy API
api = Proxy


