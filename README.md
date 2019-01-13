# Duckberry Pi Zero // USB Rubber Ducky on the Raspberry Pi Zero (not Zero W), dubbed by myself the Raspberry Pi Zero nW (non-wireless)

Version 1.0

Project to set up Duckberry Pi on a Raspberry Pi Zero, without the Zero itself having an internet connection.

## Introduction (copied from [Ossiozac](https://github.com/ossiozac/Raspberry-Pi-Zero-Rubber-Ducky-Duckberry-Pi))

The USB Rubber Ducky is a Human Interface Device programmable with a simple scripting language allowing penetration testers to quickly and easily craft and deploy security auditing payloads that mimic human keyboard input. Tools and payloads can be found at usbrubberducky.com. Quack!

DuckBerry Pi is a Raspberry Pi distro. based on Minibian which allows the Raspberry Pi Zero to behave similar to a USB Rubber Ducky: a small device USB device which emulates a keyboard and automates key entry. Ducky scripts (uncompiled) which are made for the USB Rubber Ducky can be used with the Duckyberry Pi without modification. This can be useful for automating computer tasks, penetration testing machines, playing pranks, or just fun (by default plugging in an untouched Duckberry Pi image will open a Youtube video). Since it is recognised as a standard keyboard, this tool is compatible with Windows, Mac OS, Linux, Android, PlayStation 4, and anything that supports a USB keyboard.

## Instructions

### In Windows

1) Create a live USB of Lubuntu with this [Lubuntu 18.10 ISO](http://cdimage.ubuntu.com/lubuntu/releases/18.10/release/lubuntu-18.10-desktop-amd64.iso), or at least that's the ISO I used. (I'm not exactly sure if this exact script would work on other distros but you can try it if you want). I recommend using [Rufus](https://rufus.ie/) to create the USB.

2) Plug in an SD card (class 6 at least) and flash this version of [Raspbian Jessie Lite](https://drive.google.com/open?id=1tE34LrUqLyBvPyC0WjkjZBqjCfA81RSi). Use this version! (once again I recommend doing this with Rufus.)

3) Make sure to have fixup.sh downloaded on your computer.

### Lubuntu

4) Boot your computer to the Lubuntu USB.

5) Plug in your Raspbian SD.

6) When it is plugged in, navigate to the KDE Partition Manager. After this, select the root partition of your sd card and grow it to at least 2GiB.

7) Copy fixup.sh from your computer to the home folder of Lubuntu.

8) At the home folder, bring up the terminal (Tools > Open Terminal). Give executeable permissions to fixup.sh
	``` bash
		sudo chmod 755 fixup.sh
	```
	
9) Still in the terminal, run it.
	``` bash
		sudo ./fixup.sh
	```
	
10) When prompted, provide the root path and the boot path of the sd card. This is VERY important. Note: at this point you will need an internet connection to Lubuntu. If you don't have one, get one.

11) Let the script run. It won't take too long but it will take a little while, so go watch YouTube or start working on your first payload.

12) You're done! Plug the SD into your Zero, and plug your Zero into a computer to execute your first payload. Note: The first payload is designed for a Windows computer. Also, make sure you plugged your USB cable to your port on the Zero labeled "USB" and not "PWR". Finally, make sure you are using a USB data cable, and not only a power cable.

13) Optional step: If when you plug your sd into a Windows computer you can't find the boot drive in file explorer try the following:
Open disk manager, find the boot partition and try mounting it to a drive letter. If this doesnt work:
Go back into Lubuntu, copy everything in the boot folder to a temporary folder, go into KDE and format the boot partition to fat32. Paste everything from the temporary folder back into the boot partition and then plug your SD to windows. If you still can't see it, try mounting it as described in the previous step.

## Conclusion

Edit payload.dd (located in your Raspbian boot folder) with any rubber ducky script! You're done. If you have any issues don't hesitate to contact me at [s7agvgus@gmail.com](mailto:s7agvgus@gmail) at any time. I will reply to you as soon as I can.

### Credits

Authors:
[rspiducky by Jeff L. and/aka theresalu](https://github.com/theresalu/rspiducky)
Dee-oh-double-gee
[Version 1.1 by Ossiozac](https://github.com/ossiozac/Raspberry-Pi-Zero-Rubber-Ducky-Duckberry-Pi)
S7AGV

And original authors:
[DroidDucky by Andrej Budincevic](https://github.com/anbud/DroidDucky)
[hardpass by girst](https://github.com/girst/hardpass)
