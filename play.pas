unit Play;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, mmsystem;

type

  { TPlayScreen }

  TPlayScreen = class(TForm)
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    Image5: TImage;
    Label1: TLabel;
    Timer1: TTimer;
    Timer2: TTimer;
    procedure FormShow(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure Image3Click(Sender: TObject);
    procedure Image4Click(Sender: TObject);
    procedure Image5Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  PlayScreen: TPlayScreen;

implementation

{$R *.lfm}

{ TPlayScreen }

var
  targetSpeed, dotSpeed, score: Integer;
  targetToLeft: Boolean;

procedure TPlayScreen.Timer1Timer(Sender: TObject);
begin
  if targetToLeft then
  begin
    Image4.Left:=Image4.Left-targetSpeed;
    Image1.Refresh;
    if Image4.Left<=20 then targetToLeft:=False;
  end
  else begin
    Image4.Left:=Image4.Left+targetSpeed;
    Image1.Refresh;
    if Image4.Left+32>=360 then targetToLeft:=True;
  end;
end;

procedure TPlayScreen.Timer2Timer(Sender: TObject);
var
  r : Integer;
begin
  Image5.Top:=Image5.Top-dotSpeed;
  r:= sqr(Image5.Left+16 - (Image4.Left+24))
      + sqr(Image5.Top + 16 - (Image4.Top+24));
  // Ghi điểm / Scored
  if sqrt(r) <= 40 then
  begin
    Image5.Top:=425;
    Timer2.Enabled:=False;
    sndPlaySound('Sounds\Scored.wav',SND_ASYNC or SND_NODEFAULT);
    Inc(score);
    Label1.Caption:=IntToStr(score);
    Image4.Top:=200 + Random(150);
  end
  else if Image5.Top<=26 then
    begin
      Timer2.Enabled:=False;
      ShowMessage('Game Over!');
      score:=0;
      Label1.Caption:='0';
      Image5.Top:=425;
    end;
end;

procedure TPlayScreen.FormShow(Sender: TObject);
begin
   targetSpeed:=4;
   dotSpeed:=12;
   score:=0;
   Randomize;
end;

procedure TPlayScreen.Image1Click(Sender: TObject);
begin
  Timer2.Enabled:=True;
end;

procedure TPlayScreen.Image2Click(Sender: TObject);
begin
  Image1Click(Image1);
end;

procedure TPlayScreen.Image3Click(Sender: TObject);
begin
  Image1Click(Image1);
end;

procedure TPlayScreen.Image4Click(Sender: TObject);
begin
  Image1Click(Image1);
end;

procedure TPlayScreen.Image5Click(Sender: TObject);
begin
  Image1Click(Image1);
end;

end.

