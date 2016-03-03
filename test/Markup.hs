{-# LANGUAGE OverloadedStrings   #-}
{-# LANGUAGE RankNTypes          #-}
{-# LANGUAGE ScopedTypeVariables #-}
module Markup where

import           Control.Monad.Free
import           Data.Attoparsec.Text
import           Data.Either                            (isLeft, isRight, lefts,
                                                         rights)

import qualified Data.List                              as L
import           Data.Monoid
import           Data.OrgMode.Parse.Attoparsec.Document
import           Data.OrgMode.Parse.Attoparsec.Time
import           Data.OrgMode.Parse.Types
import           Data.OrgMode.Parse.Types.Markup.Tokens
import           Data.Text
import qualified Data.Text                              as Text
import qualified Data.Text.IO                           as TextIO
import           Test.QuickCheck
import           Test.Tasty
import           Test.Tasty.HUnit
import           Test.Tasty.QuickCheck
import           Util



-- --------------------------------------------------
-- Markup Types
-- --------------------------------------------------

data Markup strtype next = Pre PreToken next
                         | Marker MarkerToken next
                         | Contents strtype next
                         | Border BorderToken next
                         | Body strtype next
                         | Post PostToken

exampleMarkup strContents strBody = pre
  where
    pre = (Pre "(" marker)
    marker = (Marker "*"  contents)
    contents = (Contents strContents borderStart)
    borderStart = (Border "|" body )
    borderEnd = (Border "/" markerEnd)
    body = (Body strBody borderEnd)
    markerEnd = (Marker "*" parenPost)
    parenPost = Post ")"








--------------------------------------------------
-- TEST Group
--------------------------------------------------



markupTests :: TestTree
markupTests = testGroup "all tests related to text markup" [ tokenInlineMarkupTests
                                                           , parserInlineMarkupTests]

parserInlineMarkupTests :: TestTree
parserInlineMarkupTests = testGroup "Attoparsec test inline markup parsing"
  []




-- Test tokens to ensure assumptions about token contents hold
tokenInlineMarkupTests :: TestTree
tokenInlineMarkupTests  = testGroup "make sure smart constructors haven't been compromised"
    [ testPreToken
    , testMarkerToken
    , testPostToken
    , testBorderToken]
  where


     testPreToken = testGroup "pre token tests" [ testCase "pre tokens are valid" validPreTokenTest]
     validPreTokenTest = assertBool "these pre tokens should be valid" ((L.null .lefts. fmap makePreToken.unpack ) preTokenList)



     testMarkerToken = testGroup "marker token tests" [testCase "marker tokens are valid" validMarkerTokenTest]
     validMarkerTokenTest = assertBool "these marker tokens should be valid" ((L.null .lefts. fmap makeMarkerToken.unpack ) markerTokenList)



     testPostToken = testGroup "post token tests" [testCase "post tokens are valid" validPostTokenTest]
     validPostTokenTest = assertBool "these post tokens are valid" ((L.null .lefts. fmap makePostToken .unpack ) postTokenList)



     testBorderToken = testGroup "border token tests" [testCase "border tokens are valid" validBorderTokenTest]
     validBorderTokenTest = assertBool "these border tokens are NOT valid" ((L.null .rights. fmap makeBorderToken .unpack ) borderTokenList)





