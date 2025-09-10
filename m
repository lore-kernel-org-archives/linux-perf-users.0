Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E04212549
	for <linux-perf-users@vger.kernel.org>; Wed, 10 Sep 2025 15:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757516697; cv=none; b=XXYfL72NdXWjKpoBbXxoLW7buvpv/3y7istyyMTzBnIjlxCkbOfnwpr/cTMgeKAv11AmAfOa1z3dkKoyS2Snfe4fMxXW2sWF7akXyBzrQOPUkmit+wBbknWgxxeRmqP7t5zxti7oyKcpH071cfOnWbzsVm9zNcGKuIaa9LVzxTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757516697; c=relaxed/simple;
	bh=zVhN9KwrjTrL0YWCbze+RiFICQMrIXK0k0lLc9Yva8c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WXRLmRZnDUgkuFriFG2zKVouWZxphfEeGY2f/Y+3J+wpyz91Kh1z2d5ziNMsBljN2OkOpFl1u1e/SRWiBRePTmMYC1YJSEp+JWAKmLaAEHdkr0xJQ2FvsNGtaBpv4dU03KuEdJRKEoZ4oNp/nvrgjUpQnzyXKBW6l02Up5pFfXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Cni7WMUB; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Cni7WMUB"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-24cf5bcfb60so199935ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 10 Sep 2025 08:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757516695; x=1758121495; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uMRSBFnuovkLCWlp7ry1NMmUF7tLcce0vVKbF+vi614=;
        b=Cni7WMUBnpWdvgsFbF5geVmRjTAWNCFMzmg0hYte5HIspgeOk/jmEJWl2kD4/Cso3Z
         w04NujJO9xfBZ8ziMVlVPeBZhH3pr4ocQxaCJFL+zceAUfA3t9QlL6djCvaTgIpXjWCT
         MV2IvHYuMEjzDcGUyhhaNXhK5N6szxphcA0LmgKtV0FaYJdMpUOlaKvBAWKppKLs6XCA
         8A9GBtD9AaQ3wiJCGluXra++d71aGY7xdGir5aBEc/5IA47cmIpMxRQNisH/qk+h8J0k
         MBN+Qbee0c/9Basa5RjOU0Cm8v9Mjau8BpvcnpQPqYAxNJx0uttrJw0Z6hgZsin2373X
         D/og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757516695; x=1758121495;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uMRSBFnuovkLCWlp7ry1NMmUF7tLcce0vVKbF+vi614=;
        b=qM08Sz2onhmpoKy/+qIHkHnKWAtaaYABAOjaAJA4OabNN3A47i5nfVnNBbdJ6qe8AP
         cne2n6oB0R/lPbJUF+GcEQXu3Kz7EgbW+5egiskm5eqV1UwTgl95Ko1e0Dqil0Bihkhe
         c0AjpXd9+paMncgrLR04gd5ym8BisImb5EwwssZE4NFtZkF+w8DbTEDAUZYilhhoTj/u
         4xFlZ3QfbnmGR8OnyxAPilUTwNXPITk75xxgDor89MsXdmmtfuqLKk5yK6gENrXBx0PK
         0I0jYGK4gAUir96Xc/kGFGgmw4QMjkugd46GkUON0es3vlCghY+awt8FAJL76s0caBHH
         6ScQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvlcFwLOSlcKzFYqd0OaPsbCw5aR5Lp/OOdVH01vbDv6xstjgxXyFv4kFbsfyA1lqTwq6zJu1b6NlmDqVmlkJT@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl40p9ZtdITZ7AB8+rWnYFlq5iPyAr+QfOfFYkLmcB7z/zf8D9
	bmgW+2UhO5RAoovu+5wjTRUkn8IersZ1trFwlofbjI7UkbSrgLuCTXA77f6jovC7wfgWzj9HpoD
	UnvjDGGpt2vfCreaO4vpWcRjVqcEaI0hNVbmKA56R
X-Gm-Gg: ASbGncviGZizA1q14EpYM+rV3WXwI4+rvYy9juqs70G2nGURoS6Qm7gstBRwz4tKbEC
	mTK0nWf0ZyLP+zftVK5cAgWvIRSM8wxHVe/UEXKUVgYtmH6YBELOSxFt77MaS0t6WLUs6GWU5h4
	M3UyyXP3Pb3bCiqyRE+oiOGcVwYDF2mDMtuiHOcTnDziPEPumm12fq7ELaizX5tdDo6dfe0sYQy
	pDFBcz6hrFUzvl9womkEFVjm2RKrBcQC6w4ZvHl6LYPGwXVV2nD0/Y=
X-Google-Smtp-Source: AGHT+IHjHK57+H0MwRrCJKavMZM9zEHegCRYZnpvioF5uadVg0iUfh9fxzk+VDqbznw0zNVO6BTHbLgR3CI0s2L1Hh4=
X-Received: by 2002:a17:902:e743:b0:234:bfa1:da3e with SMTP id
 d9443c01a7336-25a7eafc1cfmr4337455ad.5.1757516694454; Wed, 10 Sep 2025
 08:04:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250701201027.1171561-3-namhyung@kernel.org> <20250909094953.106706-1-amadio@gentoo.org>
 <CAP-5=fVCeBz+hgCsctCe7BByaL7GqKVUbDcW4R=2th0C1O0m0w@mail.gmail.com> <aMF0iWh4yTK5KwcJ@gentoo.org>
In-Reply-To: <aMF0iWh4yTK5KwcJ@gentoo.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 10 Sep 2025 08:04:42 -0700
X-Gm-Features: Ac12FXxQD4R_hEvT9DrWrjZXbBqObDt33sDkyVVXtekNBm1m971ECztnjUlcUXg
Message-ID: <CAP-5=fV8p7u9zfYAWJ8zt=Dq53u-b3pNzD9ve2HabJ9_qjymhw@mail.gmail.com>
Subject: Re: perf --help triggers an assertion
To: Guilherme Amadio <amadio@gentoo.org>
Cc: namhyung@kernel.org, acme@kernel.org, adrian.hunter@intel.com, 
	jolsa@kernel.org, kan.liang@linux.intel.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@kernel.org, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025 at 5:52=E2=80=AFAM Guilherme Amadio <amadio@gentoo.org=
> wrote:
>
> On Tue, Sep 09, 2025 at 11:31:51AM -0700, Ian Rogers wrote:
> > On Tue, Sep 9, 2025 at 2:49=E2=80=AFAM Guilherme Amadio <amadio@gentoo.=
org> wrote:
> > >
> > > Hi Namhyung,
> > >
> > > I was updating perf's package in Gentoo Linux and noticed some proble=
ms
> > > which were not there before. I tested with the version below and the =
problem
> > > still seems to be there. perf --help triggers an assertion (see below=
).
> > > Looking in the list, it seems related to the patch below:
> > >
> > > https://lore.kernel.org/linux-perf-users/20250701201027.1171561-3-nam=
hyung@kernel.org/
> > >
> > > Cheers,
> > > -Guilherme
> > >
> > > The problem:
> > >
> > > gentoo perf $ ./perf --help
> > > perf: help.c:104: exclude_cmds: Assertion `cmds->names[ci] =3D=3D NUL=
L' failed.
> > > Aborted                    (core dumped) ./perf --help
> > >
> > > Some extra information:
> > >
> > > gentoo perf $ ./perf version
> > > perf version 6.17.rc5.gf777d1112ee5
> > > gentoo perf $ ./perf test subcmd
> > >  69: libsubcmd help tests                                            =
:
> > >  69.1: Load subcmd names                                             =
: Ok
> > >  69.2: Uniquify subcmd names                                         =
: Ok
> > >  69.3: Exclude duplicate subcmd names                                =
: Ok
> > > gentoo perf $ ./perf bad-command
> > > perf: 'bad-command' is not a perf-command. See 'perf --help'.
> > > gentoo perf $ ./perf --help
> > > perf: help.c:104: exclude_cmds: Assertion `cmds->names[ci] =3D=3D NUL=
L' failed.
> > > Aborted                    (core dumped) ./perf --help
> > > gentoo perf $ gdb run --args ./perf --help
> > > GNU gdb (Gentoo 16.3 vanilla) 16.3
> > > Copyright (C) 2024 Free Software Foundation, Inc.
> > > License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/g=
pl.html>
> > > This is free software: you are free to change and redistribute it.
> > > There is NO WARRANTY, to the extent permitted by law.
> > > Type "show copying" and "show warranty" for details.
> > > This GDB was configured as "x86_64-pc-linux-gnu".
> > > Type "show configuration" for configuration details.
> > > For bug reporting instructions, please see:
> > > <https://bugs.gentoo.org/>.
> > > Find the GDB manual and other documentation resources online at:
> > >     <http://www.gnu.org/software/gdb/documentation/>.
> > >
> > > For help, type "help".
> > > Type "apropos word" to search for commands related to "word"...
> > > Reading symbols from ./perf...
> > > (gdb) run
> > > Starting program: /home/amadio/src/linux/tools/perf/perf --help
> > > [Thread debugging using libthread_db enabled]
> > > Using host libthread_db library "/usr/lib64/libthread_db.so.1".
> > > perf: help.c:104: exclude_cmds: Assertion `cmds->names[ci] =3D=3D NUL=
L' failed.
> > >
> > > Program received signal SIGABRT, Aborted.
> > > __pthread_kill_implementation (threadid=3D<optimized out>, signo=3Dsi=
gno@entry=3D6, no_tid=3Dno_tid@entry=3D0) at pthread_kill.c:44
> > > 44            return INTERNAL_SYSCALL_ERROR_P (ret) ? INTERNAL_SYSCAL=
L_ERRNO (ret) : 0;
> > > (gdb) bt
> > > #0  __pthread_kill_implementation (threadid=3D<optimized out>, signo=
=3Dsigno@entry=3D6, no_tid=3Dno_tid@entry=3D0) at pthread_kill.c:44
> > > #1  0x00007ffff74c1656 in __pthread_kill_internal (threadid=3D<optimi=
zed out>, signo=3Dsigno@entry=3D6) at pthread_kill.c:89
> > > #2  0x00007ffff74c166d in __GI___pthread_kill (threadid=3D<optimized =
out>, signo=3Dsigno@entry=3D6) at pthread_kill.c:100
> > > #3  0x00007ffff747509c in __GI_raise (sig=3Dsig@entry=3D6) at ../sysd=
eps/posix/raise.c:26
> > > #4  0x00007ffff747637e in __GI_abort () at abort.c:77
> > > #5  0x00007ffff746e023 in __assert_fail_base (fmt=3D<optimized out>, =
assertion=3Dassertion@entry=3D0x555555974d03 "cmds->names[ci] =3D=3D NULL",
> > >     file=3Dfile@entry=3D0x555555974cfc "help.c", line=3Dline@entry=3D=
104, function=3Dfunction@entry=3D0x555555974dc8 <__PRETTY_FUNCTION__.0> "ex=
clude_cmds")
> > >     at assert.c:118
> > > #6  0x00007ffff746e075 in __assert_fail (assertion=3D0x555555974d03 "=
cmds->names[ci] =3D=3D NULL", file=3D0x555555974cfc "help.c", line=3D104,
> > >     function=3D0x555555974dc8 <__PRETTY_FUNCTION__.0> "exclude_cmds")=
 at assert.c:127
> > > #7  0x0000555555693813 in exclude_cmds (cmds=3D0x55555614e5e0 <other_=
cmds>, excludes=3D0x55555614e5c0 <main_cmds>) at help.c:104
> > > #8  0x0000555555693eb3 in load_command_list (prefix=3D0x555555954071 =
"perf-", main_cmds=3D0x55555614e5c0 <main_cmds>,
> > >     other_cmds=3D0x55555614e5e0 <other_cmds>) at help.c:252
> > > #9  0x00005555555e9987 in cmd_help (argc=3D1, argv=3D0x7fffffffd1a0) =
at builtin-help.c:458
> > > #10 0x0000555555685d45 in run_builtin (p=3D0x555556130de0 <commands+1=
92>, argc=3D1, argv=3D0x7fffffffd1a0) at perf.c:349
> > > #11 0x0000555555685fe1 in handle_internal_command (argc=3D1, argv=3D0=
x7fffffffd1a0) at perf.c:401
> > > #12 0x0000555555686142 in run_argv (argcp=3D0x7fffffffcfac, argv=3D0x=
7fffffffcfa0) at perf.c:445
> > > #13 0x0000555555686493 in main (argc=3D1, argv=3D0x7fffffffd1a0) at p=
erf.c:553
> > > (gdb) quit
> >
> > Thanks Guilherme,
> >
> > I tried to reproduce the same version with various options: DEBUG=3D1
> > -UNDEBUG in EXTRA_CFLAGS, -fsanitize=3Daddress. Being in various
> > directories with "perf-" prefixed files. I'm afraid I wasn't able to
> > reproduce. The assert is trying to avoid a memory leak, so
> > non-critical, and I couldn't in a quick inspection eye-ball an issue.
> > Without getting a reproduction I don't think I can make progress with
> > the issue.
>
> I do not have any special setup on my machine (if you consider Gentoo
> not special, of course). I just did a git bisect and arrived at commit
> 9401d1771dad99bfc795dd2ae0c292343fd1f78d, which is the commit I linked
> above. I used
>
> $ make -C tools/perf clean && make -B -j16 -C tools/perf DEBUG=3D1 WERROR=
=3D0 NO_SHELLCHECK=3D1
>
> then called perf --help each time (but perf help record or equivalent
> also triggers the assertion). I'm using GCC 14 on a 3950X. The features
> I have enabled and installed dependencies are below. This patch has been
> backported to at least 6.12 stable, and I can reproduce this with
> v6.12.45.
>
> gentoo linux $ tools/perf/perf version --build-options
> perf version 6.16.g45effee4b85a
>                    aio: [ on  ]  # HAVE_AIO_SUPPORT
>                    bpf: [ on  ]  # HAVE_LIBBPF_SUPPORT
>          bpf_skeletons: [ on  ]  # HAVE_BPF_SKEL
>             debuginfod: [ on  ]  # HAVE_DEBUGINFOD_SUPPORT
>                  dwarf: [ on  ]  # HAVE_LIBDW_SUPPORT
>     dwarf_getlocations: [ on  ]  # HAVE_LIBDW_SUPPORT
>           dwarf-unwind: [ on  ]  # HAVE_DWARF_UNWIND_SUPPORT
>               auxtrace: [ on  ]  # HAVE_AUXTRACE_SUPPORT
>                 libbfd: [ OFF ]  # HAVE_LIBBFD_SUPPORT ( tip: Deprecated,=
 license incompatibility, use BUILD_NONDISTRO=3D1 and install binutils-dev[=
el] )
>            libcapstone: [ on  ]  # HAVE_LIBCAPSTONE_SUPPORT
>              libcrypto: [ on  ]  # HAVE_LIBCRYPTO_SUPPORT
>     libdw-dwarf-unwind: [ on  ]  # HAVE_LIBDW_SUPPORT
>                 libelf: [ on  ]  # HAVE_LIBELF_SUPPORT
>                libnuma: [ on  ]  # HAVE_LIBNUMA_SUPPORT
>             libopencsd: [ OFF ]  # HAVE_CSTRACE_SUPPORT
>                libperl: [ on  ]  # HAVE_LIBPERL_SUPPORT
>                libpfm4: [ on  ]  # HAVE_LIBPFM
>              libpython: [ on  ]  # HAVE_LIBPYTHON_SUPPORT
>               libslang: [ on  ]  # HAVE_SLANG_SUPPORT
>          libtraceevent: [ on  ]  # HAVE_LIBTRACEEVENT
>              libunwind: [ OFF ]  # HAVE_LIBUNWIND_SUPPORT ( tip: Deprecat=
ed, use LIBUNWIND=3D1 and install libunwind-dev[el] to build with it )
>                   lzma: [ on  ]  # HAVE_LZMA_SUPPORT
> numa_num_possible_cpus: [ on  ]  # HAVE_LIBNUMA_SUPPORT
>                   zlib: [ on  ]  # HAVE_ZLIB_SUPPORT
>                   zstd: [ on  ]  # HAVE_ZSTD_SUPPORT
>
> And here are the version of all dependencies I have installed:
>
>  * dependency graph for dev-util/perf-6.16-r1
>  `--  dev-util/perf-6.16-r1
>    `--  dev-util/babeltrace-1.5.11
>    `--  dev-libs/libbpf-1.6.2
>    `--  dev-util/bpftool-7.6.0
>    `--  dev-util/pahole-1.30
>    `--  llvm-core/clang-18.1.8-r6
>    `--  llvm-core/llvm-18.1.8-r6
>    `--  llvm-core/clang-19.1.7
>    `--  llvm-core/llvm-19.1.7
>    `--  llvm-core/clang-20.1.8
>    `--  llvm-core/llvm-20.1.8
>    `--  llvm-core/clang-21.1.0
>    `--  llvm-core/llvm-21.1.0
>    `--  sys-libs/libcap-2.76
>    `--  dev-libs/capstone-5.0.6
>    `--  dev-libs/openssl-3.5.2
>    `--  x11-libs/gtk+-2.24.33-r3
>    `--  virtual/jre-21
>    `--  dev-libs/libpfm-4.13.0
>    `--  dev-libs/libtraceevent-1.8.4
>    `--  dev-libs/libtracefs-1.8.2
>    `--  app-arch/xz-utils-5.8.1-r1
>    `--  sys-process/numactl-2.0.19
>    `--  dev-lang/perl-5.42.0
>    `--  dev-lang/python-0.3.13.7
>    `--  dev-lang/python-0.3.14.0_rc2
>    `--  dev-lang/python-3.11.13_p1
>    `--  dev-lang/python-3.12.11_p1
>    `--  dev-lang/python-3.13.9999
>    `--  dev-lang/python-3.14.0_rc2
>    `--  sys-libs/slang-2.3.3-r1
>    `--  dev-debug/systemtap-5.3
>    `--  dev-util/google-perftools-2.17.2
>    `--  sys-libs/libunwind-1.8.2-r1
>    `--  app-arch/zstd-1.5.7-r1
>    `--  dev-libs/elfutils-0.193
>    `--  sys-libs/binutils-libs-2.45-r1
>    `--  sys-libs/zlib-1.3.1-r1
>    `--  virtual/libcrypt-2-r1
>    `--  sys-kernel/linux-headers-6.16
>    `--  virtual/jdk-21
>    `--  app-arch/tar-1.35
>    `--  dev-python/setuptools-80.9.0-r1
>    `--  app-alternatives/yacc-1-r2
>    `--  app-alternatives/lex-0-r1
>    `--  sys-apps/which-2.23
>    `--  virtual/pkgconfig-3
>    `--  app-text/asciidoc-10.2.1
>    `--  app-text/sgml-common-0.6.3-r7
>    `--  app-text/xmlto-0.0.28-r11
>    `--  sys-process/time-1.9-r1
>
> I hope that this helps with reproducing the problem, but if not, let me
> know which additional information you'd like to have and I will send it.
> My running kernel is 6.16.4, and glibc is version 2.42.

Thanks Guilherme,

There is also:
https://lore.kernel.org/lkml/CADHxFxSBKuKUWDvki9QDqc5jf1Y+k2EpvOnDsg8O09pZ1=
0n2NA@mail.gmail.com/
which may give me a reproduction. The fix there doesn't look right.
I'll try to find time to look into it again.

Thanks,
Ian
