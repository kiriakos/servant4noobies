{-# LANGUAGE DataKinds       #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeOperators   #-}


module Lib
    ( app
    ) where

import Network.Wai
import Servant
import Fixtures (cats)
import Types (FullCat(..))
import Database.Persist (selectList, Entity(..), entityVal, entityKey, keyToValues)
import Database.Persist.Sqlite (runSqlPool, SqlBackend)
import Database.Persist.Sql (fromSqlKey)
import Control.Monad.IO.Class (liftIO)
import Control.Monad.Reader (ReaderT)

import qualified DB

type API =   "cats" :> Get '[JSON] [FullCat]
--        :<|> "cats" :> ReqBody '[JSON] Cat :> Post '[JSON] FullCat
--        :<|> "cats" :> Capture "id" Int :> ReqBody '[JSON] FullCat :> Put '[JSON] FullCat
--        :<|> "cats" :> Capture "id" Int :> DeleteNoContent '[JSON] NoContent
--        :<|> "cats" :> Capture "id" Int :> Get '[JSON] RelationalCat

server :: DB.ConnectionPool ->  Server API
server = getCats
--     :<|> createCat
--     :<|> updateCat
--     :<|> deleteCat
--     :<|> getRelCat 

    where
        getCats :: DB.ConnectionPool ->  Handler [FullCat]
        getCats pool = do
            liftIO $ actDb pool loadCats
--        createCat :: Cat -> Handler FullCat
--        updateCat :: Int -> FullCat -> Handler FullCat
--        deleteCat :: Int -> Handler NoContent
--        getRelCat :: Int -> Handler RelationalCat

loadCats :: Action [FullCat]
loadCats = do
    cats <- selectList [] []
    return $ map cat cats

actDb :: DB.ConnectionPool -> Action a -> IO a
actDb = flip runSqlPool

type Action a =
    ReaderT SqlBackend IO a

app :: DB.ConnectionPool -> Application
app pool = serve api $ server pool

api :: Proxy API
api = Proxy


cat :: Entity DB.Cat -> FullCat
cat dbCat =
    let c = entityVal dbCat
        id = fromIntegral . fromSqlKey . entityKey $ dbCat
    in FullCat id (DB.catName c) (DB.catAge c) (DB.catColor c)


