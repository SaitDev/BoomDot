unit Main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls;

type

  { TMainWindow }

  TMainWindow = class(TForm)
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Label1: TLabel;
    procedure Image2MouseEnter(Sender: TObject);
    procedure Image3Click(Sender: TObject);
    procedure Image3MouseLeave(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  MainWindow: TMainWindow;


implementation

{$R *.lfm}

{ TMainWindow }

uses Play;

procedure TMainWindow.Image2MouseEnter(Sender: TObject);
begin
  Image3.Show;
end;

procedure TMainWindow.Image3Click(Sender: TObject);
begin
  PlayScreen.Show;
  Hide;
  Image3.Hide;
end;

procedure TMainWindow.Image3MouseLeave(Sender: TObject);
begin
  Image3.Hide;
end;

end.

