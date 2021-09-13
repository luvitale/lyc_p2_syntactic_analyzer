# Práctica de Analizador Léxico

> Sintaxis y gramáticas

1. Desarrollar una gramática en formato BNF para reconocer expresiones aritméticas simples (sumas, restas, multiplicaciones y divisiones) que operan con constantes enteras e identificadores (Utilizar tokens para los elementos léxicos)

2. Desarrollar una gramática igual a la anterior donde la multiplicación y división tenga prioridad sobre la suma y la resta.

3. Agregar a la gramática anterior la posibilidad de incorporar expresiones entre paréntesis.

4. 

a) Desarrollar una BNF/GLC para reconocer asignaciones simples. Estas deben tener un Left Side y un Right Side. El Left Side debe ser un identificador y el Right Side una expresión aritmética simple que soporte sumas, restas, multiplicaciones, divisiones y expresiones entre paréntesis (Utilizar tokens para los elementos léxicos)

b) Hacer un árbol de parsing para el siguiente programa:

```
actual:= (contador/342) + (contador*contador);
```

5. En algunos lenguajes de programación se permite la asignación múltiple, en la que varias variables pueden recibir el mismo valor. Los que siguen son algunos ejemplos de sentencias en los que se hace uso de esta forma de escritura:

```
a:=inc:=minimo:=expresion;
total:=precio:=expresion;
```

a) Escriba en BNF la sintaxis de este tipo de asignaciones con las siguientes condiciones: la sentencia debe terminar con “;” y el valor de la derecha debe ser una expresión como la desarrollada en el ejercicio 3

b) Hacer el árbol de parsing para el siguiente programa:

```
actual:=promedio:=contador:= promedio/342 + (contador*contador);
```

6. Definir una BNF/GLC que soporte programas que tengan asignaciones simples como las del ejercicio 4 y asignaciones múltiples como las del ejercicio anterior. Estos programas pueden tener una sentencia o muchas sentencias. Cada sentencias finaliza con ;
> Los programas de este tipo deben comenzar con la palabra reservada INICIO y finalizar con FIN.

7. Verificar si el siguiente fragmento es válido para la gramática definida en el ejercicio 6

```
INICIO
contador:= 0;
actual:=contador:= 999;
contador: contador + 1/(actual *34);
FIN
```