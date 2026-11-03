Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793749545;
	b=iegn56MDjneSv91ZBGd5X9Ts0Za3NTFvfFac5fV7XQ+kbfdhikdfhKWE+X/ybnCh+xU9
	 oOvmLPA+RUYwnGzgYkioTOkcPiyhGz6/y5X+TYOb8Vpj1v2zTB0lc8TFWxkhJhYmBCXl4
	 07mC1SS6LvrTVMYuZYnq6zqlfohpM5qD4Npi/1LNpx0wMvxrMnteHncj41JUwPbOvRJRL
	 SZ4/hEAoQY2WNxByOt0Eg/nkhAMIAg+0ooz80f7DzursJxoWh0V3IhOjrqw6fgeh7LHXU
	 QluvMaLw44Qn71lekTU9wMnAEUIz/Fk//RhjcvMScDU4uStXvozRjcOwWrJFeildsxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793749545;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=zhBtqDppIq+o+FUIi/aM7a65AxM2wGNN+XC5hub2vMM=;
	b=WY/kUhAwR0/F6G/6glnkgCUVLGvWwuLBFAWsjR85o4SOrgmQ6WnOGMNHI21bhIrdW2rl
	 2f26VG/U+9ZeqgBLUCG5xCxf8WFUYsTwSIc8t4JTe10th8YQRb5yabtO5SCSpKkzVFAFo
	 iMp5JX3XXwhH7kyTTw9JLee1zSpgO7QLnrPAw3sjvwg5+NmYaYZn7Y8EWz8JNedK65LLf
	 5PQuJiCVLzSh+XvCw1zBvBMD1ft2AxKeJbz0zpmbQ2InLlegskNUHT7Os5bTJy0GbauTi
	 wATjtK/yRFBxj8iuwZo9mBmxJPwB2/bTe0Mppl2mAenu5R71cio830W8r+omeNRj1+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="MMW1w4+/";
	arc=none smtp.remote-ip=209.85.214.198
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86500606D827
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Nov 2026 23:45:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86500606D827
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=MMW1w4+/
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2e942b1cc86so1033365ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 03 Nov 2026 15:45:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793749545; x=1794354345; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zhBtqDppIq+o+FUIi/aM7a65AxM2wGNN+XC5hub2vMM=;
        b=MMW1w4+/Bd3LL7i0h7rVkeO+xZexOJIE514S9G2R4lbJJWZpM56RaYrt+V87/42T97
         k1BbTpuLRX0fLZikOavypkeoPSmQAYK9uqd5gOMKvMLMHNtIb1xw+8csxkRz9Lsm5q7v
         SNMREYkWYSZCscTOSA/MedSZZ4uH6naD5EMEaW8IrrqYXfl9N9QPZWAps77/kv5Vj5pT
         fq1UpS9FP6UdfbrPn3dRlloBy0Xn+/s0TVoe31URYBdqu6JKTrpCy8t0PWU3xADz0q7D
         Y4tLRJA1g9p4oySBscEsphEeB1wIOtRfwS0Zi7Ogl28EV9Ok/wRi6D9JysAQu7iWY6pv
         1F8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793749545; x=1794354345;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zhBtqDppIq+o+FUIi/aM7a65AxM2wGNN+XC5hub2vMM=;
        b=B8VtP2sn351l6GHAGljDvgPBU83bx3icDizlEM4h7aavQ33N/8Nl3U+MZbVNANDwQz
         M36+hde/v+rY+zCmuTAAYU/VZyZhHAoXlw9N8p2FXoPQOLNw4XDrCzK1LPE9+QIDlwlI
         S3c51gkViTGjIwHpU65Lf6GTPawZ9YixYNr8Ol1nsfCpOK9vAq9Xzpyn/YMwQ+zYUPnH
         jVWhrcQgYnzfwq7aSQm8S5NYwuzU6Ef6y3/8pxdreJPVfG+GKTdxnUeimuaVTXm4Sxic
         TH5CAlRyVZg8Hc8x33T9lTq29ntswUnyvYUmgYlM7EeGAd6O69c9E6FoIDdQQ2Mvkjf3
         q3Wg==
X-Gm-Message-State: APuU4Z9pH7BnrfrNkmGra8tmxO9NB9YC/KedrBC72k4JMMJjV2To9d9f
	faEnCuMP7DNq/TkU1xaujZIIFbpk3ULyyFuUQyCxeRwtDotyjSE/kdCbc4GK2+vKZKqs9ZDtrzX
	rIncLORotpdyQPXz44hjK8bbhIlBYvSA0SSsAo4bYBXIVheB2Z2WHU+j2SgGFJ1ZEIEjxbKDpb8
	XFCLYsIJyc16tSU29O4fWsCC2Z9mvq85X2o5+lLQXYxZNHSgYQ41DMBQo=
X-Received: from plgi10.prod.google.com ([2002:a17:902:cf0a:b0:2df:3764:615])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ce05:b0:2dd:ad73:5b6f
 with SMTP id d9443c01a7336-2eb364b55camr132241095ad.31.1793749544646; Tue, 03
 Nov 2026 15:45:44 -0800 (PST)
Date: Tue,  3 Nov 2026 15:44:30 -0800
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
Message-ID: <20261103234502.1008382-15-irogers@google.com>
Subject: [PATCH v1 14/41] perf metricgroup: Pass struct perf_pmus to metricgroup__for_each_metric()
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
index b6691ebb1b4e..8bef76eaf67d 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -2528,6 +2528,7 @@ static void perf_sample__fprint_metric(struct thread *thread,
 
 	if (!init_metrics) {
 		/* One time initialization of stat_config and metric data. */
+		struct perf_env *env = evlist__env(evsel->evlist) ?: host_env();
 		struct script_find_metrics_args args = {
 			.evlist = evsel->evlist,
 			.system_wide = perf_thread_map__pid(evsel->core.threads, /*idx=*/0) == -1,
@@ -2546,7 +2547,8 @@ static void perf_sample__fprint_metric(struct thread *thread,
 						  /*needs_sort=*/false);
 		}
 
-		metricgroup__for_each_metric(pmu_metrics_table__find(), script_find_metrics, &args);
+		metricgroup__for_each_metric(perf_env__pmus(env), pmu_metrics_table__find(),
+					     script_find_metrics, &args);
 		init_metrics = true;
 	}
 
diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 100f54338e8e..876c549069e5 100644
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
@@ -1117,7 +1119,7 @@ static int metricgroup__add_metric(struct perf_pmus *pmus, const char *pmu,
 	 * Iterate over all metrics seeing if metric matches either the
 	 * name or group. When it does add the metric to the list.
 	 */
-	ret = metricgroup__for_each_metric(table, metricgroup__add_metric_callback, &data);
+	ret = metricgroup__for_each_metric(pmus, table, metricgroup__add_metric_callback, &data);
 	if (!ret && !data.has_match)
 		ret = -ENOENT;
 
@@ -1653,7 +1655,7 @@ bool metricgroup__has_metric_or_groups(struct perf_pmus *pmus, const char *pmu,
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
2.56.0.385.gac671c819a-goog

