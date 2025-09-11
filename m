Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E1E2DC784;
	Thu, 11 Sep 2025 20:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757620976; cv=none; b=G1B3muWSNwai4stPsl3RaU1lOFImm40CJVn2/ueDgS9/NbLX+qSFEGdutsVFsP7LkCUg14H2RLYYVZbLJM8CfNK+0Uz4FoS2C0R9R1SViFfDFfg2H9Oio6Xhw6hVdV8KqOdk9On/ppBXUrhnOh7xhnTgLgx0OpTADUn/eYRFIfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757620976; c=relaxed/simple;
	bh=3KJhUTZStrKSNw941DcrJQXDDDDh7YHFRcDvZTwrj1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QZ2lUgqW5NHSRsHKCBDxf04FOsqKpQLewH8L/yNISx8PGUE5cRRXkmC3CeO3Y3PY5R4JBwZC3dCo314P/PA0b+ZQg2PimrV3Zu1jYYisHFDoW/3agVvUS1oq+9iCQDblz2mGq8K/wsQEYMQQW6hEfP810o7IxxpyhqQzsM+LXKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CMH8itYR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CMH8itYR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 702D6C4CEF5;
	Thu, 11 Sep 2025 20:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757620975;
	bh=3KJhUTZStrKSNw941DcrJQXDDDDh7YHFRcDvZTwrj1g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CMH8itYRgBG1MobCioEwJ5oRa52f8eQAXGM/N4UGIjGzKVcjkm7VAMMeQP2qwY7GF
	 KW44gg9IDund728mY1HPtSi117F75T/3yGlxjyu9s9tIhJ9t7GekxDjNjRXBHMw8cv
	 CiSbffBqQCm5V/XyNYfSQ1FFssflGZQaQubGDYAc8G0ggqDKxv9bKkqLdB/bImtm2b
	 B9UHskwI7qfOGolZwDb/8uTw8x4WidAgv+3YRzqV5UGN7RlAHbY1Lx/y8DlmtbQ5XC
	 S739yrirILjjbjFRKTJopkHvtA7Ub5PlISXDWBfIy9t9dSfmTMJWCtx5l8mx0Xhurk
	 Iqizo4Byg9+BA==
Date: Thu, 11 Sep 2025 17:02:52 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Guilherme Amadio <amadio@gentoo.org>
Cc: Ian Rogers <irogers@google.com>, namhyung@kernel.org,
	adrian.hunter@intel.com, jolsa@kernel.org,
	kan.liang@linux.intel.com, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, mingo@kernel.org,
	peterz@infradead.org
Subject: Re: perf --help triggers an assertion
Message-ID: <aMMq7I5TBoL7SX6z@x1>
References: <20250701201027.1171561-3-namhyung@kernel.org>
 <20250909094953.106706-1-amadio@gentoo.org>
 <CAP-5=fVCeBz+hgCsctCe7BByaL7GqKVUbDcW4R=2th0C1O0m0w@mail.gmail.com>
 <aMF0iWh4yTK5KwcJ@gentoo.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aMF0iWh4yTK5KwcJ@gentoo.org>

On Wed, Sep 10, 2025 at 02:52:25PM +0200, Guilherme Amadio wrote:
> On Tue, Sep 09, 2025 at 11:31:51AM -0700, Ian Rogers wrote:
> > On Tue, Sep 9, 2025 at 2:49 AM Guilherme Amadio <amadio@gentoo.org> wrote:
> > > I was updating perf's package in Gentoo Linux and noticed some problems
> > > which were not there before. I tested with the version below and the problem
> > > still seems to be there. perf --help triggers an assertion (see below).
> > > Looking in the list, it seems related to the patch below:

> > > https://lore.kernel.org/linux-perf-users/20250701201027.1171561-3-namhyung@kernel.org/

<SNIP>

> > I tried to reproduce the same version with various options: DEBUG=1
> > -UNDEBUG in EXTRA_CFLAGS, -fsanitize=address. Being in various
> > directories with "perf-" prefixed files. I'm afraid I wasn't able to
> > reproduce. The assert is trying to avoid a memory leak, so
> > non-critical, and I couldn't in a quick inspection eye-ball an issue.
> > Without getting a reproduction I don't think I can make progress with
> > the issue.
 
> I do not have any special setup on my machine (if you consider Gentoo
> not special, of course). I just did a git bisect and arrived at commit
> 9401d1771dad99bfc795dd2ae0c292343fd1f78d, which is the commit I linked
> above. I used>

⬢ [acme@toolbx perf-tools-next]$ git show 9401d1771dad99bfc795dd2ae0c292343fd1f78d
fatal: bad object 9401d1771dad99bfc795dd2ae0c292343fd1f78d
⬢ [acme@toolbx perf-tools-next]$ 

Looking for the patch title I got to this one:

commit 1fdf938168c4d26fa279d4f204768690d1f9c4ae
Author: Namhyung Kim <namhyung@kernel.org>
Date:   Tue Jul 1 13:10:27 2025 -0700

    perf tools: Fix use-after-free in help_unknown_cmd()

?

- Arnaldo
 
> $ make -C tools/perf clean && make -B -j16 -C tools/perf DEBUG=1 WERROR=0 NO_SHELLCHECK=1
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
>                 libbfd: [ OFF ]  # HAVE_LIBBFD_SUPPORT ( tip: Deprecated, license incompatibility, use BUILD_NONDISTRO=1 and install binutils-dev[el] )
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
>              libunwind: [ OFF ]  # HAVE_LIBUNWIND_SUPPORT ( tip: Deprecated, use LIBUNWIND=1 and install libunwind-dev[el] to build with it )
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
> 
> Best regards,
> -Guilherme
