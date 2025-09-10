Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886BB31AF33;
	Wed, 10 Sep 2025 12:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757508754; cv=none; b=m30AV6399QoHp6z0KjNlJhsddHTg3D8pX/OQCPH8QCKRsldNRTcijz4hnkwtkFQtgmGbmlY6gO6t1NMuM0qqonxvmYL6MerjxTn7HkeoJS40Rv2pwBkU8IyIuvn+fnFNbLpE0KMRWwTnVWtbCXaLkC82u2EEWnohAT4/3sKL9mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757508754; c=relaxed/simple;
	bh=ee7B3ZLWWj+PLQJDVUCLSsUTQ+aA/pB6s6Sn5kEfMUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L3Hnibz29Z6VsFArEF86KY7q0gOI0swTmbE3P64yEBUrWwVZ3tANqts0Jg4C6BduiIHPKE2MBnqQfOE98YcEvwa6q8+BQQXLHb2WRjvTUgXJIszy8K+19yaiwpOHxjOBngRloHq8ddVE+NvkyPo8TkLHkulvIFYC9Bgqwf/B1QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from gentoo.org (gentoo.cern.ch [IPv6:2001:1458:202:227::100:45])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: amadio)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 43C4F335DB4;
	Wed, 10 Sep 2025 12:52:30 +0000 (UTC)
Date: Wed, 10 Sep 2025 14:52:25 +0200
From: Guilherme Amadio <amadio@gentoo.org>
To: Ian Rogers <irogers@google.com>
Cc: namhyung@kernel.org, acme@kernel.org, adrian.hunter@intel.com,
	jolsa@kernel.org, kan.liang@linux.intel.com,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	mingo@kernel.org, peterz@infradead.org
Subject: Re: perf --help triggers an assertion
Message-ID: <aMF0iWh4yTK5KwcJ@gentoo.org>
References: <20250701201027.1171561-3-namhyung@kernel.org>
 <20250909094953.106706-1-amadio@gentoo.org>
 <CAP-5=fVCeBz+hgCsctCe7BByaL7GqKVUbDcW4R=2th0C1O0m0w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVCeBz+hgCsctCe7BByaL7GqKVUbDcW4R=2th0C1O0m0w@mail.gmail.com>

On Tue, Sep 09, 2025 at 11:31:51AM -0700, Ian Rogers wrote:
> On Tue, Sep 9, 2025 at 2:49 AM Guilherme Amadio <amadio@gentoo.org> wrote:
> >
> > Hi Namhyung,
> >
> > I was updating perf's package in Gentoo Linux and noticed some problems
> > which were not there before. I tested with the version below and the problem
> > still seems to be there. perf --help triggers an assertion (see below).
> > Looking in the list, it seems related to the patch below:
> >
> > https://lore.kernel.org/linux-perf-users/20250701201027.1171561-3-namhyung@kernel.org/
> >
> > Cheers,
> > -Guilherme
> >
> > The problem:
> >
> > gentoo perf $ ./perf --help
> > perf: help.c:104: exclude_cmds: Assertion `cmds->names[ci] == NULL' failed.
> > Aborted                    (core dumped) ./perf --help
> >
> > Some extra information:
> >
> > gentoo perf $ ./perf version
> > perf version 6.17.rc5.gf777d1112ee5
> > gentoo perf $ ./perf test subcmd
> >  69: libsubcmd help tests                                            :
> >  69.1: Load subcmd names                                             : Ok
> >  69.2: Uniquify subcmd names                                         : Ok
> >  69.3: Exclude duplicate subcmd names                                : Ok
> > gentoo perf $ ./perf bad-command
> > perf: 'bad-command' is not a perf-command. See 'perf --help'.
> > gentoo perf $ ./perf --help
> > perf: help.c:104: exclude_cmds: Assertion `cmds->names[ci] == NULL' failed.
> > Aborted                    (core dumped) ./perf --help
> > gentoo perf $ gdb run --args ./perf --help
> > GNU gdb (Gentoo 16.3 vanilla) 16.3
> > Copyright (C) 2024 Free Software Foundation, Inc.
> > License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
> > This is free software: you are free to change and redistribute it.
> > There is NO WARRANTY, to the extent permitted by law.
> > Type "show copying" and "show warranty" for details.
> > This GDB was configured as "x86_64-pc-linux-gnu".
> > Type "show configuration" for configuration details.
> > For bug reporting instructions, please see:
> > <https://bugs.gentoo.org/>.
> > Find the GDB manual and other documentation resources online at:
> >     <http://www.gnu.org/software/gdb/documentation/>.
> >
> > For help, type "help".
> > Type "apropos word" to search for commands related to "word"...
> > Reading symbols from ./perf...
> > (gdb) run
> > Starting program: /home/amadio/src/linux/tools/perf/perf --help
> > [Thread debugging using libthread_db enabled]
> > Using host libthread_db library "/usr/lib64/libthread_db.so.1".
> > perf: help.c:104: exclude_cmds: Assertion `cmds->names[ci] == NULL' failed.
> >
> > Program received signal SIGABRT, Aborted.
> > __pthread_kill_implementation (threadid=<optimized out>, signo=signo@entry=6, no_tid=no_tid@entry=0) at pthread_kill.c:44
> > 44            return INTERNAL_SYSCALL_ERROR_P (ret) ? INTERNAL_SYSCALL_ERRNO (ret) : 0;
> > (gdb) bt
> > #0  __pthread_kill_implementation (threadid=<optimized out>, signo=signo@entry=6, no_tid=no_tid@entry=0) at pthread_kill.c:44
> > #1  0x00007ffff74c1656 in __pthread_kill_internal (threadid=<optimized out>, signo=signo@entry=6) at pthread_kill.c:89
> > #2  0x00007ffff74c166d in __GI___pthread_kill (threadid=<optimized out>, signo=signo@entry=6) at pthread_kill.c:100
> > #3  0x00007ffff747509c in __GI_raise (sig=sig@entry=6) at ../sysdeps/posix/raise.c:26
> > #4  0x00007ffff747637e in __GI_abort () at abort.c:77
> > #5  0x00007ffff746e023 in __assert_fail_base (fmt=<optimized out>, assertion=assertion@entry=0x555555974d03 "cmds->names[ci] == NULL",
> >     file=file@entry=0x555555974cfc "help.c", line=line@entry=104, function=function@entry=0x555555974dc8 <__PRETTY_FUNCTION__.0> "exclude_cmds")
> >     at assert.c:118
> > #6  0x00007ffff746e075 in __assert_fail (assertion=0x555555974d03 "cmds->names[ci] == NULL", file=0x555555974cfc "help.c", line=104,
> >     function=0x555555974dc8 <__PRETTY_FUNCTION__.0> "exclude_cmds") at assert.c:127
> > #7  0x0000555555693813 in exclude_cmds (cmds=0x55555614e5e0 <other_cmds>, excludes=0x55555614e5c0 <main_cmds>) at help.c:104
> > #8  0x0000555555693eb3 in load_command_list (prefix=0x555555954071 "perf-", main_cmds=0x55555614e5c0 <main_cmds>,
> >     other_cmds=0x55555614e5e0 <other_cmds>) at help.c:252
> > #9  0x00005555555e9987 in cmd_help (argc=1, argv=0x7fffffffd1a0) at builtin-help.c:458
> > #10 0x0000555555685d45 in run_builtin (p=0x555556130de0 <commands+192>, argc=1, argv=0x7fffffffd1a0) at perf.c:349
> > #11 0x0000555555685fe1 in handle_internal_command (argc=1, argv=0x7fffffffd1a0) at perf.c:401
> > #12 0x0000555555686142 in run_argv (argcp=0x7fffffffcfac, argv=0x7fffffffcfa0) at perf.c:445
> > #13 0x0000555555686493 in main (argc=1, argv=0x7fffffffd1a0) at perf.c:553
> > (gdb) quit
> 
> Thanks Guilherme,
> 
> I tried to reproduce the same version with various options: DEBUG=1
> -UNDEBUG in EXTRA_CFLAGS, -fsanitize=address. Being in various
> directories with "perf-" prefixed files. I'm afraid I wasn't able to
> reproduce. The assert is trying to avoid a memory leak, so
> non-critical, and I couldn't in a quick inspection eye-ball an issue.
> Without getting a reproduction I don't think I can make progress with
> the issue.

I do not have any special setup on my machine (if you consider Gentoo
not special, of course). I just did a git bisect and arrived at commit
9401d1771dad99bfc795dd2ae0c292343fd1f78d, which is the commit I linked
above. I used

$ make -C tools/perf clean && make -B -j16 -C tools/perf DEBUG=1 WERROR=0 NO_SHELLCHECK=1

then called perf --help each time (but perf help record or equivalent
also triggers the assertion). I'm using GCC 14 on a 3950X. The features
I have enabled and installed dependencies are below. This patch has been
backported to at least 6.12 stable, and I can reproduce this with
v6.12.45.

gentoo linux $ tools/perf/perf version --build-options
perf version 6.16.g45effee4b85a
                   aio: [ on  ]  # HAVE_AIO_SUPPORT
                   bpf: [ on  ]  # HAVE_LIBBPF_SUPPORT
         bpf_skeletons: [ on  ]  # HAVE_BPF_SKEL
            debuginfod: [ on  ]  # HAVE_DEBUGINFOD_SUPPORT
                 dwarf: [ on  ]  # HAVE_LIBDW_SUPPORT
    dwarf_getlocations: [ on  ]  # HAVE_LIBDW_SUPPORT
          dwarf-unwind: [ on  ]  # HAVE_DWARF_UNWIND_SUPPORT
              auxtrace: [ on  ]  # HAVE_AUXTRACE_SUPPORT
                libbfd: [ OFF ]  # HAVE_LIBBFD_SUPPORT ( tip: Deprecated, license incompatibility, use BUILD_NONDISTRO=1 and install binutils-dev[el] )
           libcapstone: [ on  ]  # HAVE_LIBCAPSTONE_SUPPORT
             libcrypto: [ on  ]  # HAVE_LIBCRYPTO_SUPPORT
    libdw-dwarf-unwind: [ on  ]  # HAVE_LIBDW_SUPPORT
                libelf: [ on  ]  # HAVE_LIBELF_SUPPORT
               libnuma: [ on  ]  # HAVE_LIBNUMA_SUPPORT
            libopencsd: [ OFF ]  # HAVE_CSTRACE_SUPPORT
               libperl: [ on  ]  # HAVE_LIBPERL_SUPPORT
               libpfm4: [ on  ]  # HAVE_LIBPFM
             libpython: [ on  ]  # HAVE_LIBPYTHON_SUPPORT
              libslang: [ on  ]  # HAVE_SLANG_SUPPORT
         libtraceevent: [ on  ]  # HAVE_LIBTRACEEVENT
             libunwind: [ OFF ]  # HAVE_LIBUNWIND_SUPPORT ( tip: Deprecated, use LIBUNWIND=1 and install libunwind-dev[el] to build with it )
                  lzma: [ on  ]  # HAVE_LZMA_SUPPORT
numa_num_possible_cpus: [ on  ]  # HAVE_LIBNUMA_SUPPORT
                  zlib: [ on  ]  # HAVE_ZLIB_SUPPORT
                  zstd: [ on  ]  # HAVE_ZSTD_SUPPORT

And here are the version of all dependencies I have installed:

 * dependency graph for dev-util/perf-6.16-r1
 `--  dev-util/perf-6.16-r1
   `--  dev-util/babeltrace-1.5.11
   `--  dev-libs/libbpf-1.6.2
   `--  dev-util/bpftool-7.6.0
   `--  dev-util/pahole-1.30
   `--  llvm-core/clang-18.1.8-r6
   `--  llvm-core/llvm-18.1.8-r6
   `--  llvm-core/clang-19.1.7
   `--  llvm-core/llvm-19.1.7
   `--  llvm-core/clang-20.1.8
   `--  llvm-core/llvm-20.1.8
   `--  llvm-core/clang-21.1.0
   `--  llvm-core/llvm-21.1.0
   `--  sys-libs/libcap-2.76
   `--  dev-libs/capstone-5.0.6
   `--  dev-libs/openssl-3.5.2
   `--  x11-libs/gtk+-2.24.33-r3
   `--  virtual/jre-21
   `--  dev-libs/libpfm-4.13.0
   `--  dev-libs/libtraceevent-1.8.4
   `--  dev-libs/libtracefs-1.8.2
   `--  app-arch/xz-utils-5.8.1-r1
   `--  sys-process/numactl-2.0.19
   `--  dev-lang/perl-5.42.0
   `--  dev-lang/python-0.3.13.7
   `--  dev-lang/python-0.3.14.0_rc2
   `--  dev-lang/python-3.11.13_p1
   `--  dev-lang/python-3.12.11_p1
   `--  dev-lang/python-3.13.9999
   `--  dev-lang/python-3.14.0_rc2
   `--  sys-libs/slang-2.3.3-r1
   `--  dev-debug/systemtap-5.3
   `--  dev-util/google-perftools-2.17.2
   `--  sys-libs/libunwind-1.8.2-r1
   `--  app-arch/zstd-1.5.7-r1
   `--  dev-libs/elfutils-0.193
   `--  sys-libs/binutils-libs-2.45-r1
   `--  sys-libs/zlib-1.3.1-r1
   `--  virtual/libcrypt-2-r1
   `--  sys-kernel/linux-headers-6.16
   `--  virtual/jdk-21
   `--  app-arch/tar-1.35
   `--  dev-python/setuptools-80.9.0-r1
   `--  app-alternatives/yacc-1-r2
   `--  app-alternatives/lex-0-r1
   `--  sys-apps/which-2.23
   `--  virtual/pkgconfig-3
   `--  app-text/asciidoc-10.2.1
   `--  app-text/sgml-common-0.6.3-r7
   `--  app-text/xmlto-0.0.28-r11
   `--  sys-process/time-1.9-r1

I hope that this helps with reproducing the problem, but if not, let me
know which additional information you'd like to have and I will send it.
My running kernel is 6.16.4, and glibc is version 2.42.

Best regards,
-Guilherme
