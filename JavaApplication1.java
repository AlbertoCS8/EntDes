
package javaapplication1;

public class JavaApplication1 
{
public enum Dias {Lunes, Martes, Miercoles, Jueves, Viernes, Sabado, Domingo};
final double PI=3.1415926536;   //PI es una constante
int x;  
                                //de clase JavaApplication1
int obtenerX(int x) 
     {                         //x es un parametro
     int valorantiguo = this.x; //valorantiguo es una variable local
     return valorantiguo;
     }
       //el metodo main comienza la ejecucion de la aplicacion

        public static void main(String[] args) 
        {
        // TODO code application logic here
            int i = 10;
            double d = 3.14;
            char c1 = 'a';
            char c2 = 65;
            boolean encontrado = true;
            String msj = "Bienvenido a Java";
            
            System.out.println("La variable i es entera " + i);
            System.out.println("La variable f es double " + d);
            System.out.println("La variable c1 es caracter " + c1);
            System.out.println("La variable c2 es caracter " + c2);
            System.out.println("La variable encontrado es booleano " + encontrado);
            System.out.println("La variable msj es string " + msj);
            Dias diaactual = Dias.Martes;
            Dias diasiguiente = Dias.Miercoles;
            
            
            System.out.print("Hoy es ");
            System.out.println(diaactual);
            System.out.println("Mañana\nes\n" +diasiguiente);
            
        } //final del programa
    
}
