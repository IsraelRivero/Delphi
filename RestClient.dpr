program RestClient;

uses
  System.StartUpCopy,
  FMX.Forms,
  URestClient in 'URestClient.pas' {Form5};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm5, Form5);
  Application.Run;
end.
