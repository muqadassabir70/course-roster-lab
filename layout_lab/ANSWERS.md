# Flutter Layout Lab — Answers

**Name:** Muqadas Sabir  
**Roll Number:** 04072313021

## Part A: Numeric Answers

A1: 25

A2: 6

A3: 4

A4: 60

## Part B: Written Answers

### B1: Which classes are Stateless and which are Stateful, and why?

The StatelessWidget classes in my program are `LabApp`, `HomePage`, `SettingsCard`, `Probe`, `Welcome`, `InfoPanel`, `SummaryRow`, `ShareRow`, `InfoBox`, and `StampStack`. These widgets display content or arrange other widgets without managing their own changing state. The StatefulWidget classes are `Clock`, `Tile`, and `SwapBoard`. `Clock` updates the displayed seconds using a timer, `Tile` maintains its tap count, and `SwapBoard` changes the order of tiles when the Swap button is pressed.

### B2: Widget, Element, RenderObject — which one is rebuilt on every setState and which ones are kept? What did Probe show?

When `setState()` is called, Flutter runs the relevant `build()` method again and creates updated widget configurations. Flutter can reuse the existing Element objects when the widget type and key match. The associated RenderObjects are also generally retained and updated when possible instead of being recreated on every rebuild. The `Probe` experiment showed that the Widget configuration can change while the Element and its BuildContext remain associated with the same position in the widget tree.

### B3: Explain “constraints go down, sizes go up” using your Step 7 or Step 8 example.

In Step 7, the Row passes width constraints down to its children. The `Expanded` widget uses the available leftover width and divides it according to the flex values of its children. Each child chooses a size within the constraints it receives, and that size information goes back up to its parent. The parent then positions the children. This demonstrates the Flutter layout rule: constraints go down, sizes go up, and parents set the positions.