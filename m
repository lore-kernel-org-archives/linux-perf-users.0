Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6C135A94E
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Nov 2025 18:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763057157; cv=none; b=StcpH4ow5xjWpyPq9olnZYoidV1P6/6zLmjsP++NppXkuRhCG5KkN+cULdv7Ook7Lnrb9kEr7nLifZpIkgMx0H/cYO73BwzvBfKsSYPUEqrznMMhR2sDIZ3oHSYnsPIl6H6wka+BJlWxRcExUYGbvBRoUhJ2cyWiPH7WxeA1qf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763057157; c=relaxed/simple;
	bh=fEvoaHFmoaJ+2+tIFCMQtgnwukgReVbMkmGkb5xkpR4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=MPLod9xZOzZe3zQClbzREa117S3OvH59pf2GdZq3vETwmea2zX/KeYm2quCk6Esu8WVB9d6AmuENQOiMrwlr4FqOR8+gS+UgOMceH3dR/BzbSnkD3KaWbkI2UuG2nPO4iLYDeYau1rwZV/2kR/ekLaqAJISLyyA6iBLmfG4hvEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yHpnY4+Y; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yHpnY4+Y"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b5edecdf94eso2290061a12.2
        for <linux-perf-users@vger.kernel.org>; Thu, 13 Nov 2025 10:05:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763057155; x=1763661955; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=41JzJBl0/lQZ4jR+Z1Nm/tB7c9vLw1945nKhgQp8mD0=;
        b=yHpnY4+YmmyuMkG0W1JSEgqpmvUjwuMo418YfPm9tP3zKa3CSWr7pe1PHh4ooR+io8
         V4xneKqiTk6Bn277+rETQtdciZuB7X7A336lJlpB9dSLu1CHxoQM9Ohr1+5fjjGk1nCi
         FHuX/hlBZIEcfPBRezZscRky2SOJ2eG91e88sS36mW5lx2gpxGVtVjxNqWJ3nGRSdSlv
         TH6k1IiiyeMz+CxMkJ3wbzsT4t0UAJBTRDSDsy6jO0Vyvnp64O+BvifW9pnefJp6WjJa
         /Nt9KK6P4vv0ASMs5xbzuOk8hAOU0CNQLHpD16zW2uhULCg44pU40XRptoYFw6H83EMp
         Gf0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763057155; x=1763661955;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=41JzJBl0/lQZ4jR+Z1Nm/tB7c9vLw1945nKhgQp8mD0=;
        b=XFHwIVnoKJcCNsWhgKELSfkuzfEvKNVKUlMVnF3tOt/nwQoi3cUylZsiF/R5Xme1gx
         JvyfsPULq9OWFtlvzEjRMahDIFt6AUnO2uHD9Ge+2hGDhzz2KsEYIAplVRdU2DJ6ENUN
         TEJJtl+Tt7Xota+yL57XGiIkqh0QpE0ncXZN1HXaDYv2TaZ0p8pbQR9y9dRQc4Gk8LIJ
         uwdxDZhuWF9LoQD6S1hFv+q+OXOP8jgp9zpxAzISVf2PJNb5gbneaM4LMFwpC4moQbJu
         JyZv+AYUGgUYrUcfOMVxk2/aWpMV3lqV5TB0jELIsJbWwF7ZKXeY0EJhSQqriEQ5h4u5
         5q4g==
X-Forwarded-Encrypted: i=1; AJvYcCV60Mjyjn3FS33ssN759Hyx8cI0xrzqNGYV5ou99U+prGMlR9raPccgpYchLPH0R4cHrOX0X5BVaA7yqEl6FuBc@vger.kernel.org
X-Gm-Message-State: AOJu0YxQWtVbIZzaijTCvfvDWEboq3wJaKW9PQSEuWJ0UJBxvy1e0ZJW
	kTM8KxKTX7ICd69K/eO4q9Hf8L2eDUbSYMEnr8JdQ4QR63mvwZZiIRFiIdJP9M37s2RVnCB5+dg
	3w68QBNmx8A==
X-Google-Smtp-Source: AGHT+IHhm5PLUXvrIrKLsniSTSgeWCsqDeSP0Hg/Mc9l08DaMLq5jjeBC+yyy63MuLZMHCRAJ2hL1QDSthUq
X-Received: from dlbbs44.prod.google.com ([2002:a05:7022:92c:b0:119:9f33:34a9])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:7e07:b0:119:e56c:189e
 with SMTP id a92af1059eb24-11b40f9ee6dmr162862c88.6.1763057154836; Thu, 13
 Nov 2025 10:05:54 -0800 (PST)
Date: Thu, 13 Nov 2025 10:05:12 -0800
In-Reply-To: <20251113180517.44096-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251113180517.44096-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251113180517.44096-7-irogers@google.com>
Subject: [PATCH v4 06/10] perf stat: Reduce scope of walltime_nsecs_stats
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Yang Li <yang.lee@linux.alibaba.com>, 
	James Clark <james.clark@linaro.org>, Thomas Falcon <thomas.falcon@intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

walltime_nsecs_stats is no longer used for counter values, move into
that stat_config where it controls certain things like noise
measurement.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-stat.c       | 16 ++++++++--------
 tools/perf/tests/parse-metric.c |  2 --
 tools/perf/tests/pmu-events.c   |  2 --
 tools/perf/util/config.c        |  2 ++
 tools/perf/util/stat-shadow.c   |  7 -------
 tools/perf/util/stat.h          |  2 --
 6 files changed, 10 insertions(+), 21 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index d6f4c84f7d7e..ca1c80c141b6 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -239,7 +239,7 @@ static inline void diff_timespec(struct timespec *r, struct timespec *a,
 static void perf_stat__reset_stats(void)
 {
 	evlist__reset_stats(evsel_list);
-	perf_stat__reset_shadow_stats();
+	memset(stat_config.walltime_nsecs_stats, 0, sizeof(*stat_config.walltime_nsecs_stats));
 }
 
 static int process_synthesized_event(const struct perf_tool *tool __maybe_unused,
@@ -455,8 +455,8 @@ static void process_interval(void)
 			pr_err("failed to write stat round event\n");
 	}
 
-	init_stats(&walltime_nsecs_stats);
-	update_stats(&walltime_nsecs_stats, stat_config.interval * 1000000ULL);
+	init_stats(stat_config.walltime_nsecs_stats);
+	update_stats(stat_config.walltime_nsecs_stats, stat_config.interval * 1000000ULL);
 	print_counters(&rs, 0, NULL);
 }
 
@@ -988,14 +988,14 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 	if (interval && stat_config.summary) {
 		stat_config.interval = 0;
 		stat_config.stop_read_counter = true;
-		init_stats(&walltime_nsecs_stats);
-		update_stats(&walltime_nsecs_stats, t1 - t0);
+		init_stats(stat_config.walltime_nsecs_stats);
+		update_stats(stat_config.walltime_nsecs_stats, t1 - t0);
 
 		evlist__copy_prev_raw_counts(evsel_list);
 		evlist__reset_prev_raw_counts(evsel_list);
 		evlist__reset_aggr_stats(evsel_list);
 	} else {
-		update_stats(&walltime_nsecs_stats, t1 - t0);
+		update_stats(stat_config.walltime_nsecs_stats, t1 - t0);
 		update_rusage_stats(&stat_config.ru_data);
 	}
 
@@ -2167,7 +2167,7 @@ static int process_stat_round_event(const struct perf_tool *tool __maybe_unused,
 	process_counters();
 
 	if (stat_round->type == PERF_STAT_ROUND_TYPE__FINAL)
-		update_stats(&walltime_nsecs_stats, stat_round->time);
+		update_stats(stat_config.walltime_nsecs_stats, stat_round->time);
 
 	if (stat_config.interval && stat_round->time) {
 		tsh.tv_sec  = stat_round->time / NSEC_PER_SEC;
@@ -2975,7 +2975,7 @@ int cmd_stat(int argc, const char **argv)
 		}
 
 		if (!interval) {
-			if (WRITE_STAT_ROUND_EVENT(walltime_nsecs_stats.max, FINAL))
+			if (WRITE_STAT_ROUND_EVENT(stat_config.walltime_nsecs_stats->max, FINAL))
 				pr_err("failed to write stat round event\n");
 		}
 
diff --git a/tools/perf/tests/parse-metric.c b/tools/perf/tests/parse-metric.c
index 66a5275917e2..7ca0b0791677 100644
--- a/tools/perf/tests/parse-metric.c
+++ b/tools/perf/tests/parse-metric.c
@@ -40,8 +40,6 @@ static void load_runtime_stat(struct evlist *evlist, struct value *vals)
 		count = find_value(evsel->name, vals);
 		evsel->supported = true;
 		evsel->stats->aggr->counts.val = count;
-		if (evsel__name_is(evsel, "duration_time"))
-			update_stats(&walltime_nsecs_stats, count);
 	}
 }
 
diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
index f40a828c9861..a99716862168 100644
--- a/tools/perf/tests/pmu-events.c
+++ b/tools/perf/tests/pmu-events.c
@@ -872,8 +872,6 @@ static int test__parsing_callback(const struct pmu_metric *pm,
 	evlist__alloc_aggr_stats(evlist, 1);
 	evlist__for_each_entry(evlist, evsel) {
 		evsel->stats->aggr->counts.val = k;
-		if (evsel__name_is(evsel, "duration_time"))
-			update_stats(&walltime_nsecs_stats, k);
 		k++;
 	}
 	evlist__for_each_entry(evlist, evsel) {
diff --git a/tools/perf/util/config.c b/tools/perf/util/config.c
index cc0746f494f4..e0219bc6330a 100644
--- a/tools/perf/util/config.c
+++ b/tools/perf/util/config.c
@@ -37,6 +37,8 @@
 
 #define METRIC_ONLY_LEN 20
 
+static struct stats walltime_nsecs_stats;
+
 struct perf_stat_config stat_config = {
 	.aggr_mode		= AGGR_GLOBAL,
 	.aggr_level		= MAX_CACHE_LVL + 1,
diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index cb7c741a1ebb..69f09db0c945 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -17,13 +17,6 @@
 #include "util/hashmap.h"
 #include "tool_pmu.h"
 
-struct stats walltime_nsecs_stats;
-
-void perf_stat__reset_shadow_stats(void)
-{
-	memset(&walltime_nsecs_stats, 0, sizeof(walltime_nsecs_stats));
-}
-
 static bool tool_pmu__is_time_event(const struct perf_stat_config *config,
 				   const struct evsel *evsel, int *tool_aggr_idx)
 {
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index 055b95d18106..f986911c9296 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -129,8 +129,6 @@ static inline void init_stats(struct stats *stats)
 struct evsel;
 struct evlist;
 
-extern struct stats walltime_nsecs_stats;
-
 enum metric_threshold_classify {
 	METRIC_THRESHOLD_UNKNOWN,
 	METRIC_THRESHOLD_BAD,
-- 
2.51.2.1041.gc1ab5b90ca-goog

