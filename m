Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793749549;
	b=aNlSBLVb/hLVDabbwLecOCNOh7d786ZyjjFMnE5sn2jLZnyFUseno/ZQ3FLKUeBlV1qj
	 XNMfPCBXW+YvVTagc+zp9hpkKVqyV7ATOXIlc0OYZ4rMDQKPdfLjR0I9Gy5lYpmEEtKzA
	 BK6BgxdH3uzordu54o+RrqUGlqUIPxbeTLA2isFaq2FVKcEkShpZNyCvJnnk1LsRGbFtf
	 St5joPfOUP25T9NG6Y1JsDUr0MU/bjvVTBcB0RfBLZ/P/Wmu5EegsTVl/f2lgb30pW7cN
	 Ak+1yuWwzS1YtM41libsvh90ve3hiOIYeYxhjGKmJhxnDC+KuPcSDWxmvXY0j5m7liA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793749549;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=/c9dAAdPppqLCH60TYdEbM0bjim2NQq3FwqogCqlwxw=;
	b=vqf8UjREFzgVyquJ0dVyZADGWUV5x+AT36OxNt+cIQRlRqypy70yifJG+8wsabE0QUdF
	 oD7kplRAdmT7PpH8BGO79bSwVlBJ4pPDzvxI7v5WT45Ri5Psm0C57m+dQMQbToflTCZdH
	 P6k95gfLyR9QLAVICsGVw/aQuxL49BXEI0MDXHK+d4UhynbVX6yGt2Gq09Uqmf7ynwCHt
	 jpxtvmNevpY9UR8ezKKgrk9RbC5s2iztcE3EsCcA9odWu7aQM11W+lTA8VkNLz8w6SRG6
	 MrCCaJNgyolmPELc/Kd+qPM92ajMqh3HNO9dm2hYGZoZ6ADsxtmz9225Pw+aKXCjPUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=AdA1S5I+;
	arc=none smtp.remote-ip=74.125.82.199
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A858A606EEA7
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Nov 2026 23:45:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A858A606EEA7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=AdA1S5I+
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-36a223755e4so315780eec.0
        for <linux-perf-users@vger.kernel.org>; Tue, 03 Nov 2026 15:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793749548; x=1794354348; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/c9dAAdPppqLCH60TYdEbM0bjim2NQq3FwqogCqlwxw=;
        b=AdA1S5I+agN485n4wGTdxTRZtrKj/kQn2kThMHJGdE3SKhE7RQwKXgc/wimcM9TC3s
         xt8Ib2C9cGMe5Bgm0vFCQyJiisanLNCronXTFt4sBo/CObDAmdW2PiGd1792byfhSP7/
         xjptxcs7hwS7RulMcssaG6rVUtt6ryzXIe8ZGYy9GtLzeXI/FTuLGQQUuVv8vl7ox33f
         iyaNV0MBHtg7QvcYLBvmSQBKPZPcv55Rvc6IrhSKoVloTZi413Eh0w12r0+B9f7wnIsM
         O6zMJWrSKTWUyintHvJgoZPTH5tdCrEG1O/KD+F/+Ax4aVmH596TRPzYD4O4dgRPC1yu
         Syuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793749548; x=1794354348;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/c9dAAdPppqLCH60TYdEbM0bjim2NQq3FwqogCqlwxw=;
        b=PaOBJEHfzq6WBzegh55/QA7deSsgXbqRkbv8hnjuUvtV/i/XrTmj8dlDhVMwnh1K96
         3lc1WGb3x6gWhnjQr1vrQcWNIK6ZgsC5oLnkdfhGG5vWs9Qop7Syhw3WrTNbGkNeSRVP
         nvzREkiwX+uYbEyB4Ektg8wnt3oGDnvEwy85v5VswhVpO4XIEveRtlkTZM4YfEsGYfuX
         AgljVN6QfA0IxQo9WhQk6A/6i0CDhexKSIPN/aZZGLNT2yOqGgTk8dow59gwfjyPXcgG
         ebp6LfvR+9cm4OUaFX37fxBXvS+wQ8veULuZ+JL0ZRpWuRjgdYMKQe6c+5Mi+wQ84iB5
         Rp5A==
X-Gm-Message-State: APuU4Z9oV3ZGfpArHr4qwvKyRPY9h4cyJJzSGuwaZ3fW0prE4yMCf31K
	jXtiexSviZEmQUwy0P9A49duYqkAqG5ez4p1u8UZ87S2ZwCK4UvFF8+4JnrzxAo44gBdObZkmBA
	41xqM0Tv/vHnQ+/di2CT3UT4gIRw/8Ed8RT6xvEMEy9hDNVCB5islgjXXRt5GIfVP5u0XImQRD6
	NPy+7+NSGt4O/KFIczA6vM24J+SA+Xvk1uVqllipliDeKknYrzqLFfLVc=
X-Received: from dlbvg13.prod.google.com ([2002:a05:7022:7f0d:b0:150:117b:cbf8])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:b047:20b0:1a3:bfb6:44ad
 with SMTP id a92af1059eb24-1ac5da797d4mr23809134c88.32.1793749547250; Tue, 03
 Nov 2026 15:45:47 -0800 (PST)
Date: Tue,  3 Nov 2026 15:44:31 -0800
In-Reply-To: <20261103234502.1008382-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261103234502.1008382-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
Message-ID: <20261103234502.1008382-16-irogers@google.com>
Subject: [PATCH v1 15/41] perf metricgroup: Move matching of metrics to
 recorded events from perf script
From: Ian Rogers <irogers@google.com>
To: linux-perf-users@vger.kernel.org, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Kan Liang <kan.liang@linux.intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, John Garry <john.garry@linux.dev>, 
	Will Deacon <will@kernel.org>, Leo Yan <leo.yan@arm.com>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Sandipan Das <sandipan.das@amd.com>, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

perf script finds metrics whose events are all present in the
perf.data file's evlist so that they can be displayed alongside
samples. Move this code into metricgroup.c as
metricgroup__add_matching_metrics() so that it can be shared with
other commands, such as perf stat report. No functional change.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-script.c   | 156 +--------------------------------
 tools/perf/util/metricgroup.c | 157 ++++++++++++++++++++++++++++++++++
 tools/perf/util/metricgroup.h |  12 +++
 3 files changed, 172 insertions(+), 153 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 8bef76eaf67d..da3f1793774e 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -2354,151 +2354,6 @@ static void script_new_line(struct perf_stat_config *config __maybe_unused,
 	fputs("\tmetric: ", mctx->fp);
 }
 
-struct script_find_metrics_args {
-	struct evlist *evlist;
-	bool system_wide;
-};
-
-static struct evsel *map_metric_evsel_to_script_evsel(struct evlist *script_evlist,
-						      struct evsel *metric_evsel)
-{
-	struct evsel *script_evsel;
-
-	evlist__for_each_entry(script_evlist, script_evsel) {
-		/* Skip if perf_event_attr differ. */
-		if (metric_evsel->core.attr.type != script_evsel->core.attr.type)
-			continue;
-		if (metric_evsel->core.attr.config != script_evsel->core.attr.config)
-			continue;
-		/* Skip if the script event has a metric_id that doesn't match. */
-		if (script_evsel->metric_id &&
-		    strcmp(evsel__metric_id(metric_evsel), evsel__metric_id(script_evsel))) {
-			pr_debug("Skipping matching evsel due to differing metric ids '%s' vs '%s'\n",
-				 evsel__metric_id(metric_evsel), evsel__metric_id(script_evsel));
-			continue;
-		}
-		return script_evsel;
-	}
-	return NULL;
-}
-
-static int script_find_metrics(const struct pmu_metric *pm,
-			       const struct pmu_metrics_table *table __maybe_unused,
-			       void *data)
-{
-	struct script_find_metrics_args *args = data;
-	struct evlist *script_evlist = args->evlist;
-	struct evlist *metric_evlist = evlist__new();
-	struct evsel *metric_evsel;
-	int ret = metricgroup__parse_groups(metric_evlist,
-					/*pmu=*/"all",
-					/*cputype_filter=*/false,
-					pm->metric_name,
-					/*metric_no_group=*/false,
-					/*metric_no_merge=*/false,
-					/*metric_no_threshold=*/true,
-					/*user_requested_cpu_list=*/NULL,
-					args->system_wide,
-					/*hardware_aware_grouping=*/false);
-
-	if (ret) {
-		/* Metric parsing failed but continue the search. */
-		goto out;
-	}
-
-	/*
-	 * Check the script_evlist has an entry for each metric_evlist entry. If
-	 * the script evsel was already set up avoid changing data that may
-	 * break it.
-	 */
-	evlist__for_each_entry(metric_evlist, metric_evsel) {
-		struct evsel *script_evsel =
-			map_metric_evsel_to_script_evsel(script_evlist, metric_evsel);
-		struct evsel *new_metric_leader;
-
-		if (!script_evsel) {
-			pr_debug("Skipping metric '%s' as evsel '%s' / '%s' is missing\n",
-				pm->metric_name, evsel__name(metric_evsel),
-				evsel__metric_id(metric_evsel));
-			goto out;
-		}
-
-		if (script_evsel->metric_leader == NULL)
-			continue;
-
-		if (metric_evsel->metric_leader == metric_evsel) {
-			new_metric_leader = script_evsel;
-		} else {
-			new_metric_leader =
-				map_metric_evsel_to_script_evsel(script_evlist,
-								 metric_evsel->metric_leader);
-		}
-		/* Mismatching evsel leaders. */
-		if (script_evsel->metric_leader != new_metric_leader) {
-			pr_debug("Skipping metric '%s' due to mismatching evsel metric leaders '%s' vs '%s'\n",
-				pm->metric_name, evsel__metric_id(metric_evsel),
-				evsel__metric_id(script_evsel));
-			goto out;
-		}
-	}
-	/*
-	 * Metric events match those in the script evlist, copy metric evsel
-	 * data into the script evlist.
-	 */
-	evlist__for_each_entry(metric_evlist, metric_evsel) {
-		struct evsel *script_evsel =
-			map_metric_evsel_to_script_evsel(script_evlist, metric_evsel);
-		struct metric_event *metric_me =
-			metricgroup__lookup(evlist__metric_events(metric_evlist),
-					    metric_evsel,
-					    /*create=*/false);
-
-		if (script_evsel->metric_id == NULL) {
-			script_evsel->metric_id = metric_evsel->metric_id;
-			metric_evsel->metric_id = NULL;
-		}
-
-		if (script_evsel->metric_leader == NULL) {
-			if (metric_evsel->metric_leader == metric_evsel) {
-				script_evsel->metric_leader = script_evsel;
-			} else {
-				script_evsel->metric_leader =
-					map_metric_evsel_to_script_evsel(script_evlist,
-								       metric_evsel->metric_leader);
-			}
-		}
-
-		if (metric_me) {
-			struct metric_expr *expr;
-			struct metric_event *script_me =
-				metricgroup__lookup(evlist__metric_events(script_evlist),
-						    script_evsel,
-						    /*create=*/true);
-
-			if (!script_me) {
-				/*
-				 * As the metric_expr is created, the only
-				 * failure is a lack of memory.
-				 */
-				goto out;
-			}
-			list_splice_init(&metric_me->head, &script_me->head);
-			list_for_each_entry(expr, &script_me->head, nd) {
-				for (int i = 0; expr->metric_events[i]; i++) {
-					expr->metric_events[i] =
-						map_metric_evsel_to_script_evsel(script_evlist,
-									expr->metric_events[i]);
-				}
-			}
-		}
-	}
-	pr_debug("Found metric '%s' whose evsels match those of in the perf data\n",
-		 pm->metric_name);
-out:
-	evlist__put(metric_evlist);
-	return 0;
-}
-
 static struct aggr_cpu_id script_aggr_cpu_id_get(struct perf_stat_config *config __maybe_unused,
 						    struct perf_cpu cpu)
 {
@@ -2528,12 +2383,6 @@ static void perf_sample__fprint_metric(struct thread *thread,
 
 	if (!init_metrics) {
 		/* One time initialization of stat_config and metric data. */
-		struct perf_env *env = evlist__env(evsel->evlist) ?: host_env();
-		struct script_find_metrics_args args = {
-			.evlist = evsel->evlist,
-			.system_wide = perf_thread_map__pid(evsel->core.threads, /*idx=*/0) == -1,
-
-		};
 		if (!stat_config.output)
 			stat_config.output = stdout;
 
@@ -2547,8 +2396,9 @@ static void perf_sample__fprint_metric(struct thread *thread,
 						  /*needs_sort=*/false);
 		}
 
-		metricgroup__for_each_metric(perf_env__pmus(env), pmu_metrics_table__find(),
-					     script_find_metrics, &args);
+		metricgroup__add_matching_metrics(evsel->evlist,
+						  perf_thread_map__pid(evsel->core.threads,
+								       /*idx=*/0) == -1);
 		init_metrics = true;
 	}
 
diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 876c549069e5..51dbdeac5e60 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -453,6 +453,163 @@ int metricgroup__for_each_metric(struct perf_pmus *pmus, const struct pmu_metric
 	return pmu_for_each_sys_metric(metricgroup__sys_event_iter, &sys_data);
 }
 
+struct find_matching_metrics_args {
+	struct evlist *evlist;
+	bool system_wide;
+};
+
+static struct evsel *map_metric_evsel_to_evlist(struct evlist *data_evlist,
+						struct evsel *metric_evsel)
+{
+	struct evsel *data_evsel;
+
+	evlist__for_each_entry(data_evlist, data_evsel) {
+		/* Skip if perf_event_attr differ. */
+		if (metric_evsel->core.attr.type != data_evsel->core.attr.type)
+			continue;
+		if (metric_evsel->core.attr.config != data_evsel->core.attr.config)
+			continue;
+		/* Skip if the data event has a metric_id that doesn't match. */
+		if (data_evsel->metric_id &&
+		    strcmp(evsel__metric_id(metric_evsel), evsel__metric_id(data_evsel))) {
+			pr_debug("Skipping matching evsel due to differing metric ids '%s' vs '%s'\n",
+				 evsel__metric_id(metric_evsel), evsel__metric_id(data_evsel));
+			continue;
+		}
+		return data_evsel;
+	}
+	return NULL;
+}
+
+static int find_matching_metrics_cb(const struct pmu_metric *pm,
+				    const struct pmu_metrics_table *table __maybe_unused,
+				    void *data)
+{
+	struct find_matching_metrics_args *args = data;
+	struct evlist *data_evlist = args->evlist;
+	struct evlist *metric_evlist = evlist__new();
+	struct evsel *metric_evsel;
+	int ret = metricgroup__parse_groups(metric_evlist,
+					/*pmu=*/"all",
+					/*cputype_filter=*/false,
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
+	 * Check the data_evlist has an entry for each metric_evlist entry. If
+	 * the data evsel was already set up avoid changing data that may
+	 * break it.
+	 */
+	evlist__for_each_entry(metric_evlist, metric_evsel) {
+		struct evsel *data_evsel =
+			map_metric_evsel_to_evlist(data_evlist, metric_evsel);
+		struct evsel *new_metric_leader;
+
+		if (!data_evsel) {
+			pr_debug("Skipping metric '%s' as evsel '%s' / '%s' is missing\n",
+				pm->metric_name, evsel__name(metric_evsel),
+				evsel__metric_id(metric_evsel));
+			goto out;
+		}
+
+		if (data_evsel->metric_leader == NULL)
+			continue;
+
+		if (metric_evsel->metric_leader == metric_evsel) {
+			new_metric_leader = data_evsel;
+		} else {
+			new_metric_leader =
+				map_metric_evsel_to_evlist(data_evlist,
+								 metric_evsel->metric_leader);
+		}
+		/* Mismatching evsel leaders. */
+		if (data_evsel->metric_leader != new_metric_leader) {
+			pr_debug("Skipping metric '%s' due to mismatching evsel metric leaders '%s' vs '%s'\n",
+				pm->metric_name, evsel__metric_id(metric_evsel),
+				evsel__metric_id(data_evsel));
+			goto out;
+		}
+	}
+	/*
+	 * Metric events match those in the data evlist, copy metric evsel
+	 * data into the data evlist.
+	 */
+	evlist__for_each_entry(metric_evlist, metric_evsel) {
+		struct evsel *data_evsel =
+			map_metric_evsel_to_evlist(data_evlist, metric_evsel);
+		struct metric_event *metric_me =
+			metricgroup__lookup(evlist__metric_events(metric_evlist),
+					    metric_evsel,
+					    /*create=*/false);
+
+		if (data_evsel->metric_id == NULL) {
+			data_evsel->metric_id = metric_evsel->metric_id;
+			metric_evsel->metric_id = NULL;
+		}
+
+		if (data_evsel->metric_leader == NULL) {
+			if (metric_evsel->metric_leader == metric_evsel) {
+				data_evsel->metric_leader = data_evsel;
+			} else {
+				data_evsel->metric_leader =
+					map_metric_evsel_to_evlist(data_evlist,
+								       metric_evsel->metric_leader);
+			}
+		}
+
+		if (metric_me) {
+			struct metric_expr *expr;
+			struct metric_event *data_me =
+				metricgroup__lookup(evlist__metric_events(data_evlist),
+						    data_evsel,
+						    /*create=*/true);
+
+			if (!data_me) {
+				/*
+				 * As the metric_expr is created, the only
+				 * failure is a lack of memory.
+				 */
+				goto out;
+			}
+			list_splice_init(&metric_me->head, &data_me->head);
+			list_for_each_entry(expr, &data_me->head, nd) {
+				for (int i = 0; expr->metric_events[i]; i++) {
+					expr->metric_events[i] =
+						map_metric_evsel_to_evlist(data_evlist,
+									expr->metric_events[i]);
+				}
+			}
+		}
+	}
+	pr_debug("Found metric '%s' whose evsels match those of in the perf data\n",
+		 pm->metric_name);
+out:
+	evlist__put(metric_evlist);
+	return 0;
+}
+
+int metricgroup__add_matching_metrics(struct evlist *evlist, bool system_wide)
+{
+	struct perf_env *env = evlist__env(evlist) ?: host_env();
+	struct find_matching_metrics_args args = {
+		.evlist = evlist,
+		.system_wide = system_wide,
+	};
+
+	return metricgroup__for_each_metric(perf_env__pmus(env), pmu_metrics_table__find(),
+					    find_matching_metrics_cb, &args);
+}
+
 static const char *code_characters = ",-=@";
 
 static int encode_metric_id(struct strbuf *sb, const char *x)
diff --git a/tools/perf/util/metricgroup.h b/tools/perf/util/metricgroup.h
index 2cc28b3eb983..2069211913dc 100644
--- a/tools/perf/util/metricgroup.h
+++ b/tools/perf/util/metricgroup.h
@@ -97,6 +97,18 @@ int metricgroup__parse_groups_test(struct evlist *evlist,
  */
 int metricgroup__for_each_metric(struct perf_pmus *pmus, const struct pmu_metrics_table *table,
 				 pmu_metric_iter_fn fn, void *data);
+/**
+ * metricgroup__add_matching_metrics() - Add metrics whose events are in @evlist.
+ * @evlist: The evlist, typically read from a perf.data file, to add metrics to.
+ * @system_wide: Are the events in @evlist system wide?
+ *
+ * For every metric whose events all have a corresponding evsel in @evlist,
+ * add the metric to the metric events of @evlist so that it is computed and
+ * displayed along with the counts of the evsels.
+ *
+ * Return: 0 on success or a negative error code.
+ */
+int metricgroup__add_matching_metrics(struct evlist *evlist, bool system_wide);
 bool metricgroup__has_metric_or_groups(struct perf_pmus *pmus, const char *pmu,
 				       const char *metric_or_groups);
 unsigned int metricgroups__topdown_max_level(void);
-- 
2.56.0.385.gac671c819a-goog

