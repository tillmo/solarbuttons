#!/usr/bin/ruby
# Demonstration for RaspiLCD ruby bindings
# based on C demo by Martin Steppuhn
# note: if this script does not work, try to run it as root

require "raspi_lcd"
include RaspiLCD

BMP_RASPI = "#{57.chr}#{64.chr}\x00\x00\x60\xFC\xFC\xAC\x0E\x0E\x06\x06\x07\x07\x07\x87\x87\x87\x03\x07\x07\x07\x0E\x06\x0E\x0C\x1C\x38\xF0\xE0\x80\xC0\xF0\x78\x1C\x0C\x0C\x0E\x06\x06\x07\x07\x07\x07\x87\x83\x07\x07\x07\x07\x06\x06\x0E\x8C\xFC\xFC\xF8\x00\x00\x00\x00\x00\x03\x0F\x3F\x7C\xF0\xE0\xC0\x80\x00\x00\x00\x00\x01\x01\x03\x06\x06\x0C\x1C\x98\xF0\xF0\xF0\xF8\xFF\xFF\xFF\xFF\xF0\xF0\xF0\xB8\x18\x0C\x04\x06\x02\x03\x01\x01\x00\x00\x00\x80\xC0\xC0\xF0\x78\x3E\x1F\x0F\x01\x00\x00\x00\x00\x00\x00\x00\x00\x80\xE0\xF1\x71\x3B\x1F\x1F\x0E\x0E\x0C\x8C\xCE\xEE\xFE\xFE\x9F\x0F\x0F\x07\x07\x07\x07\x07\x07\x07\x07\x07\x0F\x0F\x9F\xFF\xFE\xCE\x8E\x8C\x0C\x0E\x1E\x1E\x3F\x7B\xF3\xE1\xC0\x00\x00\x00\x00\x00\x00\x00\x00\x00\x80\xC0\xE0\xFE\x7F\x7F\xF1\xF0\xF8\xF8\x7C\x3E\x1F\x0F\x0F\x07\x07\x07\x07\x07\x07\x07\x0E\x1E\x7E\xFE\xFE\xFE\xFE\x1E\x0E\x06\x07\x07\x03\x03\x07\x07\x07\x0F\x1E\x3C\x7C\xF8\xF0\xF0\xFF\x7F\x7F\xF0\xE0\xC0\x80\x00\x00\xFC\xFF\xFF\x03\x01\x00\x00\x80\xFF\xFF\xFF\xFB\xC0\x80\x00\x00\x00\x00\x00\x00\x00\x00\x00\x80\xC0\xE0\xFC\xFF\xFF\xFF\xFF\xF0\xE0\xC0\x80\x00\x00\x00\x00\x00\x00\x00\x00\x80\xC0\xFB\xFF\xFF\xFF\x00\x00\x00\x01\x03\xFF\xFF\xFC\x01\x07\x0F\x7E\xFC\xF8\xFE\x1F\x0F\x0F\x0F\x0F\x0F\x1F\x3F\x7F\xFE\xFE\xFE\xFE\xFF\x0F\x07\x03\x01\x01\x01\x00\x00\x00\x00\x01\x01\x01\x03\x07\x1F\xFF\xFF\xFE\x7E\x3F\x1F\x0F\x0F\x07\x07\x07\x07\x0F\xFC\xFC\xFE\x3F\x07\x03\x00\x00\x00\x00\x00\x03\x0F\x3F\x7C\x70\xE0\xC0\xC0\x80\x80\x80\x00\x00\x81\xCF\xFF\xFF\xFE\xF8\xF8\xF0\xF0\xE0\xE0\xE0\xE0\xE0\xE0\xF0\xF0\xF8\xFC\xFF\xFF\xC7\x81\x80\x80\x80\x80\x80\xC0\xC0\xE0\xF0\x7C\x3F\x1F\x07\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x01\x01\x03\x03\x07\x07\x0F\x0F\x1F\x1F\x3F\x7B\x71\xE1\xE0\xC0\xC0\xC0\xC0\xC0\xC0\xC0\xE0\xE0\x71\x79\x3F\x1F\x0F\x0F\x0F\x07\x07\x03\x03\x01\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
BMP_MEN = "#{128.chr}#{64.chr}\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xC0\xE0\x70\x38\x0F\x07\x03\x19\x08\x0C\x04\x04\x00\x00\x00\x00\x0C\x0C\x1C\x19\x01\x01\x03\x03\x03\x07\x07\x0F\x9F\xFF\xFF\xFE\xFC\xF0\xC0\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xF0\xFC\x0E\x06\x06\x06\x86\x06\x06\x06\x0E\x1C\x9C\xF8\xF0\x70\x30\x30\x30\x30\x30\x70\x60\xE0\xC0\xC0\x00\x00\x00\x00\x00\x0F\xBF\xFF\xFF\xFF\xFF\xFF\xFF\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x80\x80\xC0\xC0\xC0\x80\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xFE\x5F\xC7\x9F\xB8\xE0\xE0\xC7\xDF\xD0\x98\xC0\xC0\xFE\xFF\x03\x3C\x7C\xC0\xC0\xC0\x40\x00\x00\x00\x00\xC1\x7F\x1F\x0C\x0C\x1C\x18\xF8\xFF\x7F\x7F\x7F\x7F\xE7\xC0\x80\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xE0\xFC\x3F\x0F\x03\x01\x00\xE0\xFF\x3F\x0F\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x01\xEF\xFF\xFF\xC7\x03\x01\x01\x01\x01\x01\x01\x01\x00\x00\x01\x03\x07\x06\x0C\x0C\x0C\x0C\x0C\x0C\x06\x07\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xC0\xE0\xF8\x3F\x1F\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x80\xC0\xE0\xF0\x60\xE0\xF8\x78\x38\x1C\x18\x18\x7F\x7F\x07\x00\x00\x00\xF8\xFF\x0F\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x7F\xFF\xE5\x01\x43\xC7\x8E\x8E\x8C\x1C\x1C\x1C\x1C\x0C\x0E\x0E\x07\x00\x00\x00\x00\x00\x00\x00\x00\x00\x80\xE0\xF8\x3C\x1E\x0C\x0C\x0C\x0C\x0E\x07\x03\x03\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x7F\xFF\x83\x00\x00\x1F\x7F\x78\xE0\xF8\xFC\xFF\x1E\x0E\x06\x07\x07\x07\x07\x0F\x1E\x7C\xF0\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x07\x1F\x3C\xF0\xE0\xC1\x03\x07\x0F\x1F\x1F\x1B\x1F\x0F\x0F\x87\x80\xC0\x70\x7C\x1C\x10\x80\xF0\xFC\x1F\x03\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x07\x1F\x3F\x7E\xE6\xC6\xC2\xC3\x81\x01\x03\x07\x06\x06\x06\x86\xC0\xC0\xF0\x78\x3C\x1F\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x80\xE0\xF0\xF8\xF8\x78\xF8\xF0\xF0\xE0\xE0\xF0\xFC\xFC\xFC\x3C\x38\xF8\xF0\xF0\xF8\xFC\xF8\xFC\x1F\xE3\xF3\xF7\xE7\x07\xC6\xE6\xE3\xC3\x63\x61\x31\x30\x18\x18\x0C\x1C\x1F\xFF\xFF\xC7\x80\x80\x80\x80\xC0\x80\x80\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x01\x01\x0F\xFF\xF8\x00\x00\x00\xFE\xFF\x03\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x80\xC0\xC0\xE0\xF0\xF8\xFC\xFE\xFF\xDF\xBF\xEF\x7C\x3E\x0F\x07\x01\x00\xC1\x61\x9B\xE7\x33\x0C\x03\x01\x00\x80\x70\xFC\x3F\x1F\x07\x01\x80\xFC\xFF\x1F\xCF\x21\x07\x3F\x78\x70\x70\x18\x1C\x0C\x86\x7E\xEF\x39\x0D\x03\x01\x01\x01\x0D\x3F\xFF\x7F\xF8\x78\x38\x38\x38\x38\x38\x70\xF0\xC0\x80\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"


def demo_logo
	clear_screen
	draw_bitmap(0,0,BMP_RASPI)		
	set_font(0)	
	print_xy(70,4 ,"Raspi-LCD")		
	print_xy(75,14,"Project")
	print_xy(68,32,"powered by")
	print_xy(70,42,"Emsystech")
	print_xy(62,52,"Engineering")
end

def demo_text
	clear_screen
	set_font(1)	
	print_xy(30,0,"Raspi-LCD")
	print_xy(0,12,"www.emsystech.de")
	set_font(0)	
	print_xy(8,29,"128 x 64 Pixel (BW)")
	print_xy(6,38,"White LED Backlight")
	print_xy(4,47,"8 Lines with 21 Char ")
	print_xy(4,56,"in the smallest Font ")
end

def demo_vector
	clear_screen
	set_fill_color(1)	
	draw_rect(110,20,120,60,1)
	draw_line(0,0,127,0)
	draw_line(0,0,127,16)
	draw_line(0,0,127,32)
	draw_line(0,0,127,48)
	draw_line(0,0,127,63)
	set_pen_color(1)
	draw_circle(63,31,31)
	draw_circle(8,50,5)
	draw_ellipse(80,40, 30,10)
	set_fill_color(0)	
	draw_rect(12,20,40,40,3)
	set_fill_color(-1)	
	draw_rect(30,50,60,60,1)
end


def demo_bubbles(demo_mem)
	clear_screen
	set_pen_color(1)
	
	if(demo_mem[200]!=0)	then if(demo_mem[201] > 16)	then demo_mem[201]-=1 else	demo_mem[200] = 0 end
		else		     if(demo_mem[201] <48)	then demo_mem[201]+=1 else	demo_mem[200] = 1 end
        end
	demo_mem[202] = ( ((63 - demo_mem[201]) < demo_mem[201]) ? (63 - demo_mem[201]) : demo_mem[201] )
	demo_mem[202] = ( (demo_mem[202] > 20) ? 20 : demo_mem[202] )
	draw_ellipse(28,demo_mem[201],20+20-demo_mem[202],demo_mem[202])	

	if(demo_mem[203]!=0)	then if(demo_mem[204] > 14)	then demo_mem[204]-=1 else	demo_mem[203] = 0 end
		else		     if(demo_mem[204] <50)	then demo_mem[204]+=1 else	demo_mem[203] = 1 end
        end
	demo_mem[205] = ( ((63 - demo_mem[204]) < demo_mem[204]) ? (63 - demo_mem[204]) : demo_mem[204] )
	demo_mem[205] = ( (demo_mem[205] > 20) ? 20 : demo_mem[205] )
	draw_ellipse(65,demo_mem[204],22+10-demo_mem[205],demo_mem[205])	

	if(demo_mem[206]!=0)	then if(demo_mem[207] > 10)	then demo_mem[207]-=1 else	demo_mem[206] = 0 end
		else		     if(demo_mem[207] <54)	then demo_mem[207]+=1 else	demo_mem[206] = 1 end
        end
	demo_mem[208] = ( ((63 - demo_mem[207]) < demo_mem[207]) ? (63 - demo_mem[207]) : demo_mem[207] )
	demo_mem[208] = ( (demo_mem[208] > 15) ? 15 : demo_mem[208] )
	draw_ellipse(102,demo_mem[207],15+20-demo_mem[208],demo_mem[208])	
end

def demo_bubbles_init(demo_mem)
	demo_mem[200] = 1
	demo_mem[201] = 10
	demo_mem[203] = 0
	demo_mem[204] = 40
	demo_mem[206] = 1
	demo_mem[207] = 40
end

def demo_font
	clear_screen
	set_font(0)
        print_xy(0,0, "Font 0")
	set_font(1)		
        print_xy(0,8, "Font 1")
	set_font(2)		
        print_xy(0,23,"Font 2")
	set_font(3)		
        print_xy(0,39,"Font 3")
end

def demo_bitmap
	draw_bitmap(0,0,BMP_MEN)	
	set_font(1)
	print_xy(6,0, "Bitmap")
end

# main program
contrast = 9;
backlight = 1;
		
puts("RaspiLCD Demo V0.9 by Martin Steppuhn, adapted to Ruby")
printf("RaspberryHwRevision=%i\r\n",get_raspberry_hw_revision)
	
if !raspi_lcd_hw_init 
     puts("raspi_lcd_hw_init failed!") 
     exit 1
end
init			# Init Display
set_backlight(1)	# Turn backlight on

demo_view = 0
# DemoCpuTemperatureInit()
demo_mem = [0]*256
demo_bubbles_init(demo_mem)
	
demo_count = 0
clear_screen

while true do
	demo_count+=1
	sleep_ms(100)
	update_buttons
        bp = buttons_pressed
        b = buttons
		printf("Buttons: %s (pressed: %s) contrast=%i backlight=%u demo_view=%i\r\n",b,bp,contrast,backlight,demo_view)

	# if (demo_count & 3) == 0) then LogCpuTemperature end
	if bp.member?(:up) or bp.member?(:down)
		if bp.member?(:up) and (contrast < 20) then contrast+=1 end
		if bp.member?(:down) and (contrast > 0) then  contrast-=1 end 
		set_contrast(contrast) 
	end
	if bp.member?(:center)
		backlight = backlight==1 ? 0 : 1   # Toggle backlight
	        set_backlight(backlight)	# Write to Hardware
	end		
	if bp.member?(:left) and demo_view>0 then demo_view-=1 end
	if bp.member?(:right) and (demo_view < 6) then demo_view+=1 end		

	if    demo_view == 0 then demo_logo
	# elsif demo_view == 1 then if (demo_count & 3) == 0 then demo_CpuTemperature end
	elsif demo_view == 2 then demo_bitmap
	elsif demo_view == 3 then demo_font
	elsif demo_view == 4 then demo_vector
	elsif demo_view == 5 then demo_bubbles(demo_mem)
	elsif demo_view == 6 then demo_text
	end			
	write_framebuffer
end
exit 0
