unit Unit1;                                   {v3.0}

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
    procedure Button2Click(Sender: TObject);

  end;

  function Func(x:real):real;        //функция
  function func_pr(x:real):real;     //Производная функции



var
  Form1: TForm1;
  Res:array[byte]of real;
  F:Text;
  i:integer;
  Eps,x_beg,x_end:real;

implementation

{$R *.lfm}

function Func(x:real):real;
  begin
    result:=(sqr(x)*x)-sqr(x)-9.5;
  end;

function func_pr(x:real):real;
begin
  result:=(3*sqr(x))-2*x;
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

 procedure TForm1.Button2Click(Sender: TObject);
  var
   x,xn,y:real;
  begin
    assignfile(F,'lab4.txt');
    rewrite(F);
    Chart1LineSeries1.Clear;
    Eps:=StrToFloat(Edit3.Text);
    x_beg:=StrToFloat(Edit1.Text);
    x_end:=StrToFloat(Edit2.Text);
    x:=(x_end-x_beg)/15;
    repeat
      xn:=x;
      y:=Func(x)/func_pr(x);
      x:=x-y;
      if abs(x-xn)>=Eps
        then
          begin
            writeln(F,'x='+FloatToStr(x));
            writeln(F,'F(x)='+FloatToStr(Func(x)));
            Memo1.Lines.Add('x='+FloatToStr(x));
            Memo1.Lines.Add('F(x)='+FloatToStr(Func(x)));
            Chart1LineSeries1.AddXY(x,Func(x),'',clred);
          end
        else
          begin
            writeln(F,'x='+FloatToStr(x));
            Memo1.Lines.Add('x='+FloatToStr(x));
          end;
    until abs(x-xn)<=Eps;
    closefile(F);
    showmessage('x='+ FloatToStr(x));
  end;

end.
