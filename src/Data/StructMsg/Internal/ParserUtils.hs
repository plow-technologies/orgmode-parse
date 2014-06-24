module Data.StructMsg.Internal.ParserUtils where

import Control.Applicative
import Data.Attoparsec.Text
import Data.Char (isSpace)
import Data.Text (Text)

between :: Alternative f => f a -> f b -> f c -> f c
between open close p = open *> p <* close

brackets :: Parser a -> Parser a
brackets = between (char '[') (char ']')

-- | @chomp p@ consumes extraneous whitespace around p, yielding its result
chomp :: Parser a -> Parser a
chomp = between skipWS skipWS

-- | @neol c@ returns @True@ iff @c@ is not an EOL character.
neol :: Char -> Bool
neol = not . isEndOfLine

optionMaybe :: Alternative f => f a -> f (Maybe a)
optionMaybe = option Nothing . fmap Just

-- | Eats non-newline whitespace
skipWS :: Parser ()
skipWS = skipWhile (\c -> isSpace c && neol c) <?> "skipWS"

testParser, testParserEnd :: Parser a -> Text -> Either String a
testParser      = parseOnly
testParserEnd p = parseOnly (p <* endOfInput)
