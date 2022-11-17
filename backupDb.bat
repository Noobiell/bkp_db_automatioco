@echo off
cls

REM Define o usuário e senha do banco de dados
set dbUser=xxxx
set dbPassword=xxxx

REM Define a pasta que será feito o backup no padrão ...\<dia do mês>\<hora atual>
set backupDir=C:\backup\%date:~0,2%\%time:~0,2%\

REM Nome do arquivo que será gerado
set file=backup_db.sql

REM Caminho dos executáveis do mysqldump.exe, para executar o dump, e do 7z.exe, para compactar o arquivo
set mysqldump="C:\xampp\mysql\bin\mysqldump.exe"
set zip="C:\Program Files\7-Zip\7z.exe"

REM Cria a pasta de backup caso não exista
if not exist "%backupDir%" (
    mkdir "%backupDir%"
)

REM Executa o dump, aqui precisa configurar o host e o nome do banco de dados (locais com xxx)
%mysqldump% --host=" COLOCAR O HOST DO DB AQUI " --user=%dbUser% --password=%dbPassword% COLOCAR O NOME DA TABELA AQUI > "%backupDir%\%file%"

REM Compacta o arquivo com o dump
%zip% a -tgzip "%backupDir%\%file%.gz" "%backupDir%\%file%"

REM Exclui o arquivo .sql original
del "%backupDir%\%file%"
