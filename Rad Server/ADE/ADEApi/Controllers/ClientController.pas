unit ClientController;

// EMS Resource Module

interface

uses

  System.SysUtils,System.Classes,System.JSON,System.Generics.Collections,EMS.Services,
  EMS.ResourceAPI,EMS.ResourceTypes,rest.json;

type
 [ResourceName('client')]
  {$METHODINFO ON}
  TClientController = class
  published

    [ResourceSuffix('/getclients')]
    [EndPointRequestSummary('User Management', '', 'Get all users from user table mysql database ', 'application/json', '')]
    procedure GetClients(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);

    [ResourceSuffix('/addclient')]
    [EndPointRequestSummary('User Management', '', 'Insert new user into user table mysql database ', 'application/json', '')]
    procedure AddClient(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);


    [ResourceSuffix('/getclientbyid/{id}')]
    [EndPointRequestSummary('User Management', '', 'Get user by id from user table mysql database ', 'application/json', '')]
    [EndPointRequestParameter(TAPIDocParameter.TParameterIn.Path, 'Id', '', true, TAPIDoc.TPrimitiveType.spInteger,
    TAPIDoc.TPrimitiveFormat.None, TAPIDoc.TPrimitiveType.spInteger, '', '')]
    [EndPointResponseDetails(200, 'Ok', TAPIDoc.TPrimitiveType.spObject, TAPIDoc.TPrimitiveFormat.None, '', '')]
    procedure GetClientById(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
  {$METHODINFO OFF}

  end;
implementation
uses Client,UserDataAccess;

procedure TClientController.GetClients(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
var
  clients : TList<TClient>;
begin
  clients:= TUserDataAccess.GetUsers();
  AResponse.Body.SetValue( TJSON.ObjectToJsonObject(clients), True);
end;


procedure TClientController.GetClientById(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
var
  id:string;
  client:TClient;
begin
  id  := ARequest.Params.Values['id'];
  client := TUserDataAccess.GetUserById(StrToInt(id));
  AResponse.Body.SetValue( TJSON.ObjectToJsonObject(client), True);
end;

procedure TClientController.AddClient(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
var
  jsUser : TJSONObject;
  client : TClient;
begin
  jsUser := ARequest.Body.GetObject;
  client := TClient.Create(
          StrToInt(jsUser.GetValue('id').Value),
          jsUser.GetValue('firstName').Value,
          jsUser.GetValue('lastName').Value
          );
  TUserDataAccess.Insert(client);
end;


procedure Register;
begin
  RegisterResource(TypeInfo(TClientController));
end;

initialization
  Register;
end.


