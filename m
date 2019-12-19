From: Qi Liu <liuqi115@huawei.com>
Subject: [PATCH v2] Perf stat: Fix the ratio comments of miss-events
Date: Thu, 19 Dec 2019 11:00:01 +0800
Message-ID: <1576724401-30984-1-git-send-email-liuqi115@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, ak@linux.intel.com
Cc: arnaldo.melo@gmail.com, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@redhat.com, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, linuxarm@huawei.com
List-Id: linux-perf-users.vger.kernel.org

Perf stat displays miss ratio of L1-dcache, L1-icache, dTLB cache,
iTLB cache and LL-cache. Take L1-dcache for example, its miss ratio
is caculated as "L1-dcache-load-misses/L1-dcache-loads". So "of all
L1-dcache hits" is unsuitable to describe it, and "of all L1-dcache
accesses" seems better. The comments of L1-icache, dTLB cache, iTLB
cache and LL-cache are fixed in the same way.

Signed-off-by: Qi Liu <liuqi115@huawei.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
---
Changelog
v2: Fix the format issue

 tools/perf/util/stat-shadow.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index 2c41d47..28f4470 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -506,7 +506,7 @@ static void print_l1_dcache_misses(struct perf_stat_config *config,

 	color = get_ratio_color(GRC_CACHE_MISSES, ratio);

-	out->print_metric(config, out->ctx, color, "%7.2f%%", "of all L1-dcache hits", ratio);
+	out->print_metric(config, out->ctx, color, "%7.2f%%", "of all L1-dcache accesses", ratio);
 }

 static void print_l1_icache_misses(struct perf_stat_config *config,
@@ -527,7 +527,7 @@ static void print_l1_icache_misses(struct perf_stat_config *config,
 		ratio = avg / total * 100.0;

 	color = get_ratio_color(GRC_CACHE_MISSES, ratio);
-	out->print_metric(config, out->ctx, color, "%7.2f%%", "of all L1-icache hits", ratio);
+	out->print_metric(config, out->ctx, color, "%7.2f%%", "of all L1-icache accesses", ratio);
 }

 static void print_dtlb_cache_misses(struct perf_stat_config *config,
@@ -547,7 +547,7 @@ static void print_dtlb_cache_misses(struct perf_stat_config *config,
 		ratio = avg / total * 100.0;

 	color = get_ratio_color(GRC_CACHE_MISSES, ratio);
-	out->print_metric(config, out->ctx, color, "%7.2f%%", "of all dTLB cache hits", ratio);
+	out->print_metric(config, out->ctx, color, "%7.2f%%", "of all dTLB cache accesses", ratio);
 }

 static void print_itlb_cache_misses(struct perf_stat_config *config,
@@ -567,7 +567,7 @@ static void print_itlb_cache_misses(struct perf_stat_config *config,
 		ratio = avg / total * 100.0;

 	color = get_ratio_color(GRC_CACHE_MISSES, ratio);
-	out->print_metric(config, out->ctx, color, "%7.2f%%", "of all iTLB cache hits", ratio);
+	out->print_metric(config, out->ctx, color, "%7.2f%%", "of all iTLB cache accesses", ratio);
 }

 static void print_ll_cache_misses(struct perf_stat_config *config,
@@ -587,7 +587,7 @@ static void print_ll_cache_misses(struct perf_stat_config *config,
 		ratio = avg / total * 100.0;

 	color = get_ratio_color(GRC_CACHE_MISSES, ratio);
-	out->print_metric(config, out->ctx, color, "%7.2f%%", "of all LL-cache hits", ratio);
+	out->print_metric(config, out->ctx, color, "%7.2f%%", "of all LL-cache accesses", ratio);
 }

 /*
@@ -872,7 +872,7 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 		if (runtime_stat_n(st, STAT_L1_DCACHE, ctx, cpu) != 0)
 			print_l1_dcache_misses(config, cpu, evsel, avg, out, st);
 		else
-			print_metric(config, ctxp, NULL, NULL, "of all L1-dcache hits", 0);
+			print_metric(config, ctxp, NULL, NULL, "of all L1-dcache accesses", 0);
 	} else if (
 		evsel->core.attr.type == PERF_TYPE_HW_CACHE &&
 		evsel->core.attr.config ==  ( PERF_COUNT_HW_CACHE_L1I |
@@ -882,7 +882,7 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 		if (runtime_stat_n(st, STAT_L1_ICACHE, ctx, cpu) != 0)
 			print_l1_icache_misses(config, cpu, evsel, avg, out, st);
 		else
-			print_metric(config, ctxp, NULL, NULL, "of all L1-icache hits", 0);
+			print_metric(config, ctxp, NULL, NULL, "of all L1-icache accesses", 0);
 	} else if (
 		evsel->core.attr.type == PERF_TYPE_HW_CACHE &&
 		evsel->core.attr.config ==  ( PERF_COUNT_HW_CACHE_DTLB |
@@ -892,7 +892,7 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 		if (runtime_stat_n(st, STAT_DTLB_CACHE, ctx, cpu) != 0)
 			print_dtlb_cache_misses(config, cpu, evsel, avg, out, st);
 		else
-			print_metric(config, ctxp, NULL, NULL, "of all dTLB cache hits", 0);
+			print_metric(config, ctxp, NULL, NULL, "of all dTLB cache accesses", 0);
 	} else if (
 		evsel->core.attr.type == PERF_TYPE_HW_CACHE &&
 		evsel->core.attr.config ==  ( PERF_COUNT_HW_CACHE_ITLB |
@@ -902,7 +902,7 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 		if (runtime_stat_n(st, STAT_ITLB_CACHE, ctx, cpu) != 0)
 			print_itlb_cache_misses(config, cpu, evsel, avg, out, st);
 		else
-			print_metric(config, ctxp, NULL, NULL, "of all iTLB cache hits", 0);
+			print_metric(config, ctxp, NULL, NULL, "of all iTLB cache accesses", 0);
 	} else if (
 		evsel->core.attr.type == PERF_TYPE_HW_CACHE &&
 		evsel->core.attr.config ==  ( PERF_COUNT_HW_CACHE_LL |
@@ -912,7 +912,7 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 		if (runtime_stat_n(st, STAT_LL_CACHE, ctx, cpu) != 0)
 			print_ll_cache_misses(config, cpu, evsel, avg, out, st);
 		else
-			print_metric(config, ctxp, NULL, NULL, "of all LL-cache hits", 0);
+			print_metric(config, ctxp, NULL, NULL, "of all LL-cache accesses", 0);
 	} else if (perf_evsel__match(evsel, HARDWARE, HW_CACHE_MISSES)) {
 		total = runtime_stat_avg(st, STAT_CACHEREFS, ctx, cpu);

--
2.8.1
