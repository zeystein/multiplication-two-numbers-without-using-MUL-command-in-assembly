    ORG 100

start:
        
MOV WORD PTR [0120h],0FFFFH  ;Carpanin 16-0 bitini bellege 
MOV WORD PTR [0122h],0FFFFH   ;Carpanin 32-16 bitini bellege    



MOV WORD PTR [0124h],0FFFFH   ;Carpilanin 16-0 bitini bellege 
MOV WORD PTR [0126h],0FFFFH   ;Carpilanin 32-16 bitini bellege  



MOV WORD PTR [0130h],0000h  ;CARPIMIN 16-0  arasinin bellek adresi
MOV WORD PTR [0132h],0000h  ;CARPIMIN 32-16 arasinin bellek adresi
MOV WORD PTR [0134h],0000h  ;CARPIMIN 48-32 arasinin bellek adresi
MOV WORD PTR [0136h],0000h  ;CARPIMIN 64-48 arasinin bellek adresi

SUB AX,AX
SUB BX,BX
SUB CX,CX
SUB DX,DX                                                    ; 1111 1111 1111 1110
SUB SI,SI
SUB DI,DI


MOV SI,32       ;Dongu sayaci 32  dec    

tekrar:                          ;BURDA BIT DUZEYINDE CARPMA YAPCAZ LSB KONTROL GEREK�RSSE TOPLAMA YAP 32 KEZ TEKRAR

MOV BX,[120h]  ; CARPAN�N 16-0 B�T�N� DISAA AKTAR
AND BX,01H 	; CARPAN�N LSB'SI DI�INDA D��ER B�TLER� 0LA ANDLE YAN� 0 YAP (LSBY� 1 LE ANDLE YAN� LSB ONCEDEN NEYSE SONRADAN DA O OLACAK)
XOR BX,01H	; CARPAN�N LSB B�T� 0 MI D�YE KONTROL ET 0 SA ZERO FLAG 0  A E��TLEN�R
JZ topla_kaydir ; CARPAN�N LSB B�T� 1 �SE ZERO FLAG 1 E E��TLEN�R VE JZ DEK� FONKS�YONA G�T
CLC	; CARPAN�N LSB B�T� 1 DEG�LD�R ZERO FLAG 0 DIR CARRY� TEM�ZLE         -->         CARPAN�N SON B�T SIFIRSA GEREK YOK B�RSE CARP�LANLA TOPL�CAZ


devam:

MOV AX,[0136h]
RCR AX,1        ;CARPIM SONUCUNUN 64-48 B�T�N� B�R SAGA KAYDIR
MOV [0136h],AX
MOV BX,[0134h]      
RCR BX,1        ;CARPIM SONUCUNUN 48-32 B�T�N� B�R SAGA KAYDIR
MOV [0134h],BX
MOV CX,[0132h]
RCR CX,1        ;CARPIM SONUCUNUN 32-16 B�T�N� B�R SAGA KAYDIR
MOV [0132h],CX	
MOV DX,[0130h]
RCR DX,1        ;CARPIM SONUCUNUN 16-0  B�T�N� B�R SAGA KAYDIR
MOV [0130h],DX	
  
MOV AX,[0122h]
SHR AX,1        ;CARPAN� B�R B�T SAGA KAYDIR
MOV [0122h],AX 
MOV BX,[0120h]
RCR BX,1        ;CARPAN� B�R B�T SAGA KAYDIR AMA CARRY �LE B�RL�KTE GEL�RSE YAN� CARPAN�N 32-16 B�T�NDEN GELEN ELDEY� DE KULLANARAK
MOV [0120h],BX 
   		
DEC SI		;DONGU DEG�SKEN�N� AZALT
CMP SI,0	;DEG�SKEN 0 MI D�YE BAK	
JNZ tekrar	;SIFIR DEG�, KONTROLCUYE G�T
JMP son		;UYGULAMAYI B�T�RMEYE G�T 


topla_kaydir:;LSB 1 oldugunda.carpilan, �carpimn ADD ve ADC komutlariyla ekle ve ard�ndan �
;carpim bitleri saga kaydirma icin devam etiketine git
                                                                                                ; 0010110110
                                                                                                ; 0000101100
MOV DX,[0124h]	;DX'E CARPILANIN 16-0 B�T�N� KOPYALA
ADD [0134h],DX  ;CARPIMIN 48-32 BITINE BURADA CARRY ONEMLI DEGIL
MOV DX,[0126h]  ;DX'E CARPILANIN 32-16 BITINI KOPYALA
ADC [0136h],DX  ;CARPIMIN 64-48 BITINE CARRY I GOZ ONUNE ALARAK ATA  cunku son kisim yuksek degerli carry eklencek 134ten gelen eldeyi goz onune al
JMP devam  


son:

HLT		;SONUCLAR MSB DEN LSB YE 0136H-0130H BELLEK GOZLERINDE TUTULMAKTADIR





