module Fixtures
    ( cats
    ) where

import Types (FullCat(..), CatColor(..))

cats :: [FullCat]
cats = [ FullCat 1 "Fuzzy McFuzzboots" 8 DottedBrown
       , FullCat 2 "Bella Furrball" 12 Black
       , FullCat 3 "Tiga Foots" 10 StripedBrown 
       ] 
