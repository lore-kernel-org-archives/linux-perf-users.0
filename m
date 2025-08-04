Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D44E1A4E70;
	Mon,  4 Aug 2025 14:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754317704; cv=none; b=I/f9GxP8qpAliwHbaFOPGsm7z1aR3YrIHo+RA/GdPdUUpSc1+kJ1v4rxOfz02UhqHmPD7rrWVmR5e0ZkKHEGScR4IjwSzIz06HPpxozl8aDFWCuoc767OFkTicyT1J/b1htvl4JGuu7M8WonvV8kVv0zryTCbXZ3TxEvTarYiUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754317704; c=relaxed/simple;
	bh=JgWY27q5R1KLqQGS/pspjK6FYiCa98kFd+ZRH4tz9Xk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WBJNcZEna3t3ur4Vl+dUswseHwx8VcSdoxuEZjO/sQMUERgBK3CpeFRwW26t+una6DKbcfEuWc9+eV7TMeLKnHzELZVn1Limz6EsRBxo0Yqo0+PHZCfYhKH7nKJXjdbitabmlrtM22cJ6Neh9Ht0iotOvv+3Qzlz0l/PJR2s4D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AA39B150C;
	Mon,  4 Aug 2025 07:28:13 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 280523F738;
	Mon,  4 Aug 2025 07:28:18 -0700 (PDT)
Date: Mon, 4 Aug 2025 15:28:12 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Yuzhuo Jing <yuzhuo@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Liang Kan <kan.liang@linux.intel.com>, Yuzhuo Jing <yzj@umich.edu>,
	Andrea Parri <parri.andrea@gmail.com>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Barret Rhoden <brho@google.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Guo Ren <guoren@kernel.org>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v1 0/7] perf bench: Add qspinlock benchmark
Message-ID: <aJDDfCKFXFQOJ134@J2N7QTR9R3>
References: <20250729022640.3134066-1-yuzhuo@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250729022640.3134066-1-yuzhuo@google.com>

On Mon, Jul 28, 2025 at 07:26:33PM -0700, Yuzhuo Jing wrote:
> As an effort to improve the perf bench subcommand, this patch series
> adds benchmark for the kernel's queued spinlock implementation.
> 
> This series imports necessary kernel definitions such as atomics,
> introduces userspace per-cpu adapter, and imports the qspinlock
> implementation from the kernel tree to tools tree, with minimum
> adaptions.

Who is this intended to be useful for, and when would they use this?

This doesn't serve as a benchmark of the host kernel, since it tests
whatever stale copy of the qspinlock code was built into the perf
binary.

I can understand that being able to test the code in userspace may be
helpful when making some changes, but why does this need to be built
into the perf tool?

Mark.

> This subcommand enables convenient commands to investigate the
> performance of kernel lock implementations, such as using sampling:
> 
>     perf record -- ./perf bench sync qspinlock -t5
>     perf report
> 
> Yuzhuo Jing (7):
>   tools: Import cmpxchg and xchg functions
>   tools: Import smp_cond_load and atomic_cond_read
>   tools: Partial import of prefetch.h
>   tools: Implement userspace per-cpu
>   perf bench: Import qspinlock from kernel
>   perf bench: Add 'bench sync qspinlock' subcommand
>   perf bench sync: Add latency histogram functionality
> 
>  tools/arch/x86/include/asm/atomic.h           |  14 +
>  tools/arch/x86/include/asm/cmpxchg.h          | 113 +++++
>  tools/include/asm-generic/atomic-gcc.h        |  47 ++
>  tools/include/asm/barrier.h                   |  58 +++
>  tools/include/linux/atomic.h                  |  27 ++
>  tools/include/linux/compiler_types.h          |  30 ++
>  tools/include/linux/percpu-simulate.h         | 128 ++++++
>  tools/include/linux/prefetch.h                |  41 ++
>  tools/perf/bench/Build                        |   2 +
>  tools/perf/bench/bench.h                      |   1 +
>  .../perf/bench/include/mcs_spinlock-private.h | 115 +++++
>  tools/perf/bench/include/mcs_spinlock.h       |  19 +
>  tools/perf/bench/include/qspinlock-private.h  | 204 +++++++++
>  tools/perf/bench/include/qspinlock.h          | 153 +++++++
>  tools/perf/bench/include/qspinlock_types.h    |  98 +++++
>  tools/perf/bench/qspinlock.c                  | 411 ++++++++++++++++++
>  tools/perf/bench/sync.c                       | 329 ++++++++++++++
>  tools/perf/builtin-bench.c                    |   7 +
>  tools/perf/check-headers.sh                   |  32 ++
>  19 files changed, 1829 insertions(+)
>  create mode 100644 tools/include/linux/percpu-simulate.h
>  create mode 100644 tools/include/linux/prefetch.h
>  create mode 100644 tools/perf/bench/include/mcs_spinlock-private.h
>  create mode 100644 tools/perf/bench/include/mcs_spinlock.h
>  create mode 100644 tools/perf/bench/include/qspinlock-private.h
>  create mode 100644 tools/perf/bench/include/qspinlock.h
>  create mode 100644 tools/perf/bench/include/qspinlock_types.h
>  create mode 100644 tools/perf/bench/qspinlock.c
>  create mode 100644 tools/perf/bench/sync.c
> 
> -- 
> 2.50.1.487.gc89ff58d15-goog
> 
