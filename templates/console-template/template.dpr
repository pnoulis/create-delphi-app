program ~app_name~;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  ~pas_basename~ in '~rel_pas_path~';

begin
  try
    { TODO -oUser -cConsole Main : Insert code here }
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
