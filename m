Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C28357736
	for <linux-perf-users@vger.kernel.org>; Thu,  6 Nov 2025 23:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762470955; cv=none; b=UP6o1CPyyFPjHEmGQkN7uOJSl5jKUclRt3uQ4daEX5XA+/cp2nwO1ZXnbnr1lDVcEpxQT58erLYO0EtoM0TDVDyENKbXnuPLwuaCTs1ytydTmTM1txhdtbrG1l4UM8y0btUi5Davy6wfxs62jUsPpVGQfGotzjzlvMnla1Jvyvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762470955; c=relaxed/simple;
	bh=3E9wfGv9PEXnn5shTNvkeIBmNV0ywFljmbQlUe8NPMw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=f4CDSSkY8bRf76tkJu0He5wTSGQ1+fpQLuG/W39547X2ltw9xyPn+eKhUma8HjqFMXDWzIWxX9B7p8x6gjOxPWxRJ5EusEcz/6dEAFFUN/mivYj99BuUYbBljfHaB97e9iMtHh+zQRhR6ewa/SxMVY0taV5CvIybr160uxNHMaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=shpQHEgT; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="shpQHEgT"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-ba433d88288so116603a12.2
        for <linux-perf-users@vger.kernel.org>; Thu, 06 Nov 2025 15:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762470952; x=1763075752; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EQWWs18Tf82l9vd7uc3cmYkO6mjNYPE1n+OwWs9yhfs=;
        b=shpQHEgThbo9zuyqB7scR4tONG01SMRWoYlCEbWMZf26Ov0MktE3GunXbXRWXKgVpp
         Upvpjprq1l31JuF/53kUPfDw2046QXt2IHZA4HN70s3+AGKi6s+MxL8DL4DZxDA1rvSC
         FrT8r38SQejo1Z/9Jt4tyG2Y6/9pLL7jPsQLLkDZKhYBjL5y2dhWlkn65JnwdM/1rBxL
         vMrAR20ER972VPVDIQ9+6s/tQ44NelIRVCbJ8HOUzV6RAzra6Xbpgpq7oGXirPpMmjN/
         NteHKq1w1InFWcTJCT62Bud4jkt0rKZC5riLMNrvjzWzICW5GP6zNLO7Y621EiN2fCJ2
         wbsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762470952; x=1763075752;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EQWWs18Tf82l9vd7uc3cmYkO6mjNYPE1n+OwWs9yhfs=;
        b=kaI7rYYt46eHhBj99py1stRp9v+VQoyU0YQbQnYopj3Gh2Z7MmpEJ7kZbr3pqqMd+F
         co35sWAeFarx8JqeF/UZF8kxahr0Zpq34e1mV0A32VeaPpLc2ZZ1CMj8+UGjcjXzg63b
         9+T/ljTp+ZjWMo6wYSaezmrnKjlkIYoJzShJJDhQ7Ae2d+GLB/qaq5sO2ql8j6k6Ab++
         RMIOz6pHBvlsyx2+2k+rIdB0Wae3dTyzNrExD4RZlWnU3h28Cz2KNc/cIGoqLULIPX1N
         4kcBqmgDGTYrnLtXnfBZZf2El9dZYKu52uL6QzQUXMQsTGxNFNs8EuLtheWjAkzC6xc2
         mqhg==
X-Forwarded-Encrypted: i=1; AJvYcCV4mdF8LzeztjuaJ/8+1cHzCWaJu4VzXie7MCawkJ1SM61tpBhbNjfQkZhNt/7T3AuXZ1QefC2um5QUpy9JpY/J@vger.kernel.org
X-Gm-Message-State: AOJu0YwuotyMfu8BBhgYi2Ifi7lybdkCssM6fMDGo5qxwcsj6M2j1Fvz
	suxf8SPUHtE5aEDMRlKOgv2Y0Me4uqgWcuCdAMt2mCR8MZ+1ka2J4oYVSOoKWEBm2/JDx44ZxTn
	aSqG0glSTLQ==
X-Google-Smtp-Source: AGHT+IGMJm0d1bp45Lc2D7noXhJ1M4EISZiHWmNXgZ9yugwy942mteCEc+KAeANIlZ3bxeczuRQL0P8MLH/S
X-Received: from dlag15.prod.google.com ([2002:a05:701b:250f:b0:119:78ff:fe18])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ec8f:b0:295:9b3a:16b6
 with SMTP id d9443c01a7336-297c0492c72mr15271785ad.49.1762470952206; Thu, 06
 Nov 2025 15:15:52 -0800 (PST)
Date: Thu,  6 Nov 2025 15:14:57 -0800
In-Reply-To: <20251106231508.448793-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251106231508.448793-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251106231508.448793-8-irogers@google.com>
Subject: [PATCH v2 07/18] perf stat: Remove hard coded shadow metrics
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Xu Yang <xu.yang_2@nxp.com>, 
	Chun-Tse Shao <ctshao@google.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Sumanth Korikkar <sumanthk@linux.ibm.com>, Collin Funk <collin.funk1@gmail.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Howard Chu <howardchu95@gmail.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Levi Yun <yeoreum.yun@arm.com>, 
	Yang Li <yang.lee@linux.alibaba.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, 
	Weilin Wang <weilin.wang@intel.com>
Content-Type: text/plain; charset="UTF-8"

Now that the metrics are encoded in common json the hard coded
printing means the metrics are shown twice. Remove the hard coded
version.

This means that when specifying events, and those events correspond to
a hard coded metric, the metric will no longer be displayed. The
metric will be displayed if the metric is requested. Due to the adhoc
printing in the previous approach it was often found frustrating, the
new approach avoids this.

The default perf stat output on an alderlake now looks like:
```
$ perf stat -a -- sleep 1

 Performance counter stats for 'system wide':

             7,932      context-switches                 #    281.7 cs/sec  cs_per_second
             TopdownL1 (cpu_core)                 #     10.3 %  tma_bad_speculation
                                                  #     17.3 %  tma_frontend_bound
             TopdownL1 (cpu_core)                 #     37.3 %  tma_backend_bound
                                                  #     35.2 %  tma_retiring
             5,901      page-faults                      #    209.5 faults/sec  page_faults_per_second
       418,955,116      cpu_atom/cpu-cycles/             #      0.0 GHz  cycles_frequency       (49.77%)
     1,113,933,476      cpu_core/cpu-cycles/             #      0.0 GHz  cycles_frequency
                                                  #     14.6 %  tma_bad_speculation
                                                  #      8.5 %  tma_retiring             (50.17%)
                                                  #     41.8 %  tma_backend_bound
                                                  #     35.1 %  tma_frontend_bound       (50.31%)
        32,196,918      cpu_atom/branches/               #      1.1 K/sec  branch_frequency     (60.24%)
       445,404,717      cpu_core/branches/               #     15.8 K/sec  branch_frequency
               235      cpu-migrations                   #      8.3 migrations/sec  migrations_per_second
    28,160,951,165      cpu-clock                        #     28.0 CPUs  CPUs_utilized
       382,285,763      cpu_atom/cpu-cycles/             #      0.4 instructions  insn_per_cycle  (60.18%)
     1,114,029,255      cpu_core/cpu-cycles/             #      2.3 instructions  insn_per_cycle
         1,768,727      cpu_atom/branches-misses/        #      6.5 %  branch_miss_rate         (49.68%)
         4,505,904      cpu_core/branches-misses/        #      1.0 %  branch_miss_rate

       1.007137632 seconds time elapsed
```

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-script.c    |   1 -
 tools/perf/util/stat-display.c |   4 +-
 tools/perf/util/stat-shadow.c  | 392 +--------------------------------
 tools/perf/util/stat.h         |   2 +-
 4 files changed, 6 insertions(+), 393 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index e24c3d9e01a8..6da8bfe1e7aa 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -2358,7 +2358,6 @@ static void perf_sample__fprint_metric(struct thread *thread,
 	evlist__for_each_entry(evsel->evlist, pos) {
 		cpu_aggr_map__for_each_idx(aggr_idx, stat_config.aggr_map) {
 			perf_stat__print_shadow_stats(&stat_config, pos,
-						count->val,
 						aggr_idx,
 						&ctx);
 		}
diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 4d0e353846ea..eabeab5e6614 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -902,7 +902,7 @@ static void printout(struct perf_stat_config *config, struct outstate *os,
 										 &num, from, &out);
 			} while (from != NULL);
 		} else {
-			perf_stat__print_shadow_stats(config, counter, uval, aggr_idx, &out);
+			perf_stat__print_shadow_stats(config, counter, aggr_idx, &out);
 		}
 	} else {
 		pm(config, os, METRIC_THRESHOLD_UNKNOWN, /*format=*/NULL, /*unit=*/NULL, /*val=*/0);
@@ -1274,7 +1274,7 @@ static void print_metric_headers(struct perf_stat_config *config,
 
 		os.evsel = counter;
 
-		perf_stat__print_shadow_stats(config, counter, 0, 0, &out);
+		perf_stat__print_shadow_stats(config, counter, /*aggr_idx=*/0, &out);
 	}
 
 	if (!config->json_output)
diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index 4df614f8e200..afbc49e8cb31 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -20,357 +20,12 @@
 struct stats walltime_nsecs_stats;
 struct rusage_stats ru_stats;
 
-enum {
-	CTX_BIT_USER	= 1 << 0,
-	CTX_BIT_KERNEL	= 1 << 1,
-	CTX_BIT_HV	= 1 << 2,
-	CTX_BIT_HOST	= 1 << 3,
-	CTX_BIT_IDLE	= 1 << 4,
-	CTX_BIT_MAX	= 1 << 5,
-};
-
-enum stat_type {
-	STAT_NONE = 0,
-	STAT_NSECS,
-	STAT_CYCLES,
-	STAT_INSTRUCTIONS,
-	STAT_STALLED_CYCLES_FRONT,
-	STAT_STALLED_CYCLES_BACK,
-	STAT_BRANCHES,
-	STAT_BRANCH_MISS,
-	STAT_CACHE_REFS,
-	STAT_CACHE_MISSES,
-	STAT_L1_DCACHE,
-	STAT_L1_ICACHE,
-	STAT_LL_CACHE,
-	STAT_ITLB_CACHE,
-	STAT_DTLB_CACHE,
-	STAT_L1D_MISS,
-	STAT_L1I_MISS,
-	STAT_LL_MISS,
-	STAT_DTLB_MISS,
-	STAT_ITLB_MISS,
-	STAT_MAX
-};
-
-static int evsel_context(const struct evsel *evsel)
-{
-	int ctx = 0;
-
-	if (evsel->core.attr.exclude_kernel)
-		ctx |= CTX_BIT_KERNEL;
-	if (evsel->core.attr.exclude_user)
-		ctx |= CTX_BIT_USER;
-	if (evsel->core.attr.exclude_hv)
-		ctx |= CTX_BIT_HV;
-	if (evsel->core.attr.exclude_host)
-		ctx |= CTX_BIT_HOST;
-	if (evsel->core.attr.exclude_idle)
-		ctx |= CTX_BIT_IDLE;
-
-	return ctx;
-}
-
 void perf_stat__reset_shadow_stats(void)
 {
 	memset(&walltime_nsecs_stats, 0, sizeof(walltime_nsecs_stats));
 	memset(&ru_stats, 0, sizeof(ru_stats));
 }
 
-static enum stat_type evsel__stat_type(struct evsel *evsel)
-{
-	/* Fake perf_hw_cache_op_id values for use with evsel__match. */
-	u64 PERF_COUNT_hw_cache_l1d_miss = PERF_COUNT_HW_CACHE_L1D |
-		((PERF_COUNT_HW_CACHE_OP_READ) << 8) |
-		((PERF_COUNT_HW_CACHE_RESULT_MISS) << 16);
-	u64 PERF_COUNT_hw_cache_l1i_miss = PERF_COUNT_HW_CACHE_L1I |
-		((PERF_COUNT_HW_CACHE_OP_READ) << 8) |
-		((PERF_COUNT_HW_CACHE_RESULT_MISS) << 16);
-	u64 PERF_COUNT_hw_cache_ll_miss = PERF_COUNT_HW_CACHE_LL |
-		((PERF_COUNT_HW_CACHE_OP_READ) << 8) |
-		((PERF_COUNT_HW_CACHE_RESULT_MISS) << 16);
-	u64 PERF_COUNT_hw_cache_dtlb_miss = PERF_COUNT_HW_CACHE_DTLB |
-		((PERF_COUNT_HW_CACHE_OP_READ) << 8) |
-		((PERF_COUNT_HW_CACHE_RESULT_MISS) << 16);
-	u64 PERF_COUNT_hw_cache_itlb_miss = PERF_COUNT_HW_CACHE_ITLB |
-		((PERF_COUNT_HW_CACHE_OP_READ) << 8) |
-		((PERF_COUNT_HW_CACHE_RESULT_MISS) << 16);
-
-	if (evsel__is_clock(evsel))
-		return STAT_NSECS;
-	else if (evsel__match(evsel, HARDWARE, HW_CPU_CYCLES))
-		return STAT_CYCLES;
-	else if (evsel__match(evsel, HARDWARE, HW_INSTRUCTIONS))
-		return STAT_INSTRUCTIONS;
-	else if (evsel__match(evsel, HARDWARE, HW_STALLED_CYCLES_FRONTEND))
-		return STAT_STALLED_CYCLES_FRONT;
-	else if (evsel__match(evsel, HARDWARE, HW_STALLED_CYCLES_BACKEND))
-		return STAT_STALLED_CYCLES_BACK;
-	else if (evsel__match(evsel, HARDWARE, HW_BRANCH_INSTRUCTIONS))
-		return STAT_BRANCHES;
-	else if (evsel__match(evsel, HARDWARE, HW_BRANCH_MISSES))
-		return STAT_BRANCH_MISS;
-	else if (evsel__match(evsel, HARDWARE, HW_CACHE_REFERENCES))
-		return STAT_CACHE_REFS;
-	else if (evsel__match(evsel, HARDWARE, HW_CACHE_MISSES))
-		return STAT_CACHE_MISSES;
-	else if (evsel__match(evsel, HW_CACHE, HW_CACHE_L1D))
-		return STAT_L1_DCACHE;
-	else if (evsel__match(evsel, HW_CACHE, HW_CACHE_L1I))
-		return STAT_L1_ICACHE;
-	else if (evsel__match(evsel, HW_CACHE, HW_CACHE_LL))
-		return STAT_LL_CACHE;
-	else if (evsel__match(evsel, HW_CACHE, HW_CACHE_DTLB))
-		return STAT_DTLB_CACHE;
-	else if (evsel__match(evsel, HW_CACHE, HW_CACHE_ITLB))
-		return STAT_ITLB_CACHE;
-	else if (evsel__match(evsel, HW_CACHE, hw_cache_l1d_miss))
-		return STAT_L1D_MISS;
-	else if (evsel__match(evsel, HW_CACHE, hw_cache_l1i_miss))
-		return STAT_L1I_MISS;
-	else if (evsel__match(evsel, HW_CACHE, hw_cache_ll_miss))
-		return STAT_LL_MISS;
-	else if (evsel__match(evsel, HW_CACHE, hw_cache_dtlb_miss))
-		return STAT_DTLB_MISS;
-	else if (evsel__match(evsel, HW_CACHE, hw_cache_itlb_miss))
-		return STAT_ITLB_MISS;
-	return STAT_NONE;
-}
-
-static enum metric_threshold_classify get_ratio_thresh(const double ratios[3], double val)
-{
-	assert(ratios[0] > ratios[1]);
-	assert(ratios[1] > ratios[2]);
-
-	return val > ratios[1]
-		? (val > ratios[0] ? METRIC_THRESHOLD_BAD : METRIC_THRESHOLD_NEARLY_BAD)
-		: (val > ratios[2] ? METRIC_THRESHOLD_LESS_GOOD : METRIC_THRESHOLD_GOOD);
-}
-
-static double find_stat(const struct evsel *evsel, int aggr_idx, enum stat_type type)
-{
-	struct evsel *cur;
-	int evsel_ctx = evsel_context(evsel);
-	struct perf_pmu *evsel_pmu = evsel__find_pmu(evsel);
-
-	evlist__for_each_entry(evsel->evlist, cur) {
-		struct perf_stat_aggr *aggr;
-
-		/* Ignore the evsel that is being searched from. */
-		if (evsel == cur)
-			continue;
-
-		/* Ignore evsels that are part of different groups. */
-		if (evsel->core.leader->nr_members > 1 &&
-		    evsel->core.leader != cur->core.leader)
-			continue;
-		/* Ignore evsels with mismatched modifiers. */
-		if (evsel_ctx != evsel_context(cur))
-			continue;
-		/* Ignore if not the cgroup we're looking for. */
-		if (evsel->cgrp != cur->cgrp)
-			continue;
-		/* Ignore if not the stat we're looking for. */
-		if (type != evsel__stat_type(cur))
-			continue;
-
-		/*
-		 * Except the SW CLOCK events,
-		 * ignore if not the PMU we're looking for.
-		 */
-		if ((type != STAT_NSECS) && (evsel_pmu != evsel__find_pmu(cur)))
-			continue;
-
-		aggr = &cur->stats->aggr[aggr_idx];
-		if (type == STAT_NSECS)
-			return aggr->counts.val;
-		return aggr->counts.val * cur->scale;
-	}
-	return 0.0;
-}
-
-static void print_ratio(struct perf_stat_config *config,
-			const struct evsel *evsel, int aggr_idx,
-			double numerator, struct perf_stat_output_ctx *out,
-			enum stat_type denominator_type,
-			const double thresh_ratios[3], const char *_unit)
-{
-	double denominator = find_stat(evsel, aggr_idx, denominator_type);
-	double ratio = 0;
-	enum metric_threshold_classify thresh = METRIC_THRESHOLD_UNKNOWN;
-	const char *fmt = NULL;
-	const char *unit = NULL;
-
-	if (numerator && denominator) {
-		ratio = numerator / denominator * 100.0;
-		thresh = get_ratio_thresh(thresh_ratios, ratio);
-		fmt = "%7.2f%%";
-		unit = _unit;
-	}
-	out->print_metric(config, out->ctx, thresh, fmt, unit, ratio);
-}
-
-static void print_stalled_cycles_front(struct perf_stat_config *config,
-				const struct evsel *evsel,
-				int aggr_idx, double stalled,
-				struct perf_stat_output_ctx *out)
-{
-	const double thresh_ratios[3] = {50.0, 30.0, 10.0};
-
-	print_ratio(config, evsel, aggr_idx, stalled, out, STAT_CYCLES, thresh_ratios,
-		    "frontend cycles idle");
-}
-
-static void print_stalled_cycles_back(struct perf_stat_config *config,
-				const struct evsel *evsel,
-				int aggr_idx, double stalled,
-				struct perf_stat_output_ctx *out)
-{
-	const double thresh_ratios[3] = {75.0, 50.0, 20.0};
-
-	print_ratio(config, evsel, aggr_idx, stalled, out, STAT_CYCLES, thresh_ratios,
-		    "backend cycles idle");
-}
-
-static void print_branch_miss(struct perf_stat_config *config,
-			const struct evsel *evsel,
-			int aggr_idx, double misses,
-			struct perf_stat_output_ctx *out)
-{
-	const double thresh_ratios[3] = {20.0, 10.0, 5.0};
-
-	print_ratio(config, evsel, aggr_idx, misses, out, STAT_BRANCHES, thresh_ratios,
-		    "of all branches");
-}
-
-static void print_l1d_miss(struct perf_stat_config *config,
-			const struct evsel *evsel,
-			int aggr_idx, double misses,
-			struct perf_stat_output_ctx *out)
-{
-	const double thresh_ratios[3] = {20.0, 10.0, 5.0};
-
-	print_ratio(config, evsel, aggr_idx, misses, out, STAT_L1_DCACHE, thresh_ratios,
-		    "of all L1-dcache accesses");
-}
-
-static void print_l1i_miss(struct perf_stat_config *config,
-			const struct evsel *evsel,
-			int aggr_idx, double misses,
-			struct perf_stat_output_ctx *out)
-{
-	const double thresh_ratios[3] = {20.0, 10.0, 5.0};
-
-	print_ratio(config, evsel, aggr_idx, misses, out, STAT_L1_ICACHE, thresh_ratios,
-		    "of all L1-icache accesses");
-}
-
-static void print_ll_miss(struct perf_stat_config *config,
-			const struct evsel *evsel,
-			int aggr_idx, double misses,
-			struct perf_stat_output_ctx *out)
-{
-	const double thresh_ratios[3] = {20.0, 10.0, 5.0};
-
-	print_ratio(config, evsel, aggr_idx, misses, out, STAT_LL_CACHE, thresh_ratios,
-		    "of all LL-cache accesses");
-}
-
-static void print_dtlb_miss(struct perf_stat_config *config,
-			const struct evsel *evsel,
-			int aggr_idx, double misses,
-			struct perf_stat_output_ctx *out)
-{
-	const double thresh_ratios[3] = {20.0, 10.0, 5.0};
-
-	print_ratio(config, evsel, aggr_idx, misses, out, STAT_DTLB_CACHE, thresh_ratios,
-		    "of all dTLB cache accesses");
-}
-
-static void print_itlb_miss(struct perf_stat_config *config,
-			const struct evsel *evsel,
-			int aggr_idx, double misses,
-			struct perf_stat_output_ctx *out)
-{
-	const double thresh_ratios[3] = {20.0, 10.0, 5.0};
-
-	print_ratio(config, evsel, aggr_idx, misses, out, STAT_ITLB_CACHE, thresh_ratios,
-		    "of all iTLB cache accesses");
-}
-
-static void print_cache_miss(struct perf_stat_config *config,
-			const struct evsel *evsel,
-			int aggr_idx, double misses,
-			struct perf_stat_output_ctx *out)
-{
-	const double thresh_ratios[3] = {20.0, 10.0, 5.0};
-
-	print_ratio(config, evsel, aggr_idx, misses, out, STAT_CACHE_REFS, thresh_ratios,
-		    "of all cache refs");
-}
-
-static void print_instructions(struct perf_stat_config *config,
-			const struct evsel *evsel,
-			int aggr_idx, double instructions,
-			struct perf_stat_output_ctx *out)
-{
-	print_metric_t print_metric = out->print_metric;
-	void *ctxp = out->ctx;
-	double cycles = find_stat(evsel, aggr_idx, STAT_CYCLES);
-	double max_stalled = max(find_stat(evsel, aggr_idx, STAT_STALLED_CYCLES_FRONT),
-				find_stat(evsel, aggr_idx, STAT_STALLED_CYCLES_BACK));
-
-	if (cycles) {
-		print_metric(config, ctxp, METRIC_THRESHOLD_UNKNOWN, "%7.2f ",
-			     "insn per cycle", instructions / cycles);
-	} else {
-		print_metric(config, ctxp, METRIC_THRESHOLD_UNKNOWN, /*fmt=*/NULL,
-			     "insn per cycle", 0);
-	}
-	if (max_stalled && instructions) {
-		if (out->new_line)
-			out->new_line(config, ctxp);
-		print_metric(config, ctxp, METRIC_THRESHOLD_UNKNOWN, "%7.2f ",
-			     "stalled cycles per insn", max_stalled / instructions);
-	}
-}
-
-static void print_cycles(struct perf_stat_config *config,
-			const struct evsel *evsel,
-			int aggr_idx, double cycles,
-			struct perf_stat_output_ctx *out)
-{
-	double nsecs = find_stat(evsel, aggr_idx, STAT_NSECS);
-
-	if (cycles && nsecs) {
-		double ratio = cycles / nsecs;
-
-		out->print_metric(config, out->ctx, METRIC_THRESHOLD_UNKNOWN, "%8.3f",
-				  "GHz", ratio);
-	} else {
-		out->print_metric(config, out->ctx, METRIC_THRESHOLD_UNKNOWN, /*fmt=*/NULL,
-				  "GHz", 0);
-	}
-}
-
-static void print_nsecs(struct perf_stat_config *config,
-			const struct evsel *evsel,
-			int aggr_idx __maybe_unused, double nsecs,
-			struct perf_stat_output_ctx *out)
-{
-	print_metric_t print_metric = out->print_metric;
-	void *ctxp = out->ctx;
-	double wall_time = avg_stats(&walltime_nsecs_stats);
-
-	if (wall_time) {
-		print_metric(config, ctxp, METRIC_THRESHOLD_UNKNOWN, "%8.3f", "CPUs utilized",
-			nsecs / (wall_time * evsel->scale));
-	} else {
-		print_metric(config, ctxp, METRIC_THRESHOLD_UNKNOWN, /*fmt=*/NULL,
-			     "CPUs utilized", 0);
-	}
-}
-
 static int prepare_metric(const struct metric_expr *mexp,
 			  const struct evsel *evsel,
 			  struct expr_parse_ctx *pctx,
@@ -682,56 +337,15 @@ void *perf_stat__print_shadow_stats_metricgroup(struct perf_stat_config *config,
 
 void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 				   struct evsel *evsel,
-				   double avg, int aggr_idx,
+				   int aggr_idx,
 				   struct perf_stat_output_ctx *out)
 {
-	typedef void (*stat_print_function_t)(struct perf_stat_config *config,
-					const struct evsel *evsel,
-					int aggr_idx, double misses,
-					struct perf_stat_output_ctx *out);
-	static const stat_print_function_t stat_print_function[STAT_MAX] = {
-		[STAT_INSTRUCTIONS] = print_instructions,
-		[STAT_BRANCH_MISS] = print_branch_miss,
-		[STAT_L1D_MISS] = print_l1d_miss,
-		[STAT_L1I_MISS] = print_l1i_miss,
-		[STAT_DTLB_MISS] = print_dtlb_miss,
-		[STAT_ITLB_MISS] = print_itlb_miss,
-		[STAT_LL_MISS] = print_ll_miss,
-		[STAT_CACHE_MISSES] = print_cache_miss,
-		[STAT_STALLED_CYCLES_FRONT] = print_stalled_cycles_front,
-		[STAT_STALLED_CYCLES_BACK] = print_stalled_cycles_back,
-		[STAT_CYCLES] = print_cycles,
-		[STAT_NSECS] = print_nsecs,
-	};
 	print_metric_t print_metric = out->print_metric;
 	void *ctxp = out->ctx;
-	int num = 1;
+	int num = 0;
 
-	if (config->iostat_run) {
+	if (config->iostat_run)
 		iostat_print_metric(config, evsel, out);
-	} else {
-		stat_print_function_t fn = stat_print_function[evsel__stat_type(evsel)];
-
-		if (fn)
-			fn(config, evsel, aggr_idx, avg, out);
-		else {
-			double nsecs =	find_stat(evsel, aggr_idx, STAT_NSECS);
-
-			if (nsecs) {
-				char unit = ' ';
-				char unit_buf[10] = "/sec";
-				double ratio = convert_unit_double(1000000000.0 * avg / nsecs,
-								   &unit);
-
-				if (unit != ' ')
-					snprintf(unit_buf, sizeof(unit_buf), "%c/sec", unit);
-				print_metric(config, ctxp, METRIC_THRESHOLD_UNKNOWN, "%8.3f",
-					     unit_buf, ratio);
-			} else {
-				num = 0;
-			}
-		}
-	}
 
 	perf_stat__print_shadow_stats_metricgroup(config, evsel, aggr_idx,
 						  &num, NULL, out);
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index 34f30a295f89..53e4aa411e5f 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -184,7 +184,7 @@ struct perf_stat_output_ctx {
 
 void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 				   struct evsel *evsel,
-				   double avg, int aggr_idx,
+				   int aggr_idx,
 				   struct perf_stat_output_ctx *out);
 bool perf_stat__skip_metric_event(struct evsel *evsel, u64 ena, u64 run);
 void *perf_stat__print_shadow_stats_metricgroup(struct perf_stat_config *config,
-- 
2.51.2.1041.gc1ab5b90ca-goog

