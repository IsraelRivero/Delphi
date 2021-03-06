unit BillController;

interface

uses
  System.SysUtils,System.Classes,System.JSON,System.Generics.Collections,EMS.Services,
  EMS.ResourceAPI,EMS.ResourceTypes,rest.json;

type
 [ResourceName('bill')]
  {$METHODINFO ON}
  TBillController = class
  published

    [ResourceSuffix('/getbills')]
    [EndPointRequestSummary('User Management', '', 'Get all users from user table mysql database ', 'application/json', '')]
    procedure GetBills(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);

  {$METHODINFO OFF}

  end;
implementation
uses Bill,UserDataAccess;

procedure TBillController.GetBills(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
var
  bills : TList<TBill>;
begin
  bills:= TList<TBill>.Create();
  AResponse.Body.SetValue( TJSON.ObjectToJsonObject(bills), True);
end;


procedure Register;
begin
  RegisterResource(TypeInfo(TBillController));
end;

initialization
  Register;
end.


