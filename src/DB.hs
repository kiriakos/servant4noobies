{-# LANGUAGE EmptyDataDecls             #-}
{-# LANGUAGE FlexibleContexts           #-}
{-# LANGUAGE GADTs                      #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE MultiParamTypeClasses      #-}
{-# LANGUAGE OverloadedStrings          #-}
{-# LANGUAGE QuasiQuotes                #-}
{-# LANGUAGE TemplateHaskell            #-}
{-# LANGUAGE TypeFamilies               #-}

module DB where

import System.Directory (createDirectoryIfMissing)
import Control.Monad.Logger (runNoLoggingT)
-- import Database.Persist
import qualified Database.Persist.Sqlite as S
import Database.Persist.TH
import Types (CatColor, PicLoc)
import Data.Text (Text, pack)
import System.FilePath ((</>))

share [mkPersist sqlSettings, mkMigrate "migrateAll"] [persistLowerCase|
Cat
    name String
    age Int
    color CatColor
    deriving Show
Pic
    location PicLoc
    popularity Int
    catId Int
    deriving Show
|]


type ConnectionPool =
    S.ConnectionPool

dataDir = ".data"
dbPath = pack $ dataDir </> "sqlite.db"
          
createPool :: IO S.ConnectionPool
createPool =
    do
        createDirectoryIfMissing True $ dataDir
        runNoLoggingT $ S.createSqlitePool dbPath 2


migrate :: S.ConnectionPool -> IO ()
migrate =
    S.runSqlPool $ S.runMigration migrateAll

          
          
-- main :: IO ()
-- main = runSqlite ":memory:" $ do
--     runMigration migrateAll
-- 
--    johnId <- insert $ Person "John Doe" $ Just 35
--    janeId <- insert $ Person "Jane Doe" Nothing
--
--    insert $ BlogPost "My fr1st p0st" johnId
--    insert $ BlogPost "One more for good measure" johnId
--
--    oneJohnPost <- selectList [BlogPostAuthorId ==. johnId] [LimitTo 1]
--    liftIO $ print (oneJohnPost :: [Entity BlogPost])
--
--    john <- get johnId
--    liftIO $ print (john :: Maybe Person)
--
--    delete janeId
--    deleteWhere [BlogPostAuthorId ==. johnId]
--
