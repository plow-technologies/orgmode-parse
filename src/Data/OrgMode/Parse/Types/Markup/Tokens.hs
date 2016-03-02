{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE NoImplicitPrelude          #-}
{-# LANGUAGE OverloadedStrings          #-}
module OrgMode.Parse.Types.Markup.Tokens (PreToken) where
import           Data.Monoid ((<>))
import           Data.String
import           Data.Text
import           Prelude     (Bool (..), Char, Show, const, error, maybe, show,
                              ($), (++), (.), (==))

-- |   PRE is a whitespace character, `(', `{' or a double quote.
-- I took out ~’~ for now
-- IsString is defined so you can write tokens with literals
newtype PreToken = PreToken Text
  deriving (Show)
makePreToken :: Char ->  PreToken
makePreToken c = if isMatch
                    then PreToken (cons c empty)
                    else generateError

  where
    isMatch = any (== c) tokenList
    generateError = error ((show c) ++ " is not a valid PRE token, must be whitespace or " ++ ((unpack . intersperse ' ') tokenList))
    tokenList = " ({\""


instance IsString PreToken where
  fromString [] = error "no pre token given"
  fromString (c:[]) = makePreToken c
  fromString _ = error "only one character should be a pre"

