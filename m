Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884141F872D;
	Fri, 12 Sep 2025 11:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757676443; cv=none; b=eHmf1LCnbU89tyY+JV4wRGzCMT+3648txX3OvPxiSeloQYJv4LcO7iHwCLv4YOefBNZlDo4Nk5IE2zuZww4hASpAOYajvwYD17OXE1GfPg6vzHzD4SNOGG4tE5yJqwPh9oeh6UFMfmMIWXjrTnpsr0Lxh7+L2ZgIRE7yJiF96Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757676443; c=relaxed/simple;
	bh=/dMkzczY8UnVnYvuPQb4VMBZdkK2WuuUhRa8vJzNj9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HcROwJH4TTuk4veuQYuYJb95SSfIc+Aw51w+Yl7wvZwLpalL7NI0Mv9+qu2Q2G6z2EZz3udHm3sDGVsE7OhPhFA0x7PLKaw5OG0tt6wpYNkMNBbvIrMY3g5DKrBySJ3rgxyzWSOz/XsFJ7TMrLvKx4VbfaT8o3fAx1VrnpqyANc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from gentoo.org (gentoo.cern.ch [IPv6:2001:1458:202:227::100:45])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: amadio)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 3D0C4340DB0;
	Fri, 12 Sep 2025 11:27:19 +0000 (UTC)
Date: Fri, 12 Sep 2025 13:27:14 +0200
From: Guilherme Amadio <amadio@gentoo.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>, namhyung@kernel.org,
	adrian.hunter@intel.com, jolsa@kernel.org,
	kan.liang@linux.intel.com, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, mingo@kernel.org,
	peterz@infradead.org
Subject: Re: perf --help triggers an assertion
Message-ID: <aMQDkp8ewyxlX_8Z@gentoo.org>
References: <20250701201027.1171561-3-namhyung@kernel.org>
 <20250909094953.106706-1-amadio@gentoo.org>
 <CAP-5=fVCeBz+hgCsctCe7BByaL7GqKVUbDcW4R=2th0C1O0m0w@mail.gmail.com>
 <aMF0iWh4yTK5KwcJ@gentoo.org>
 <aMMq7I5TBoL7SX6z@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aMMq7I5TBoL7SX6z@x1>

On Thu, Sep 11, 2025 at 05:02:52PM -0300, Arnaldo Carvalho de Melo wrote:
> On Wed, Sep 10, 2025 at 02:52:25PM +0200, Guilherme Amadio wrote:
> > On Tue, Sep 09, 2025 at 11:31:51AM -0700, Ian Rogers wrote:
> > > On Tue, Sep 9, 2025 at 2:49 AM Guilherme Amadio <amadio@gentoo.org> wrote:
> > > > I was updating perf's package in Gentoo Linux and noticed some problems
> > > > which were not there before. I tested with the version below and the problem
> > > > still seems to be there. perf --help triggers an assertion (see below).
> > > > Looking in the list, it seems related to the patch below:
> 
> > > > https://lore.kernel.org/linux-perf-users/20250701201027.1171561-3-namhyung@kernel.org/
> 
> <SNIP>
> 
> > > I tried to reproduce the same version with various options: DEBUG=1
> > > -UNDEBUG in EXTRA_CFLAGS, -fsanitize=address. Being in various
> > > directories with "perf-" prefixed files. I'm afraid I wasn't able to
> > > reproduce. The assert is trying to avoid a memory leak, so
> > > non-critical, and I couldn't in a quick inspection eye-ball an issue.
> > > Without getting a reproduction I don't think I can make progress with
> > > the issue.
>  
> > I do not have any special setup on my machine (if you consider Gentoo
> > not special, of course). I just did a git bisect and arrived at commit
> > 9401d1771dad99bfc795dd2ae0c292343fd1f78d, which is the commit I linked
> > above. I used>
> 
> ⬢ [acme@toolbx perf-tools-next]$ git show 9401d1771dad99bfc795dd2ae0c292343fd1f78d
> fatal: bad object 9401d1771dad99bfc795dd2ae0c292343fd1f78d
> ⬢ [acme@toolbx perf-tools-next]$ 
> 
> Looking for the patch title I got to this one:
> 
> commit 1fdf938168c4d26fa279d4f204768690d1f9c4ae
> Author: Namhyung Kim <namhyung@kernel.org>
> Date:   Tue Jul 1 13:10:27 2025 -0700
> 
>     perf tools: Fix use-after-free in help_unknown_cmd()
> 
> ?

Sorry, I used the tag I arrived at with git bisect, which was probably cherry-picked:

gentoo linux $ git remote -v
amadio	git@github.com:amadio/linux (fetch)
amadio	git@github.com:amadio/linux (push)
perf-tools	git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git (fetch)
perf-tools	git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git (push)
perf-tools-next	git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git (fetch)
perf-tools-next	git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git (push)
stable	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git (fetch)
stable	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git (push)
torvalds	git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git (fetch)
torvalds	git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git (push)
gentoo linux $ git show 9401d1771dad99bfc795dd2ae0c292343fd1f78d | head
commit 9401d1771dad99bfc795dd2ae0c292343fd1f78d
Author: Namhyung Kim <namhyung@kernel.org>
  Date:   Tue Jul 1 13:10:27 2025 -0700

    perf tools: Fix use-after-free in help_unknown_cmd()
    
    [ Upstream commit 1fdf938168c4d26fa279d4f204768690d1f9c4ae ]
    
    Currently perf aborts when it finds an invalid command.  I guess it
    depends on the environment as I have some custom commands in the path.
gentoo linux $ git tag --contains 9401d1771dad99bfc795dd2ae0c292343fd1f78d
v6.16.1
v6.16.2
v6.16.3
v6.16.4
v6.16.5
v6.16.6
v6.16.7
gentoo linux $ git tag --contains 1fdf938168c4d26fa279d4f204768690d1f9c4ae
perf-tools-fixes-for-v6.17-2025-08-27
perf-tools-fixes-for-v6.17-2025-09-05
perf-tools-for-v6.17-2025-08-01
v6.17-rc1
v6.17-rc2
v6.17-rc3
v6.17-rc4
v6.17-rc5

Cheers,
-Guilherme


> 
> - Arnaldo
>  
> > $ make -C tools/perf clean && make -B -j16 -C tools/perf DEBUG=1 WERROR=0 NO_SHELLCHECK=1
> > 
> > then called perf --help each time (but perf help record or equivalent
> > also triggers the assertion). I'm using GCC 14 on a 3950X. The features
> > I have enabled and installed dependencies are below. This patch has been
> > backported to at least 6.12 stable, and I can reproduce this with
> > v6.12.45.
> > 
> > gentoo linux $ tools/perf/perf version --build-options
> > perf version 6.16.g45effee4b85a
> >                    aio: [ on  ]  # HAVE_AIO_SUPPORT
> >                    bpf: [ on  ]  # HAVE_LIBBPF_SUPPORT
> >          bpf_skeletons: [ on  ]  # HAVE_BPF_SKEL
> >             debuginfod: [ on  ]  # HAVE_DEBUGINFOD_SUPPORT
> >                  dwarf: [ on  ]  # HAVE_LIBDW_SUPPORT
> >     dwarf_getlocations: [ on  ]  # HAVE_LIBDW_SUPPORT
> >           dwarf-unwind: [ on  ]  # HAVE_DWARF_UNWIND_SUPPORT
> >               auxtrace: [ on  ]  # HAVE_AUXTRACE_SUPPORT
> >                 libbfd: [ OFF ]  # HAVE_LIBBFD_SUPPORT ( tip: Deprecated, license incompatibility, use BUILD_NONDISTRO=1 and install binutils-dev[el] )
> >            libcapstone: [ on  ]  # HAVE_LIBCAPSTONE_SUPPORT
> >              libcrypto: [ on  ]  # HAVE_LIBCRYPTO_SUPPORT
> >     libdw-dwarf-unwind: [ on  ]  # HAVE_LIBDW_SUPPORT
> >                 libelf: [ on  ]  # HAVE_LIBELF_SUPPORT
> >                libnuma: [ on  ]  # HAVE_LIBNUMA_SUPPORT
> >             libopencsd: [ OFF ]  # HAVE_CSTRACE_SUPPORT
> >                libperl: [ on  ]  # HAVE_LIBPERL_SUPPORT
> >                libpfm4: [ on  ]  # HAVE_LIBPFM
> >              libpython: [ on  ]  # HAVE_LIBPYTHON_SUPPORT
> >               libslang: [ on  ]  # HAVE_SLANG_SUPPORT
> >          libtraceevent: [ on  ]  # HAVE_LIBTRACEEVENT
> >              libunwind: [ OFF ]  # HAVE_LIBUNWIND_SUPPORT ( tip: Deprecated, use LIBUNWIND=1 and install libunwind-dev[el] to build with it )
> >                   lzma: [ on  ]  # HAVE_LZMA_SUPPORT
> > numa_num_possible_cpus: [ on  ]  # HAVE_LIBNUMA_SUPPORT
> >                   zlib: [ on  ]  # HAVE_ZLIB_SUPPORT
> >                   zstd: [ on  ]  # HAVE_ZSTD_SUPPORT
> > 
> > And here are the version of all dependencies I have installed:
> > 
> >  * dependency graph for dev-util/perf-6.16-r1
> >  `--  dev-util/perf-6.16-r1
> >    `--  dev-util/babeltrace-1.5.11
> >    `--  dev-libs/libbpf-1.6.2
> >    `--  dev-util/bpftool-7.6.0
> >    `--  dev-util/pahole-1.30
> >    `--  llvm-core/clang-18.1.8-r6
> >    `--  llvm-core/llvm-18.1.8-r6
> >    `--  llvm-core/clang-19.1.7
> >    `--  llvm-core/llvm-19.1.7
> >    `--  llvm-core/clang-20.1.8
> >    `--  llvm-core/llvm-20.1.8
> >    `--  llvm-core/clang-21.1.0
> >    `--  llvm-core/llvm-21.1.0
> >    `--  sys-libs/libcap-2.76
> >    `--  dev-libs/capstone-5.0.6
> >    `--  dev-libs/openssl-3.5.2
> >    `--  x11-libs/gtk+-2.24.33-r3
> >    `--  virtual/jre-21
> >    `--  dev-libs/libpfm-4.13.0
> >    `--  dev-libs/libtraceevent-1.8.4
> >    `--  dev-libs/libtracefs-1.8.2
> >    `--  app-arch/xz-utils-5.8.1-r1
> >    `--  sys-process/numactl-2.0.19
> >    `--  dev-lang/perl-5.42.0
> >    `--  dev-lang/python-0.3.13.7
> >    `--  dev-lang/python-0.3.14.0_rc2
> >    `--  dev-lang/python-3.11.13_p1
> >    `--  dev-lang/python-3.12.11_p1
> >    `--  dev-lang/python-3.13.9999
> >    `--  dev-lang/python-3.14.0_rc2
> >    `--  sys-libs/slang-2.3.3-r1
> >    `--  dev-debug/systemtap-5.3
> >    `--  dev-util/google-perftools-2.17.2
> >    `--  sys-libs/libunwind-1.8.2-r1
> >    `--  app-arch/zstd-1.5.7-r1
> >    `--  dev-libs/elfutils-0.193
> >    `--  sys-libs/binutils-libs-2.45-r1
> >    `--  sys-libs/zlib-1.3.1-r1
> >    `--  virtual/libcrypt-2-r1
> >    `--  sys-kernel/linux-headers-6.16
> >    `--  virtual/jdk-21
> >    `--  app-arch/tar-1.35
> >    `--  dev-python/setuptools-80.9.0-r1
> >    `--  app-alternatives/yacc-1-r2
> >    `--  app-alternatives/lex-0-r1
> >    `--  sys-apps/which-2.23
> >    `--  virtual/pkgconfig-3
> >    `--  app-text/asciidoc-10.2.1
> >    `--  app-text/sgml-common-0.6.3-r7
> >    `--  app-text/xmlto-0.0.28-r11
> >    `--  sys-process/time-1.9-r1
> > 
> > I hope that this helps with reproducing the problem, but if not, let me
> > know which additional information you'd like to have and I will send it.
> > My running kernel is 6.16.4, and glibc is version 2.42.
> > 
> > Best regards,
> > -Guilherme
