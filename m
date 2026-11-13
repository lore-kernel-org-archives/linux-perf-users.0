Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794599670;
	b=pXaNS91ZaqZ65K5oXX6qT2E/vQiciA6cuOhHUk7QBQC+fSODCT3Cpyo0CREwfWFRvkAk
	 KGh3gdKu9J6No4b3GJQr5igm4Ni7Uy+qY8Npf3bQ0+mBRUpONHqKpZ+FerZpgdL3qBlxk
	 wkvkamMa8eifwnkhqAuTuwm83V9SUEAjbk4rmWrj+mBefDDHWVe/b+ehxFcoECLj6wJPY
	 4IJHbl/frpuL7a5kSrlAXagD4OcVpCd24oGPsyiMTYeATDyVmuOoIkOEAzI0Z/TcsSX/Y
	 Z92N2Vt8QDbSGLgTUIbv6hpmX2G9kutX5siHX0yN+BzncxKeNxqeQvuyptECr4sxeBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794599670;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=Dd6sPSv5UsKYUvXfKX9G1K18DZVFGWpfdOLBXEawQTo=;
	b=3EJotq+lTjHmnz557Joj5lkKn16TgJJKsTBXQjYS/YdG3kY4cuEAyGENUGpGmHZsJsv/
	 qFOP3IEMwYwVCkpO5RQAyQhDmqfiOLQ8Io1qn3Rl6m3rSOIn1Mt+VxQLrfz1LF5EmNPJ1
	 hnt0Y+j9o/BUIXntW708wZdCDHfsoym8omSVoR1Q7kPluk6pZRTH9EdHdyNc/JVTAY1+0
	 rflxfhgxtybCkonkx4syTQODXyI/laNznJE20QjpZMDvVjPZFzjFQ23PtZkyn1ISaezcr
	 FMB/daip0HvDM2EdMxjprIPDTmdxU1MIbxOXedn2WBd9pfBySV4aSJxbxZdj7HgfOaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=EKJSj8S+;
	arc=none smtp.remote-ip=74.125.82.198
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3589D606F34A
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 19:54:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3589D606F34A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=EKJSj8S+
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-36a3451ea93so1367130eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 11:54:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794599669; x=1795204469; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Dd6sPSv5UsKYUvXfKX9G1K18DZVFGWpfdOLBXEawQTo=;
        b=EKJSj8S+c0iQUGY4maAn4mYmZ9iwz/+zlbOpGX0/KRbmn2ffoKG/gCOHDEJNMvtSs3
         VhWTEX1KZgUYEiJhaFiOgSdK6VejAdkcG2wTAls+2vnqaSR8M+do7cWJyI0h99hdatZ/
         4XmERWyB9EsXVlDUUT28kVHIQtHN/+kDaTgIxVtJKcsO4L6l/oRWNVUKFU9z7BCVmYtu
         fUBVh0p9cj3LjgDB04NOaHeOS9XSDKnNudZ91Xtx0GFff4/qcHVe/6vdzqddX7hqW6GF
         Jl05jmYBg9r8IVxiUqJf964qcjtCNbHSAFy6E4Q+XotWtDYUU3V3TqQHlFp6wdUlAruz
         T7xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794599669; x=1795204469;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Dd6sPSv5UsKYUvXfKX9G1K18DZVFGWpfdOLBXEawQTo=;
        b=z5gxMhm3/3KGapfcaKGAUhtKandAjOzV8ecgu80oWB4QQ98nY7JLZC0LyoN5k7D4yu
         wEHYst3kU9kP40+96Icmkyrt+Bbzq8fEMV50WhTQ6PEil9CTVyevdGP4cedFQjPMKPqZ
         KAsnC+pD4G9jknf6RPQV8HOjP9H+L1494waF8fudPdWGpzYSQ3q2I9A4chmQRLW9ekW8
         f9siuqJAAXzqUj0PcaCp7rhw56FnQe3q2mqEQxkI7EU0SQkMTJqlrmtS/odLhMyQL1+J
         FEl+BYi4UovnWbdLPiYcZRWojlMyC/dAJ6riLHjrT+RbzcyCkagfkAZTpHPiPwIeBRGJ
         yfuQ==
X-Gm-Message-State: APuU4Z/+z4KnRcO6rHkAHIq5tGEs2mnAt5iRdboecXnK61W3gQTeGoF4
	tnc6rgaMcPmuRq6XxEn4TzfSAthT5uVexhbDMZm+OhWDEb585mEzn8EbsuqNEU6zCKH69MzWAml
	7wI5XQpKVNA==
X-Received: from dybnj2.prod.google.com ([2002:a05:7300:d082:b0:375:5ce5:6e37])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:d189:b0:376:2ddd:2ab1
 with SMTP id 5a478bee46e88-37963660405mr3099899eec.4.1794599668891; Fri, 13
 Nov 2026 11:54:28 -0800 (PST)
Date: Fri, 13 Nov 2026 11:53:24 -0800
In-Reply-To: <20261113195335.2865725-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261113195335.2865725-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261113195335.2865725-20-irogers@google.com>
Subject: [PATCH v2 19/30] perf metricgroup: Move matching of metrics to
 recorded events from perf script
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
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
index f854eadb46eb..afed2353ef80 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -2350,151 +2350,6 @@ static void script_new_line(struct perf_stat_config *config __maybe_unused,
 	/* Each metric is printed on its own line by script_print_metric(). */
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
@@ -2523,12 +2378,6 @@ static void perf_sample__fprint_metric(struct thread *thread,
 
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
 
@@ -2542,8 +2391,9 @@ static void perf_sample__fprint_metric(struct thread *thread,
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
index fba02619ffb5..9922445a6d15 100644
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
2.56.1.703.gf848ed807c-goog

