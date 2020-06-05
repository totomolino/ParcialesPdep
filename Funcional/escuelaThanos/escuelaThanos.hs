import Text.Show.Functions

--objetos de prueba 


ironMan   = Personaje{edad = 45, energia = 10,  habilidades = ["reactor","volar"], nombre = "Tony" ,     planeta = "tierra"}
ironManViejo   = Personaje{edad = 50, energia = 10,  habilidades = [], nombre = "Tony" ,     planeta = "tierra"}
drStrange = Personaje{edad = 35, energia = 100, habilidades = ["teletransporte","escudos","volar"], nombre = "Stehepen" , planeta = "tierra"}
spiderMan = Personaje{edad = 16, energia =  50, habilidades = ["fuerza","saltar","telarañas"], nombre = "Peter" , planeta = "tierra"}

guanteleteDelInfinito = Guantelete {material = "uru" , gemas = [mente 2 , tiempo , espacio "vormir" , gemaLoca poder , poder , alma " "]}
guanteleteFalso       = Guantelete {material = "oro" , gemas =            []}

universo616 = [ironMan,drStrange,ironMan,drStrange]
universo1 = [ironManViejo]


--punto 1 

type Gema = Personaje -> Personaje
type Universo = [Personaje]
type Habilidad = String

data Guantelete = Guantelete {
    material :: String,
    gemas    :: [Gema]
}deriving (Show)


data Personaje = Personaje {
    edad :: Int,
    energia :: Float,
    habilidades :: [Habilidad],
    nombre :: String,
    planeta :: String
}deriving (Show,Eq)

mapPlaneta :: (String -> String) -> Personaje -> Personaje
mapPlaneta funcion personaje = personaje {planeta = funcion   (planeta personaje)}

mapNombre :: (String -> String) -> Personaje -> Personaje
mapNombre  funcion personaje = personaje {nombre  = funcion    (nombre personaje)}

mapEnergia :: (Float -> Float) -> Personaje -> Personaje
mapEnergia funcion personaje = personaje {energia  = funcion  (energia personaje)}

mapEdad :: (Int -> Int) -> Personaje -> Personaje
mapEdad funcion personaje = personaje {edad  = funcion  (edad personaje)}


chasquido :: Guantelete -> Universo -> [String]
chasquido guantelete universo | puedeChasquear guantelete = chauMitad universo
                              | otherwise = map nombre universo

puedeChasquear :: Guantelete -> Bool
puedeChasquear guantelete = (material guantelete) == "uru" && length (gemas guantelete) == 6 

chauMitad :: Universo -> [String]
chauMitad universo = map nombre  (drop (div (length universo) 2) universo)


--punto 2

esUniversoPendex :: Universo -> Bool
esUniversoPendex  = any $ ((<45).edad) 

energiaTotalUniverso :: Universo -> Float
energiaTotalUniverso  = sum.map energia.filter ((>1).length.habilidades)


--Segunda parte


--punto 3 


mente :: Float -> Gema 
mente personaje = quitarEnergia personaje

quitarEnergia :: Float -> Personaje -> Personaje
quitarEnergia valor personaje = personaje {energia = energia personaje - valor }



alma :: Habilidad -> Gema
alma habilidad personaje = quitarEnergia 10 personaje {habilidades = filter (/= habilidad) (habilidades personaje) }



espacio :: String -> Gema
espacio planeta personaje = quitarEnergia 20 (mapPlaneta (const planeta) personaje )



poder :: Gema 
poder personaje = quitarHabilidadesSegun 2 (quitarEnergia (energia personaje) personaje)

quitarHabilidadesSegun :: Int -> Personaje -> Personaje
quitarHabilidadesSegun cuanto personaje |length (habilidades personaje) <= 2  = personaje {habilidades = []}
                                        |otherwise = personaje


tiempo :: Gema 
tiempo = (quitarEnergia 50) . reducirEdad 

reducirEdad :: Personaje -> Personaje
reducirEdad personaje | (mitad (edad personaje)) < 18 = mapEdad (const 18) personaje 
                      | otherwise                     = mapEdad (const (mitad (edad personaje))) personaje

mitad :: Int -> Int
mitad edad = div edad 2


gemaLoca :: Gema -> Gema
gemaLoca gema = gema . gema  


--punto 4

guanteleteDeGoma :: Guantelete
guanteleteDeGoma = Guantelete {material = "goma", gemas = [tiempo,alma "usar Mjolnir" , gemaLoca (alma "programacion en Haskell")]}


-- punto 5

utilizar :: [Gema] -> Personaje -> Personaje
utilizar gemas enemigo = foldr ($) enemigo  gemas

-- punto 6

gemaMasPoderosa :: Personaje -> Guantelete -> Gema
gemaMasPoderosa  personaje guantelete = prueboGemas personaje $ (gemas guantelete) 


prueboGemas ::  Personaje -> [Gema] -> Gema
prueboGemas _  [gema]  = gema
prueboGemas  personaje (gema1:gema2:gemas)  | (energia . gema1) personaje < (energia . gema2) personaje = prueboGemas personaje (gema1 : gemas) 
                                            | otherwise = prueboGemas personaje (gema2 : gemas) 




-- punto 7

infinitasGemas :: Gema -> [ Gema ]
infinitasGemas gema = gema : ( infinitasGemas gema)

guanteleteDeLocos :: Guantelete
guanteleteDeLocos = Guantelete "vesconite" ( infinitasGemas tiempo )

usoLasTresPrimerasGemas :: Guantelete -> Personaje -> Personaje
usoLasTresPrimerasGemas guantelete = ( utilizar . take 3 . gemas) guantelete


{- 
gemaMasPoderosa spiderMan guanteleteDeLocos

ejecutar esa funcion, si "funciona", devuelve una funcion con la gema infinita, la cual cumple la condicion, si esa gema se la aplico a ironMan no para de calcular.

(B)

usoLasTresPrimerasGemas guanteleteDeLocos spiderMan

esta funciona, porque el take 3 de la funcion "usoLasTresPrimerasGemas" toma 3 de la lista infinitas de gemas, esto significa, que haskell va a generar esas 3 y listo
no va a seguir con la lista infinita de gemas, y ahora tengo una lista de 3 gemas, y utilizo la funcion utilizar, como normal, una lista de 3 gemas.

Si no estuviese el take 3, la funcion se trabaria, porque aplicaria la funcion utilizar a una lista infinita de gemas, es decir que no va a parar de aplicarle las gemas a un 
personaje.


-}
