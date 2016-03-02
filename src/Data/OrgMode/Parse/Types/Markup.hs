{-
5.13 Text Markup
────────────────

  Text markup follows the pattern:

  ╭────
  │ PRE MARKER CONTENTS MARKER POST
  ╰────

  PRE is a whitespace character, `(', `{' ~’~ or a double quote.  It can
  also be a beginning of line.

  MARKER is a character among `*' (bold), `=' (verbatim), `/' (italic),
  `+' (strike-through), `_' (underline), `~' (code).

  CONTENTS is a string following the pattern:

  ╭────
  │ BORDER BODY BORDER
  ╰────

  BORDER can be any non-whitespace character excepted ~,~, ~’~ or
  a double quote.

  BODY can contain contain any character but may not span over more than
  3 lines.

  BORDER and BODY are not separated by whitespaces.

  CONTENTS can contain any object encountered in a paragraph when markup
  is “bold”, “italic”, “strike-through” or “underline”.

  POST is a whitespace character, `-', `.', ~,~, `:', `!', `?', ~’~,
  `)', `}' or a double quote.  It can also be an end of line.

  PRE, MARKER, CONTENTS, MARKER and POST are not separated by whitespace
  characters.

                                  ―――――

        All of this is wrong if `org-emphasis-regexp-components'
        or `org-emphasis-alist' are modified.

        This should really be simplified and made persistent
        (i.e. no defcustom allowed).  Otherwise, portability and
        parsing are jokes.

        Also, CONTENTS should be anything within code and verbatim
        emphasis, by definition.  — ngz




-}


module OrgMode.Parse.Types.Markup () where

