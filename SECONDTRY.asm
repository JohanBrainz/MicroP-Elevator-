		ORG 3000H
DATA7SEG:	DFB 00000110B, 01011011B, 01001111B,
		DFB 01100110B, 01101101B, 01111101B,
		DFB 00000111B, 01111111B, 01100111B,
		HLT

	ORG	0000H
	LXI	SP,3FF0H
	LXI     D,DATA7SEG
	PUSH	D

PA1:	EQU	60H
PB1:	EQU	61H
PC1: 	EQU	62H
CTRL1:	EQU	63H

PA2:	EQU	70H
PB2:	EQU	71H
PC2:	EQU	72H
CTRL2:	EQU	73H

PA3:	EQU	80H
PB3:	EQU	81H
PC3:	EQU	82H
CTRL3:	EQU	83H



	MVI	A,10000000B	;PORTBINPUT
	OUT	CTRL1	
	OUT	CTRL2	
	MVI	A,10010010B	;PPI3
	OUT	CTRL3

CHECK1:	IN 	PA3
	ANI	 10H
	JZ	CHECK1

CHECK2:	IN 	PA3
	ANI 	10H
	JNZ	CHECK2

;MAIN:	LXI	H,DATA7SEG
;	IN	PA3		;GET INPUT VALUE FROM PORTB
;	MOV	C,A		;MOVE THE VALUE INTO REG C
;	MVI	B,00H		;MOVE 00H TO REG B
;	DAD	B		;ADD REG PAIR HL AND BC TO FIND COLUMN AND ROW FOR VALUE IN TABLE
;	MOV 	A,M		;RESULT IS TRANSFER TO ACC
;	OUT	PA1		;VALUE FROM ACC IS SEND TO OUTPUT (7SEG)
;	JMP 	MAIN		;JUMP BACK TO MAIN

;UNTUK COUNTER MASUK DLM REGISTER
MAIN:	LXI	H,DATAKEY
	MVI	B,0H
	IN	PA3
	MOV 	C,A
	DAD	B
	MOV	A, M
	XCHG			;LDAX TAKBLEH M, SO KITA EXCHANGE DLU MSUK DE
	LDAX	D
	MOV	B,A
;	JMP	MAIN
;UNTUK COUNTER MASUK DLM REGISTER TAMAT


JOAN:		POP	D
NAIK:		LDAX	D
		
		OUT	PB1
		MVI	A,11111111B
		OUT	PC1
		CALL 	DELAY
		MVI	A,00000000B
		OUT	PC1
		INX	D
		DCR	B
		JNZ	NAIK
		PUSH	D
		JMP	CHECK3
		
		
DELAY:	MVI	C,40
LOOP:	DCR	C
	JNZ	LOOP
	RET
	
DATAKEY: DFB 	01H,02H,03H,0AH
	 DFB 	04H,05H,06H,0BH


	 DFB	07H,08H,09H,0CH
	 DFB	00H,00H,00H,0DH


CHECK3:	IN 	PA3
	ANI	 10H
	JZ	CHECK3

CHECK4:	IN 	PA3
	ANI 	10H
	JNZ	CHECK4

;MAIN:	LXI	H,DATA7SEG
;	IN	PA3		;GET INPUT VALUE FROM PORTB
;	MOV	C,A		;MOVE THE VALUE INTO REG C
;	MVI	B,00H		;MOVE 00H TO REG B
;	DAD	B		;ADD REG PAIR HL AND BC TO FIND COLUMN AND ROW FOR VALUE IN TABLE
;	MOV 	A,M		;RESULT IS TRANSFER TO ACC
;	OUT	PA1		;VALUE FROM ACC IS SEND TO OUTPUT (7SEG)
;	JMP 	MAIN		;JUMP BACK TO MAIN

;UNTUK COUNTER MASUK DLM REGISTER
	LXI	H,DATAKEY
	MVI	B,0H
	IN	PA3
	MOV 	C,A
	DAD	B
	MOV	A, M
	XCHG			;LDAX TAKBLEH M, SO KITA EXCHANGE DLU MSUK DE
	LDAX	D
	MOV	B,A

	POP	D
	MOV	A,B
	SUB	E
	MOV	B,A
	PUSH	D
	JMP	JOAN

