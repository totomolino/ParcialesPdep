import Text.Show.Functions

-----------
--punto 1--
-----------

type CondicionViaje = Viaje -> Bool

data Chofer = Chofer {nombre :: String , kilometraje :: Int , viajes :: [Viaje] ,  condicionViaje :: CondicionViaje } deriving (Show)

data Cliente = Cliente {nombreCliente :: String , lugar :: String} deriving (Show)

data Viaje = Viaje {fecha :: (Int,Int,Int) , cliente :: Cliente , costo :: Float} deriving (Show)






manuel = Cliente {nombreCliente = "Manuel" , lugar = "centenario 1187"}

viajeCorto = Viaje {fecha = (12,12,12) , cliente = manuel , costo = 250}

pepe = Chofer {nombre = "pepe" , kilometraje = 15000 , viajes = [viajeCorto] , condicionViaje = condicionMenosDe200 }

-----------
--punto 2--
-----------


cualquierViaje :: CondicionViaje
cualquierViaje _ = True

condicionMenosDe200 :: CondicionViaje
condicionMenosDe200 = (>200).costo

clienteNLetras :: Int -> CondicionViaje
clienteNLetras n = (>n).length.nombreCliente.cliente

clienteNoViveEn :: String -> CondicionViaje
clienteNoViveEn casa = (/= casa).lugar.cliente


-----------
--punto 3--
-----------

lucas = Cliente {nombreCliente = "Lucas" , lugar = "Victoria" }

viajeConLucas = Viaje {fecha = (20,04,2017) , cliente = lucas , costo = 150}

daniel = Chofer {nombre = "Daniel" , kilometraje = 23500 , viajes = [viajeConLucas] , condicionViaje = (clienteNoViveEn "Olivos")}

alejandra = Chofer {nombre = "Alejandra" , kilometraje = 180000 , viajes = [] , condicionViaje = cualquierViaje}


-----------
--punto 4--
-----------

choferTomaViaje :: Chofer -> Viaje -> Bool

choferTomaViaje chofer viaje =  condicionViaje chofer $ viaje 

-----------
--punto 5--
-----------

liquidacionDeChofer :: Chofer -> Float

liquidacionDeChofer = sum. map costo . viajes 

