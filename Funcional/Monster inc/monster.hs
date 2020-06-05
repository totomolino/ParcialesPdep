import Text.Show.Functions

type Grito = ( String , Int , Bool )

onomatopeya :: Grito -> String
onomatopeya (x,_,_) = x

intensidad :: Grito -> Int
intensidad   (_,x,_) = x

mojoLaCama :: Grito -> Bool
mojoLaCama  (_,_,x) = x

-- Punto 1

energiaDeGrito :: Grito -> Int
energiaDeGrito unGrito 
 |mojoLaCama unGrito = (* cuadrado (intensidad unGrito)) . nivelTerror $ unGrito
 |otherwise          = (+ intensidad unGrito) . (*3) . nivelTerror $ unGrito

cuadrado :: Int -> Int
cuadrado x = x * x

nivelTerror :: Grito -> Int
nivelTerror unGrito = length . onomatopeya $ unGrito

-- Punto 2

type Nene = (String , Int , Double)

nombre :: Nene -> String
nombre (x,_,_) = x

edad  :: Nene -> Int
edad    (_,x,_) = x

altura :: Nene -> Double
altura  (_,_,x) = x


ninio :: Nene
ninio = ("juan" , 2 , 150)

type Mounstruo = Nene -> Grito

sullivan :: Mounstruo
sullivan nino = (gritoGenerado,intensidadGenerada,haceMojarLaCama)
 where gritoGenerado      = map (\ _ -> 'A') (nombre nino) ++ "GH"
       intensidadGenerada = div 20 . edad $ nino
       haceMojarLaCama    = (edad nino) < 3
       