{-# LANGUAGE OverloadedStrings #-}
----------------------------------------------------------------
-- https://github.com/yi-editor/yi/tree/master/example-configs
-- edited by M.W.
--

import           Data.Monoid
import           Yi hiding (super)
import qualified Yi.Keymap.Vim as V2
import qualified Yi.Keymap.Vim.Common as V2
import qualified Yi.Keymap.Vim.Utils as V2
import qualified Yi.Mode.Haskell as Haskell
import qualified Yi.Rope as R

myKeymapSet :: KeymapSet
myKeymapSet = V2.mkKeymapSet $ V2.defVimConfig `override` \super this ->
    let eval = V2.pureEval this
    in super {
          -- Here we can add custom bindings.
          -- See Yi.Keymap.Vim.Common for datatypes and
          -- Yi.Keymap.Vim.Utils for useful functions like mkStringBindingE

          -- In case of conflict, that is if there exist multiple bindings
          -- whose prereq function returns WholeMatch,
          -- the first such binding is used.
          -- So it's important to have custom bindings first.
          V2.vimBindings = myBindings eval ++ V2.vimBindings super
        }

myBindings :: (V2.EventString -> EditorM ()) -> [V2.VimBinding]
myBindings eval =
    let nmap x y = V2.mkStringBindingE V2.Normal V2.Drop (x, y, id)
        imap x y = V2.VimBindingE (\evs state -> case V2.vsMode state of
                                    V2.Insert _ ->
                                         fmap (const (y >> return V2.Continue))
                                              (evs `V2.matchesString` x)
                                    _ -> V2.NoMatch)
    in [ nmap "<C-h>" previousTabE
       , nmap "<C-l>" nextTabE
       , nmap " " (eval ":nohlsearch<CR>")
       , nmap ";" (eval ":")
       , nmap "<F1>" (withCurrentBuffer readCurrentWordB >>= printMsg . R.toText)
       , nmap "<F3>" (withCurrentBuffer deleteTrailingSpaceB)
       , nmap "<F4>" (withCurrentBuffer moveToSol)
       , imap "<Home>" (withCurrentBuffer moveToSol)
       , imap "<End>" (withCurrentBuffer moveToEol)
       ]

myModes :: [AnyMode]
myModes = [
         AnyMode Haskell.fastMode {
             -- Disable beautification
             modePrettify = const $ return ()
         }
    ]

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

myConfig = defaultVimConfig

myFrontEnd = (startFrontEnd myConfig)

myUIConfig = (configUI myConfig)
  {
    configFontSize = Just 13,
    configTheme = darkBlueTheme,
    configWindowFill = '~'
  }

main :: IO ()
main = yi $ myConfig {
    defaultKm = myKeymapSet,
    modeTable = fmap (onMode prefIndent) (myModes ++ modeTable myConfig),
    startFrontEnd = myFrontEnd,
    configRegionStyle = Exclusive,
    configKillringAccumulate = True,
    configCheckExternalChangesObsessively = False,
    configUI = myUIConfig,
    startActions = startActions myConfig
}
