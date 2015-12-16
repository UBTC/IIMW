----------------------------------------------------------------
-- https://github.com/yi-editor/yi/blob/master/yi-contrib/src/Yi/Config/Users/
--                                             Jeff & Michal's configurations
-- edited by MogeiWang
--

import Yi
import Yi.Keymap.Vim
import qualified Yi.Keymap.Vim2 as V2
import qualified Yi.Keymap.Vim2.Common as V2
import qualified Yi.Keymap.Vim2.Utils as V2


----------------------------------------------------------------
--
-- myKeymap = (defaultKm myConfig)
-- ^^^ olds --- imported now
--
defaultSearchKeymap :: Keymap
defaultSearchKeymap = do
    Event (KASCII c) [] <- anyEvent
    write (isearchAddE [c])

-- See Yi.Keymap.Vim2.Common for datatypes and
-- Yi.Keymap.Vim2.Utils for useful functions like mkStringBindingE
-- file:///usr/share/doc/libghc-yi-doc/html/src/Yi-Keymap-Vim2-*.html
-- https://hackage.haskell.org/package/yi-0.8.1/docs/src/Yi-Keymap-Vim2-*.html
--
myKeymap :: KeymapSet
myKeymap = V2.mkKeymapSet $ V2.defVimConfig `override` \super this ->
    let eval = V2.pureEval this
    in super { V2.vimBindings = myBindings eval ++ V2.vimBindings super }

myBindings :: (String -> EditorM ()) -> [V2.VimBinding]
myBindings eval =
    let nmap  x y = V2.mkStringBindingE V2.Normal V2.Drop (x, y, Yi.id)
        imap  x y = V2.VimBindingE (\evs state -> case V2.vsMode state of
                                     V2.Insert _ -> evs `V2.matchesString` x
                                     _ -> V2.NoMatch)
                                   (\_evs -> y >> return V2.Continue)
        nmap'  x y = V2.VimBindingY prereq (\_ -> y >> return V2.Drop)
          where prereq _ vs | V2.vsMode vs /= V2.Normal = V2.NoMatch
                prereq evs _ = evs `V2.matchesString` "D"
    in [
         nmap  "<C-h>" previousTabE
       , nmap  "<C-l>" nextTabE
       , nmap  " " (eval ":nohlsearch<CR>")
       , nmap  ";" (eval ":")
       , imap  "<Home>" (withBuffer0 moveToSol)
       , imap  "<End>"  (withBuffer0 moveToEol)
       ]


----------------------------------------------------------------
--
myConfig = defaultConfig

myFrontEnd = (startFrontEnd myConfig)
myStartAction = [makeAction (maxStatusHeightA Yi.%= 20 :: EditorM ())]
myUIConfig = (configUI myConfig)
  {
    configFontSize = Just 13,
    configTheme = darkBlueTheme,
    configWindowFill = '~'
  }


----------------------------------------------------------------
--
main = yi $ myConfig
  {
    modeTable = fmap (onMode prefIndent) (modeTable myConfig),
    defaultKm = myKeymap,
    startFrontEnd = myFrontEnd,
    configRegionStyle = Exclusive,
    configKillringAccumulate = True,
    configCheckExternalChangesObsessively = True,
    configUI = myUIConfig,
    startActions = myStartAction
  }


----------------------------------------------------------------
-- Softtabs of 2 characters for Berkeley coding style, if not editing makefile.
prefIndent :: Mode syntax -> Mode syntax
prefIndent m = if modeName m == "Makefile"
                 then m
                 else m {
        modeIndentSettings = IndentSettings
            {
                expandTabs = True,
                shiftWidth = 2,
                tabSize    = 2
            }
        }
