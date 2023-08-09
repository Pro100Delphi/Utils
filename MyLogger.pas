unit MyLogger;

interface

uses
  SysUtils, Classes, Controls, StdCtrls, Graphics, ComCtrls, Forms, Windows, Messages;

type
  TMyLogger = class(TCustomControl)
    private
      FLog: TRichEdit;
      FButton: TButton;

      procedure OnLogChange(Sender: TObject);
      procedure OnLogKeyPress(Sender: TObject; var AKey: Char);

      procedure OnClearClick(Sender: TObject);

    protected
      procedure CreateHandle; override;
    public
      constructor Create(AOwner: TComponent); override;
      destructor Destroy; override;

      procedure Add(AMsg: String; AColor: TColor);
      procedure Clear;
  end;

var
  MyLogControl: TMyLogger;

procedure MyLog(AMsg: String); overload;
procedure MyLog(AMsg: Integer); overload;
procedure MyLog(AMsg: Double); overload;
procedure MyLog(AMsg: Boolean); overload;

procedure MyLog(AStrMsg: String; AMsg: String); overload;
procedure MyLog(AStrMsg: String; AMsg: Integer); overload;
procedure MyLog(AStrMsg: String; AMsg: Double); overload;
procedure MyLog(AStrMsg: String; AMsg: Boolean); overload;

procedure MyLogInfo(AMsg: String); overload;
procedure MyLogWarning(AMsg: String); overload;
procedure MyLogError(AMsg: String); overload;

procedure MyLogClear;

function PrintFloat(AValue: Single; ADigs: Integer = 3): String;

implementation

procedure MyLog(AMsg: String);
begin
  MyLogControl.Add(AMsg, $00CF7300);
end;

procedure MyLog(AMsg: Integer);
begin
  MyLog(IntToStr(AMsg));
end;

procedure MyLog(AMsg: Double);
begin
  MyLog(FloatToStrF(AMsg, ffFixed, 10, 3));
end;

procedure MyLog(AMsg: Boolean);
begin
  MyLog(BoolToStr(AMsg, True));
end;

procedure MyLog(AStrMsg: String; AMsg: String);
begin
  MyLog(AStrMsg + AMsg);
end;

procedure MyLog(AStrMsg: String; AMsg: Integer);
begin
  MyLog(AStrMsg + IntToStr(AMsg));
end;

procedure MyLog(AStrMsg: String; AMsg: Double);
begin
  MyLog(AStrMsg + FloatToStrF(AMsg, ffFixed, 10, 3));
end;

procedure MyLog(AStrMsg: String; AMsg: Boolean);
begin
  MyLog(AStrMsg + BoolToStr(AMsg, True));
end;

procedure MyLogInfo(AMsg: String);
begin
  MyLogControl.Add(AMsg, $006BA800 );
end;

procedure MyLogWarning(AMsg: String);
begin
  MyLogControl.Add(AMsg, $0020A5DA);
end;

procedure MyLogError(AMsg: String);
begin
  MyLogControl.Add(AMsg, $001E119B);
end;

procedure MyLogClear;
begin
  MyLogControl.Clear;
end;

constructor TMyLogger.Create(AOwner: TComponent);
begin
  inherited;

  BevelEdges := [beLeft];

  FLog := TRichEdit.CreateParented(HWND_MESSAGE);
  FLog.Align := alClient;
  FLog.ReadOnly := True;
  FLog.OnChange := OnLogChange;
  FLog.OnKeyPress := OnLogKeyPress;
  FLog.ScrollBars := ssVertical;

  FLog.BevelKind := bkNone;
  FLog.BevelInner := bvNone;
  FLog.BevelOuter := bvNone;
  FLog.BevelEdges := [];
  
  FButton := TMyButton.Create(Self);
  FButton.Parent := Self;
  FButton.Align := alTop;
  FButton.OnClick := OnClearClick;
  FButton.Caption := 'Clear';
  
  Width := 200;
  Height := 400;

  Font.Size := 10;
  Font.Name := 'Courier New';
end;

procedure TMyLogger.CreateHandle;
begin
  inherited;

  FLog.Parent := Self;
  FLog.Align := alClient;
  FLog.BorderStyle := bsNone;
end;

destructor TMyLogger.Destroy;
begin
  FreeAndNil(FLog);
  inherited;
end;

procedure TMyLogger.Add(AMsg: String; AColor: TColor);
begin
  FLog.SelLength := Length(AMsg);
  FLog.SelAttributes.Color := AColor;
  FLog.Lines.Add(AMsg);
end;

procedure TMyLogger.Clear;
begin
  FLog.Clear;
end;

procedure TMyLogger.OnLogKeyPress(Sender: TObject; var AKey: Char);
begin
  AKey := #0;
end;

procedure TMyLogger.OnLogChange(Sender: TObject);
begin
  SendMessage(FLog.Handle, WM_VSCROLL, SB_BOTTOM, 0);
end;

procedure TMyLogger.OnClearClick(Sender: TObject);
begin
  FLog.Clear;
end;

function PrintFloat(AValue: Single; ADigs: Integer = 3): String;
begin
  Result := FloatToStrF(AValue, ffFixed, 10, ADigs);
end;

initialization
  MyLogControl := TMyLogger.Create(Application);

finalization
	// No need to destroy, Application will destroy it

end.