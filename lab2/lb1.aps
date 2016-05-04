;***** Программа к лабораторной работе №2 (стенд EV8031/AVR) *****
;подключение файла, содержащего описание регистров и адресов для ATmega8515
.include "m8515def.inc"

;*** Назначение символических имен регистров ***

.def temp = r16		;регистр временного хранения
.def dig = r17		;регистр хранения выводимых на индикатор чисел (в 16-формате) 
.def counter = r18	;счетчик цикла в подпрограмме генерации задержки
.def counter1 = r20 ;счетчик количества пройденных состояний
.def plus = r19		;регистр, хранящий число, добавляемое к маске
.def long_delay_low = r24	;младший байт счетчика длинной задержки
.def long_delay_high = r25	;старший байт счетчика длинной задержки

;*** Назначение констант ***

;адрес линейки светодиодов в стенде
.EQU led_line = 0xA006
;адрес двух левых знакомест статического семисегментного индикатора
.EQU stat_7seg_left = 0xA000
;адрес двух правых знакомест статического семисегментного индикатора
.EQU stat_7seg_right = 0xB000
;адрес регистра управления точками и зажиганием знакомест статического семисегментного индикатора
.EQU stat_7seg_control = 0xA004

;***** Начало программы *****

.CSEG		;определяем начало сегмента кода
.ORG 0x0000	;определяем адрес начала сегмента кода в памяти программ

;*** Вектор прерываний контроллера ***
	rjmp Init ; вектор прерывания по сбросу
	reti;rjmp EXT_INT0 ; IRQ0 Handler
	reti;rjmp EXT_INT1 ; IRQ1 Handler
	reti;rjmp TIM1_CAPT ; Timer1 Capture Handler
	reti;rjmp TIM1_COMPA ; Timer1 Compare A Handler
	reti;rjmp TIM1_COMPB ; Timer1 Compare B Handler
	reti;rjmp TIM1_OVF ; Timer1 Overflow Handler
	reti;rjmp TIM0_OVF ; Timer0 Overflow Handler
	reti;rjmp SPI_STC ; SPI Transfer Complete Handler
	reti;rjmp USART_RXC ; USART RX Complete Handler
	reti;rjmp USART_UDRE ; UDR0 Empty Handler
	reti;rjmp USART_TXC ; USART TX Complete Handler
	reti;rjmp ANA_COMP ; Analog Comparator Handler
	reti;rjmp EXT_INT2 ; IRQ2 Handler
	reti;rjmp TIM0_COMP ; Timer0 Compare Handler
	reti;rjmp EE_RDY ; EEPROM Ready Handler
	reti;rjmp SPM_RDY ; Store Program memory Ready

;*** Начальная инициализация контроллера ***

Init:
	ldi 	temp,	low(RAMEND)
	out 	SPL,	temp
	ldi 	temp,	high(RAMEND)
	out 	SPH,	temp	;установка SP на последний адрес SRAM
	sbi 	ACSR,	7		;отключение питания аналогового компаратора

	ldi 	temp, 	0b10000000	;разрешаем работу с внешней памятью
	out 	MCUCR, 	temp


;работаем со статическим семисегментным индикатором	
	clr 	dig		;обнуляем значение числа

;*** Переходим в бесконечный цикл ***

Infinite_loop:	;бесконечный цикл

	;начальная инициализация 
	ldi 	dig, 		0xFF	;заносим начальное значение, выводимое на индикатор
	ldi 	plus, 		0x01	;заносим число 11, на которое будет увеличиваться начальное
	ldi 	counter1, 	0x10	;заносим начальное значение счетчика (16)

Loop1:  			;цикл вывода значений на первое знакоместо
;устанавливаем указатель Z на адрес регистра управления статическим индикатором
	ldi 	ZL, 	low(stat_7seg_control)
	ldi 	ZH, 	high(stat_7seg_control)
	ldi 	temp, 	0x07	;выключаем все точки и зажигаем левое знакоместо 1
	st 		Z, 		temp		;выдаем эту маску на индикатор

;устанавливаем указатель Z на адрес левых знакомест статического индикатора
	ldi 	ZL, 	low(stat_7seg_right)
	ldi 	ZH, 	high(stat_7seg_right)

Loop1_1:

	st 		Z, 		dig			;выдаем маску на индикатор

	rcall 	long_delay		;вызываем задержку примерно 2 с
	
	sub 	dig, 	plus		;прибавляем к начальному значению маски число 11h
	dec 	counter1		;уменьшаем значение счетчика на 1

	breq	Loop2
	rjmp	Loop1_1

Loop2:
	;начальная инициализация 
	ldi 	dig, 		0xFF	;заносим начальное значение, выводимое на индикатор
	ldi 	plus, 		0x10	;заносим число 11, на которое будет увеличиваться начальное
	ldi 	counter1, 	0x10	;заносим начальное значение счетчика (16)
;устанавливаем указатель Z на адрес регистра управления статическим индикатором
	ldi 	ZL, 	low(stat_7seg_control)
	ldi 	ZH, 	high(stat_7seg_control)

	ldi 	temp, 	0x0B	;выключаем все точки и зажигаем левое знакоместо 2
	st 		Z, 		temp		;выдаем эту маску на индикатор

	;устанавливаем указатель Z на адрес левых знакомест статического индикатора
	ldi 	ZL, 	low(stat_7seg_right)
	ldi 	ZH, 	high(stat_7seg_right)

Loop2_1:

	st 		Z, 		dig			;выдаем маску на индикатор

	rcall 	long_delay		;вызываем задержку примерно 2 с
	
	sub 	dig, 	plus		;прибавляем к начальному значению маски число 11h
	dec 	counter1		;уменьшаем значение счетчика на 1

	breq	Loop3
	rjmp	Loop2_1

Loop3:
;начальная инициализация 
	ldi 	dig, 		0xFF	;заносим начальное значение, выводимое на индикатор
	ldi 	plus, 		0x01	;заносим число 11, на которое будет увеличиваться начальное
	ldi 	counter1, 	0x10	;заносим начальное значение счетчика (16)
;устанавливаем указатель Z на адрес регистра управления статическим индикатором
	ldi 	ZL, 	low(stat_7seg_control)
	ldi 	ZH, 	high(stat_7seg_control)

	ldi 	temp, 	0x0D	;выключаем все точки и зажигаем левое знакоместо 2
	st 		Z, 		temp		;выдаем эту маску на индикатор

	;устанавливаем указатель Z на адрес левых знакомест статического индикатора
	ldi 	ZL, 	low(stat_7seg_left)
	ldi 	ZH, 	high(stat_7seg_left)

Loop3_1:

	st 		Z, 		dig		;выдаем эту маску на индикатор

	rcall 	long_delay		;вызываем задержку примерно 2 с
	
	sub 	dig, 	plus		;прибавляем к начальному значению маски число 11h
	dec 	counter1		;уменьшаем значение счетчика на 1

	breq	Loop4
	rjmp	Loop3_1

Loop4:
;начальная инициализация 
	ldi 	dig, 		0xFF	;заносим начальное значение, выводимое на индикатор
	ldi 	plus, 		0x10	;заносим число 11, на которое будет увеличиваться начальное
	ldi 	counter1, 	0x10	;заносим начальное значение счетчика (16)
;устанавливаем указатель Z на адрес регистра управления статическим индикатором
	ldi 	ZL, 	low(stat_7seg_control)
	ldi 	ZH, 	high(stat_7seg_control)

	ldi 	temp, 	0x0E	;выключаем все точки и зажигаем левое знакоместо 2
	st 		Z, 		temp		;выдаем эту маску на индикатор

	;устанавливаем указатель Z на адрес левых знакомест статического индикатора
	ldi 	ZL, 	low(stat_7seg_left)
	ldi 	ZH, 	high(stat_7seg_left)

Loop4_1:

	st 		Z, 		dig		;выдаем эту маску на индикатор

	rcall 	long_delay		;вызываем задержку примерно 2 с
	
	sub 	dig, 	plus		;прибавляем к начальному значению маски число 11h
	dec 	counter1		;уменьшаем значение счетчика на 1

	breq 	Infinite_loop		;переход если счетчик равен 0
	rjmp 	Loop4_1

;*** Подпрограмма длинной задержки ***
long_delay:
;* Если в регистровую пару загрузить число 18432 (4800h), то задержка будет около 2 секунд

;* Примерная формула расчета коэффициента при кварце в 7.3728 МГц такая:
;* 800 x коэффициент задержки / (7.3728*1 000 000) = требуемое время в с

	ldi long_delay_low,0x00	;загрузка в регистровую пару коэффициента задержки 
	ldi long_delay_high,0x24	;(4800h), это будет задержка на 2 с

long_loop:	;тело цикла занимает 796 + 2 + 2 = 800 тактов
	rcall short_delay		;короткая задержка
	sbiw long_delay_high:long_delay_low,0b00000001	;вычитание из пары числа 1 (декремент длинного счетчика)
	brne long_loop	;если не 0,повторить цикл

	ret			;возврат в основную программу

;*** Подпрограмма короткой задержки (нужна для генерации длинных задержек) ***
short_delay:	;вся подпрограмма занимает ровно 796 тактов вместе с rcall и ret
	nop
	ldi counter,0xC5	;счетчик цикла	
short_loop:
	nop
	dec counter
	brne short_loop	;команда ветвления по флагу нуля (зацикливание)
	ret			;возврат в основную программу
.EXIT			;конец программы
