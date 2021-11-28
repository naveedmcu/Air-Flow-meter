unsigned short read_ds1307(unsigned short address)
{
  char dataa;
  I2C1_Start();
  I2C1_Wr(0xd0); //address 0x68 followed by direction bit (0 for write, 1 for read) 0x68 followed by 0 --> 0xD0
  I2C1_Wr(address);
  I2C1_Repeated_Start();
  I2C1_Wr(0xd1); //0x68 followed by 1 --> 0xD1
  dataa=I2C1_Rd(0);
  I2C1_Stop();
  return(dataa);
}

void write_ds1307(unsigned short address,unsigned short w_data)
{
I2C1_Start(); // issue I2C start signal
//address 0x68 followed by direction bit (0 for write, 1 for read) 0x68 followed by 0 --> 0xD0
I2C1_Wr(0xD0); // send byte via I2C (device address + W)
I2C1_Wr(address); // send byte (address of DS1307 location)
I2C1_Wr(w_data); // send data (data to be written)
I2C1_Stop(); // issue I2C stop signal
}


void dafualt_timer()
{
// cls();
 Glcd_write_text("Dafult time",28,6,xColorSet);  // Write counter value
 write_ds1307(0,0x80); //Reset second to 0 sec. and stop Oscillator
 write_ds1307(1,0x25); //write min 25
 write_ds1307(2,0x69); //write hour 8 PM
 write_ds1307(3,0x07); //write day of week 2:Saturday
 write_ds1307(4,0x22); // write date 22
 write_ds1307(5,0x05); // write month May
 write_ds1307(6,0x10); // write year 10 --> 2010
 write_ds1307(7,0x10); //SQWE output at 1 Hz
 write_ds1307(0,0x00); //Reset second to 0 sec. and start Oscillator
 write_ds1307(0x2F,0xAA);
 delay_ms(500);
 Glcd_write_text("Dafult time set",0,0,xColorSet);  // Write counter value
// cls();
}
