From: Michael Petlan <mpetlan@redhat.com>
Subject: Re: perf records  no samples on an IBM x3250M5
Date: Thu, 03 Dec 2015 16:42:25 +0100
Message-ID: <1449157345.24573.149.camel@redhat.com>
References: <loom.20151203T151613-447@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36616 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752142AbbLCPm2 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 3 Dec 2015 10:42:28 -0500
In-Reply-To: <loom.20151203T151613-447@post.gmane.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Patrick Agrain <patrick.agrain@al-enterprise.com>
Cc: linux-perf-users@vger.kernel.org

On Thu, 2015-12-03 at 14:26 +0000, Patrick Agrain wrote:
> Hello,
> 
> perf record no samples in perf.data on an IBM x3250M5.
> perf stat is OK (in that way that it displays some stats).

1) Which stats are displayed? Do the basic events from "perf list hw"
work?

perf stat -e cycles -- sleep 1
perf stat -e instructions -- sleep 1


2) What does "perf list hw" show?


> Before digging into the hardware, let us check together if my 'perf'
> compilation fulfills all requirements :
> 
> I tried to compile the perf inside a linux kernel 3.19 from kernel.org.
> Compilation is made on a Centos 6.6 with following info:
> 
> [root@localhost Desktop]# cat /proc/version
> Linux version 2.6.32-504.23.4.el6.i686 (mockbuild@c6b9.bsys.dev.centos.org)
> (gcc version 4.4.7 20120313 (Red Hat 4.4.7-11) (GCC) ) #1 SMP Tue Jun 9
> 18:09:42 UTC 2015
> [root@localhost Desktop]# cd /usr/src/kernels/linux-3.19/tools/perf/
> [root@localhost perf]# make
>   BUILD:   Doing 'make -j1' parallel build
> config/Makefile:128: The path 'python-config' is not executable.
> config/Makefile:390: No libunwind found. Please install libunwind-dev[el] >=
> 1.1 and/or set LIBUNWIND_DIR
> config/Makefile:494: Missing perl devel files. Disabling perl scripting
> support, consider installing perl-ExtUtils-Embed
> config/Makefile:525: No python-config tool was found
> config/Makefile:525: Python support will not be built
> config/Makefile:627: No numa.h found, disables 'perf bench numa mem'
> benchmark, please install numactl-devel/libnuma-devel/libnuma-dev
> 
> Auto-detecting system features:
> ...                         dwarf: [ on  ]
> ...                         glibc: [ on  ]
> ...                          gtk2: [ on  ]
> ...                      libaudit: [ on  ]
> ...                        libbfd: [ on  ]
> ...                        libelf: [ on  ]
> ...                       libnuma: [ OFF ]
> ...                       libperl: [ OFF ]
> ...                     libpython: [ OFF ]
> ...                      libslang: [ on  ]
> ...                     libunwind: [ OFF ]
> ...            libdw-dwarf-unwind: [ on  ]
> ...                          zlib: [ on  ]
> ...     DWARF post unwind library: libdw
> 
>   CC       perf.o
>   LINK     perf
>   GEN      perf-archive
>   GEN      perf-with-kcore
> [root@localhost perf]#
> 
> Do you see here anything unusual (or wrong, or missing) ?
> FYI, I saw no error message during compilation.
> 
> Thanks.
> Kind regards,
> Patrick Agrain
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
