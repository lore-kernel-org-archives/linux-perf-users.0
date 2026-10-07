Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A424413787;
	Wed,  7 Oct 2026 21:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791408927; cv=none; b=YTXtZx9Mgp6qbqc2kpJNT0mXbaEC0XdJeLWpNEwkfx5oUUREfhS0//mAV5KMUPlhhmkqONOszwjg8zU8owTs2hEG0eyGDO1sTVcY4tnNmirIct3JMHIBMkbmlM2+QeYYX2ULGQS4is2pfm7HV45SPK8D4YJLbyIZleHokFGWwrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791408927; c=relaxed/simple;
	bh=vP2ZYU6YS886YQ4vA5qJU1ypYkuItEqWC9HKfNyaBlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kgGHSIBt+mCMN3tn+VJxExQYE2d51UUieLjmClfQ8LySG5U2+RAE2HKIYf0ALhYUyGEf2fS0bYGK4FUyZSz1g2KG/IPnqgxMxbQHhZHfLJHE7JZeY4qkiBm2heAw7jqICqWkTPFLYIhuuhed8eDRd/RfJLLr0XtJkXVzMcMgqxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bmpi27SB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bmpi27SB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9A121F000FF;
	Wed,  7 Oct 2026 21:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791408926;
	bh=oSv+BnYhJxpYrrmQ22JNB57+rdXO3Tb5wWWSMx6vKtQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bmpi27SBzGNv/EzGzc7D5WBVKM/2ul5onZhpDm0M0NrZTcikRKzwY2PPdajubwpLm
	 KPIaMKACWghbbYmsM/v8AcpWsN/R805tLOaB5AGwRaVvZWWoPnBSRIXToWtYHHJECK
	 b4nuv9ih4zox5pnyRDWSEaL9dHrTH51mUYmEbmVlBrjW5t961vaIVcrb8e17WtzFmw
	 TkYtTYz1lHagwQImMCmZBTLaYWSPStyUCIpe2zL5qgqDsBNxO66P9G34Sywe3XLHd2
	 90BG3wp4wbb2EXsmMTtP0u4N+V9FP6qrfNsK9bgaP8jZKsKjjJUuNhesSwl0UP4uOY
	 ERKGQnUdJSWxA==
Date: Wed, 7 Oct 2026 14:35:24 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Changbin Du <changbin.du@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf bench: Add atomic CAS benchmark
Message-ID: <asa7HPL9sKgbi4_X@google.com>
References: <20260930091617.4189736-1-changbin.du@gmail.com>
 <asQlFvclL-vj5xlh@google.com>
 <asXXZJzEPoEsMSni@mail.google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <asXXZJzEPoEsMSni@mail.google.com>

On Wed, Oct 07, 2026 at 01:27:36PM +0800, Changbin Du wrote:
> Hello,
> On Mon, Oct 05, 2026 at 03:30:46PM -0700, Namhyung Kim wrote:
> > Hello,
> > 
> > On Wed, Sep 30, 2026 at 05:16:17PM +0800, Changbin Du wrote:
> > > Add a new 'atomic' collection to perf bench for benchmarking
> > > compare-and-swap (CAS) atomic operations with multi-threaded
> > > contention testing.
> > > 
> > > The benchmark tests __atomic_compare_exchange_n operations
> > > with configurable thread count and iteration count to measure
> > > atomic contention effects.
> > > 
> > > Why this benchmark is needed:
> > > - CAS operations are fundamental to lock-free algorithms and data
> > >   structures. Understanding their performance characteristics under
> > >   contention is critical for designing high-performance concurrent
> > >   applications.
> > > - The benchmark helps identify atomic operation latency and
> > >   scalability issues across different thread counts, revealing
> > >   contention patterns that are not visible in single-threaded tests.
> > > - Useful for evaluating atomic implementation quality on different
> > >   architectures and for regression testing after changes to atomic
> > >   primitives or memory ordering.
> > > 
> > > Measurement methodology:
> > > - Each thread starts a private timer (clock_gettime CLOCK_MONOTONIC)
> > >   after synchronizing on a pthread_barrier, ensuring all threads
> > >   begin simultaneously.
> > > - Each thread performs a hot loop of atomic compare-and-swap on a
> > >   shared u64 counter, incrementing from 0 to iterations.
> > > - The shared counter is cache-line aligned (64 bytes) to isolate
> > >   contention to the target cache line and avoid false sharing.
> > > - The wall-clock time is measured as the max of all per-thread
> > >   runtimes (the time for the slowest thread to finish).
> > > - The first repeat is excluded from statistics as a warmup phase
> > >   to avoid cache-cold effects.
> > > Example usage:
> > >   $ perf bench atomic cas --threads 2
> > >   # Running 'atomic/cas' benchmark:
> > > 
> > >     Threads: 2, iterations/thread: 100000000, repeats: 10 (warmup: 1)
> > >     Avg wall-clock time: 7365.480 msec  (stddev 66.014 msec)
> > >     Total ops: 200,000,000
> > >     Throughput total: 27,153,697 ops/sec
> > >     Per-thread times and throughput (last repeat):
> > >       fastest:  7510.031 msec  (13315525 ops/sec)
> > >       slowest:  7581.678 msec  (13189692 ops/sec)
> > >       avg:      7545.854 msec  (13252310 ops/sec)
> > > 
> > > Output fields explained:
> > > - Threads: number of contending threads
> > > - iterations/thread: CAS operations each thread performs
> > > - repeats: number of test runs (first is warmup)
> > > - Avg wall-clock time: mean time for all threads to complete
> > > - stddev: standard deviation across repeats
> > > - Total ops: threads x iterations/thread
> > > - Throughput total: aggregate ops/sec across all threads
> > > - Per-thread times: fastest/slowest/avg thread completion time
> > > - Per-thread throughput: per-thread ops/sec (shows scheduling imbalance)
> > 
> > Thanks for the contribution!  I think it's very useful.
> > Just a few suggestions.
> > 
> > 1. it'd be nice to add simple atomic_inc benchmark too.
> > 2. it'd be nice to have an option to try other ordering requirements
> >    than "relaxed".
> > 
> > Thanks,
> > Namhyung
> 
> Thanks for the review!
> 1. Done in v2. The collection now provides atomic inc alongside
> cas, measuring contended __atomic_fetch_add() throughput with the
> same skeleton (barrier-synchronized start, wall-clock taken from the
> slowest thread, warmup repeat). Note that its ops/sec is not
> instruction-level comparable with cas — cas counts successful
> compare-and-swaps only, not the retries and loads in between — which
> the documentation now points out.
> 
> 2. Adding memory-order variants is not necessary because ordering
> has no semantic role in this benchmark. Memory ordering exists to
> constrain the visibility of other memory operations relative to an
> atomic access; its cost and effect only become meaningful in an
> algorithm with additional accesses to order — for example, ordering
> the initialization stores of a new node before publishing a pointer
> with a release CAS. This benchmark, however, measures a single shared
> counter with no other memory operations in the loop, so a stronger
> ordering would not order anything of consequence: it would only
> measure the marginal cost of the stronger instruction itself. Those
> numbers would say nothing about how orderings behave in real
> workloads, and would therefore add a configuration knob that invites
> misleading comparisons rather than useful measurement.

Agreed that it has no semantics here.  Maybe we can add the option with
a meaningful scenario later.

Thanks,
Namhyung

