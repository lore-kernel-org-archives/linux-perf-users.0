Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792475118;
	b=KTY3zehVxVkcJtYq6tAmLMihk3VtNpBLd3NLMqUaJD9+LxsAEeJMAt4PQgzPuT4Nj2We
	 Eoa2dovG42kPNkGUWFHb/iV9k05opqZsnzuMFIJ9dmuIe0P5hOVtlhJc8BZYB3WX7lhP0
	 XjrTRNOcCdLickEKRhv2s/cQSfq8C5YLKKofMyjJtM/cZKcqximra8Py/tzbdhGPt5DnM
	 vNaRJvC5YUBN5W4JvVgM/UHzq8cgHUmw+r04DPhmFasifii8/Fnw/XcTVoULGf+s06VZW
	 aSTopwqb95RALOtNyM/zFyU5jwMx03COKevg4wDKz+6Ao+GIPsD6sPRqn40qqQUMxnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792475118;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=tEdN/iM1JPmtngUml9AOVZRoTPizOmSCQoltxjzcxPQ=;
	b=E1KdyWn6PYbiahCJz0ZiEYEI56cZUyz+X9sqn5feOcdERJJCbYH6a8h26yomrQLLblgb
	 4zqr0rSUEJa3TQ7XVsUhjEiGCfWNJC3h57rqP1KNJpXoRqZAxr+WV38d6Q+mXwWaw7Zvh
	 aP7kIjrhmiQ+eaSDLTPBGNa1gAq52GAcrSrZgUtZyYdk5j4beIbZWvkaIvDePI8Ky4Mkg
	 Q7vHIMXFSsLgt//CADawkmr5T2HEV5Tf9qaR6a0wJGfFlzGNULUjwP9MBV1ZLo1NCW+d1
	 woxA9+6YRtgIciqDmLu8Ot8fyjsTQ3Wue3meuyii2nVuDqOhwbOMBvK2NXbQrACduJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="a/y7oxwa";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25762606A31C;
	Tue, 20 Oct 2026 05:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a/y7oxwa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CF981F000C4;
	Tue, 20 Oct 2026 05:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792475117;
	bh=tEdN/iM1JPmtngUml9AOVZRoTPizOmSCQoltxjzcxPQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=a/y7oxwaF5lWXyjb+VWiqy3bBCy3MOloj6Q51j0WN8raQPFht5u41qK6FMxkL0oWn
	 HYzoJ9qo4mciwhbjziuLnuW4VivQoDg7BxmhJZVoLDgtjxYvpSE4OVFQi0cNmz9EQN
	 sZ8nSYZ71e9CLxKqdUrfaQwLCtnYronJK/N1uvMyIDYFyPb3KR5Ai0Te8uKMXZ9Wfw
	 9gm2zShOA4X3NWldsmW3pFzYrdZGXNW/2QQfC8aznoN1MZarOzHmac6qLe8VKMhuQO
	 xkTs8pBqhr3Rxbe+ySYAsCQchKl8ZgDyayXKayqtFBj8vmoh8Co+GM0cl/X6gCntMj
	 0R32KJv8VWiKg==
Date: Mon, 19 Oct 2026 22:45:15 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Changbin Du <changbin.du@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	David Laight <david.laight.linux@gmail.com>
Subject: Re: [PATCH v5] perf bench: Add atomic operations benchmark
Message-ID: <atb_6wO-BN_cklar@z2>
References: <20261016075552.1759260-1-changbin.du@gmail.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261016075552.1759260-1-changbin.du@gmail.com>

On Fri, Oct 16, 2026 at 03:55:52PM +0800, Changbin Du wrote:
> Add a new 'atomic' collection to perf bench for benchmarking
> atomic read-modify-write operations with multi-threaded
> contention testing. It provides two subcommands:
> 
>   - atomic cas: contended compare-and-swap operations
>     (__atomic_compare_exchange_n)
>   - atomic inc: contended fetch-add operations (__atomic_fetch_add)
> 
> Both support a configurable thread count and runtime to measure
> atomic contention effects.
> 
> Why this benchmark is needed:
> - Atomic read-modify-write operations are fundamental to lock-free
>   algorithms and data structures. Understanding their performance
>   characteristics under contention is critical for designing
>   high-performance concurrent applications.
> - The benchmark helps identify atomic operation latency and
>   scalability issues across different thread counts, revealing
>   contention patterns that are not visible in single-threaded tests.
> - Useful for evaluating atomic implementation quality on different
>   architectures and for regression testing after changes to atomic
>   primitives or memory ordering.
> 
> Measurement methodology:
> - By default two threads contend for the counter, enough to expose
>   the contention effect; use -t to scale the count.
> - Each thread starts a private timer (clock_gettime CLOCK_MONOTONIC)
>   after synchronizing on a pthread_barrier, ensuring all threads
>   begin simultaneously.
> - Each thread performs a hot loop of the selected atomic operation
>   (compare-and-swap or fetch-add) on a shared unsigned long counter
>   for a fixed runtime. It counts its own completed operations in a
>   local variable, and the loop runs in batches so the termination
>   flag is only polled between batches.
> - The main thread sleeps for the runtime and then sets the flag; the
>   throughput of a repeat is the total operation count divided by the
>   measured wall time (the max per-thread runtime).
> - The shared counter is cache-line aligned (64 bytes) to isolate
>   contention to the target cache line and avoid false sharing.
> - The per-thread operation counts of the last repeat show whether
>   any thread failed to make progress under contention.
> - The first repeat is excluded from statistics as a warmup phase
>   to avoid cache-cold effects.
> 
> Example usage:
>   $ perf bench atomic all
>   # Running atomic/cas benchmark...
>     Threads: 2, runtime: 2 sec, repeats: 10 (warmup: 1)
>     Avg throughput: 68,599,954 ops/sec (+- 0.13%)
>     Per-thread ops (last repeat):
>       fastest:  74,842,112 ops
>       slowest:  63,176,704 ops
>       avg:      69,009,408 ops
> 
>   # Running atomic/inc benchmark...
>     Threads: 2, runtime: 2 sec, repeats: 10 (warmup: 1)
>     Avg throughput: 128,428,772 ops/sec (+- 0.54%)
>     Per-thread ops (last repeat):
>       fastest:  146,230,272 ops
>       slowest:  112,825,344 ops
>       avg:      129,527,808 ops
> 
> Output fields explained:
> - Threads: number of contending threads
> - runtime: seconds each thread runs per repeat
> - repeats: number of test runs (first is warmup)
> - Avg throughput: mean aggregate ops/sec across repeats
> - +- %: relative standard error of the mean throughput across repeats
> - Per-thread ops: fastest/slowest/avg operations per thread in the
>   last repeat (shows scheduling imbalance and lack of progress)
> 
> Assisted-by: opencode:DeepSeek-V4-Pro
> Signed-off-by: Changbin Du <changbin.du@gmail.com>

Reviewed-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung
