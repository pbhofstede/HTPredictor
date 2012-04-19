unit formHTPredictor;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  cxPC, cxControls, dxBar, ImgList, cxClasses, cxGridLevel, uSelectie,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, uRatingBijdrages,
  cxGridDBTableView, cxGrid, Db, dxmdaset, ExtCtrls, StdCtrls, dxCntner,
  Menus;

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
    MainMenu1: TMainMenu;
    Bestand1: TMenuItem;
    Afsluiten1: TMenuItem;
    Instellingen1: TMenuItem;
    Ratingbijdrages1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure Ratingbijdrages1Click(Sender: TObject);
  private
    FSelectie_Eigen: TSelectie;
    FSelectie_Tegen: TSelectie;
    FRatingBijdrages: TRatingBijdrages;
    procedure ToonRatingbijdrages;
    { Private declarations }
  public
    { Public declarations }
    function ToonSpelersGrids(aPanel: TPanel; aTabSheet: TcxTabSheet):TSelectie;
    property RatingBijdrages:TRatingBijdrages read FRatingBijdrages write FRatingBijdrages;
    property Selectie_Eigen: TSelectie read FSelectie_Eigen write FSelectie_Eigen;
    property Selectie_Tegen: TSelectie read FSelectie_Tegen write FSelectie_Tegen;
  end;

var
  frmHTPredictor: TfrmHTPredictor;

implementation

uses
  FormSpelerGrid, uPlayer, FormOpstelling, FormRatingBijdrages;

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
  Procedure: ToonRatingbijdrages
  Author:    Harry
  Date:      19-apr-2012
  Arguments: None
  Result:    None
-----------------------------------------------------------------------------}
procedure TfrmHTPredictor.ToonRatingbijdrages;
begin
  if FormRatingBijdrages.ToonRatingbijdrages(FRatingBijdrages) then
  begin
    FSelectie_Eigen.UpdateOpstellingen;
    FSelectie_Tegen.UpdateOpstellingen;
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

  FRatingBijdrages := TRatingBijdrages.Create;

  FSelectie_Tegen := ToonSpelersGrids(pnlSpelersGrid1, cxtbTegenstander);
  FSelectie_Eigen := ToonSpelersGrids(pnlSpelersGrid2, cxtbEigenTeam);
  FSelectie_Eigen.RatingBijdrages := FRatingBijdrages;
  FSelectie_Tegen.RatingBijdrages := FRatingBijdrages;

  FormOpstelling.ToonOpstelling(cxTabSheet1, FSelectie_Eigen);
end;

procedure TfrmHTPredictor.Ratingbijdrages1Click(Sender: TObject);
begin
  ToonRatingbijdrages;
end;

end.
