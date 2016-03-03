{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE NoImplicitPrelude          #-}
{-# LANGUAGE OverloadedStrings          #-}


{-|

Tokens are correct by construction delimiters that represent targets for markup parsers

|-}
module Data.OrgMode.Parse.Types.Markup.Tokens ( PreToken,makePreToken, preTokenList
                                              , PostToken, makePostToken, postTokenList
                                              , BorderToken, makeBorderToken, borderTokenList
                                              , MarkerToken, makeMarkerToken, markerTokenList) where
import           Data.Monoid ((<>))
import           Data.String
import           Data.Text
import           Prelude     (Char, Either (..), Eq, Ord, Show, either, error,
                              id, show, ($), (++), (.), (==))















-- |   PRE is a whitespace character, `(', `{' ~’~ or a double quote.
-- IsString is defined so you can write tokens with literals
newtype PreToken = PreToken Text
  deriving (Show,Eq,Ord)





makePreToken :: Char ->  Either Text PreToken
makePreToken c = if isMatch
                    then Right $ PreToken (cons c empty)
                    else Left generateError

  where
    isMatch = any (== c) preTokenList
    generateError = pack ((show c) ++ " is not a valid PRE token, must be whitespace or " ++ ((unpack . intersperse ' ') preTokenList))

preTokenList :: Text
preTokenList = " ({\"’" <> whiteSpaceCharacters


instance IsString PreToken where
  fromString [] = error "no pre token given"
  fromString (c:[]) = either (error . unpack) (id) $ makePreToken c
  fromString _ = error "only one character should be a pre"




















-- |   POST is a whitespace character, `-', `.', ~,~, `:', `!', `?', ~’~,
--   `)', `}' or a double quote.

newtype PostToken = PostToken Text
  deriving (Show,Eq,Ord)

makePostToken :: Char -> Either Text PostToken
makePostToken c = if isMatch
                     then Right $ PostToken (cons c empty)
                     else Left generateError
  where
    isMatch = any (== c) postTokenList
    generateError = pack ((show c) ++ " is not a valid POST token, must be whitespace or " ++ ((unpack . intersperse ' ') postTokenList))


postTokenList :: Text
postTokenList = "-.,:!?’\"" <> whiteSpaceCharacters



instance IsString PostToken where
  fromString [] = error "no post token given"
  fromString (c:[]) = either (error.unpack) id $ makePostToken c
  fromString _ = error "only one character should be a post token"




















-- | BORDER can be any non-whitespace character excepted ~,~, ~’~ or a double quote.
newtype BorderToken = BorderToken Text
   deriving (Show,Eq,Ord)


makeBorderToken :: Char -> Either Text BorderToken
makeBorderToken c = if isMatch
                       then Left . pack $ ((show c ) ++ " is not a valid Border token any character except ',' and '’'  is acceptable")
                       else Right $ BorderToken (cons c empty)
  where
    isMatch = any (== c) borderTokenList

borderTokenList :: Text
borderTokenList = "’," <> whiteSpaceCharacters




instance IsString BorderToken where
  fromString [] = error "no Border Token given"
  fromString (c:[]) = either (error.unpack) id $ makeBorderToken c
  fromString _ = error "only one character should be a Border Token"










-- |MARKER is a character among `*' (bold), `=' (verbatim), `/' (italic),
-- `+' (strike-through), `_' (underline), `~' (code).

data MarkerToken = MarkerTokenBold | MarkerTokenVerbatim | MarkerTokenItalic | MarkerTokenStrikeThrough
                 | MarkerTokenUnderline | MarkerTokenCode
  deriving (Show,Ord,Eq)

makeMarkerToken :: Char -> Either Text MarkerToken
makeMarkerToken c = case c of
                      '*' -> Right MarkerTokenBold
                      '=' -> Right MarkerTokenVerbatim
                      '/' -> Right MarkerTokenItalic
                      '+' -> Right MarkerTokenStrikeThrough
                      '_' -> Right MarkerTokenCode
                      _  -> Left . pack $  ((c: []) ++ "invalid marker token, must be * = / + or _")


markerTokenList :: Text
markerTokenList = "*=/+_"


instance IsString MarkerToken where
  fromString [] = error "no marker token given"
  fromString (c:[]) = either (error.unpack) id $  makeMarkerToken c
  fromString _ = error "only one character should be a marker token"











-- | This is a list of all valid whitespace tokens.
whiteSpaceCharacters :: Text
whiteSpaceCharacters = "\n\r \t"




