
#eval 1+2
#eval 1+2*4
#eval String.append "Hello," "Lean"
#eval String.append "great " (String.append "oak " "tree")
/- parenthese is necessary here, otherwise the type would be mismatched-/
#eval String.append (String.append "A" "B") "C"
/- Lean is a expression-oriented functional language
so that in Lean there's no condition statements, only condition expressions-/
/-String.append "it is " (if 1 > 2 then "yes" else "no")
===>
String.append "it is " (if false then "yes" else "no")
===>
String.append "it is " "no"
===>
"it is no"-/

#eval 1-2
#eval (1 - 2 : Int)

def lean : String := "Lean"
def hello := "Hello"
#eval String.append hello (String.append " " lean)

def rain : Nat := 0
def sunny : Nat := 1
#eval rain > sunny
#eval String.append "OK " (if true then "let's go to Leopold" else "let's go to Oettingen")

def add1 (n : Nat) : Nat := n + 1
#check add1 /-retun a funtion's signature-/
#check (add1) /-return the type of a function-/

def Str : Type := String
def typedefinition : Str := "This is a String"

def NaturalNumber : Type := Nat
def thirtyEight : NaturalNumber := (38 : Nat)
/- the solution to the overload of natural numbers -/

abbrev N : Type := Nat
def thirtyNine : N := 39
#eval thirtyNine
#check thirtyNine

#check 0.0
#check 0
#check (0 : Float)

structure Point where
  x : Float
  y : Float
deriving Repr
/- Point is a new structure type-/
def origin : Point := {x := 0.0, y := 0.0}
#eval origin
#eval origin.x
#eval origin.y

def addPoints (p1 : Point) (p2 : Point) : Point :=
  {x := p1.x + p2.x, y := p1.y + p2.y}

def p1 : Point := {x := 1.2, y := 1.3}
def p2 : Point := {x := 2.2, y := 2.3}

#eval addPoints p1 p2

def zeroX(p : Point) : Point :=
 { x := 0, y := p.y}
 #eval zeroX {x :=3.5, y := 4.0}
 /- Lean doesn't have mutable state
    a fresh point is allocated with the x field pointing to the new value-/

def zeroX2(p :Point) : Point :=
{ p with x := 0}
#eval zeroX2 {x :=3.5, y :=4.0}

/-the sturcture update syntax does not modify existing values
  it creates new values that share some fields with old values-/
def fourAndThree : Point :=
  { x := 4.3, y := 3.4}
#eval fourAndThree
#eval zeroX fourAndThree
#eval zeroX2 fourAndThree

/- Every construct has a constructor.
   In Lean, a constuctor simply gather the data to be stored in the newly-allocated data structure.-/
/- By default, the constructor for a structure named S is named S.mk .
   S is a namespace qualifier, and mk is the name of the constructor itself.
-/
#check (Point.mk)
#check Point.mk 1.5 2.8
#check Point.mk 2.3 4.0/- this is not a good Lean code style-/

/- the constructor's name could be overrided-/
structure Point_constructor_name_override where
  point :: /-write it with two colons at the beginning-/
  x : Float
  y : Float
deriving Repr

/- accessor function-/
#check (Point.x)
#check (Point.y)

/- generally, the accessor notation has the form TARGET.f ARG1 ARG2 ...-/
#eval "one string".append " and another"

/- here hte function Point.modifyBoth is defined in the Point namespace
    thus it applies to both fields in a Point-/
def f (x : Float) : Float := x + 2.0
def Point.modifyBoth (f : Float → Float) (p : Point) : Point :=
  {x := f p.x, y := f p.y}
#eval fourAndThree.modifyBoth  f

--exercise
structure RectangularPrism where
  height : Float
  width : Float
  depth : Float
deriving Repr
def volume (r : RectangularPrism) : Float :=
  r.height * r.width * r.depth
def exampleRec : RectangularPrism := { height := 1.0, width := 2.0, depth := 3.0}
#eval volume exampleRec
