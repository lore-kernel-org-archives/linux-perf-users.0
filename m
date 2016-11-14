From: Kim Phillips <kim.phillips@arm.com>
Subject: Re: frame-pointer based user stack unwinding with perf on arm32
Date: Mon, 14 Nov 2016 17:45:18 -0600
Message-ID: <20161114174518.9d88459ac32145bbd6e0d5a8@arm.com>
References: <2484144.z8iE8SUiXE@milian-kdab2>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:42744 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755155AbcKNXpU (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 14 Nov 2016 18:45:20 -0500
In-Reply-To: <2484144.z8iE8SUiXE@milian-kdab2>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <milian.wolff@kdab.com>
Cc: perf group <linux-perf-users@vger.kernel.org>

On Mon, 14 Nov 2016 14:14:30 +0100
Milian Wolff <milian.wolff@kdab.com> wrote:

Hi Milian,

> None of these produced the desired results when running `perf record -g` on 
> the target platform (a panda board):
> 
> root@arm:~# perf record -g ./stress_bt
> Total count: 171711327751528502
> root@arm:~# perf script 
> <snip>
> ...
> stress_bt   825  7645.3346298627:    8241360 cycles:ppp: 
>                      5a0 foo_128+0xfffe0084 (/root/stress_bt)
> 
> stress_bt   825  7645.3346305738:    7932022 cycles:ppp: 
>                      592 foo_128+0xfffe0076 (/root/stress_bt)
> ...

> So, can someone please clarify whether this should also work on arm32? What 
> are the requirements?

I have this working with a natively-built perf (today's acme's
perf/core branch):

$ ./perf --version
perf version 4.9.rc1.g699c
$ uname -a
Linux tc2 4.8.0+ #7 SMP Tue Oct 4 10:29:55 CDT 2016 armv7l GNU/Linux
$ cat ./runcallg.sh
sudo ./perf record -o perf.data --call-graph dwarf -- ./stress_bt |& tee record-callg.log
sudo ./perf report --call-graph --stdio >& report-callg.log
$ ./runcallg.sh 
Lowering default frequency rate to 1600.
Please consider tweaking /proc/sys/kernel/perf_event_max_sample_rate.
Total count: 171711327751528502
[ perf record: Woken up 514 times to write data ]
Warning:
Processed 19294 events and lost 32 chunks!

Check IO/CPU overload!

[ perf record: Captured and wrote 128.420 MB perf.data (16025 samples) ]
$ head -40 report-callg.log
Warning:
Processed 19294 events and lost 32 chunks!

Check IO/CPU overload!

# To display the perf.data header info, please use --header/--header-only options.
#
#
# Total Lost Samples: 0
#
# Samples: 16K of event 'cycles:ppp'
# Event count (approx.): 7863498267
#
# Children      Self  Command    Shared Object      Symbol                            
# ........  ........  .........  .................  ..................................
#
    99.62%    99.58%  stress_bt  stress_bt          [.] foo_128
            |          
            |--95.74%--__libc_start_main
            |          main
            |          doit
            |          bar
            |          |          
            |          |--1.01%--foo_30
            |          |          foo_31
            |          |          foo_32
            |          |          foo_33
            |          |          foo_34
            |          |          foo_35
            |          |          foo_36
            |          |          foo_37
            |          |          foo_38
            |          |          foo_39
            |          |          foo_40
            |          |          foo_41
            |          |          foo_42
            |          |          foo_43
            |          |          foo_44
            |          |          foo_45
            |          |          foo_46

The above works both with the arm32 binary included in the downloaded
stress_bt.tar.gz, and one built with a native gcc 4.9.2, using only the
'-g' flag ("gcc -g stress_bt.c").

OTOH, I tried using a cross-built perf, and it did not work (same
behaviour you're seeing).

The Linaro wiki page lists at least libunwind as a dependency, and the
native build has it:

Auto-detecting system features:
...                         dwarf: [ on  ]
...            dwarf_getlocations: [ on  ]
...                         glibc: [ on  ]
...                          gtk2: [ OFF ]
...                      libaudit: [ on  ]
...                        libbfd: [ on  ]
...                        libelf: [ on  ]
...                       libnuma: [ OFF ]
...        numa_num_possible_cpus: [ OFF ]
...                       libperl: [ on  ]
...                     libpython: [ on  ]
...                      libslang: [ on  ]
...                     libcrypto: [ on  ]
...                     libunwind: [ on  ]
...            libdw-dwarf-unwind: [ on  ]
...                          zlib: [ on  ]
...                          lzma: [ on  ]
...                     get_cpuid: [ OFF ]
...                           bpf: [ OFF ]

Makefile.config:349: BPF prologue is not supported by architecture arm, missing regs_query_register_offset()
Makefile.config:422: BPF API too old. Please install recent kernel headers. BPF support in 'perf record' is disabled.
Makefile.config:519: GTK2 not found, disables GTK2 support. Please install gtk2-devel or libgtk2.0-dev
Makefile.config:693: No numa.h found, disables 'perf bench numa mem' benchmark, please install numactl-devel/libnuma-devel/libnuma-dev

whereas the cross build does not:

Auto-detecting system features:
...                         dwarf: [ OFF ]
...            dwarf_getlocations: [ OFF ]
...                         glibc: [ on  ]
...                          gtk2: [ OFF ]
...                      libaudit: [ OFF ]
...                        libbfd: [ OFF ]
...                        libelf: [ OFF ]
...                       libnuma: [ OFF ]
...        numa_num_possible_cpus: [ OFF ]
...                       libperl: [ OFF ]
...                     libpython: [ OFF ]
...                      libslang: [ OFF ]
...                     libcrypto: [ OFF ]
...                     libunwind: [ OFF ]
...            libdw-dwarf-unwind: [ OFF ]
...                          zlib: [ OFF ]
...                          lzma: [ OFF ]
...                     get_cpuid: [ OFF ]
...                           bpf: [ on  ]

Makefile.config:260: No libelf found, disables 'probe' tool and BPF support in 'perf record', please install libelf-dev, l
ibelf-devel or elfutils-libelf-devel
Makefile.config:360: No sys/sdt.h found, no SDT events are defined, please install systemtap-sdt-devel or systemtap-sdt-de
v
Makefile.config:433: Disabling post unwind, no support found.
Makefile.config:479: No libaudit.h found, disables 'trace' tool, please install audit-libs-devel or libaudit-dev
Makefile.config:490: No libcrypto.h found, disables jitted code injection, please install libssl-devel or libssl-dev
Makefile.config:505: slang not found, disables TUI support. Please install slang-devel, libslang-dev or libslang2-dev
Makefile.config:519: GTK2 not found, disables GTK2 support. Please install gtk2-devel or libgtk2.0-dev
Makefile.config:547: Missing perl devel files. Disabling perl scripting support, please install perl-ExtUtils-Embed/libper
l-dev
Makefile.config:590: No 'Python.h' (for Python 2.x support) was found: disables Python support - please install python-dev
el/python-dev
Makefile.config:680: No liblzma found, disables xz kernel module decompression, please install xz-devel/liblzma-dev
Makefile.config:693: No numa.h found, disables 'perf bench numa mem' benchmark, please install numactl-devel/libnuma-devel
/libnuma-dev

Unfortunately, I don't know how to cross-build perf with libunwind
turned on: On Ubuntu, I cd tools/ and issue 'make ARCH=arm
CROSS_COMPILE=arm-linux-gnueabihf- perf'.  Installing something called
android-libunwind-dev didn't help, and I can't tell whether the wiki
page includes building perf in a cross environment (in fact, it
references a /lib/arm-linux-gnueabihf/ which is present on my versatile
express' target Debian installation).

hth,

Kim
