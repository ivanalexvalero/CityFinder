# CityFinder

**CityFinder** Es una aplicacion para buscar ciudades, obtener su latitud, longitud, pais y nombre completo. Es una aplicación nativa de iOS que permite a los usuarios ver un listado de ciudades, un buscador para filtrar por nombre, seleccionar una ciudad y poder ver su localizacion en un mapa, ademas, con posibilidad de obtener mas informacion respecto de esa localidad con presionar un boton adicional. También es posible guardar tus ciudades favoritas y también poder filtrarlas y verlas en una lista. Es posible utilizarla tanto en landscape y en portrait, ademas, de los modos claro y oscuro.

## Características

- **Buscador de Ciudades**: Permite buscar ciudades por nombre en un listado.
- **Listado de Ciudades**: Muestra una lista de ciudades con nombre, nomenclatura del país, longitud y latitud.
- **Listado de Ciudades Favoritas**: Se puede filtrar las ciudades favoritas
- **Vista en Mapa**: Permite ver la ubicación de la ciudad en un mapa.
- **Vista Detalle**: Muestra detalles de la ciudad seleccionada al presionar el botón de "Más info".
- **Modo Landscape**: La aplicación se adapta para ser visualizada en modo landscape.
- **Adapta modo oscuro**: Se puede utikizar la app en light mode y dark mode

## Explicación de Uso

Cada ciudad se muestra con su nombre y nomenclatura del país (por ejemplo, "Alabama, US"), junto con su latitud y longitud. Las ciudades se presentan en un listado, y al seleccionar una de ellas, se desplegará una nueva pantalla mostrando un mapa donde el usuario podrá ubicarla y navegar en él. También habrá un botón en la parte inferior que proporcionará más información sobre la ciudad seleccionada.

## Desarrollo de la App

Se desarrollo la app con la arquitectura de MVVM con SwiftUI y SwiftData para persistencia de datos. Además, se implemento el uso de URLSession para el consumo del servicio. Se implemento la paginacion para reducir el tiempo de carga de la app y del funcionamiento del buscador, intentando que la experiencia sea lo mas fluida posible. Se utilizo todo nativo, sin librerias externas. Se puede utilizar tanto en portrait como en landscape y se adapto para light mode y dark mode.

## Algunas Capturas del Funcionamiento de la Aplicación

## Capturas de pantalla

| App logo light mode             | App logo dark mode             |
|-------------------------------------|-------------------------------------|
| <img src="https://github.com/user-attachments/assets/9565b490-9e49-4f72-b7b5-b1bb92baccdf" width="160"/>    | <img src="https://github.com/user-attachments/assets/2d6dd811-9415-47c2-8b30-a518914e4e64" width="160"/> |

| Splash light mode             | Splash dark mode             |
|-------------------------------------|-------------------------------------|
|![RocketSim_Recording_iPhone_12_Pro_Max__6 7_2025-03-11_21 37 59](https://github.com/user-attachments/assets/c3302c83-9332-4eec-be4d-8f0adc5462a1)    | ![RocketSim_Recording_iPhone_12_Pro_Max__6 7_2025-03-11_21 39 39](https://github.com/user-attachments/assets/b082b0d7-52e2-437a-b95a-f3aa35bea358) |


| List           | Loading           |
|-------------------------------------|-------------------------------------|
| <img src="https://github.com/user-attachments/assets/d23a92f9-5cf2-451b-a710-841e6005c35c" width="310"/>    | ![RocketSim_Recording_iPhone_14_Pro_Max_6 7_2025-03-12_20 38 31](https://github.com/user-attachments/assets/a920edc4-16f7-45c3-a8ea-98a76e841073) |


| App logo light mode             | App logo dark mode             |
|-------------------------------------|-------------------------------------|
| <img src="https://github.com/user-attachments/assets/ade8895c-465c-4ee7-81ec-37af42f4bdff" width="360"/>    | <img src="https://github.com/user-attachments/assets/c041aa82-351e-40cf-8e29-316057d9b024" width="360"/> |


| App logo light mode             | App logo dark mode             |
|-------------------------------------|-------------------------------------|
| <img src="https://github.com/user-attachments/assets/12753e4a-2bd4-4e0b-b697-ab83baaa139a" width="360"/>    | <img src="https://github.com/user-attachments/assets/ef0d0ae3-9df4-4408-9f41-90e81e7df198" width="360"/> |

