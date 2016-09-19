uses
  graphABC;



const
  Screen_w: integer = 400;
  SCR_SIZE: integer = 400;
  B_Color: Color = RGB(100, 100, 200);
   B_Color_Finish = RGB(155, 155, 155);
  T_COLOR: Color = RGB(200, 200, 64);
  FLD_SIZE: integer = 4;
  B_Size: integer = round(SCR_SIZE / FLD_SIZE);

var
  field: array[0..(FLD_SIZE - 1)] of array[0..(FLD_SIZE - 1)] of integer;

procedure swapCells(var c1: integer; var c2: integer);
begin
  var tmp: integer := c1;
  c1 := c2;
  c2 := tmp;
  
end;

procedure createField();
begin
  for var i: integer := 0 to FLD_SIZE - 1 do
  begin
    for var j: integer := 0 to FLD_SIZE - 1 do
    begin
      field[i][j] := i * FLD_SIZE + j;     
    end;    
  end;
  
  for var i: integer := 1 to 100 do
  begin
    var f_row: integer := random(0, FLD_SIZE - 1);
    var f_col: integer := random(0, FLD_SIZE - 1);
    var s_row: integer := random(0, FLD_SIZE - 1);
    var s_col: integer := random(0, FLD_SIZE - 1);
    
    swapCells(field[f_row][f_col], field[f_row][f_col]);
    
  end;    
  
end;

 
function isWin:boolean;
begin
  isWin:=false;
  var i: integer;
  for i := 0 to FLD_SIZE - 2 do
    for var j: integer := 0 to FLD_SIZE - 1 do
      if field[i][j]<>((i*4)+j+1) then Exit;
  i:=FLD_SIZE - 1;    
  for var j: integer := 0 to FLD_SIZE - 2 do
      if field[i][j]<>((i*4)+j+1) then Exit;
  isWin:=true;
end;

procedure drawField();
begin
  Window.Clear();
    var s:string := '';
  if isWin() then begin 
     s:='FINISH! Game over!';
     OnMouseDown := nil;
     SetBrushColor(B_Color_Finish);
  end;
  for var i: integer := 0 to FLD_SIZE - 1 do
  begin
    for var j: integer := 0 to FLD_SIZE - 1 do
    begin
      
      if(field[i][j] > 0) then
      begin
        rectangle(j * B_SIZE, i * B_SIZE, j * B_SIZE + B_SIZE, i * B_SIZE + B_SIZE);
        
        var out_string: string := IntToStr(field[i][j]);
        
        var t_w:= TextWidth(out_string);
        var t_h:= TextHeight(out_string);
        
        
        TextOut(j * B_SIZE + (B_SIZE - t_w) div 2, i * B_SIZE + (B_SIZE - t_h) div 2, out_string);
        
      end;
    end;  
  end;
  Redraw();
end;

procedure onMouse(x: integer; y: integer; mb: integer);


begin
  writeln(floor(x / B_SIZE), ' ', floor(y / B_SIZE), ' ', mb);
  var row: integer := Floor(y / B_SIZE);
  var col: integer := Floor(x / B_SIZE);
  
  if(field[row][col] <> 0) then 
  begin
    
    if (row - 1 >= 0) and (field[row - 1][col] = 0) then 
    begin
      swapCells(field[row][col], field[row - 1][col]);
    end else if (col + 1 < FLD_SIZE) and (field[row][col + 1] = 0) then
    begin
      swapCells(field[row][col], field[row][col + 1]);
    end else if (row + 1 < FLD_SIZE) and (field[row + 1][col] = 0) then
    begin
      swapCells(field[row][col], field[row + 1][col]);
    end else if (col - 1 < FLD_SIZE) and (field[row][col - 1] = 0) then
    begin
      swapCells(field[row][col], field[row][col - 1]);
    end;
    drawField();
    
  end;
end;

begin
  window.IsFixedSize := true;
  window.Width := SCR_SIZE;
  window.Height := SCR_SIZE;
  Window.Title := 'Tag game';
  OnMouseDown := OnMouse;
  LockDrawing();
  SetBrushColor(B_COLOR);
  
  Font.Color := T_COLOR;
  Font.Size := 24;
  
  createField();
  
  drawField();
  
end.