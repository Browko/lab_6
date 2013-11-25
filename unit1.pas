unit Unit1;                                   {v2.0}

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
    Edit1: TEdit;                      {Левая граница}
    Edit2: TEdit;                      {Правая граница}
    Edit3: TEdit;                      {Точность}
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
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

  function Func(x:real):real;
  begin
    result:=(sqr(x)*x)-sqr(x)-9.5;
  end;

  function func_pr(x:real):real;
  begin
    result:=(3*sqr(x))-2*x;
  end;


  { TForm1 }

  procedure TForm1.Button1Click(Sender: TObject);
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

  {$R *.lfm}

  end.
