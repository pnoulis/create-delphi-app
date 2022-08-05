program ~app_name~;

uses
   Vcl.Forms,
   ~pas_basename~ in '~rel_pas_path~';

begin
   Application.Initialize;
   Application.MainFormOnTaskbar := true;
   Application.CreateForm(T~form_name~, ~form_name~);
   Application.Run;
end.
