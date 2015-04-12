-----------------------------------------------------------------------------
-- |
-- Module      :  Data.OrgMode.Parse.Attoparsec.Markup.List
-- Copyright   :  © 2015 Parnell Springmeyer
-- License     :  All Rights Reserved
-- Maintainer  :  Parnell Springmeyer <parnell@digitalmentat.com>
-- Stability   :  stable
--
-- Parsing combinators for transforming org-mode list markup in text
-- into a free monadic AST. This parses all the flavors, numbered,
-- unordered, nested, and checkboxed.
--
-- > - item 1
-- > - item 2
--
-- > - [ ] Checkbox 1
-- > - [X] Checkbox 2
----------------------------------------------------------------------------

{-# LANGUAGE OverloadedStrings #-}

module Data.OrgMode.Parse.Attoparsec.Markup.List where


