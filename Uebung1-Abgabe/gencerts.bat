@echo off
if "%1" == "" goto usage

keytool -genkeypair -alias servercert -keyalg RSA -dname "CN=Web Server,OU=Unit,O=Organization,L=City,S=State,C=US" -keypass password -keystore server.jks -storepass password
keytool -genkeypair -alias %1 -keystore %1.p12 -storetype pkcs12 -keyalg RSA -dname "CN=%1,OU=Unit,O=Organization,L=City,S=State,C=US" -keypass password -storepass password
keytool -exportcert -alias %1 -file %1.cer -keystore %1.p12 -storetype pkcs12 -storepass password
keytool -importcert -keystore server.jks -alias %1 -file %1.cer -v -trustcacerts -noprompt -storepass password
keytool -list -v -keystore server.jks -storepass password
del %1.cer
goto end

:usage
echo Need user id as first argument: generate_keystore [username]
goto end

:end
pause