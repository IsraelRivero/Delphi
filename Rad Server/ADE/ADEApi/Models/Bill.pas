unit Bill;

interface

type
  TBill = class
  private

    FId: integer;
    FLastName: string;
    FFirstName: string;
  public
    Property Id: integer read FId write FId;
    Property FirstName : string read FFirstName write FFirstName;
    Property LastName : string read FLastName write FLastName;
    Constructor Create; overload;
    Constructor Create(id : integer; firstName:string; lastName: string); overload;

  end;

implementation

Constructor TBill.Create(); begin end;

Constructor TBill.Create(id : integer; firstName:string; lastName: string);
begin
    self.Id     := id;
    self.FirstName := firstName;
    self.LastName   := lastName;
end;


end.
