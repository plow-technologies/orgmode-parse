{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module Data.StructMsg.Internal.OrgMode.Types where

import Data.Text

newtype Depth    = Depth    Int  deriving (Eq, Show)
newtype Keyword  = Keyword  Text deriving (Eq, Show)
newtype Priority = Priority Char deriving (Eq, Show)
newtype Tag      = Tag      Text deriving (Eq, Show)
newtype Title    = Title    Text deriving (Eq, Show)

-- | Represents the org-mode headline element, e.g.:
--
-- > *
-- > ** DONE
-- > *** Some e-mail
-- > **** TODO [#A] Title :tag1:tag2:
--
data Headline =
  Headline { hlDepth    :: Depth
           , hlKeyword  :: Maybe Keyword
           , hlPriority :: Maybe Priority
           , hlTitle    :: Title
           , hlTags     :: [Tag]
           }
  deriving (Eq, Show)
