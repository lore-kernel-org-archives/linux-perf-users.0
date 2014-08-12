From: Suresh Nagarajan <Sureshnagaraja@gmail.com>
Subject: perf cross compilation on yocto-linux for ARM fails
Date: Tue, 12 Aug 2014 21:49:47 +0000 (UTC)
Message-ID: <loom.20140812T234636-955@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:58816 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752787AbaHLVuC (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 12 Aug 2014 17:50:02 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glkpu-linux-perf-users@m.gmane.org>)
	id 1XHJxA-00082m-2Q
	for linux-perf-users@vger.kernel.org; Tue, 12 Aug 2014 23:50:00 +0200
Received: from ip67-88-244-162.z244-88-67.customer.algx.net ([67.88.244.162])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Tue, 12 Aug 2014 23:50:00 +0200
Received: from Sureshnagaraja by ip67-88-244-162.z244-88-67.customer.algx.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Tue, 12 Aug 2014 23:50:00 +0200
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org


perf cross compilation on yocto-linux for ARM fails.  I've seen posts on 
this failure on internet but no where a detailed info is given on what was 
the fix (or if there is a fix yet)

using yocto package, I have run into issues.. 

Here are the steps to run into the issue
$ cd ~
$ git clone http://git.rocketboards.org/poky-socfpga.git  
$ cd  poky-socfpga/
$ git checkout -b <test_branch> ACDS14.0_REL_GSRD_PR
$ source ./altera-init build
$ bitbake perf 

Note: replace <test_branch> with the name of the branch you want to use 
locally.


This fails with 

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
