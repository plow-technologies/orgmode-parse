{-# LANGUAGE OverloadedStrings #-}

module Data.StructMsg.Internal.OrgMode.Parser.Elements
  ( headline
  )
where

import           Control.Applicative
import           Data.Attoparsec.Text
import           Data.Char (isAlphaNum)
import           Data.Text (Text)
import qualified Data.Attoparsec.Text as A
import qualified Data.Text            as T

import           Data.StructMsg.Internal.OrgMode.Types
import           Data.StructMsg.Internal.ParserUtils

-- | From @org-todo-keywords@
todoKeywords :: [Text]
todoKeywords = ["TODO", "DONE"]

-- | Parses an org-mode headline element
--
-- NB: This doesn't yet handle commented/quoted titles, footnote sections,
-- or archive state.
--
headline :: Parser Headline
headline =
  Headline
    <$> stars            <* skipWS
    <*> optionMaybe kw   <* skipWS
    <*> optionMaybe pri  <* skipWS
    <*> title            <* skipWS
    <*> option [] tags   <* skipWS
  <* endOfLine
  where
    stars = Depth    <$> T.length <$> takeWhile1 (== '*')       <?> "stars"
    kw    = Keyword  <$> choice (string <$> todoKeywords)       <?> "keyword"
    pri   = Priority <$> brackets (chomp (char '#' *> letter))  <?> "priority"
    title = mkt      <$> A.takeWhile (\c -> c /= ':' && neol c) <?> "title"
            where
              mkt = Title . T.unwords . T.words
    tags  = char ':' *> many1 tag                               <?> "tags"
            where
              tag     = Tag . T.pack <$> many1 tagChar <* char ':'
              tagChar = satisfy isAlphaNum <|> satisfy (`elem` "@#%_")
