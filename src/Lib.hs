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
import Fixtures (users)
import Types (User)

type API = "users" :> Get '[JSON] [User]

app :: Application
app = serve api server

api :: Proxy API
api = Proxy

server :: Server API
server = return users

