Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794604290;
	b=Tehs4BxlwLT+q3AcnGAOSoVdmXFdAChu8fQ1LLt56FuADHGtLQ8SS2sfS3V6nz1EQsBl
	 ftcB/hvW3mivhI7phDCZ988rkL7HRWGmFwG2Hm4cDa2RX3O9rLqQKbj7mINrFGrk7CaO6
	 tMNtONonsKVdQu1wwMZsjaFYPR5SHlugo7bR/UXPWFmdUGZTaqNGRsbzEpeNLZI+sIg4S
	 lFFESWuI6U+zkFTtO26IGztOMyqogh24fIAkyQn9vmRw783ksgZfgg56n1qfwDJk2Vm6V
	 5sjXWoCY21E5bhWMqrjXfbbjA2+a123o9e9v6APGOG/4FK15QHPYOEF0fS6F3fhiKkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794604290;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=nFXskHL4vdfxtjhTdFrVwlbtgqR0HMOwmfY48TjS8ko=;
	b=jPXsKhTfGUT/q4TdYRltwCM4LdVtngoOHdOh9iz/DQg4DigOlxbLTP/oYiGE3Wb+6ZkD
	 3wEZ4jw1gwf5luN8MEeHO3uMx3KzXZT5zehv7cWBDKX1qZXKyWQtpVYOBGXLmMNHKA5kf
	 +H8KhQhA8KvI85uLEyilzSgvgHCCYpCOgisp5umkrJgPBTd3XT+V8yzzep8sISGKqT+XU
	 GTCgbeftf9cDQhtHFmYxrRAcgHi2cbtspOSG0QXhsKeyzmF9e3y4OYIdjCiLakqUTSwaL
	 VET+ImuPBrIEPIRl2sROxbC9c5InFG5HBkQL+4ZElTr53G3kerzXEHmcT/ZMpaFB7Jg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=gA5O5PV+;
	arc=none smtp.remote-ip=74.125.82.200
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B9F60A2629
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 21:11:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59B9F60A2629
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=gA5O5PV+
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-33713e5e6daso1306444eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 13:11:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794604288; x=1795209088; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nFXskHL4vdfxtjhTdFrVwlbtgqR0HMOwmfY48TjS8ko=;
        b=gA5O5PV+/H9k2CYAA51fBWSTKyhZEGv1bPEEI9tzJHIzzbXII1fjCO4bEE4zEj0THw
         5mF1WbCXOypVq6UBY2APIHZhlJgIlSrHLzNaaE8umqi1Z2flrjbKlIcdoLiaJmK80tdr
         o3tNUu5+onkgFQ3OzWAXR5AIX6pInkZBjiXvUpSFVNQv/rznbAIv4e2Ed/9XkW7LkstO
         MDCUSiqqkjQveMOXyLMS5tEJpyLgtBhDszobuDU9Fgintnakdf8foQghZRjJMNiVfw0M
         +JsHwpYVObwE0wPtBIadSIktxZX9euN9h9JgQF/aSWlQxVo7wZ9skpr+lmDxZIpMz/E6
         Qk6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794604288; x=1795209088;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nFXskHL4vdfxtjhTdFrVwlbtgqR0HMOwmfY48TjS8ko=;
        b=gFdhydt7ADEqxWoT78VLe/nmX96WtLq37g582KBKlIjh9pHvH7/X2SmUpk+DQn7QUi
         DBLhSjCQ8UbSDXEZeg8DjUpdrFymooCQOnSVHjlyMToxIpgepn9f7hMfUWC/dAA5Sai8
         BkSil29IxB4VcQ2Uivw8/Y/ppZlWzU1+mii39az2rE/QeF4GfseRFGEZq1B6XaQ8qlo4
         +cF3bQkRZojOr+0yJgIYT3jyKujhBAMuoAsFM+I7sKYRlfoCAQgofodzkqbfD+TKkyX8
         HBWQcbLyEpubgkASYSQcJse/RZdTU7eTQnK8VI51IigcUYntxfTBrs/PgLTZ19lSw65Z
         q18w==
X-Forwarded-Encrypted: i=1; AL+hErFgiog4NVP9ZPAV0HdBYCIhMuabouqmV1LZu/k79VniHFTwlQxs1XlWp3vWQTd7wZnn8csJKv9zoNsEdEI8T2ES@vger.kernel.org
X-Gm-Message-State: APuU4Z9h0MkhRqgRjqBcz9skAM3JK8fbZa6Kv2SJwxE0maSr+DKp3CwG
	319CGhWhCnufkxPM7bv4l1Mli6jVUyIAVK97IgzPzTCsRHAcSXnTBT9iS1YWcUZRTabGIPwvmGN
	//SvMWyjteA==
X-Received: from dycmz14.prod.google.com ([2002:a05:7300:ea0e:b0:36d:554e:92dc])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:2149:b0:36a:1bac:6bf4
 with SMTP id 5a478bee46e88-37967316a68mr4344826eec.18.1794604287952; Fri, 13
 Nov 2026 13:11:27 -0800 (PST)
Date: Fri, 13 Nov 2026 13:10:58 -0800
In-Reply-To: <20261113211105.3118281-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261113211105.3118281-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261113211105.3118281-8-irogers@google.com>
Subject: [PATCH 07/11] perf metricgroup: Route metric and metricgroup lookups
 through struct perf_pmu
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Expose metric and metricgroup lookup and enumeration helpers on struct
perf_pmu and perf_pmus (perf_pmu__find_metric(),
perf_pmu__for_each_metric(), perf_pmu__describe_metricgroup(),
perf_pmus__find_metric(), perf_pmus__find_metric_pmu(),
perf_pmus__for_each_metric(), perf_pmus__for_each_pmu_metric(), and
perf_pmus__describe_metricgroup()) backed by the layered PMU VFS stack,
using struct pmu_metric at the public boundary so struct perf_pmu_metric
remains private.

Scan all core and uncore PMUs without suffix collapsing so heterogeneous
PMUs are preserved, deduplicating identical shared metrics across PMU
instances while resolving sub-metrics and thresholds on their
originating struct perf_pmu and letting user metricgroup overrides on
any PMU take precedence over compiled-in defaults.

Update live callers in metricgroup.c, print-events.c, builtin-list.c,
builtin-script.c, and util/python.c to query metrics and metricgroup
descriptions through struct perf_pmu rather than reading compiled-in
pmu_metrics_table arrays directly, while retaining explicit table
overrides for fake_pmu unit tests.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-list.c      |   2 +-
 tools/perf/builtin-script.c    |   2 +-
 tools/perf/util/metricgroup.c  | 369 +++++++++++++++++++++++++++------
 tools/perf/util/pmu.c          |  65 +++++-
 tools/perf/util/pmu.h          |   7 +
 tools/perf/util/pmus.c         | 237 ++++++++++++++++++++-
 tools/perf/util/pmus.h         |  13 ++
 tools/perf/util/print-events.c |   4 +-
 tools/perf/util/python.c       |   5 +-
 9 files changed, 628 insertions(+), 76 deletions(-)

diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
index 47668d66c395..53e1834233c8 100644
--- a/tools/perf/builtin-list.c
+++ b/tools/perf/builtin-list.c
@@ -232,7 +232,7 @@ static void default_print_metric(void *ps,
 				fprintf(fp, "%s ", group);
 			} else {
 				const char *gdesc = print_state->desc
-					? describe_metricgroup(group)
+					? perf_pmus__describe_metricgroup(group)
 					: NULL;
 				const char *print_colon = "";
 
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index b6691ebb1b4e..f4c61172eb84 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -2546,7 +2546,7 @@ static void perf_sample__fprint_metric(struct thread *thread,
 						  /*needs_sort=*/false);
 		}
 
-		metricgroup__for_each_metric(pmu_metrics_table__find(), script_find_metrics, &args);
+		metricgroup__for_each_metric(/*table=*/NULL, script_find_metrics, &args);
 		init_metrics = true;
 	}
 
diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 779fe56fe8d0..ebe9873d273f 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -128,6 +128,7 @@ struct metric {
 	 */
 	struct expr_parse_ctx *pctx;
 	const char *pmu;
+	struct perf_pmu *source_pmu;
 	/** The name of the metric such as "IPC". */
 	const char *metric_name;
 	/** Modifier on the metric such as "u" or NULL for none. */
@@ -219,6 +220,7 @@ static void metric__free(struct metric *m)
 }
 
 static struct metric *metric__new(const struct pmu_metric *pm,
+				  struct perf_pmu *source_pmu,
 				  const char *modifier,
 				  bool metric_no_group,
 				  bool metric_no_threshold,
@@ -237,7 +239,9 @@ static struct metric *metric__new(const struct pmu_metric *pm,
 	if (!m->pctx)
 		goto out_err;
 
-	m->pmu = pm->pmu ?: "cpu";
+	m->pmu = (source_pmu && source_pmu->is_core && (!pm->pmu || !pm->pmu[0]))
+		? "default_core" : (pm->pmu ?: "cpu");
+	m->source_pmu = source_pmu;
 	m->metric_name = pm->metric_name;
 	m->default_metricgroup_name = pm->default_metricgroup_name ?: "";
 	m->modifier = NULL;
@@ -281,6 +285,16 @@ static bool contains_metric_id(struct evsel **metric_events, int num_events,
 	return false;
 }
 
+static bool is_core_pmu_name(const char *pmu)
+{
+	struct perf_pmu *perf_pmu;
+
+	if (is_pmu_core(pmu))
+		return true;
+	perf_pmu = perf_pmus__find(pmu);
+	return perf_pmu && perf_pmu->is_core;
+}
+
 /**
  * setup_metric_events - Find a group of events in metric_evlist that correspond
  *                       to the IDs from a parsed metric expression.
@@ -298,7 +312,7 @@ static int setup_metric_events(const char *pmu, struct hashmap *ids,
 	struct evsel *ev;
 	size_t ids_size, matched_events, i;
 	bool all_pmus = !strcmp(pmu, "all") || !strcmp(pmu, "default_core") ||
-			perf_pmus__num_core_pmus() == 1 || !is_pmu_core(pmu);
+			perf_pmus__num_core_pmus() == 1 || !is_core_pmu_name(pmu);
 
 	*out_metric_events = NULL;
 	ids_size = hashmap__size(ids);
@@ -359,6 +373,10 @@ static int setup_metric_events(const char *pmu, struct hashmap *ids,
 		 */
 		metric_id = evsel__metric_id(ev);
 		evlist__for_each_entry_continue(metric_evlist, ev) {
+			/* Don't match events for the wrong hybrid PMU. */
+			if (!all_pmus && ev->pmu && evsel__is_hybrid(ev) &&
+			    strcmp(ev->pmu->name, pmu))
+				continue;
 			if (!strcmp(evsel__metric_id(ev), metric_id))
 				ev->metric_leader = metric_events[i];
 		}
@@ -386,18 +404,32 @@ static bool match_metric_or_groups(const char *metric_or_groups, const char *sou
 	return m && match_metric_or_groups(m + 1, sought);
 }
 
-static bool match_pm_metric_or_groups(const struct pmu_metric *pm, const char *pmu,
+static bool match_pm_metric_or_groups(const struct pmu_metric *pm,
+				      struct perf_pmu *source_pmu,
+				      const char *pmu,
 				      const char *metric_or_groups)
 {
 	const char *pm_pmu = pm->pmu ?: "cpu";
 	struct perf_pmu *perf_pmu = NULL;
 
-	if (pm->pmu)
-		perf_pmu = perf_pmus__find(pm->pmu);
-
-	if (strcmp(pmu, "all") && strcmp(pm_pmu, pmu) &&
-	   (perf_pmu && !perf_pmu__name_wildcard_match(perf_pmu, pmu)))
-		return false;
+	if (strcmp(pmu, "all")) {
+		if (source_pmu) {
+			if (!perf_pmu__name_wildcard_match(source_pmu, pmu) &&
+			    !perf_pmu__wildcard_match(source_pmu, pmu))
+				return false;
+		} else if (!strcmp(pm_pmu, "default_core") && is_core_pmu_name(pmu)) {
+			/* default_core matches any core PMU filter. */
+		} else {
+			if (pm->pmu)
+				perf_pmu = perf_pmus__find(pm->pmu);
+
+			if (strcmp(pm_pmu, pmu) &&
+			    (!perf_pmu ||
+			     (!perf_pmu__name_wildcard_match(perf_pmu, pmu) &&
+			      !perf_pmu__wildcard_match(perf_pmu, pmu))))
+				return false;
+		}
+	}
 
 	return match_metric_or_groups(pm->metric_group, metric_or_groups) ||
 	       match_metric_or_groups(pm->metric_name, metric_or_groups);
@@ -435,6 +467,9 @@ int metricgroup__for_each_metric(const struct pmu_metrics_table *table, pmu_metr
 		pmu_metrics_table__default(),
 	};
 
+	if (!table)
+		return perf_pmus__for_each_metric(fn, data);
+
 	for (size_t i = 0; i < ARRAY_SIZE(tables); i++) {
 		int ret;
 
@@ -696,6 +731,7 @@ struct metricgroup_add_iter_data {
 
 static int add_metric(struct list_head *metric_list,
 		      const struct pmu_metric *pm,
+		      struct perf_pmu *source_pmu,
 		      const char *modifier,
 		      bool metric_no_group,
 		      bool metric_no_threshold,
@@ -720,11 +756,13 @@ static int metricgroup__find_metric_callback(const struct pmu_metric *pm,
  * resolve_metric - Locate metrics within the root metric and recursively add
  *                    references to them.
  * @metric_list: The list the metric is added to.
- * @pmu: The PMU name to resolve metrics on, or "all" for all PMUs.
+ * @pm_pmu: The PMU name pattern to resolve metrics on when @pmu is NULL.
+ * @pmu: Originating PMU struct when known, or target PMU for @fake_pmu.
  * @modifier: if non-null event modifiers like "u".
  * @metric_no_group: Should events written to events be grouped "{}" or
  *                   global. Grouping is the default but due to multiplexing the
  *                   user may override.
+ * @metric_no_threshold: Should threshold expressions be ignored?
  * @user_requested_cpu_list: Command line specified CPUs to record on.
  * @system_wide: Are events for all processes recorded.
  * @fake_pmu: Are PMUs and events being faked for testing?
@@ -737,6 +775,7 @@ static int metricgroup__find_metric_callback(const struct pmu_metric *pm,
  *       architecture perf is running upon.
  */
 static int resolve_metric(struct list_head *metric_list,
+			  const char *pm_pmu,
 			  struct perf_pmu *pmu,
 			  const char *modifier,
 			  bool metric_no_group,
@@ -767,10 +806,18 @@ static int resolve_metric(struct list_head *metric_list,
 	 */
 	hashmap__for_each_entry(root_metric->pctx->ids, cur, bkt) {
 		struct pmu_metric pm;
+		bool found;
 
-		if (pmu_metrics_table__find_metric(table, pmu, cur->pkey,
-						   metricgroup__find_metric_callback,
-						   &pm) != PMU_METRICS__NOT_FOUND) {
+		if (fake_pmu && table) {
+			found = pmu_metrics_table__find_metric(table, pmu, cur->pkey,
+							       metricgroup__find_metric_callback,
+							       &pm) != PMU_METRICS__NOT_FOUND;
+		} else {
+			found = pmu ? perf_pmu__find_metric(pmu, cur->pkey, &pm)
+				    : perf_pmus__find_metric_pmu(pm_pmu, cur->pkey, &pm);
+		}
+
+		if (found) {
 			pending = realloc(pending,
 					(pending_cnt + 1) * sizeof(struct to_resolve));
 			if (!pending)
@@ -791,8 +838,9 @@ static int resolve_metric(struct list_head *metric_list,
 	 * context.
 	 */
 	for (i = 0; i < pending_cnt; i++) {
-		ret = add_metric(metric_list, &pending[i].pm, modifier, metric_no_group,
-				 metric_no_threshold, user_requested_cpu_list, system_wide,
+		ret = add_metric(metric_list, &pending[i].pm, pmu, modifier,
+				 metric_no_group, metric_no_threshold,
+				 user_requested_cpu_list, system_wide,
 				 fake_pmu, root_metric, visited, table);
 		if (ret)
 			break;
@@ -806,6 +854,7 @@ static int resolve_metric(struct list_head *metric_list,
  * __add_metric - Add a metric to metric_list.
  * @metric_list: The list the metric is added to.
  * @pm: The pmu_metric containing the metric to be added.
+ * @source_pmu: Originating PMU struct when known, or NULL.
  * @modifier: if non-null event modifiers like "u".
  * @metric_no_group: Should events written to events be grouped "{}" or
  *                   global. Grouping is the default but due to multiplexing the
@@ -825,6 +874,7 @@ static int resolve_metric(struct list_head *metric_list,
  */
 static int __add_metric(struct list_head *metric_list,
 			const struct pmu_metric *pm,
+			struct perf_pmu *source_pmu,
 			const char *modifier,
 			bool metric_no_group,
 			bool metric_no_threshold,
@@ -857,8 +907,10 @@ static int __add_metric(struct list_head *metric_list,
 		 * This metric is the root of a tree and may reference other
 		 * metrics that are added recursively.
 		 */
-		root_metric = metric__new(pm, modifier, metric_no_group, metric_no_threshold,
-					  runtime, user_requested_cpu_list, system_wide, fake_pmu);
+		root_metric = metric__new(pm, source_pmu, modifier,
+					  metric_no_group, metric_no_threshold,
+					  runtime, user_requested_cpu_list,
+					  system_wide, fake_pmu);
 		if (!root_metric)
 			return -ENOMEM;
 
@@ -922,14 +974,17 @@ static int __add_metric(struct list_head *metric_list,
 
 	if (!ret) {
 		/* Resolve referenced metrics. */
-		struct perf_pmu *pmu;
+		const char *pm_pmu = (pm->pmu && pm->pmu[0]) ? pm->pmu : "default_core";
+		struct perf_pmu *pmu = source_pmu;
 
-		if (pm->pmu && pm->pmu[0] != '\0')
-			pmu = perf_pmus__find(pm->pmu);
-		else
-			pmu = perf_pmus__scan_core(/*pmu=*/ NULL);
+		if (!pmu && fake_pmu && table) {
+			if (pm->pmu && pm->pmu[0] != '\0')
+				pmu = perf_pmus__find(pm->pmu);
+			else
+				pmu = perf_pmus__scan_core(/*pmu=*/NULL);
+		}
 
-		ret = resolve_metric(metric_list, pmu, modifier, metric_no_group,
+		ret = resolve_metric(metric_list, pm_pmu, pmu, modifier, metric_no_group,
 				     metric_no_threshold, user_requested_cpu_list,
 				     system_wide, fake_pmu, root_metric, &visited_node,
 				     table);
@@ -946,6 +1001,7 @@ static int __add_metric(struct list_head *metric_list,
 
 static int add_metric(struct list_head *metric_list,
 		      const struct pmu_metric *pm,
+		      struct perf_pmu *source_pmu,
 		      const char *modifier,
 		      bool metric_no_group,
 		      bool metric_no_threshold,
@@ -961,9 +1017,10 @@ static int add_metric(struct list_head *metric_list,
 	pr_debug("metric expr %s for %s\n", pm->metric_expr, pm->metric_name);
 
 	if (!strstr(pm->metric_expr, "?")) {
-		ret = __add_metric(metric_list, pm, modifier, metric_no_group,
-				   metric_no_threshold, 0, user_requested_cpu_list,
-				   system_wide, fake_pmu, root_metric, visited, table);
+		ret = __add_metric(metric_list, pm, source_pmu, modifier,
+				   metric_no_group, metric_no_threshold, 0,
+				   user_requested_cpu_list, system_wide,
+				   fake_pmu, root_metric, visited, table);
 	} else {
 		int j, count;
 
@@ -975,9 +1032,10 @@ static int add_metric(struct list_head *metric_list,
 		 */
 
 		for (j = 0; j < count && !ret; j++)
-			ret = __add_metric(metric_list, pm, modifier, metric_no_group,
-					   metric_no_threshold, j, user_requested_cpu_list,
-					   system_wide, fake_pmu, root_metric, visited, table);
+			ret = __add_metric(metric_list, pm, source_pmu, modifier,
+					   metric_no_group, metric_no_threshold, j,
+					   user_requested_cpu_list, system_wide,
+					   fake_pmu, root_metric, visited, table);
 	}
 
 	return ret;
@@ -1042,26 +1100,141 @@ struct metricgroup__add_metric_data {
 	bool has_match;
 };
 
-static int metricgroup__add_metric_callback(const struct pmu_metric *pm,
-					    const struct pmu_metrics_table *table,
-					    void *vdata)
+static size_t metric_refs_count(const struct metric_ref *refs)
+{
+	size_t n = 0;
+
+	if (!refs)
+		return 0;
+	while (refs[n].metric_name)
+		n++;
+	return n;
+}
+
+static bool metric__same_definition(const struct metric *a, const struct metric *b)
+{
+	size_t na, nb;
+
+	if (strcmp(a->metric_name ?: "", b->metric_name ?: "") ||
+	    strcmp(a->modifier ?: "", b->modifier ?: "") ||
+	    strcmp(a->metric_expr ?: "", b->metric_expr ?: "") ||
+	    strcmp(a->metric_threshold ?: "", b->metric_threshold ?: "") ||
+	    a->pctx->sctx.runtime != b->pctx->sctx.runtime)
+		return false;
+
+	na = metric_refs_count(a->metric_refs);
+	nb = metric_refs_count(b->metric_refs);
+	if (na != nb)
+		return false;
+
+	for (size_t i = 0; i < na; i++) {
+		bool found = false;
+
+		for (size_t j = 0; j < nb; j++) {
+			if (!strcmp(a->metric_refs[i].metric_name,
+				    b->metric_refs[j].metric_name) &&
+			    !strcmp(a->metric_refs[i].metric_expr ?: "",
+				    b->metric_refs[j].metric_expr ?: "")) {
+				found = true;
+				break;
+			}
+		}
+		if (!found)
+			return false;
+	}
+	return true;
+}
+
+static void metricgroup__dedup_and_pin_metrics(struct list_head *list)
+{
+	struct metric *m, *other, *tmp;
+	int total_core_pmus = perf_pmus__num_core_pmus();
+
+	if (total_core_pmus > 1) {
+		list_for_each_entry(m, list, nd) {
+			size_t core_matches = 0;
+			bool uniform = true;
+
+			if (!m->source_pmu || !m->source_pmu->is_core ||
+			    strcmp(m->pmu, "default_core") != 0)
+				continue;
+
+			list_for_each_entry(other, list, nd) {
+				if (!other->source_pmu || !other->source_pmu->is_core ||
+				    strcmp(other->pmu, "default_core") != 0)
+					continue;
+				if (strcmp(m->metric_name ?: "", other->metric_name ?: "") ||
+				    strcmp(m->modifier ?: "", other->modifier ?: "") ||
+				    m->pctx->sctx.runtime != other->pctx->sctx.runtime)
+					continue;
+				core_matches++;
+				if (!metric__same_definition(m, other))
+					uniform = false;
+			}
+			if (!uniform || core_matches < (size_t)total_core_pmus) {
+				list_for_each_entry(other, list, nd) {
+					if (!other->source_pmu ||
+					    !other->source_pmu->is_core ||
+					    strcmp(other->pmu, "default_core") != 0)
+						continue;
+					if (strcmp(m->metric_name ?: "",
+						   other->metric_name ?: "") ||
+					    strcmp(m->modifier ?: "",
+						   other->modifier ?: "") ||
+					    m->pctx->sctx.runtime !=
+						    other->pctx->sctx.runtime)
+						continue;
+					other->pmu = other->source_pmu->name;
+				}
+			}
+		}
+	}
+
+	list_for_each_entry_safe(m, tmp, list, nd) {
+		list_for_each_entry(other, list, nd) {
+			if (other == m)
+				break;
+			if (!strcmp(other->pmu ?: "", m->pmu ?: "") &&
+			    metric__same_definition(other, m)) {
+				list_del_init(&m->nd);
+				metric__free(m);
+				break;
+			}
+		}
+	}
+}
+
+static int metricgroup__add_pmu_metric_callback(struct perf_pmu *pmu,
+						const struct pmu_metric *pm,
+						const struct pmu_metrics_table *table,
+						void *vdata)
 {
 	struct metricgroup__add_metric_data *data = vdata;
 	int ret = 0;
 
-	if (pm->metric_expr && match_pm_metric_or_groups(pm, data->pmu, data->metric_name)) {
+	if (pm->metric_expr &&
+	    match_pm_metric_or_groups(pm, pmu, data->pmu, data->metric_name)) {
 		bool metric_no_group = data->metric_no_group ||
 			match_metric_or_groups(pm->metricgroup_no_group, data->metric_name);
 
 		data->has_match = true;
-		ret = add_metric(data->list, pm, data->modifier, metric_no_group,
-				 data->metric_no_threshold, data->user_requested_cpu_list,
-				data->system_wide, data->fake_pmu, /*root_metric=*/NULL,
+		ret = add_metric(data->list, pm, pmu, data->modifier,
+				 metric_no_group, data->metric_no_threshold,
+				 data->user_requested_cpu_list,
+				 data->system_wide, data->fake_pmu,
+				 /*root_metric=*/NULL,
 				 /*visited_metrics=*/NULL, table);
 	}
 	return ret;
 }
 
+static int metricgroup__add_metric_callback(const struct pmu_metric *pm,
+					    const struct pmu_metrics_table *table,
+					    void *vdata)
+{
+	return metricgroup__add_pmu_metric_callback(/*pmu=*/NULL, pm, table, vdata);
+}
+
 /**
  * metricgroup__add_metric - Find and add a metric, or a metric group.
  * @pmu: The PMU name to search for metrics on, or "all" for all PMUs.
@@ -1105,7 +1278,16 @@ static int metricgroup__add_metric(const char *pmu, const char *metric_name, con
 	 * Iterate over all metrics seeing if metric matches either the
 	 * name or group. When it does add the metric to the list.
 	 */
-	ret = metricgroup__for_each_metric(table, metricgroup__add_metric_callback, &data);
+	if (!table) {
+		ret = perf_pmus__for_each_pmu_metric(metricgroup__add_pmu_metric_callback,
+						     &data);
+		if (!ret)
+			metricgroup__dedup_and_pin_metrics(&list);
+	} else {
+		ret = metricgroup__for_each_metric(table,
+						   metricgroup__add_metric_callback,
+						   &data);
+	}
 	if (!ret && !data.has_match)
 		ret = -ENOENT;
 
@@ -1219,14 +1401,68 @@ static void find_tool_events(const struct list_head *metric_list,
 	}
 }
 
+static bool metric__has_unqualified_id(const struct metric *m)
+{
+	struct hashmap_entry *cur;
+	size_t bkt;
+
+	hashmap__for_each_entry(m->pctx->ids, cur, bkt) {
+		const char *id = cur->pkey;
+
+		if (tool_pmu__str_to_event(id) == TOOL_PMU__EVENT_NONE &&
+		    !strchr(id, '@'))
+			return true;
+	}
+	return false;
+}
+
+static bool pmu_filter_allows_other_core_pmu(const char *pmu_filter,
+					     const char *target_pmu)
+{
+	struct perf_pmu *core_pmu = NULL;
+
+	while ((core_pmu = perf_pmus__scan_core(core_pmu)) != NULL) {
+		if (perf_pmu__name_wildcard_match(core_pmu, target_pmu))
+			continue;
+		if (!pmu_filter || !strcmp(pmu_filter, "all") ||
+		    perf_pmu__wildcard_match(core_pmu, pmu_filter) ||
+		    perf_pmu__name_wildcard_match(core_pmu, pmu_filter))
+			return true;
+	}
+	return false;
+}
+
+static bool metric__needs_per_pmu_evlist(const struct metric *m,
+					 const char *pmu,
+					 bool fake_pmu)
+{
+	if (fake_pmu || !m->pmu || !strcmp(m->pmu, "all") ||
+	    !strcmp(m->pmu, "default_core") || !is_core_pmu_name(m->pmu))
+		return false;
+
+	return pmu_filter_allows_other_core_pmu(pmu, m->pmu) &&
+	       metric__has_unqualified_id(m);
+}
+
+static bool metric__can_use_combined_evlist(const struct metric *m,
+					    const char *pmu,
+					    bool fake_pmu)
+{
+	return !m->group_events && !m->modifier &&
+	       !metric__needs_per_pmu_evlist(m, pmu, fake_pmu);
+}
+
 /**
  * build_combined_expr_ctx - Make an expr_parse_ctx with all !group_events
  *                           metric IDs, as the IDs are held in a set,
  *                           duplicates will be removed.
  * @metric_list: List to take metrics from.
+ * @pmu: Top-level PMU filter, or "all".
+ * @fake_pmu: Are PMUs and events being faked for testing?
  * @combined: Out argument for result.
  */
 static int build_combined_expr_ctx(const struct list_head *metric_list,
+				   const char *pmu, bool fake_pmu,
 				   struct expr_parse_ctx **combined)
 {
 	struct hashmap_entry *cur;
@@ -1240,7 +1476,7 @@ static int build_combined_expr_ctx(const struct list_head *metric_list,
 		return -ENOMEM;
 
 	list_for_each_entry(m, metric_list, nd) {
-		if (!m->group_events && !m->modifier) {
+		if (metric__can_use_combined_evlist(m, pmu, fake_pmu)) {
 			hashmap__for_each_entry(m->pctx->ids, cur, bkt) {
 				dup = strdup(cur->pkey);
 				if (!dup) {
@@ -1430,7 +1666,8 @@ static int parse_groups(struct evlist *perf_evlist,
 
 		find_tool_events(&metric_list, tool_events);
 
-		ret = build_combined_expr_ctx(&metric_list, &combined);
+		ret = build_combined_expr_ctx(&metric_list, pmu, fake_pmu,
+					      &combined);
 
 		if (!ret && combined && hashmap__size(combined->ids)) {
 			ret = parse_ids(metric_no_merge, fake_pmu, combined,
@@ -1458,7 +1695,8 @@ static int parse_groups(struct evlist *perf_evlist,
 		struct metric *n;
 		struct metric_expr *expr;
 
-		if (combined_evlist && !m->group_events) {
+		if (combined_evlist &&
+		    metric__can_use_combined_evlist(m, pmu, fake_pmu)) {
 			metric_evlist = combined_evlist;
 		} else if (!metric_no_merge) {
 			/*
@@ -1493,10 +1731,23 @@ static int parse_groups(struct evlist *perf_evlist,
 			}
 		}
 		if (!metric_evlist) {
+			const char *m_filter_pmu =
+				(pmu && strcmp(pmu, "all") != 0) ? pmu : NULL;
+			bool m_cputype_filter = cputype_filter;
+
+			if (!fake_pmu && m->pmu &&
+			    strcmp(m->pmu, "all") != 0 &&
+			    strcmp(m->pmu, "default_core") != 0 &&
+			    is_core_pmu_name(m->pmu) &&
+			    pmu_filter_allows_other_core_pmu(pmu, m->pmu)) {
+				if (!m_filter_pmu)
+					m_cputype_filter = true;
+				m_filter_pmu = m->pmu;
+			}
+
 			ret = parse_ids(metric_no_merge, fake_pmu, m->pctx, m->modifier,
 					m->group_events, tool_events, &m->evlist,
-					(pmu && strcmp(pmu, "all") == 0) ? NULL : pmu,
-					cputype_filter);
+					m_filter_pmu, m_cputype_filter);
 			if (ret)
 				goto out;
 
@@ -1589,14 +1840,12 @@ int metricgroup__parse_groups(struct evlist *perf_evlist,
 			      bool system_wide,
 			      bool hardware_aware_grouping)
 {
-	const struct pmu_metrics_table *table = pmu_metrics_table__find();
-
 	if (hardware_aware_grouping)
 		pr_debug("Use hardware aware grouping instead of traditional metric grouping method\n");
 
 	return parse_groups(perf_evlist, pmu, cputype_filter, str, metric_no_group, metric_no_merge,
 			    metric_no_threshold, user_requested_cpu_list, system_wide,
-			    /*fake_pmu=*/false, table);
+			    /*fake_pmu=*/false, /*table=*/NULL);
 }
 
 int metricgroup__parse_groups_test(struct evlist *evlist,
@@ -1617,28 +1866,30 @@ struct metricgroup__has_metric_data {
 	const char *pmu;
 	const char *metric_or_groups;
 };
-static int metricgroup__has_metric_or_groups_callback(const struct pmu_metric *pm,
-						      const struct pmu_metrics_table *table
-							__maybe_unused,
-						      void *vdata)
+static int metricgroup__has_pmu_metric_or_groups_callback(struct perf_pmu *pmu,
+							  const struct pmu_metric *pm,
+							  const struct pmu_metrics_table *table
+								__maybe_unused,
+							  void *vdata)
 {
 	struct metricgroup__has_metric_data *data = vdata;
 
-	return match_pm_metric_or_groups(pm, data->pmu, data->metric_or_groups) ? 1 : 0;
+	if (!pm->metric_expr)
+		return 0;
+
+	return match_pm_metric_or_groups(pm, pmu, data->pmu,
+					 data->metric_or_groups) ? 1 : 0;
 }
 
 bool metricgroup__has_metric_or_groups(const char *pmu, const char *metric_or_groups)
 {
-	const struct pmu_metrics_table *table = pmu_metrics_table__find();
 	struct metricgroup__has_metric_data data = {
 		.pmu = pmu,
 		.metric_or_groups = metric_or_groups,
 	};
 
-	return metricgroup__for_each_metric(table,
-					    metricgroup__has_metric_or_groups_callback,
-					    &data)
-		? true : false;
+	return perf_pmus__for_each_pmu_metric(metricgroup__has_pmu_metric_or_groups_callback,
+					      &data) > 0;
 }
 
 static int metricgroup__topdown_max_level_callback(const struct pmu_metric *pm,
@@ -1662,13 +1913,9 @@ static int metricgroup__topdown_max_level_callback(const struct pmu_metric *pm,
 unsigned int metricgroups__topdown_max_level(void)
 {
 	unsigned int max_level = 0;
-	const struct pmu_metrics_table *table = pmu_metrics_table__find();
-
-	if (!table)
-		return false;
 
-	pmu_metrics_table__for_each_metric(table, metricgroup__topdown_max_level_callback,
-					  &max_level);
+	perf_pmus__for_each_metric(metricgroup__topdown_max_level_callback,
+				   &max_level);
 	return max_level;
 }
 
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index a3e1630c5a84..9713d266393e 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -421,6 +421,53 @@ static struct perf_pmu_alias *perf_pmu__find_alias(struct perf_pmu *pmu,
 	return pmu_layer__find_event(pmu, name);
 }
 
+bool perf_pmu__find_metric(struct perf_pmu *pmu, const char *name,
+			   struct pmu_metric *out)
+{
+	struct perf_pmu_metric *m = pmu_layer__find_metric(pmu, name);
+
+	if (!m)
+		return false;
+	if (out)
+		perf_pmu_metric__to_pmu_metric(m, out);
+	return true;
+}
+
+int perf_pmu__for_each_metric(struct perf_pmu *pmu, pmu_metric_iter_fn fn,
+			      void *data)
+{
+	struct hashmap_entry *entry;
+	size_t bkt;
+	int ret;
+
+	if (!pmu)
+		return 0;
+
+	ret = pmu_layer__load_metrics(pmu);
+	if (ret)
+		return ret;
+
+	hashmap__for_each_entry(pmu->metrics, entry, bkt) {
+		const struct perf_pmu_metric *m = entry->pvalue;
+		struct pmu_metric pm;
+
+		if (!m->metric_expr)
+			continue;
+
+		perf_pmu_metric__to_pmu_metric(m, &pm);
+		ret = fn(&pm, pmu->metrics_table, data);
+		if (ret)
+			return ret;
+	}
+	return 0;
+}
+
+const char *perf_pmu__describe_metricgroup(struct perf_pmu *pmu,
+					   const char *group)
+{
+	return pmu_layer__describe_metricgroup(pmu, group);
+}
+
 static int pmu_alias_terms(struct perf_pmu_alias *alias, struct list_head *terms)
 {
 	struct parse_events_terms alias_terms;
@@ -855,6 +902,22 @@ static __u32 wellknown_pmu_type(const char *pmu_name)
 	return PERF_TYPE_MAX;
 }
 
+bool perf_pmu__is_core_at(int dirfd, const char *name)
+{
+	int fd;
+
+	if (is_pmu_core(name))
+		return true;
+	if (dirfd < 0)
+		return false;
+
+	fd = perf_pmu__pathname_fd(dirfd, name, "cpus", O_RDONLY);
+	if (fd < 0)
+		return false;
+	close(fd);
+	return true;
+}
+
 struct perf_pmu *perf_pmu__lookup(struct list_head *pmus, int dirfd, const char *name,
 				  bool eager_load)
 {
@@ -892,7 +955,7 @@ struct perf_pmu *perf_pmu__lookup(struct list_head *pmus, int dirfd, const char
 		return NULL;
 	}
 
-	pmu->is_core = is_pmu_core(name);
+	pmu->is_core = perf_pmu__is_core_at(dirfd, name);
 	pmu->cpus = pmu_cpumask(dirfd, name, pmu->is_core);
 
 	pmu->is_uncore = pmu_is_uncore(dirfd, name);
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 42a0f5655b1c..ef437cc4c7e6 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -270,6 +270,12 @@ typedef int (*pmu_event_callback)(void *state, struct pmu_event_info *info);
 typedef int (*pmu_format_callback)(void *state, const char *name, int config,
 				   const unsigned long *bits);
 
+bool perf_pmu__find_metric(struct perf_pmu *pmu, const char *name,
+			   struct pmu_metric *out);
+int perf_pmu__for_each_metric(struct perf_pmu *pmu, pmu_metric_iter_fn fn,
+			      void *data);
+const char *perf_pmu__describe_metricgroup(struct perf_pmu *pmu,
+					   const char *group);
 void pmu_add_sys_aliases(struct perf_pmu *pmu);
 int perf_pmu__config(struct perf_pmu *pmu, struct perf_event_attr *attr,
 		     struct parse_events_terms *head_terms,
@@ -353,6 +359,7 @@ int perf_pmu__event_source_devices_fd(void);
 int perf_pmu__pathname_fd(int dirfd, const char *pmu_name, const char *filename, int flags);
 
 int perf_pmu__init(struct perf_pmu *pmu, __u32 type, const char *name);
+bool perf_pmu__is_core_at(int dirfd, const char *name);
 struct perf_pmu *perf_pmu__lookup(struct list_head *pmus, int dirfd, const char *lookup_name,
 				  bool eager_load);
 struct perf_pmu *perf_pmu__create_placeholder_core_pmu(struct list_head *core_pmus);
diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
index 6ecea8f0d382..928dfc80f8db 100644
--- a/tools/perf/util/pmus.c
+++ b/tools/perf/util/pmus.c
@@ -7,7 +7,9 @@
 #include <subcmd/pager.h>
 #include <sys/types.h>
 #include <ctype.h>
+#include <errno.h>
 #include <pthread.h>
+#include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
@@ -15,6 +17,7 @@
 #include "debug.h"
 #include "drm_pmu.h"
 #include "evsel.h"
+#include "hashmap.h"
 #include "pmus.h"
 #include "pmu.h"
 #include "pmu-layer.h"
@@ -23,6 +26,7 @@
 #include "print-events.h"
 #include "strbuf.h"
 #include "string2.h"
+#include "strlist.h"
 
 /*
  * core_pmus:  A PMU belongs to core_pmus if it's name is "cpu" or it's sysfs
@@ -61,6 +65,7 @@ enum perf_tool_pmu_type {
 					PERF_TOOL_PMU_TYPE_DRM_MASK)
 };
 static unsigned int read_pmu_types;
+static int core_pmus_count;
 
 static void pmu_read_sysfs(unsigned int to_read_pmus);
 
@@ -125,6 +130,7 @@ void perf_pmus__destroy(void)
 		perf_pmu__delete(pmu);
 	}
 	read_pmu_types = 0;
+	core_pmus_count = 0;
 	pmu_layers__exit();
 }
 
@@ -491,6 +497,31 @@ static struct perf_pmu *perf_pmus__scan_skip_duplicates(struct perf_pmu *pmu)
 	return NULL;
 }
 
+struct perf_pmu *perf_pmus__scan_for_metrics(struct perf_pmu *pmu)
+{
+	bool use_core_pmus = !pmu || pmu->is_core;
+
+	if (!pmu) {
+		const unsigned int to_read_pmus =
+			PERF_TOOL_PMU_TYPE_PE_CORE_MASK |
+			PERF_TOOL_PMU_TYPE_PE_OTHER_MASK |
+			PERF_TOOL_PMU_TYPE_TOOL_MASK;
+
+		pmu_read_sysfs(to_read_pmus);
+		pmu = list_prepare_entry(pmu, &core_pmus, list);
+	}
+	if (use_core_pmus) {
+		list_for_each_entry_continue(pmu, &core_pmus, list)
+			return pmu;
+
+		pmu = NULL;
+		pmu = list_prepare_entry(pmu, &other_pmus, list);
+	}
+	list_for_each_entry_continue(pmu, &other_pmus, list)
+		return pmu;
+	return NULL;
+}
+
 struct perf_pmu *perf_pmus__scan_for_uncore_id(struct perf_pmu *pmu, const char *compat)
 {
 	if (!pmu) {
@@ -805,17 +836,204 @@ bool perf_pmus__have_event(const char *pname, const char *name)
 	return pmu && perf_pmu__have_event(pmu, name);
 }
 
-int perf_pmus__num_core_pmus(void)
+bool perf_pmus__find_metric_pmu(const char *pmu_name, const char *name,
+				struct pmu_metric *out)
+{
+	struct perf_pmu *pmu = NULL;
+
+	if (!name || !name[0])
+		return false;
+
+	if (pmu_name && pmu_name[0] && strcmp(pmu_name, "all") != 0) {
+		struct pmu_metric fallback = {};
+		bool have_fallback = false;
+
+		if (!strcmp(pmu_name, "default_core")) {
+			while ((pmu = perf_pmus__scan_core(pmu)) != NULL) {
+				struct pmu_metric pm;
+
+				if (!perf_pmu__find_metric(pmu, name, &pm))
+					continue;
+				if (!pm.pmu || !pm.pmu[0] ||
+				    !strcmp(pm.pmu, "default_core")) {
+					if (out)
+						*out = pm;
+					return true;
+				}
+				if (!have_fallback) {
+					fallback = pm;
+					have_fallback = true;
+				}
+			}
+			if (have_fallback && out)
+				*out = fallback;
+			return have_fallback;
+		}
+
+		pmu = perf_pmus__find(pmu_name);
+		if (pmu)
+			return perf_pmu__find_metric(pmu, name, out);
+
+		while ((pmu = perf_pmus__scan_for_metrics(pmu)) != NULL) {
+			struct pmu_metric pm;
+			const char *m_pmu;
+
+			if (!perf_pmu__name_wildcard_match(pmu, pmu_name) &&
+			    !perf_pmu__wildcard_match(pmu, pmu_name))
+				continue;
+			if (!perf_pmu__find_metric(pmu, name, &pm))
+				continue;
+			m_pmu = (pm.pmu && pm.pmu[0]) ? pm.pmu :
+				(pmu->is_core ? "default_core" : pmu->name);
+			if (!strcmp(m_pmu, pmu_name)) {
+				if (out)
+					*out = pm;
+				return true;
+			}
+			if (!have_fallback) {
+				fallback = pm;
+				have_fallback = true;
+			}
+		}
+		if (have_fallback && out)
+			*out = fallback;
+		return have_fallback;
+	}
+
+	while ((pmu = perf_pmus__scan_for_metrics(pmu)) != NULL) {
+		if (perf_pmu__find_metric(pmu, name, out))
+			return true;
+	}
+	return false;
+}
+
+bool perf_pmus__find_metric(const char *name, struct pmu_metric *out)
+{
+	return perf_pmus__find_metric_pmu(NULL, name, out);
+}
+
+struct pmus_pmu_metric_iter_ctx {
+	struct perf_pmu *pmu;
+	pmus_metric_iter_fn fn;
+	void *data;
+};
+
+static int pmus_for_each_pmu_metric_cb(const struct pmu_metric *pm,
+				       const struct pmu_metrics_table *table,
+				       void *vdata)
+{
+	struct pmus_pmu_metric_iter_ctx *ctx = vdata;
+
+	return ctx->fn(ctx->pmu, pm, table, ctx->data);
+}
+
+int perf_pmus__for_each_pmu_metric(pmus_metric_iter_fn fn, void *data)
 {
-	static int count;
+	struct pmus_pmu_metric_iter_ctx ctx = {
+		.fn = fn,
+		.data = data,
+	};
+	int ret = 0;
+
+	while ((ctx.pmu = perf_pmus__scan_for_metrics(ctx.pmu)) != NULL) {
+		ret = perf_pmu__for_each_metric(ctx.pmu,
+						pmus_for_each_pmu_metric_cb,
+						&ctx);
+		if (ret)
+			break;
+	}
+	return ret;
+}
+
+struct pmus_metric_iter_adapter_ctx {
+	pmu_metric_iter_fn fn;
+	void *data;
+	struct strlist *seen;
+};
+
+static int pmus_metric_iter_adapter_cb(struct perf_pmu *pmu __maybe_unused,
+				       const struct pmu_metric *pm,
+				       const struct pmu_metrics_table *table,
+				       void *vdata)
+{
+	struct pmus_metric_iter_adapter_ctx *ctx = vdata;
+	char *key = NULL;
+	int ret;
+
+	if (asprintf(&key, "%s\x1f%s\x1f%s\x1f%s",
+		     (pm->pmu && pm->pmu[0]) ? pm->pmu : "default_core",
+		     pm->metric_name ?: "",
+		     pm->metric_expr ?: "",
+		     pm->metric_threshold ?: "") < 0)
+		return -ENOMEM;
+
+	if (strlist__has_entry(ctx->seen, key)) {
+		free(key);
+		return 0;
+	}
+	ret = strlist__add(ctx->seen, key);
+	free(key);
+	if (ret)
+		return ret;
+
+	return ctx->fn(pm, table, ctx->data);
+}
 
-	if (!count) {
+int perf_pmus__for_each_metric(pmu_metric_iter_fn fn, void *data)
+{
+	struct pmus_metric_iter_adapter_ctx ctx = {
+		.fn = fn,
+		.data = data,
+		.seen = strlist__new(NULL, NULL),
+	};
+	int ret;
+
+	if (!ctx.seen)
+		return -ENOMEM;
+
+	ret = perf_pmus__for_each_pmu_metric(pmus_metric_iter_adapter_cb, &ctx);
+	strlist__delete(ctx.seen);
+	return ret;
+}
+
+const char *perf_pmus__describe_metricgroup(const char *group)
+{
+	struct perf_pmu *pmu = NULL;
+	const char *builtin_desc = NULL;
+	bool saw_core_pmu = false;
+
+	if (!group || !group[0])
+		return NULL;
+
+	while ((pmu = perf_pmus__scan_for_metrics(pmu)) != NULL) {
+		const char *desc = perf_pmu__describe_metricgroup(pmu, group);
+		struct perf_pmu_metricgroup *mg = NULL;
+
+		if (pmu->is_core)
+			saw_core_pmu = true;
+		if (!desc)
+			continue;
+		if (pmu->metricgroups)
+			hashmap__find(pmu->metricgroups, group, &mg);
+		if (mg && !mg->from_builtin)
+			return desc;
+		if (!builtin_desc)
+			builtin_desc = desc;
+	}
+	if (saw_core_pmu)
+		return builtin_desc;
+	return describe_metricgroup(group);
+}
+
+int perf_pmus__num_core_pmus(void)
+{
+	if (!core_pmus_count) {
 		struct perf_pmu *pmu = NULL;
 
 		while ((pmu = perf_pmus__scan_core(pmu)) != NULL)
-			count++;
+			core_pmus_count++;
 	}
-	return count;
+	return core_pmus_count;
 }
 
 static bool __perf_pmus__supports_extended_type(void)
@@ -893,12 +1111,19 @@ struct perf_pmu *perf_pmus__find_core_pmu(void)
 
 struct perf_pmu *perf_pmus__add_test_pmu(int test_sysfs_dirfd, const char *name)
 {
+	bool is_core = perf_pmu__is_core_at(test_sysfs_dirfd, name);
+	struct perf_pmu *pmu;
+
 	/*
 	 * Some PMU functions read from the sysfs mount point, so care is
 	 * needed, hence passing the eager_load flag to load things like the
 	 * format files.
 	 */
-	return perf_pmu__lookup(&other_pmus, test_sysfs_dirfd, name, /*eager_load=*/true);
+	pmu = perf_pmu__lookup(is_core ? &core_pmus : &other_pmus,
+			       test_sysfs_dirfd, name, /*eager_load=*/true);
+	if (pmu && is_core)
+		core_pmus_count = 0;
+	return pmu;
 }
 
 struct perf_pmu *perf_pmus__add_test_hwmon_pmu(const char *hwmon_dir,
diff --git a/tools/perf/util/pmus.h b/tools/perf/util/pmus.h
index 0d55edb3f2fc..f4295526b2ae 100644
--- a/tools/perf/util/pmus.h
+++ b/tools/perf/util/pmus.h
@@ -4,6 +4,7 @@
 
 #include <stdbool.h>
 #include <stddef.h>
+#include "pmu-events/pmu-events.h"
 
 struct perf_event_attr;
 struct perf_pmu;
@@ -23,6 +24,7 @@ struct perf_pmu *perf_pmus__scan(struct perf_pmu *pmu);
 struct perf_pmu *perf_pmus__scan_core(struct perf_pmu *pmu);
 struct perf_pmu *perf_pmus__scan_for_event(struct perf_pmu *pmu, const char *event);
 struct perf_pmu *perf_pmus__scan_matching_wildcard(struct perf_pmu *pmu, const char *wildcard);
+struct perf_pmu *perf_pmus__scan_for_metrics(struct perf_pmu *pmu);
 struct perf_pmu *perf_pmus__scan_for_uncore_id(struct perf_pmu *pmu, const char *compat);
 
 const struct perf_pmu *perf_pmus__pmu_for_pmu_filter(const char *str);
@@ -30,6 +32,17 @@ const struct perf_pmu *perf_pmus__pmu_for_pmu_filter(const char *str);
 void perf_pmus__print_pmu_events(const struct print_callbacks *print_cb, void *print_state);
 void perf_pmus__print_raw_pmu_events(const struct print_callbacks *print_cb, void *print_state);
 bool perf_pmus__have_event(const char *pname, const char *name);
+typedef int (*pmus_metric_iter_fn)(struct perf_pmu *pmu,
+				   const struct pmu_metric *pm,
+				   const struct pmu_metrics_table *table,
+				   void *data);
+
+bool perf_pmus__find_metric_pmu(const char *pmu_name, const char *name,
+				struct pmu_metric *out);
+bool perf_pmus__find_metric(const char *name, struct pmu_metric *out);
+int perf_pmus__for_each_pmu_metric(pmus_metric_iter_fn fn, void *data);
+int perf_pmus__for_each_metric(pmu_metric_iter_fn fn, void *data);
+const char *perf_pmus__describe_metricgroup(const char *group);
 int perf_pmus__num_core_pmus(void);
 bool perf_pmus__supports_extended_type(void);
 
diff --git a/tools/perf/util/print-events.c b/tools/perf/util/print-events.c
index 77428d9e73c4..eb44026972b9 100644
--- a/tools/perf/util/print-events.c
+++ b/tools/perf/util/print-events.c
@@ -289,14 +289,14 @@ void metricgroup__print(const struct print_callbacks *print_cb, void *print_stat
 {
 	struct rblist groups;
 	struct rb_node *node, *next;
-	const struct pmu_metrics_table *table = pmu_metrics_table__find();
 
 	rblist__init(&groups);
 	groups.node_new = mep_new;
 	groups.node_cmp = mep_cmp;
 	groups.node_delete = mep_delete;
 
-	metricgroup__for_each_metric(table, metricgroup__add_to_mep_groups_callback, &groups);
+	metricgroup__for_each_metric(/*table=*/NULL,
+				     metricgroup__add_to_mep_groups_callback, &groups);
 
 	for (node = rb_first_cached(&groups.entries); node; node = next) {
 		struct mep *me = container_of(node, struct mep, nd);
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 42c587cd54a5..9002288d24f4 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -3953,16 +3953,13 @@ static int pyrf__metrics_cb(const struct pmu_metric *pm,
 
 static PyObject *pyrf__metrics(PyObject *self, PyObject *args)
 {
-	const struct pmu_metrics_table *table = pmu_metrics_table__find();
 	PyObject *list = PyList_New(/*len=*/0);
 	int ret;
 
 	if (!list)
 		return NULL;
 
-	ret = pmu_metrics_table__for_each_metric(table, pyrf__metrics_cb, list);
-	if (!ret)
-		ret = pmu_for_each_sys_metric(pyrf__metrics_cb, list);
+	ret = metricgroup__for_each_metric(/*table=*/NULL, pyrf__metrics_cb, list);
 
 	if (ret) {
 		Py_DECREF(list);
-- 
2.56.1.703.gf848ed807c-goog

