Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6740A3CEBB8
	for <linux-perf-users@vger.kernel.org>; Wed,  7 Oct 2026 05:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791350933; cv=none; b=udLwfsVk1Mc3EZ5nwJjuyN855suA7ZS/6K7pMT3gXnFDRLFmEH+0o2UJKV9mCY6xjlTbtKB+jWDdxLNm/WxRvMUM1ZvCcVijSnFn0dNx7cwuP/8/2k89vrl7K0/Txamxylg7kv5LE5TPhiWpsJWloaiCfQkQNmQROQzYX/yn6wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791350933; c=relaxed/simple;
	bh=9BLxi1iOxS8u1n7nbPWTBX+5RRsaGfEipyAQKq7zRFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fHgq8Pmx5916SthgLcS3MUCiFrJtH4KlDsgVxe7pcM6JcN576izTQMxv/F5lUZcW+QaBtW3IfDYOKml25J2p43Uc2JqKCoE49oGbL06kwj+a0KZjDKNMDMXWPwyMdSDOrP0qUjjc657QSX4UKWEgjYf31FfvCVahcPuDTpasHL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IDgB19Hw; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IDgB19Hw"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cc52c1b8286so892895a12.1
        for <linux-perf-users@vger.kernel.org>; Tue, 06 Oct 2026 22:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791350932; x=1791955732; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Z9vZgGPrpeSf9tM8Tqy/pIg9qeR0AcwpeuIorHxZ0+0=;
        b=IDgB19Hw+Htt6U+Vnwctn5b3TBoLDnqU9eWLDCwwDOuOsLeeAxVSLH/Tou4LcOs+l0
         zu/+m2xWLduwHTLx1RBZ/9MBw7dBu2HXho8kQFGHd+zXKqeLbuOhj5PS0NvAzWEEvH0i
         kMr7J7kpsoKGI3m1RoO4BaOZcdxkviPjajH5eXCMxgA1yQpAKJO8Ka9J+uXECZ1B0L6o
         0ShDd9V1tmwFoCrFkGkFUwHVgpka2Ft9YlXotixmEaMhr0D9fo6isOKRf6TsGrl4+GQc
         M3YffO3nV1e2cSJdj3tvM2sBp6Z2KMHaFDQG7Ei+nSrC7F/2f7j0ylbUV6qNKvkoMrqT
         5Isw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791350932; x=1791955732;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Z9vZgGPrpeSf9tM8Tqy/pIg9qeR0AcwpeuIorHxZ0+0=;
        b=iXGb/iY5DQacsRvrjpP4PerbFfDHwv5l/XDqA17iWG/NQSXRu1msOMdwZxGMfIbjrB
         pXbTnIheYQx/CfcKFpdzNIepxqVQCvguwKChhFCkLWnKRtdybcTTQmgkw7DVu0GPhqte
         KQDyNi6vMrNoyt00TKcXB+EXTSo45a1uO6sFtX61UxlW5cY4lSkPfzfQZezVJ8bfViaf
         GT+4DEeXs7NTXqlIGvS7a5RZSfe56gR8DVpMLjKrcHS6xq01R1+uGmBXH5W7Y5UyFRyd
         tL16xiHGQCP7JeQycUT1DLU1vWh/pHLhwNV0W3kOaM472dB5nznisd30xLDzluuazbX1
         19xg==
X-Forwarded-Encrypted: i=1; AKwUvBw+FpEoMGdUavFAw9/2Pgp43RYRY3U3e0SYNOg6AEBOEh8kqYGn4MbFnCE8YOiT5B5AqeUVXfK2nWRIbn8/1sKs@vger.kernel.org
X-Gm-Message-State: AFuF++n1Qy0P91M6eKnfNm207//c5f+/VwyjUDC8D8nEpFVu+Y7jFyEA
	wVXpEBM0g6ozkbmjuxh2K9zO0B0KLz0MKutGPsHw5FmTa1j5erUpWhhk
X-Gm-Gg: AYBFou2sI/hvOawMv2KpbB0fbcEMhdtYRkclyjziTvLdOTUToNKJUsV4AM5SjRdf4IQ
	GG+I/yzotUXOTiSzK0cQCMctARcKzqXJzz3IXc/oP2bhgYA8IB8qPcNwiimx86vz8WU/I+yaTb7
	ZMmWL16K9Q/DGTJzH0mRBJ2WpSYIY62SA3d0sJzHe/vyBQgsG+nBXRszoxKwRg4eOJMQyvTeMKx
	U+KIPNQSXO2r2QckX/kKIaCof4T1FPE59EwQfqhP7cGazlbvpMaymjASB381+DePDIC4sMFwLz5
	/CvEHKUyMwqFmWX4OJ8j6kRvIGhSYvnSvtHz7LlSqIQLX0+03UGgEZMHrsO+CTB7tD2o1Dp7D6E
	grTgGZ3C1Mmynwg5YkUuuR25zhY/29WpIkvMYIzftQPcTJo6cTFtKclcxw9ogSZykJOd8pWQz9+
	HboC5gwr2N1PDzS68Enl7pHqrt/5fOEnnrHDeGDtAkf4EIXRpKNHdrOoP36clCgMKqIGDtclzzJ
	/grYKplS3EB1Q==
X-Received: by 2002:a05:6300:4083:b0:3d8:e57a:5a5b with SMTP id adf61e73a8af0-3e133db546amr698677637.5.1791350931596;
        Tue, 06 Oct 2026 22:28:51 -0700 (PDT)
Received: from mail.google.com ([5.34.221.10])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89189cdfd79sm793620b3a.52.2026.10.06.22.27.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 22:28:50 -0700 (PDT)
Date: Wed, 7 Oct 2026 13:27:36 +0800
From: Changbin Du <changbin.du@gmail.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Changbin Du <changbin.du@gmail.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf bench: Add atomic CAS benchmark
Message-ID: <asXXZJzEPoEsMSni@mail.google.com>
References: <20260930091617.4189736-1-changbin.du@gmail.com>
 <asQlFvclL-vj5xlh@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <asQlFvclL-vj5xlh@google.com>

Hello,
On Mon, Oct 05, 2026 at 03:30:46PM -0700, Namhyung Kim wrote:
> Hello,
> 
> On Wed, Sep 30, 2026 at 05:16:17PM +0800, Changbin Du wrote:
> > Add a new 'atomic' collection to perf bench for benchmarking
> > compare-and-swap (CAS) atomic operations with multi-threaded
> > contention testing.
> > 
> > The benchmark tests __atomic_compare_exchange_n operations
> > with configurable thread count and iteration count to measure
> > atomic contention effects.
> > 
> > Why this benchmark is needed:
> > - CAS operations are fundamental to lock-free algorithms and data
> >   structures. Understanding their performance characteristics under
> >   contention is critical for designing high-performance concurrent
> >   applications.
> > - The benchmark helps identify atomic operation latency and
> >   scalability issues across different thread counts, revealing
> >   contention patterns that are not visible in single-threaded tests.
> > - Useful for evaluating atomic implementation quality on different
> >   architectures and for regression testing after changes to atomic
> >   primitives or memory ordering.
> > 
> > Measurement methodology:
> > - Each thread starts a private timer (clock_gettime CLOCK_MONOTONIC)
> >   after synchronizing on a pthread_barrier, ensuring all threads
> >   begin simultaneously.
> > - Each thread performs a hot loop of atomic compare-and-swap on a
> >   shared u64 counter, incrementing from 0 to iterations.
> > - The shared counter is cache-line aligned (64 bytes) to isolate
> >   contention to the target cache line and avoid false sharing.
> > - The wall-clock time is measured as the max of all per-thread
> >   runtimes (the time for the slowest thread to finish).
> > - The first repeat is excluded from statistics as a warmup phase
> >   to avoid cache-cold effects.
> > Example usage:
> >   $ perf bench atomic cas --threads 2
> >   # Running 'atomic/cas' benchmark:
> > 
> >     Threads: 2, iterations/thread: 100000000, repeats: 10 (warmup: 1)
> >     Avg wall-clock time: 7365.480 msec  (stddev 66.014 msec)
> >     Total ops: 200,000,000
> >     Throughput total: 27,153,697 ops/sec
> >     Per-thread times and throughput (last repeat):
> >       fastest:  7510.031 msec  (13315525 ops/sec)
> >       slowest:  7581.678 msec  (13189692 ops/sec)
> >       avg:      7545.854 msec  (13252310 ops/sec)
> > 
> > Output fields explained:
> > - Threads: number of contending threads
> > - iterations/thread: CAS operations each thread performs
> > - repeats: number of test runs (first is warmup)
> > - Avg wall-clock time: mean time for all threads to complete
> > - stddev: standard deviation across repeats
> > - Total ops: threads x iterations/thread
> > - Throughput total: aggregate ops/sec across all threads
> > - Per-thread times: fastest/slowest/avg thread completion time
> > - Per-thread throughput: per-thread ops/sec (shows scheduling imbalance)
> 
> Thanks for the contribution!  I think it's very useful.
> Just a few suggestions.
> 
> 1. it'd be nice to add simple atomic_inc benchmark too.
> 2. it'd be nice to have an option to try other ordering requirements
>    than "relaxed".
> 
> Thanks,
> Namhyung

Thanks for the review!
1. Done in v2. The collection now provides atomic inc alongside
cas, measuring contended __atomic_fetch_add() throughput with the
same skeleton (barrier-synchronized start, wall-clock taken from the
slowest thread, warmup repeat). Note that its ops/sec is not
instruction-level comparable with cas — cas counts successful
compare-and-swaps only, not the retries and loads in between — which
the documentation now points out.

2. Adding memory-order variants is not necessary because ordering
has no semantic role in this benchmark. Memory ordering exists to
constrain the visibility of other memory operations relative to an
atomic access; its cost and effect only become meaningful in an
algorithm with additional accesses to order — for example, ordering
the initialization stores of a new node before publishing a pointer
with a release CAS. This benchmark, however, measures a single shared
counter with no other memory operations in the loop, so a stronger
ordering would not order anything of consequence: it would only
measure the marginal cost of the stronger instruction itself. Those
numbers would say nothing about how orderings behave in real
workloads, and would therefore add a configuration knob that invites
misleading comparisons rather than useful measurement.
