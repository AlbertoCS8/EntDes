/*Alberto Collantes Sánchez 1DAW A*/
package arraysmultidimensionales;

import java.util.Scanner;


public class Practica2 {
    static Scanner teclado = new Scanner(System.in);
    
    public static void imprimir1 (float[][] madera)
    {
    float suma1mm=0,suma3mm=0,suma5mm=0,suma7mm=0;
    for (int i=0;i<madera.length;i++)/*Bucle de 1mm*/
    {
    suma1mm=madera[i][0] + suma1mm; /*AQUI PONEMOS EL 0 QUE SON LAS COLUMNAS XORRESPONDIENTES A 1 MM*/
    }
    for(int i=0;i<madera.length;i++)/*BUCLE 3 MM*/
    {
    suma3mm=madera[i][1] + suma3mm;/*IGUAL PERO CON LOS 3 MM*/
    }
     for(int i=0;i<madera.length;i++)/*BUCLE 5 MM*/
    {
    suma5mm=madera[i][2] + suma5mm;
    }
     for(int i=0;i<madera.length;i++)/*BUCLE 7 MM*/
    {
    suma7mm=madera[i][3] + suma7mm;
    }
        System.out.println("Estos son los resultados");
        System.out.println("sumatorio de precios de 1MM:  "+suma1mm);
        System.out.println("sumatorio de precios de 3MM:  "+suma3mm);
        System.out.println("sumatorio de precios de 5MM:  "+suma5mm);
        System.out.println("sumatorio de precios de 7MM:  "+suma7mm);
    
    }
    
    public static void imprimir2(float [][]madera){
        
        System.out.println("Dime de qué madera quieres sacar la media de precio");
        System.out.println("Me valen empezando por mayus o minus");
        System.out.println("1= pino 2= roble 3 = caoba");
        int opcion;
        opcion=teclado.nextInt(); /*AQUI LO HE PUESTO PARA ELEGIR CON UN ENTERO PORWUE CON STRING NO ME LOS COMPARA Y SI PONGO LINE NI SIQUIIERA ME DEJA INTRODUCIRLE VALOR AL STRING*/
        float mediaPino=0;
        float mediaRoble=0;
        float mediaCaoba=0;
        if (opcion == 1)
        {
            for(int i =0;i<1;i++){
                for (int j = 0; j < 3; j++) {
                    if (j!=2){
                    mediaPino=madera[i][j] + mediaPino;
                    }
                }
                                }
        }
          if (opcion == 2)
        {
            for(int i =1;i<2;i++){
                for (int j = 0; j < 3; j++) {
                    if (j!=2){
                    mediaRoble=madera[i][j] + mediaRoble;
                    }
                }
                System.out.println("prueba");
                                }
        }
            if (opcion == 3)
        {
            for(int i =2;i<3;i++){
                for (int j = 0; j < 3; j++) {
                    if (j!=2){
                    mediaCaoba=madera[i][j] + mediaCaoba;
                    }
                }
                                }
        }
        
    }
    
    public static void main(String[] args) {
       float[][] madera = new float[3][4];
       for (int i = 0; i < madera.length; i++) {
            for (int j = 0; j < madera[i].length; j++) {
                System.out.println("Introduce el valor ["+i+"]["+j+"]");
                madera[i][j]=teclado.nextFloat();
            }
            
        }
        for (int i = 0; i!= 3;) {
            System.out.println("Introduce la opcion que prefieras");
            System.out.println("1 Llamar a la funcion para que imprima la suma de los milimetros");
            System.out.println("2 Llamara a la funcion a la que se le pasa un tipo de madera");
            System.out.println("3 Salir");
            i=teclado.nextInt();
            if (i==1){
            imprimir1(madera);
            }   
            if (i==2){
            imprimir2(madera); /*AQUI NO SE POR QUE NO ME DEJA METER LA OPCION,SIMPLEMENTE PASA DE MI*/
            }
            if (i==3){
            break;
            }
            if (i<0 || i>3)
            {
                System.out.println("Introduce una opcion correcta");
            }
                                }
        }
    }
    
