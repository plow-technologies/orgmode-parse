{-# LANGUAGE OverloadedStrings #-}

module Markup where

import           Control.Monad.Free
import           Data.Attoparsec.Text
import           Data.Either                            (isLeft, isRight, lefts,
                                                         rights)

import           Data.Monoid
import           Data.OrgMode.Parse.Attoparsec.Document
import           Data.OrgMode.Parse.Attoparsec.Time
import           Data.OrgMode.Parse.Types
import           Data.OrgMode.Parse.Types.Markup.Tokens
import           Data.Text
import qualified Data.Text                              as Text
import qualified Data.Text.IO                           as TextIO
import           Test.Tasty
import           Test.Tasty.HUnit
import           Util

import qualified Data.List                              as L



-- --------------------------------------------------
-- Markup Types
-- --------------------------------------------------

data Markup strtype next = Pre PreToken next
                         | Marker MarkerToken next
                         | Contents strtype next
                         | Border BorderToken next
                         | Body strtype next
                         | POST PostToken next
















--------------------------------------------------
-- TEST Group
--------------------------------------------------



markupTests = testGroup "all tests related to text markup" [ tokenInlineMarkupTests
                                                           , parserInlineMarkupTests]

parserInlineMarkupTests :: TestTree
parserInlineMarkupTests = testGroup "Attoparsec test inline markup parsing"
  []



tokenInlineMarkupTests :: TestTree
tokenInlineMarkupTests  = testGroup "make sure smart constructors haven't been compromised"
    [ testPreToken
    , testMarkerToken
    , testPostToken
    , testBorderToken]
  where
     testPreToken = testGroup "pre token tests" [ testCase "pre tokens are valid" validPreTokenTest]
     validPreTokenTest = assertBool "these pre tokens should be valid" ((L.null .lefts. fmap makePreToken.unpack ) preTokenList)
     testMarkerToken = testGroup "marker token tests" []
     testPostToken = testGroup "post token tests" []
     testBorderToken = testGroup "border token tests" []

