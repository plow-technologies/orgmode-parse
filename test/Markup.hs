{-# LANGUAGE OverloadedStrings #-}

module Markup where

import           Data.Attoparsec.Text
import           Data.Monoid
import           Data.Text
import qualified Data.Text                              as Text
import qualified Data.Text.IO                           as TextIO
import           Test.Tasty
import           Test.Tasty.HUnit

import           Control.Monad.Free
import           Data.OrgMode.Parse.Attoparsec.Document
import           Data.OrgMode.Parse.Attoparsec.Time
import           Data.OrgMode.Parse.Types
import           Util






-- --------------------------------------------------
-- Markup Types
-- --------------------------------------------------

type Token = Char
type PreToken = Char
type MarkerToken = Char
type BorderToken = Char
data Markup strtype next = Pre PreToken next
                         | Marker Token next
                         | Contents strtype next
                         | Border BorderToken next
                         | Body strtype next
                         | POST PostToken next
















--------------------------------------------------
-- TEST Group
--------------------------------------------------

parserInlineMarkupTests :: TestTree
parserInlineMarkupTests = testGroup "Attoparsec test inline markup parsing"
  []


