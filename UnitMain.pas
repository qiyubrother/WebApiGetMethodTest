unit UnitMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IdComponent, IdTCPConnection, IdTCPClient,
  StdCtrls, Buttons, ExtCtrls, IdBaseComponent;


type
  TForm1 = class(TForm)
    mmoTx: TMemo;
    lbledtIP: TLabeledEdit;
    lbledtPort: TLabeledEdit;
    btnSendMessage: TBitBtn;
    lblPostString: TLabel;
    idtcpclnt1: TIdTCPClient;
    mmoRx: TMemo;
    lbledtWebAPIUrl: TLabeledEdit;
    procedure FormCreate(Sender: TObject);
    procedure btnSendMessageClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  lbledtIP.Text := '';
  lbledtPort.Text := '';
end;

procedure TForm1.btnSendMessageClick(Sender: TObject);
var
  sendMessage: string;
begin
  idtcpclnt1.Host := lbledtIP.Text;
  idtcpclnt1.Port := strtoint(lbledtPort.Text);
  idtcpclnt1.Connect();
  try
    // $"GET {s} HTTP/1.1{Environment.NewLine}Host: {hostName}{Environment.NewLine}Connection: close{Environment.NewLine}{Environment.NewLine}";
    sendMessage := 'GET ' + Trim(lbledtWebAPIUrl.Text) + ' HTTP/1.1' + #13#10 + 'Host: ' + idtcpclnt1.Host + #13#10 + 'Connection: close'+ #13#10 + #13#10;
    mmoTx.Text := sendMessage;
    idtcpclnt1.SendCmd(sendMessage);
    mmoRx.Lines.Clear;
    mmoRx.Lines.Add(idtcpclnt1.CurrentReadBuffer);
  except
    on e:Exception do
    ShowMessage(e.Message);
  end;
  idtcpclnt1.Disconnect;
end;

end.
