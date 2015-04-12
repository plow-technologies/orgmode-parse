-----------------------------------------------------------------------------
-- |
-- Module      :  Data.OrgMode.Parse.Attoparsec.Markup.Table
-- Copyright   :  © 2015 Parnell Springmeyer
-- License     :  All Rights Reserved
-- Maintainer  :  Parnell Springmeyer <parnell@digitalmentat.com>
-- Stability   :  stable
--
-- Parsing combinators for transforming org-mode table markup in text
-- into a free monadic AST.
--
-- This specific feature of org-mode is very powerful but also quite
-- the rabbit hole since calc is a full featured table / spreadsheet
-- editing and computation mode. I may only be supporting parsing of
-- the tables and not executing calc formulas.
--
-- > |------------+---------------|
-- > | Column 1   | Column 2      |
-- > |------------+---------------|
-- > | Some value | Another value |
----------------------------------------------------------------------------

{-# LANGUAGE OverloadedStrings #-}

module Data.OrgMode.Parse.Attoparsec.Markup.Table where


