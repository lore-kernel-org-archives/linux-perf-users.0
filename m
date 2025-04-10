Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9DE1E515;
	Thu, 10 Apr 2025 14:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744293802; cv=none; b=C7dEyGt3yWlw1RSuvJtyfW8mjbHRfLHuJt/cdEWVKuPecp/b2U1UHGgI1v2+nDXjMbrrdYj89VHGqOiZiLf8aEgvcfnB1Ur+OWYA57nPJpXaGFIJcGW7Qp7mFGMp4jWGU7PWXb/MhLBfofy15nsBvykoRPvLEEA6euOZP+W6jJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744293802; c=relaxed/simple;
	bh=pBRvknAVUD0G3K153267322eDRSeCF9wcCoZODOKnYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cQdWdBaKbjJzZKWan17p73FsD3G+Rwe63I3M9XIoIHEvoB436qKxlK2be4rX8UXn68aXDW3oH8PlNhMFQHnQQ+OcUFaTJrD8s3hptJexACMLw5PrHw8uq4Hc74wj9DcXiTrhB6rCY3c5v9jQKCkZGrBv2va15uWgSjfIsqrARBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hq7MFxXY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hq7MFxXY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58A21C4CEDD;
	Thu, 10 Apr 2025 14:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744293801;
	bh=pBRvknAVUD0G3K153267322eDRSeCF9wcCoZODOKnYs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hq7MFxXYBX66LGaM4VQN7NGb6kNqa1n5Z42SucADWQULAttYry1XLDJvVrpnocxqr
	 PgG66SvVdsYDKPIQWCoxU7j3sxusEB5W5NSr+5228TNuU8Oqk7mj21ieMXRhY3F1F2
	 ebqLRGAivO/uTEFdPuu6ReRQ/Ff6kO1LV7Ww7L1kMY1nM0fpC1VkP8pslvWNyWW+aC
	 QBFO2LlvglWcXHgDdloimnGf8vwu4LAD9Nd2gEH3SVefTIRxF7kLujFKwJj+E++lE0
	 Uiz9ZRwq9QEBnh1zeREBanPB11g3sP+VXTn+1iVlSkGko9ordx7KF1PdJBFvzhii2w
	 qiD//jRAt7tbA==
Date: Thu, 10 Apr 2025 11:03:18 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Howard Chu <howardchu95@gmail.com>, Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-perf-users@vger.kernel.org,
	Dmitry Vyukov <dvyukov@google.com>,
	Michael Petlan <mpetlan@redhat.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Fixes for perf build system and TUI browsers was Re: [perf top]
 annotation doesn't work, libunwind doesn't seem to be working either
Message-ID: <Z_fPpmHZu5ppip5V@x1>
References: <Z_Rz10stoLzBocIO@x1>
 <Z_TYux5fUg2pW-pF@gmail.com>
 <Z_XaOp4TCBKe-M0o@x1>
 <Z_ZltdaHx9XuKcd9@x1>
 <Z_aY0fTs53id77CS@x1>
 <Z_bHtD7umCsKeWJ6@x1>
 <Z_bI7wK8mJYVOWDH@x1>
 <Z_bl8tabAwfqKuy-@gmail.com>
 <Z_chCGYb1_hMS1F9@x1>
 <Z_dkNDj9EPFwPqq1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z_dkNDj9EPFwPqq1@gmail.com>

On Thu, Apr 10, 2025 at 08:24:52AM +0200, Ingo Molnar wrote:
> * Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > On Wed, Apr 09, 2025 at 11:26:10PM +0200, Ingo Molnar wrote:
> > > * Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > > > Anyway, back to the bug.

> > > Thanks for having a look! :)

> > I guess I found it, another one-liner (well, two if you count removing a
> > comment line) with a long explanation, see below.

> > There is a tidy up patch before this, all is at:

> > https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git perf-annotate+build
 
> Wow, that's quite a lot!

You reported various problems that accumulated thru over a decade, which
shows how difficult is to regression test TUIs :-\

We have 'perf test' to test various aspects of the tools, with C ones
testing APIs, shell ones running the tools and looking if they are
generating expected results by grepping output and using other
techniques, the perf test shell infrastructure is itself checked using
ShellCheck, if installed:

⬢ [acme@toolbox perf-tools-next]$ rpm -q --qf "%{description}\n" ShellCheck
The goals of ShellCheck are:

* To point out and clarify typical beginner's syntax issues,
  that causes a shell to give cryptic error messages.

* To point out and clarify typical intermediate level semantic problems,
  that causes a shell to behave strangely and counter-intuitively.

* To point out subtle caveats, corner cases and pitfalls, that may cause an
  advanced user's otherwise working script to fail under future circumstances.
⬢ [acme@toolbox perf-tools-next]$

A big regression test suite that lived/lives inside Red Hat,
created/maintained by Michael Petlan (and was continuosly used to test
perf) is being merged with it over time.

Ian did lots of work on making it parallel, with some tests needing to
be run exclusively as it changes global state (perf probe adding stuff,
etc).

But one area we lack is to test things that interact with the user, like
the TUI, something to improve!

So I'm rather happy when someone that uses the TUI comes along and
points out problems, as this isn't an area that we are automatically
testing, it all depends on sheer code review, with corner case bugs
living in the codebase for years, sometimes decades...
 
> So, I can confirm that the build warning is gone - as the libunwind 
> entry is gone:

Great!
 
>  Auto-detecting system features:
>  ...                                   libdw: [ on  ]
>  ...                                   glibc: [ on  ]
>  ...                                  libelf: [ on  ]
>  ...                                 libnuma: [ on  ]
>  ...                  numa_num_possible_cpus: [ on  ]
>  ...                                 libperl: [ on  ]
>  ...                               libpython: [ on  ]
>  ...                               libcrypto: [ on  ]
>  ...                             libcapstone: [ on  ]
>  ...                               llvm-perf: [ on  ]
>  ...                                    zlib: [ on  ]
>  ...                                    lzma: [ on  ]
>  ...                               get_cpuid: [ on  ]
>  ...                                     bpf: [ on  ]
>  ...                                  libaio: [ on  ]
>  ...                                 libzstd: [ on  ]
> 
> And there's this second round of auto-detection:
 
>  Auto-detecting system features:
>  ...                         clang-bpf-co-re: [ on  ]
>  ...                                    llvm: [ on  ]
>  ...                                  libcap: [ on  ]
>  ...                                  libbfd: [ on  ]
 
> which is all-green as well.
 
> I still have these dependency warnings:
 
>   Makefile.config:563: No elfutils/debuginfod.h found, no debuginfo server support, please install elfutils-debuginfod-client-devel or equivalent
>   Makefile.config:1146: No openjdk development package found, please install JDK package, e.g. openjdk-8-jdk, java-1.8.0-openjdk-devel
>   Makefile.config:1191: libtracefs is missing. Please install libtracefs-dev/libtracefs-devel
 
> The libtracefs one was resolved via 'apt install libtracefs-dev', 
> leaving two:
 
>  Makefile.config:563: No elfutils/debuginfod.h found, no debuginfo server support, please install elfutils-debuginfod-client-devel or equivalent
>  Makefile.config:1146: No openjdk development package found, please install JDK package, e.g. openjdk-8-jdk, java-1.8.0-openjdk-devel
 
> I cannot resolve the openjdk dependency warning, despite installing a 
> plethora of packages:

This one is a sore spot, I'll try to take a look.
 
> kepler:~/tip> dpkg -l | grep openjdk
> rc  openjdk-14-jre-headless:amd64                               14.0.2+12-1                                         amd64        OpenJDK Java runtime, using Hotspot JIT (headless)
> ii  openjdk-17-jre:amd64                                        17.0.14+7-1~24.10                                   amd64        OpenJDK Java runtime, using Hotspot JIT
> ii  openjdk-17-jre-headless:amd64                               17.0.14+7-1~24.10                                   amd64        OpenJDK Java runtime, using Hotspot JIT (headless)
> rc  openjdk-18-jre-headless:amd64                               18.0.2+9-2ubuntu1                                   amd64        OpenJDK Java runtime, using Hotspot JIT (headless)
> ii  openjdk-21-jdk-headless:amd64                               21.0.6+7-1~24.10.1                                  amd64        OpenJDK Development Kit (JDK) (headless)
> ii  openjdk-21-jre:amd64                                        21.0.6+7-1~24.10.1                                  amd64        OpenJDK Java runtime, using Hotspot JIT
> ii  openjdk-21-jre-headless:amd64                               21.0.6+7-1~24.10.1                                  amd64        OpenJDK Java runtime, using Hotspot JIT (headless)
> ii  openjdk-8-jdk:amd64                                         8u442-b06~us1-0ubuntu1~24.10                        amd64        OpenJDK Development Kit (JDK)
> ii  openjdk-8-jdk-headless:amd64                                8u442-b06~us1-0ubuntu1~24.10                        amd64        OpenJDK Development Kit (JDK) (headless)
> ii  openjdk-8-jre:amd64                                         8u442-b06~us1-0ubuntu1~24.10                        amd64        OpenJDK Java runtime, using Hotspot JIT
> ii  openjdk-8-jre-headless:amd64                                8u442-b06~us1-0ubuntu1~24.10                        amd64        OpenJDK Java runtime, using Hotspot JIT (headless)

> And I managed to resolve the elfutils/debuginfod.h warning via an 
> apt-file search and installing the libdebuginfod-dev package, the 
> warning message should probably be updated via the patch further below 
> that gives a more specific package name to install.

I've folded your patch in the patch I added in this series while
addressing the other problems you pointed out with libunwind, ditto for
libbfd.

> With that resolved, I now have only a single dependency failure left:
 
>   Makefile.config:1146: No openjdk development package found, please install JDK package, e.g. openjdk-8-jdk, java-1.8.0-openjdk-devel

I'll work on that.
 
> On the UI front:
> 
>  - I can confirm that the left-arrow now works intuitively wrt. context 
>    zooming, thanks for implementing that!

Great! the good thing was that minor changes were needed.
 
>  - Likewise, the Esc key suggested in the 'h' screen now works 
>    intuitively as well.

Right, I didn't even try to fix that one explicitely, it was that
do_zoom_thread() (that does zoom in and out) not having act->thread set
when handling the left arrow, that happens to also handle the ESC case.
 
>  - When pressing an unbound key I now get a helpful message.

Great.
 
>     - One small detail with the unbound key warning I noticed: it now 
>       says "'l' key not associated, use 'h'/'?'/F1 to see actions!", but 
>       pressing 'h' will only work after dismissing this window. It might 
>       be a nice little extra UI tweak to allow 'h/?/F1' to jump to the 
>       help window straight away from warning windows, instead of 
>       requiring two keys to be pressed?

Sure, I'll add a patch on top of this series doing that.
 
>  - I also see that 'P' now works in a broader context as well, saving 
>    the perf.hist.0 file.

I did nothing in this regard, a good fallout from the other changes then.
 
>     - A small observation with the 'P' key too: maybe the status line 
>       at the bottom should update with the action performed? I only see 
>       a small flash and the "Press '?' for help on key bindings" 
>       message is reprinted.

Right, I think this is a case to use a popup window stating that the
"screenshot" was produced and was saved in file xyz.bla
 
> Anyway, I'd say that the large majority of my TUI complaints were 
> resolved by your changes, and I had no new problems, so for the
> changes so far:
 
>   Tested-by: Ingo Molnar <mingo@kernel.org>

Thanks, I added that to the patches and will use what I have right now
to open the perf-tools-next.git tree, so that in addition to this work I
start processing the many patches that are out there for 6.16!

Please, if you have further comments, just send them my way but do not
forget to CC perf's co-maintainer, reviewers and the mailing list, its
not always that I can focus on something like this ;-)

Cheers,

- Arnaldo
