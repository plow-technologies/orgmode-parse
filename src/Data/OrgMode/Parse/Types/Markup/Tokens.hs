{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE NoImplicitPrelude          #-}
{-# LANGUAGE OverloadedStrings          #-}


{-|

Tokens are correct by construction delimiters that represent targets for markup parsers

|-}
module OrgMode.Parse.Types.Markup.Tokens ( PreToken,makePreToken
                                         , PostToken, makePostToken
                                         , BorderToken, makeBorderToken) where
import           Data.Monoid ((<>))
import           Data.String
import           Data.Text
import           Prelude     (Bool (..), Char, Eq, Ord, Show, const, error,
                              maybe, show, ($), (++), (.), (==))















-- |   PRE is a whitespace character, `(', `{' ~’~ or a double quote.
-- IsString is defined so you can write tokens with literals
newtype PreToken = PreToken Text
  deriving (Show,Eq,Ord)
makePreToken :: Char ->  PreToken
makePreToken c = if isMatch
                    then PreToken (cons c empty)
                    else generateError

  where
    isMatch = any (== c) tokenList
    generateError = error ((show c) ++ " is not a valid PRE token, must be whitespace or " ++ ((unpack . intersperse ' ') tokenList))
    tokenList = " ({\"’" <> whiteSpaceCharacters


instance IsString PreToken where
  fromString [] = error "no pre token given"
  fromString (c:[]) = makePreToken c
  fromString _ = error "only one character should be a pre"




















-- |   POST is a whitespace character, `-', `.', ~,~, `:', `!', `?', ~’~,
--   `)', `}' or a double quote.

newtype PostToken = PostToken Text
  deriving (Show,Eq,Ord)

makePostToken :: Char -> PostToken
makePostToken c = if isMatch
                     then PostToken (cons c empty)
                     else generateError
  where
    isMatch = any (== c) tokenList
    generateError = error ((show c) ++ " is not a valid POST token, must be whitespace or " ++ ((unpack . intersperse ' ') tokenList))
    tokenList = "-.,:!?’\"" <> whiteSpaceCharacters





instance IsString PostToken where
  fromString [] = error "no post token given"
  fromString (c:[]) = makePostToken c
  fromString _ = error "only one character should be a post token"




















-- | BORDER can be any non-whitespace character excepted ~,~, ~’~ or a double quote.
newtype BorderToken = BorderToken Text
   deriving (Show,Eq,Ord)


makeBorderToken :: Char -> BorderToken
makeBorderToken c = if isMatch
                       then error ((show c ) ++ " is not a valid Border token any character except ',' and '’'  is acceptable")
                       else BorderToken (cons c empty)
  where
    isMatch = any (== c) "’,"






instance IsString BorderToken where
  fromString [] = error "no Border Token given"
  fromString (c:[]) = makeBorderToken c
  fromString _ = error "only one character should be a Border Token"










-- |MARKER is a character among `*' (bold), `=' (verbatim), `/' (italic),
-- `+' (strike-through), `_' (underline), `~' (code).

data MarkerToken = MarkerTokenBold | MarkerTokenVerbatim | MarkerTokenItalic | MarkerTokenStrikeThrough
                 | MarkerTokenUnderline | MarkerTokenCode
  deriving (Show,Ord,Eq)

makeMarkerToken :: Char -> MarkerToken
makeMarkerToken c = case c of
                      '*' -> MarkerTokenBold
                      '=' -> MarkerTokenVerbatim
                      '/' -> MarkerTokenItalic
                      '+' -> MarkerTokenStrikeThrough
                      '_' -> MarkerTokenCode
                      _  -> error ((c: []) ++ "invalid marker token, must be * = / + or _")


instance IsString MarkerToken where
  fromString [] = error "no marker token given"
  fromString (c:[]) = makeMarkerToken c
  fromString _ = error "only one character should be a marker token"











-- | This is a list of all valid whitespace tokens.
whiteSpaceCharacters = "\n\r \t"




