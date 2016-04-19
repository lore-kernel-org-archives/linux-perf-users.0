From: Mark Davis <markdavisinboston@gmail.com>
Subject: Missing stack symbols with =?utf-8?b?cGVyZl9ldmVudCdz?= perf report, despite -fno-omit-frame-pointer compilation
Date: Tue, 19 Apr 2016 00:07:33 +0000 (UTC)
Message-ID: <loom.20160419T015612-712@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:45485 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751363AbcDSAKJ (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 18 Apr 2016 20:10:09 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glkpu-linux-perf-users@m.gmane.org>)
	id 1asJEz-0005NF-E9
	for linux-perf-users@vger.kernel.org; Tue, 19 Apr 2016 02:10:05 +0200
Received: from 75-150-115-86-NewEngland.hfc.comcastbusiness.net ([75.150.115.86])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Tue, 19 Apr 2016 02:10:05 +0200
Received: from markdavisinboston by 75-150-115-86-NewEngland.hfc.comcastbusiness.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Tue, 19 Apr 2016 02:10:05 +0200
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

I'm struggling getting perf_events to give me stack traces with symbols, 
despite reading many tutorials on the subject and doing (I think) all the 
necessary things. It's possible that my local install of perf (details on that 
below) is somehow botched? Anyway, here's what I did:

main.cpp is a simple C++ program that calls a few functions defined in the same 
file, allocates some memory and frees it, and prints a few things out.

compilation command:
    
    gcc -std=c++11 -lstdc++ main.cpp -Og -fno-omit-frame-pointer -fno-inline -o 
arr_test

profile command:

    perf record -a -g -- ./arr_test && perf report --stdio


I do get the following warnings about kernel symbols, but I don't think this 
should matter given that I only care about symbols in my application for now:

    [ perf record: Woken up 1 times to write data ]
    [ perf record: Captured and wrote 0.052 MB perf.data (~2285 samples) ]
    [kernel.kallsyms] with build id e22966849c48748782a1be4fe0ce94db6838b806 
not found, continuing without symbols
    [kernel.kallsyms] with build id e22966849c48748782a1be4fe0ce94db6838b806 
not found, continuing without symbols
    Warning:
    Kernel address maps (/proc/{kallsyms,modules}) were restricted.
    
    Check /proc/sys/kernel/kptr_restrict before running 'perf record'.
    
    As no suitable kallsyms nor vmlinux was found, kernel samples
    can't be resolved.
    
    Samples in kernel modules can't be resolved as well.

Here's a snippet of the output:

    # Overhead   Command      Shared Object
    # ........  ........  .................
    #
        83.27%  arr_test  arr_test         
                |          
                |--34.12%-- 0x400908
                |          0x7fe72b381ec5
                |          
                |--10.48%-- 0x400903
                |          0x7fe72b381ec5
                |          
                |--10.08%-- 0x4008b8
                |          0x7fe72b381ec5
                |          
                |--9.22%-- 0x4008e5
                |          0x7fe72b381ec5
                |          
                |--9.05%-- 0x4008da
                |          0x7fe72b381ec5
                |          
                |--8.49%-- 0x4008f0
                |          0x7fe72b381ec5
                |          
                |--6.87%-- 0x4008d5
                |          0x7fe72b381ec5
                |          
                |--6.23%-- 0x4008c2
                |          0x7fe72b381ec5
                |          
                |--4.76%-- 0x4008fd
                |          0x7fe72b381ec5
                 --0.70%-- [...]
    
         8.02%  arr_test  [kernel.kallsyms]
                |          
                |--4.87%-- 0xffffffff81140b64
                |          0xffffffff81146646
                |          0xffffffff81182751
                |          0xffffffff811829eb
                |          0xffffffff8173317d
                |          0x7fe72bab86a7
                |          0x7fe72baa7e00


file info (shows "not stripped"):

    $ file arr_test 
    arr_test: ELF 64-bit LSB  executable, x86-64, version 1 (SYSV), dynamically 
linked (uses shared libs), for GNU/Linux 2.6.24, not stripped

Details on my perf install (do any of these warnings prevent me from seeing 
symbols in stacks?)

    Auto-detecting system features:
    ...                     backtrace: [ on  ]
    ...                         dwarf: [ OFF ]
    ...                fortify-source: [ on  ]
    ...                         glibc: [ on  ]
    ...                          gtk2: [ on  ]
    ...                  gtk2-infobar: [ on  ]
    ...                      libaudit: [ OFF ]
    ...                        libbfd: [ OFF ]
    ...                        libelf: [ OFF ]
    ...             libelf-getphdrnum: [ OFF ]
    ...                   libelf-mmap: [ OFF ]
    ...                       libnuma: [ on  ]
    ...                       libperl: [ on  ]
    ...                     libpython: [ on  ]
    ...             libpython-version: [ on  ]
    ...                      libslang: [ on  ]
    ...                     libunwind: [ OFF ]
    ...                       on-exit: [ on  ]
    ...                stackprotector: [ on  ]
    ...            stackprotector-all: [ on  ]
    ...                       timerfd: [ on  ]
    
    config/Makefile:264: No libelf found, disables 'probe' tool, please install 
elfutils-libelf-devel/libelf-dev
    config/Makefile:329: No libunwind found, disabling post unwind support. 
Please install libunwind-dev[el] >= 1.1
    config/Makefile:354: No libaudit.h found, disables 'trace' tool, please 
install audit-libs-devel or libaudit-dev

How can I find my symbols in perf?
