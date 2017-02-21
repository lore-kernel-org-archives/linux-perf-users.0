From: Mark Davis <markdavisinboston@gmail.com>
Subject: make perf-targz-src-pkg or better approach to install perf?
Date: Tue, 21 Feb 2017 15:42:39 -0500
Message-ID: <CAPe7T+-MO04yfoNSMy91F-z9F759Y8Moa_NUBs7KUJURmVrtJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-oi0-f46.google.com ([209.85.218.46]:34279 "EHLO
        mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753310AbdBUUml (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 21 Feb 2017 15:42:41 -0500
Received: by mail-oi0-f46.google.com with SMTP id 65so10536830oig.1
        for <linux-perf-users@vger.kernel.org>; Tue, 21 Feb 2017 12:42:40 -0800 (PST)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hi all. I used to use

make perf-targz-src-pkg

to install perf from the linux/tools/perf source. I'm now trying to
upgrade my perf installation from source again and I'm not seeing this
make target. I'm having a bit of trouble with dependencies. Here's
what I get when I try to build. (Note: my source is from github
(https://github.com/torvalds/linux) at 772c8f6 (from a couple hours
ago). Is there a new / recommended approach to installing perf that is
similar to the above approach? I don't have root on this machine and
need to install either from source or a relatively recent package that
I can install to an arbitrary directory. I'm using clang 3.8.0 as my
compiler (note: I can change this or upgrade this if necessary). In
particular I'm trying to get BPF in perf-record, which seems to be
disabled based on the warnings that print out.

I'm also getting this other compiler error:

warning: optimization level '-O6' is not supported; using '-O3' instead

  CC       pmu-events/pmu-events.o

error: unknown warning option '-Wstrict-aliasing=3'; did you mean
'-Wstring-plus-int'?

      [-Werror,-Wunknown-warning-option]


Auto-detecting system features:

...                         dwarf: [ OFF ]

...            dwarf_getlocations: [ OFF ]

...                         glibc: [ on  ]

...                          gtk2: [ on  ]

...                      libaudit: [ OFF ]

...                        libbfd: [ OFF ]

...                        libelf: [ OFF ]

...                       libnuma: [ on  ]

...        numa_num_possible_cpus: [ on  ]

...                       libperl: [ on  ]

...                     libpython: [ on  ]

...                      libslang: [ on  ]

...                     libcrypto: [ OFF ]

...                     libunwind: [ OFF ]

...            libdw-dwarf-unwind: [ OFF ]

...                          zlib: [ on  ]

...                          lzma: [ on  ]

...                     get_cpuid: [ on  ]

...                           bpf: [ on  ]


Makefile.config:275: No libelf found, disables 'probe' tool and BPF
support in 'perf record', please installlibelf-dev, libelf-devel or
elfutils-libelf-devel

Makefile.config:377: No sys/sdt.h found, no SDT events are defined,
please install systemtap-sdt-devel or systemtap-sdt-dev

Makefile.config:450: Disabling post unwind, no support found.

Makefile.config:496: No libaudit.h found, disables 'trace' tool,
please install audit-libs-devel or libaudit-dev

Makefile.config:507: No libcrypto.h found, disables jitted code
injection, please install libssl-devel or libssl-dev

Makefile.config:798: No openjdk development package found, please
install JDK package



Thank you,

Mark
