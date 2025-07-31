Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ABEE1E51D;
	Thu, 31 Jul 2025 04:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753937512; cv=none; b=cQIKK1chey1YiuIGWeuoW/icQ9IBQSJvGZuqI+p5vMfmROIqwCjk9mBmU78PPvqqz4Anjg0D/N+J28747s7fVMSotdZ5Q1EHCWTX9yjSpOl3Ejap+XP1YmIeUfRbKpF3A4rPT8PW2l3CyT0CfNStjqROnsr9UzoPImTI/TPTrCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753937512; c=relaxed/simple;
	bh=+D8/5nG6PjqSbnTbpU0RdHsDPdSM3cCcRs/hvXTPLLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UcAz0h0zoqiiRYaF/7pPyWVhJEMfkKRyKKqgssFu5CxyrjY1iryI4/Ni5Z6Pp+qC8vABjzdnxrG3Zt9dYTmsPseudLC0UagnuxS/XXRNUP99xeS5WseiK8SoMdp0Omhs3W9KY5p8BIhDubOK0S2iGMbD95YvVTg2c7XmMmUKVBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cz/V6E4g; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cz/V6E4g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6A55C4CEEF;
	Thu, 31 Jul 2025 04:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753937511;
	bh=+D8/5nG6PjqSbnTbpU0RdHsDPdSM3cCcRs/hvXTPLLo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cz/V6E4gB8xsOyr31l9PEOJ75wdVr02VXKxsedXP5TWuCUdFAmafJqBt4pJdCNWzg
	 k6cDt74QFCWK0xuyk1KhnX2JrJ/o+vg8f8b1PghbU4uQLuD7SMDSkIvIyLd8k5IR3M
	 Fnzsm/CwT8uPLbRvWkWf844CGal09Uga172/g61A3jMF76nIQcUA+IBZVyzcmzPQXt
	 yCiyeNvlXBkfmsSMM/hiwqsETWkp75fbDq9fjuSU/2uqoQ2750JKRJjdQWpu3ZcaFl
	 N7eDx2c8jEETm3gqcWnaYEn1mPbTSw7MqAHMtkygJ+g2opRMf8Jse4oI1CSXaQsc6b
	 y6LFjHGAgY73A==
Date: Wed, 30 Jul 2025 21:51:49 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Yuzhuo Jing <yuzhuo@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
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
Message-ID: <aIr2ZdxmuBoCmDhw@google.com>
References: <20250729022640.3134066-1-yuzhuo@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250729022640.3134066-1-yuzhuo@google.com>

Hello,

On Mon, Jul 28, 2025 at 07:26:33PM -0700, Yuzhuo Jing wrote:
> As an effort to improve the perf bench subcommand, this patch series
> adds benchmark for the kernel's queued spinlock implementation.
> 
> This series imports necessary kernel definitions such as atomics,
> introduces userspace per-cpu adapter, and imports the qspinlock
> implementation from the kernel tree to tools tree, with minimum
> adaptions.

But I'm curious how you handled difference in kernel vs. user space.
For example, normally kernel spinlocks imply no preemption but we cannot
guarantee that in userspace.

> 
> This subcommand enables convenient commands to investigate the
> performance of kernel lock implementations, such as using sampling:
> 
>     perf record -- ./perf bench sync qspinlock -t5
>     perf report

It'd be nice if you can share an example output of the change.

Thanks,
Namhyung

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
