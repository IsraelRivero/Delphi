unit ClientService;

interface

uses
  Client,
  MysqlConnection,
  rest.json,
  System.JSON,
  System.SysUtils,
  System.Classes,
  System.Generics.Collections,
  Aurelius.Drivers.Interfaces,
  Aurelius.Engine.DatabaseManager,
  Aurelius.Engine.ObjectManager,
  Aurelius.Criteria.Linq,
  Aurelius.Criteria.Projections;

type
    TClientService = class
        class procedure AddClient(jsUser : TJSONObject);static;
    public

end;
implementation

class procedure TClientService.AddClient(jsUser : TJSONObject);
var
  client : TClient;
  FConnection : IDBConnection;
  Manager : TObjectManager;
begin
  client := TClient.Create(
          StrToInt(jsUser.GetValue('id').Value),
          jsUser.GetValue('firstName').Value,
          jsUser.GetValue('lastName').Value
          );

  Manager.Save(client);
 // TUserDataAccess.Insert(client);
end;



end.
