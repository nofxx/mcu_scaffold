# AVR SCAFFOLD

Collection of Rakefiles to start of and avoid the Arduino IDE.

Here you'll find a pure C, C++ and Arduino C++ scaffolds with optional libraries support.

Just clone:

    git clone git://github.com/nofxx/avr_scaffold.git

or download:

    https://github.com/nofxx/avr_scaffold/zipball/master    # .zip

    https://github.com/nofxx/avr_scaffold/tarball/master    # .tar.gz

And choose a scaffold, <LANG> options: c, cpp, asm or arduino:
    
    cp -r avr_scaffold/<LANG> ~/newproject
    

## Common Usage

```bash
$ rake -T # see all tasks
$ rake # build the project, flash to the arduino
$ rake clobber # clean the project
```


## Board Resources

* ATMega328P datasheet - http://www.atmel.com/dyn/resources/prod_documents/doc8161.pdf
* Arduino UNO Schematic - http://arduino.cc/en/uploads/Main/arduino-uno-schematic.pdf

## Getting Started

The following are instructions for getting up and running under different
operating systems. This will take you through installing avr-gcc, avr-libc,
avrdude, and the AVR GNU Binutils.

### Windows

First, install a recent version of Ruby. You can grab a Windows installer for
Ruby from the [RubyInstaller for Windows][rifw] page. After installing Ruby,
you'll need to open a console and use the ```gem``` command to install the
Cucumber and

Second, you'll need a copy of [WinAVR][WinAVR_DL]. Download the latest version
and install it. You will want to make sure the option to 'Add directories to
PATH' is checked.

WinAVR contains all the tools you need to use this scaffolding including (but
not limited to):

* AVR GNU Binutils
* AVR GNU Compiler Collection (GCC)
* AVRDUDE
* avr-libc

In order to complete the next step, you'll need to download the Arduino
software package this can be found on the [Arduino download page][adp].

After you've installed Ruby and WinAVR, connect the Arduino UNO to your Windows
computer via the USB cable. It will attempt to install a driver, but will
fail. Follow the instructions on [arduino.cc][acc] to complete the
installation of the drivers.

### OSX

I recommend installing the needed AVR tools by means of [Homebrew][hb]. If
you're already setup with homebrew, then you should just have to execute the
following commands. If not, take a moment to read a bit about Homebrew and get
it setup on your Mac.

Once you're ready, here are the commands to install the needed tools:

```bash
$ brew install avrdude
$ brew install https://raw.github.com/larsimmisch/homebrew-alt/3a4f8ce4bcda88c25f4fa4ea3f42688a2ed03d12/avr/avr-binutils.rb
$ brew install https://raw.github.com/larsimmisch/homebrew-alt/124853640317af04e11269c517d449dbd202773d/avr/avr-gcc.rb
$ brew install https://raw.github.com/larsimmisch/homebrew-alt/7d774c6b15dafdee6ca518aff5e8368528d69ae0/avr/avr-libc.rb
```

**These are built from source and will take a while to complete.**

### Linux

Getting the environment up and running on Linux is quite simple. One
need only install some packages. These are all supported in the package
manager. Open a terminal and run the following command:

Debian/Ubuntu

```bash
$ sudo apt-get install binutils-avr avr-libc avrdude gcc-avr
```

Archlinux

```bash
$ sudo pacman -S avrdude gcc-avr
```

## Building and Running the Sample Project

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

hterm - Linux/Windows
http://www.der-hammer.info/terminal

gtkterm - Linux/Mac
https://fedorahosted.org/gtkterm

realterm - Windows
http://realterm.sourceforge.net


## ASSEMBLY

There's .inc files included in asm/incs.
After trying for full day to download from:
http://www.attiny.com/definitions.htm
Server was off.


## Exploring the Source Code

TBD


## AVR Scaffold

This works with others arduinos and barebones AVRs too.
Tested on Duemilanove and the Blackwidow.

Chips ATMEGA328p, ATMEGA32, ATMEGA64 and ATTiny85.
Programmer USBASP.



[WinAVR_DL]: http://sourceforge.net/projects/winavr/files/ "WinAVR Download"
[rifw]: http://rubyinstaller.org/
[acc]: http://arduino.cc/en/Guide/Windows#toc4
[adp]: http://arduino.cc/en/Main/Software
[rake]: http://en.wikipedia.org/wiki/Rake_(software)
[hb]: http://mxcl.github.com/homebrew/


[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/nofxx/avr_scaffold/trend.png)](https://bitdeli.com/free "Bitdeli Badge")

