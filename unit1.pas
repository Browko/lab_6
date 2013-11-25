unit Unit1;                                   {v1.0}

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, TAGraph, TASeries, Forms, Controls, Graphics,
  Dialogs, StdCtrls;

type

  TForm1 = class(TForm)
    Button1: TButton;
    Chart1: TChart;
    Chart1LineSeries1: TLineSeries;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);

  end;

  function Func(x:real):real;


var
  Form1: TForm1;
  F:Text;

implementation

{$R *.lfm}

function Func(x:real):real;
begin
  result:=(sqr(x)*x)-sqr(x)-9.5;
end;

procedure TForm1.Button1Click(Sender: TObject);
var a,b,c,x,i,Eps:real;
begin
  AssignFile(F,'lab4.txt');
  Rewrite(F);
  a:=StrToFloat(Edit1.Text);
  i:=a;
  b:=StrToFloat(Edit2.Text);
  Eps:=StrToFloat(Edit3.Text);
  if Func(a)*Func(b)<0
   then
    begin
     repeat
       c:=(a+b)/2;
       Memo1.Lines.add('x='+FloatToStr(c));
       Memo1.Lines.add('F(x)='+FloatToStr(Func(c)));
       Chart1LineSeries1.AddXY(c,Func(c),'',clgreen);
       if Func(a)*Func(c)<=0
         then b:=c
         else a:=c;
      until (b-a)<Eps;
      x:=(a+b)/2;
    end
   else x:=a-1;
  if x<a
    then showmessage('На данном интервале корней нет!')
    else showmessage('x='+FloatToStr(x));
  CloseFile(F);
end;

end.


