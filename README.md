# ugmaventon-
Repositorio destinado a Ugmaventón.

OBSERVACIONES DEL PRIMER MERGE:

Integracion del login, y registro de usuario

Dependencias a tomar en cuenta:

- Firebase_Core
- cloud_firestore
- image_picker
- firebase_auth
- firebase_storage

Correccion para posible error con imagepicker (flutter/flutter#156307)

cambiar en settings.gradle en el id:

id "com.android.application" version "8.3.2" apply false

cambiar en gradle-wrapper.properties en el distribution:

distributionUrl=https://services.gradle.org/distributions/gradle-8.4-all.zip

En el build.gradle

- en defaultConfig cambiar la linea de minSdkVersion por
minSdkVersion 23
- en ndkVersion colocar
ndkVersion = "25.1.8937393"

NOTA: Para cualquier integracion de datos con la base de datos, trabajar en el archivo firebase_service o trabajar en auth_service para registro de usuarios, pero para comodidad crear archivos relaciones a su objetivo ejemplo, travel_service para gestionar los viajes existentes y viajes por crear

NOTA 2: La base de datos firestore trabaja por colecciones, las colecciones actuales son:

- people: almacena usuarios
- drivers: almacena conductores
- offers: almacena las ofertas disponibles
- travels: almacena los viajes

No se requieren datos especificos para registrarse, pueden incluir los datos que creen convenientes

se agrego un .dart para registrar conductores de momento en la rama mapa+login.
