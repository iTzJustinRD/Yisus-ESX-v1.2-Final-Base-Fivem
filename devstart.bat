cd server-data
rmdir cache /S /Q
..\server\FXServer.exe +exec server.cfg
cmd /k
pause