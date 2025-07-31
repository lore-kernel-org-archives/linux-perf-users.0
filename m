Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4163A2BE633
	for <linux-perf-users@vger.kernel.org>; Thu, 31 Jul 2025 13:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753967988; cv=none; b=f/YB2/ZdiuNrO9qH77MrnBkK4NOyNpqObw5hX5H6deVbPBtQT0xrIuvg9hYg30542XWCyit5m+bs50NOpGEQu/YfFKe8QErLz4CkpyiuKKGuWMSngy9CFw9ERuCq5Td4AQc2i2eXs9Mge6Awx3CgyZTOxjz1qsnfqDB0mTKG+m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753967988; c=relaxed/simple;
	bh=q/0CwU72oOdZIuLDyG6/09Fp7D/WRRSWRcFUYu9Yd8k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RPFHQW1wnXhRFpmV8Ln3N8k/6fo3CGDLtsG5Hc+eeMhCbH2/UJ/YxNbOSzqZCsMMcT95pf5jVn3aL1CPAVIlXmbbr3W8s6naSnelR7bBLPHTunzflO6rdw1ZEUdCSVcyynEgrdrijOxzFX1/SEpZoT06RCTE7m5dzWeMo4sB4PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zSOUiJfd; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zSOUiJfd"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ae0dffaa8b2so170365366b.0
        for <linux-perf-users@vger.kernel.org>; Thu, 31 Jul 2025 06:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753967984; x=1754572784; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=erlQ/LLHQExO1WKTcytAJrwyzb9h0x78zkEBmeizUwE=;
        b=zSOUiJfdgmNG2vH3VgmRvHRp8FCHOxkSawu/pXo3+b50162lQcIebl/cBqBvFNk4OA
         ou0+LxoyLKg6mNFm1WbDoggtnkN5y28/lc5qorcH0Hiw4zB+TvwGnsEzmM7P2Q4jzoiq
         qa1gVRcV220NSAgLEREVTkRhd8gWsHS8y4BoObVsTA9dVIOgbZMgQGvGU2LVsN8jhZsA
         /ZnFdECpqL+nVpDLUqBAWQNS3IOM1ixMetZ2S49lxormy9kXYiWv7JPLbMruEb89gZz3
         lMEPKJxVEiD4nifGv3SUeI16p/QSRsefkM3rfZzwBpgIXwoU4ROdlFg6a1gzhZhoOk/d
         ISNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753967984; x=1754572784;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=erlQ/LLHQExO1WKTcytAJrwyzb9h0x78zkEBmeizUwE=;
        b=WG+kcscXQXSEsIMhz8pya5qbxoiBEQISdDktHVoxJdlobZ8PmDKXbbK4mIt5ofvkXB
         MLizLM3rG+0Zq+33Z2Xq9A9KzZDf7cp1RiSo2y4EOy7tRvKSBpWSSG364YXzA90BEn9u
         1IKUxy4QqKe43FprjeNZWCa28Pe1V6Jhf+GTXSKvF8vGN8/BjEZBH64C/eVvqzpLxOUm
         VyQRmEmVLXgiFLMeQEQE6yogJNrMS0QwqqksDOrZ38yrCi3/P3kcorGTr0+vAK8DoNop
         C6kYj9Q4g4lvE/J1exvvjto0Ad3JPoJwl5Ysff2sWY1C4KXVjlq1zi4vn0gh0Ct9LZ7j
         4awg==
X-Forwarded-Encrypted: i=1; AJvYcCWfqZBx7B1B3Dhwuidunn9nCrDjDaAxAi0wBLm7ishReoeemGoJB2xh+uxOtxUbbssYJIy8GM85SRvBQttKJesC@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0gLI6+egVXg3m6ThFjOsNzQGRC9t0Q6iwfmCpeS0ZBgPNIstz
	WHs46NjbE38X7BAvjGaH9q5aKACyARLupb1eGJPXembiHfzqm7zQflSKbQCgR2GhUYDEW0UNjz0
	AP1pPNNFekEcM/hQdj2Hle8IOK8QZqx/SWOuUUvpY
X-Gm-Gg: ASbGnct6zHkvPN+PyQf9Jx/h7miB5KDX+Miz1DrxQkWJv13rk/sHsPESuC8q0xr1hGf
	OHC+Ks0t5b7fEHWzPppBzwz1/KLN68V0I4L0PSrywhw/ohI39EGaGDz0hK9P5BamV/HrNXZd23Q
	c0f81uU2eKCwn54Pt/mz/FtN9g1+gbtEWJncBvTJCZ/ryQS2hQzBx+nUsxlikEZp9vunx3WqVm+
	RDADR3Is/T5l+qB3HKZHyyPkeE7nokbRwdiobcd
X-Google-Smtp-Source: AGHT+IFqJJo1pb4T1+KNXxezny+BBoZpYPMQq8AGiOdfWPyUnAoxZrfZYRXDPA8u8ryltt6YnqLcEfI+U+GvrQxoCfc=
X-Received: by 2002:a17:906:9e16:b0:af9:10c7:59b6 with SMTP id
 a640c23a62f3a-af910c75f97mr317417566b.32.1753967984155; Thu, 31 Jul 2025
 06:19:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250729022640.3134066-1-yuzhuo@google.com> <20250729022640.3134066-7-yuzhuo@google.com>
 <aIr8JuprT1JPNJsq@google.com>
In-Reply-To: <aIr8JuprT1JPNJsq@google.com>
From: Yuzhuo Jing <yuzhuo@google.com>
Date: Thu, 31 Jul 2025 06:19:26 -0700
X-Gm-Features: Ac12FXyIhUFDytjG41oc7SOsf47Ir-TzU6_QHAFGK9ZpLkho8cN3fMKcIYXZnI4
Message-ID: <CADQikVDgFa2pHHsUERpxsEj6ufZYp5cwgQ7z5xXUhvOnmSNk0g@mail.gmail.com>
Subject: Re: [PATCH v1 6/7] perf bench: Add 'bench sync qspinlock' subcommand
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Liang Kan <kan.liang@linux.intel.com>, Yuzhuo Jing <yzj@umich.edu>, 
	Andrea Parri <parri.andrea@gmail.com>, Charlie Jenkins <charlie@rivosinc.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Barret Rhoden <brho@google.com>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Guo Ren <guoren@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 30, 2025 at 10:16=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> On Mon, Jul 28, 2025 at 07:26:39PM -0700, Yuzhuo Jing wrote:
> > Benchmark kernel queued spinlock implementation in user space.  Support
> > settings of the number of threads and the number of acquire/releases.
>
> My general advice is that you'd better add an example command line and
> output in the commit message if you add any user-visible changes.  Also
> please update the Documentation/perf-bench.txt.
>
> Thanks,
> Namhyung

Hi Namhyung. Thanks for the review and for the advice! I will update
the commit messages and documentation later in a v2 patch.

Best regards,
Yuzhuo

> >
> > Signed-off-by: Yuzhuo Jing <yuzhuo@google.com>
> > ---
> >  tools/perf/bench/Build     |   2 +
> >  tools/perf/bench/bench.h   |   1 +
> >  tools/perf/bench/sync.c    | 234 +++++++++++++++++++++++++++++++++++++
> >  tools/perf/builtin-bench.c |   7 ++
> >  4 files changed, 244 insertions(+)
> >  create mode 100644 tools/perf/bench/sync.c
> >
> > diff --git a/tools/perf/bench/Build b/tools/perf/bench/Build
> > index b558ab98719f..13558279fa0e 100644
> > --- a/tools/perf/bench/Build
> > +++ b/tools/perf/bench/Build
> > @@ -19,6 +19,8 @@ perf-bench-y +=3D evlist-open-close.o
> >  perf-bench-y +=3D breakpoint.o
> >  perf-bench-y +=3D pmu-scan.o
> >  perf-bench-y +=3D uprobe.o
> > +perf-bench-y +=3D sync.o
> > +perf-bench-y +=3D qspinlock.o
> >
> >  perf-bench-$(CONFIG_X86_64) +=3D mem-memcpy-x86-64-asm.o
> >  perf-bench-$(CONFIG_X86_64) +=3D mem-memset-x86-64-asm.o
> > diff --git a/tools/perf/bench/bench.h b/tools/perf/bench/bench.h
> > index 9f736423af53..dd6c8b6126d3 100644
> > --- a/tools/perf/bench/bench.h
> > +++ b/tools/perf/bench/bench.h
> > @@ -22,6 +22,7 @@ int bench_numa(int argc, const char **argv);
> >  int bench_sched_messaging(int argc, const char **argv);
> >  int bench_sched_pipe(int argc, const char **argv);
> >  int bench_sched_seccomp_notify(int argc, const char **argv);
> > +int bench_sync_qspinlock(int argc, const char **argv);
> >  int bench_syscall_basic(int argc, const char **argv);
> >  int bench_syscall_getpgid(int argc, const char **argv);
> >  int bench_syscall_fork(int argc, const char **argv);
> > diff --git a/tools/perf/bench/sync.c b/tools/perf/bench/sync.c
> > new file mode 100644
> > index 000000000000..2685cb66584c
> > --- /dev/null
> > +++ b/tools/perf/bench/sync.c
> > @@ -0,0 +1,234 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Synchronization benchmark.
> > + *
> > + * 2025  Yuzhuo Jing <yuzhuo@google.com>
> > + */
> > +#include <bits/time.h>
> > +#include <err.h>
> > +#include <inttypes.h>
> > +#include <perf/cpumap.h>
> > +#include <pthread.h>
> > +#include <stdbool.h>
> > +#include <string.h>
> > +#include <subcmd/parse-options.h>
> > +#include <sys/cdefs.h>
> > +
> > +#include "bench.h"
> > +
> > +#include "include/qspinlock.h"
> > +
> > +#define NS 1000000000ull
> > +#define CACHELINE_SIZE 64
> > +
> > +static unsigned int nthreads;
> > +static unsigned long nspins =3D 10000ul;
> > +
> > +struct barrier_t;
> > +
> > +typedef void(*lock_fn)(void *);
> > +
> > +/*
> > + * Lock operation definition to support multiple implmentations of loc=
ks.
> > + *
> > + * The lock and unlock functions only take one variable, the data poin=
ter.
> > + */
> > +struct lock_ops {
> > +     lock_fn lock;
> > +     lock_fn unlock;
> > +     void *data;
> > +};
> > +
> > +struct worker {
> > +     pthread_t thd;
> > +     unsigned int tid;
> > +     struct lock_ops *ops;
> > +     struct barrier_t *barrier;
> > +     u64 runtime;            // in nanoseconds
> > +};
> > +
> > +static const struct option options[] =3D {
> > +     OPT_UINTEGER('t',       "threads",      &nthreads,
> > +             "Specify number of threads (default: number of CPUs)."),
> > +     OPT_ULONG('n',          "spins",        &nspins,
> > +             "Number of lock acquire operations per thread (default: 1=
0,000 times)."),
> > +     OPT_END()
> > +};
> > +
> > +static const char *const bench_sync_usage[] =3D {
> > +     "perf bench sync qspinlock <options>",
> > +     NULL
> > +};
> > +
> > +/*
> > + * A atomic-based barrier.  Expect to have lower latency than pthread =
barrier
> > + * that sleeps the thread.
> > + */
> > +struct barrier_t {
> > +     unsigned int count __aligned(CACHELINE_SIZE);
> > +};
> > +
> > +/*
> > + * A atomic-based barrier.  Expect to have lower latency than pthread =
barrier
> > + * that sleeps the thread.
> > + */
> > +__always_inline void wait_barrier(struct barrier_t *b)
> > +{
> > +     if (__atomic_sub_fetch(&b->count, 1, __ATOMIC_RELAXED) =3D=3D 0)
> > +             return;
> > +     while (__atomic_load_n(&b->count, __ATOMIC_RELAXED))
> > +             ;
> > +}
> > +
> > +static int bench_sync_lock_generic(struct lock_ops *ops, int argc, con=
st char **argv);
> > +
> > +/*
> > + * Benchmark of linux kernel queued spinlock in user land.
> > + */
> > +int bench_sync_qspinlock(int argc, const char **argv)
> > +{
> > +     struct qspinlock lock =3D __ARCH_SPIN_LOCK_UNLOCKED;
> > +     struct lock_ops ops =3D {
> > +             .lock =3D (lock_fn)queued_spin_lock,
> > +             .unlock =3D (lock_fn)queued_spin_unlock,
> > +             .data =3D &lock,
> > +     };
> > +     return bench_sync_lock_generic(&ops, argc, argv);
> > +}
> > +
> > +/*
> > + * A busy loop to acquire and release the given lock N times.
> > + */
> > +static void lock_loop(const struct lock_ops *ops, unsigned long n)
> > +{
> > +     unsigned long i;
> > +
> > +     for (i =3D 0; i < n; ++i) {
> > +             ops->lock(ops->data);
> > +             ops->unlock(ops->data);
> > +     }
> > +}
> > +
> > +/*
> > + * Thread worker function.  Runs lock loop for N/5 times before and af=
ter
> > + * the main timed loop.
> > + */
> > +static void *sync_workerfn(void *args)
> > +{
> > +     struct worker *worker =3D (struct worker *)args;
> > +     struct timespec starttime, endtime;
> > +
> > +     set_this_cpu_id(worker->tid);
> > +
> > +     /* Barrier to let all threads start together */
> > +     wait_barrier(worker->barrier);
> > +
> > +     /* Warmup loop (not counted) to keep the below loop contended. */
> > +     lock_loop(worker->ops, nspins / 5);
> > +
> > +     clock_gettime(CLOCK_THREAD_CPUTIME_ID, &starttime);
> > +     lock_loop(worker->ops, nspins);
> > +     clock_gettime(CLOCK_THREAD_CPUTIME_ID, &endtime);
> > +
> > +     /* Tail loop (not counted) to keep the above loop contended. */
> > +     lock_loop(worker->ops, nspins / 5);
> > +
> > +     worker->runtime =3D (endtime.tv_sec - starttime.tv_sec) * NS
> > +             + endtime.tv_nsec - starttime.tv_nsec;
> > +
> > +     return NULL;
> > +}
> > +
> > +/*
> > + * Generic lock synchronization benchmark function.  Sets up threads a=
nd
> > + * thread affinities.
> > + */
> > +static int bench_sync_lock_generic(struct lock_ops *ops, int argc, con=
st char **argv)
> > +{
> > +     struct perf_cpu_map *online_cpus;
> > +     unsigned int online_cpus_nr;
> > +     struct worker *workers;
> > +     u64 totaltime =3D 0, total_spins, avg_ns, avg_ns_dot;
> > +     struct barrier_t barrier;
> > +     cpu_set_t *cpuset;
> > +     size_t cpuset_size;
> > +
> > +     argc =3D parse_options(argc, argv, options, bench_sync_usage, 0);
> > +     if (argc) {
> > +             usage_with_options(bench_sync_usage, options);
> > +             exit(EXIT_FAILURE);
> > +     }
> > +
> > +     /* CPU count setup. */
> > +     online_cpus =3D perf_cpu_map__new_online_cpus();
> > +     if (!online_cpus)
> > +             err(EXIT_FAILURE, "No online CPUs available");
> > +     online_cpus_nr =3D perf_cpu_map__nr(online_cpus);
> > +
> > +     if (!nthreads) /* default to the number of CPUs */
> > +             nthreads =3D online_cpus_nr;
> > +
> > +     workers =3D calloc(nthreads, sizeof(*workers));
> > +     if (!workers)
> > +             err(EXIT_FAILURE, "calloc");
> > +
> > +     barrier.count =3D nthreads;
> > +
> > +     printf("Running with %u threads.\n", nthreads);
> > +
> > +     cpuset =3D CPU_ALLOC(online_cpus_nr);
> > +     if (!cpuset)
> > +             err(EXIT_FAILURE, "Cannot allocate cpuset.");
> > +     cpuset_size =3D CPU_ALLOC_SIZE(online_cpus_nr);
> > +
> > +     /* Create worker data structures, set CPU affinity, and create   =
*/
> > +     for (unsigned int i =3D 0; i < nthreads; ++i) {
> > +             pthread_attr_t thread_attr;
> > +             int ret;
> > +
> > +             /* Basic worker thread information */
> > +             workers[i].tid =3D i;
> > +             workers[i].barrier =3D &barrier;
> > +             workers[i].ops =3D ops;
> > +
> > +             /* Set CPU affinity */
> > +             pthread_attr_init(&thread_attr);
> > +             CPU_ZERO_S(cpuset_size, cpuset);
> > +             CPU_SET_S(perf_cpu_map__cpu(online_cpus, i % online_cpus_=
nr).cpu,
> > +                     cpuset_size, cpuset);
> > +
> > +             if (pthread_attr_setaffinity_np(&thread_attr, cpuset_size=
, cpuset))
> > +                     err(EXIT_FAILURE, "Pthread set affinity failed");
> > +
> > +             /* Create and block thread */
> > +             ret =3D pthread_create(&workers[i].thd, &thread_attr, syn=
c_workerfn, &workers[i]);
> > +             if (ret !=3D 0)
> > +                     err(EXIT_FAILURE, "Error creating thread: %s", st=
rerror(ret));
> > +
> > +             pthread_attr_destroy(&thread_attr);
> > +     }
> > +
> > +     CPU_FREE(cpuset);
> > +
> > +     for (unsigned int i =3D 0; i < nthreads; ++i) {
> > +             int ret =3D pthread_join(workers[i].thd, NULL);
> > +
> > +             if (ret)
> > +                     err(EXIT_FAILURE, "pthread_join");
> > +     }
> > +
> > +     /* Calculate overall average latency. */
> > +     for (unsigned int i =3D 0; i < nthreads; ++i)
> > +             totaltime +=3D workers[i].runtime;
> > +
> > +     total_spins =3D (u64)nthreads * nspins;
> > +     avg_ns =3D totaltime / total_spins;
> > +     avg_ns_dot =3D (totaltime % total_spins) * 10000 / total_spins;
> > +
> > +     printf("Lock-unlock latency of %u threads: %"PRIu64".%"PRIu64" ns=
.\n",
> > +                     nthreads, avg_ns, avg_ns_dot);
> > +
> > +     free(workers);
> > +
> > +     return 0;
> > +}
> > diff --git a/tools/perf/builtin-bench.c b/tools/perf/builtin-bench.c
> > index 2c1a9f3d847a..cfe6f6dc6ed4 100644
> > --- a/tools/perf/builtin-bench.c
> > +++ b/tools/perf/builtin-bench.c
> > @@ -52,6 +52,12 @@ static struct bench sched_benchmarks[] =3D {
> >       { NULL,         NULL,                                           N=
ULL                    }
> >  };
> >
> > +static struct bench sync_benchmarks[] =3D {
> > +     { "qspinlock",  "Benchmark for queued spinlock",                b=
ench_sync_qspinlock    },
> > +     { "all",        "Run all synchronization benchmarks",           N=
ULL                    },
> > +     { NULL,         NULL,                                           N=
ULL                    }
> > +};
> > +
> >  static struct bench syscall_benchmarks[] =3D {
> >       { "basic",      "Benchmark for basic getppid(2) calls",         b=
ench_syscall_basic     },
> >       { "getpgid",    "Benchmark for getpgid(2) calls",               b=
ench_syscall_getpgid   },
> > @@ -122,6 +128,7 @@ struct collection {
> >
> >  static struct collection collections[] =3D {
> >       { "sched",      "Scheduler and IPC benchmarks",                 s=
ched_benchmarks        },
> > +     { "sync",       "Synchronization benchmarks",                   s=
ync_benchmarks         },
> >       { "syscall",    "System call benchmarks",                       s=
yscall_benchmarks      },
> >       { "mem",        "Memory access benchmarks",                     m=
em_benchmarks          },
> >  #ifdef HAVE_LIBNUMA_SUPPORT
> > --
> > 2.50.1.487.gc89ff58d15-goog
> >
