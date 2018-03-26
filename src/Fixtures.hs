module Fixtures
    ( users
    ) where

import Types (User(..))

users :: [User]
users = [ User 1 "Isaac" "Newton"
        , User 2 "Albert" "Einstein"
        ]
