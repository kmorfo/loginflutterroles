<p align="center">
  <a href="https://rlujancreations.es/" target="blank"><img src="https://rlujancreations.es/assets/img/logo%20rlujan%20SF.png" width="200" alt="RLujanCreations Logo" /></a>
</p>

# Documentación de las librerias utilizadas
[go_router](https://pub.dev/documentation/go_router/latest/)
\
[permission_handler](https://pub.dev/packages/permission_handler)
\
[shared_preferences](https://pub.dev/documentation/shared_preferences/latest/)
\
[flutter_dotenv](https://pub.dev/packages/flutter_dotenv)
\
[Configuración de los DeepLink Android](https://docs.flutter.dev/cookbook/navigation/set-up-app-links)
\
[Configuración de los DeepLink IOS](https://docs.flutter.dev/cookbook/navigation/set-up-universal-links)
\
[Generador y verificador de la lista de instrucciones](https://developers.google.com/digital-asset-links/tools/generator?hl=es-419)

# Esqueleto de un login, registro y recuperación de contraseñas
[Backend de este login](https://github.com/kmorfo/NestJS-RESTFul-API)
Para la realización de este loginApp se utilizará el concepto DDD - Domain Data Driven, que será la arquitectura utilizada en las aplicaciones que utilizaran este login como base.


# Skeleton login
1. Crear un nuevo proyecto en Flutter y sobreescribir la estructura de carpetas con las existentes en el repositorio.
    * Clonar repositorio en caso de clonar el repositorio es necesario crear las carpetas de las plataformas en las que se desarrollara el proyecto. \
    ```flutter create --platforms=IOS,android .```
2. ```flutter pub get```
3. Clonar el archivo `.env.template` y renombrarlo a `.env`
4. Configurar las variables de entorno según nuestros parametros
5. Si se va a publicar la app en alguna store, se deberá renombrar el dominio y nombre de la misma. Se puede hacer manualmente o utilizando un paquete como [rename](https://pub.dev/packages/rename)
7. Configuración DeepLinking 
    * Para obtener la firma de la app en adroid
      ````
      cd android
      ./gradlew signingReport
      ````
    * Es necesario cambiar el dominio donde estara la webapp con la configuración del deeplink en el archivo `AndroidManifest.xml`

