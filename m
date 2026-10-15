Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA7735E922;
	Thu, 15 Oct 2026 14:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792074993; cv=none; b=FfsvB17xsTc9UlhSc1+qrnTXloApuGf2fqycGZRbBmT341FggonaTlF+1t+J4zQrNba/7iJ1MqKxTQL9pmihui2cSXPMHO1WwTCQKXNEbtGfGDGxVW6mvodrKYaOEsvQie3oT7S96WB132uvyNIuKK20/4F0/zngWzsbZ72sIUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792074993; c=relaxed/simple;
	bh=+339iin8YDxu73cdixQ40mGObU5uUHzWLVz9chThbYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PoJ4oPL8KWBiZQ+v+jIg1AWMtfjvh35GVReDpQk8wG5Dl/0LAwy9VOTZEpGQ5cGstuCXMpmvfM9Gi9g17nES6GGKUz9epBksh5SECiBXPebiR0i2NsfexThR0Vq++VkUx7+pgUcNqJadiV/+YwPR1YbfNa4njHIuQ3/OZfMXcKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HBddTCH+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HBddTCH+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C034C1F000C4;
	Thu, 15 Oct 2026 14:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792074991;
	bh=G4HYCNRwmOYnsIzSHtwPTUn70uM/iwo6cRsidIC2HRU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HBddTCH+RlOLLfTmDAd5bx/qgStnKOV+WzhlxvxE41Vt1wYD6orgPcMI4GPNbVSV2
	 6DdYDYoC0UQIaIZNTkyTF+smva8QJIHZx1TndYymgxxqWlvnOy61mE3kzN7WU2563w
	 uOOoGJNpHxEBPIXm5UWk/tov81SM2gc0BXhLNP9XfPZNL0jZhQocj1mFAO1hypHkDg
	 nY+Q30UEM9QYQfUMZX9cGbSXEkcwrIf1k1CoBf74EGU7Me2PcG4S096gQt4ajy7D1h
	 7GPbKLOS6duFcK51M+1YLjxq1pD8zhadvlyAzLDCGmVfhszCyrkEBvyCoL4EhyE59R
	 FjJ7YJPuWjGQg==
Date: Thu, 15 Oct 2026 11:36:28 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v5 07/11] perf tools: Factor out dso__find_binary_type()
Message-ID: <atDk7JqIrWIfPq18@x2>
References: <20261013172155.160869-1-namhyung@kernel.org>
 <20261013172155.160869-8-namhyung@kernel.org>
 <atDSmfwd4v_oLg4m@x2>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <atDSmfwd4v_oLg4m@x2>

On Thu, Oct 15, 2026 at 10:18:21AM -0300, Arnaldo Carvalho de Melo wrote:
> On Tue, Oct 13, 2026 at 10:21:51AM -0700, Namhyung Kim wrote:
> > Separate out the logic to detect binary type of a DSO.  It checks if
> > the candidate file contains ".text" section.  There could be data-only
> > DSOs but as our use cases focus on the code (perf annotate or intel
> > PT), we can ignore them for now.
>  
> > But it also can fail due to open file limit.  Handle the case by
> > retrying with _dso__data_open_lock.
>  
> > Introduce bintype_searched flag and it accessors to prevent repeated
> > (failed) search.
> 
> This one, when compiled with clang, catch this in all my build
> containers:
> 
>   LD      /tmp/build/perf-tools-next/tests/perf-test-in.o
> util/dso.c:942:7: error: mutex '_dso__data_open_lock' is not held on every path through here [-Werror,-Wthread-safety-analysis]
>   942 |                 if (dso__data_open_cnt) {
>       |                     ^
> util/dso.c:940:4: note: mutex acquired here
>   940 |                         mutex_lock(dso__data_open_lock());
>       |                         ^
> util/dso.c:942:7: error: reading variable 'dso__data_open_cnt' requires holding mutex '_dso__data_open_lock'   CC      /tmp/build/perf-tools-next/util/maps.o
> [-Werror,-Wthread-safety-analysis]
>   942 |                 if (dso__data_open_cnt) {
>       |                     ^
> util/dso.c:943:4: error: calling function 'close_first_dso' requires holding mutex '_dso__data_open_lock' exclusively [-Werror,-Wthread-safety-analysis]
>   943 |                         close_first_dso();
>       |                         ^
> util/dso.c:949:3: error: releasing mutex '_dso__data_open_lock' that was not held [-Werror,-Wthread-safety-analysis]
>   949 |                 mutex_unlock(dso__data_open_lock());
>       |                 ^
> 4 errors generated.
> make[4]: *** [/home/acme/git/perf-tools-next/tools/build/Makefile.build:95: /tmp/build/perf-tools-next/util/dso.o] Error 1
>   CC	  /tmp/build/perf-tools-next/util/thread.o
> 
> perf adds -Wthread-safety for clang builds (tools/perf/Makefile.config),
> so it is -Werror there.
> 
> This is because __dso__find_binary_type() takes _dso__data_open_lock only
> on the first retry, under needs_open_lock, and then reads
> dso__data_open_cnt and calls close_first_dso(); with the lock taken
> conditionally the analyzer can't see it held on every path.  And for the
> try_to_open_dso() caller, which already holds it, the requirement was
> only implicit, the helper had no annotation for clang to check.
> 
> I've folded the following into the patch, see if it is acceptable:

With it only some cross builds are failing but that is unrelated, I
still need to fix those:

toolsbuilder@five:~$ cat dm.log/summary
Subject: tools build test for http://192.168.86.5/perf/perf-7.3.0-rc2.tar.xz

   1    71.83 almalinux:8                   : Ok   gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-28) , clang version 21.1.8 ( 21.1.8-1.module_el8.10.0+4172+b6b13d75) flex 2.6.1
   2    80.63 almalinux:9                   : Ok   gcc (GCC) 11.5.0 20240719 (Red Hat 11.5.0-14) , clang version 21.1.8 (AlmaLinux OS Foundation 21.1.8-2.el9) flex 2.6.4
   3   100.09 almalinux:9-i386              : Ok   gcc (GCC) 11.5.0 20240719 (Red Hat 11.5.0-14) , clang version 21.1.8 (AlmaLinux OS Foundation 21.1.8-2.el9) flex 2.6.4
   4    77.04 almalinux:10                  : Ok   gcc (GCC) 14.3.1 20251022 (Red Hat 14.3.1-4) , clang version 21.1.8 (AlmaLinux OS Foundation 21.1.8-1.el10.alma.1) flex 2.6.4
   5   108.48 alpine:3.22                   : Ok   gcc (Alpine 14.2.0) 14.2.0 , Alpine clang version 20.1.8 flex 2.6.4
   6    99.85 alpine:3.23                   : Ok   gcc (Alpine 15.2.0) 15.2.0 , Alpine clang version 21.1.2 flex 2.6.4
   7   108.80 alpine:3.24                   : Ok   gcc (Alpine 15.2.0) 15.2.0 , Alpine clang version 22.1.3 flex 2.6.4
   8   124.65 alpine:edge                   : Ok   gcc (Alpine 15.2.0) 15.2.0 , Alpine clang version 23.1.2 flex 2.6.4
   9    90.47 amazonlinux:2023              : Ok   gcc (GCC) 11.5.0 20240719 (Red Hat 11.5.0-5) , clang version 15.0.7 (AWS 15.0.7-3.amzn2023.0.4) flex 2.6.4
  10    91.24 amazonlinux:devel             : Ok   gcc (GCC) 11.3.1 20221121 (Red Hat 11.3.1-4) , clang version 15.0.6 (Amazon Linux 15.0.6-3.amzn2023.0.2) flex 2.6.4
  11   105.40 archlinux:base                : Ok   gcc (GCC) 16.2.1 20260810 , clang version 22.1.8 flex 2.6.4
  12    73.00 centos:stream                 : Ok   gcc (GCC) 14.4.1 20260724 (Red Hat 14.4.1-3) , clang version 22.1.8 (CentOS 22.1.8-1.el10) flex 2.6.4
  13    76.29 debian:11                     : Ok   gcc (Debian 10.2.1-6) 10.2.1 20210110 , Debian clang version 13.0.1-6~deb11u1 flex 2.6.4
  14    88.71 debian:12                     : Ok   gcc (Debian 12.2.0-14+deb12u1) 12.2.0 , Debian clang version 14.0.6 flex 2.6.4
  15    77.93 debian:13                     : Ok   gcc (Debian 14.2.0-19) 14.2.0 , Debian clang version 19.1.7 (3+b1) flex 2.6.4
  16    90.35 debian:experimental           : Ok   gcc (Debian 16.2.0-3) 16.2.0 , Debian clang version 21.1.8 (13) flex 2.6.4
  17     0.76 debian:experimental-x-arm64   : FAIL gcc version 16.2.0 (Debian 16.2.0-3)
  18     0.73 debian:experimental-x-mips    : FAIL gcc version 14.2.0 (Debian 14.2.0-13)
  19     0.73 debian:experimental-x-mips64  : FAIL gcc version 14.2.0 (Debian 14.2.0-13)
  20     0.73 debian:experimental-x-mipsel  : FAIL gcc version 14.2.0 (Debian 14.2.0-13)
  21    87.11 fedora:40                     : Ok   gcc (GCC) 14.2.1 20240912 (Red Hat 14.2.1-3) , clang version 18.1.8 (Fedora 18.1.8-2.fc40) flex 2.6.4
  22    85.68 fedora:41                     : Ok   gcc (GCC) 14.3.1 20251022 (Red Hat 14.3.1-4) , clang version 19.1.7 (Fedora 19.1.7-5.fc41) flex 2.6.4
  23    87.42 fedora:42                     : Ok   gcc (GCC) 15.2.1 20260123 (Red Hat 15.2.1-7) , clang version 20.1.8 (Fedora 20.1.8-4.fc42) flex 2.6.4
  24    84.77 fedora:43                     : Ok   gcc (GCC) 15.3.1 20260722 (Red Hat 15.3.1-1) , clang version 21.1.8 (Fedora 21.1.8-6.fc43) flex 2.6.4
  25    92.43 fedora:44                     : Ok   gcc (GCC) 16.2.1 20260819 (Red Hat 16.2.1-2) , clang version 22.1.8 (Fedora 22.1.8-4.fc44) flex 2.6.4
  26    86.94 fedora:45                     : Ok   gcc (GCC) 16.2.1 20260819 (Red Hat 16.2.1-2) , clang version 23.1.2 (Fedora 23.1.2-2.fc45) flex 2.6.4
  27    78.37 fedora:rawhide                : Ok   gcc (GCC) 16.2.1 20260819 (Red Hat 16.2.1-2) , clang version 23.1.3 (Fedora 23.1.3-1.fc46) flex 2.6.4
  28    38.57 gentoo:stage3                 : Ok   gcc (Gentoo 15.3.0 p8) 15.3.0  flex 2.6.4
  29   100.14 manjaro:base                  : Ok   gcc (GCC) 16.1.1 20260625 , clang version 22.1.6 flex 2.6.4
  30    93.15 opensuse:16.0                 : Ok   gcc (SUSE Linux) 15.3.0 , clang version 19.1.7 flex 2.6.4
  31    89.04 opensuse:tumbleweed           : Ok   gcc (SUSE Linux) 15.3.0 , clang version 22.1.8 flex 2.6.4
  32    74.08 oraclelinux:8                 : Ok   gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-28.0.1) , clang version 21.1.8 ( 21.1.8-1.module+el8.10.0+90887+a5269809) flex 2.6.1
  33    77.72 oraclelinux:9                 : Ok   gcc (GCC) 11.5.0 20240719 (Red Hat 11.5.0-14.0.1) , clang version 21.1.8 ( 21.1.8-2.el9) flex 2.6.4
  34    79.23 oraclelinux:10                : Ok   gcc (GCC) 14.3.1 20251022 (Red Hat 14.3.1-4.0.1) , clang version 21.1.8 (Oracle America 21.1.8-1.el10) flex 2.6.4
  35    75.95 rockylinux:8                  : Ok   gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-28) , clang version 21.1.8 (RESF 21.1.8-1.module+el8.10.0+40180+8e26bdb3) flex 2.6.1
  36    81.29 rockylinux:9                  : Ok   gcc (GCC) 11.5.0 20240719 (Red Hat 11.5.0-14) , clang version 21.1.8 (RESF 21.1.8-2.el9) flex 2.6.4
  37    77.09 rockylinux:10                 : Ok   gcc (GCC) 14.3.1 20251022 (Red Hat 14.3.1-4) , clang version 21.1.8 (RESF 21.1.8-1.el10) flex 2.6.4
  38    90.96 ubuntu:22.04                  : Ok   gcc (Ubuntu 11.4.0-1ubuntu1~22.04.3) 11.4.0 , Ubuntu clang version 14.0.0-1ubuntu1.1 flex 2.6.4
  39     0.89 ubuntu:22.04-x-riscv64        : FAIL gcc version 11.4.0 (Ubuntu 11.4.0-1ubuntu1~22.04)
  40    83.45 ubuntu:24.04                  : Ok   gcc (Ubuntu 13.3.0-6ubuntu2~24.04.1) 13.3.0 , Ubuntu clang version 18.1.3 (1ubuntu1) flex 2.6.4
  41    86.09 ubuntu:25.04                  : Ok   gcc (Ubuntu 14.2.0-19ubuntu2) 14.2.0 , Ubuntu clang version 20.1.2 (0ubuntu1) flex 2.6.4
  42    88.82 ubuntu:25.10                  : Ok   gcc (Ubuntu 15.2.0-4ubuntu4) 15.2.0 , Ubuntu clang version 20.1.8 (0ubuntu4) flex 2.6.4
  43    89.49 ubuntu:26.04                  : Ok   gcc (Ubuntu 15.2.0-16ubuntu1) 15.2.0 , Ubuntu clang version 21.1.8 (6ubuntu1) flex 2.6.4
BUILD_TARBALL_HEAD=cb9dba6f4764fc68ab75c36e332887332339f9c3
44 3296.37
toolsbuilder@five:~$
