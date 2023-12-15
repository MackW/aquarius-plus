1 REM Char-based Greyscale Mandelbrot, 80 Column
2 SET FAST ON
3 SCREEN 3
5 CLS 15,0
6 GOSUB _OPGET
7 GOSUB _NPSET
8 LOCATE 30,22
9 PRINT"Generating Mandelbrot"
10 LOCATE 28,22
15 FOR Y=-2 TO 2 STEP 0.2
20 FOR X=-2 TO 2 STEP 0.1
30 N=0
40 V=X
50 W=Y
60 IF V*V+W*W<4 AND N<15 THEN 140
70 A=Y*5+10
80 B=X*10+20
90 REM P=13392+B+A*40
91 P=(B+A*80)+22
95 REM P2=12368+B+A*40
96 P2=(B+A*80)+22
100 POKE COLOR P,(N*(N+1))+N
101 POKE SCREEN P2,134
110 NEXTX
120 NEXTY
130 GOTO 190
140 Z=V
150 V=V*V-W*W+X
160 W=2*W*Z+Y
170 N=N+1
180 GOTO 60
190 LOCATE 30,22
200 PRINT"Press any key to exit"
205 LOCATE 39,11
210 K=GETKEY
300 GOSUB _OPSET
400 CLS
500 SET FAST OFF
600 END
1000 _OPGET
1005 REM Save original palette
1010 OP$=GETPALETTE$(0)
1020 RETURN
1100 _NPSET
1110 REM Define Greyscale Palette
1120 DEF RGBLIST N1$=0,0,0;1,1,1;2,2,2;3,3,3
1130 DEF RGBLIST N2$=4,4,4;5,5,5;6,6,6;7,7,7
1140 DEF RGBLIST N3$=8,8,8;9,9,9;10,10,10;11,11,11
1150 DEF RGBLIST N4$=12,12,12;13,13,13;14,14,14;15,15,15
1160 NP$ = N1$+N2$+N3$+N4$
1170 SET PALETTE 0 TO NP$
1199 RETURN
1200 _OPSET
1201 REM Restore original palette
1210 SET PALETTE 0 TO OP$
1212 CLS
1215 SCREEN 1
1217 CLS
1220 RETURN
