# MCUs SCAFFOLDs

Collection of Rakefiles to start of and avoid IDEs.

Or graphically:

AVR + ~~IDE~~ Ruby = FUN
ESP + ~~IDE~~ Ruby = FUN
ARM + ~~IDE~~ Ruby = FUN


Just clone:

    git clone git://github.com/nofxx/mcu_scaffold.git

or download:

    https://github.com/nofxx/mcu_scaffold/zipball/master    # .zip

    https://github.com/nofxx/mcu_scaffold/tarball/master    # .tar.gz


## And choose a MCU:


## AVR

ATmega Family.
The 8bit father of all. From ATMEL, you know it from Arduino.
The CPU, the famous ATmega328.

## ARM

Linux Boards -> Rpi/BBB
Cortex M? STM32...
Up to 64 bits of linux fun. 
Lots of CPUs here, and nevermind if you have a kernel to worry about that.

## ESP

ESP32/ESP8266/NodeMCU/WeMos
Xtensa CPU. The cheap answer to ARM's 32bits reign.
With wifi!


## Getting Started

The following are instructions for getting up and running under different
operating systems. This will take you through installing mcu-gcc, mcu-libc,
mcudude, and the MCU GNU Binutils.


### Building and Running the Sample Project

Each scaffold is driven by a Rakefile. If you're not familiar with
[Rake][rake], you'll want to take some time to familiarize yourself with it.
It's integral to the operation of this scaffolding.

The different stages of the build process are broken down into different rake
tasks. These can be viewed by running the command ```rake -T``` in the
scaffold directory. You'll see something like this:

    $ rake -T
    rake clean                       # Remove any temporary products.
    rake clobber                     # Remove any generated file.
    ...

The name of the serial port used by the programmer may be passed as an
environment variable to the rake. If you do not know how to identify
the name of the serial port used by the programmer, consult with the section
corresponding with your operating system under the 'Identifying the Name of
the Programmer Serial Port' later in this document.

    rake SERIAL_PORT=[serial port name]


### Linux

Just check each chip folder for it's own README.md.
Most package names are from archlinux.

### OSX

I recommend installing the needed MCU tools by means of [Homebrew][hb]. 


## Serial Monitor

Collection of software that can be used to replace the IDE's one:


### Terminal

GNU screen - Linux/OSX
http://www.gnu.org/software/screen/

Example 19200 bps, 8-N-1 parity:

    screen /dev/ttyUSB0 19200,cs8


minicom - Linux/OSX
http://alioth.debian.org/projects/minicom

Example 19200 bps, 8-N-1 parity:

    minicom -b 19200 -8 -D /dev/ttyUSB0


picocom - Linux/OSX


### Scripting

Subduino - Ruby
http://github.com/nofxx/subduino

serialport - Ruby
https://github.com/hparra/ruby-serialport

pySerial - Python
http://pyserial.sourceforge.net

node-serialport - JS
https://github.com/voodootikigod/node-serialport



### Graphical

hterm - Linux
http://www.der-hammer.info/terminal

gtkterm - Linux/Mac
https://fedorahosted.org/gtkterm



[adp]: http://arduino.cc/en/Main/Software
[rake]: http://en.wikipedia.org/wiki/Rake_(software)
[hb]: http://mxcl.github.com/homebrew/
