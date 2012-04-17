unit formHTPredictor;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  cxPC, cxControls, dxBar, ImgList, cxClasses, cxGridLevel, uSelectie,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, Db, dxmdaset, ExtCtrls, StdCtrls, dxCntner;

type
  TfrmHTPredictor = class(TForm)
    cxpgctrlHTPredictor: TcxPageControl;
    cxtbTegenstander: TcxTabSheet;
    cxtbEigenTeam: TcxTabSheet;
    dxBarManager1: TdxBarManager;
    imgListHTPredictor: TImageList;
    Panel1: TPanel;
    pnlSpelersGrid1: TPanel;
    Splitter1: TSplitter;
    pnlSpelersGrid2: TPanel;
    Panel4: TPanel;
    Splitter2: TSplitter;
    cxPageControl1: TcxPageControl;
    cxTabSheet1: TcxTabSheet;
    cxTabSheet2: TcxTabSheet;
    tbResultaat: TcxTabSheet;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    procedure FormCreate(Sender: TObject);
  private
    FSelectie_Eigen: TSelectie;
    FSelectie_Tegen: TSelectie;
    { Private declarations }
  public
    { Public declarations }
    function ToonSpelersGrids(aPanel: TPanel; aTabSheet: TcxTabSheet):TSelectie;
    property Selectie_Eigen: TSelectie read FSelectie_Eigen write FSelectie_Eigen;
    property Selectie_Tegen: TSelectie read FSelectie_Tegen write FSelectie_Tegen;
  end;

var
  frmHTPredictor: TfrmHTPredictor;

implementation

uses
  FormSpelerGrid, uPlayer, FormOpstelling;

{$R *.DFM}

{-----------------------------------------------------------------------------
  Procedure: ToonSpelersGrids
  Author:    Harry
  Date:      13-apr-2012
  Arguments: aPanel: TPanel
  Result:    TSelectie
-----------------------------------------------------------------------------}
function TfrmHTPredictor.ToonSpelersGrids(aPanel: TPanel; aTabSheet: TcxTabSheet):TSelectie;
begin
  with TfrmSpelerGrid.Create(Self) do
  begin
    Parent := aPanel;
    Visible := TRUE;
    Align := alClient;
    TabSheet := aTabsheet;
    result := Selectie;
  end;
end;

{-----------------------------------------------------------------------------
  Procedure: FormCreate
  Author:    Harry
  Date:      13-apr-2012
  Arguments: Sender: TObject
  Result:    None
-----------------------------------------------------------------------------}
procedure TfrmHTPredictor.FormCreate(Sender: TObject);
begin
  cxpgctrlHTPredictor.ActivePage := cxtbTegenstander;
  FSelectie_Tegen := ToonSpelersGrids(pnlSpelersGrid1, cxtbTegenstander);
  FSelectie_Eigen := ToonSpelersGrids(pnlSpelersGrid2, cxtbEigenTeam);

  FormOpstelling.ToonOpstelling(cxTabSheet1, FSelectie_Eigen);
end;

end.
