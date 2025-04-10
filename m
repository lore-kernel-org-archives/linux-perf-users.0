Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D711FBCB1
	for <linux-perf-users@vger.kernel.org>; Thu, 10 Apr 2025 04:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744260355; cv=none; b=TvgysigcYq09nY+VB+K18nMkSf1iQor66T/tFIFVAmbLXBKKcHiGXV97sgYbIto5ZSFIsaG/7rUoosHXc+Aq+ePXOmV3Mu9/vtbw394jTQKmUY7Gmv6yvkAgti7Ey1HPlPDO0msxwQxT4ppqfN9SMIOvcXPSYyLPBoMw6F7o3/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744260355; c=relaxed/simple;
	bh=Aivw7EsXRxA9inZFP3SFHTkCN6KMulBbPpz5+2ZgC50=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=KCmf9xlBPFWxJKU+uIaPsibuH7O4lR0vLf61JjYSboebeviht4YsYNgcnUEclzq8DYhfEbm8xwHokpHiMjiW54eI3wsvg1x4VQ3vPo/bRNdDYPAslWcOjirBlq0wUQuvon4aV/IlOOt/Fc5t7anASrbmWetTxX0WaYdpQCsHoO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=asxX/32v; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="asxX/32v"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2254e0b4b85so4035675ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 09 Apr 2025 21:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744260352; x=1744865152; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xCHjrVgp9LQqMelwYL3MStJ4KvMiGkqr5mdBSE1Ktac=;
        b=asxX/32vijEObpwZQirF/vd3FxZixqLuOgt4E9qPx97D7eaE/j1kYa0py0V6Eexa9o
         oDq+i4EqQa4wWSqI8LJE5F+F3fiJrWp4o5dF6PhMEcx5gTJgz9Kp6WYPElPA6PJh6On/
         7CCT9OLCKi52zsG19Xk8S7QRMI1VZuWktZK1SISVbDTsSzC30wr95VMQcl1Woc5sFr+o
         ggFGCOQr26BNoZd4S8+mx3ybJgRXIF5O/NXohC5nH6Wzqz/dTeXFg38XIOmL25oe7Ra7
         Zg5FzVk4vk+dpmz7HyKU7Nkpd9ZsGTMnqaH9+IcWsKL1VaLX18FBeQsLmaqCNiRKa/om
         Hqzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744260352; x=1744865152;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xCHjrVgp9LQqMelwYL3MStJ4KvMiGkqr5mdBSE1Ktac=;
        b=QGrdPeK6Dyexajq/QvMDb+UroH7usXLHM6T71gxCvcoGgsUxJnrEiVSkR6NKMdpt1t
         CmVq1n/Iw/7GzECkGU5yQ2ta39VABVsZS3IbCT9mz8Ox/N+De3QpTOwZsnhLBMqpRPXd
         wReG3F8NYl0s0VNyUed0OgvVkF1Qo7RSp2ECJhrRjc1nLPoqPosWE0yb5FFyCVZEaK9X
         lrXJJkRf6xR4ZcXvOyVjAXNeHxvQ6zJ/hBF0T5dPZ2kYC4J+RS+E9ErUTdVs5tqWbPSC
         1/roiplmHxaUSkvZh91dxKeNtywOZHv1QTpGx39Hq88Zv/JItNCcXfVDDUibC2dUfqjH
         i6gg==
X-Forwarded-Encrypted: i=1; AJvYcCWcjuLsKDxf04jx7Ogv1L4omFlLC0aA5VfEs2keKM6nzmWA8MRA8ZSsRkJNlF3iPBAB5rUGiUA/ihwxUkYDH1kU@vger.kernel.org
X-Gm-Message-State: AOJu0YxuP+8zbIyk6ek3S/dSSW/r5uoU2oYdSRV61kSMYfKPuyWhgidS
	qaOWQ6AftJKYLJAEoaHd1muHA5aesQ2PorRU0CZpaqCKuoYWEBEOz38St4fn9LutYeAXEE74mkv
	OU3GjwQ==
X-Google-Smtp-Source: AGHT+IFoKovCjtIEa4S72PmsR+Xf2MJkMt515AdfNWXf3VBdBa9aa3t2puceXYwKbWSGqfWR1KmWelAXkZ9m
X-Received: from pjzz7.prod.google.com ([2002:a17:90b:58e7:b0:2ff:8471:8e53])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ccce:b0:221:1497:7b08
 with SMTP id d9443c01a7336-22b7f91d901mr22454325ad.23.1744260352161; Wed, 09
 Apr 2025 21:45:52 -0700 (PDT)
Date: Wed,  9 Apr 2025 21:45:32 -0700
In-Reply-To: <20250410044532.52017-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250410044532.52017-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250410044532.52017-4-irogers@google.com>
Subject: [PATCH v1 3/3] perf metricgroup: Binary search when resolving
 referred to metrics
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, John Garry <john.g.garry@oracle.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, Thomas Richter <tmricht@linux.ibm.com>, 
	Weilin Wang <weilin.wang@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Unlike with events, metrics can be matched by name or a list of metric
groups. However, when a metric refers to another metric it isn't
referring to a group but the singular metric in question. Prior to
this change every "id" in a metric expression is checked to see if it
is a metric by scanning all the metrics in the metrics table. As the
table is sorted my metric name we can speed the search in the
resolution case by binary searching for the metric.

Rename some of the metricgroup functions to make it clearer whether
they match a metric by name or by both name and group.

Before:
```
$ time perf test -v 10
 10: PMU JSON event tests                                            :
 10.1: PMU event table sanity                                        : Ok
 10.2: PMU event map aliases                                         : Ok
 10.3: Parsing of PMU event table metrics                            : Ok
 10.4: Parsing of PMU event table metrics with fake PMUs             : Ok
 10.5: Parsing of metric thresholds with fake PMUs                   : Ok

real    0m15.551s
user    0m15.092s
sys     0m3.009s
```

After:
```
$ time perf test -v 10
 10: PMU JSON event tests                                            :
 10.1: PMU event table sanity                                        : Ok
 10.2: PMU event map aliases                                         : Ok
 10.3: Parsing of PMU event table metrics                            : Ok
 10.4: Parsing of PMU event table metrics with fake PMUs             : Ok
 10.5: Parsing of metric thresholds with fake PMUs                   : Ok

real    0m2.338s
user    0m1.797s
sys     0m2.186s
```

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-stat.c                |   6 +-
 tools/perf/pmu-events/empty-pmu-events.c |  66 ++++++++++++++-
 tools/perf/pmu-events/jevents.py         |  66 ++++++++++++++-
 tools/perf/pmu-events/pmu-events.h       |  23 +++--
 tools/perf/util/metricgroup.c            | 102 +++++++++--------------
 tools/perf/util/metricgroup.h            |   2 +-
 6 files changed, 192 insertions(+), 73 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 68ea7589c143..67e6efaabe27 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1856,7 +1856,7 @@ static int add_default_events(void)
 		 * will use this approach. To determine transaction support
 		 * on an architecture test for such a metric name.
 		 */
-		if (!metricgroup__has_metric(pmu, "transaction")) {
+		if (!metricgroup__has_metric_or_groups(pmu, "transaction")) {
 			pr_err("Missing transaction metrics\n");
 			ret = -1;
 			goto out;
@@ -1890,7 +1890,7 @@ static int add_default_events(void)
 			smi_reset = true;
 		}
 
-		if (!metricgroup__has_metric(pmu, "smi")) {
+		if (!metricgroup__has_metric_or_groups(pmu, "smi")) {
 			pr_err("Missing smi metrics\n");
 			ret = -1;
 			goto out;
@@ -1980,7 +1980,7 @@ static int add_default_events(void)
 		 * Add TopdownL1 metrics if they exist. To minimize
 		 * multiplexing, don't request threshold computation.
 		 */
-		if (metricgroup__has_metric(pmu, "Default")) {
+		if (metricgroup__has_metric_or_groups(pmu, "Default")) {
 			struct evlist *metric_evlist = evlist__new();
 
 			if (!metric_evlist) {
diff --git a/tools/perf/pmu-events/empty-pmu-events.c b/tools/perf/pmu-events/empty-pmu-events.c
index 0cb7ba7912e8..5cdf7e68e331 100644
--- a/tools/perf/pmu-events/empty-pmu-events.c
+++ b/tools/perf/pmu-events/empty-pmu-events.c
@@ -443,7 +443,7 @@ int pmu_events_table__find_event(const struct pmu_events_table *table,
                 const char *pmu_name = &big_c_string[table_pmu->pmu_name.offset];
                 int ret;
 
-                if (!perf_pmu__name_wildcard_match(pmu, pmu_name))
+                if (pmu && !perf_pmu__name_wildcard_match(pmu, pmu_name))
                         continue;
 
                 ret = pmu_events_table__find_event_pmu(table, table_pmu, name, fn, data);
@@ -489,6 +489,49 @@ static int pmu_metrics_table__for_each_metric_pmu(const struct pmu_metrics_table
         return 0;
 }
 
+static int pmu_metrics_table__find_metric_pmu(const struct pmu_metrics_table *table,
+                                            const struct pmu_table_entry *pmu,
+                                            const char *metric,
+                                            pmu_metric_iter_fn fn,
+                                            void *data)
+{
+        struct pmu_metric pm = {
+                .pmu = &big_c_string[pmu->pmu_name.offset],
+        };
+        int low = 0, high = pmu->num_entries - 1;
+
+        while (low <= high) {
+                int cmp, mid = (low + high) / 2;
+
+                decompress_metric(pmu->entries[mid].offset, &pm);
+
+                if (!pm.metric_name && !metric)
+                        goto do_call;
+
+                if (!pm.metric_name && metric) {
+                        low = mid + 1;
+                        continue;
+                }
+                if (pm.metric_name && !metric) {
+                        high = mid - 1;
+                        continue;
+                }
+
+                cmp = strcmp(pm.metric_name, metric);
+                if (cmp < 0) {
+                        low = mid + 1;
+                        continue;
+                }
+                if (cmp > 0) {
+                        high = mid - 1;
+                        continue;
+                }
+  do_call:
+                return fn ? fn(&pm, table, data) : 0;
+        }
+        return PMU_METRICS__NOT_FOUND;
+}
+
 int pmu_metrics_table__for_each_metric(const struct pmu_metrics_table *table,
                                      pmu_metric_iter_fn fn,
                                      void *data)
@@ -503,6 +546,27 @@ int pmu_metrics_table__for_each_metric(const struct pmu_metrics_table *table,
         return 0;
 }
 
+int pmu_metrics_table__find_metric(const struct pmu_metrics_table *table,
+                                 struct perf_pmu *pmu,
+                                 const char *metric,
+                                 pmu_metric_iter_fn fn,
+                                 void *data)
+{
+        for (size_t i = 0; i < table->num_pmus; i++) {
+                const struct pmu_table_entry *table_pmu = &table->pmus[i];
+                const char *pmu_name = &big_c_string[table_pmu->pmu_name.offset];
+                int ret;
+
+                if (pmu && !perf_pmu__name_wildcard_match(pmu, pmu_name))
+                        continue;
+
+                ret = pmu_metrics_table__find_metric_pmu(table, table_pmu, metric, fn, data);
+                if (ret != PMU_METRICS__NOT_FOUND)
+                        return ret;
+        }
+        return PMU_METRICS__NOT_FOUND;
+}
+
 static const struct pmu_events_map *map_for_cpu(struct perf_cpu cpu)
 {
         static struct {
diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 7499a35bfadd..ec10d767fb49 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -966,7 +966,7 @@ int pmu_events_table__find_event(const struct pmu_events_table *table,
                 const char *pmu_name = &big_c_string[table_pmu->pmu_name.offset];
                 int ret;
 
-                if (!perf_pmu__name_wildcard_match(pmu, pmu_name))
+                if (pmu && !perf_pmu__name_wildcard_match(pmu, pmu_name))
                         continue;
 
                 ret = pmu_events_table__find_event_pmu(table, table_pmu, name, fn, data);
@@ -1012,6 +1012,49 @@ static int pmu_metrics_table__for_each_metric_pmu(const struct pmu_metrics_table
         return 0;
 }
 
+static int pmu_metrics_table__find_metric_pmu(const struct pmu_metrics_table *table,
+                                            const struct pmu_table_entry *pmu,
+                                            const char *metric,
+                                            pmu_metric_iter_fn fn,
+                                            void *data)
+{
+        struct pmu_metric pm = {
+                .pmu = &big_c_string[pmu->pmu_name.offset],
+        };
+        int low = 0, high = pmu->num_entries - 1;
+
+        while (low <= high) {
+                int cmp, mid = (low + high) / 2;
+
+                decompress_metric(pmu->entries[mid].offset, &pm);
+
+                if (!pm.metric_name && !metric)
+                        goto do_call;
+
+                if (!pm.metric_name && metric) {
+                        low = mid + 1;
+                        continue;
+                }
+                if (pm.metric_name && !metric) {
+                        high = mid - 1;
+                        continue;
+                }
+
+                cmp = strcmp(pm.metric_name, metric);
+                if (cmp < 0) {
+                        low = mid + 1;
+                        continue;
+                }
+                if (cmp > 0) {
+                        high = mid - 1;
+                        continue;
+                }
+  do_call:
+                return fn ? fn(&pm, table, data) : 0;
+        }
+        return PMU_METRICS__NOT_FOUND;
+}
+
 int pmu_metrics_table__for_each_metric(const struct pmu_metrics_table *table,
                                      pmu_metric_iter_fn fn,
                                      void *data)
@@ -1026,6 +1069,27 @@ int pmu_metrics_table__for_each_metric(const struct pmu_metrics_table *table,
         return 0;
 }
 
+int pmu_metrics_table__find_metric(const struct pmu_metrics_table *table,
+                                 struct perf_pmu *pmu,
+                                 const char *metric,
+                                 pmu_metric_iter_fn fn,
+                                 void *data)
+{
+        for (size_t i = 0; i < table->num_pmus; i++) {
+                const struct pmu_table_entry *table_pmu = &table->pmus[i];
+                const char *pmu_name = &big_c_string[table_pmu->pmu_name.offset];
+                int ret;
+
+                if (pmu && !perf_pmu__name_wildcard_match(pmu, pmu_name))
+                        continue;
+
+                ret = pmu_metrics_table__find_metric_pmu(table, table_pmu, metric, fn, data);
+                if (ret != PMU_METRICS__NOT_FOUND)
+                        return ret;
+        }
+        return PMU_METRICS__NOT_FOUND;
+}
+
 static const struct pmu_events_map *map_for_cpu(struct perf_cpu cpu)
 {
         static struct {
diff --git a/tools/perf/pmu-events/pmu-events.h b/tools/perf/pmu-events/pmu-events.h
index 675562e6f770..8048ca0b2fb3 100644
--- a/tools/perf/pmu-events/pmu-events.h
+++ b/tools/perf/pmu-events/pmu-events.h
@@ -71,6 +71,7 @@ struct pmu_events_table;
 struct pmu_metrics_table;
 
 #define PMU_EVENTS__NOT_FOUND -1000
+#define PMU_METRICS__NOT_FOUND -1000
 
 typedef int (*pmu_event_iter_fn)(const struct pmu_event *pe,
 				 const struct pmu_events_table *table,
@@ -85,11 +86,11 @@ int pmu_events_table__for_each_event(const struct pmu_events_table *table,
 				    pmu_event_iter_fn fn,
 				    void *data);
 /*
- * Search for table and entry matching with pmu__name_match. Each matching event
- * has fn called on it. 0 implies to success/continue the search while non-zero
- * means to terminate. The special value PMU_EVENTS__NOT_FOUND is used to
- * indicate no event was found in one of the tables which doesn't terminate the
- * search of all tables.
+ * Search for a table and entry matching with pmu__name_wildcard_match or any
+ * tables if pmu is NULL. Each matching event has fn called on it. 0 implies to
+ * success/continue the search while non-zero means to terminate. The special
+ * value PMU_EVENTS__NOT_FOUND is used to indicate no event was found in one of
+ * the tables which doesn't terminate the search of all tables.
  */
 int pmu_events_table__find_event(const struct pmu_events_table *table,
                                  struct perf_pmu *pmu,
@@ -101,6 +102,18 @@ size_t pmu_events_table__num_events(const struct pmu_events_table *table,
 
 int pmu_metrics_table__for_each_metric(const struct pmu_metrics_table *table, pmu_metric_iter_fn fn,
 				     void *data);
+/*
+ * Search for a table and entry matching with pmu__name_wildcard_match or any
+ * tables if pmu is NULL. Each matching metric has fn called on it. 0 implies to
+ * success/continue the search while non-zero means to terminate. The special
+ * value PMU_METRICS__NOT_FOUND is used to indicate no metric was found in one
+ * of the tables which doesn't terminate the search of all tables.
+ */
+int pmu_metrics_table__find_metric(const struct pmu_metrics_table *table,
+				   struct perf_pmu *pmu,
+				   const char *metric,
+				   pmu_metric_iter_fn fn,
+				   void *data);
 
 const struct pmu_events_table *perf_pmu__find_events_table(struct perf_pmu *pmu);
 const struct pmu_metrics_table *pmu_metrics_table__find(void);
diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 46920ebadfd1..126a631686b0 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -353,7 +353,7 @@ static int setup_metric_events(const char *pmu, struct hashmap *ids,
 	return 0;
 }
 
-static bool match_metric(const char *metric_or_groups, const char *sought)
+static bool match_metric_or_groups(const char *metric_or_groups, const char *sought)
 {
 	int len;
 	char *m;
@@ -369,18 +369,19 @@ static bool match_metric(const char *metric_or_groups, const char *sought)
 	    (metric_or_groups[len] == 0 || metric_or_groups[len] == ';'))
 		return true;
 	m = strchr(metric_or_groups, ';');
-	return m && match_metric(m + 1, sought);
+	return m && match_metric_or_groups(m + 1, sought);
 }
 
-static bool match_pm_metric(const struct pmu_metric *pm, const char *pmu, const char *metric)
+static bool match_pm_metric_or_groups(const struct pmu_metric *pm, const char *pmu,
+				      const char *metric_or_groups)
 {
 	const char *pm_pmu = pm->pmu ?: "cpu";
 
 	if (strcmp(pmu, "all") && strcmp(pm_pmu, pmu))
 		return false;
 
-	return match_metric(pm->metric_group, metric) ||
-	       match_metric(pm->metric_name, metric);
+	return match_metric_or_groups(pm->metric_group, metric_or_groups) ||
+	       match_metric_or_groups(pm->metric_name, metric_or_groups);
 }
 
 /** struct mep - RB-tree node for building printing information. */
@@ -802,11 +803,6 @@ struct metricgroup_add_iter_data {
 	const struct pmu_metrics_table *table;
 };
 
-static bool metricgroup__find_metric(const char *pmu,
-				     const char *metric,
-				     const struct pmu_metrics_table *table,
-				     struct pmu_metric *pm);
-
 static int add_metric(struct list_head *metric_list,
 		      const struct pmu_metric *pm,
 		      const char *modifier,
@@ -818,6 +814,16 @@ static int add_metric(struct list_head *metric_list,
 		      const struct visited_metric *visited,
 		      const struct pmu_metrics_table *table);
 
+static int metricgroup__find_metric_callback(const struct pmu_metric *pm,
+					     const struct pmu_metrics_table *table  __maybe_unused,
+					     void *vdata)
+{
+	struct pmu_metric *copied_pm = vdata;
+
+	memcpy(copied_pm, pm, sizeof(*pm));
+	return 0;
+}
+
 /**
  * resolve_metric - Locate metrics within the root metric and recursively add
  *                    references to them.
@@ -838,7 +844,7 @@ static int add_metric(struct list_head *metric_list,
  *       architecture perf is running upon.
  */
 static int resolve_metric(struct list_head *metric_list,
-			  const char *pmu,
+			  struct perf_pmu *pmu,
 			  const char *modifier,
 			  bool metric_no_group,
 			  bool metric_no_threshold,
@@ -868,7 +874,9 @@ static int resolve_metric(struct list_head *metric_list,
 	hashmap__for_each_entry(root_metric->pctx->ids, cur, bkt) {
 		struct pmu_metric pm;
 
-		if (metricgroup__find_metric(pmu, cur->pkey, table, &pm)) {
+		if (pmu_metrics_table__find_metric(table, pmu, cur->pkey,
+						   metricgroup__find_metric_callback,
+						   &pm) != PMU_METRICS__NOT_FOUND) {
 			pending = realloc(pending,
 					(pending_cnt + 1) * sizeof(struct to_resolve));
 			if (!pending)
@@ -1019,7 +1027,12 @@ static int __add_metric(struct list_head *metric_list,
 	}
 	if (!ret) {
 		/* Resolve referenced metrics. */
-		const char *pmu = pm->pmu ?: "cpu";
+		struct perf_pmu *pmu;
+
+		if (pm->pmu && pm->pmu[0] != '\0')
+			pmu = perf_pmus__find(pm->pmu);
+		else
+			pmu = perf_pmus__scan_core(/*pmu=*/ NULL);
 
 		ret = resolve_metric(metric_list, pmu, modifier, metric_no_group,
 				     metric_no_threshold, user_requested_cpu_list,
@@ -1036,44 +1049,6 @@ static int __add_metric(struct list_head *metric_list,
 	return ret;
 }
 
-struct metricgroup__find_metric_data {
-	const char *pmu;
-	const char *metric;
-	struct pmu_metric *pm;
-};
-
-static int metricgroup__find_metric_callback(const struct pmu_metric *pm,
-					     const struct pmu_metrics_table *table  __maybe_unused,
-					     void *vdata)
-{
-	struct metricgroup__find_metric_data *data = vdata;
-	const char *pm_pmu = pm->pmu ?: "cpu";
-
-	if (strcmp(data->pmu, "all") && strcmp(pm_pmu, data->pmu))
-		return 0;
-
-	if (!match_metric(pm->metric_name, data->metric))
-		return 0;
-
-	memcpy(data->pm, pm, sizeof(*pm));
-	return 1;
-}
-
-static bool metricgroup__find_metric(const char *pmu,
-				     const char *metric,
-				     const struct pmu_metrics_table *table,
-				     struct pmu_metric *pm)
-{
-	struct metricgroup__find_metric_data data = {
-		.pmu = pmu,
-		.metric = metric,
-		.pm = pm,
-	};
-
-	return pmu_metrics_table__for_each_metric(table, metricgroup__find_metric_callback, &data)
-		? true : false;
-}
-
 static int add_metric(struct list_head *metric_list,
 		      const struct pmu_metric *pm,
 		      const char *modifier,
@@ -1119,7 +1094,7 @@ static int metricgroup__add_metric_sys_event_iter(const struct pmu_metric *pm,
 	struct metricgroup_add_iter_data *d = data;
 	int ret;
 
-	if (!match_pm_metric(pm, d->pmu, d->metric_name))
+	if (!match_pm_metric_or_groups(pm, d->pmu, d->metric_name))
 		return 0;
 
 	ret = add_metric(d->metric_list, pm, d->modifier, d->metric_no_group,
@@ -1200,9 +1175,9 @@ static int metricgroup__add_metric_callback(const struct pmu_metric *pm,
 	struct metricgroup__add_metric_data *data = vdata;
 	int ret = 0;
 
-	if (pm->metric_expr && match_pm_metric(pm, data->pmu, data->metric_name)) {
+	if (pm->metric_expr && match_pm_metric_or_groups(pm, data->pmu, data->metric_name)) {
 		bool metric_no_group = data->metric_no_group ||
-			match_metric(pm->metricgroup_no_group, data->metric_name);
+			match_metric_or_groups(pm->metricgroup_no_group, data->metric_name);
 
 		data->has_match = true;
 		ret = add_metric(data->list, pm, data->modifier, metric_no_group,
@@ -1723,29 +1698,32 @@ int metricgroup__parse_groups_test(struct evlist *evlist,
 
 struct metricgroup__has_metric_data {
 	const char *pmu;
-	const char *metric;
+	const char *metric_or_groups;
 };
-static int metricgroup__has_metric_callback(const struct pmu_metric *pm,
-					    const struct pmu_metrics_table *table __maybe_unused,
-					    void *vdata)
+static int metricgroup__has_metric_or_groups_callback(const struct pmu_metric *pm,
+						      const struct pmu_metrics_table *table
+							__maybe_unused,
+						      void *vdata)
 {
 	struct metricgroup__has_metric_data *data = vdata;
 
-	return match_pm_metric(pm, data->pmu, data->metric) ? 1 : 0;
+	return match_pm_metric_or_groups(pm, data->pmu, data->metric_or_groups) ? 1 : 0;
 }
 
-bool metricgroup__has_metric(const char *pmu, const char *metric)
+bool metricgroup__has_metric_or_groups(const char *pmu, const char *metric_or_groups)
 {
 	const struct pmu_metrics_table *table = pmu_metrics_table__find();
 	struct metricgroup__has_metric_data data = {
 		.pmu = pmu,
-		.metric = metric,
+		.metric_or_groups = metric_or_groups,
 	};
 
 	if (!table)
 		return false;
 
-	return pmu_metrics_table__for_each_metric(table, metricgroup__has_metric_callback, &data)
+	return pmu_metrics_table__for_each_metric(table,
+						  metricgroup__has_metric_or_groups_callback,
+						  &data)
 		? true : false;
 }
 
diff --git a/tools/perf/util/metricgroup.h b/tools/perf/util/metricgroup.h
index 779f6ede1b51..a04ac1afa6cc 100644
--- a/tools/perf/util/metricgroup.h
+++ b/tools/perf/util/metricgroup.h
@@ -85,7 +85,7 @@ int metricgroup__parse_groups_test(struct evlist *evlist,
 				   struct rblist *metric_events);
 
 void metricgroup__print(const struct print_callbacks *print_cb, void *print_state);
-bool metricgroup__has_metric(const char *pmu, const char *metric);
+bool metricgroup__has_metric_or_groups(const char *pmu, const char *metric_or_groups);
 unsigned int metricgroups__topdown_max_level(void);
 int arch_get_runtimeparam(const struct pmu_metric *pm);
 void metricgroup__rblist_exit(struct rblist *metric_events);
-- 
2.49.0.504.g3bcea36a83-goog

