{-# LANGUAGE OverloadedStrings #-}

module Markup where

import           Data.Attoparsec.Text
import           Data.Monoid
import           Data.Text
import qualified Data.Text                              as Text
import qualified Data.Text.IO                           as TextIO
import           Test.Tasty
import           Test.Tasty.HUnit

import           Data.OrgMode.Parse.Attoparsec.Document
import           Data.OrgMode.Parse.Attoparsec.Time
import           Data.OrgMode.Parse.Types
import           Util







-- --------------------------------------------------
-- Markup Types
-- --------------------------------------------------

















--------------------------------------------------
-- TEST Group
--------------------------------------------------

parserInlineMarkupTests :: TestTree
parserInlineMarkupTests = testGroup "Attoparsec test inline markup parsing"
  []


