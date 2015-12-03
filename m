From: Patrick Agrain <patrick.agrain@al-enterprise.com>
Subject: perf records  no samples on an IBM x3250M5
Date: Thu, 3 Dec 2015 14:26:14 +0000 (UTC)
Message-ID: <loom.20151203T151613-447@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:56893 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752019AbbLCOa3 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 3 Dec 2015 09:30:29 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glkpu-linux-perf-users@m.gmane.org>)
	id 1a4UtY-0004K0-Av
	for linux-perf-users@vger.kernel.org; Thu, 03 Dec 2015 15:30:04 +0100
Received: from proxy.eu.alcatel-lucent.com ([proxy.eu.alcatel-lucent.com])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Thu, 03 Dec 2015 15:30:04 +0100
Received: from patrick.agrain by proxy.eu.alcatel-lucent.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Thu, 03 Dec 2015 15:30:04 +0100
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hello,

perf record no samples in perf.data on an IBM x3250M5.
perf stat is OK (in that way that it displays some stats).
Before digging into the hardware, let us check together if my 'perf'
compilation fulfills all requirements :

I tried to compile the perf inside a linux kernel 3.19 from kernel.org.
Compilation is made on a Centos 6.6 with following info:

[root@localhost Desktop]# cat /proc/version
Linux version 2.6.32-504.23.4.el6.i686 (mockbuild@c6b9.bsys.dev.centos.org)
(gcc version 4.4.7 20120313 (Red Hat 4.4.7-11) (GCC) ) #1 SMP Tue Jun 9
18:09:42 UTC 2015
[root@localhost Desktop]# cd /usr/src/kernels/linux-3.19/tools/perf/
[root@localhost perf]# make
  BUILD:   Doing 'make -j1' parallel build
config/Makefile:128: The path 'python-config' is not executable.
config/Makefile:390: No libunwind found. Please install libunwind-dev[el] >=
1.1 and/or set LIBUNWIND_DIR
config/Makefile:494: Missing perl devel files. Disabling perl scripting
support, consider installing perl-ExtUtils-Embed
config/Makefile:525: No python-config tool was found
config/Makefile:525: Python support will not be built
config/Makefile:627: No numa.h found, disables 'perf bench numa mem'
benchmark, please install numactl-devel/libnuma-devel/libnuma-dev

Auto-detecting system features:
...                         dwarf: [ on  ]
...                         glibc: [ on  ]
...                          gtk2: [ on  ]
...                      libaudit: [ on  ]
...                        libbfd: [ on  ]
...                        libelf: [ on  ]
...                       libnuma: [ OFF ]
...                       libperl: [ OFF ]
...                     libpython: [ OFF ]
...                      libslang: [ on  ]
...                     libunwind: [ OFF ]
...            libdw-dwarf-unwind: [ on  ]
...                          zlib: [ on  ]
...     DWARF post unwind library: libdw

  CC       perf.o
  LINK     perf
  GEN      perf-archive
  GEN      perf-with-kcore
[root@localhost perf]#

Do you see here anything unusual (or wrong, or missing) ?
FYI, I saw no error message during compilation.

Thanks.
Kind regards,
Patrick Agrain
