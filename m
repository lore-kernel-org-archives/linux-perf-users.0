From: Hannu Lounento <hannu.lounento@ge.com>
Subject: Problems with call-graphs on ARMv7
Date: Thu, 23 Jun 2016 09:06:52 +0300
Message-ID: <20160623060651.GE7717@hce-dnlf162.clients.em.health.ge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx0a-00176a03.pphosted.com ([67.231.149.52]:46752 "EHLO
	mx0a-00176a03.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751000AbcFWG1t (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 23 Jun 2016 02:27:49 -0400
Received: from pps.filterd (m0048275.ppops.net [127.0.0.1])
	by m0048275.ppops.net-00176a03. (8.16.0.11/8.16.0.11) with SMTP id u5N67xfD043764
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Jun 2016 02:08:50 -0400
Content-Disposition: inline
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hi,

I'm trying to record call graphs with perf on an i.MX6 Dual (dual core ARMv7-A)
and Linux 4.5 based system but I can't get perf to show the call chain at all
or I get a call chain with user space and kernel space symbols seem to be
interleaved.


The examples here are from a test application (called sbt) that is based on the
stress_bt application from Linaro's perf related wiki article ARM32/64: perf:
dwarf stack frame unwinding support [1]. In order to simplify the test case
initially, I modified the test application not to produce parallel call
hierarchies to foo_N functions. I.e. my version only calls the function foo_1 in
a loop in its main function and, foo_1 calls foo_2, which calls foo_3, etc.
until foo_128.

I run perf as follows:

  # perf record --call-graph dwarf -- sbt
  # perf report --call-graph --stdio

and get no call chain at all:

    [...]

    17.75%    15.93%  sbt      sbt                [.] foo_128                      
                |
                ---foo_128

    [...]

As far I've understood, if foo_128 is sampled, I should see the call chain main
foo_1 - ... - foo_127 - foo_128 as shown at [1] in the section "Expected Result
/ Example with dwarf unwinding information".

Another case from the very same perf report where the call chain seems very
odd to me:

    [...]

     6.95%     0.00%  sbt      [kernel.kallsyms]  [k] irq_exit                     
                |
                ---irq_exit
                   __do_softirq
                   |          
                   |--4.27%--tasklet_hi_action
                   |          usb_giveback_urb_bh
                   |          |          
                   |          |--3.86%--__usb_hcd_giveback_urby
                   |          |          |          
                   |          |          |--2.46%--__GI___libc_write
                   |          |          |          
                   |          |          |--1.26%--foo_128
                   |          |          |          
                   |          |           --0.14%--usb_anchor_suspend_wakeups
                   |          |                     __GI___libc_write
                   |          |          
                   |           --0.41%--_raw_spin_unlock_irq
                   |                     |          
                   |                     |--0.26%--__GI___libc_write
                   |                     |          
                   |                      --0.15%--foo_128
                   |          
                   |--1.74%--__GI___libc_write
                   |          
                   |--0.41%--foo_128
                   |          
                   |--0.15%--run_rebalance_domains
                   |          rebalance_domains
                   |          _raw_spin_unlock_irqrestore
                   |          __GI___libc_write
                   |          
                   |--0.15%--_fini
                   |          
                   |--0.12%--foo_97
                   |          
                    --0.11%--run_timer_softirq
                              call_timer_fn
                              process_timeout
                              wake_up_process
                              try_to_wake_up
                              _raw_spin_unlock_irqrestore
                              __GI___libc_write

    [...]

E.g. __usb_hcd_giveback_urby and foo_128 or _raw_spin_unlock_irq and foo_128
should not be (at least directly) related at all.

Based on [1] Linaro has done work on call graphs on ARM, and according to [1]
and [2] (FOSDEM 2015 presentation) unwinding support for ARMv7 has been merged
to the mainline.

In [1] the section 'perf built-in dwarf unwinding test' shows the perf
test 'dwarf unwind' run on ARMv7 but I don't see dwarf unwind in the
output of 'perf test list' on my system. Additionally, the only place
where I can find "Test dwarf unwind" in the kernel source tree (both our
4.5 and the stable 4.6 tree) is tools/perf/arch/x86/tests/arch-tests.c,
which suggests that it is only available in the x86 arch. This makes me
feel that not everything documented on Linaro's wiki applies to mainline
even if the ARMv7 patches should have been mainlined.


I'm running a Yocto (krogoth) based distribution with Linux 4.5. perf is built
as follows:

    NOTE: make -j 48 -C /path/to/my/build/tmp/work-shared/myhw/kernel-source/tools/perf O=/path/to/my/build/tmp/work/myhw-mydistro-linux-gnueabi/perf/1.0-r9/perf-1.0 CROSS_COMPILE=arm-mydistro-linux-gnueabi- ARCH=arm CC=arm-mydistro-linux-gnueabi-gcc -march=armv7-a -mfpu=neon -mfloat-abi=hard -mcpu=cortex-a8 --sysroot=/path/to/my/build/tmp/sysroots/myhw AR=arm-mydistro-linux-gnueabi-ar EXTRA_CFLAGS=-ldw perfexecdir=/usr/libexec NO_GTK2=1 NO_LIBNUMA=1 DESTDIR=/path/to/my/build/tmp/work/myhw-mydistro-linux-gnueabi/perf/1.0-r9/image prefix=/usr bindir=/usr/bin sharedir=/usr/share sysconfdir=/etc perfexecdir=/usr/libexec/perf-core ETC_PERFCONFIG=
    ../etc sharedir=share mandir=share/man infodir=share/info all
    make: Entering directory `/path/to/my/build/tmp/work-shared/myhw/kernel-source/tools/perf'
      BUILD:   Doing 'make        -j48     ' parallel build
    
    Auto-detecting system features:
    ...                         dwarf: [        on       ]
    ...                         glibc: [        on       ]
    ...                          gtk2: [        OFF      ]
    ...                      libaudit: [        on       ]
    ...                        libbfd: [        on       ]
    ...                        libelf: [        on       ]
    ...                       libnuma: [        OFF      ]
    ...        numa_num_possible_cpus: [        OFF      ]
    ...                       libperl: [        on       ]
    ...                     libpython: [        on       ]
    ...                      libslang: [        on       ]
    ...                     libunwind: [        on       ]
    ...            libdw-dwarf-unwind: [        on       ]
    ...                          zlib: [        on       ]
    ...                          lzma: [        on       ]
    ...                     get_cpuid: [        OFF      ]
    ...                           bpf: [        on       ]
    
    config/Makefile:329: BPF prologue is not supported by architecture arm, missing regs_query_register_offset()
    config/Makefile:665: Your gcc lacks the __get_cpuid() builtin, disables support for auxtrace/Intel PT, please install a newer gcc

(Note: I'm building for Cortex-A8 instead of Cortex-A9 as the same builds are
supposed to be run also on an i.MX535 CPU.)

libunwind and libdw versions are as follows:

    libdw1 - 0.164-r0.0
    libunwind - 1.1-r0.0

poky (meta/recipes-kernel/perf.bb) defines NO_DWARF=1 when building perf, which
I have removed to get DWARF support built in addition to adding perf-libunwind
to perf features. The openembedded-core commit that added support for libunwind
has a commit message that suggests that call stack would only work when
compiling for THUMB2:

    commit 10dfa4ee4e05841be3d3caaa28778aa40b782f97
    Author: Chong Lu <Chong.Lu@windriver.com>
    Date:   Mon Sep 8 12:58:25 2014 +0100
    
        perf: add libunwind support
        
        Add a new feature named 'perf-libunwind'. Adding this support to perf allows it
        to do stack traces on ARM - thumb2 and MIPS targets. PERF_FEATURES variable in
        perf-features.inc will enable the perf-libunwind.
        
        Signed-off-by: Chong Lu <Chong.Lu@windriver.com>
        Signed-off-by: Saul Wold <sgw@linux.intel.com>
        Signed-off-by: Ross Burton <ross.burton@intel.com>
        Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

My assumption is that this was the case in 2014 but with a current kernel
(including 4.5 that we're using) stack unwinding should also work with the
ARM instruction set.


My test application is built with -g including DWARF debug information required
for stack unwinding (the ELF section .debug_frame exists):

    # readelf -S /usr/bin/.debug/sbt 
    There are 40 section headers, starting at offset 0x1c160:
    
    Section Headers:
      [Nr] Name              Type            Addr     Off    Size   ES Flg Lk Inf Al
      [ 0]                   NULL            00000000 000000 000000 00      0   0  0
      [ 1] .interp           NOBITS          00010134 000134 000019 00   A  0   0  1
      [ 2] .note.ABI-tag     NOTE            00010150 000150 000020 00   A  0   0  4
      [ 3] .note.gnu.build-i NOTE            00010170 000170 000024 00   A  0   0  4
      [ 4] .gnu.hash         NOBITS          00010194 000194 0000c0 04   A  5   0  4
      [ 5] .dynsym           NOBITS          00010254 000194 000160 10   A  6   1  4
      [ 6] .dynstr           NOBITS          000103b4 000194 0001e0 00   A  0   0  1
      [ 7] .gnu.version      NOBITS          00010594 000194 00002c 02   A  5   0  2
      [ 8] .gnu.version_r    NOBITS          000105c0 000194 000070 00   A  6   3  4
      [ 9] .rel.dyn          NOBITS          00010630 000194 000018 08   A  5   0  4
      [10] .rel.plt          NOBITS          00010648 000194 000078 08   A  0   0  4
      [11] .init             NOBITS          000106c0 000194 00000c 00  AX  0   0  4
      [12] .plt              NOBITS          000106cc 000194 0000c8 04  AX  0   0  4
      [13] .text             NOBITS          00010794 000194 001e50 00  AX  0   0  4
      [14] .fini             NOBITS          000125e4 000194 000008 00  AX  0   0  4
      [15] .rodata           NOBITS          000125ec 000194 00000c 00   A  0   0  4
      [16] .ARM.extab        NOBITS          000125f8 000194 00060c 00   A  0   0  4
      [17] .ARM.exidx        NOBITS          00012c04 000194 000418 00  AL 13   0  4
      [18] .eh_frame         NOBITS          0001301c 000194 000004 00   A  0   0  4
      [19] .init_array       NOBITS          00023020 003020 000008 00  WA  0   0  4
      [20] .fini_array       NOBITS          00023028 003020 000004 00  WA  0   0  4
      [21] .jcr              NOBITS          0002302c 003020 000004 00  WA  0   0  4
      [22] .dynamic          NOBITS          00023030 003020 0000f8 08  WA  6   0  4
      [23] .got              NOBITS          00023128 003020 00004c 04  WA  0   0  4
      [24] .data             NOBITS          00023174 003020 00000c 00  WA  0   0  4
      [25] .bss              NOBITS          00023180 003020 0000a4 00  WA  0   0  8
      [26] .comment          PROGBITS        00000000 000194 000011 01  MS  0   0  1
      [27] .ARM.attributes   ARM_ATTRIBUTES  00000000 0001a5 00003d 00      0   0  1
      [28] .debug_aranges    PROGBITS        00000000 0001e8 0000d0 00      0   0  8
      [29] .debug_info       PROGBITS        00000000 0002b8 002c47 00      0   0  1
      [30] .debug_abbrev     PROGBITS        00000000 002eff 0005e9 00      0   0  1
      [31] .debug_line       PROGBITS        00000000 0034e8 000f68 00      0   0  1
      [32] .debug_frame      PROGBITS        00000000 004450 000ec8 00      0   0  4
      [33] .debug_str        PROGBITS        00000000 005318 011157 01  MS  0   0  1
      [34] .debug_loc        PROGBITS        00000000 01646f 000091 00      0   0  1
      [35] .debug_ranges     PROGBITS        00000000 016500 000078 00      0   0  8
      [36] .debug_macro      PROGBITS        00000000 016578 003dde 00      0   0  1
      [37] .shstrtab         STRTAB          00000000 01bfd5 000188 00      0   0  1
      [38] .symtab           SYMTAB          00000000 01a358 0010e0 10     39 101  4
      [39] .strtab           STRTAB          00000000 01b438 000b9d 00      0   0  1
    Key to Flags:
      W (write), A (alloc), X (execute), M (merge), S (strings)
      I (info), L (link order), G (group), T (TLS), E (exclude), x (unknown)
      O (extra OS processing required) o (OS specific), p (processor specific)

The build command lines are as follows:

    arm-mydistro-linux-gnueabi-g++  -march=armv7-a -mfpu=neon  -mfloat-abi=hard -mcpu=cortex-a8 --sysroot=/path/to/my/build/tmp/sysroots/myhw -DHAVE_CONFIG_H -I. -I../../../../../../../../../sbt     -O0 -g3 -c -o src/sbt.o ../../../../../../../../../sbt/src/sbt.cpp
    arm-mydistro-linux-gnueabi-g++  -march=armv7-a -mfpu=neon  -mfloat-abi=hard -mcpu=cortex-a8 --sysroot=/path/to/my/build/tmp/sysroots/myhw  -O0 -g3  -Wl,-O1 -Wl,--hash-style=gnu -Wl,--as-needed -o sbt src/sbt.o


Other observations I have made, which may or may not be relevant:

* I also have -fno-omit-frame-pointer system-wide and I've tried `perf record
  --call-graph fp` without significantly different results.

* I'm seeing overload problems if I run perf even for a longer period of
  time than a single run of my test application with the default sampling
  rate (1000 Hz according to [3]). The maximum sampling rate on my system
  according to /proc/sys/kernel/perf_event_max_sample_rate was 1600 Hz at
  the time of the test. perf report reported "Check IO/CPU overload!" with
  a 5 second recording and with a 10 second recording perf record
  triggered the message

    kernel[234]: [84121.647250] Disabling IRQ #24

  which is the perf hardware event interrupt.


I'm not sure if the problem is e.g.
* perf configuration or build issue
* Application build issue (e.g. improper flags resulting in e.g. some missing
  debug info)
* Sampling problem (e.g. due to performance problems)

Any advice on what to investigate further to get perf to record and report
proper call graphs would be highly appreciated.


[1] https://wiki.linaro.org/LEG/Engineering/TOOLS/perf-callstack-unwinding
[2] https://wiki.linaro.org/LEG/Engineering/TOOLS/perf-callstack-unwinding?action=AttachFile&do=view&target=Fosdem+2015+perf+status+on+ARM+and+ARM64.pdf
[3] https://perf.wiki.kernel.org/index.php/Tutorial


Thanks,
-- 
-Hannu
