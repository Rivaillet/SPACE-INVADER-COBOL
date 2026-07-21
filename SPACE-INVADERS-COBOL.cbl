       IDENTIFICATION DIVISION.
       PROGRAM-ID. SPACE-INVADERS.
       DATA DIVISION. 
       WORKING-STORAGE SECTION. 

       77  WINDOW-SHOULD-CLOSE PIC S9(9) COMP-5 VALUE 0.
       77  IS-PRESSED          PIC 9 COMP-X VALUE 0.
 
      *> ------------   CÓDIGOS DE TECLADO DE RAYLIB  ---------

       77  KEY-RIGHT           PIC S9(9) COMP-5 VALUE 262.
       77  KEY-LEFT            PIC S9(9) COMP-5 VALUE 263.
       77  KEY-DOWN            PIC S9(9) COMP-5 VALUE 264.
       77  KEY-UP              PIC S9(9) COMP-5 VALUE 265.
      *> ------------------------------------------------------
      *> --------------   DATOS DEL JUGADOR -------------------
       
      *> POSICION INICIAL DEL JUGADOR
       77  PLAYER-X            PIC S9(9) COMP-5 VALUE 380.
       77  PLAYER-Y            PIC S9(9) COMP-5 VALUE 280.
      *> TAMAÑO DEL JUGADOR 
       77  PLAYER-WIDTH        PIC S9(9) COMP-5 VALUE 30.
       77  PLAYER-HEIGHT       PIC S9(9) COMP-5 VALUE 30.
      *> "VELOCIDAD DEL JUGADOR"
       77  PLAYER-SPEED        PIC S9(9) COMP-5 VALUE 6.

      *> -------------------------------------------------------

      *> ---------------- PALETA DE COLORES EN HEXADECIMAL -----

       77  BLACK-COLOR         PIC 9(10) COMP-5 VALUE 4278190080.
       77  RED-COLOR           PIC 9(10) COMP-5 VALUE 4278190335.
       77  WHITE-COLOR         PIC 9(10) COMP-5 VALUE 4294967295.


       PROCEDURE DIVISION.

       0000-MAIN.

           CALL "InitWindow" USING BY VALUE 800 
                                   BY VALUE 600
                                   BY REFERENCE Z"SPACE INVADERS 1.0".

           CALL "SetTargetFPS" USING BY VALUE 60.


           PERFORM 1000-JUEGO UNTIL WINDOW-SHOULD-CLOSE = 1.
           
           CALL "CloseWindow".
           GOBACK.
       
       1000-JUEGO.

           CALL "WindowShouldClose" RETURNING WINDOW-SHOULD-CLOSE.

      *> ------------ MOVIMIENTOS DEL JUGADOR -------------------
      *> Se comprueba si el boton es pulsado , si es pulsado se suma la velocidad
      *> a las coordenadas x-y dependiendo de que boton haya sido pulsado.

      *> MOVER DERECHA

           CALL "IsKeyDown" USING BY VALUE KEY-RIGHT 
                                     RETURNING IS-PRESSED.
           IF   IS-PRESSED NOT = 0
           THEN ADD PLAYER-SPEED TO PLAYER-X
           END-IF.

      *> MOVER IZQUIERDA

           CALL "IsKeyDown" USING BY VALUE KEY-LEFT 
                                     RETURNING IS-PRESSED.
           IF   IS-PRESSED NOT = 0 
           THEN SUBTRACT PLAYER-SPEED FROM PLAYER-X
           END-IF.
        
      *> MOVER ABAJO

           CALL "IsKeyDown" USING BY VALUE KEY-DOWN  
                                     RETURNING IS-PRESSED.
           IF   IS-PRESSED NOT = 0 
           THEN ADD PLAYER-SPEED TO PLAYER-Y 
           END-IF.
       
      *> MOVER ARRIBA

           CALL "IsKeyDown" USING BY VALUE KEY-UP  
                                     RETURNING IS-PRESSED.
           IF   IS-PRESSED NOT = 0 
           THEN SUBTRACT PLAYER-SPEED FROM PLAYER-Y 
           END-IF.


      *>REGLA PARA QUE NO SE SALGA EL JUGADORE DE LA PANTALLA

           IF   PLAYER-X < 0
           THEN MOVE 0 TO PLAYER-X
           END-IF.

           IF   PLAYER-X > 760
           THEN MOVE 760 TO PLAYER-X 
           END-IF.

           IF   PLAYER-Y < 0
           THEN MOVE 0 TO PLAYER-Y
           END-IF.

           IF   PLAYER-Y > 560
           THEN MOVE 560 TO PLAYER-Y
           END-IF.

      *>  ---------- METODO QUE PINTA LA PANTALLA "oculta" ---------------
           CALL "BeginDrawing".
           CALL "ClearBackground" USING BY VALUE BLACK-COLOR.
           CALL "DrawRectangle"   USING BY VALUE PLAYER-X 
                                        BY VALUE PLAYER-Y 
                                        BY VALUE PLAYER-WIDTH 
                                        BY VALUE PLAYER-HEIGHT 
                                        BY VALUE RED-COLOR.
           CALL "DrawText"        USING BY REFERENCE Z"BIENVENIDO AL SPACE INVADER!"
                                        BY VALUE 10
                                        BY VALUE 10
                                        BY VALUE 20 
                                        BY VALUE WHITE-COLOR.
           CALL "EndDrawing".


             

            
           