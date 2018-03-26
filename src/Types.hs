{-# LANGUAGE DeriveAnyClass  #-}
{-# LANGUAGE DeriveGeneric   #-}
module Types
    ( User(..)
    ) where

import GHC.Generics (Generic)
import Data.Aeson (ToJSON, FromJSON)

data User = User
  { userId        :: Int
  , userFirstName :: String
  , userLastName  :: String
  } deriving (Eq, Show, Generic, ToJSON, FromJSON)

