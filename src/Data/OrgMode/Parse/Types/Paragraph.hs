
{- |
Module      : Data.OrgMode.Parse.Markup
Description : Paragraph Parsing modified to fit into the overall orgmode-parse framwork


Paragraph is defined in the standard orgmode grammar as:

--------------------------------------------------
Paragraphs are the default element, which means that any unrecognized
  context is a paragraph.

  Empty lines and other elements end paragraphs.

  Paragraphs can contain every type of object.

--------------------------------------------------


However, this definition makes little sense in the context of the nested structure of the types in this package.

Instead, paragraph now contains every object not already defined by other parts of the document parser.

namely:

  • [paragraphs],
  • [table cells],
  • [table rows], which can only contain table cell objects,
  • [verse blocks].

| -}

module Data.OrgMode.Parse.Types.Paragraph () where

import           Control.Comonad.Cofree
import           Data.OrgMode.Parse.Types.Markup

-- data ParagraphExpr strtype next = ParagraphPlainText strtype
--                                   | ParagraphMarker





