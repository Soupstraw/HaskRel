{-# LANGUAGE DataKinds, TemplateHaskell #-}

{- | Data definition for HList record based suppliers and parts database. -}

module SuppliersPartsDB.Definition where

import Data.HList.CommonMain
import Database.HaskRel.Relational.Definition
import Database.HaskRel.Relational.Variable

dbPath = "SuppliersPartsDB/"
--dbPath = "examples/SuppliersPartsDB/"

-- Attributes

type SNO    = Attr "sno"    String
type SName  = Attr "sName"  String
type Status = Attr "status" Integer
type City   = Attr "city"   String

makeLabels6 ["sno","sName","status","city"]
{- Expands to:
sno = Label :: Label "sno"
sName = Label :: Label "sName"
status = Label :: Label "status"
city = Label :: Label "city"

Which is what one must append to "let " to do the same in GHCi.
-}

-- Tagged value/attribute constructors. These are convenient to have since the label names collide with the label functions when punning, which is a particular nuisance when using 'extend' to alter an attribute:
_sno a = sno .=. a :: SNO
_sName a = sName .=. a :: SName
_status a = status .=. a :: Status
_city a = city .=. a :: City



type PNO    = Attr "pno"    String
type PName  = Attr "pName"  String
type Color  = Attr "color"  String
type Weight = Attr "weight" Rational

makeLabels6 ["pno","pName","color","weight"]

_pno a = pno .=. a :: PNO
_pName a = pName .=. a :: PName
_color a = color .=. a :: Color
_weight a = weight .=. a :: Weight


type QTY    = Attr "qty"    Integer

makeLabels6 ["qty"]

_qty a = qty .=. a :: QTY


-- Types. Header types in relational theory, of either relations or tuples.
type S  = '[SNO, SName, Status, City]
type SP = '[SNO, PNO, QTY]
type P  = '[PNO, PName, Color, Weight, City]


-- "Relvar S" could be used instead, but when doing ":t s" it's nicer to list the attributes.
s  :: Relvar '[SNO, SName, Status, City]
s   = Relvar ( dbPath ++ "S.rv" )
sp :: Relvar '[SNO, PNO, QTY]
sp  = Relvar ( dbPath ++ "SP.rv" )
p  :: Relvar '[PNO, PName, Color, Weight, City]
p   = Relvar ( dbPath ++ "P.rv" )

