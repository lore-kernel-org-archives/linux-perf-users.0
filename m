Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE3F220F35
	for <linux-perf-users@vger.kernel.org>; Tue, 29 Jul 2025 02:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753756020; cv=none; b=qXzQK/D5TCUChNhAjlMhiGQKOlTUyfZIget1MVzq1PQuv9VTTiacgzPf8dseBC5hw+iS/rpH3DlomQ4GkdffIiDfo7qEiLg34SyNoEJmS2O1hvbwFv7yrLFCPVbblNzi4JKxP3da1+UZfy0hL+FavC36y7Zzrqm5IV3jK1iKRpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753756020; c=relaxed/simple;
	bh=78XwSvfsUo5qjFzpcoZ2YE5qIEQTQanZ2gjLZQMR2U4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=CsqoHYZq7LFLMCErnEWgrSEzWekMJfRK6aSVuYADeG/Ajo7ZtlJozZmvvjjMOF2e79rswbbjFNgzD7zTg27iDLrsvhTOG9H4qYZozbA52MUwtv5X4SkJQudb0vcdVtnr4f/MWzYkL6beOBoNm3tK3X2wP//awUolwwWN0YYd3eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuzhuo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WReMhAPy; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuzhuo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WReMhAPy"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-764072aca31so4663089b3a.2
        for <linux-perf-users@vger.kernel.org>; Mon, 28 Jul 2025 19:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753756017; x=1754360817; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lpJZQW2XhZpV9woIMXPe23IdtVvXCXsSMOWR9kV9OUE=;
        b=WReMhAPyKngyzGyRBpodM2hg4ltB+BKpDYYCyPo9/W66DPi539LagpZ4OU15ZH0N81
         hqu+6b/GXf/c8d+7xCq+xYV7XEHxPkvdUvZHHB58Ua1PGC5/s1YGro0KVvunPfenY21H
         yPcw3mA3P4g5cfgbZH0T85XfwPBPaYx9ybV7MBMpL1sD7DkJKfWKl2BBnG5XSGW8B2DC
         yBkwSL2AVi9iLCfWjBhzos6j/Oigkw7AFcqZmV5rDK0N12Jz/pXlYSxrlG8jWFvDdHpv
         bHKTnNfqixNRP14+Ftrc7CrVvYMHn1Ust7wSWIwXo0boERAwURlABFPXGaUa9eJMFMy3
         ncLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753756017; x=1754360817;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lpJZQW2XhZpV9woIMXPe23IdtVvXCXsSMOWR9kV9OUE=;
        b=KsBf8C7CeU4QTPMW6sFbNzI5EbQ56eF/3NUecpcK9/djBbz+RN6lAfVhxvYtN0dFKG
         XltqLkfc3rnMrS/1YMmV5WCY4/HqZBPQO3iPkBrW1WaSrTo6Aerf7dCfck6Zj1pBTBRb
         ar3M47AXhqNqFmgTWjYjkP3orjJghMvvHVcwqeKnJ88+7UVXle2XGgbSBaX0Rr4JDKXE
         vCGiaWlq9sHLqhtgfJK1XYn/qt66UkpMLZR8+Dhm3WJ7TaZ06zKpfbuHdMnhUucObnp/
         wInO+CtssEjQva6lBQV9kR0FtdMP2vAVojZNplLAXA+8/GwMH6TezBdg9EOL4szEzzIU
         irXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXF1BW0oiWQ7kb3i5DtJ3GPaj5Ue75GWoB1RCfmLGjNRdqr7gCg80RGssfNP/fDV9+T93MpNRJ3cZZvyd3VEB++@vger.kernel.org
X-Gm-Message-State: AOJu0YwkQQSVPJkihjsSuu6ZbV9qyxQLEjRUIx3KvhA2piBghMLFPw/d
	lr6FAGkGZZHD/P3B7+fQIMgs1/+1sYyMNfIoM0o7wD8nv1r06ssRzgh1gDZOy7fGqvqxf0BJQFU
	UYtnibQ==
X-Google-Smtp-Source: AGHT+IF3BgulVEdztgtpO3hFWLE1HkY5w4Qq15DrebDHOcpen7DayFyYTAX+bxT3j4xX+6CCPymj3m5uGog=
X-Received: from pfoo28.prod.google.com ([2002:a05:6a00:1a1c:b0:748:f16c:14c5])
 (user=yuzhuo job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:10cb:b0:748:f750:14c6
 with SMTP id d2e1a72fcca58-76336f1bcb7mr20458767b3a.14.1753756016683; Mon, 28
 Jul 2025 19:26:56 -0700 (PDT)
Date: Mon, 28 Jul 2025 19:26:40 -0700
In-Reply-To: <20250729022640.3134066-1-yuzhuo@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250729022640.3134066-1-yuzhuo@google.com>
X-Mailer: git-send-email 2.50.1.487.gc89ff58d15-goog
Message-ID: <20250729022640.3134066-8-yuzhuo@google.com>
Subject: [PATCH v1 7/7] perf bench sync: Add latency histogram functionality
From: Yuzhuo Jing <yuzhuo@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Liang Kan <kan.liang@linux.intel.com>, Yuzhuo Jing <yzj@umich.edu>, 
	Yuzhuo Jing <yuzhuo@google.com>, Andrea Parri <parri.andrea@gmail.com>, 
	Palmer Dabbelt <palmer@rivosinc.com>, Charlie Jenkins <charlie@rivosinc.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Barret Rhoden <brho@google.com>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Guo Ren <guoren@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add an option to print the histogram of lock acquire latencies (unit in
TSCs).

Signed-off-by: Yuzhuo Jing <yuzhuo@google.com>
---
 tools/perf/bench/sync.c | 97 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 96 insertions(+), 1 deletion(-)

diff --git a/tools/perf/bench/sync.c b/tools/perf/bench/sync.c
index 2685cb66584c..c85e9853c72a 100644
--- a/tools/perf/bench/sync.c
+++ b/tools/perf/bench/sync.c
@@ -15,14 +15,19 @@
 #include <sys/cdefs.h>
 
 #include "bench.h"
+#include "../util/tsc.h"
 
 #include "include/qspinlock.h"
 
 #define NS 1000000000ull
 #define CACHELINE_SIZE 64
 
+#define DEFAULT_HIST_INTERVAL 1000
+
 static unsigned int nthreads;
 static unsigned long nspins = 10000ul;
+static bool do_hist;
+static u64 hist_interval = DEFAULT_HIST_INTERVAL;
 
 struct barrier_t;
 
@@ -45,6 +50,7 @@ struct worker {
 	struct lock_ops *ops;
 	struct barrier_t *barrier;
 	u64 runtime;		// in nanoseconds
+	u64 *lock_latency;	// in TSCs
 };
 
 static const struct option options[] = {
@@ -52,6 +58,10 @@ static const struct option options[] = {
 		"Specify number of threads (default: number of CPUs)."),
 	OPT_ULONG('n',		"spins",	&nspins,
 		"Number of lock acquire operations per thread (default: 10,000 times)."),
+	OPT_BOOLEAN(0,		"hist",		&do_hist,
+		"Print a histogram of lock acquire TSCs."),
+	OPT_U64(0,	"hist-interval",	&hist_interval,
+		"Histogram bucket size (default 1,000 TSCs)."),
 	OPT_END()
 };
 
@@ -109,6 +119,25 @@ static void lock_loop(const struct lock_ops *ops, unsigned long n)
 	}
 }
 
+/*
+ * A busy loop to acquire and release the given lock N times, and also collect
+ * all acquire latencies, for histogram use.  Note that the TSC operations
+ * latency itself is also included.
+ */
+static void lock_loop_timing(const struct lock_ops *ops, unsigned long n, u64 *sample_buffer)
+{
+	unsigned long i;
+	u64 t1, t2;
+
+	for (i = 0; i < n; ++i) {
+		t1 = rdtsc();
+		ops->lock(ops->data);
+		t2 = rdtsc();
+		ops->unlock(ops->data);
+		sample_buffer[i] = t2 - t1;
+	}
+}
+
 /*
  * Thread worker function.  Runs lock loop for N/5 times before and after
  * the main timed loop.
@@ -127,7 +156,10 @@ static void *sync_workerfn(void *args)
 	lock_loop(worker->ops, nspins / 5);
 
 	clock_gettime(CLOCK_THREAD_CPUTIME_ID, &starttime);
-	lock_loop(worker->ops, nspins);
+	if (worker->lock_latency)
+		lock_loop_timing(worker->ops, nspins, worker->lock_latency);
+	else
+		lock_loop(worker->ops, nspins);
 	clock_gettime(CLOCK_THREAD_CPUTIME_ID, &endtime);
 
 	/* Tail loop (not counted) to keep the above loop contended. */
@@ -139,6 +171,57 @@ static void *sync_workerfn(void *args)
 	return NULL;
 }
 
+/*
+ * Calculate and print a histogram.
+ */
+static void print_histogram(struct worker *workers)
+{
+	u64 tsc_max = 0;
+	u64 *buckets;
+	unsigned long nbuckets;
+
+	if (hist_interval == 0)
+		hist_interval = DEFAULT_HIST_INTERVAL;
+
+	printf("Lock acquire histogram:\n");
+
+	/* Calculate the max TSC value to get the number of buckets needed. */
+	for (unsigned int i = 0; i < nthreads; ++i) {
+		struct worker *w = workers + i;
+
+		for (unsigned long j = 0; j < nspins; ++j)
+			tsc_max = max(w->lock_latency[j], tsc_max);
+	}
+	nbuckets = (tsc_max + hist_interval - 1) / hist_interval;
+
+	/* Allocate the actual bucket.  The bucket definition may be optimized
+	 * if it is sparse.
+	 */
+	buckets = calloc(nbuckets, sizeof(*buckets));
+	if (!buckets)
+		err(EXIT_FAILURE, "calloc");
+
+	/* Iterate through all latencies again to fill the buckets. */
+	for (unsigned int i = 0; i < nthreads; ++i) {
+		struct worker *w = workers + i;
+
+		for (unsigned long j = 0; j < nspins; ++j) {
+			u64 latency = w->lock_latency[j];
+			++buckets[latency / hist_interval];
+		}
+	}
+
+	/* Print the histogram as a table. */
+	printf("Bucket, Count\n");
+	for (unsigned long i = 0; i < nbuckets; ++i) {
+		if (buckets[i] == 0)
+			continue;
+		printf("%"PRIu64", %"PRIu64"\n", hist_interval * (i + 1), buckets[i]);
+	}
+
+	free(buckets);
+}
+
 /*
  * Generic lock synchronization benchmark function.  Sets up threads and
  * thread affinities.
@@ -191,6 +274,12 @@ static int bench_sync_lock_generic(struct lock_ops *ops, int argc, const char **
 		workers[i].barrier = &barrier;
 		workers[i].ops = ops;
 
+		if (do_hist) {
+			workers[i].lock_latency = calloc(nspins, sizeof(*workers[i].lock_latency));
+			if (!workers[i].lock_latency)
+				err(EXIT_FAILURE, "calloc");
+		}
+
 		/* Set CPU affinity */
 		pthread_attr_init(&thread_attr);
 		CPU_ZERO_S(cpuset_size, cpuset);
@@ -228,6 +317,12 @@ static int bench_sync_lock_generic(struct lock_ops *ops, int argc, const char **
 	printf("Lock-unlock latency of %u threads: %"PRIu64".%"PRIu64" ns.\n",
 			nthreads, avg_ns, avg_ns_dot);
 
+	/* Print histogram if requested. */
+	if (do_hist)
+		print_histogram(workers);
+
+	for (unsigned int i = 0; i < nthreads; ++i)
+		free(workers[i].lock_latency);
 	free(workers);
 
 	return 0;
-- 
2.50.1.487.gc89ff58d15-goog

