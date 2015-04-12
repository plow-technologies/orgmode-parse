-----------------------------------------------------------------------------
-- |
-- Module      :  Data.OrgMode.Parse.Attoparsec.Section
-- Copyright   :  © 2015 Parnell Springmeyer
-- License     :  All Rights Reserved
-- Maintainer  :  Parnell Springmeyer <parnell@digitalmentat.com>
-- Stability   :  stable
--
-- Parsing combinators for org-mode sections.
----------------------------------------------------------------------------

module Data.OrgMode.Parse.Attoparsec.Document (
 parseDocument
) where

import           Control.Applicative                   ((<$>), (<*>))
import           Data.Attoparsec.Text
import           Data.Attoparsec.Types                 as TP
import           Data.OrgMode.Parse.Attoparsec.Heading
import           Data.OrgMode.Parse.Types
import           Data.Text                             (Text, pack, unlines)
import           Prelude                               hiding (unlines)

------------------------------------------------------------------------------
parseDocument :: [Text] -> TP.Parser Text Document
parseDocument otherKeywords =
  Document
    <$> (unlines <$> many' nonHeaderLine)
    <*> many' (headingBelowLevel otherKeywords 0)

nonHeaderLine :: TP.Parser Text Text
nonHeaderLine = pack <$> manyTill (notChar '*') endOfLine
