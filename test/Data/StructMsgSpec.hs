{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE LambdaCase #-}

module Data.StructMsgSpec (main, spec) where

import Test.Hspec

import Data.StructMsg.Internal.ParserUtils( testParserEnd )

import qualified Data.StructMsg.Internal.OrgMode.Parser as P

main :: IO ()
main = hspec spec

dummySpec, dummyParserSpec :: Spec

dummySpec = do
  describe "dummySpec" $ do
    it "should work fine" $ do
      True `shouldBe` True

dummyParserSpec = do
  describe "headline parser" $ do

    let check inp expected = do
          it ("should parse " ++ show inp) $ do
            testParserEnd P.headline inp `shouldSatisfy` \case
              Right x | x == expected -> True
              _                       -> False

    check "*\n"
      $ P.Headline (P.Depth 1) Nothing Nothing (P.Title "") []

    check "** DONE\n"
      $ P.Headline (P.Depth 2) (Just (P.Keyword "DONE")) Nothing (P.Title "") []

    check "*** Some e-mail\n"
      $ P.Headline (P.Depth 3) Nothing Nothing (P.Title "Some e-mail") []

    check "**** TODO [#A] Title :tag1:tag2:\n"
      $ P.Headline (P.Depth 4) (Just (P.Keyword "TODO")) (Just (P.Priority 'A'))
          (P.Title "Title") [P.Tag "tag1", P.Tag "tag2"]

spec :: Spec
spec = sequence_
         [ dummySpec
         , dummyParserSpec
         ]
