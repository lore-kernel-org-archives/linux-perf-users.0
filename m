Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9348E12B17C;
	Thu, 13 Mar 2025 07:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741849903; cv=none; b=BObsDkaWHZ93cI9rXvCHzPxPJqiN9JLpX7niC5U7S7tMeG8wdn3bHTUsNDBWtOzT2nQvweqhJEuZsGtvPwEo2vw5fy9y0sm5m6m8YVejfWgFC8wAY1r5RNhxl3wBTlYkqxSnhNP8OrPP4TfaxpkMxBkJg5Z+8H9jCFOGvPAO9Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741849903; c=relaxed/simple;
	bh=q9Dl0FHGQmih4lZVAN04K/wTRrdLBiM11KRo6Ki9rEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CjByOSmHf83lyB598VUvH++8IVAU5uAG/nCJD8V1/HQHVV089p+Z/z8F5JzQ3BztfBoGPpXOFgDCFraDXale+N6YW7omHbkqWlOrhxpCaRgBBDYsIshc6t6DBQCWdenA3h1v6FCtLPqfU/k15TCWcSG/tErq6wXvPNVzeEKMW04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WDH4wrX2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WDH4wrX2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01A1CC4CEDD;
	Thu, 13 Mar 2025 07:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741849903;
	bh=q9Dl0FHGQmih4lZVAN04K/wTRrdLBiM11KRo6Ki9rEk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WDH4wrX262Bl/pXty7Tof6tDNbPo/AyqOM3f7eHVGWpenOwQUTomh+UZnLsJawuPR
	 etJaZfPdMuc2JgoqLqpKWXh0sxBRNitJhbu/SLtzHqyCU8nynYpyXGmi6Zjk8wR0TZ
	 mCF/amFQk+Y23iE0bNlSUeMXoTQifpX/TAycLijvkILamzG+uAAksftzSElsS6aJgr
	 HBuZHnCE6/zHROd/BVVoCoGRUEDfxJE2ZzXRV1fU26svGsncAxCvLdk6QqNvNdvXJY
	 plkWuxZdnoTsh9vDiR133bIBdp0M5znL3hRUR7tIj1DDFtDVCca9S47/7pg2GeM9B6
	 SynX5brK73BdQ==
Date: Thu, 13 Mar 2025 00:11:40 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
	guoren <guoren@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Bibo Mao <maobibo@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
	Howard Chu <howardchu95@gmail.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	"linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
	linux-riscv@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v5 00/11] perf: Support multiple system call tables in
 the build
Message-ID: <Z9KFLGpenwOP32q3@google.com>
References: <20250308003209.234114-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250308003209.234114-1-irogers@google.com>

On Fri, Mar 07, 2025 at 04:31:58PM -0800, Ian Rogers wrote:
> This work builds on the clean up of system call tables and removal of
> libaudit by Charlie Jenkins <charlie@rivosinc.com>.
> 
> The system call table in perf trace is used to map system call numbers
> to names and vice versa. Prior to these changes, a single table
> matching the perf binary's build was present. The table would be
> incorrect if tracing say a 32-bit binary from a 64-bit version of
> perf, the names and numbers wouldn't match.
> 
> Change the build so that a single system call file is built and the
> potentially multiple tables are identifiable from the ELF machine type
> of the process being examined. To determine the ELF machine type, the
> executable's maps are searched and the associated DSOs ELF headers are
> read. When this fails and when live, /proc/pid/exe's ELF header is
> read. Fallback to using the perf's binary type when unknown.

Now it works well for me!

  $ sudo ./perf trace a32.out
           ? (         ): a32.out/1267727  ... [continued]: execve())                                           = 0
           ? (         ): a32.out/1267727  ... [continued]: brk())                                              = 0x57f33000
       0.062 ( 0.003 ms): a32.out/1267727 access(filename: 0xf7f170cc, mode: R)                                 = -1 ENOENT (No such file or directory)
       0.070 ( 0.011 ms): a32.out/1267727 openat(dfd: CWD, filename: 0xf7f1347f, flags: RDONLY|CLOEXEC|LARGEFILE) = 3
       0.070 ( 0.023 ms): a32.out/1267727  ... [continued]: close())                                            = 0
       0.103 ( 0.009 ms): a32.out/1267727 openat(dfd: CWD, filename: 0xf7ee43e0, flags: RDONLY|CLOEXEC|LARGEFILE) = 3
       0.113 ( 0.002 ms): a32.out/1267727 read(fd: 3, buf: 0xff854990, count: 512)                              = 512
       0.113 ( 0.049 ms): a32.out/1267727  ... [continued]: close())                                            = 0
       0.113 ( 0.060 ms): a32.out/1267727  ... [continued]: set_tid_address())                                  = 1267727 (a32.out)
       0.175 ( 0.001 ms): a32.out/1267727 set_robust_list(head: 0xf7ee556c, len: 12)                            = 
       0.222 ( 0.005 ms): a32.out/1267727 mprotect(start: 0xf7ebc000, len: 8192, prot: READ)                    = 0
       0.230 ( 0.004 ms): a32.out/1267727 mprotect(start: 0x565b1000, len: 4096, prot: READ)                    = 0
       0.237 ( 0.003 ms): a32.out/1267727 mprotect(start: 0xf7f1f000, len: 8192, prot: READ)                    = 0
       0.258 ( 0.006 ms): a32.out/1267727 munmap(addr: 0xf7ec9000, len: 108298)                                 = 0
       0.258 ( 0.027 ms): a32.out/1267727  ... [continued]: brk())                                              = 0x57f33000
       0.258 ( 0.031 ms): a32.out/1267727  ... [continued]: brk())                                              = 0x57f54000
       0.258 ( 0.033 ms): a32.out/1267727  ... [continued]: brk())                                              = 0x57f55000
       0.296 ( 0.008 ms): a32.out/1267727 openat(dfd: CWD, filename: 0x565b000a)                                = 3
       0.316 ( 0.002 ms): a32.out/1267727 read(fd: 3, buf: 0xff8544a8, count: 4096)                             = 211
       0.319 ( 0.001 ms): a32.out/1267727 read(fd: 3, buf: 0x57f332e0, count: 4096)                             = 0
       0.319 ( 0.005 ms): a32.out/1267727  ... [continued]: close())                                            = 0
       0.319 ( 0.010 ms): a32.out/1267727  ... [continued]: brk())                                              = 0x57f54000
       0.337 (         ): a32.out/1267727 exit_group()                                                          = ?

Thanks,
Namhyung

> 
> Remove some runtime types used by the system call tables and make
> equivalents generated at build time.
> 
> v5: Add byte swap to dso__e_machine and fix comment as suggested by
>     Namhyung.
> 
> v4: Add reading the e_machine from the thread's maps dsos, only read
>     from /proc/pid/exe on failure and when live as requested by
>     Namhyung. Add patches to add dso comments and remove unused
>     dso_data variables that are unused without libunwind.
> 
> v3: Add Charlie's reviewed-by tags. Incorporate feedback from Arnd
>     Bergmann <arnd@arndb.de> on additional optional column and MIPS
>     system call numbering. Rebase past Namhyung's global system call
>     statistics and add comments that they don't yet support an
>     e_machine other than EM_HOST.
> 
> v2: Change the 1 element cache for the last table as suggested by
>     Howard Chu, add Howard's reviewed-by tags.
>     Add a comment and apology to Charlie for not doing better in
>     guiding:
>     https://lore.kernel.org/all/20250114-perf_syscall_arch_runtime-v1-1-5b304e408e11@rivosinc.com/
>     After discussion on v1 and he agreed this patch series would be
>     the better direction.
> 
> Ian Rogers (11):
>   perf dso: Move libunwind dso_data variables into ifdef
>   perf dso: kernel-doc for enum dso_binary_type
>   perf syscalltbl: Remove syscall_table.h
>   perf trace: Reorganize syscalls
>   perf syscalltbl: Remove struct syscalltbl
>   perf dso: Add support for reading the e_machine type for a dso
>   perf thread: Add support for reading the e_machine type for a thread
>   perf trace beauty: Add syscalltbl.sh generating all system call tables
>   perf syscalltbl: Use lookup table containing multiple architectures
>   perf build: Remove Makefile.syscalls
>   perf syscalltbl: Mask off ABI type for MIPS system calls
> 
>  tools/perf/Makefile.perf                      |  10 +-
>  tools/perf/arch/alpha/entry/syscalls/Kbuild   |   2 -
>  .../alpha/entry/syscalls/Makefile.syscalls    |   5 -
>  tools/perf/arch/alpha/include/syscall_table.h |   2 -
>  tools/perf/arch/arc/entry/syscalls/Kbuild     |   2 -
>  .../arch/arc/entry/syscalls/Makefile.syscalls |   3 -
>  tools/perf/arch/arc/include/syscall_table.h   |   2 -
>  tools/perf/arch/arm/entry/syscalls/Kbuild     |   4 -
>  .../arch/arm/entry/syscalls/Makefile.syscalls |   2 -
>  tools/perf/arch/arm/include/syscall_table.h   |   2 -
>  tools/perf/arch/arm64/entry/syscalls/Kbuild   |   3 -
>  .../arm64/entry/syscalls/Makefile.syscalls    |   6 -
>  tools/perf/arch/arm64/include/syscall_table.h |   8 -
>  tools/perf/arch/csky/entry/syscalls/Kbuild    |   2 -
>  .../csky/entry/syscalls/Makefile.syscalls     |   3 -
>  tools/perf/arch/csky/include/syscall_table.h  |   2 -
>  .../perf/arch/loongarch/entry/syscalls/Kbuild |   2 -
>  .../entry/syscalls/Makefile.syscalls          |   3 -
>  .../arch/loongarch/include/syscall_table.h    |   2 -
>  tools/perf/arch/mips/entry/syscalls/Kbuild    |   2 -
>  .../mips/entry/syscalls/Makefile.syscalls     |   5 -
>  tools/perf/arch/mips/include/syscall_table.h  |   2 -
>  tools/perf/arch/parisc/entry/syscalls/Kbuild  |   3 -
>  .../parisc/entry/syscalls/Makefile.syscalls   |   6 -
>  .../perf/arch/parisc/include/syscall_table.h  |   8 -
>  tools/perf/arch/powerpc/entry/syscalls/Kbuild |   3 -
>  .../powerpc/entry/syscalls/Makefile.syscalls  |   6 -
>  .../perf/arch/powerpc/include/syscall_table.h |   8 -
>  tools/perf/arch/riscv/entry/syscalls/Kbuild   |   2 -
>  .../riscv/entry/syscalls/Makefile.syscalls    |   4 -
>  tools/perf/arch/riscv/include/syscall_table.h |   8 -
>  tools/perf/arch/s390/entry/syscalls/Kbuild    |   2 -
>  .../s390/entry/syscalls/Makefile.syscalls     |   5 -
>  tools/perf/arch/s390/include/syscall_table.h  |   2 -
>  tools/perf/arch/sh/entry/syscalls/Kbuild      |   2 -
>  .../arch/sh/entry/syscalls/Makefile.syscalls  |   4 -
>  tools/perf/arch/sh/include/syscall_table.h    |   2 -
>  tools/perf/arch/sparc/entry/syscalls/Kbuild   |   3 -
>  .../sparc/entry/syscalls/Makefile.syscalls    |   5 -
>  tools/perf/arch/sparc/include/syscall_table.h |   8 -
>  tools/perf/arch/x86/entry/syscalls/Kbuild     |   3 -
>  .../arch/x86/entry/syscalls/Makefile.syscalls |   6 -
>  tools/perf/arch/x86/include/syscall_table.h   |   8 -
>  tools/perf/arch/xtensa/entry/syscalls/Kbuild  |   2 -
>  .../xtensa/entry/syscalls/Makefile.syscalls   |   4 -
>  .../perf/arch/xtensa/include/syscall_table.h  |   2 -
>  tools/perf/builtin-trace.c                    | 290 +++++++++++-------
>  tools/perf/scripts/Makefile.syscalls          |  61 ----
>  tools/perf/scripts/syscalltbl.sh              |  86 ------
>  tools/perf/trace/beauty/syscalltbl.sh         | 274 +++++++++++++++++
>  tools/perf/util/dso.c                         |  88 ++++++
>  tools/perf/util/dso.h                         |  58 ++++
>  tools/perf/util/symbol-elf.c                  |  27 --
>  tools/perf/util/syscalltbl.c                  | 148 ++++-----
>  tools/perf/util/syscalltbl.h                  |  22 +-
>  tools/perf/util/thread.c                      |  80 +++++
>  tools/perf/util/thread.h                      |  14 +-
>  57 files changed, 792 insertions(+), 536 deletions(-)
>  delete mode 100644 tools/perf/arch/alpha/entry/syscalls/Kbuild
>  delete mode 100644 tools/perf/arch/alpha/entry/syscalls/Makefile.syscalls
>  delete mode 100644 tools/perf/arch/alpha/include/syscall_table.h
>  delete mode 100644 tools/perf/arch/arc/entry/syscalls/Kbuild
>  delete mode 100644 tools/perf/arch/arc/entry/syscalls/Makefile.syscalls
>  delete mode 100644 tools/perf/arch/arc/include/syscall_table.h
>  delete mode 100644 tools/perf/arch/arm/entry/syscalls/Kbuild
>  delete mode 100644 tools/perf/arch/arm/entry/syscalls/Makefile.syscalls
>  delete mode 100644 tools/perf/arch/arm/include/syscall_table.h
>  delete mode 100644 tools/perf/arch/arm64/entry/syscalls/Kbuild
>  delete mode 100644 tools/perf/arch/arm64/entry/syscalls/Makefile.syscalls
>  delete mode 100644 tools/perf/arch/arm64/include/syscall_table.h
>  delete mode 100644 tools/perf/arch/csky/entry/syscalls/Kbuild
>  delete mode 100644 tools/perf/arch/csky/entry/syscalls/Makefile.syscalls
>  delete mode 100644 tools/perf/arch/csky/include/syscall_table.h
>  delete mode 100644 tools/perf/arch/loongarch/entry/syscalls/Kbuild
>  delete mode 100644 tools/perf/arch/loongarch/entry/syscalls/Makefile.syscalls
>  delete mode 100644 tools/perf/arch/loongarch/include/syscall_table.h
>  delete mode 100644 tools/perf/arch/mips/entry/syscalls/Kbuild
>  delete mode 100644 tools/perf/arch/mips/entry/syscalls/Makefile.syscalls
>  delete mode 100644 tools/perf/arch/mips/include/syscall_table.h
>  delete mode 100644 tools/perf/arch/parisc/entry/syscalls/Kbuild
>  delete mode 100644 tools/perf/arch/parisc/entry/syscalls/Makefile.syscalls
>  delete mode 100644 tools/perf/arch/parisc/include/syscall_table.h
>  delete mode 100644 tools/perf/arch/powerpc/entry/syscalls/Kbuild
>  delete mode 100644 tools/perf/arch/powerpc/entry/syscalls/Makefile.syscalls
>  delete mode 100644 tools/perf/arch/powerpc/include/syscall_table.h
>  delete mode 100644 tools/perf/arch/riscv/entry/syscalls/Kbuild
>  delete mode 100644 tools/perf/arch/riscv/entry/syscalls/Makefile.syscalls
>  delete mode 100644 tools/perf/arch/riscv/include/syscall_table.h
>  delete mode 100644 tools/perf/arch/s390/entry/syscalls/Kbuild
>  delete mode 100644 tools/perf/arch/s390/entry/syscalls/Makefile.syscalls
>  delete mode 100644 tools/perf/arch/s390/include/syscall_table.h
>  delete mode 100644 tools/perf/arch/sh/entry/syscalls/Kbuild
>  delete mode 100644 tools/perf/arch/sh/entry/syscalls/Makefile.syscalls
>  delete mode 100644 tools/perf/arch/sh/include/syscall_table.h
>  delete mode 100644 tools/perf/arch/sparc/entry/syscalls/Kbuild
>  delete mode 100644 tools/perf/arch/sparc/entry/syscalls/Makefile.syscalls
>  delete mode 100644 tools/perf/arch/sparc/include/syscall_table.h
>  delete mode 100644 tools/perf/arch/x86/entry/syscalls/Kbuild
>  delete mode 100644 tools/perf/arch/x86/entry/syscalls/Makefile.syscalls
>  delete mode 100644 tools/perf/arch/x86/include/syscall_table.h
>  delete mode 100644 tools/perf/arch/xtensa/entry/syscalls/Kbuild
>  delete mode 100644 tools/perf/arch/xtensa/entry/syscalls/Makefile.syscalls
>  delete mode 100644 tools/perf/arch/xtensa/include/syscall_table.h
>  delete mode 100644 tools/perf/scripts/Makefile.syscalls
>  delete mode 100755 tools/perf/scripts/syscalltbl.sh
>  create mode 100755 tools/perf/trace/beauty/syscalltbl.sh
> 
> -- 
> 2.49.0.rc0.332.g42c0ae87b1-goog
> 
