Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D362F25F5;
	Thu,  4 Jun 2026 23:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780616102; cv=none; b=IByvr2mybHe/ewO2NGRLBqZEhCgr5WoKUrRSM9SR2kL0zPB6YCZtBp6TzMd0gnlTifatAbPbGJzrRPJP50TeXa5LyKPSbXTbLbXcsCKjU30p+ZO1eBAaMcQCseQPFcgMU2ROUpxAoBhCIys5XWmo+hi3Uia0sqK82pAHFZuWTo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780616102; c=relaxed/simple;
	bh=c8K1j2bxDz2SlndVZF+ckIXMkG/PoZ8Pa/JeQdissXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AVaPeEBasRPIzzBlFyGoRZyAGv7GpS+y4rCuKrbme8pRMaCv+cobat8Vra9/mMjvh6YepHWqsusIkLxRvNwdHeQ3WUbXmgfF11tZooNXJA7G5t+ayCXN67Nd7L4wfa2YGqv6IhE9ktHzyYc747cVLccyr5tLLh4vGaGw5fiISsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V/RqA59/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V/RqA59/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B67D11F00893;
	Thu,  4 Jun 2026 23:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780616101;
	bh=eaIigWcgTpI+75JHWpiyotoeOYAV/YkNLtrxdK6qgiY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=V/RqA59/URvQghme5uFo5Y3YJmiuTr2qOxIaZPMrJ61V7jId7+8EboaENnS9hpsmK
	 rJHtyo2meOMsFGMcmxni2u5k1lgjQn18Pi0oFc3R0bG9iTWbu4gvP78B9msHl4hrc4
	 s/951RrmyAVwaXxEKSrZnuN7gpsRzqM5WbJ+ObHUGWJAER8rMWBecHRScFiMUl/FrQ
	 tOu7cDsSSfVHs58ajRkF2dn8Nrc/e+dFZZd8FePja2kF76hczAK0Z+UBVMI35rW342
	 +tpH+BcF8J1PtotFt9Kx18qVxIbgc65iqErYPPXlMjchdVbkx3B4d5atoDLFE8rK/B
	 VbMHXc8/Jh07Q==
Date: Thu, 4 Jun 2026 16:34:58 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 0/4] perf timechart: Small optimization for backtrace
Message-ID: <aiILolfi8MA27v2L@google.com>
References: <20260604214931.2202322-1-namhyung@kernel.org>
 <CAP-5=fU3JO3b+bPYzZd=TKoxDy4xYMgGXVtCZq6W3Lh3LNN8YA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fU3JO3b+bPYzZd=TKoxDy4xYMgGXVtCZq6W3Lh3LNN8YA@mail.gmail.com>

Hi Ian,

On Thu, Jun 04, 2026 at 03:38:05PM -0700, Ian Rogers wrote:
> On Thu, Jun 4, 2026 at 2:49 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > Hello,
> >
> > I found an issue int timechart backtrace handling during the last review.
> > The goal is to reduce unnecessary work in generating backtrace string.
> >
> > v2 changes)
> >  * fix memory leaks when backtrace is not used
> >  * copy backtrace when it's used twice
> 
> Hi Namhyung,
> 
> thanks for cleaning this up and the fixes! Running a build of:
> $ make -C tools/perf O=/tmp/perf DEBUG=1
> EXTRA_CFLAGS="-fno-omit-frame-pointer -O0 -g -fsanitize=address" clean
> all
> 
> I get an error but the test harness makes it look like the test is
> passing (I added set -x to the test and removed the "> /dev/null
> 2>&1"):
> ```
> $ sudo /tmp/perf/perf test -vv timechart
> 136: perf timechart tests
> 136: perf timechart tests:
> ---- start ----
> test child forked, pid 937043
> + err=0
> ++ mktemp /tmp/__perf_timechart_test.perf.data.XXXXX
> + perfdata=/tmp/__perf_timechart_test.perf.data.cXMvK
> ++ mktemp /tmp/__perf_timechart_test.output.XXXXX.svg
> + output=/tmp/__perf_timechart_test.output.xZXfy.svg
> + trap trap_cleanup EXIT TERM INT
> + perf check feature -q libtraceevent
> + test_timechart
> + echo 'Basic perf timechart test'
> Basic perf timechart test
> + perf timechart record -o /tmp/__perf_timechart_test.perf.data.cXMvK true
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 4.135 MB
> /tmp/__perf_timechart_test.perf.data.cXMvK (748 samples) ]
> 
> =================================================================
> ==937049==ERROR: LeakSanitizer: detected memory leaks
> 
> Direct leak of 136 byte(s) in 1 object(s) allocated from:
>    #0 0x7fd211119a23 in calloc
> ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:74
>    #1 0x555c44044416 in timechart__record ~/linux/tools/perf/builtin-timech
> art.c:1895
>    #2 0x555c44046c19 in cmd_timechart ~/linux/tools/perf/builtin-timechart.
> c:2073
>    #3 0x555c440828a4 in run_builtin ~/linux/tools/perf/perf.c:348
>    #4 0x555c44082d42 in handle_internal_command ~/linux/tools/perf/perf.c:3
> 98
>    #5 0x555c44083110 in run_argv ~/linux/tools/perf/perf.c:442
>    #6 0x555c44083667 in main ~/linux/tools/perf/perf.c:549
>    #7 0x7fd206e29f76 in __libc_start_call_main
> ../sysdeps/nptl/libc_start_call_main.h:58
>    #8 0x7fffcf8a352a  ([stack]+0x2052a)
> 
> Direct leak of 10 byte(s) in 2 object(s) allocated from:
>    #0 0x7fd211113e20 in strdup
> ../../../../src/libsanitizer/asan/asan_interceptors.cpp:593
>    #1 0x555c440444a1 in timechart__record ~/linux/tools/perf/builtin-timech
> art.c:1902
>    #2 0x555c44046c19 in cmd_timechart ~/linux/tools/perf/builtin-timechart.
> c:2073
>    #3 0x555c440828a4 in run_builtin ~/linux/tools/perf/perf.c:348
>    #4 0x555c44082d42 in handle_internal_command ~/linux/tools/perf/perf.c:3
> 98
>    #5 0x555c44083110 in run_argv ~/linux/tools/perf/perf.c:442
>    #6 0x555c44083667 in main ~/linux/tools/perf/perf.c:549
>    #7 0x7fd206e29f76 in __libc_start_call_main
> ../sysdeps/nptl/libc_start_call_main.h:58
>    #8 0x7fffcf8a352a  ([stack]+0x2052a)
> 
> Indirect leak of 44 byte(s) in 4 object(s) allocated from:
>    #0 0x7fd211113e20 in strdup
> ../../../../src/libsanitizer/asan/asan_interceptors.cpp:593
>    #1 0x555c440445ef in timechart__record ~/linux/tools/perf/builtin-timech
> art.c:1908
>    #2 0x555c44046c19 in cmd_timechart ~/linux/tools/perf/builtin-timechart.
> c:2073
>    #3 0x555c440828a4 in run_builtin ~/linux/tools/perf/perf.c:348
>    #4 0x555c44082d42 in handle_internal_command ~/linux/tools/perf/perf.c:3
> 98
>    #5 0x555c44083110 in run_argv ~/linux/tools/perf/perf.c:442
>    #6 0x555c44083667 in main ~/linux/tools/perf/perf.c:549
>    #7 0x7fd206e29f76 in __libc_start_call_main
> ../sysdeps/nptl/libc_start_call_main.h:58
>    #8 0x7fffcf8a352a  ([stack]+0x2052a)
> 
> Indirect leak of 41 byte(s) in 4 object(s) allocated from:
>    #0 0x7fd211113e20 in strdup
> ../../../../src/libsanitizer/asan/asan_interceptors.cpp:593
>    #1 0x555c44044696 in timechart__record ~/linux/tools/perf/builtin-timech
> art.c:1911
>    #2 0x555c44046c19 in cmd_timechart ~/linux/tools/perf/builtin-timechart.
> c:2073
>    #3 0x555c440828a4 in run_builtin ~/linux/tools/perf/perf.c:348
>    #4 0x555c44082d42 in handle_internal_command ~/linux/tools/perf/perf.c:3
> 98
>    #5 0x555c44083110 in run_argv ~/linux/tools/perf/perf.c:442
>    #6 0x555c44083667 in main ~/linux/tools/perf/perf.c:549
>    #7 0x7fd206e29f76 in __libc_start_call_main
> ../sysdeps/nptl/libc_start_call_main.h:58
>    #8 0x7fffcf8a352a  ([stack]+0x2052a)
> 
> Indirect leak of 11 byte(s) in 4 object(s) allocated from:
>    #0 0x7fd211113e20 in strdup
> ../../../../src/libsanitizer/asan/asan_interceptors.cpp:593
>    #1 0x555c440444a1 in timechart__record ~/linux/tools/perf/builtin-timech
> art.c:1902
>    #2 0x555c44046c19 in cmd_timechart ~/linux/tools/perf/builtin-timechart.
> c:2073
>    #3 0x555c440828a4 in run_builtin ~/linux/tools/perf/perf.c:348
>    #4 0x555c44082d42 in handle_internal_command ~/linux/tools/perf/perf.c:3
> 98
>    #5 0x555c44083110 in run_argv ~/linux/tools/perf/perf.c:442
>    #6 0x555c44083667 in main ~/linux/tools/perf/perf.c:549
>    #7 0x7fd206e29f76 in __libc_start_call_main
> ../sysdeps/nptl/libc_start_call_main.h:58
>    #8 0x7fffcf8a352a  ([stack]+0x2052a)
> 
> SUMMARY: AddressSanitizer: 242 byte(s) leaked in 15 allocation(s).
> + echo 'Basic perf timechart test [Skipped: perf timechart record
> failed (permissions/events?)]'
> Basic perf timechart test [Skipped: perf timechart record failed
> (permissions/events?)]
> + return
> + cleanup
> + rm -f /tmp/__perf_timechart_test.perf.data.cXMvK
> + rm -f /tmp/__perf_timechart_test.output.xZXfy.svg
> + trap - EXIT TERM INT
> + exit 0
> ---- end(0) ----
> 136: perf timechart tests
> : Ok
> ```
> 
> It was this test that I was trying to make leak sanitizer clean when
> doing my fixes.

I think these leaks are pre-existing.  I don't see where it frees cpu
samples and other events.  I'll take a look and send a fix separately.

Thanks,
Namhyung

