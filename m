Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BA93FE348
	for <linux-perf-users@vger.kernel.org>; Thu,  8 Oct 2026 07:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791445497; cv=none; b=mDSLr+HMiMbGupg6KjRJTHl6Vt5znFw5Wh+RtVFqgqRuSaJ+u8Z6R736zeiV906Pfj6C2VCMV8Lj50uL8PfFKqvxy70172by/nM02xAlz4lVQjWcVFAV1txkQ5EuAJ9BHGVBXV6ot//e+4O67FzLoeLGkdZN5da5JBOoqfi/aWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791445497; c=relaxed/simple;
	bh=ajiALRBG+uLF/FyUtt4O4djMH9+/M2s+8Yt/b/qL4Tg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OEUW+ARalhPW0VRbD+PFQEBqPJ4Mf9gPsC7BzED2RJlyNPKjZ4qRVWocpoBzgwFo3rqbNL3DX1wutQ0izemKcolNow7Cz7SvW0rBsTvyoWO9CPYaaLW5G4FmfPER7i3yFwBT02Q3iBw0YisPMBN4MRhou3sEl5RjHtHqNil864A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ouUY31Yw; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ouUY31Yw"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-487049569b6so1859749f8f.1
        for <linux-perf-users@vger.kernel.org>; Thu, 08 Oct 2026 00:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791445492; x=1792050292; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2+65PmeGU2pObojaDMqRZq6O86JoQo/QbeOjqEwMad4=;
        b=ouUY31YwyOQgLZBFtYyHHBaFUmxk98Mq29w11P3UGFmTix75XSD98bWN2jMylDuvve
         rRzy9q1cemDSawMl+IxXWeX7/vaNCfKFg5/r1pzdYAaKWii0ZFCdgMlLI62WzpyaLqe1
         SekWmxrfjBO9juYhyD+vqqZbtbCOyHvEFyI7wsGgQsrLH6y7tNwZ2Io+HD2sX6PXcOat
         EI8cvelqoh+ZTEfImfzyKlekVbtF7t7d2SJeGZFqTk2eNJDKoA+ym87FUrwopoB0BuSI
         K5Q8tzb1bGuQ5/38DSDojJ0Pfg22GLwFv71jK2Agt6aLvej/Z9O0ELl46Fsssp5VoKG9
         CjFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791445492; x=1792050292;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2+65PmeGU2pObojaDMqRZq6O86JoQo/QbeOjqEwMad4=;
        b=04cdtH0Q2uzkOPDv4oyrW6mzw35K1IBVVq4m69fpjd90llovrfpt6qY2jDegtTL6zZ
         9xKuX2fPs8T8S/ZhgrSYQ/jy2E22tC/DfldFstJAeOJ0ptRA/ZLlXPiuqSLY8fwjRoEn
         ML/hJ10ss62lnY9t+ePakTeeQpkZQsZDP+3Z1t6J+PL3zvcbmE34e239dauuMzXq46Gh
         bTIDDKHyEt9fQoU074yvrq6DZk4n0PI8rW7KJ3D1MGIdyNnq5izU++ptuBRJ/OEJaBBU
         IFA0hNITOrJSI/8L3oowJq5LydCP7N+n+oEFMC5TguP/9rdq9eBOjtmebljkiijgRi7X
         TxeQ==
X-Forwarded-Encrypted: i=1; AKwUvByxkbXh7OG/TkwiIYrf6hCywcVxDJ/oPINl2/L/w80Rh6XjWnFmNbdtusrkVGHEn5nKup4JtJzrzBOv5HTMIAYM@vger.kernel.org
X-Gm-Message-State: AFuF++ldvtSpALbd2necNvlRy3PQZUQReb8knP18hZ54oRHrQVL9MtpN
	7e64VRPjBnc52AQYt4SHVGNKvBTa0PNgtcmtpCYJv2XJ9rQjhSFDe5un
X-Gm-Gg: AYBFou1LORp4NXhvlYu3eTHfX1BswvxvthaBMjELo1aVmhZ46Qzl5xBOKzpAJ05GRkp
	AMw5RVoS2lfDkXZLktBgxj4ZV+pDDz8iJmSKiViTZBBaJ3GQXVz2hFuI5l+ugqT5FLtwgioRGtt
	fazeI6CRwvvpUyqeRtY+uOkkZkoiLgzCMszRMCmhLfu2GlCNAnLfdWXf5QXfxTixeCipXJfjQ9/
	ei4rQOtRQFadl6b+CoTXFCAquY6MY26NB5GyZzJIyjJmWic2wvwoMCZNbDWjRCgLsamNgkT6FB4
	N06E9NUy0de0VjYlj2Tu/hUsEcR4vsLxNsgA9SHpSJuE/0Aq2hSoOrFRwtrOAHMXGHXCpNqsJsS
	GXb7Chh+8PZDXryd72afQxyZmLYLftkfKMSssdv0ZbxqN6T6Pwl/UBv3u8EJXuZHJB1ckoO3hwO
	gB1TnOpA3xmf7yabQTmDgvR3bdzJP7T0TyFcvD3LMm1+otWfLT30cVsqcCnxY6GOgl2wLnP7T7f
	7TM/xo80aTDxUCVgnXoY23WaHlLW2gbN0U=
X-Received: by 2002:a05:600c:83c4:b0:4a0:17a:8844 with SMTP id 5b1f17b1804b1-4a1800d3d5bmr77042795e9.1.1791445491496;
        Thu, 08 Oct 2026 00:44:51 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1843b5a2esm48410145e9.11.2026.10.08.00.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 00:44:50 -0700 (PDT)
Date: Thu, 8 Oct 2026 08:44:49 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Changbin Du <changbin.du@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
 <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander
 Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa
 <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, Adrian Hunter
 <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf bench: Add atomic CAS benchmark
Message-ID: <20261008084449.5d9971ad@pumpkin>
In-Reply-To: <20260930091617.4189736-1-changbin.du@gmail.com>
References: <20260930091617.4189736-1-changbin.du@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 30 Sep 2026 17:16:17 +0800
Changbin Du <changbin.du@gmail.com> wrote:

> Add a new 'atomic' collection to perf bench for benchmarking
> compare-and-swap (CAS) atomic operations with multi-threaded
> contention testing.
> 
> The benchmark tests __atomic_compare_exchange_n operations
> with configurable thread count and iteration count to measure
> atomic contention effects.
> 
> Why this benchmark is needed:
> - CAS operations are fundamental to lock-free algorithms and data
>   structures. Understanding their performance characteristics under
>   contention is critical for designing high-performance concurrent
>   applications.
> - The benchmark helps identify atomic operation latency and
>   scalability issues across different thread counts, revealing
>   contention patterns that are not visible in single-threaded tests.
> - Useful for evaluating atomic implementation quality on different
>   architectures and for regression testing after changes to atomic
>   primitives or memory ordering.
> 
> Measurement methodology:
> - Each thread starts a private timer (clock_gettime CLOCK_MONOTONIC)
>   after synchronizing on a pthread_barrier, ensuring all threads
>   begin simultaneously.
> - Each thread performs a hot loop of atomic compare-and-swap on a
>   shared u64 counter, incrementing from 0 to iterations.
> - The shared counter is cache-line aligned (64 bytes) to isolate
>   contention to the target cache line and avoid false sharing.
> - The wall-clock time is measured as the max of all per-thread
>   runtimes (the time for the slowest thread to finish).
> - The first repeat is excluded from statistics as a warmup phase
>   to avoid cache-cold effects.
> Example usage:
>   $ perf bench atomic cas --threads 2
>   # Running 'atomic/cas' benchmark:
> 
>     Threads: 2, iterations/thread: 100000000, repeats: 10 (warmup: 1)
>     Avg wall-clock time: 7365.480 msec  (stddev 66.014 msec)
>     Total ops: 200,000,000
>     Throughput total: 27,153,697 ops/sec
>     Per-thread times and throughput (last repeat):
>       fastest:  7510.031 msec  (13315525 ops/sec)
>       slowest:  7581.678 msec  (13189692 ops/sec)
>       avg:      7545.854 msec  (13252310 ops/sec)
> 
> Output fields explained:
> - Threads: number of contending threads
> - iterations/thread: CAS operations each thread performs
> - repeats: number of test runs (first is warmup)
> - Avg wall-clock time: mean time for all threads to complete
> - stddev: standard deviation across repeats
> - Total ops: threads x iterations/thread
> - Throughput total: aggregate ops/sec across all threads
> - Per-thread times: fastest/slowest/avg thread completion time
> - Per-thread throughput: per-thread ops/sec (shows scheduling imbalance)
> 

I think you need to default to one thread per cpu.
Also try to run the test for a fixed time period rather than a very
large count.
You should be able to see that some systems completely fail to make
progress under very heavy contention.
(This isn't one thread getting starved, none of them make progress.)

David
