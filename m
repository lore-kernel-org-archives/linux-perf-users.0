From: Andrew Parlane <andrewp@carallon.com>
Subject: Profiling a Qt5 application running on embedded hardware (IMX6)
Date: Wed, 10 Dec 2014 19:04:27 +0000
Message-ID: <5488993B.1020500@carallon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.carallon.com ([95.177.28.122]:58950 "EHLO
	mail.carallon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932501AbaLJTKA (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 10 Dec 2014 14:10:00 -0500
Received: from [x.x.x.x] by mail.carallon.com (Cipher TLSv1:-SHA:128) (MDaemon PRO v14.5.2)
	with ESMTPSA id md50001820037.msg for <linux-perf-users@vger.kernel.org>;
	Wed, 10 Dec 2014 19:04:31 +0000
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hi All,

I've spent the last couple of weeks trying to use perf to profile an 
application. I've not had a huge amount of success. I apologise for the 
long post, I'm hoping to include all the relevant details.

Kernel version 3.10.17 based off Freescale's GIT.
Processor: IMX6Solo
Build system: Buildroot 2014.08
libelf v0.8.12

For now I'm trying to profile a Qt5 example application: 
/usr/lib/qt/examples/widgets/widgets/analogueclock/analogueclock.

I patched QT to build with -g -O2 -fno-omit-frame-pointer. This is for 
the libraries and the application. The CXX_FLAGS in the makefile is set 
to: CXXFLAGS = -pipe -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE 
-D_FILE_OFFSET_BITS=64 -pipe -Os -D_LARGEFILE_SOURCE 
-D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64 -pipe -Os 
-fno-omit-frame-pointer 
--sysroot=~/buildroot-output/host/usr/arm-buildroot-linux-gnueabi/sysroot -O2 
-g -fno-exceptions -Wall -W -D_REENTRANT -fPIE $(DEFINES)

For simplicities sake I copy all the Qt .so files and the application 
from the staging directory onto the target. This way they avoid getting 
stripped of symbols.

Running:
# perf record -o /rw/record.txt -v -g fp -p 250
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.028 MB /rw/record.txt (~1227 samples) ]
failed to write feature 9
failed to write feature 14

Note: I'm using -g fp and not DWARF because of this in tools\perf\Makefile:
# There's only x86 (both 32 and 64) support for CFI unwind so far
ifneq ($(ARCH),x86)
     NO_LIBUNWIND := 1
endif

Then I try and generate a report on the target:
# perf report -v -i /rw/record.txt > /rw/report.txt
build id event received for [kernel.kallsyms]: 
c8961634ed01e5bb5a79e296ba2409017a0f170a
Looking at the vmlinux_path (6 entries long)
symsrc__init: cannot get elf header.
Using /proc/kallsyms for symbols
dso__synthesize_plt_symbols: problems reading /lib/libc-2.18.so PLT info.
dso__synthesize_plt_symbols: problems reading 
/usr/lib/libQt5Core.so.5.3.1 PLT info.
dso__synthesize_plt_symbols: problems reading 
/usr/lib/libQt5Widgets.so.5.3.1 PLT info.
dso__synthesize_plt_symbols: problems reading 
/usr/lib/libQt5Gui.so.5.3.1 PLT info.
dso__synthesize_plt_symbols: problems reading /lib/libgcc_s.so.1 PLT info.
dso__synthesize_plt_symbols: problems reading /lib/libm-2.18.so PLT info.
dso__synthesize_plt_symbols: problems reading /usr/lib/libGAL-fb.so PLT 
info.
dso__synthesize_plt_symbols: problems reading /usr/lib/libGLESv2-fb.so 
PLT info.
Failed to open [vectors], continuing without symbols
dso__synthesize_plt_symbols: problems reading 
/usr/lib/qt/plugins/platforms/libqeglfs.so PLT info.
dso__synthesize_plt_symbols: problems reading 
/usr/lib/libstdc++.so.6.0.18 PLT info.
dso__synthesize_plt_symbols: problems reading /usr/lib/libEGL-fb.so PLT 
info.

There were more errors until I removed the following from 
tools\perf\Makefile
ifeq ($(call try-cc,$(SOURCE_ELF_MMAP),$(FLAGS_LIBELF),-DLIBELF_MMAP),y)
     BASIC_CFLAGS += -DLIBELF_MMAP
endif

I'm using a recent version of libelf (see above).

Without removing the LIBELF_MMAP define, I got an extra 4 or 5 errors 
per line above. With something along the lines of "symsrc__init: cannot 
read /path/here ELF file.".

Now when I look at the output of the report command I see: 
http://slexy.org/view/s20E0vB0nN

So I do have some symbols being read in, but not all. For some like 
/lib/libm-2.18.so this isn't surprising since I haven't copied over a 
non stripped version of the library, nor have I built it with 
-fno-omit-frame-pointer -g. However for others such as 
/usr/lib/libQt5Gui.so.5.3.1 I do have symbols and it was built with with 
the relevant flags.

Next I tried doing the report on the build machine which has all the 
symbols. So I built a copy of perf for the host machine from the same 
linux version. and run:
# ~/buildroot-output/host/bin/perf report -v -k 
~/buildroot-output/build/linux-custom/vmlinux --symfs 
~/buildroot-output/staging -i record.txt > report.txt
build id event received for [kernel.kallsyms]: 
c8961634ed01e5bb5a79e296ba2409017a0f170a
[kernel.kallsyms] with build id c8961634ed01e5bb5a79e296ba2409017a0f170a 
not found, continuing without symbols
Failed to open [vectors], continuing without symbols

Without the -k and the --symfs I get a bunch more errors about missing 
symbols. ~/buildroot-output/staging is a copy of my rootfs that hasn't 
been stripped.

Now my report.txt is: http://slexy.org/view/s21SWFq0MQ

Which as you can see is significantly worse.

So my questions are as follows:

1) Why am I missing everything other than the first entry on the call 
stack when generating the report on the device?
2) Why do I get no symbols at all when generating the report on the 
build machine?
3) Would you expect perf to work with LIBELF_MMAP defined?
4) Not on this application, but on the actual one I want to profile I 
spend a lot of time in [vectors]. Can you clarify what this entry is? 
I've read it's the exception vectors table. Is it limited to exceptions 
from this application? Is there anyway to get symbols out of it.

Thanks for any help.

Andrew Parlane
Carallon LTD.
