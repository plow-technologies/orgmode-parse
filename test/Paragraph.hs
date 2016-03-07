{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RankNTypes        #-}
module Paragraph () where

import           Control.Monad.Free
import           Data.OrgMode.Parse.Types.Paragraph
import           Data.OrgMode.Parse.Types.Paragraph


exampleParagraph :: Free (ParagraphExpr [Char]) a
exampleParagraph = plainText
  where
    plainText = Free (ParagraphPlainText "Here is some sample text"  markupText)
    markupText = Free (ParagraphMarkup (exampleMarkup "Test contents" "Test Body") paragraphTable)
    paragraphTable = Free (ParagraphTable "Here is something that isn't really a table yet"  verseBlock)
    verseBlock = Free (ParagraphVerseBlock "string" end)
    end = Free ParagraphEnd




exampleMarkup :: forall a . String -> String -> Free (Markup String) (Markup String a)
exampleMarkup stringContents stringBody = pre
  where
      pre = Free (Pre "("  marker)
      marker = Free (Marker "*" contents)
      contents = Free (Contents stringContents borderStart)
      borderStart = Free (Border "/" body)
      body = Free (Body stringBody borderEnd)
      borderEnd = Free (Border "/" markerEnd)
      markerEnd = Free (Marker "*" parenPost)
      parenPost = Free (Post ")")
