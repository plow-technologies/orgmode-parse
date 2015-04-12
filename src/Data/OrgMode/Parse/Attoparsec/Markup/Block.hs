-----------------------------------------------------------------------------
-- |
-- Module      :  Data.OrgMode.Parse.Attoparsec.Markup.Block
-- Copyright   :  © 2015 Parnell Springmeyer
-- License     :  All Rights Reserved
-- Maintainer  :  Parnell Springmeyer <parnell@digitalmentat.com>
-- Stability   :  stable
--
-- Parsing combinators for transforming org-mode source blocks in text
-- into a free monadic AST.
--
-- > #+BEGIN_QUOTE
-- > This is like a block-quote.
-- > #+END_QUOTE
--
-- > #+BEGIN_COMMENT
-- > This is a comment in org-mode.
-- > #+END_COMMENT
--
-- > #+BEGIN_SRC haskell
-- > main :: IO ()
-- > main = print "A Haskell code block"
-- > #+END_SRC
----------------------------------------------------------------------------

{-# LANGUAGE OverloadedStrings #-}

module Data.OrgMode.Parse.Attoparsec.Markup.Block where


