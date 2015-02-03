From: Christopher Covington <ccovingt@quicinc.com>
Subject: Re: [PATCH] perf: fix building error in x86_64 when dwarf unwind is on.
Date: Tue, 3 Feb 2015 14:58:53 -0500
Message-ID: <54D1287D.5020502@quicinc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:18541 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756139AbbBCT65 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 3 Feb 2015 14:58:57 -0500
References: 1421029255-23039-1-git-send-email-wangnan0@huawei.com
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Wang Nan <wangnan0@huawei.com>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Li Zefan <lizefan@huawei.com>, Ingo Molnar <mingo@redhat.com>, linux-perf-users@vger.kernel.org

Hi,

Commit c6e5e9fbc3ea1c1a5648a3498d085fc3978df2d4 breaks the following make
invocation (-j, -C, O=, LDFLAGS=, and build directory prefix stripped to
simplify report):

make ARCH=x86_64 CROSS_COMPILE= EXTRA_CFLAGS=
config/Makefile:128: The path 'python-config' is not executable.
config/Makefile:349: No libdw.h found or old libdw.h found or elfutils is
older than 0.138, disables dwarf support. Please install new
elfutils-devel/libdw-dev
config/Makefile:401: Disabling post unwind, no support found.
config/Makefile:439: No libaudit.h found, disables 'trace' tool, please
install audit-libs-devel or libaudit-dev
config/Makefile:453: slang not found, disables TUI support. Please install
slang-devel or libslang-dev
config/Makefile:466: GTK2 not found, disables GTK2 support. Please install
gtk2-devel or libgtk2.0-dev
config/Makefile:494: Missing perl devel files. Disabling perl scripting
support, consider installing perl-ExtUtils-Embed
config/Makefile:525: No python-config tool was found
config/Makefile:525: Python support will not be built
config/Makefile:597: No bfd.h/libbfd found, install
binutils-dev[el]/zlib-static to gain symbol demangling
config/Makefile:627: No numa.h found, disables 'perf bench numa mem'
benchmark, please install numactl-devel/libnuma-devel/libnuma-dev

Auto-detecting system features:
...                         dwarf: [ [31mOFF[m ]
...                         glibc: [ [32mon[m  ]
...                          gtk2: [ [31mOFF[m ]
...                      libaudit: [ [31mOFF[m ]
...                        libbfd: [ [31mOFF[m ]
...                        libelf: [ [32mon[m  ]
...                       libnuma: [ [31mOFF[m ]
...                       libperl: [ [31mOFF[m ]
...                     libpython: [ [31mOFF[m ]
...                      libslang: [ [31mOFF[m ]
...                     libunwind: [ [31mOFF[m ]
...            libdw-dwarf-unwind: [ [31mOFF[m ]
...                          zlib: [ [32mon[m  ]

[...]

  AR       x86_64-linux-gnu/perf/libperf.a
  LINK     x86_64-linux-gnu/perf/perf
x86_64-linux-gnu/perf/tests/builtin-test.o:(.data+0x158): undefined reference
to `test__perf_time_to_tsc'
collect2: ld returned 1 exit status

Thanks,
Chris
