{-
zipWithIf :: (a -> b -> b) -> (b -> Bool) -> [a] -> [b] -> [b] 
zipWithIf funcion1 funcion2 [] []                      = []
zipWithIf funcion1 funcion2 [] (cabezaLista2)          = cumpleLaCondicion funcion1 funcion2 0 cabezaLista2 
zipWithIf funcion1 funcion2 (cabezaLista1) []          = []
zipWithIf funcion1 funcion2 (cabezaLista1:colaLista1) (cabezaLista2:colaLista2) = cumpleLaCondicion funcion1 funcion2 cabezaLista1 cabezaLista2 : zipWithIf funcion1 funcion2 colaLista1 colaLista2



cumpleLaCondicion :: (a -> b -> b) -> (b -> Bool) -> a -> b -> b
cumpleLaCondicion funcion1 funcion2 cabezaLista1 cabezaLista2 
      | funcion2 cabezaLista2 = funcion1 cabezaLista1 cabezaLista2
      | otherwise = cabezaLista2

      -}

zipWithIf :: (a -> b -> b) -> (b -> Bool) -> [a] -> [b] -> [b] 
--zipWithIf funcion condicion lista1 lista2 = zipWith funcion lista1 (filter condicion lista2)


zipWithIf funcion condicion (x:y:z) (a:b:c) = 
    