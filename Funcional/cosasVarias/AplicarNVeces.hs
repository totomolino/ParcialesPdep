import Text.Show.Functions


aplicarNVeces :: Int -> (a -> a) -> a -> a

aplicarNVeces number funcion valor = foldr ($) valor (replicate number funcion)


hacerLista :: Int -> (a -> b) -> [(a -> b)]

hacerLista number funcion = replicate number funcion 




