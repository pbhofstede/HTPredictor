unit FormRatingbijdrages;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  uRatingBijdrages, cxPC, cxControls, cxGridLevel, cxClasses,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, Db, dxmdaset, cxStyles;

type
  TfrmRatingBijdrages = class(TForm)
    cxpgctlRatingBijdrages: TcxPageControl;
    cxtbFlattermann: TcxTabSheet;
    cxtbCustom: TcxTabSheet;
    dxmdFlatterMann: TdxMemData;
    cxgrdFlattermannDBTableView1: TcxGridDBTableView;
    cxgrdFlattermannLevel1: TcxGridLevel;
    cxgrdFlattermann: TcxGrid;
    dxmdFlatterMannPOSITIE: TStringField;
    dxmdFlatterMannMID_PM: TFloatField;
    dxmdFlatterMannCD_GK: TFloatField;
    dxmdFlatterMannCD_DEF: TFloatField;
    dxmdFlatterMannWB_GK: TFloatField;
    dxmdFlatterMannWB_DEF: TFloatField;
    dxmdFlatterMannCA_PASS: TFloatField;
    dxmdFlatterMannCA_SC: TFloatField;
    dxmdFlatterMannWA_PASS: TFloatField;
    dxmdFlatterMannWA_WING: TFloatField;
    dxmdFlatterMannWA_SC: TFloatField;
    dxmdFlatterMannWA_SC_OTHER: TFloatField;
    dsFlatterMann: TDataSource;
    cxgrdFlattermannDBTableView1RecId: TcxGridDBColumn;
    cxgrdFlattermannDBTableView1POSITIE: TcxGridDBColumn;
    cxgrdFlattermannDBTableView1MID_PM: TcxGridDBColumn;
    cxgrdFlattermannDBTableView1CD_GK: TcxGridDBColumn;
    cxgrdFlattermannDBTableView1CD_DEF: TcxGridDBColumn;
    cxgrdFlattermannDBTableView1WB_GK: TcxGridDBColumn;
    cxgrdFlattermannDBTableView1WB_DEF: TcxGridDBColumn;
    cxgrdFlattermannDBTableView1CA_PASS: TcxGridDBColumn;
    cxgrdFlattermannDBTableView1CA_SC: TcxGridDBColumn;
    cxgrdFlattermannDBTableView1WA_PASS: TcxGridDBColumn;
    cxgrdFlattermannDBTableView1WA_WING: TcxGridDBColumn;
    cxgrdFlattermannDBTableView1WA_SC: TcxGridDBColumn;
    cxgrdFlattermannDBTableView1WA_SC_OTHER: TcxGridDBColumn;
    cxGrdUser: TcxGrid;
    cxGridDBTableView1: TcxGridDBTableView;
    cxGridDBColumn1: TcxGridDBColumn;
    cxGridDBColumn2: TcxGridDBColumn;
    cxGridDBColumn3: TcxGridDBColumn;
    cxGridDBColumn4: TcxGridDBColumn;
    cxGridDBColumn5: TcxGridDBColumn;
    cxGridDBColumn6: TcxGridDBColumn;
    cxGridDBColumn7: TcxGridDBColumn;
    cxGridDBColumn8: TcxGridDBColumn;
    cxGridDBColumn9: TcxGridDBColumn;
    cxGridDBColumn10: TcxGridDBColumn;
    cxGridDBColumn11: TcxGridDBColumn;
    cxGridDBColumn12: TcxGridDBColumn;
    cxGridDBColumn13: TcxGridDBColumn;
    cxGridLevel1: TcxGridLevel;
    dxmdUser: TdxMemData;
    StringField1: TStringField;
    FloatField1: TFloatField;
    FloatField2: TFloatField;
    FloatField3: TFloatField;
    FloatField4: TFloatField;
    FloatField5: TFloatField;
    FloatField6: TFloatField;
    FloatField7: TFloatField;
    FloatField8: TFloatField;
    FloatField9: TFloatField;
    FloatField10: TFloatField;
    FloatField11: TFloatField;
    dsUser: TDataSource;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    procedure FormCreate(Sender: TObject);
    procedure dsUserStateChange(Sender: TObject);
  private
    FTRatingBijdrages: TRatingBijdrages;
    FRatingsChanged: boolean;
    procedure ShowFlatterMannRatings;
    procedure SetTRatingBijdrages(const Value: TRatingBijdrages);
    { Private declarations }
  public
    { Public declarations }
    property RatingBijdrages: TRatingBijdrages read FTRatingBijdrages write SetTRatingBijdrages;
    property RatingsChanged: boolean read FRatingsChanged write FRatingsChanged;
  end;

  function ToonRatingbijdrages(aCurBijdrages: TRatingBijdrages):boolean;

implementation

{$R *.DFM}

function ToonRatingbijdrages(aCurBijdrages: TRatingBijdrages):boolean;
begin
  with TfrmRatingBijdrages.Create(nil) do
  begin
    try
      RatingBijdrages := aCurBijdrages;
      ShowModal;
      result := RatingsChanged;

      if (result) then
      begin
        RatingBijdrages.LoadFromMemData(dxMdUser);
      end;
    finally
      Free;
    end;
  end;
end;

{ TfrmRatingBijdrages }

procedure TfrmRatingBijdrages.SetTRatingBijdrages(
  const Value: TRatingBijdrages);
begin
  FTRatingBijdrages := Value;
  FTRatingBijdrages.SaveToMemData(dxmdUser);
  FRatingsChanged := FALSE;
end;

procedure TfrmRatingBijdrages.FormCreate(Sender: TObject);
begin
  cxpgctlRatingBijdrages.ActivePage := cxtbFlattermann;
  ShowFlatterMannRatings;
end;

procedure TfrmRatingBijdrages.ShowFlatterMannRatings;
var
  vRatings: TRatingBijdrages;
begin
  vRatings := TRatingBijdrages.Create;
  try
    vRatings.SaveToMemData(dxmdFlatterMann);
  finally
    vRatings.Free;
  end;
end;

procedure TfrmRatingBijdrages.dsUserStateChange(Sender: TObject);
begin
  RatingsChanged := RatingsChanged or (TDataSource(Sender).State in [dsEdit,dsInsert]);
end;

end.
