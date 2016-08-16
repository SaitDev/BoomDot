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
    Timer3: TTimer;
    Timer4: TTimer;
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormShow(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure Image3Click(Sender: TObject);
    procedure Image4Click(Sender: TObject);
    procedure Image5Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure Timer3Timer(Sender: TObject);
    procedure Timer4Timer(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  PlayScreen: TPlayScreen;

implementation

{$R *.lfm}

uses Main;

{ TPlayScreen }

var
  targetSpeed, dotSpeed, score: Integer;
  targetToLeft: Boolean;
  backgroudSpeed, backgroupTop, dropDownSpeed: Real;


 // ====================
 // Target's moving loop

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

// ============
// Player shots

procedure TPlayScreen.Timer2Timer(Sender: TObject);
var
  distance : Real;
begin
  Image5.Top:=Image5.Top-dotSpeed;
  distance:= sqrt(sqr(Image5.Left+16 - (Image4.Left+24))
             + sqr(Image5.Top + 16 - (Image4.Top+24)));
  // Ghi điểm / Scored
  if distance <= 40 then
  begin
    //Image5.Top:=425;
    Timer2.Enabled:=False;
    sndPlaySound('Sounds\Scored.wav',SND_ASYNC or SND_NODEFAULT);
    backgroudSpeed:=20;
    dotSpeed:=15;
    Image4.Hide;
    Timer1.Enabled:=False;
    Timer3.Enabled:=True;
    Inc(score);
    Label1.Caption:=IntToStr(score);
    Image4.Top:=200 + Random(150);
  end
  // Bắn hụt / Missed
  else if Image5.Top<=26 then
    begin
      Timer2.Enabled:=False;
      ShowMessage('Game Over!');
      score:=0;
      Label1.Caption:='0';
      Image5.Top:=425;
    end;
end;

// =====================================
// Background moving, player auto moving

procedure TPlayScreen.Timer3Timer(Sender: TObject);
begin
  if dotSpeed>1 then
  begin
    if Image5.Top>=420 then dotSpeed:=3
    else if Image5.Top>=400 then dotSpeed:=5;
    if Image5.Top+dotSpeed>=430 then
    begin
      dotSpeed:=0;
      backgroudSpeed:=0.4;
      Image5.Top:=430;
      Image4.Top:=150 + Random(150);
      Image4.Left:=30+Random(290);
      Timer3.Enabled:=False;
      dropDownSpeed:=6.5;
      Image4.Show;
      Timer1.Enabled:=True;
      Timer4.Enabled:=True;
    end
    else Image5.Top:=Image5.Top+dotSpeed;
  end;
  backgroupTop:=backgroupTop+backgroudSpeed;
  Image1.Top:=round(backgroupTop);
  if Image1.Top>=0 then backgroupTop:=-110;
  if backgroudSpeed > 1 then backgroudSpeed-=1;
end;

// ==============
// Target come in

procedure TPlayScreen.Timer4Timer(Sender: TObject);
begin
  if dropDownSpeed>=1 then
  begin
    Image4.Top:=Image4.Top + round(dropDownSpeed);
    dropDownSpeed-= 0.5;
  end
  else begin
      Timer4.Enabled:=False;
  end;
end;

// ===========
// Game opened

procedure TPlayScreen.FormShow(Sender: TObject);
begin
   targetSpeed:=4;
   dotSpeed:=10;
   score:=0;
   backgroupTop:=-110;
   backgroudSpeed:=22;
   Randomize;
end;

procedure TPlayScreen.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  MainWindow.Close;
end;

// ==================
// Background clicked

procedure TPlayScreen.Image1Click(Sender: TObject);
begin
  dotSpeed:=10;
  Timer2.Enabled:=True;
end;

// ===========
// Top clicked

procedure TPlayScreen.Image2Click(Sender: TObject);
begin
  Image1Click(Image1);
end;

// ==============
// Bottom clicked

procedure TPlayScreen.Image3Click(Sender: TObject);
begin
  Image1Click(Image1);
end;

// ==============
// Target clicked

procedure TPlayScreen.Image4Click(Sender: TObject);
begin
  Image1Click(Image1);
end;

// ==============
// Player clicked

procedure TPlayScreen.Image5Click(Sender: TObject);
begin
  Image1Click(Image1);
end;

end.

