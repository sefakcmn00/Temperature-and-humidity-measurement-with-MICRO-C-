
_bcd_to_decimal:

;ds3231.c,140 :: 		uint8_t bcd_to_decimal(uint8_t number)
;ds3231.c,142 :: 		return ( (number >> 4) * 10 + (number & 0x0F) );
	MOVF        FARG_bcd_to_decimal_number+0, 0 
	MOVWF       R0 
	RRCF        R0, 1 
	BCF         R0, 7 
	RRCF        R0, 1 
	BCF         R0, 7 
	RRCF        R0, 1 
	BCF         R0, 7 
	RRCF        R0, 1 
	BCF         R0, 7 
	MOVLW       10
	MULWF       R0 
	MOVF        PRODL+0, 0 
	MOVWF       R1 
	MOVLW       15
	ANDWF       FARG_bcd_to_decimal_number+0, 0 
	MOVWF       R0 
	MOVF        R1, 0 
	ADDWF       R0, 1 
;ds3231.c,143 :: 		}
L_end_bcd_to_decimal:
	RETURN      0
; end of _bcd_to_decimal

_decimal_to_bcd:

;ds3231.c,146 :: 		uint8_t decimal_to_bcd(uint8_t number)
;ds3231.c,148 :: 		return ( ((number / 10) << 4) + (number % 10) );
	MOVLW       10
	MOVWF       R4 
	MOVF        FARG_decimal_to_bcd_number+0, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__decimal_to_bcd+0 
	RLCF        FLOC__decimal_to_bcd+0, 1 
	BCF         FLOC__decimal_to_bcd+0, 0 
	RLCF        FLOC__decimal_to_bcd+0, 1 
	BCF         FLOC__decimal_to_bcd+0, 0 
	RLCF        FLOC__decimal_to_bcd+0, 1 
	BCF         FLOC__decimal_to_bcd+0, 0 
	RLCF        FLOC__decimal_to_bcd+0, 1 
	BCF         FLOC__decimal_to_bcd+0, 0 
	MOVLW       10
	MOVWF       R4 
	MOVF        FARG_decimal_to_bcd_number+0, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        FLOC__decimal_to_bcd+0, 0 
	ADDWF       R0, 1 
;ds3231.c,149 :: 		}
L_end_decimal_to_bcd:
	RETURN      0
; end of _decimal_to_bcd

_alarm_cfg:

;ds3231.c,152 :: 		uint8_t alarm_cfg(uint8_t n, uint8_t i)
;ds3231.c,154 :: 		if( n & (1 << i) )
	MOVF        FARG_alarm_cfg_i+0, 0 
	MOVWF       R2 
	MOVLW       1
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        R2, 0 
L__alarm_cfg127:
	BZ          L__alarm_cfg128
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	ADDLW       255
	GOTO        L__alarm_cfg127
L__alarm_cfg128:
	MOVF        FARG_alarm_cfg_n+0, 0 
	ANDWF       R0, 1 
	MOVLW       0
	ANDWF       R1, 1 
	MOVF        R0, 0 
	IORWF       R1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_alarm_cfg0
;ds3231.c,155 :: 		return 0x80;
	MOVLW       128
	MOVWF       R0 
	GOTO        L_end_alarm_cfg
L_alarm_cfg0:
;ds3231.c,157 :: 		return 0;
	CLRF        R0 
;ds3231.c,158 :: 		}
L_end_alarm_cfg:
	RETURN      0
; end of _alarm_cfg

_RTC_Set:

;ds3231.c,161 :: 		void RTC_Set(RTC_Time *time_t)
;ds3231.c,164 :: 		time_t->day     = decimal_to_bcd(time_t->day);
	MOVLW       4
	ADDWF       FARG_RTC_Set_time_t+0, 0 
	MOVWF       FLOC__RTC_Set+0 
	MOVLW       0
	ADDWFC      FARG_RTC_Set_time_t+1, 0 
	MOVWF       FLOC__RTC_Set+1 
	MOVFF       FLOC__RTC_Set+0, FSR0L+0
	MOVFF       FLOC__RTC_Set+1, FSR0H+0
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_decimal_to_bcd_number+0 
	CALL        _decimal_to_bcd+0, 0
	MOVFF       FLOC__RTC_Set+0, FSR1L+0
	MOVFF       FLOC__RTC_Set+1, FSR1H+0
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;ds3231.c,165 :: 		time_t->month   = decimal_to_bcd(time_t->month);
	MOVLW       5
	ADDWF       FARG_RTC_Set_time_t+0, 0 
	MOVWF       FLOC__RTC_Set+0 
	MOVLW       0
	ADDWFC      FARG_RTC_Set_time_t+1, 0 
	MOVWF       FLOC__RTC_Set+1 
	MOVFF       FLOC__RTC_Set+0, FSR0L+0
	MOVFF       FLOC__RTC_Set+1, FSR0H+0
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_decimal_to_bcd_number+0 
	CALL        _decimal_to_bcd+0, 0
	MOVFF       FLOC__RTC_Set+0, FSR1L+0
	MOVFF       FLOC__RTC_Set+1, FSR1H+0
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;ds3231.c,166 :: 		time_t->year    = decimal_to_bcd(time_t->year);
	MOVLW       6
	ADDWF       FARG_RTC_Set_time_t+0, 0 
	MOVWF       FLOC__RTC_Set+0 
	MOVLW       0
	ADDWFC      FARG_RTC_Set_time_t+1, 0 
	MOVWF       FLOC__RTC_Set+1 
	MOVFF       FLOC__RTC_Set+0, FSR0L+0
	MOVFF       FLOC__RTC_Set+1, FSR0H+0
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_decimal_to_bcd_number+0 
	CALL        _decimal_to_bcd+0, 0
	MOVFF       FLOC__RTC_Set+0, FSR1L+0
	MOVFF       FLOC__RTC_Set+1, FSR1H+0
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;ds3231.c,167 :: 		time_t->hours   = decimal_to_bcd(time_t->hours);
	MOVLW       2
	ADDWF       FARG_RTC_Set_time_t+0, 0 
	MOVWF       FLOC__RTC_Set+0 
	MOVLW       0
	ADDWFC      FARG_RTC_Set_time_t+1, 0 
	MOVWF       FLOC__RTC_Set+1 
	MOVFF       FLOC__RTC_Set+0, FSR0L+0
	MOVFF       FLOC__RTC_Set+1, FSR0H+0
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_decimal_to_bcd_number+0 
	CALL        _decimal_to_bcd+0, 0
	MOVFF       FLOC__RTC_Set+0, FSR1L+0
	MOVFF       FLOC__RTC_Set+1, FSR1H+0
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;ds3231.c,168 :: 		time_t->minutes = decimal_to_bcd(time_t->minutes);
	MOVLW       1
	ADDWF       FARG_RTC_Set_time_t+0, 0 
	MOVWF       FLOC__RTC_Set+0 
	MOVLW       0
	ADDWFC      FARG_RTC_Set_time_t+1, 0 
	MOVWF       FLOC__RTC_Set+1 
	MOVFF       FLOC__RTC_Set+0, FSR0L+0
	MOVFF       FLOC__RTC_Set+1, FSR0H+0
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_decimal_to_bcd_number+0 
	CALL        _decimal_to_bcd+0, 0
	MOVFF       FLOC__RTC_Set+0, FSR1L+0
	MOVFF       FLOC__RTC_Set+1, FSR1H+0
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;ds3231.c,169 :: 		time_t->seconds = decimal_to_bcd(time_t->seconds);
	MOVF        FARG_RTC_Set_time_t+0, 0 
	MOVWF       FLOC__RTC_Set+0 
	MOVF        FARG_RTC_Set_time_t+1, 0 
	MOVWF       FLOC__RTC_Set+1 
	MOVFF       FARG_RTC_Set_time_t+0, FSR0L+0
	MOVFF       FARG_RTC_Set_time_t+1, FSR0H+0
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_decimal_to_bcd_number+0 
	CALL        _decimal_to_bcd+0, 0
	MOVFF       FLOC__RTC_Set+0, FSR1L+0
	MOVFF       FLOC__RTC_Set+1, FSR1H+0
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;ds3231.c,173 :: 		RTC_I2C_START();
	CALL        _I2C2_Start+0, 0
;ds3231.c,174 :: 		RTC_I2C_WRITE(DS3231_ADDRESS);
	MOVLW       208
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;ds3231.c,175 :: 		RTC_I2C_WRITE(DS3231_REG_SECONDS);
	CLRF        FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;ds3231.c,176 :: 		RTC_I2C_WRITE(time_t->seconds);
	MOVFF       FARG_RTC_Set_time_t+0, FSR0L+0
	MOVFF       FARG_RTC_Set_time_t+1, FSR0H+0
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;ds3231.c,177 :: 		RTC_I2C_WRITE(time_t->minutes);
	MOVLW       1
	ADDWF       FARG_RTC_Set_time_t+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       0
	ADDWFC      FARG_RTC_Set_time_t+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;ds3231.c,178 :: 		RTC_I2C_WRITE(time_t->hours);
	MOVLW       2
	ADDWF       FARG_RTC_Set_time_t+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       0
	ADDWFC      FARG_RTC_Set_time_t+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;ds3231.c,179 :: 		RTC_I2C_WRITE(time_t->dow);
	MOVLW       3
	ADDWF       FARG_RTC_Set_time_t+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       0
	ADDWFC      FARG_RTC_Set_time_t+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;ds3231.c,180 :: 		RTC_I2C_WRITE(time_t->day);
	MOVLW       4
	ADDWF       FARG_RTC_Set_time_t+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       0
	ADDWFC      FARG_RTC_Set_time_t+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;ds3231.c,181 :: 		RTC_I2C_WRITE(time_t->month);
	MOVLW       5
	ADDWF       FARG_RTC_Set_time_t+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       0
	ADDWFC      FARG_RTC_Set_time_t+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;ds3231.c,182 :: 		RTC_I2C_WRITE(time_t->year);
	MOVLW       6
	ADDWF       FARG_RTC_Set_time_t+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       0
	ADDWFC      FARG_RTC_Set_time_t+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;ds3231.c,183 :: 		RTC_I2C_STOP();
	CALL        _I2C2_Stop+0, 0
;ds3231.c,184 :: 		}
L_end_RTC_Set:
	RETURN      0
; end of _RTC_Set

_RTC_Get:

;ds3231.c,187 :: 		RTC_Time *RTC_Get()
;ds3231.c,189 :: 		RTC_I2C_START();
	CALL        _I2C2_Start+0, 0
;ds3231.c,190 :: 		RTC_I2C_WRITE(DS3231_ADDRESS);
	MOVLW       208
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;ds3231.c,191 :: 		RTC_I2C_WRITE(DS3231_REG_SECONDS);
	CLRF        FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;ds3231.c,192 :: 		RTC_I2C_RESTART();
	CALL        _I2C2_Repeated_Start+0, 0
;ds3231.c,193 :: 		RTC_I2C_WRITE(DS3231_ADDRESS | 0x01);
	MOVLW       209
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;ds3231.c,194 :: 		c_time.seconds = RTC_I2C_READ(1);
	MOVLW       1
	MOVWF       FARG_I2C2_Rd_ack+0 
	CALL        _I2C2_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       _c_time+0 
;ds3231.c,195 :: 		c_time.minutes = RTC_I2C_READ(1);
	MOVLW       1
	MOVWF       FARG_I2C2_Rd_ack+0 
	CALL        _I2C2_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       _c_time+1 
;ds3231.c,196 :: 		c_time.hours   = RTC_I2C_READ(1);
	MOVLW       1
	MOVWF       FARG_I2C2_Rd_ack+0 
	CALL        _I2C2_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       _c_time+2 
;ds3231.c,197 :: 		c_time.dow   = RTC_I2C_READ(1);
	MOVLW       1
	MOVWF       FARG_I2C2_Rd_ack+0 
	CALL        _I2C2_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       _c_time+3 
;ds3231.c,198 :: 		c_time.day   = RTC_I2C_READ(1);
	MOVLW       1
	MOVWF       FARG_I2C2_Rd_ack+0 
	CALL        _I2C2_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       _c_time+4 
;ds3231.c,199 :: 		c_time.month = RTC_I2C_READ(1);
	MOVLW       1
	MOVWF       FARG_I2C2_Rd_ack+0 
	CALL        _I2C2_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       _c_time+5 
;ds3231.c,200 :: 		c_time.year  = RTC_I2C_READ(0);
	CLRF        FARG_I2C2_Rd_ack+0 
	CALL        _I2C2_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       _c_time+6 
;ds3231.c,201 :: 		RTC_I2C_STOP();
	CALL        _I2C2_Stop+0, 0
;ds3231.c,204 :: 		c_time.seconds = bcd_to_decimal(c_time.seconds);
	MOVF        _c_time+0, 0 
	MOVWF       FARG_bcd_to_decimal_number+0 
	CALL        _bcd_to_decimal+0, 0
	MOVF        R0, 0 
	MOVWF       _c_time+0 
;ds3231.c,205 :: 		c_time.minutes = bcd_to_decimal(c_time.minutes);
	MOVF        _c_time+1, 0 
	MOVWF       FARG_bcd_to_decimal_number+0 
	CALL        _bcd_to_decimal+0, 0
	MOVF        R0, 0 
	MOVWF       _c_time+1 
;ds3231.c,206 :: 		c_time.hours   = bcd_to_decimal(c_time.hours);
	MOVF        _c_time+2, 0 
	MOVWF       FARG_bcd_to_decimal_number+0 
	CALL        _bcd_to_decimal+0, 0
	MOVF        R0, 0 
	MOVWF       _c_time+2 
;ds3231.c,207 :: 		c_time.day     = bcd_to_decimal(c_time.day);
	MOVF        _c_time+4, 0 
	MOVWF       FARG_bcd_to_decimal_number+0 
	CALL        _bcd_to_decimal+0, 0
	MOVF        R0, 0 
	MOVWF       _c_time+4 
;ds3231.c,208 :: 		c_time.month   = bcd_to_decimal(c_time.month);
	MOVF        _c_time+5, 0 
	MOVWF       FARG_bcd_to_decimal_number+0 
	CALL        _bcd_to_decimal+0, 0
	MOVF        R0, 0 
	MOVWF       _c_time+5 
;ds3231.c,209 :: 		c_time.year    = bcd_to_decimal(c_time.year);
	MOVF        _c_time+6, 0 
	MOVWF       FARG_bcd_to_decimal_number+0 
	CALL        _bcd_to_decimal+0, 0
	MOVF        R0, 0 
	MOVWF       _c_time+6 
;ds3231.c,212 :: 		return &c_time;
	MOVLW       _c_time+0
	MOVWF       R0 
	MOVLW       hi_addr(_c_time+0)
	MOVWF       R1 
;ds3231.c,213 :: 		}
L_end_RTC_Get:
	RETURN      0
; end of _RTC_Get

_Alarm1_Set:

;ds3231.c,216 :: 		void Alarm1_Set(RTC_Time *time_t, al1 _config)
;ds3231.c,219 :: 		time_t->day     = decimal_to_bcd(time_t->day);
	MOVLW       4
	ADDWF       FARG_Alarm1_Set_time_t+0, 0 
	MOVWF       FLOC__Alarm1_Set+0 
	MOVLW       0
	ADDWFC      FARG_Alarm1_Set_time_t+1, 0 
	MOVWF       FLOC__Alarm1_Set+1 
	MOVFF       FLOC__Alarm1_Set+0, FSR0L+0
	MOVFF       FLOC__Alarm1_Set+1, FSR0H+0
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_decimal_to_bcd_number+0 
	CALL        _decimal_to_bcd+0, 0
	MOVFF       FLOC__Alarm1_Set+0, FSR1L+0
	MOVFF       FLOC__Alarm1_Set+1, FSR1H+0
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;ds3231.c,220 :: 		time_t->hours   = decimal_to_bcd(time_t->hours);
	MOVLW       2
	ADDWF       FARG_Alarm1_Set_time_t+0, 0 
	MOVWF       FLOC__Alarm1_Set+0 
	MOVLW       0
	ADDWFC      FARG_Alarm1_Set_time_t+1, 0 
	MOVWF       FLOC__Alarm1_Set+1 
	MOVFF       FLOC__Alarm1_Set+0, FSR0L+0
	MOVFF       FLOC__Alarm1_Set+1, FSR0H+0
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_decimal_to_bcd_number+0 
	CALL        _decimal_to_bcd+0, 0
	MOVFF       FLOC__Alarm1_Set+0, FSR1L+0
	MOVFF       FLOC__Alarm1_Set+1, FSR1H+0
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;ds3231.c,221 :: 		time_t->minutes = decimal_to_bcd(time_t->minutes);
	MOVLW       1
	ADDWF       FARG_Alarm1_Set_time_t+0, 0 
	MOVWF       FLOC__Alarm1_Set+0 
	MOVLW       0
	ADDWFC      FARG_Alarm1_Set_time_t+1, 0 
	MOVWF       FLOC__Alarm1_Set+1 
	MOVFF       FLOC__Alarm1_Set+0, FSR0L+0
	MOVFF       FLOC__Alarm1_Set+1, FSR0H+0
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_decimal_to_bcd_number+0 
	CALL        _decimal_to_bcd+0, 0
	MOVFF       FLOC__Alarm1_Set+0, FSR1L+0
	MOVFF       FLOC__Alarm1_Set+1, FSR1H+0
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;ds3231.c,222 :: 		time_t->seconds = decimal_to_bcd(time_t->seconds);
	MOVF        FARG_Alarm1_Set_time_t+0, 0 
	MOVWF       FLOC__Alarm1_Set+0 
	MOVF        FARG_Alarm1_Set_time_t+1, 0 
	MOVWF       FLOC__Alarm1_Set+1 
	MOVFF       FARG_Alarm1_Set_time_t+0, FSR0L+0
	MOVFF       FARG_Alarm1_Set_time_t+1, FSR0H+0
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_decimal_to_bcd_number+0 
	CALL        _decimal_to_bcd+0, 0
	MOVFF       FLOC__Alarm1_Set+0, FSR1L+0
	MOVFF       FLOC__Alarm1_Set+1, FSR1H+0
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;ds3231.c,226 :: 		RTC_I2C_START();
	CALL        _I2C2_Start+0, 0
;ds3231.c,227 :: 		RTC_I2C_WRITE(DS3231_ADDRESS);
	MOVLW       208
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;ds3231.c,228 :: 		RTC_I2C_WRITE(DS3231_REG_AL1_SEC);
	MOVLW       7
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;ds3231.c,229 :: 		RTC_I2C_WRITE( time_t->seconds | alarm_cfg(_config, 0) );
	MOVFF       FARG_Alarm1_Set_time_t+0, FSR0L+0
	MOVFF       FARG_Alarm1_Set_time_t+1, FSR0H+0
	MOVF        POSTINC0+0, 0 
	MOVWF       FLOC__Alarm1_Set+0 
	MOVF        FARG_Alarm1_Set__config+0, 0 
	MOVWF       FARG_alarm_cfg_n+0 
	CLRF        FARG_alarm_cfg_i+0 
	CALL        _alarm_cfg+0, 0
	MOVF        R0, 0 
	IORWF       FLOC__Alarm1_Set+0, 0 
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;ds3231.c,230 :: 		RTC_I2C_WRITE( time_t->minutes | alarm_cfg(_config, 1) );
	MOVLW       1
	ADDWF       FARG_Alarm1_Set_time_t+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       0
	ADDWFC      FARG_Alarm1_Set_time_t+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       FLOC__Alarm1_Set+0 
	MOVF        FARG_Alarm1_Set__config+0, 0 
	MOVWF       FARG_alarm_cfg_n+0 
	MOVLW       1
	MOVWF       FARG_alarm_cfg_i+0 
	CALL        _alarm_cfg+0, 0
	MOVF        R0, 0 
	IORWF       FLOC__Alarm1_Set+0, 0 
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;ds3231.c,231 :: 		RTC_I2C_WRITE( time_t->hours   | alarm_cfg(_config, 2) );
	MOVLW       2
	ADDWF       FARG_Alarm1_Set_time_t+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       0
	ADDWFC      FARG_Alarm1_Set_time_t+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       FLOC__Alarm1_Set+0 
	MOVF        FARG_Alarm1_Set__config+0, 0 
	MOVWF       FARG_alarm_cfg_n+0 
	MOVLW       2
	MOVWF       FARG_alarm_cfg_i+0 
	CALL        _alarm_cfg+0, 0
	MOVF        R0, 0 
	IORWF       FLOC__Alarm1_Set+0, 0 
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;ds3231.c,232 :: 		if ( _config & 0x10 )
	BTFSS       FARG_Alarm1_Set__config+0, 4 
	GOTO        L_Alarm1_Set2
;ds3231.c,233 :: 		RTC_I2C_WRITE( time_t->dow | 0x40 | alarm_cfg(_config, 3) );
	MOVLW       3
	ADDWF       FARG_Alarm1_Set_time_t+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       0
	ADDWFC      FARG_Alarm1_Set_time_t+1, 0 
	MOVWF       FSR0L+1 
	MOVLW       64
	IORWF       POSTINC0+0, 0 
	MOVWF       FLOC__Alarm1_Set+0 
	MOVF        FARG_Alarm1_Set__config+0, 0 
	MOVWF       FARG_alarm_cfg_n+0 
	MOVLW       3
	MOVWF       FARG_alarm_cfg_i+0 
	CALL        _alarm_cfg+0, 0
	MOVF        R0, 0 
	IORWF       FLOC__Alarm1_Set+0, 0 
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
	GOTO        L_Alarm1_Set3
L_Alarm1_Set2:
;ds3231.c,235 :: 		RTC_I2C_WRITE( time_t->day | alarm_cfg(_config, 3) );
	MOVLW       4
	ADDWF       FARG_Alarm1_Set_time_t+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       0
	ADDWFC      FARG_Alarm1_Set_time_t+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       FLOC__Alarm1_Set+0 
	MOVF        FARG_Alarm1_Set__config+0, 0 
	MOVWF       FARG_alarm_cfg_n+0 
	MOVLW       3
	MOVWF       FARG_alarm_cfg_i+0 
	CALL        _alarm_cfg+0, 0
	MOVF        R0, 0 
	IORWF       FLOC__Alarm1_Set+0, 0 
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
L_Alarm1_Set3:
;ds3231.c,236 :: 		RTC_I2C_STOP();
	CALL        _I2C2_Stop+0, 0
;ds3231.c,237 :: 		}
L_end_Alarm1_Set:
	RETURN      0
; end of _Alarm1_Set

_Alarm1_Get:

;ds3231.c,240 :: 		RTC_Time *Alarm1_Get()
;ds3231.c,242 :: 		RTC_I2C_START();
	CALL        _I2C2_Start+0, 0
;ds3231.c,243 :: 		RTC_I2C_WRITE(DS3231_ADDRESS);
	MOVLW       208
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;ds3231.c,244 :: 		RTC_I2C_WRITE(DS3231_REG_AL1_SEC);
	MOVLW       7
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;ds3231.c,245 :: 		RTC_I2C_RESTART();
	CALL        _I2C2_Repeated_Start+0, 0
;ds3231.c,246 :: 		RTC_I2C_WRITE(DS3231_ADDRESS | 0x01);
	MOVLW       209
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;ds3231.c,247 :: 		c_alarm1.seconds = RTC_I2C_READ(1) & 0x7F;
	MOVLW       1
	MOVWF       FARG_I2C2_Rd_ack+0 
	CALL        _I2C2_Rd+0, 0
	MOVLW       127
	ANDWF       R0, 1 
	MOVF        R0, 0 
	MOVWF       _c_alarm1+0 
;ds3231.c,248 :: 		c_alarm1.minutes = RTC_I2C_READ(1) & 0x7F;
	MOVLW       1
	MOVWF       FARG_I2C2_Rd_ack+0 
	CALL        _I2C2_Rd+0, 0
	MOVLW       127
	ANDWF       R0, 1 
	MOVF        R0, 0 
	MOVWF       _c_alarm1+1 
;ds3231.c,249 :: 		c_alarm1.hours   = RTC_I2C_READ(1) & 0x3F;
	MOVLW       1
	MOVWF       FARG_I2C2_Rd_ack+0 
	CALL        _I2C2_Rd+0, 0
	MOVLW       63
	ANDWF       R0, 1 
	MOVF        R0, 0 
	MOVWF       _c_alarm1+2 
;ds3231.c,250 :: 		c_alarm1.dow = c_alarm1.day = RTC_I2C_READ(0) & 0x3F;
	CLRF        FARG_I2C2_Rd_ack+0 
	CALL        _I2C2_Rd+0, 0
	MOVLW       63
	ANDWF       R0, 1 
	MOVF        R0, 0 
	MOVWF       _c_alarm1+4 
	MOVF        R0, 0 
	MOVWF       _c_alarm1+3 
;ds3231.c,251 :: 		RTC_I2C_STOP();
	CALL        _I2C2_Stop+0, 0
;ds3231.c,254 :: 		c_alarm1.seconds = bcd_to_decimal(c_alarm1.seconds);
	MOVF        _c_alarm1+0, 0 
	MOVWF       FARG_bcd_to_decimal_number+0 
	CALL        _bcd_to_decimal+0, 0
	MOVF        R0, 0 
	MOVWF       _c_alarm1+0 
;ds3231.c,255 :: 		c_alarm1.minutes = bcd_to_decimal(c_alarm1.minutes);
	MOVF        _c_alarm1+1, 0 
	MOVWF       FARG_bcd_to_decimal_number+0 
	CALL        _bcd_to_decimal+0, 0
	MOVF        R0, 0 
	MOVWF       _c_alarm1+1 
;ds3231.c,256 :: 		c_alarm1.hours   = bcd_to_decimal(c_alarm1.hours);
	MOVF        _c_alarm1+2, 0 
	MOVWF       FARG_bcd_to_decimal_number+0 
	CALL        _bcd_to_decimal+0, 0
	MOVF        R0, 0 
	MOVWF       _c_alarm1+2 
;ds3231.c,257 :: 		c_alarm1.day     = bcd_to_decimal(c_alarm1.day);
	MOVF        _c_alarm1+4, 0 
	MOVWF       FARG_bcd_to_decimal_number+0 
	CALL        _bcd_to_decimal+0, 0
	MOVF        R0, 0 
	MOVWF       _c_alarm1+4 
;ds3231.c,260 :: 		return &c_alarm1;
	MOVLW       _c_alarm1+0
	MOVWF       R0 
	MOVLW       hi_addr(_c_alarm1+0)
	MOVWF       R1 
;ds3231.c,261 :: 		}
L_end_Alarm1_Get:
	RETURN      0
; end of _Alarm1_Get

_Alarm1_Enable:

;ds3231.c,264 :: 		void Alarm1_Enable()
;ds3231.c,266 :: 		uint8_t ctrl_reg = RTC_Read_Reg(DS3231_REG_CONTROL);
	MOVLW       14
	MOVWF       FARG_RTC_Read_Reg_reg_address+0 
	CALL        _RTC_Read_Reg+0, 0
;ds3231.c,267 :: 		ctrl_reg |= 0x01;
	MOVLW       1
	IORWF       R0, 0 
	MOVWF       FARG_RTC_Write_Reg_reg_value+0 
;ds3231.c,268 :: 		RTC_Write_Reg(DS3231_REG_CONTROL, ctrl_reg);
	MOVLW       14
	MOVWF       FARG_RTC_Write_Reg_reg_address+0 
	CALL        _RTC_Write_Reg+0, 0
;ds3231.c,269 :: 		}
L_end_Alarm1_Enable:
	RETURN      0
; end of _Alarm1_Enable

_Alarm1_Disable:

;ds3231.c,272 :: 		void Alarm1_Disable()
;ds3231.c,274 :: 		uint8_t ctrl_reg = RTC_Read_Reg(DS3231_REG_CONTROL);
	MOVLW       14
	MOVWF       FARG_RTC_Read_Reg_reg_address+0 
	CALL        _RTC_Read_Reg+0, 0
;ds3231.c,275 :: 		ctrl_reg &= 0xFE;
	MOVLW       254
	ANDWF       R0, 0 
	MOVWF       FARG_RTC_Write_Reg_reg_value+0 
;ds3231.c,276 :: 		RTC_Write_Reg(DS3231_REG_CONTROL, ctrl_reg);
	MOVLW       14
	MOVWF       FARG_RTC_Write_Reg_reg_address+0 
	CALL        _RTC_Write_Reg+0, 0
;ds3231.c,277 :: 		}
L_end_Alarm1_Disable:
	RETURN      0
; end of _Alarm1_Disable

_Alarm1_IF_Check:

;ds3231.c,280 :: 		uint8_t Alarm1_IF_Check()
;ds3231.c,282 :: 		uint8_t stat_reg = RTC_Read_Reg(DS3231_REG_STATUS);
	MOVLW       15
	MOVWF       FARG_RTC_Read_Reg_reg_address+0 
	CALL        _RTC_Read_Reg+0, 0
;ds3231.c,283 :: 		if(stat_reg & 0x01)
	BTFSS       R0, 0 
	GOTO        L_Alarm1_IF_Check4
;ds3231.c,284 :: 		return 1;
	MOVLW       1
	MOVWF       R0 
	GOTO        L_end_Alarm1_IF_Check
L_Alarm1_IF_Check4:
;ds3231.c,286 :: 		return 0;
	CLRF        R0 
;ds3231.c,287 :: 		}
L_end_Alarm1_IF_Check:
	RETURN      0
; end of _Alarm1_IF_Check

_Alarm1_IF_Reset:

;ds3231.c,290 :: 		void Alarm1_IF_Reset()
;ds3231.c,292 :: 		uint8_t stat_reg = RTC_Read_Reg(DS3231_REG_STATUS);
	MOVLW       15
	MOVWF       FARG_RTC_Read_Reg_reg_address+0 
	CALL        _RTC_Read_Reg+0, 0
;ds3231.c,293 :: 		stat_reg &= 0xFE;
	MOVLW       254
	ANDWF       R0, 0 
	MOVWF       FARG_RTC_Write_Reg_reg_value+0 
;ds3231.c,294 :: 		RTC_Write_Reg(DS3231_REG_STATUS, stat_reg);
	MOVLW       15
	MOVWF       FARG_RTC_Write_Reg_reg_address+0 
	CALL        _RTC_Write_Reg+0, 0
;ds3231.c,295 :: 		}
L_end_Alarm1_IF_Reset:
	RETURN      0
; end of _Alarm1_IF_Reset

_Alarm1_Status:

;ds3231.c,298 :: 		uint8_t Alarm1_Status()
;ds3231.c,300 :: 		uint8_t ctrl_reg = RTC_Read_Reg(DS3231_REG_CONTROL);
	MOVLW       14
	MOVWF       FARG_RTC_Read_Reg_reg_address+0 
	CALL        _RTC_Read_Reg+0, 0
;ds3231.c,301 :: 		if(ctrl_reg & 0x01)
	BTFSS       R0, 0 
	GOTO        L_Alarm1_Status6
;ds3231.c,302 :: 		return 1;
	MOVLW       1
	MOVWF       R0 
	GOTO        L_end_Alarm1_Status
L_Alarm1_Status6:
;ds3231.c,304 :: 		return 0;
	CLRF        R0 
;ds3231.c,305 :: 		}
L_end_Alarm1_Status:
	RETURN      0
; end of _Alarm1_Status

_Alarm2_Set:

;ds3231.c,308 :: 		void Alarm2_Set(RTC_Time *time_t, al2 _config)
;ds3231.c,311 :: 		time_t->day     = decimal_to_bcd(time_t->day);
	MOVLW       4
	ADDWF       FARG_Alarm2_Set_time_t+0, 0 
	MOVWF       FLOC__Alarm2_Set+0 
	MOVLW       0
	ADDWFC      FARG_Alarm2_Set_time_t+1, 0 
	MOVWF       FLOC__Alarm2_Set+1 
	MOVFF       FLOC__Alarm2_Set+0, FSR0L+0
	MOVFF       FLOC__Alarm2_Set+1, FSR0H+0
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_decimal_to_bcd_number+0 
	CALL        _decimal_to_bcd+0, 0
	MOVFF       FLOC__Alarm2_Set+0, FSR1L+0
	MOVFF       FLOC__Alarm2_Set+1, FSR1H+0
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;ds3231.c,312 :: 		time_t->hours   = decimal_to_bcd(time_t->hours);
	MOVLW       2
	ADDWF       FARG_Alarm2_Set_time_t+0, 0 
	MOVWF       FLOC__Alarm2_Set+0 
	MOVLW       0
	ADDWFC      FARG_Alarm2_Set_time_t+1, 0 
	MOVWF       FLOC__Alarm2_Set+1 
	MOVFF       FLOC__Alarm2_Set+0, FSR0L+0
	MOVFF       FLOC__Alarm2_Set+1, FSR0H+0
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_decimal_to_bcd_number+0 
	CALL        _decimal_to_bcd+0, 0
	MOVFF       FLOC__Alarm2_Set+0, FSR1L+0
	MOVFF       FLOC__Alarm2_Set+1, FSR1H+0
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;ds3231.c,313 :: 		time_t->minutes = decimal_to_bcd(time_t->minutes);
	MOVLW       1
	ADDWF       FARG_Alarm2_Set_time_t+0, 0 
	MOVWF       FLOC__Alarm2_Set+0 
	MOVLW       0
	ADDWFC      FARG_Alarm2_Set_time_t+1, 0 
	MOVWF       FLOC__Alarm2_Set+1 
	MOVFF       FLOC__Alarm2_Set+0, FSR0L+0
	MOVFF       FLOC__Alarm2_Set+1, FSR0H+0
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_decimal_to_bcd_number+0 
	CALL        _decimal_to_bcd+0, 0
	MOVFF       FLOC__Alarm2_Set+0, FSR1L+0
	MOVFF       FLOC__Alarm2_Set+1, FSR1H+0
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;ds3231.c,317 :: 		RTC_I2C_START();
	CALL        _I2C2_Start+0, 0
;ds3231.c,318 :: 		RTC_I2C_WRITE(DS3231_ADDRESS);
	MOVLW       208
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;ds3231.c,319 :: 		RTC_I2C_WRITE(DS3231_REG_AL2_MIN);
	MOVLW       11
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;ds3231.c,320 :: 		RTC_I2C_WRITE( (time_t->minutes) | alarm_cfg(_config, 1) );
	MOVLW       1
	ADDWF       FARG_Alarm2_Set_time_t+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       0
	ADDWFC      FARG_Alarm2_Set_time_t+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       FLOC__Alarm2_Set+0 
	MOVF        FARG_Alarm2_Set__config+0, 0 
	MOVWF       FARG_alarm_cfg_n+0 
	MOVLW       1
	MOVWF       FARG_alarm_cfg_i+0 
	CALL        _alarm_cfg+0, 0
	MOVF        R0, 0 
	IORWF       FLOC__Alarm2_Set+0, 0 
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;ds3231.c,321 :: 		RTC_I2C_WRITE( (time_t->hours) | alarm_cfg(_config, 2) );
	MOVLW       2
	ADDWF       FARG_Alarm2_Set_time_t+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       0
	ADDWFC      FARG_Alarm2_Set_time_t+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       FLOC__Alarm2_Set+0 
	MOVF        FARG_Alarm2_Set__config+0, 0 
	MOVWF       FARG_alarm_cfg_n+0 
	MOVLW       2
	MOVWF       FARG_alarm_cfg_i+0 
	CALL        _alarm_cfg+0, 0
	MOVF        R0, 0 
	IORWF       FLOC__Alarm2_Set+0, 0 
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;ds3231.c,322 :: 		if ( _config & 0x10 )
	BTFSS       FARG_Alarm2_Set__config+0, 4 
	GOTO        L_Alarm2_Set8
;ds3231.c,323 :: 		RTC_I2C_WRITE( time_t->dow | 0x40 | alarm_cfg(_config, 3) );
	MOVLW       3
	ADDWF       FARG_Alarm2_Set_time_t+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       0
	ADDWFC      FARG_Alarm2_Set_time_t+1, 0 
	MOVWF       FSR0L+1 
	MOVLW       64
	IORWF       POSTINC0+0, 0 
	MOVWF       FLOC__Alarm2_Set+0 
	MOVF        FARG_Alarm2_Set__config+0, 0 
	MOVWF       FARG_alarm_cfg_n+0 
	MOVLW       3
	MOVWF       FARG_alarm_cfg_i+0 
	CALL        _alarm_cfg+0, 0
	MOVF        R0, 0 
	IORWF       FLOC__Alarm2_Set+0, 0 
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
	GOTO        L_Alarm2_Set9
L_Alarm2_Set8:
;ds3231.c,325 :: 		RTC_I2C_WRITE( time_t->day | alarm_cfg(_config, 3) );
	MOVLW       4
	ADDWF       FARG_Alarm2_Set_time_t+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       0
	ADDWFC      FARG_Alarm2_Set_time_t+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       FLOC__Alarm2_Set+0 
	MOVF        FARG_Alarm2_Set__config+0, 0 
	MOVWF       FARG_alarm_cfg_n+0 
	MOVLW       3
	MOVWF       FARG_alarm_cfg_i+0 
	CALL        _alarm_cfg+0, 0
	MOVF        R0, 0 
	IORWF       FLOC__Alarm2_Set+0, 0 
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
L_Alarm2_Set9:
;ds3231.c,326 :: 		RTC_I2C_STOP();
	CALL        _I2C2_Stop+0, 0
;ds3231.c,327 :: 		}
L_end_Alarm2_Set:
	RETURN      0
; end of _Alarm2_Set

_Alarm2_Get:

;ds3231.c,330 :: 		RTC_Time *Alarm2_Get()
;ds3231.c,332 :: 		RTC_I2C_START();
	CALL        _I2C2_Start+0, 0
;ds3231.c,333 :: 		RTC_I2C_WRITE(DS3231_ADDRESS);
	MOVLW       208
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;ds3231.c,334 :: 		RTC_I2C_WRITE(DS3231_REG_AL2_MIN);
	MOVLW       11
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;ds3231.c,335 :: 		RTC_I2C_RESTART();
	CALL        _I2C2_Repeated_Start+0, 0
;ds3231.c,336 :: 		RTC_I2C_WRITE(DS3231_ADDRESS | 0x01);
	MOVLW       209
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;ds3231.c,337 :: 		c_alarm2.minutes = RTC_I2C_READ(1) & 0x7F;
	MOVLW       1
	MOVWF       FARG_I2C2_Rd_ack+0 
	CALL        _I2C2_Rd+0, 0
	MOVLW       127
	ANDWF       R0, 1 
	MOVF        R0, 0 
	MOVWF       _c_alarm2+1 
;ds3231.c,338 :: 		c_alarm2.hours   = RTC_I2C_READ(1) & 0x3F;
	MOVLW       1
	MOVWF       FARG_I2C2_Rd_ack+0 
	CALL        _I2C2_Rd+0, 0
	MOVLW       63
	ANDWF       R0, 1 
	MOVF        R0, 0 
	MOVWF       _c_alarm2+2 
;ds3231.c,339 :: 		c_alarm2.dow = c_alarm2.day = RTC_I2C_READ(0) & 0x3F;
	CLRF        FARG_I2C2_Rd_ack+0 
	CALL        _I2C2_Rd+0, 0
	MOVLW       63
	ANDWF       R0, 1 
	MOVF        R0, 0 
	MOVWF       _c_alarm2+4 
	MOVF        R0, 0 
	MOVWF       _c_alarm2+3 
;ds3231.c,340 :: 		RTC_I2C_STOP();
	CALL        _I2C2_Stop+0, 0
;ds3231.c,343 :: 		c_alarm2.minutes = bcd_to_decimal(c_alarm2.minutes);
	MOVF        _c_alarm2+1, 0 
	MOVWF       FARG_bcd_to_decimal_number+0 
	CALL        _bcd_to_decimal+0, 0
	MOVF        R0, 0 
	MOVWF       _c_alarm2+1 
;ds3231.c,344 :: 		c_alarm2.hours   = bcd_to_decimal(c_alarm2.hours);
	MOVF        _c_alarm2+2, 0 
	MOVWF       FARG_bcd_to_decimal_number+0 
	CALL        _bcd_to_decimal+0, 0
	MOVF        R0, 0 
	MOVWF       _c_alarm2+2 
;ds3231.c,345 :: 		c_alarm2.day     = bcd_to_decimal(c_alarm2.day);
	MOVF        _c_alarm2+4, 0 
	MOVWF       FARG_bcd_to_decimal_number+0 
	CALL        _bcd_to_decimal+0, 0
	MOVF        R0, 0 
	MOVWF       _c_alarm2+4 
;ds3231.c,347 :: 		c_alarm2.seconds = 0;
	CLRF        _c_alarm2+0 
;ds3231.c,348 :: 		return &c_alarm2;
	MOVLW       _c_alarm2+0
	MOVWF       R0 
	MOVLW       hi_addr(_c_alarm2+0)
	MOVWF       R1 
;ds3231.c,349 :: 		}
L_end_Alarm2_Get:
	RETURN      0
; end of _Alarm2_Get

_Alarm2_Enable:

;ds3231.c,352 :: 		void Alarm2_Enable()
;ds3231.c,354 :: 		uint8_t ctrl_reg = RTC_Read_Reg(DS3231_REG_CONTROL);
	MOVLW       14
	MOVWF       FARG_RTC_Read_Reg_reg_address+0 
	CALL        _RTC_Read_Reg+0, 0
;ds3231.c,355 :: 		ctrl_reg |= 0x02;
	MOVLW       2
	IORWF       R0, 0 
	MOVWF       FARG_RTC_Write_Reg_reg_value+0 
;ds3231.c,356 :: 		RTC_Write_Reg(DS3231_REG_CONTROL, ctrl_reg);
	MOVLW       14
	MOVWF       FARG_RTC_Write_Reg_reg_address+0 
	CALL        _RTC_Write_Reg+0, 0
;ds3231.c,357 :: 		}
L_end_Alarm2_Enable:
	RETURN      0
; end of _Alarm2_Enable

_Alarm2_Disable:

;ds3231.c,360 :: 		void Alarm2_Disable()
;ds3231.c,362 :: 		uint8_t ctrl_reg = RTC_Read_Reg(DS3231_REG_CONTROL);
	MOVLW       14
	MOVWF       FARG_RTC_Read_Reg_reg_address+0 
	CALL        _RTC_Read_Reg+0, 0
;ds3231.c,363 :: 		ctrl_reg &= 0xFD;
	MOVLW       253
	ANDWF       R0, 0 
	MOVWF       FARG_RTC_Write_Reg_reg_value+0 
;ds3231.c,364 :: 		RTC_Write_Reg(DS3231_REG_CONTROL, ctrl_reg);
	MOVLW       14
	MOVWF       FARG_RTC_Write_Reg_reg_address+0 
	CALL        _RTC_Write_Reg+0, 0
;ds3231.c,365 :: 		}
L_end_Alarm2_Disable:
	RETURN      0
; end of _Alarm2_Disable

_Alarm2_IF_Check:

;ds3231.c,368 :: 		uint8_t Alarm2_IF_Check()
;ds3231.c,370 :: 		uint8_t stat_reg = RTC_Read_Reg(DS3231_REG_STATUS);
	MOVLW       15
	MOVWF       FARG_RTC_Read_Reg_reg_address+0 
	CALL        _RTC_Read_Reg+0, 0
;ds3231.c,371 :: 		if(stat_reg & 0x02)
	BTFSS       R0, 1 
	GOTO        L_Alarm2_IF_Check10
;ds3231.c,372 :: 		return 1;
	MOVLW       1
	MOVWF       R0 
	GOTO        L_end_Alarm2_IF_Check
L_Alarm2_IF_Check10:
;ds3231.c,374 :: 		return 0;
	CLRF        R0 
;ds3231.c,375 :: 		}
L_end_Alarm2_IF_Check:
	RETURN      0
; end of _Alarm2_IF_Check

_Alarm2_IF_Reset:

;ds3231.c,378 :: 		void Alarm2_IF_Reset()
;ds3231.c,380 :: 		uint8_t stat_reg = RTC_Read_Reg(DS3231_REG_STATUS);
	MOVLW       15
	MOVWF       FARG_RTC_Read_Reg_reg_address+0 
	CALL        _RTC_Read_Reg+0, 0
;ds3231.c,381 :: 		stat_reg &= 0xFD;
	MOVLW       253
	ANDWF       R0, 0 
	MOVWF       FARG_RTC_Write_Reg_reg_value+0 
;ds3231.c,382 :: 		RTC_Write_Reg(DS3231_REG_STATUS, stat_reg);
	MOVLW       15
	MOVWF       FARG_RTC_Write_Reg_reg_address+0 
	CALL        _RTC_Write_Reg+0, 0
;ds3231.c,383 :: 		}
L_end_Alarm2_IF_Reset:
	RETURN      0
; end of _Alarm2_IF_Reset

_Alarm2_Status:

;ds3231.c,386 :: 		uint8_t Alarm2_Status()
;ds3231.c,388 :: 		uint8_t ctrl_reg = RTC_Read_Reg(DS3231_REG_CONTROL);
	MOVLW       14
	MOVWF       FARG_RTC_Read_Reg_reg_address+0 
	CALL        _RTC_Read_Reg+0, 0
;ds3231.c,389 :: 		if(ctrl_reg & 0x02)
	BTFSS       R0, 1 
	GOTO        L_Alarm2_Status12
;ds3231.c,390 :: 		return 1;
	MOVLW       1
	MOVWF       R0 
	GOTO        L_end_Alarm2_Status
L_Alarm2_Status12:
;ds3231.c,392 :: 		return 0;
	CLRF        R0 
;ds3231.c,393 :: 		}
L_end_Alarm2_Status:
	RETURN      0
; end of _Alarm2_Status

_RTC_Write_Reg:

;ds3231.c,396 :: 		void RTC_Write_Reg(uint8_t reg_address, uint8_t reg_value)
;ds3231.c,398 :: 		RTC_I2C_START();
	CALL        _I2C2_Start+0, 0
;ds3231.c,399 :: 		RTC_I2C_WRITE(DS3231_ADDRESS);
	MOVLW       208
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;ds3231.c,400 :: 		RTC_I2C_WRITE(reg_address);
	MOVF        FARG_RTC_Write_Reg_reg_address+0, 0 
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;ds3231.c,401 :: 		RTC_I2C_WRITE(reg_value);
	MOVF        FARG_RTC_Write_Reg_reg_value+0, 0 
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;ds3231.c,402 :: 		RTC_I2C_STOP();
	CALL        _I2C2_Stop+0, 0
;ds3231.c,403 :: 		}
L_end_RTC_Write_Reg:
	RETURN      0
; end of _RTC_Write_Reg

_RTC_Read_Reg:

;ds3231.c,406 :: 		uint8_t RTC_Read_Reg(uint8_t reg_address)
;ds3231.c,410 :: 		RTC_I2C_START();
	CALL        _I2C2_Start+0, 0
;ds3231.c,411 :: 		RTC_I2C_WRITE(DS3231_ADDRESS);
	MOVLW       208
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;ds3231.c,412 :: 		RTC_I2C_WRITE(reg_address);
	MOVF        FARG_RTC_Read_Reg_reg_address+0, 0 
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;ds3231.c,413 :: 		RTC_I2C_RESTART();
	CALL        _I2C2_Repeated_Start+0, 0
;ds3231.c,414 :: 		RTC_I2C_WRITE(DS3231_ADDRESS | 0x01);
	MOVLW       209
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;ds3231.c,415 :: 		reg_data = RTC_I2C_READ(0);
	CLRF        FARG_I2C2_Rd_ack+0 
	CALL        _I2C2_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       RTC_Read_Reg_reg_data_L0+0 
;ds3231.c,416 :: 		RTC_I2C_STOP();
	CALL        _I2C2_Stop+0, 0
;ds3231.c,418 :: 		return reg_data;
	MOVF        RTC_Read_Reg_reg_data_L0+0, 0 
	MOVWF       R0 
;ds3231.c,419 :: 		}
L_end_RTC_Read_Reg:
	RETURN      0
; end of _RTC_Read_Reg

_IntSqw_Set:

;ds3231.c,422 :: 		void IntSqw_Set(INT_SQW _config)
;ds3231.c,424 :: 		uint8_t ctrl_reg = RTC_Read_Reg(DS3231_REG_CONTROL);
	MOVLW       14
	MOVWF       FARG_RTC_Read_Reg_reg_address+0 
	CALL        _RTC_Read_Reg+0, 0
;ds3231.c,425 :: 		ctrl_reg &= 0xA3;
	MOVLW       163
	ANDWF       R0, 0 
	MOVWF       FARG_RTC_Write_Reg_reg_value+0 
;ds3231.c,426 :: 		ctrl_reg |= _config;
	MOVF        FARG_IntSqw_Set__config+0, 0 
	IORWF       FARG_RTC_Write_Reg_reg_value+0, 1 
;ds3231.c,427 :: 		RTC_Write_Reg(DS3231_REG_CONTROL, ctrl_reg);
	MOVLW       14
	MOVWF       FARG_RTC_Write_Reg_reg_address+0 
	CALL        _RTC_Write_Reg+0, 0
;ds3231.c,428 :: 		}
L_end_IntSqw_Set:
	RETURN      0
; end of _IntSqw_Set

_Enable_32kHZ:

;ds3231.c,431 :: 		void Enable_32kHZ()
;ds3231.c,433 :: 		uint8_t stat_reg = RTC_Read_Reg(DS3231_REG_STATUS);
	MOVLW       15
	MOVWF       FARG_RTC_Read_Reg_reg_address+0 
	CALL        _RTC_Read_Reg+0, 0
;ds3231.c,434 :: 		stat_reg |= 0x08;
	MOVLW       8
	IORWF       R0, 0 
	MOVWF       FARG_RTC_Write_Reg_reg_value+0 
;ds3231.c,435 :: 		RTC_Write_Reg(DS3231_REG_STATUS, stat_reg);
	MOVLW       15
	MOVWF       FARG_RTC_Write_Reg_reg_address+0 
	CALL        _RTC_Write_Reg+0, 0
;ds3231.c,436 :: 		}
L_end_Enable_32kHZ:
	RETURN      0
; end of _Enable_32kHZ

_Disable_32kHZ:

;ds3231.c,439 :: 		void Disable_32kHZ()
;ds3231.c,441 :: 		uint8_t stat_reg = RTC_Read_Reg(DS3231_REG_STATUS);
	MOVLW       15
	MOVWF       FARG_RTC_Read_Reg_reg_address+0 
	CALL        _RTC_Read_Reg+0, 0
;ds3231.c,442 :: 		stat_reg &= 0xF7;
	MOVLW       247
	ANDWF       R0, 0 
	MOVWF       FARG_RTC_Write_Reg_reg_value+0 
;ds3231.c,443 :: 		RTC_Write_Reg(DS3231_REG_STATUS, stat_reg);
	MOVLW       15
	MOVWF       FARG_RTC_Write_Reg_reg_address+0 
	CALL        _RTC_Write_Reg+0, 0
;ds3231.c,444 :: 		}
L_end_Disable_32kHZ:
	RETURN      0
; end of _Disable_32kHZ

_OSC_Start:

;ds3231.c,447 :: 		void OSC_Start()
;ds3231.c,449 :: 		uint8_t ctrl_reg = RTC_Read_Reg(DS3231_REG_CONTROL);
	MOVLW       14
	MOVWF       FARG_RTC_Read_Reg_reg_address+0 
	CALL        _RTC_Read_Reg+0, 0
;ds3231.c,450 :: 		ctrl_reg &= 0x7F;
	MOVLW       127
	ANDWF       R0, 0 
	MOVWF       FARG_RTC_Write_Reg_reg_value+0 
;ds3231.c,451 :: 		RTC_Write_Reg(DS3231_REG_CONTROL, ctrl_reg);
	MOVLW       14
	MOVWF       FARG_RTC_Write_Reg_reg_address+0 
	CALL        _RTC_Write_Reg+0, 0
;ds3231.c,452 :: 		}
L_end_OSC_Start:
	RETURN      0
; end of _OSC_Start

_OSC_Stop:

;ds3231.c,455 :: 		void OSC_Stop()
;ds3231.c,457 :: 		uint8_t ctrl_reg = RTC_Read_Reg(DS3231_REG_CONTROL);
	MOVLW       14
	MOVWF       FARG_RTC_Read_Reg_reg_address+0 
	CALL        _RTC_Read_Reg+0, 0
;ds3231.c,458 :: 		ctrl_reg |= 0x80;
	MOVLW       128
	IORWF       R0, 0 
	MOVWF       FARG_RTC_Write_Reg_reg_value+0 
;ds3231.c,459 :: 		RTC_Write_Reg(DS3231_REG_CONTROL, ctrl_reg);
	MOVLW       14
	MOVWF       FARG_RTC_Write_Reg_reg_address+0 
	CALL        _RTC_Write_Reg+0, 0
;ds3231.c,460 :: 		}
L_end_OSC_Stop:
	RETURN      0
; end of _OSC_Stop

_Get_Temperature:

;ds3231.c,464 :: 		int16_t Get_Temperature()
;ds3231.c,468 :: 		RTC_I2C_START();
	CALL        _I2C2_Start+0, 0
;ds3231.c,469 :: 		RTC_I2C_WRITE(DS3231_ADDRESS);
	MOVLW       208
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;ds3231.c,470 :: 		RTC_I2C_WRITE(DS3231_REG_TEMP_MSB);
	MOVLW       17
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;ds3231.c,471 :: 		RTC_I2C_RESTART();
	CALL        _I2C2_Repeated_Start+0, 0
;ds3231.c,472 :: 		RTC_I2C_WRITE(DS3231_ADDRESS | 0x01);
	MOVLW       209
	MOVWF       FARG_I2C2_Wr_data_+0 
	CALL        _I2C2_Wr+0, 0
;ds3231.c,473 :: 		t_msb = RTC_I2C_READ(1);
	MOVLW       1
	MOVWF       FARG_I2C2_Rd_ack+0 
	CALL        _I2C2_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       Get_Temperature_t_msb_L0+0 
;ds3231.c,474 :: 		t_lsb = RTC_I2C_READ(0);
	CLRF        FARG_I2C2_Rd_ack+0 
	CALL        _I2C2_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       Get_Temperature_t_lsb_L0+0 
;ds3231.c,475 :: 		RTC_I2C_STOP();
	CALL        _I2C2_Stop+0, 0
;ds3231.c,477 :: 		c_temp = (uint16_t)t_msb << 2 | t_lsb >> 6;
	MOVF        Get_Temperature_t_msb_L0+0, 0 
	MOVWF       Get_Temperature_c_temp_L0+0 
	MOVLW       0
	MOVWF       Get_Temperature_c_temp_L0+1 
	RLCF        Get_Temperature_c_temp_L0+0, 1 
	BCF         Get_Temperature_c_temp_L0+0, 0 
	RLCF        Get_Temperature_c_temp_L0+1, 1 
	RLCF        Get_Temperature_c_temp_L0+0, 1 
	BCF         Get_Temperature_c_temp_L0+0, 0 
	RLCF        Get_Temperature_c_temp_L0+1, 1 
	MOVLW       6
	MOVWF       R1 
	MOVF        Get_Temperature_t_lsb_L0+0, 0 
	MOVWF       R0 
	MOVF        R1, 0 
L__Get_Temperature153:
	BZ          L__Get_Temperature154
	RRCF        R0, 1 
	BCF         R0, 7 
	ADDLW       255
	GOTO        L__Get_Temperature153
L__Get_Temperature154:
	MOVF        R0, 0 
	IORWF       Get_Temperature_c_temp_L0+0, 1 
	MOVLW       0
	IORWF       Get_Temperature_c_temp_L0+1, 1 
;ds3231.c,479 :: 		if(t_msb & 0x80)
	BTFSS       Get_Temperature_t_msb_L0+0, 7 
	GOTO        L_Get_Temperature14
;ds3231.c,480 :: 		c_temp |= 0xFC00;
	MOVLW       0
	IORWF       Get_Temperature_c_temp_L0+0, 1 
	MOVLW       252
	IORWF       Get_Temperature_c_temp_L0+1, 1 
L_Get_Temperature14:
;ds3231.c,482 :: 		return c_temp * 25;
	MOVF        Get_Temperature_c_temp_L0+0, 0 
	MOVWF       R0 
	MOVF        Get_Temperature_c_temp_L0+1, 0 
	MOVWF       R1 
	MOVLW       25
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
;ds3231.c,483 :: 		}
L_end_Get_Temperature:
	RETURN      0
; end of _Get_Temperature

_debounce:

;MyProject.c,44 :: 		char debounce()
;MyProject.c,46 :: 		char m, count = 0;
	CLRF        debounce_count_L0+0 
;MyProject.c,47 :: 		for(m = 0; m < 5; m++)
	CLRF        R1 
L_debounce15:
	MOVLW       5
	SUBWF       R1, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_debounce16
;MyProject.c,49 :: 		if ( !button1 )
	BTFSC       RB0_bit+0, BitPos(RB0_bit+0) 
	GOTO        L_debounce18
;MyProject.c,50 :: 		count++;
	INCF        debounce_count_L0+0, 1 
L_debounce18:
;MyProject.c,51 :: 		delay_ms(10);
	MOVLW       52
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_debounce19:
	DECFSZ      R13, 1, 1
	BRA         L_debounce19
	DECFSZ      R12, 1, 1
	BRA         L_debounce19
	NOP
	NOP
;MyProject.c,47 :: 		for(m = 0; m < 5; m++)
	INCF        R1, 1 
;MyProject.c,52 :: 		}
	GOTO        L_debounce15
L_debounce16:
;MyProject.c,54 :: 		if(count > 2)  return 1;
	MOVF        debounce_count_L0+0, 0 
	SUBLW       2
	BTFSC       STATUS+0, 0 
	GOTO        L_debounce20
	MOVLW       1
	MOVWF       R0 
	GOTO        L_end_debounce
L_debounce20:
;MyProject.c,55 :: 		else           return 0;
	CLRF        R0 
;MyProject.c,56 :: 		}
L_end_debounce:
	RETURN      0
; end of _debounce

_wait:

;MyProject.c,59 :: 		void wait()
;MyProject.c,61 :: 		unsigned int TMR0_value = 0;
	CLRF        wait_TMR0_value_L0+0 
	CLRF        wait_TMR0_value_L0+1 
;MyProject.c,62 :: 		TMR0L = TMR0H = 0;
	CLRF        TMR0H+0 
	MOVF        TMR0H+0, 0 
	MOVWF       TMR0L+0 
;MyProject.c,63 :: 		while( (TMR0_value < 62500L) && button1 && button2 )
L_wait22:
	MOVLW       0
	SUBLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__wait157
	MOVLW       0
	SUBLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__wait157
	MOVLW       244
	SUBWF       wait_TMR0_value_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__wait157
	MOVLW       36
	SUBWF       wait_TMR0_value_L0+0, 0 
L__wait157:
	BTFSC       STATUS+0, 0 
	GOTO        L_wait23
	BTFSS       RB0_bit+0, BitPos(RB0_bit+0) 
	GOTO        L_wait23
	BTFSS       RB1_bit+0, BitPos(RB1_bit+0) 
	GOTO        L_wait23
L__wait116:
;MyProject.c,64 :: 		TMR0_value = (TMR0H << 8) | TMR0L;
	MOVF        TMR0H+0, 0 
	MOVWF       wait_TMR0_value_L0+1 
	CLRF        wait_TMR0_value_L0+0 
	MOVF        TMR0L+0, 0 
	IORWF       wait_TMR0_value_L0+0, 1 
	MOVLW       0
	IORWF       wait_TMR0_value_L0+1, 1 
	GOTO        L_wait22
L_wait23:
;MyProject.c,65 :: 		}
L_end_wait:
	RETURN      0
; end of _wait

_edit:

;MyProject.c,67 :: 		char edit(char x_pos, char y_pos, char parameter)
;MyProject.c,70 :: 		while(debounce());  // B1 butonuna basýldýðýnda deðiþmesi için deðiþken
L_edit26:
	CALL        _debounce+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_edit27
	GOTO        L_edit26
L_edit27:
;MyProject.c,71 :: 		sprinti(buffer, "%02u", (int)parameter);
	MOVLW       edit_buffer_L0+0
	MOVWF       FARG_sprinti_wh+0 
	MOVLW       hi_addr(edit_buffer_L0+0)
	MOVWF       FARG_sprinti_wh+1 
	MOVLW       ?lstr_1_MyProject+0
	MOVWF       FARG_sprinti_f+0 
	MOVLW       hi_addr(?lstr_1_MyProject+0)
	MOVWF       FARG_sprinti_f+1 
	MOVLW       higher_addr(?lstr_1_MyProject+0)
	MOVWF       FARG_sprinti_f+2 
	MOVF        FARG_edit_parameter+0, 0 
	MOVWF       FARG_sprinti_wh+5 
	MOVLW       0
	MOVWF       FARG_sprinti_wh+6 
	CALL        _sprinti+0, 0
;MyProject.c,73 :: 		while(1)
L_edit28:
;MyProject.c,75 :: 		while( !button2 )
L_edit30:
	BTFSC       RB1_bit+0, BitPos(RB1_bit+0) 
	GOTO        L_edit31
;MyProject.c,77 :: 		parameter++;
	INCF        FARG_edit_parameter+0, 1 
;MyProject.c,78 :: 		if(i == 0 && parameter > 23)
	MOVF        _i+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_edit34
	MOVF        FARG_edit_parameter+0, 0 
	SUBLW       23
	BTFSC       STATUS+0, 0 
	GOTO        L_edit34
L__edit121:
;MyProject.c,79 :: 		parameter = 0;
	CLRF        FARG_edit_parameter+0 
L_edit34:
;MyProject.c,80 :: 		if(i == 1 && parameter > 59)
	MOVF        _i+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_edit37
	MOVF        FARG_edit_parameter+0, 0 
	SUBLW       59
	BTFSC       STATUS+0, 0 
	GOTO        L_edit37
L__edit120:
;MyProject.c,81 :: 		parameter = 0;
	CLRF        FARG_edit_parameter+0 
L_edit37:
;MyProject.c,82 :: 		if(i == 2 && parameter > 31)
	MOVF        _i+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_edit40
	MOVF        FARG_edit_parameter+0, 0 
	SUBLW       31
	BTFSC       STATUS+0, 0 
	GOTO        L_edit40
L__edit119:
;MyProject.c,83 :: 		parameter = 1;
	MOVLW       1
	MOVWF       FARG_edit_parameter+0 
L_edit40:
;MyProject.c,84 :: 		if(i == 3 && parameter > 12)
	MOVF        _i+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_edit43
	MOVF        FARG_edit_parameter+0, 0 
	SUBLW       12
	BTFSC       STATUS+0, 0 
	GOTO        L_edit43
L__edit118:
;MyProject.c,85 :: 		parameter = 1;
	MOVLW       1
	MOVWF       FARG_edit_parameter+0 
L_edit43:
;MyProject.c,86 :: 		if(i == 4 && parameter > 99)
	MOVF        _i+0, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_edit46
	MOVF        FARG_edit_parameter+0, 0 
	SUBLW       99
	BTFSC       STATUS+0, 0 
	GOTO        L_edit46
L__edit117:
;MyProject.c,87 :: 		parameter = 0;
	CLRF        FARG_edit_parameter+0 
L_edit46:
;MyProject.c,89 :: 		sprinti(buffer, "%02u", (int)parameter);
	MOVLW       edit_buffer_L0+0
	MOVWF       FARG_sprinti_wh+0 
	MOVLW       hi_addr(edit_buffer_L0+0)
	MOVWF       FARG_sprinti_wh+1 
	MOVLW       ?lstr_2_MyProject+0
	MOVWF       FARG_sprinti_f+0 
	MOVLW       hi_addr(?lstr_2_MyProject+0)
	MOVWF       FARG_sprinti_f+1 
	MOVLW       higher_addr(?lstr_2_MyProject+0)
	MOVWF       FARG_sprinti_f+2 
	MOVF        FARG_edit_parameter+0, 0 
	MOVWF       FARG_sprinti_wh+5 
	MOVLW       0
	MOVWF       FARG_sprinti_wh+6 
	CALL        _sprinti+0, 0
;MyProject.c,90 :: 		LCD_Out(y_pos, x_pos, buffer);
	MOVF        FARG_edit_y_pos+0, 0 
	MOVWF       FARG_Lcd_Out_row+0 
	MOVF        FARG_edit_x_pos+0, 0 
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       edit_buffer_L0+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(edit_buffer_L0+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;MyProject.c,91 :: 		delay_ms(200);
	MOVLW       5
	MOVWF       R11, 0
	MOVLW       15
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_edit47:
	DECFSZ      R13, 1, 1
	BRA         L_edit47
	DECFSZ      R12, 1, 1
	BRA         L_edit47
	DECFSZ      R11, 1, 1
	BRA         L_edit47
;MyProject.c,92 :: 		}
	GOTO        L_edit30
L_edit31:
;MyProject.c,94 :: 		LCD_Out(y_pos, x_pos, "  ");
	MOVF        FARG_edit_y_pos+0, 0 
	MOVWF       FARG_Lcd_Out_row+0 
	MOVF        FARG_edit_x_pos+0, 0 
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr3_MyProject+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr3_MyProject+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;MyProject.c,95 :: 		wait();
	CALL        _wait+0, 0
;MyProject.c,96 :: 		LCD_Out(y_pos, x_pos, buffer);
	MOVF        FARG_edit_y_pos+0, 0 
	MOVWF       FARG_Lcd_Out_row+0 
	MOVF        FARG_edit_x_pos+0, 0 
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       edit_buffer_L0+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(edit_buffer_L0+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;MyProject.c,97 :: 		wait();
	CALL        _wait+0, 0
;MyProject.c,99 :: 		if(!button1) // Buton 1 basýldýgýnda döngüye giriyor
	BTFSC       RB0_bit+0, BitPos(RB0_bit+0) 
	GOTO        L_edit48
;MyProject.c,101 :: 		i++;                // Diðer parametreye geçiyor
	INCF        _i+0, 1 
;MyProject.c,102 :: 		return parameter;   // Parametreye dönüyor ve çýkýyor
	MOVF        FARG_edit_parameter+0, 0 
	MOVWF       R0 
	GOTO        L_end_edit
;MyProject.c,103 :: 		}
L_edit48:
;MyProject.c,104 :: 		}
	GOTO        L_edit28
;MyProject.c,105 :: 		}
L_end_edit:
	RETURN      0
; end of _edit

_dow_print:

;MyProject.c,107 :: 		void dow_print()
;MyProject.c,109 :: 		switch(mytime->dow)
	MOVLW       3
	ADDWF       _mytime+0, 0 
	MOVWF       FLOC__dow_print+0 
	MOVLW       0
	ADDWFC      _mytime+1, 0 
	MOVWF       FLOC__dow_print+1 
	GOTO        L_dow_print49
;MyProject.c,111 :: 		case SUNDAY   :  LCD_Out(2, 7, "PZR");  break;
L_dow_print51:
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       7
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr4_MyProject+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr4_MyProject+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
	GOTO        L_dow_print50
;MyProject.c,112 :: 		case MONDAY   :  LCD_Out(2, 7, "PZT");  break;
L_dow_print52:
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       7
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr5_MyProject+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr5_MyProject+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
	GOTO        L_dow_print50
;MyProject.c,113 :: 		case TUESDAY  :  LCD_Out(2, 7, "SAL");  break;
L_dow_print53:
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       7
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr6_MyProject+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr6_MyProject+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
	GOTO        L_dow_print50
;MyProject.c,114 :: 		case WEDNESDAY:  LCD_Out(2, 7, "CAR");  break;
L_dow_print54:
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       7
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr7_MyProject+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr7_MyProject+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
	GOTO        L_dow_print50
;MyProject.c,115 :: 		case THURSDAY :  LCD_Out(2, 7, "PER");  break;
L_dow_print55:
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       7
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr8_MyProject+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr8_MyProject+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
	GOTO        L_dow_print50
;MyProject.c,116 :: 		case FRIDAY   :  LCD_Out(2, 7, "CUM");  break;
L_dow_print56:
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       7
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr9_MyProject+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr9_MyProject+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
	GOTO        L_dow_print50
;MyProject.c,117 :: 		default       :  LCD_Out(2, 7, "CMR");
L_dow_print57:
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       7
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr10_MyProject+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr10_MyProject+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;MyProject.c,118 :: 		}
	GOTO        L_dow_print50
L_dow_print49:
	MOVFF       FLOC__dow_print+0, FSR0L+0
	MOVFF       FLOC__dow_print+1, FSR0H+0
	MOVF        POSTINC0+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_dow_print51
	MOVFF       FLOC__dow_print+0, FSR0L+0
	MOVFF       FLOC__dow_print+1, FSR0H+0
	MOVF        POSTINC0+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_dow_print52
	MOVFF       FLOC__dow_print+0, FSR0L+0
	MOVFF       FLOC__dow_print+1, FSR0H+0
	MOVF        POSTINC0+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_dow_print53
	MOVFF       FLOC__dow_print+0, FSR0L+0
	MOVFF       FLOC__dow_print+1, FSR0H+0
	MOVF        POSTINC0+0, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_dow_print54
	MOVFF       FLOC__dow_print+0, FSR0L+0
	MOVFF       FLOC__dow_print+1, FSR0H+0
	MOVF        POSTINC0+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L_dow_print55
	MOVFF       FLOC__dow_print+0, FSR0L+0
	MOVFF       FLOC__dow_print+1, FSR0H+0
	MOVF        POSTINC0+0, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L_dow_print56
	GOTO        L_dow_print57
L_dow_print50:
;MyProject.c,119 :: 		}
L_end_dow_print:
	RETURN      0
; end of _dow_print

_rtc_print:

;MyProject.c,121 :: 		void rtc_print()
;MyProject.c,125 :: 		dow_print();
	CALL        _dow_print+0, 0
;MyProject.c,127 :: 		sprinti(buffer, "%02u:%02u:%02u", (int)mytime->hours, (int)mytime->minutes, (int)mytime->seconds);
	MOVLW       rtc_print_buffer_L0+0
	MOVWF       FARG_sprinti_wh+0 
	MOVLW       hi_addr(rtc_print_buffer_L0+0)
	MOVWF       FARG_sprinti_wh+1 
	MOVLW       ?lstr_11_MyProject+0
	MOVWF       FARG_sprinti_f+0 
	MOVLW       hi_addr(?lstr_11_MyProject+0)
	MOVWF       FARG_sprinti_f+1 
	MOVLW       higher_addr(?lstr_11_MyProject+0)
	MOVWF       FARG_sprinti_f+2 
	MOVLW       2
	ADDWF       _mytime+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       0
	ADDWFC      _mytime+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_sprinti_wh+5 
	MOVLW       0
	MOVWF       FARG_sprinti_wh+6 
	MOVLW       1
	ADDWF       _mytime+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       0
	ADDWFC      _mytime+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_sprinti_wh+7 
	MOVLW       0
	MOVWF       FARG_sprinti_wh+8 
	MOVFF       _mytime+0, FSR0L+0
	MOVFF       _mytime+1, FSR0H+0
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       FARG_sprinti_wh+9 
	MOVLW       0
	MOVWF       FARG_sprinti_wh+10 
	CALL        _sprinti+0, 0
;MyProject.c,128 :: 		LCD_Out(1, 11, buffer);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       11
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       rtc_print_buffer_L0+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(rtc_print_buffer_L0+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;MyProject.c,130 :: 		sprinti(buffer, "-%02u-%02u-20%02u", (int)mytime->day, (int)mytime->month, (int)mytime->year);
	MOVLW       rtc_print_buffer_L0+0
	MOVWF       FARG_sprinti_wh+0 
	MOVLW       hi_addr(rtc_print_buffer_L0+0)
	MOVWF       FARG_sprinti_wh+1 
	MOVLW       ?lstr_12_MyProject+0
	MOVWF       FARG_sprinti_f+0 
	MOVLW       hi_addr(?lstr_12_MyProject+0)
	MOVWF       FARG_sprinti_f+1 
	MOVLW       higher_addr(?lstr_12_MyProject+0)
	MOVWF       FARG_sprinti_f+2 
	MOVLW       4
	ADDWF       _mytime+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       0
	ADDWFC      _mytime+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_sprinti_wh+5 
	MOVLW       0
	MOVWF       FARG_sprinti_wh+6 
	MOVLW       5
	ADDWF       _mytime+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       0
	ADDWFC      _mytime+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_sprinti_wh+7 
	MOVLW       0
	MOVWF       FARG_sprinti_wh+8 
	MOVLW       6
	ADDWF       _mytime+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       0
	ADDWFC      _mytime+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_sprinti_wh+9 
	MOVLW       0
	MOVWF       FARG_sprinti_wh+10 
	CALL        _sprinti+0, 0
;MyProject.c,131 :: 		LCD_Out(2, 10, buffer);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       10
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       rtc_print_buffer_L0+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(rtc_print_buffer_L0+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;MyProject.c,132 :: 		}
L_end_rtc_print:
	RETURN      0
; end of _rtc_print

_Start_Signal:

;MyProject.c,137 :: 		void Start_Signal(void)
;MyProject.c,139 :: 		DHT22_PIN     = 0;   // DHT22 pinine 0 volt gönderilmesi
	BCF         RB2_bit+0, BitPos(RB2_bit+0) 
;MyProject.c,140 :: 		DHT22_PIN_DIR = 0;   // Çýkýsýnýn ayarlanmasý
	BCF         TRISB2_bit+0, BitPos(TRISB2_bit+0) 
;MyProject.c,141 :: 		delay_ms(25);        // 25 mikrosaniye bekliyor
	MOVLW       130
	MOVWF       R12, 0
	MOVLW       221
	MOVWF       R13, 0
L_Start_Signal58:
	DECFSZ      R13, 1, 1
	BRA         L_Start_Signal58
	DECFSZ      R12, 1, 1
	BRA         L_Start_Signal58
	NOP
	NOP
;MyProject.c,142 :: 		DHT22_PIN     = 1;   // pine 5 volt gönderilmesi
	BSF         RB2_bit+0, BitPos(RB2_bit+0) 
;MyProject.c,143 :: 		delay_us(30);        // 30 mikrosaniye bekliyor
	MOVLW       39
	MOVWF       R13, 0
L_Start_Signal59:
	DECFSZ      R13, 1, 1
	BRA         L_Start_Signal59
	NOP
	NOP
;MyProject.c,144 :: 		DHT22_PIN_DIR = 1;
	BSF         TRISB2_bit+0, BitPos(TRISB2_bit+0) 
;MyProject.c,145 :: 		}
L_end_Start_Signal:
	RETURN      0
; end of _Start_Signal

_Check_Response:

;MyProject.c,148 :: 		char Check_Response()
;MyProject.c,150 :: 		TMR0L = TMR0H = 0;  // Reseet tuþuna 0 volt gönderilmesi
	CLRF        TMR0H+0 
	MOVF        TMR0H+0, 0 
	MOVWF       TMR0L+0 
;MyProject.c,153 :: 		while(!DHT22_PIN && TMR0L < 100) ;
L_Check_Response60:
	BTFSC       RB2_bit+0, BitPos(RB2_bit+0) 
	GOTO        L_Check_Response61
	MOVLW       100
	SUBWF       TMR0L+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Check_Response61
L__Check_Response123:
	GOTO        L_Check_Response60
L_Check_Response61:
;MyProject.c,155 :: 		if(TMR0L >= 100)  // yanýt süresi > 80µS ==> yanýt hatasý ise
	MOVLW       100
	SUBWF       TMR0L+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_Check_Response64
;MyProject.c,156 :: 		return 0;       // 0 döndür (cihazýn yanýt vermede bir sorunu var)
	CLRF        R0 
	GOTO        L_end_Check_Response
L_Check_Response64:
;MyProject.c,158 :: 		TMR0L = TMR0H = 0;  // dinlenme Timer0 düþük ve yüksek kayýtlar
	CLRF        TMR0H+0 
	MOVF        TMR0H+0, 0 
	MOVWF       TMR0L+0 
;MyProject.c,161 :: 		while(DHT22_PIN && TMR0L < 100) ;
L_Check_Response65:
	BTFSS       RB2_bit+0, BitPos(RB2_bit+0) 
	GOTO        L_Check_Response66
	MOVLW       100
	SUBWF       TMR0L+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Check_Response66
L__Check_Response122:
	GOTO        L_Check_Response65
L_Check_Response66:
;MyProject.c,163 :: 		if(TMR0L >= 100)  // yanýt süresi > 80µS ==> yanýt hatasý ise
	MOVLW       100
	SUBWF       TMR0L+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_Check_Response69
;MyProject.c,164 :: 		return 0;       // 0 döndür (cihazýn yanýt vermede bir sorunu var)
	CLRF        R0 
	GOTO        L_end_Check_Response
L_Check_Response69:
;MyProject.c,166 :: 		return 1;   // döngüye tekrar sokuluyor 1 (yanýt tamam)
	MOVLW       1
	MOVWF       R0 
;MyProject.c,167 :: 		}
L_end_Check_Response:
	RETURN      0
; end of _Check_Response

_Read_Data:

;MyProject.c,170 :: 		void Read_Data(unsigned short* dht_data)
;MyProject.c,172 :: 		*dht_data = 0;
	MOVFF       FARG_Read_Data_dht_data+0, FSR1L+0
	MOVFF       FARG_Read_Data_dht_data+1, FSR1H+0
	CLRF        POSTINC1+0 
;MyProject.c,173 :: 		for(i = 0; i < 8; i++)
	CLRF        _i+0 
L_Read_Data70:
	MOVLW       128
	XORWF       _i+0, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       8
	SUBWF       R0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Read_Data71
;MyProject.c,175 :: 		TMR0L = TMR0H = 0;
	CLRF        TMR0H+0 
	MOVF        TMR0H+0, 0 
	MOVWF       TMR0L+0 
;MyProject.c,177 :: 		while(!DHT22_PIN)
L_Read_Data73:
	BTFSC       RB2_bit+0, BitPos(RB2_bit+0) 
	GOTO        L_Read_Data74
;MyProject.c,179 :: 		if(TMR0L > 80);
	MOVF        TMR0L+0, 0 
	SUBLW       80
	BTFSC       STATUS+0, 0 
	GOTO        L_Read_Data75
L_Read_Data75:
;MyProject.c,180 :: 		}
	GOTO        L_Read_Data73
L_Read_Data74:
;MyProject.c,182 :: 		TMR0L = TMR0H = 0;
	CLRF        TMR0H+0 
	MOVF        TMR0H+0, 0 
	MOVWF       TMR0L+0 
;MyProject.c,184 :: 		while(DHT22_PIN)
L_Read_Data76:
	BTFSS       RB2_bit+0, BitPos(RB2_bit+0) 
	GOTO        L_Read_Data77
;MyProject.c,186 :: 		if(TMR0L > 80)
	MOVF        TMR0L+0, 0 
	SUBLW       80
	BTFSC       STATUS+0, 0 
	GOTO        L_Read_Data78
;MyProject.c,187 :: 		return;
	GOTO        L_end_Read_Data
L_Read_Data78:
;MyProject.c,188 :: 		}
	GOTO        L_Read_Data76
L_Read_Data77:
;MyProject.c,189 :: 		if(TMR0L > 40)
	MOVF        TMR0L+0, 0 
	SUBLW       40
	BTFSC       STATUS+0, 0 
	GOTO        L_Read_Data79
;MyProject.c,191 :: 		*dht_data |= (1 << (7 - i));
	MOVF        _i+0, 0 
	SUBLW       7
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       R1 
	MOVLW       1
	MOVWF       R0 
	MOVF        R1, 0 
L__Read_Data164:
	BZ          L__Read_Data165
	RLCF        R0, 1 
	BCF         R0, 0 
	ADDLW       255
	GOTO        L__Read_Data164
L__Read_Data165:
	MOVFF       FARG_Read_Data_dht_data+0, FSR0L+0
	MOVFF       FARG_Read_Data_dht_data+1, FSR0H+0
	MOVFF       FARG_Read_Data_dht_data+0, FSR1L+0
	MOVFF       FARG_Read_Data_dht_data+1, FSR1H+0
	MOVF        R0, 0 
	IORWF       POSTINC0+0, 1 
;MyProject.c,192 :: 		}
L_Read_Data79:
;MyProject.c,173 :: 		for(i = 0; i < 8; i++)
	INCF        _i+0, 1 
;MyProject.c,193 :: 		}
	GOTO        L_Read_Data70
L_Read_Data71:
;MyProject.c,196 :: 		return;
;MyProject.c,197 :: 		}
L_end_Read_Data:
	RETURN      0
; end of _Read_Data

_main:

;MyProject.c,202 :: 		void main()
;MyProject.c,204 :: 		OSCCON = 0x70;      // dahili osilatörü 16MHz'e ayarlýyoruz
	MOVLW       112
	MOVWF       OSCCON+0 
;MyProject.c,205 :: 		ANSELB = 0;         // tüm PORTB pinlerini dijital olarak yapýlandýrýyoruz
	CLRF        ANSELB+0 
;MyProject.c,206 :: 		ANSELC = 0;         // tüm PORTC pinlerini dijital olarak yapýlandýrýyoruz
	CLRF        ANSELC+0 
;MyProject.c,207 :: 		ANSELD = 0;         // tüm PORTD pinlerini dijital olarak yapýlandýrýyoruz
	CLRF        ANSELD+0 
;MyProject.c,209 :: 		RBPU_bit  = 0;      // RBPU bitini temizle (INTCON2.7)
	BCF         RBPU_bit+0, BitPos(RBPU_bit+0) 
;MyProject.c,210 :: 		WPUB      = 0x03;   // WPUB kaydý = 0b00000011
	MOVLW       3
	MOVWF       WPUB+0 
;MyProject.c,212 :: 		delay_ms(1000);           // 1 saniye bekliyoruz
	MOVLW       21
	MOVWF       R11, 0
	MOVLW       75
	MOVWF       R12, 0
	MOVLW       190
	MOVWF       R13, 0
L_main80:
	DECFSZ      R13, 1, 1
	BRA         L_main80
	DECFSZ      R12, 1, 1
	BRA         L_main80
	DECFSZ      R11, 1, 1
	BRA         L_main80
	NOP
;MyProject.c,213 :: 		Lcd_Init();               // LCD modülünü baþlatyoruz
	CALL        _Lcd_Init+0, 0
;MyProject.c,214 :: 		Lcd_Cmd(_LCD_CURSOR_OFF); // Ýmleci kapatýyoruz
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;MyProject.c,215 :: 		Lcd_Cmd(_LCD_CLEAR);      // LCD temizleme Komutu
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;MyProject.c,216 :: 		LCD_Out(1, 1, "ZAMAN:");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr13_MyProject+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr13_MyProject+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;MyProject.c,217 :: 		LCD_Out(2, 1, "TARIH:");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr14_MyProject+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr14_MyProject+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;MyProject.c,218 :: 		LCD_Out(3, 1, "SICAK:");
	MOVLW       3
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr15_MyProject+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr15_MyProject+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;MyProject.c,219 :: 		LCD_Out(4, 1, "NEM:");
	MOVLW       4
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr16_MyProject+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr16_MyProject+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;MyProject.c,222 :: 		I2C2_Init(100000);
	MOVLW       40
	MOVWF       SSP2ADD+0 
	CALL        _I2C2_Init+0, 0
;MyProject.c,224 :: 		SPI1_Init_Advanced(_SPI_MASTER_OSC_DIV64, _SPI_DATA_SAMPLE_MIDDLE, _SPI_CLK_IDLE_LOW, _SPI_LOW_2_HIGH);
	MOVLW       2
	MOVWF       FARG_SPI1_Init_Advanced_master+0 
	CLRF        FARG_SPI1_Init_Advanced_data_sample+0 
	CLRF        FARG_SPI1_Init_Advanced_clock_idle+0 
	MOVLW       1
	MOVWF       FARG_SPI1_Init_Advanced_transmit_edge+0 
	CALL        _SPI1_Init_Advanced+0, 0
;MyProject.c,226 :: 		UART1_Init(9600);   // UART1 modülünü 9600 baud'da baþlat
	BSF         BAUDCON+0, 3, 0
	MOVLW       1
	MOVWF       SPBRGH+0 
	MOVLW       160
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;MyProject.c,227 :: 		UART1_Write_Text("\r\n\nFat Kutuphanesi Baslatildi ... ");
	MOVLW       ?lstr17_MyProject+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr17_MyProject+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;MyProject.c,229 :: 		fat_err = FAT32_Init();
	CALL        _FAT32_Init+0, 0
	MOVF        R0, 0 
	MOVWF       _fat_err+0 
;MyProject.c,230 :: 		if(fat_err != 0)
	MOVF        R0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_main81
;MyProject.c,232 :: 		UART1_Write_Text("Fat Kutuphanesi Baslatilamadi!");
	MOVLW       ?lstr18_MyProject+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr18_MyProject+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;MyProject.c,233 :: 		}
	GOTO        L_main82
L_main81:
;MyProject.c,238 :: 		SPI1_Init_Advanced(_SPI_MASTER_OSC_DIV4, _SPI_DATA_SAMPLE_MIDDLE, _SPI_CLK_IDLE_LOW, _SPI_LOW_2_HIGH);
	CLRF        FARG_SPI1_Init_Advanced_master+0 
	CLRF        FARG_SPI1_Init_Advanced_data_sample+0 
	CLRF        FARG_SPI1_Init_Advanced_clock_idle+0 
	MOVLW       1
	MOVWF       FARG_SPI1_Init_Advanced_transmit_edge+0 
	CALL        _SPI1_Init_Advanced+0, 0
;MyProject.c,239 :: 		UART1_Write_Text("FAT Kutuphanesi Bulundu");
	MOVLW       ?lstr19_MyProject+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr19_MyProject+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;MyProject.c,240 :: 		if(FAT32_Exists("DHT22Log.txt") == 0)   // 'DHT22.Log.txt' adlý dosyanýn mevcut olup olmadýðýný test edin
	MOVLW       ?lstr20_MyProject+0
	MOVWF       FARG_FAT32_Exists_fn+0 
	MOVLW       hi_addr(?lstr20_MyProject+0)
	MOVWF       FARG_FAT32_Exists_fn+1 
	CALL        _FAT32_Exists+0, 0
	MOVF        R0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_main83
;MyProject.c,243 :: 		UART1_Write_Text("\r\n\r\nCreate 'DHT22Log.txt' file ... ");
	MOVLW       ?lstr21_MyProject+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr21_MyProject+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;MyProject.c,244 :: 		fileHandle = FAT32_Open("DHT22Log.txt", FILE_WRITE);
	MOVLW       ?lstr22_MyProject+0
	MOVWF       FARG_FAT32_Open_fn+0 
	MOVLW       hi_addr(?lstr22_MyProject+0)
	MOVWF       FARG_FAT32_Open_fn+1 
	MOVLW       2
	MOVWF       FARG_FAT32_Open_mode+0 
	CALL        _FAT32_Open+0, 0
	MOVF        R0, 0 
	MOVWF       _fileHandle+0 
;MyProject.c,245 :: 		if(fileHandle == 0){
	MOVF        R0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_main84
;MyProject.c,246 :: 		UART1_Write_Text("OK");
	MOVLW       ?lstr23_MyProject+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr23_MyProject+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;MyProject.c,248 :: 		FAT32_Write(fileHandle, "    TARIH    |    ZAMAN  | SICAKLIK | NEM\r\n", 49);
	MOVF        _fileHandle+0, 0 
	MOVWF       FARG_FAT32_Write_fHandle+0 
	MOVLW       ?lstr24_MyProject+0
	MOVWF       FARG_FAT32_Write_wrBuf+0 
	MOVLW       hi_addr(?lstr24_MyProject+0)
	MOVWF       FARG_FAT32_Write_wrBuf+1 
	MOVLW       49
	MOVWF       FARG_FAT32_Write_len+0 
	MOVLW       0
	MOVWF       FARG_FAT32_Write_len+1 
	CALL        _FAT32_Write+0, 0
;MyProject.c,249 :: 		FAT32_Write(fileHandle, "(dd-mm-yyyy)|(hh:mm:ss)|             |\r\n", 40);
	MOVF        _fileHandle+0, 0 
	MOVWF       FARG_FAT32_Write_fHandle+0 
	MOVLW       ?lstr25_MyProject+0
	MOVWF       FARG_FAT32_Write_wrBuf+0 
	MOVLW       hi_addr(?lstr25_MyProject+0)
	MOVWF       FARG_FAT32_Write_wrBuf+1 
	MOVLW       40
	MOVWF       FARG_FAT32_Write_len+0 
	MOVLW       0
	MOVWF       FARG_FAT32_Write_len+1 
	CALL        _FAT32_Write+0, 0
;MyProject.c,250 :: 		FAT32_Write(fileHandle, "            |          |             |\r\n", 40);
	MOVF        _fileHandle+0, 0 
	MOVWF       FARG_FAT32_Write_fHandle+0 
	MOVLW       ?lstr26_MyProject+0
	MOVWF       FARG_FAT32_Write_wrBuf+0 
	MOVLW       hi_addr(?lstr26_MyProject+0)
	MOVWF       FARG_FAT32_Write_wrBuf+1 
	MOVLW       40
	MOVWF       FARG_FAT32_Write_len+0 
	MOVLW       0
	MOVWF       FARG_FAT32_Write_len+1 
	CALL        _FAT32_Write+0, 0
;MyProject.c,252 :: 		FAT32_Close(fileHandle);
	MOVF        _fileHandle+0, 0 
	MOVWF       FARG_FAT32_Close_fHandle+0 
	CALL        _FAT32_Close+0, 0
;MyProject.c,253 :: 		}
	GOTO        L_main85
L_main84:
;MyProject.c,255 :: 		UART1_Write_Text("DOSYA HATASI.");
	MOVLW       ?lstr27_MyProject+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr27_MyProject+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
L_main85:
;MyProject.c,256 :: 		}
L_main83:
;MyProject.c,257 :: 		}
L_main82:
;MyProject.c,259 :: 		while(1)
L_main86:
;MyProject.c,262 :: 		mytime = RTC_Get();
	CALL        _RTC_Get+0, 0
	MOVF        R0, 0 
	MOVWF       _mytime+0 
	MOVF        R1, 0 
	MOVWF       _mytime+1 
;MyProject.c,264 :: 		rtc_print();
	CALL        _rtc_print+0, 0
;MyProject.c,266 :: 		if( !button1 )    // B1 düðmesine basýlýrsa
	BTFSC       RB0_bit+0, BitPos(RB0_bit+0) 
	GOTO        L_main88
;MyProject.c,267 :: 		if( debounce() )  // geri dönme iþlevini çaðýr (B1'e basýldýðýndan emin olun) Geri dönme iþlevini çaðýr (B1'e basýldýðýndan emin olun)
	CALL        _debounce+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main89
;MyProject.c,269 :: 		i = 0;
	CLRF        _i+0 
;MyProject.c,270 :: 		while( debounce() );  // geri dönme iþlevini çaðýrýn (B1 düðmesinin serbest býrakýlmasýný bekleyin)
L_main90:
	CALL        _debounce+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main91
	GOTO        L_main90
L_main91:
;MyProject.c,271 :: 		T0CON  = 0x84;        // Timer0 modülünü etkinleþtir (16-bit zamanlayýcý ve ön ölçekleyici = 32)
	MOVLW       132
	MOVWF       T0CON+0 
;MyProject.c,273 :: 		mytime->hours   = edit(11, 1, mytime->hours);    // Saati Ayarla
	MOVLW       2
	ADDWF       _mytime+0, 0 
	MOVWF       FLOC__main+0 
	MOVLW       0
	ADDWFC      _mytime+1, 0 
	MOVWF       FLOC__main+1 
	MOVLW       11
	MOVWF       FARG_edit_x_pos+0 
	MOVLW       1
	MOVWF       FARG_edit_y_pos+0 
	MOVFF       FLOC__main+0, FSR0L+0
	MOVFF       FLOC__main+1, FSR0H+0
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_edit_parameter+0 
	CALL        _edit+0, 0
	MOVFF       FLOC__main+0, FSR1L+0
	MOVFF       FLOC__main+1, FSR1H+0
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;MyProject.c,274 :: 		mytime->minutes = edit(14, 1, mytime->minutes);  // Dakikayý Ayarla
	MOVLW       1
	ADDWF       _mytime+0, 0 
	MOVWF       FLOC__main+0 
	MOVLW       0
	ADDWFC      _mytime+1, 0 
	MOVWF       FLOC__main+1 
	MOVLW       14
	MOVWF       FARG_edit_x_pos+0 
	MOVLW       1
	MOVWF       FARG_edit_y_pos+0 
	MOVFF       FLOC__main+0, FSR0L+0
	MOVFF       FLOC__main+1, FSR0H+0
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_edit_parameter+0 
	CALL        _edit+0, 0
	MOVFF       FLOC__main+0, FSR1L+0
	MOVFF       FLOC__main+1, FSR1H+0
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;MyProject.c,275 :: 		mytime->seconds = 0;                             // Saniyeyi resetle
	MOVFF       _mytime+0, FSR1L+0
	MOVFF       _mytime+1, FSR1H+0
	CLRF        POSTINC1+0 
;MyProject.c,277 :: 		while(debounce());  // geri dönme iþlevini çaðýrýn (B1'in serbest býrakýlmasýný bekleyin)
L_main92:
	CALL        _debounce+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main93
	GOTO        L_main92
L_main93:
;MyProject.c,278 :: 		while(1)
L_main94:
;MyProject.c,280 :: 		while( !button2 )  //  B2 düðmesine basýlýrsa
L_main96:
	BTFSC       RB1_bit+0, BitPos(RB1_bit+0) 
	GOTO        L_main97
;MyProject.c,282 :: 		mytime->dow++;
	MOVLW       3
	ADDWF       _mytime+0, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      _mytime+1, 0 
	MOVWF       R2 
	MOVFF       R1, FSR0L+0
	MOVFF       R2, FSR0H+0
	MOVF        POSTINC0+0, 0 
	ADDLW       1
	MOVWF       R0 
	MOVFF       R1, FSR1L+0
	MOVFF       R2, FSR1H+0
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;MyProject.c,283 :: 		if(mytime->dow > SATURDAY)
	MOVLW       3
	ADDWF       _mytime+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       0
	ADDWFC      _mytime+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	SUBLW       7
	BTFSC       STATUS+0, 0 
	GOTO        L_main98
;MyProject.c,284 :: 		mytime->dow = SUNDAY;
	MOVLW       3
	ADDWF       _mytime+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       0
	ADDWFC      _mytime+1, 0 
	MOVWF       FSR1L+1 
	MOVLW       1
	MOVWF       POSTINC1+0 
L_main98:
;MyProject.c,285 :: 		dow_print();     // haftanýn gününü yazdýr
	CALL        _dow_print+0, 0
;MyProject.c,286 :: 		delay_ms(500);   // yarým saniye bekle
	MOVLW       11
	MOVWF       R11, 0
	MOVLW       38
	MOVWF       R12, 0
	MOVLW       93
	MOVWF       R13, 0
L_main99:
	DECFSZ      R13, 1, 1
	BRA         L_main99
	DECFSZ      R12, 1, 1
	BRA         L_main99
	DECFSZ      R11, 1, 1
	BRA         L_main99
	NOP
	NOP
;MyProject.c,287 :: 		}
	GOTO        L_main96
L_main97:
;MyProject.c,288 :: 		LCD_Out(2, 7, "   ");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       7
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr28_MyProject+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr28_MyProject+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;MyProject.c,289 :: 		wait();         //  wait()    fonsiyonun çaðýr
	CALL        _wait+0, 0
;MyProject.c,290 :: 		dow_print();    // haftanýn gününü yazdýr
	CALL        _dow_print+0, 0
;MyProject.c,291 :: 		wait();
	CALL        _wait+0, 0
;MyProject.c,292 :: 		if( !button1 )
	BTFSC       RB0_bit+0, BitPos(RB0_bit+0) 
	GOTO        L_main100
;MyProject.c,293 :: 		break;
	GOTO        L_main95
L_main100:
;MyProject.c,294 :: 		}
	GOTO        L_main94
L_main95:
;MyProject.c,296 :: 		mytime->day     = edit(11, 2, mytime->day);      // günü düzenle (ayýn günü)
	MOVLW       4
	ADDWF       _mytime+0, 0 
	MOVWF       FLOC__main+0 
	MOVLW       0
	ADDWFC      _mytime+1, 0 
	MOVWF       FLOC__main+1 
	MOVLW       11
	MOVWF       FARG_edit_x_pos+0 
	MOVLW       2
	MOVWF       FARG_edit_y_pos+0 
	MOVFF       FLOC__main+0, FSR0L+0
	MOVFF       FLOC__main+1, FSR0H+0
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_edit_parameter+0 
	CALL        _edit+0, 0
	MOVFF       FLOC__main+0, FSR1L+0
	MOVFF       FLOC__main+1, FSR1H+0
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;MyProject.c,297 :: 		mytime->month   = edit(14, 2, mytime->month);    // ayý düzenle
	MOVLW       5
	ADDWF       _mytime+0, 0 
	MOVWF       FLOC__main+0 
	MOVLW       0
	ADDWFC      _mytime+1, 0 
	MOVWF       FLOC__main+1 
	MOVLW       14
	MOVWF       FARG_edit_x_pos+0 
	MOVLW       2
	MOVWF       FARG_edit_y_pos+0 
	MOVFF       FLOC__main+0, FSR0L+0
	MOVFF       FLOC__main+1, FSR0H+0
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_edit_parameter+0 
	CALL        _edit+0, 0
	MOVFF       FLOC__main+0, FSR1L+0
	MOVFF       FLOC__main+1, FSR1H+0
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;MyProject.c,298 :: 		mytime->year    = edit(19, 2, mytime->year);     // yýlý düzenle
	MOVLW       6
	ADDWF       _mytime+0, 0 
	MOVWF       FLOC__main+0 
	MOVLW       0
	ADDWFC      _mytime+1, 0 
	MOVWF       FLOC__main+1 
	MOVLW       19
	MOVWF       FARG_edit_x_pos+0 
	MOVLW       2
	MOVWF       FARG_edit_y_pos+0 
	MOVFF       FLOC__main+0, FSR0L+0
	MOVFF       FLOC__main+1, FSR0H+0
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_edit_parameter+0 
	CALL        _edit+0, 0
	MOVFF       FLOC__main+0, FSR1L+0
	MOVFF       FLOC__main+1, FSR1H+0
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;MyProject.c,300 :: 		TMR0ON_bit = 0;     // Timer0 modülünü devre dýþý býrak
	BCF         TMR0ON_bit+0, BitPos(TMR0ON_bit+0) 
;MyProject.c,301 :: 		while(debounce());  //geri dönme iþlevini çaðýrýn (B1 düðmesinin serbest býrakýlmasýný bekleyin)
L_main101:
	CALL        _debounce+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main102
	GOTO        L_main101
L_main102:
;MyProject.c,303 :: 		RTC_Set(mytime);
	MOVF        _mytime+0, 0 
	MOVWF       FARG_RTC_Set_time_t+0 
	MOVF        _mytime+1, 0 
	MOVWF       FARG_RTC_Set_time_t+1 
	CALL        _RTC_Set+0, 0
;MyProject.c,304 :: 		}
L_main89:
L_main88:
;MyProject.c,306 :: 		if( mytime->seconds != p_second )
	MOVFF       _mytime+0, FSR0L+0
	MOVFF       _mytime+1, FSR0H+0
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVLW       0
	MOVWF       R0 
	MOVLW       0
	BTFSC       _p_second+0, 7 
	MOVLW       255
	XORWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main167
	MOVF        _p_second+0, 0 
	XORWF       R1, 0 
L__main167:
	BTFSC       STATUS+0, 2 
	GOTO        L_main103
;MyProject.c,312 :: 		p_second = mytime->seconds;  // geçerli saniyeyi kaydet
	MOVFF       _mytime+0, FSR0L+0
	MOVFF       _mytime+1, FSR0H+0
	MOVF        POSTINC0+0, 0 
	MOVWF       _p_second+0 
;MyProject.c,313 :: 		T0CON  = 0x81;   // Timer0 modülünü etkinleþtir (16-bit zamanlayýcý ve ön ölçekleyici = 4)
	MOVLW       129
	MOVWF       T0CON+0 
;MyProject.c,315 :: 		Start_Signal();  // sensöre bir baþlangýç ??sinyali gönder
	CALL        _Start_Signal+0, 0
;MyProject.c,316 :: 		if(Check_Response())  // sensörden yanýt gelip gelmediðini kontrol edin (Tamam ise nem ve sýcaklýk verilerini okumaya baþlayýn)
	CALL        _Check_Response+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main104
;MyProject.c,318 :: 		Read_Data(&RH_Byte1);  //  humidity 1st byte okumasý ve kaydedilmesi RH_Byte1
	MOVLW       main_RH_Byte1_L2+0
	MOVWF       FARG_Read_Data_dht_data+0 
	MOVLW       hi_addr(main_RH_Byte1_L2+0)
	MOVWF       FARG_Read_Data_dht_data+1 
	CALL        _Read_Data+0, 0
;MyProject.c,319 :: 		Read_Data(&RH_Byte2);  //  humidity 2nd byte okunmasý ve kaydedilmesi H_Byte2
	MOVLW       main_RH_Byte2_L2+0
	MOVWF       FARG_Read_Data_dht_data+0 
	MOVLW       hi_addr(main_RH_Byte2_L2+0)
	MOVWF       FARG_Read_Data_dht_data+1 
	CALL        _Read_Data+0, 0
;MyProject.c,320 :: 		Read_Data(&T_Byte1);   //  sýcaklýk 1st byte okunmasý ve yazýlmasý  T_Byte1
	MOVLW       main_T_Byte1_L2+0
	MOVWF       FARG_Read_Data_dht_data+0 
	MOVLW       hi_addr(main_T_Byte1_L2+0)
	MOVWF       FARG_Read_Data_dht_data+1 
	CALL        _Read_Data+0, 0
;MyProject.c,321 :: 		Read_Data(&T_Byte2);   //  sýcaklýk  2nd byte okunmasý  ve  yazýlmasý T_Byte2
	MOVLW       main_T_Byte2_L2+0
	MOVWF       FARG_Read_Data_dht_data+0 
	MOVLW       hi_addr(main_T_Byte2_L2+0)
	MOVWF       FARG_Read_Data_dht_data+1 
	CALL        _Read_Data+0, 0
;MyProject.c,322 :: 		Read_Data(&CheckSum);  // saðlama toplamýný okuyun ve deðerini CheckSum'a kaydedin
	MOVLW       main_CheckSum_L2+0
	MOVWF       FARG_Read_Data_dht_data+0 
	MOVLW       hi_addr(main_CheckSum_L2+0)
	MOVWF       FARG_Read_Data_dht_data+1 
	CALL        _Read_Data+0, 0
;MyProject.c,325 :: 		if(CheckSum == ((RH_Byte1 + RH_Byte2 + T_Byte1 + T_Byte2) & 0xFF))
	MOVF        main_RH_Byte2_L2+0, 0 
	ADDWF       main_RH_Byte1_L2+0, 0 
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVF        main_T_Byte1_L2+0, 0 
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVF        main_T_Byte2_L2+0, 0 
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVLW       255
	ANDWF       R0, 0 
	MOVWF       R2 
	MOVF        R1, 0 
	MOVWF       R3 
	MOVLW       0
	ANDWF       R3, 1 
	MOVLW       0
	XORWF       R3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main168
	MOVF        R2, 0 
	XORWF       main_CheckSum_L2+0, 0 
L__main168:
	BTFSS       STATUS+0, 2 
	GOTO        L_main105
;MyProject.c,327 :: 		read_ok = 1;
	BSF         main_read_ok_L2+0, BitPos(main_read_ok_L2+0) 
;MyProject.c,328 :: 		Humi = (RH_Byte1 << 8) | RH_Byte2;
	MOVF        main_RH_Byte1_L2+0, 0 
	MOVWF       main_Humi_L2+1 
	CLRF        main_Humi_L2+0 
	MOVF        main_RH_Byte2_L2+0, 0 
	IORWF       main_Humi_L2+0, 1 
	MOVLW       0
	IORWF       main_Humi_L2+1, 1 
;MyProject.c,329 :: 		Temp = (T_Byte1  << 8) |  T_Byte2;
	MOVF        main_T_Byte1_L2+0, 0 
	MOVWF       R1 
	CLRF        R0 
	MOVF        main_T_Byte2_L2+0, 0 
	IORWF       R0, 0 
	MOVWF       R2 
	MOVF        R1, 0 
	MOVWF       R3 
	MOVLW       0
	IORWF       R3, 1 
	MOVF        R2, 0 
	MOVWF       main_Temp_L2+0 
	MOVF        R3, 0 
	MOVWF       main_Temp_L2+1 
;MyProject.c,331 :: 		if(Temp & 0x8000) {      //
	BTFSS       R3, 7 
	GOTO        L_main106
;MyProject.c,332 :: 		Temp = Temp & 0x7FFF;
	MOVLW       255
	ANDWF       main_Temp_L2+0, 0 
	MOVWF       FLOC__main+0 
	MOVF        main_Temp_L2+1, 0 
	ANDLW       127
	MOVWF       FLOC__main+1 
	MOVF        FLOC__main+0, 0 
	MOVWF       main_Temp_L2+0 
	MOVF        FLOC__main+1, 0 
	MOVWF       main_Temp_L2+1 
;MyProject.c,333 :: 		sprinti(temp_a, "-%02u.%01u%cC ", (Temp/10)%100, Temp % 10, (int)223);
	MOVLW       main_temp_a_L2+0
	MOVWF       FARG_sprinti_wh+0 
	MOVLW       hi_addr(main_temp_a_L2+0)
	MOVWF       FARG_sprinti_wh+1 
	MOVLW       ?lstr_29_MyProject+0
	MOVWF       FARG_sprinti_f+0 
	MOVLW       hi_addr(?lstr_29_MyProject+0)
	MOVWF       FARG_sprinti_f+1 
	MOVLW       higher_addr(?lstr_29_MyProject+0)
	MOVWF       FARG_sprinti_f+2 
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        FLOC__main+0, 0 
	MOVWF       R0 
	MOVF        FLOC__main+1, 0 
	MOVWF       R1 
	CALL        _Div_16X16_U+0, 0
	MOVLW       100
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16X16_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       FARG_sprinti_wh+5 
	MOVF        R1, 0 
	MOVWF       FARG_sprinti_wh+6 
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        FLOC__main+0, 0 
	MOVWF       R0 
	MOVF        FLOC__main+1, 0 
	MOVWF       R1 
	CALL        _Div_16X16_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       FARG_sprinti_wh+7 
	MOVF        R1, 0 
	MOVWF       FARG_sprinti_wh+8 
	MOVLW       223
	MOVWF       FARG_sprinti_wh+9 
	MOVLW       0
	MOVWF       FARG_sprinti_wh+10 
	CALL        _sprinti+0, 0
;MyProject.c,334 :: 		}
	GOTO        L_main107
L_main106:
;MyProject.c,336 :: 		sprinti(temp_a, " %02u.%01u%cC ", (Temp/10)%100, Temp % 10, (int)223);
	MOVLW       main_temp_a_L2+0
	MOVWF       FARG_sprinti_wh+0 
	MOVLW       hi_addr(main_temp_a_L2+0)
	MOVWF       FARG_sprinti_wh+1 
	MOVLW       ?lstr_30_MyProject+0
	MOVWF       FARG_sprinti_f+0 
	MOVLW       hi_addr(?lstr_30_MyProject+0)
	MOVWF       FARG_sprinti_f+1 
	MOVLW       higher_addr(?lstr_30_MyProject+0)
	MOVWF       FARG_sprinti_f+2 
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        main_Temp_L2+0, 0 
	MOVWF       R0 
	MOVF        main_Temp_L2+1, 0 
	MOVWF       R1 
	CALL        _Div_16X16_U+0, 0
	MOVLW       100
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16X16_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       FARG_sprinti_wh+5 
	MOVF        R1, 0 
	MOVWF       FARG_sprinti_wh+6 
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        main_Temp_L2+0, 0 
	MOVWF       R0 
	MOVF        main_Temp_L2+1, 0 
	MOVWF       R1 
	CALL        _Div_16X16_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       FARG_sprinti_wh+7 
	MOVF        R1, 0 
	MOVWF       FARG_sprinti_wh+8 
	MOVLW       223
	MOVWF       FARG_sprinti_wh+9 
	MOVLW       0
	MOVWF       FARG_sprinti_wh+10 
	CALL        _sprinti+0, 0
L_main107:
;MyProject.c,338 :: 		if(humi >= 1000)
	MOVLW       3
	SUBWF       main_Humi_L2+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main169
	MOVLW       232
	SUBWF       main_Humi_L2+0, 0 
L__main169:
	BTFSS       STATUS+0, 0 
	GOTO        L_main108
;MyProject.c,339 :: 		sprinti(humi_a, "1%02u.%01u %%", (humi/10)%100, humi % 10);
	MOVLW       main_humi_a_L2+0
	MOVWF       FARG_sprinti_wh+0 
	MOVLW       hi_addr(main_humi_a_L2+0)
	MOVWF       FARG_sprinti_wh+1 
	MOVLW       ?lstr_31_MyProject+0
	MOVWF       FARG_sprinti_f+0 
	MOVLW       hi_addr(?lstr_31_MyProject+0)
	MOVWF       FARG_sprinti_f+1 
	MOVLW       higher_addr(?lstr_31_MyProject+0)
	MOVWF       FARG_sprinti_f+2 
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        main_Humi_L2+0, 0 
	MOVWF       R0 
	MOVF        main_Humi_L2+1, 0 
	MOVWF       R1 
	CALL        _Div_16X16_U+0, 0
	MOVLW       100
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16X16_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       FARG_sprinti_wh+5 
	MOVF        R1, 0 
	MOVWF       FARG_sprinti_wh+6 
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        main_Humi_L2+0, 0 
	MOVWF       R0 
	MOVF        main_Humi_L2+1, 0 
	MOVWF       R1 
	CALL        _Div_16X16_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       FARG_sprinti_wh+7 
	MOVF        R1, 0 
	MOVWF       FARG_sprinti_wh+8 
	CALL        _sprinti+0, 0
	GOTO        L_main109
L_main108:
;MyProject.c,341 :: 		sprinti(humi_a, " %02u.%01u %%", (humi/10)%100, humi % 10);
	MOVLW       main_humi_a_L2+0
	MOVWF       FARG_sprinti_wh+0 
	MOVLW       hi_addr(main_humi_a_L2+0)
	MOVWF       FARG_sprinti_wh+1 
	MOVLW       ?lstr_32_MyProject+0
	MOVWF       FARG_sprinti_f+0 
	MOVLW       hi_addr(?lstr_32_MyProject+0)
	MOVWF       FARG_sprinti_f+1 
	MOVLW       higher_addr(?lstr_32_MyProject+0)
	MOVWF       FARG_sprinti_f+2 
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        main_Humi_L2+0, 0 
	MOVWF       R0 
	MOVF        main_Humi_L2+1, 0 
	MOVWF       R1 
	CALL        _Div_16X16_U+0, 0
	MOVLW       100
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16X16_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       FARG_sprinti_wh+5 
	MOVF        R1, 0 
	MOVWF       FARG_sprinti_wh+6 
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        main_Humi_L2+0, 0 
	MOVWF       R0 
	MOVF        main_Humi_L2+1, 0 
	MOVWF       R1 
	CALL        _Div_16X16_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       FARG_sprinti_wh+7 
	MOVF        R1, 0 
	MOVWF       FARG_sprinti_wh+8 
	CALL        _sprinti+0, 0
L_main109:
;MyProject.c,343 :: 		}
	GOTO        L_main110
L_main105:
;MyProject.c,346 :: 		read_ok = 0;
	BCF         main_read_ok_L2+0, BitPos(main_read_ok_L2+0) 
;MyProject.c,347 :: 		sprinti(temp_a, "Checksum");
	MOVLW       main_temp_a_L2+0
	MOVWF       FARG_sprinti_wh+0 
	MOVLW       hi_addr(main_temp_a_L2+0)
	MOVWF       FARG_sprinti_wh+1 
	MOVLW       ?lstr_33_MyProject+0
	MOVWF       FARG_sprinti_f+0 
	MOVLW       hi_addr(?lstr_33_MyProject+0)
	MOVWF       FARG_sprinti_f+1 
	MOVLW       higher_addr(?lstr_33_MyProject+0)
	MOVWF       FARG_sprinti_f+2 
	CALL        _sprinti+0, 0
;MyProject.c,348 :: 		sprinti(humi_a, " Error ");
	MOVLW       main_humi_a_L2+0
	MOVWF       FARG_sprinti_wh+0 
	MOVLW       hi_addr(main_humi_a_L2+0)
	MOVWF       FARG_sprinti_wh+1 
	MOVLW       ?lstr_34_MyProject+0
	MOVWF       FARG_sprinti_f+0 
	MOVLW       hi_addr(?lstr_34_MyProject+0)
	MOVWF       FARG_sprinti_f+1 
	MOVLW       higher_addr(?lstr_34_MyProject+0)
	MOVWF       FARG_sprinti_f+2 
	CALL        _sprinti+0, 0
;MyProject.c,349 :: 		}
L_main110:
;MyProject.c,350 :: 		}
	GOTO        L_main111
L_main104:
;MyProject.c,354 :: 		read_ok = 0;
	BCF         main_read_ok_L2+0, BitPos(main_read_ok_L2+0) 
;MyProject.c,355 :: 		sprinti(temp_a, " Sensor ");
	MOVLW       main_temp_a_L2+0
	MOVWF       FARG_sprinti_wh+0 
	MOVLW       hi_addr(main_temp_a_L2+0)
	MOVWF       FARG_sprinti_wh+1 
	MOVLW       ?lstr_35_MyProject+0
	MOVWF       FARG_sprinti_f+0 
	MOVLW       hi_addr(?lstr_35_MyProject+0)
	MOVWF       FARG_sprinti_f+1 
	MOVLW       higher_addr(?lstr_35_MyProject+0)
	MOVWF       FARG_sprinti_f+2 
	CALL        _sprinti+0, 0
;MyProject.c,356 :: 		sprinti(humi_a, " Error ");
	MOVLW       main_humi_a_L2+0
	MOVWF       FARG_sprinti_wh+0 
	MOVLW       hi_addr(main_humi_a_L2+0)
	MOVWF       FARG_sprinti_wh+1 
	MOVLW       ?lstr_36_MyProject+0
	MOVWF       FARG_sprinti_f+0 
	MOVLW       hi_addr(?lstr_36_MyProject+0)
	MOVWF       FARG_sprinti_f+1 
	MOVLW       higher_addr(?lstr_36_MyProject+0)
	MOVWF       FARG_sprinti_f+2 
	CALL        _sprinti+0, 0
;MyProject.c,357 :: 		}
L_main111:
;MyProject.c,359 :: 		TMR0ON_bit = 0;     // Timer0 modülünü devre dýþý býrak
	BCF         TMR0ON_bit+0, BitPos(TMR0ON_bit+0) 
;MyProject.c,361 :: 		LCD_Out(3, 7, temp_a);
	MOVLW       3
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       7
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       main_temp_a_L2+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(main_temp_a_L2+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;MyProject.c,362 :: 		LCD_Out(4, 7, humi_a);
	MOVLW       4
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       7
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       main_humi_a_L2+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(main_humi_a_L2+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;MyProject.c,365 :: 		if(fat_err == 0)
	MOVF        _fat_err+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_main112
;MyProject.c,368 :: 		sprinti(buffer, " %02u-%02u-20%02u | %02u:%02u:%02u |   ", (int)mytime->day, (int)mytime->month, (int)mytime->year,
	MOVLW       main_buffer_L3+0
	MOVWF       FARG_sprinti_wh+0 
	MOVLW       hi_addr(main_buffer_L3+0)
	MOVWF       FARG_sprinti_wh+1 
	MOVLW       ?lstr_37_MyProject+0
	MOVWF       FARG_sprinti_f+0 
	MOVLW       hi_addr(?lstr_37_MyProject+0)
	MOVWF       FARG_sprinti_f+1 
	MOVLW       higher_addr(?lstr_37_MyProject+0)
	MOVWF       FARG_sprinti_f+2 
	MOVLW       4
	ADDWF       _mytime+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       0
	ADDWFC      _mytime+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_sprinti_wh+5 
	MOVLW       0
	MOVWF       FARG_sprinti_wh+6 
	MOVLW       5
	ADDWF       _mytime+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       0
	ADDWFC      _mytime+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_sprinti_wh+7 
	MOVLW       0
	MOVWF       FARG_sprinti_wh+8 
	MOVLW       6
	ADDWF       _mytime+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       0
	ADDWFC      _mytime+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_sprinti_wh+9 
	MOVLW       0
	MOVWF       FARG_sprinti_wh+10 
;MyProject.c,369 :: 		(int)mytime->hours, (int)mytime->minutes, (int)mytime->seconds);
	MOVLW       2
	ADDWF       _mytime+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       0
	ADDWFC      _mytime+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_sprinti_wh+11 
	MOVLW       0
	MOVWF       FARG_sprinti_wh+12 
	MOVLW       1
	ADDWF       _mytime+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       0
	ADDWFC      _mytime+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_sprinti_wh+13 
	MOVLW       0
	MOVWF       FARG_sprinti_wh+14 
	MOVFF       _mytime+0, FSR0L+0
	MOVFF       _mytime+1, FSR0H+0
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       FARG_sprinti_wh+15 
	MOVLW       0
	MOVWF       FARG_sprinti_wh+16 
	CALL        _sprinti+0, 0
;MyProject.c,371 :: 		fileHandle = FAT32_Open("DHT22Log.txt", FILE_APPEND);
	MOVLW       ?lstr38_MyProject+0
	MOVWF       FARG_FAT32_Open_fn+0 
	MOVLW       hi_addr(?lstr38_MyProject+0)
	MOVWF       FARG_FAT32_Open_fn+1 
	MOVLW       4
	MOVWF       FARG_FAT32_Open_mode+0 
	CALL        _FAT32_Open+0, 0
	MOVF        R0, 0 
	MOVWF       _fileHandle+0 
;MyProject.c,372 :: 		if(fileHandle == 0)
	MOVF        R0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_main113
;MyProject.c,374 :: 		FAT32_Write(fileHandle, buffer, 27);
	MOVF        _fileHandle+0, 0 
	MOVWF       FARG_FAT32_Write_fHandle+0 
	MOVLW       main_buffer_L3+0
	MOVWF       FARG_FAT32_Write_wrBuf+0 
	MOVLW       hi_addr(main_buffer_L3+0)
	MOVWF       FARG_FAT32_Write_wrBuf+1 
	MOVLW       27
	MOVWF       FARG_FAT32_Write_len+0 
	MOVLW       0
	MOVWF       FARG_FAT32_Write_len+1 
	CALL        _FAT32_Write+0, 0
;MyProject.c,375 :: 		if(read_ok == 1)      // saðlama toplamý veya sensör hatasý yoksa
	BTFSS       main_read_ok_L2+0, BitPos(main_read_ok_L2+0) 
	GOTO        L_main114
;MyProject.c,376 :: 		temp_a[5] = '°';    // put degree symbol
	MOVLW       176
	MOVWF       main_temp_a_L2+5 
L_main114:
;MyProject.c,377 :: 		FAT32_Write(fileHandle, temp_a, 8);
	MOVF        _fileHandle+0, 0 
	MOVWF       FARG_FAT32_Write_fHandle+0 
	MOVLW       main_temp_a_L2+0
	MOVWF       FARG_FAT32_Write_wrBuf+0 
	MOVLW       hi_addr(main_temp_a_L2+0)
	MOVWF       FARG_FAT32_Write_wrBuf+1 
	MOVLW       8
	MOVWF       FARG_FAT32_Write_len+0 
	MOVLW       0
	MOVWF       FARG_FAT32_Write_len+1 
	CALL        _FAT32_Write+0, 0
;MyProject.c,378 :: 		FAT32_Write(fileHandle, "  | ", 5);
	MOVF        _fileHandle+0, 0 
	MOVWF       FARG_FAT32_Write_fHandle+0 
	MOVLW       ?lstr39_MyProject+0
	MOVWF       FARG_FAT32_Write_wrBuf+0 
	MOVLW       hi_addr(?lstr39_MyProject+0)
	MOVWF       FARG_FAT32_Write_wrBuf+1 
	MOVLW       5
	MOVWF       FARG_FAT32_Write_len+0 
	MOVLW       0
	MOVWF       FARG_FAT32_Write_len+1 
	CALL        _FAT32_Write+0, 0
;MyProject.c,379 :: 		FAT32_Write(fileHandle, humi_a, 7);
	MOVF        _fileHandle+0, 0 
	MOVWF       FARG_FAT32_Write_fHandle+0 
	MOVLW       main_humi_a_L2+0
	MOVWF       FARG_FAT32_Write_wrBuf+0 
	MOVLW       hi_addr(main_humi_a_L2+0)
	MOVWF       FARG_FAT32_Write_wrBuf+1 
	MOVLW       7
	MOVWF       FARG_FAT32_Write_len+0 
	MOVLW       0
	MOVWF       FARG_FAT32_Write_len+1 
	CALL        _FAT32_Write+0, 0
;MyProject.c,380 :: 		FAT32_Write(fileHandle, "\r\n", 2);     // start a new line
	MOVF        _fileHandle+0, 0 
	MOVWF       FARG_FAT32_Write_fHandle+0 
	MOVLW       ?lstr40_MyProject+0
	MOVWF       FARG_FAT32_Write_wrBuf+0 
	MOVLW       hi_addr(?lstr40_MyProject+0)
	MOVWF       FARG_FAT32_Write_wrBuf+1 
	MOVLW       2
	MOVWF       FARG_FAT32_Write_len+0 
	MOVLW       0
	MOVWF       FARG_FAT32_Write_len+1 
	CALL        _FAT32_Write+0, 0
;MyProject.c,382 :: 		FAT32_Close(fileHandle);
	MOVF        _fileHandle+0, 0 
	MOVWF       FARG_FAT32_Close_fHandle+0 
	CALL        _FAT32_Close+0, 0
;MyProject.c,383 :: 		}
L_main113:
;MyProject.c,384 :: 		}
L_main112:
;MyProject.c,386 :: 		}
L_main103:
;MyProject.c,388 :: 		delay_ms(100);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       8
	MOVWF       R12, 0
	MOVLW       119
	MOVWF       R13, 0
L_main115:
	DECFSZ      R13, 1, 1
	BRA         L_main115
	DECFSZ      R12, 1, 1
	BRA         L_main115
	DECFSZ      R11, 1, 1
	BRA         L_main115
;MyProject.c,390 :: 		}
	GOTO        L_main86
;MyProject.c,392 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
