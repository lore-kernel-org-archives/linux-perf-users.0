Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B3234A3C1
	for <linux-perf-users@vger.kernel.org>; Fri, 24 Oct 2025 17:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761328768; cv=none; b=BDRiEltf0Aph3xc5CR9lCbEZLPSfXWOCFpyj1Xbjsq6oaCZmp/cMIoUXe0r01F1YaXyXWWeezcqfzZFuImAvnWwz2v/VYcF7KNpkoZX9gIBraWL9yri0CdKQp02y1gotHhLvSufhLaivRqAEgrV5y6Vw8S3kkvImu5JCHlclICo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761328768; c=relaxed/simple;
	bh=mEOeZdRB5TKzNcc+fI3rW3H+SBVWCA3FDy6gOrPFDS8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=gwtvRJLy9pFXMpVE71/VBBc2XEIIKj4mp2TkhX1Dxr4+zKBxRxy8iCKEUNA39cRLW9AmH0Lr3pV+TwbrHt6k5Q0W7O91oA/SgtMlzEsj2paKUtulIp3YPKGpUg2C6dmTMqOTyhVagpXffHWOsk6tujXjnr79yCazm4s0DF8WWBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UFv7Goff; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UFv7Goff"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-290b13e3ac0so20071165ad.0
        for <linux-perf-users@vger.kernel.org>; Fri, 24 Oct 2025 10:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761328764; x=1761933564; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KrDMZvJFcr7/lo49tH87BdhyUBn/6YXkb3DwbU+Za4Y=;
        b=UFv7Goff3IhJpe2Mr/79LSeee2aFJhcVs9wJzk1n5as2TTF/dB9DCyzd63DzekM+9k
         /OoSG4J9wEiUcJ1y7k3iKy413xrS6q/bdmK9re5eTUbWtGmYxft39XDelcV2FYMZ7Nhc
         poJ1bLTTpT3/t1ERPRIGskQMOxzQi3YPIAJtpmED6xk/M5yB4KuMC5FbgyHYs6kf5e9O
         3/3NGgWUzBwA5rpmKLrnveOn/BMg5y48B+qCNixi+5lJflRDvDkCBvgMtpCuhrvRD5M1
         EuZOqujC2ySXxvTe9YRm9rjmt86LQaPXhNcPUso0MLk87DPXttYkwwuvGdNco1i904lA
         7xSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761328764; x=1761933564;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KrDMZvJFcr7/lo49tH87BdhyUBn/6YXkb3DwbU+Za4Y=;
        b=ma6fK5NgRN9uN7fW+I5MtFYTxv+naOYeSoKL0ho/eXzyIJApDBLBXVEBR6oXfwUHtf
         KSitBlP0kyBgHiIWunaRzO4lSNKXqxqLHaetd2G42FwGxiwkZrI4L+Itc0kyvs2442rS
         5kmSEi2Q3XIdpczpS06MgBbuChA423SNE/MFnBdayf5hWfqwQtEkTJdiLjA1+Q8pUJr9
         nf9z0Melygwv/HmrvWNJ9LHF9kaiXd9JYbbu72oYc7mEZypSRyp9hI6wOg/Gk/61pEah
         Qxzp3MJC+HI2/2cZ3nRfgKrQ4kcvmnH2o3tEyX7T4CrIVbSYxkakJup1YWtB9q4S8Otb
         Onrw==
X-Forwarded-Encrypted: i=1; AJvYcCWy1euXyUj2hxaA30nqzZoiZT+mZVgm4/jPt7tXdsX3Z9M2EGBmfEoXnnsPeH3t9IATDMtW3a7cWJpyY5g8SNSc@vger.kernel.org
X-Gm-Message-State: AOJu0YzWdayzjlS9QVcTl/0Zw5+7euz1KpNrAvUTWlUH2fAERDx8HkEp
	fkLGcwFB7g+Ah9KNejYaemU5/wCgOIUWGUh8nfCenPH/fS3oJ40FryXGFCc34ZhlTKcggF+aY32
	b6vvT6FpKRQ==
X-Google-Smtp-Source: AGHT+IE9VBUQe4Btyjv6sTOUjOt2qEBy3WdrMTIrYSWLBGhPPd16gB4FVVQdSbcO3uOOsBgOIl1U5bqtikM/
X-Received: from plbms14.prod.google.com ([2002:a17:903:ace:b0:269:740f:8ae8])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:230d:b0:273:c463:7b2c
 with SMTP id d9443c01a7336-2948b9579ecmr39543765ad.3.1761328764248; Fri, 24
 Oct 2025 10:59:24 -0700 (PDT)
Date: Fri, 24 Oct 2025 10:58:46 -0700
In-Reply-To: <20251024175857.808401-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251024175857.808401-1-irogers@google.com>
X-Mailer: git-send-email 2.51.1.821.gb6fe4d2222-goog
Message-ID: <20251024175857.808401-12-irogers@google.com>
Subject: [PATCH v1 11/22] perf script: Change metric format to use json metrics
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
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The metric format option isn't properly supported. This change
improves that by making the sample events update the counts of an
evsel, where the shadow metric code expects to read the values.  To
support printing metrics, metrics need to be found. This is done on
the first attempt to print a metric. Every metric is parsed and then
the evsels in the metric's evlist compared to those in perf script
using the perf_event_attr type and config. If the metric matches then
it is added for printing. As an event in the perf script's evlist may
have >1 metric id, or different leader for aggregation, the first
metric matched will be displayed in those cases.

An example use is:
```
$ perf record -a -e '{instructions,cpu-cycles}:S' -a -- sleep 1
$ perf script -F period,metric
...
     867817
         metric:    0.30  insn per cycle
     125394
         metric:    0.04  insn per cycle
     313516
         metric:    0.11  insn per cycle
         metric:    1.00  insn per cycle
```

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-script.c | 239 ++++++++++++++++++++++++++++++++----
 1 file changed, 217 insertions(+), 22 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 8124fcb51da9..e24c3d9e01a8 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -33,6 +33,7 @@
 #include "util/path.h"
 #include "util/event.h"
 #include "util/mem-info.h"
+#include "util/metricgroup.h"
 #include "ui/ui.h"
 #include "print_binary.h"
 #include "print_insn.h"
@@ -341,9 +342,6 @@ struct evsel_script {
        char *filename;
        FILE *fp;
        u64  samples;
-       /* For metric output */
-       u64  val;
-       int  gnum;
 };
 
 static inline struct evsel_script *evsel_script(struct evsel *evsel)
@@ -2132,13 +2130,161 @@ static void script_new_line(struct perf_stat_config *config __maybe_unused,
 	fputs("\tmetric: ", mctx->fp);
 }
 
-static void perf_sample__fprint_metric(struct perf_script *script,
-				       struct thread *thread,
+struct script_find_metrics_args {
+	struct evlist *evlist;
+	bool system_wide;
+};
+
+static struct evsel *map_metric_evsel_to_script_evsel(struct evlist *script_evlist,
+						      struct evsel *metric_evsel)
+{
+	struct evsel *script_evsel;
+
+	evlist__for_each_entry(script_evlist, script_evsel) {
+		/* Skip if perf_event_attr differ. */
+		if (metric_evsel->core.attr.type != script_evsel->core.attr.type)
+			continue;
+		if (metric_evsel->core.attr.config != script_evsel->core.attr.config)
+			continue;
+		/* Skip if the script event has a metric_id that doesn't match. */
+		if (script_evsel->metric_id &&
+		    strcmp(evsel__metric_id(metric_evsel), evsel__metric_id(script_evsel))) {
+			pr_debug("Skipping matching evsel due to differing metric ids '%s' vs '%s'\n",
+				 evsel__metric_id(metric_evsel), evsel__metric_id(script_evsel));
+			continue;
+		}
+		return script_evsel;
+	}
+	return NULL;
+}
+
+static int script_find_metrics(const struct pmu_metric *pm,
+			       const struct pmu_metrics_table *table __maybe_unused,
+			       void *data)
+{
+	struct script_find_metrics_args *args = data;
+	struct evlist *script_evlist = args->evlist;
+	struct evlist *metric_evlist = evlist__new();
+	struct evsel *metric_evsel;
+	int ret = metricgroup__parse_groups(metric_evlist,
+					/*pmu=*/"all",
+					pm->metric_name,
+					/*metric_no_group=*/false,
+					/*metric_no_merge=*/false,
+					/*metric_no_threshold=*/true,
+					/*user_requested_cpu_list=*/NULL,
+					args->system_wide,
+					/*hardware_aware_grouping=*/false);
+
+	if (ret) {
+		/* Metric parsing failed but continue the search. */
+		goto out;
+	}
+
+	/*
+	 * Check the script_evlist has an entry for each metric_evlist entry. If
+	 * the script evsel was already set up avoid changing data that may
+	 * break it.
+	 */
+	evlist__for_each_entry(metric_evlist, metric_evsel) {
+		struct evsel *script_evsel =
+			map_metric_evsel_to_script_evsel(script_evlist, metric_evsel);
+		struct evsel *new_metric_leader;
+
+		if (!script_evsel) {
+			pr_debug("Skipping metric '%s' as evsel '%s' / '%s' is missing\n",
+				pm->metric_name, evsel__name(metric_evsel),
+				evsel__metric_id(metric_evsel));
+			goto out;
+		}
+
+		if (script_evsel->metric_leader == NULL)
+			continue;
+
+		if (metric_evsel->metric_leader == metric_evsel) {
+			new_metric_leader = script_evsel;
+		} else {
+			new_metric_leader =
+				map_metric_evsel_to_script_evsel(script_evlist,
+								 metric_evsel->metric_leader);
+		}
+		/* Mismatching evsel leaders. */
+		if (script_evsel->metric_leader != new_metric_leader) {
+			pr_debug("Skipping metric '%s' due to mismatching evsel metric leaders '%s' vs '%s'\n",
+				pm->metric_name, evsel__metric_id(metric_evsel),
+				evsel__metric_id(script_evsel));
+			goto out;
+		}
+	}
+	/*
+	 * Metric events match those in the script evlist, copy metric evsel
+	 * data into the script evlist.
+	 */
+	evlist__for_each_entry(metric_evlist, metric_evsel) {
+		struct evsel *script_evsel =
+			map_metric_evsel_to_script_evsel(script_evlist, metric_evsel);
+		struct metric_event *metric_me = metricgroup__lookup(&metric_evlist->metric_events,
+								     metric_evsel,
+								     /*create=*/false);
+
+		if (script_evsel->metric_id == NULL) {
+			script_evsel->metric_id = metric_evsel->metric_id;
+			metric_evsel->metric_id = NULL;
+		}
+
+		if (script_evsel->metric_leader == NULL) {
+			if (metric_evsel->metric_leader == metric_evsel) {
+				script_evsel->metric_leader = script_evsel;
+			} else {
+				script_evsel->metric_leader =
+					map_metric_evsel_to_script_evsel(script_evlist,
+								       metric_evsel->metric_leader);
+			}
+		}
+
+		if (metric_me) {
+			struct metric_expr *expr;
+			struct metric_event *script_me =
+				metricgroup__lookup(&script_evlist->metric_events,
+						    script_evsel,
+						    /*create=*/true);
+
+			if (!script_me) {
+				/*
+				 * As the metric_expr is created, the only
+				 * failure is a lack of memory.
+				 */
+				goto out;
+			}
+			list_splice_init(&metric_me->head, &script_me->head);
+			list_for_each_entry(expr, &script_me->head, nd) {
+				for (int i = 0; expr->metric_events[i]; i++) {
+					expr->metric_events[i] =
+						map_metric_evsel_to_script_evsel(script_evlist,
+									expr->metric_events[i]);
+				}
+			}
+		}
+	}
+	pr_debug("Found metric '%s' whose evsels match those of in the perf data\n",
+		 pm->metric_name);
+	evlist__delete(metric_evlist);
+out:
+	return 0;
+}
+
+static struct aggr_cpu_id script_aggr_cpu_id_get(struct perf_stat_config *config __maybe_unused,
+						    struct perf_cpu cpu)
+{
+	return aggr_cpu_id__global(cpu, /*data=*/NULL);
+}
+
+static void perf_sample__fprint_metric(struct thread *thread,
 				       struct evsel *evsel,
 				       struct perf_sample *sample,
 				       FILE *fp)
 {
-	struct evsel *leader = evsel__leader(evsel);
+	static bool init_metrics;
 	struct perf_stat_output_ctx ctx = {
 		.print_metric = script_print_metric,
 		.new_line = script_new_line,
@@ -2150,23 +2296,72 @@ static void perf_sample__fprint_metric(struct perf_script *script,
 			 },
 		.force_header = false,
 	};
-	struct evsel *ev2;
-	u64 val;
+	struct perf_counts_values *count, *old_count;
+	int cpu_map_idx, thread_map_idx, aggr_idx;
+	struct evsel *pos;
+
+	if (!init_metrics) {
+		/* One time initialization of stat_config and metric data. */
+		struct script_find_metrics_args args = {
+			.evlist = evsel->evlist,
+			/* TODO: Determine system-wide based on evlist.. */
+			.system_wide = true,
+		};
+		if (!stat_config.output)
+			stat_config.output = stdout;
+
+		if (!stat_config.aggr_map) {
+			/* TODO: currently only global aggregation is supported. */
+			assert(stat_config.aggr_mode == AGGR_GLOBAL);
+			stat_config.aggr_get_id = script_aggr_cpu_id_get;
+			stat_config.aggr_map =
+				cpu_aggr_map__new(evsel->evlist->core.user_requested_cpus,
+						  aggr_cpu_id__global, /*data=*/NULL,
+						  /*needs_sort=*/false);
+		}
 
-	if (!evsel->stats)
-		evlist__alloc_stats(&stat_config, script->session->evlist, /*alloc_raw=*/false);
-	if (evsel_script(leader)->gnum++ == 0)
-		perf_stat__reset_shadow_stats();
-	val = sample->period * evsel->scale;
-	evsel_script(evsel)->val = val;
-	if (evsel_script(leader)->gnum == leader->core.nr_members) {
-		for_each_group_member (ev2, leader) {
-			perf_stat__print_shadow_stats(&stat_config, ev2,
-						      evsel_script(ev2)->val,
-						      sample->cpu,
-						      &ctx);
+		metricgroup__for_each_metric(pmu_metrics_table__find(), script_find_metrics, &args);
+		init_metrics = true;
+	}
+
+	if (!evsel->stats) {
+		if (evlist__alloc_stats(&stat_config, evsel->evlist, /*alloc_raw=*/true) < 0)
+			return;
+	}
+	if (!evsel->stats->aggr) {
+		if (evlist__alloc_aggr_stats(evsel->evlist, stat_config.aggr_map->nr) < 0)
+			return;
+	}
+
+	/* Update the evsel's count using the sample's data. */
+	cpu_map_idx = perf_cpu_map__idx(evsel->core.cpus, (struct perf_cpu){sample->cpu});
+	thread_map_idx = perf_thread_map__idx(evsel->core.threads, sample->tid);
+	if (thread_map_idx < 0) {
+		/* Missing thread, check for any thread. */
+		if (perf_thread_map__pid(evsel->core.threads, /*idx=*/0) == -1) {
+			thread_map_idx = 0;
+		} else {
+			pr_info("Missing thread map entry for thread %d\n", sample->tid);
+			return;
+		}
+	}
+	count = perf_counts(evsel->counts, cpu_map_idx, thread_map_idx);
+	old_count = perf_counts(evsel->prev_raw_counts, cpu_map_idx, thread_map_idx);
+	count->val = old_count->val + sample->period;
+	count->run = old_count->run + 1;
+	count->ena = old_count->ena + 1;
+
+	/* Update the aggregated stats. */
+	perf_stat_process_counter(&stat_config, evsel);
+
+	/* Display all metrics. */
+	evlist__for_each_entry(evsel->evlist, pos) {
+		cpu_aggr_map__for_each_idx(aggr_idx, stat_config.aggr_map) {
+			perf_stat__print_shadow_stats(&stat_config, pos,
+						count->val,
+						aggr_idx,
+						&ctx);
 		}
-		evsel_script(leader)->gnum = 0;
 	}
 }
 
@@ -2348,7 +2543,7 @@ static void process_event(struct perf_script *script,
 	}
 
 	if (PRINT_FIELD(METRIC))
-		perf_sample__fprint_metric(script, thread, evsel, sample, fp);
+		perf_sample__fprint_metric(thread, evsel, sample, fp);
 
 	if (verbose > 0)
 		fflush(fp);
-- 
2.51.1.821.gb6fe4d2222-goog

