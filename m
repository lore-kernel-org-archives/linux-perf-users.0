From: Suresh Nagarajan <Sureshnagaraja@gmail.com>
Subject: cross compiling perf tool on ARM fails in yocto-linux environment
Date: Tue, 12 Aug 2014 18:04:10 +0000 (UTC)
Message-ID: <loom.20140812T195504-52@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:43455 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752765AbaHLSKG (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 12 Aug 2014 14:10:06 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glkpu-linux-perf-users@m.gmane.org>)
	id 1XHGWK-0000ru-9i
	for linux-perf-users@vger.kernel.org; Tue, 12 Aug 2014 20:10:04 +0200
Received: from ip67-88-244-162.z244-88-67.customer.algx.net ([67.88.244.162])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Tue, 12 Aug 2014 20:10:04 +0200
Received: from Sureshnagaraja by ip67-88-244-162.z244-88-67.customer.algx.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Tue, 12 Aug 2014 20:10:04 +0200
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

I am trying to cross-compile perf tool for ARM on x86 machine. 


====================================================

[snagarajan@moltar-76 perf]$ alias armmake='make CROSS_COMPILE=arm-linux-
gnueabihf- ARCH=arm'
[snagarajan@moltar-76 perf]$ PATH=~/gcc-linaro-arm-linux-gnueabihf-4.9-
2014.07_linux/bin:$PATH
[snagarajan@moltar-76 perf]$ armmake install
  BUILD:   Doing 'make -j4' parallel build

Auto-detecting system features:
...                     backtrace: [ on  ]
...                         dwarf: [ on  ]
...                fortify-source: [ on  ]
...                         glibc: [ on  ]
...                          gtk2: [ OFF ]
...                  gtk2-infobar: [ OFF ]
...                      libaudit: [ on  ]
...                        libbfd: [ on  ]
...                        libelf: [ on  ]
...             libelf-getphdrnum: [ on  ]
...                   libelf-mmap: [ on  ]
...                       libnuma: [ OFF ]
...                       libperl: [ on  ]
...                     libpython: [ on  ]
...             libpython-version: [ on  ]
...                      libslang: [ OFF ]
...                     libunwind: [ OFF ]
...                       on-exit: [ on  ]
...                stackprotector: [ on  ]
...            stackprotector-all: [ on  ]
...                       timerfd: [ on  ]

config/Makefile:329: No libunwind found, disabling post unwind support. 
Please install libunwind-dev[el] >= 1.1
config/Makefile:368: slang not found, disables TUI support. Please install 
slang-devel or libslang-dev
config/Makefile:381: GTK2 not found, disables GTK2 support. Please install 
gtk2-devel or libgtk2.0-dev
config/Makefile:536: No numa.h found, disables 'perf bench numa mem' 
benchmark, please install numa-libs-devel or libnuma-dev
  FLEX     util/pmu-flex.c
  CC       util/environment.o
  CC       util/event.o
  CC       util/evlist.o
In file included from util/callchain.h:8:0,
                 from util/hist.h:6,
                 from util/evsel.h:11,
                 from util/evlist.h:8,
                 from util/evlist.c:15:
util/symbol.h:17:20: fatal error: libelf.h: No such file or directory
 #include <libelf.h>
                    ^
compilation terminated.
make[1]: *** [util/evlist.o] Error 1
make[1]: *** Waiting for unfinished jobs....
In file included from util/sort.h:11:0,
                 from util/event.c:5:
util/symbol.h:17:20: fatal error: libelf.h: No such file or directory
 #include <libelf.h>
                    ^
compilation terminated.
make[1]: *** [util/event.o] Error 1
make: *** [install] Error 2


====================================================================

I have libelf.h file compiled for ARM, I tried replacing it in
/usr/include and also in ../arm-none-linux-gnueabi/libc/usr/include.
However, I face the same error. (I am not exactly sure about where the
compiler is looking for libelf.h)

I noticed that this issue existed from 2012... Is this not fixed?
