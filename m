Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17FB157A72
	for <linux-perf-users@vger.kernel.org>; Thu, 10 Apr 2025 06:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744266298; cv=none; b=e36To9JyykJ05MXyvyDcFZQyNsZOO00zsbrJW7+aIsJG0EGreTAfjWnuPIb8K5xQSP71l4eN+1Futek9IIjzuKz4PpmvX0iu8laW5rdtL3TSMRprR6R/7QChwJvP+uFhB4o7e2FFRue87JJZ45zmX7HjLkjlTDINSvpw7z5+YDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744266298; c=relaxed/simple;
	bh=joLGuCsfmz/o6I4tCMNy05ydHs8fTi0sy5xn8MCEU10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fGflOeh3htM9Bz2GCBAvlanClbzM2no06H4OMMZpVyNsl+E8pRIB0Xbwl1HiODpqPPjbdoKsFqKNeyzoHhplcxGMsmyfGVli4bhkisr4qRhyvvnKPL2ZmD5x7Gz/Pn84sczIdgI4wapCLztywlDvmSImZHSDWRrtHh1gtfXomEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JABBCf7k; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JABBCf7k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 598B3C4CEDD;
	Thu, 10 Apr 2025 06:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744266297;
	bh=joLGuCsfmz/o6I4tCMNy05ydHs8fTi0sy5xn8MCEU10=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JABBCf7kdXKJEe8O0EgQzU/H+NMj2+EF7z6ADCq0mMnOgwBqqHPZEm7q26ZbWPEuC
	 gDiPNg6R5B3qYAhoqwzMPJBre9XQL09L5Xpm6cm2XKsISXu19x1vmXUpUV1uLeduWz
	 uOhTW1yXc5lrFgM6qAgDN7E0CEDq9cHr/VxgLjHuAn3tOjiQjxx54ebSzVPedTUSHy
	 XaiF7mZ7OLiCyhWn9EH6oj9NI8t5B0STNy4m/4qxcsUVZUjcPKtO4rA4f6pVtMxtw+
	 qQaNmkIH5neiFtSn5Cnjm2CjwHjwcvaUUE5pNta//sH9QP0zcjhMM5Y/cmF/KK1Hs9
	 jiD6U3GQyFPMw==
Date: Thu, 10 Apr 2025 08:24:52 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Howard Chu <howardchu95@gmail.com>, Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-perf-users@vger.kernel.org,
	Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [perf top] annotation doesn't work, libunwind doesn't seem to be
 working either
Message-ID: <Z_dkNDj9EPFwPqq1@gmail.com>
References: <Z_QEND63LoxP0h9H@gmail.com>
 <Z_Rz10stoLzBocIO@x1>
 <Z_TYux5fUg2pW-pF@gmail.com>
 <Z_XaOp4TCBKe-M0o@x1>
 <Z_ZltdaHx9XuKcd9@x1>
 <Z_aY0fTs53id77CS@x1>
 <Z_bHtD7umCsKeWJ6@x1>
 <Z_bI7wK8mJYVOWDH@x1>
 <Z_bl8tabAwfqKuy-@gmail.com>
 <Z_chCGYb1_hMS1F9@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_chCGYb1_hMS1F9@x1>


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> On Wed, Apr 09, 2025 at 11:26:10PM +0200, Ingo Molnar wrote:
> > * Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > > Using 't' to zoom into a thread and then LEFT to zoom out works, ditto
> > > for 'd' + LEFT, 'k' (zoom into the kernel) + LEFT its just 'm' + thread
> > > or ENTER + Zoom into Thread that isn't working...
> 
> > > Not even that, there is something subtle, investigating.
> 
> > > But as a suggestion, pressing 't' zooms into a thread, pressing it again
> > > zooms out of that thread, rinse repeat.
> 
> > Indeed, this works it around. It's not *that* easy though: 't' goes 
> > into thread view, but has to be pressed another 3(?) times to get back 
> > to the previous non-threaded view again.
> 
> > > Ditto for 'd' for DSO and 'k' for the kernel DSO, 'S' for a CPU socket
> > > (Kan Liang implemented this, but not for 'c' CPU, will try to add that).
> 
> > > Anyway, back to the bug.
>  
> > Thanks for having a look! :)
> 
> I guess I found it, another one-liner (well, two if you count removing a
> comment line) with a long explanation, see below.
> 
> There is a tidy up patch before this, all is at:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git perf-annotate+build

Wow, that's quite a lot!

So, I can confirm that the build warning is gone - as the libunwind 
entry is gone:

 Auto-detecting system features:
 ...                                   libdw: [ on  ]
 ...                                   glibc: [ on  ]
 ...                                  libelf: [ on  ]
 ...                                 libnuma: [ on  ]
 ...                  numa_num_possible_cpus: [ on  ]
 ...                                 libperl: [ on  ]
 ...                               libpython: [ on  ]
 ...                               libcrypto: [ on  ]
 ...                             libcapstone: [ on  ]
 ...                               llvm-perf: [ on  ]
 ...                                    zlib: [ on  ]
 ...                                    lzma: [ on  ]
 ...                               get_cpuid: [ on  ]
 ...                                     bpf: [ on  ]
 ...                                  libaio: [ on  ]
 ...                                 libzstd: [ on  ]

And there's this second round of auto-detection:

 Auto-detecting system features:
 ...                         clang-bpf-co-re: [ on  ]
 ...                                    llvm: [ on  ]
 ...                                  libcap: [ on  ]
 ...                                  libbfd: [ on  ]

which is all-green as well.

I still have these dependency warnings:

  Makefile.config:563: No elfutils/debuginfod.h found, no debuginfo server support, please install elfutils-debuginfod-client-devel or equivalent
  Makefile.config:1146: No openjdk development package found, please install JDK package, e.g. openjdk-8-jdk, java-1.8.0-openjdk-devel
  Makefile.config:1191: libtracefs is missing. Please install libtracefs-dev/libtracefs-devel

The libtracefs one was resolved via 'apt install libtracefs-dev', 
leaving two:

 Makefile.config:563: No elfutils/debuginfod.h found, no debuginfo server support, please install elfutils-debuginfod-client-devel or equivalent
 Makefile.config:1146: No openjdk development package found, please install JDK package, e.g. openjdk-8-jdk, java-1.8.0-openjdk-devel

I cannot resolve the openjdk dependency warning, despite installing a 
plethora of packages:

kepler:~/tip> dpkg -l | grep openjdk
rc  openjdk-14-jre-headless:amd64                               14.0.2+12-1                                         amd64        OpenJDK Java runtime, using Hotspot JIT (headless)
ii  openjdk-17-jre:amd64                                        17.0.14+7-1~24.10                                   amd64        OpenJDK Java runtime, using Hotspot JIT
ii  openjdk-17-jre-headless:amd64                               17.0.14+7-1~24.10                                   amd64        OpenJDK Java runtime, using Hotspot JIT (headless)
rc  openjdk-18-jre-headless:amd64                               18.0.2+9-2ubuntu1                                   amd64        OpenJDK Java runtime, using Hotspot JIT (headless)
ii  openjdk-21-jdk-headless:amd64                               21.0.6+7-1~24.10.1                                  amd64        OpenJDK Development Kit (JDK) (headless)
ii  openjdk-21-jre:amd64                                        21.0.6+7-1~24.10.1                                  amd64        OpenJDK Java runtime, using Hotspot JIT
ii  openjdk-21-jre-headless:amd64                               21.0.6+7-1~24.10.1                                  amd64        OpenJDK Java runtime, using Hotspot JIT (headless)
ii  openjdk-8-jdk:amd64                                         8u442-b06~us1-0ubuntu1~24.10                        amd64        OpenJDK Development Kit (JDK)
ii  openjdk-8-jdk-headless:amd64                                8u442-b06~us1-0ubuntu1~24.10                        amd64        OpenJDK Development Kit (JDK) (headless)
ii  openjdk-8-jre:amd64                                         8u442-b06~us1-0ubuntu1~24.10                        amd64        OpenJDK Java runtime, using Hotspot JIT
ii  openjdk-8-jre-headless:amd64                                8u442-b06~us1-0ubuntu1~24.10                        amd64        OpenJDK Java runtime, using Hotspot JIT (headless)

And I managed to resolve the elfutils/debuginfod.h warning via an 
apt-file search and installing the libdebuginfod-dev package, the 
warning message should probably be updated via the patch further below 
that gives a more specific package name to install.

With that resolved, I now have only a single dependency failure left:

  Makefile.config:1146: No openjdk development package found, please install JDK package, e.g. openjdk-8-jdk, java-1.8.0-openjdk-devel

On the UI front:

 - I can confirm that the left-arrow now works intuitively wrt. context 
   zooming, thanks for implementing that!

 - Likewise, the Esc key suggested in the 'h' screen now works 
   intuitively as well.

 - When pressing an unbound key I now get a helpful message.

    - One small detail with the unbound key warning I noticed: it now 
      says "'l' key not associated, use 'h'/'?'/F1 to see actions!", but 
      pressing 'h' will only work after dismissing this window. It might 
      be a nice little extra UI tweak to allow 'h/?/F1' to jump to the 
      help window straight away from warning windows, instead of 
      requiring two keys to be pressed?

 - I also see that 'P' now works in a broader context as well, saving 
   the perf.hist.0 file.

    - A small observation with the 'P' key too: maybe the status line 
      at the bottom should update with the action performed? I only see 
      a small flash and the "Press '?' for help on key bindings" 
      message is reprinted.

Anyway, I'd say that the large majority of my TUI complaints were 
resolved by your changes, and I had no new problems, so for the
changes so far:

  Tested-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo

=================================>

Signed-off-by: Ingo Molnar <mingo@kernel.org>

 tools/perf/Makefile.config | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 211eb88e6bd8..9f08a6e96b35 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -560,7 +560,7 @@ ifndef NO_LIBELF
       CFLAGS += -DHAVE_DEBUGINFOD_SUPPORT
       EXTLIBS += -ldebuginfod
     else
-      $(warning No elfutils/debuginfod.h found, no debuginfo server support, please install elfutils-debuginfod-client-devel or equivalent)
+      $(warning No elfutils/debuginfod.h found, no debuginfo server support, please install libdebuginfod-dev/elfutils-debuginfod-client-devel or equivalent)
     endif
   endif
 
