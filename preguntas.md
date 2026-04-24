Conceptos de SQL

1. ¿Qué hace un JOIN?
Básicamente, un JOIN sirve para combinar información de dos o más tablas en una sola consulta. Imaginate que tenés una tabla de clientes y otra de pedidos, con JOIN podés traer todo junto y ver qué cliente hizo qué pedido, sin tener que hacer consultas por separado.

2. Diferencia entre los tipos de JOIN
Todos unen tablas, pero la diferencia está en qué registros incluyen en el resultado:

INNER JOIN — Solo trae los registros que tienen coincidencia en ambas tablas. Si un dato no tiene pareja en la otra tabla, no aparece.
LEFT JOIN — Trae todos los registros de la tabla izquierda, y los que coincidan de la derecha. Si no hay coincidencia en la derecha, aparece como vacío (NULL).
RIGHT JOIN — Es lo opuesto al LEFT JOIN. Trae todos los de la tabla derecha, y los que coincidan de la izquierda.
FULL JOIN — Trae absolutamente todo de ambas tablas, coincidan o no. Donde no hay coincidencia, rellena con NULL.


3. ¿Qué es una clave foránea?
Una clave foránea es un campo en una tabla que hace referencia al identificador principal de otra tabla. Sirve para conectar las dos tablas entre sí y mantener la coherencia de los datos. Por ejemplo, en una tabla de pedidos puede haber un campo id_cliente que apunta a la tabla de clientes, eso sería la clave foránea.

4. ¿Qué es una relación muchos a muchos?
Es cuando un registro de una tabla puede relacionarse con varios de otra, y viceversa. Por ejemplo, un estudiante puede estar inscrito en varios cursos, y un curso puede tener varios estudiantes. Para manejar este tipo de relación en una base de datos, normalmente se crea una tabla intermedia que conecta ambas.

5. ¿Para qué sirve GROUP BY?
GROUP BY se usa para agrupar filas que tienen el mismo valor en una columna, generalmente para hacer cálculos sobre esos grupos. Por ejemplo, si querés saber cuántos pedidos hizo cada cliente, agrupás por cliente y contás. Sin GROUP BY, no podrías hacer ese tipo de resumen.

6. ¿Qué hace HAVING?
HAVING funciona parecido al WHERE, pero con una diferencia clave: se usa después de un GROUP BY, es decir, filtra sobre los grupos ya formados, no sobre los registros individuales. Por ejemplo, si solo querés ver los clientes que hicieron más de 5 pedidos, usás HAVING para esa condición. Con WHERE no se puede hacer eso directamente cuando hay agrupaciones de por medio.



