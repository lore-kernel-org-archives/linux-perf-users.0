Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795212908;
	b=N1Q/oKx9ltUaVugATC37t6C1e9CLtblqUX2QZVipEkAyrZD/+d5ZsMMqe5NJ6ba+CIKV
	 /uwa1j+O9eIglmMYMfz/r5vhlj/StX0/sgOcajV5epkbehXeUKK8XPtUFj8Gv2x3uThbQ
	 za0DwNotIu0yijmRTxYtSDLCSdYCvEbGe+kuuAjGb+OrRNzJIQ6UfUaVyJc/LFOa0rm9y
	 0x8vCIpPqFnOnAV4RcUPDTSTZ1dkZupdkXc6TP2WI7j3aqqOk5BPlJx4EgJD0jCjtCvsx
	 NMsneUj25QA7cuZ9b+P+atp6isGSfEVbSM1wdSIJOpqI2zMTPupGeSOfVPccBRy1xow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795212908;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=u3apUpuScIs0ycHDErWWJzNI6wCQ/fKpNWRrmrwxM94=;
	b=nNs68spHE073pZ4bl81LdC5PQLNReKxpyCz4hMH7p0e2inftQXIXtlM+3YCUXzpgNAJM
	 zGHQQb8yPbTru0S9KV7hGH5k6qiCoy+3+96nBMA+DuWo6kC+BV4sQFIDtvvfwjWhUZrfr
	 y4663kklLOZXj9056NbBRNd8Xbe1t67OPoQmZPOiHHNAFK77BKUB9sp5iw2lb0bY60Ozb
	 m/AlWBIIhRlCpdydJivTCdBHf0VmwQSG8x1T+LcV7bkfTXw8z3nVCe6ajmfRvQIeRkhH6
	 6cNhVzZGTWlLzTPQLXk0z35SEWmUu8P6+33kCiN2QzTloat3t3VM9DnU219vwr33zqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=G2yRsBY0;
	arc=none smtp.remote-ip=74.125.82.197
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403F0606A330
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 22:15:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 403F0606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=G2yRsBY0
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-382af5cfc58so3819422eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 14:15:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795212905; x=1795817705; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u3apUpuScIs0ycHDErWWJzNI6wCQ/fKpNWRrmrwxM94=;
        b=G2yRsBY0b7thejxXtqDRyLTkzOL0s4D9hd5TtFAkvfy5LRFsFjOvcsi8+9CPE1X99T
         1CVZLBMNmMhjHSJrR/wG1IgwyRSP/5MQ6YoE/idP4eRO7Rd7eBmQQgP1E7n1nEH4hk4O
         ngQPHrAexsQe3gvx+7ImVnZPC77g74DeIlPokp4mzgvKEHHBhvMO3y+L4dIJH1YcKWHb
         Xh3c8aftS7hDfPyn1Ykh8BzZMbhEJHqMUMIv/w8XvAo7wHdQIpNW5aekf6984ddKwkL4
         nUW5msF37PWJgqXZAj67I+k5S+hBhHhX1/Jtj94amiHVEyLeZB40OrrK2WKXLtE1fJn0
         M7oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795212905; x=1795817705;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=u3apUpuScIs0ycHDErWWJzNI6wCQ/fKpNWRrmrwxM94=;
        b=mCcDKjY9+bv7vJbW1BygGYPvHTafHUx7xtdGo9S3keshM6Xa5bW9nXoQVt593hgsCt
         rHuTajukrUGq3bEvWgjJAIQgrJgzwgU7VHxEcc9XdFUVVHMz4BDgxoAjaF4bWPFduJWb
         UvOCBNCOVtjYJ92j8NX6mhLZrKB14yceloEUMToqu7RVwtTR2zBrJcl2H9i1K5DUv6bG
         UclJEZrCZiyMswlV2CMoC7cI2LTyE4Yx7lVmrQIYxcEepUDEkCbJXJYNGByLFAz41oUe
         OpDsbFXtYUgIpULmREL5m3Ut+kklFnr+VmdtqV0X+OEgbYZHZIJq1AiApjBa51+eCjXR
         C48w==
X-Gm-Message-State: APuU4Z8mtnogOFapsTmpb5aY0kE4x4zpQ/Aj7+jK5xJd+8opd1s/Fd0Z
	aQq59yHdWtRtVC9gDms+RqJ+EH2HJMAOYsHUcWtgpLdIhumhW6aWMjng1nvVA4EsVxBp4z1hig4
	LiuLRf7K92Q==
X-Received: from dycue7.prod.google.com ([2002:a05:7300:87:b0:386:46f:406])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:f283:b0:386:9854:9123
 with SMTP id 5a478bee46e88-3869854950emr1174215eec.14.1795212905000; Fri, 20
 Nov 2026 14:15:05 -0800 (PST)
Date: Fri, 20 Nov 2026 14:13:19 -0800
In-Reply-To: <20261120221332.2245191-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261120221332.2245191-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261120221332.2245191-19-irogers@google.com>
Subject: [PATCH v3 18/30] perf metricgroup: Pass struct perf_pmus to metricgroup__for_each_metric()
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

metricgroup__sys_event_iter() matched system metrics against uncore
PMUs using the live host's PMUs, so when processing a perf.data file
from another machine system metrics were matched against the wrong PMU
topology. Add a struct perf_pmus * argument to
metricgroup__for_each_metric() and use it to match the metric's compat
identifier. Callers pass the PMUs of the environment they are working
on.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-script.c    |  4 +++-
 tools/perf/util/metricgroup.c  | 12 +++++++-----
 tools/perf/util/metricgroup.h  | 14 ++++++++++++--
 tools/perf/util/print-events.c |  3 ++-
 4 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 97bad639753f..f854eadb46eb 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -2523,6 +2523,7 @@ static void perf_sample__fprint_metric(struct thread *thread,
 
 	if (!init_metrics) {
 		/* One time initialization of stat_config and metric data. */
+		struct perf_env *env = evlist__env(evsel->evlist) ?: host_env();
 		struct script_find_metrics_args args = {
 			.evlist = evsel->evlist,
 			.system_wide = perf_thread_map__pid(evsel->core.threads, /*idx=*/0) == -1,
@@ -2541,7 +2542,8 @@ static void perf_sample__fprint_metric(struct thread *thread,
 						  /*needs_sort=*/false);
 		}
 
-		metricgroup__for_each_metric(pmu_metrics_table__find(), script_find_metrics, &args);
+		metricgroup__for_each_metric(perf_env__pmus(env), pmu_metrics_table__find(),
+					     script_find_metrics, &args);
 		init_metrics = true;
 	}
 
diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 80c2086555a8..fba02619ffb5 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -406,6 +406,7 @@ static bool match_pm_metric_or_groups(struct perf_pmus *pmus, const struct pmu_m
 }
 
 struct metricgroup_iter_data {
+	struct perf_pmus *pmus;
 	pmu_metric_iter_fn fn;
 	void *data;
 };
@@ -421,14 +422,15 @@ static int metricgroup__sys_event_iter(const struct pmu_metric *pm,
 		return 0;
 
 	/* Only process with the iterator if there is a a PMU that matches the ID. */
-	pmu = perf_pmus__scan_for_uncore_id(perf_env__pmus(host_env()), pmu, pm->compat);
+	pmu = perf_pmus__scan_for_uncore_id(d->pmus, pmu, pm->compat);
 	return pmu ? d->fn(pm, table, d->data) : 0;
 }
 
-int metricgroup__for_each_metric(const struct pmu_metrics_table *table, pmu_metric_iter_fn fn,
-				 void *data)
+int metricgroup__for_each_metric(struct perf_pmus *pmus, const struct pmu_metrics_table *table,
+				 pmu_metric_iter_fn fn, void *data)
 {
 	struct metricgroup_iter_data sys_data = {
+		.pmus = pmus,
 		.fn = fn,
 		.data = data,
 	};
@@ -1118,7 +1120,7 @@ static int metricgroup__add_metric(struct perf_pmus *pmus, const char *pmu,
 	 * Iterate over all metrics seeing if metric matches either the
 	 * name or group. When it does add the metric to the list.
 	 */
-	ret = metricgroup__for_each_metric(table, metricgroup__add_metric_callback, &data);
+	ret = metricgroup__for_each_metric(pmus, table, metricgroup__add_metric_callback, &data);
 	if (!ret && !data.has_match)
 		ret = -ENOENT;
 
@@ -1656,7 +1658,7 @@ bool metricgroup__has_metric_or_groups(struct perf_pmus *pmus, const char *pmu,
 		.metric_or_groups = metric_or_groups,
 	};
 
-	return metricgroup__for_each_metric(table,
+	return metricgroup__for_each_metric(pmus, table,
 					    metricgroup__has_metric_or_groups_callback,
 					    &data)
 		? true : false;
diff --git a/tools/perf/util/metricgroup.h b/tools/perf/util/metricgroup.h
index bc5d3d21f405..2cc28b3eb983 100644
--- a/tools/perf/util/metricgroup.h
+++ b/tools/perf/util/metricgroup.h
@@ -85,8 +85,18 @@ int metricgroup__parse_groups_test(struct evlist *evlist,
 				   const char *str,
 				   bool cputype_filter);
 
-int metricgroup__for_each_metric(const struct pmu_metrics_table *table, pmu_metric_iter_fn fn,
-				 void *data);
+/**
+ * metricgroup__for_each_metric() - Iterate over metrics in @table and system
+ *                                  metrics matching @pmus.
+ * @pmus: The PMUs used to match system metric compat identifiers.
+ * @table: Optional CPU metrics table to iterate over.
+ * @fn: Callback invoked for each metric.
+ * @data: User data passed to @fn.
+ *
+ * Return: 0 on success or the non-zero return value from @fn.
+ */
+int metricgroup__for_each_metric(struct perf_pmus *pmus, const struct pmu_metrics_table *table,
+				 pmu_metric_iter_fn fn, void *data);
 bool metricgroup__has_metric_or_groups(struct perf_pmus *pmus, const char *pmu,
 				       const char *metric_or_groups);
 unsigned int metricgroups__topdown_max_level(void);
diff --git a/tools/perf/util/print-events.c b/tools/perf/util/print-events.c
index fe48efe9aefb..6145367d2184 100644
--- a/tools/perf/util/print-events.c
+++ b/tools/perf/util/print-events.c
@@ -297,7 +297,8 @@ void metricgroup__print(const struct print_callbacks *print_cb, void *print_stat
 	groups.node_cmp = mep_cmp;
 	groups.node_delete = mep_delete;
 
-	metricgroup__for_each_metric(table, metricgroup__add_to_mep_groups_callback, &groups);
+	metricgroup__for_each_metric(perf_env__pmus(host_env()), table,
+				     metricgroup__add_to_mep_groups_callback, &groups);
 
 	for (node = rb_first_cached(&groups.entries); node; node = next) {
 		struct mep *me = container_of(node, struct mep, nd);
-- 
2.56.1.750.gf70dc682cf-goog

