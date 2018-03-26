{-# LANGUAGE DeriveAnyClass  #-}
{-# LANGUAGE DeriveGeneric   #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DuplicateRecordFields #-}


module Types
    ( Cat(..)
    , FullCat(..)
    , RelationalCat(..)
    , Pic(..)
    , CatColor(..)
    , PicLoc(..)
    ) where

import GHC.Generics (Generic)
import Data.Aeson (ToJSON, FromJSON)

data Cat = Cat { name :: String
               , age :: Int
               , color :: CatColor
  } deriving (Eq, Show, Generic, ToJSON, FromJSON)


data FullCat = FullCat { id :: Int
                       , name :: String
                       , age :: Int
                       , color :: CatColor
  } deriving (Eq, Show, Generic, ToJSON, FromJSON)


data RelationalCat = RelationalCat
                  { id :: Int
                  , name :: String
                  , age :: Int
                  , color :: CatColor
                  , pics :: [Pic]
  } deriving (Eq, Show, Generic, ToJSON, FromJSON)


data Pic = Pic { location :: PicLoc
               , popularity :: Int
               , catId :: Int
  } deriving (Eq, Show, Generic, ToJSON, FromJSON)

data CatColor = DottedBrown | StripedBrown | Black deriving (Show, Read, Eq, Generic, ToJSON, FromJSON)
data PicLoc = EastCoast | Riviera | Narnia deriving (Show, Read, Eq, Generic, ToJSON, FromJSON)
