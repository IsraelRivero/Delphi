unit Unit9;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  ConnectionModule,
  Aurelius.Drivers.Interfaces,
  Aurelius.Engine.DatabaseManager,
  Aurelius.Engine.ObjectManager,
  UserDB,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Edit,
  System.Generics.Collections, FMX.Layouts, FMX.ListBox, Data.DB,
  Aurelius.Bind.BaseDataset, Aurelius.Bind.Dataset, System.Rtti, FMX.Grid.Style,
  Data.Bind.EngExt, Fmx.Bind.DBEngExt, Fmx.Bind.Grid, System.Bindings.Outputs,
  Fmx.Bind.Editors, Data.Bind.Components, Data.Bind.Grid, Data.Bind.DBScope,
  FMX.ScrollBox, FMX.Grid
  ;

type
  TForm9 = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Button2: TButton;
    ListBox1: TListBox;
    Button3: TButton;
    Edit3: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
      FConnection : IDBConnection;
      Manager : TObjectManager;
  public
    { Public declarations }
  end;

var
  Form9: TForm9;

implementation

{$R *.fmx}

procedure TForm9.Button1Click(Sender: TObject);
var
   user : TUserDB;
begin
      user := TUserDB.Create;
      user.FirstName:= Edit1.Text;
      user.LastName := Edit2.Text;
      Manager.Save(user);

end;

procedure TForm9.Button2Click(Sender: TObject);
var
  users : TList<TUserDB>;
  user : TUserDB;
begin
   try
     users := Manager.Find<TUserDB>().List();


     ListBox1.Clear;
     for user in users do
      ListBox1.Items.Add( user.FirstName + ' ' + user.LastName );

    //AureliusDataset1.Close;
    //AureliusDataset1.Manager := Manager;
    //AureliusDataset1.SetSourceCriteria(Manager.Find<TUserDB>);
    //AureliusDataset1.Open;

   finally
      //Manager.Free;
   end;

end;

procedure TForm9.Button3Click(Sender: TObject);
var user : TUserDB;
id :Integer;
begin
    id := StrToInt(edit3.Text);
    user:=  Manager.Find<TUserDB>(id);
    Manager.Remove(user);
end;

procedure TForm9.FormCreate(Sender: TObject);
begin
   FConnection := TMSSQLConnection.CreateConnection;
   TDatabaseManager.Update(FConnection);
   Manager := TObjectManager.Create(FConnection);
end;

procedure TForm9.FormDestroy(Sender: TObject);
begin
   Manager.Free;
end;

end.
