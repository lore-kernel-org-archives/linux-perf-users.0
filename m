Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A84B478E39
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 16:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781628510; cv=none; b=rrNYdruRsHJaPBoIBgfAce8efsGdTMkq3iwbVqLjmsShV9Fc5GJNQcLwfKDoj6+/9gTHLRSZ0ToVbjlCUt5BQBKRA5gCG3aV0zxIX8N5ZOABnyICvQZ7gEQg6jZnohl9bePffLznv8N+0UPS7xLYW/51sD95HV3VuTV6b3ZP6AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781628510; c=relaxed/simple;
	bh=z3YYkiCHCzf+Quo2an7ai/bJldX8v1/fPDVQr4hx7sw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LiS+GhWIgFV9mflxloWp2yY47NqUnx/bi4tNHN3hJJDB5UpErdb6P2Bljo2fWvEQHifzCRHGUYCP1OrNz1qk+wUc2KS4NeRjfz6tfWIJdisCJgxhEJR6CSwfBIRRbqEd2ICe9j9dloGsNeiziSHfzg3nrR4BtyH4khp8ZQnPjys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uPO4xcBa; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uPO4xcBa"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-304ec73b015so1737669eec.1
        for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 09:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781628508; x=1782233308; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jLhhfLiRah3wPp0yZH3JQKyLjR52iNjpxNldZtI2l+8=;
        b=uPO4xcBaRNGOm+1Buvf6v4AXoBgEwI0Whp1JAPLdqFJC1HhuwL/uV4iv8osRjVwnGX
         7Qkl6eZqN+W6c4oiZIWwvRq4SCVbGzSvTtUtvovTjb2SquNth/mHgYSKExsw6nHvfx2F
         EWwp2GjZW4p5yDnJCFW+f3muoLh5sY4PzzufqhE/aKWIvr9tzC1iq7YwqNIFBBHrfeY9
         G7Ep+45013/L+OCqn9CS9KcuWX5x3OYMCH8f7t61SQQeBZKqE/5CpYvBKyNy5Gva16vQ
         5CJJ7FXBkUJQtVirtGOScuRRAi20VfDRMTuIu72gVaRMe1Z+G1cdyN27wzwG2VWgR8Yl
         22EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781628508; x=1782233308;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jLhhfLiRah3wPp0yZH3JQKyLjR52iNjpxNldZtI2l+8=;
        b=T0s+1SU21k9ALcJezJAUIxQgpwf2mx7klytvw/sZsGGXU2OOuEzzsFwxU1AY4n7BBk
         nBfxau2x2uQpMugEfV3LqJVEeHlXmEcPNt3zeoElqXlJCgTy0EUM7UoTfV8pYDd7cVW6
         eL501SOY4F958imC9ncB3UwLQ+tRIgEarQMkX/jLsPrsnyjm+fsxkpdHjcSCCA2av8rN
         tJE1pwOGvrA5TqSjXrlFUMxFKdI8sCP2BSBgD2DiZDgFGwGcaPPL3UCHv2WaIA8oEOaq
         VFYO0e0FtJ9TmiXuj90KaUuWsV3pRW8AysuYqCzD75A5zZkelbVCmlfXSG/Il94+suP4
         ULeQ==
X-Forwarded-Encrypted: i=1; AFNElJ8u+06XuUXzlqFIEf6SeG5SBKox/2jmJI94gj88DUkfvQ0twOm9S4A8zuHb3m09jg3h+uu/7n7AT2jYJcQVhgtd@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7jEoRHghcEqwFq4K1UpOALGBM/fXW7Dx2+zbaaOHFYHjRZ0HW
	fj8FtoQvNPIkISVmp//Sq2EGv2Qwwg0ctSqdYWgIPn28a3H0qeneGRK42EmtCU/XRvXAgFgLKq8
	o51NaU3sOgw==
X-Received: from dyjt21.prod.google.com ([2002:a05:7300:7b15:b0:304:ee5b:e1a5])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:f18f:b0:304:cd60:b6a6
 with SMTP id 5a478bee46e88-30bca21d25fmr47575eec.30.1781628507281; Tue, 16
 Jun 2026 09:48:27 -0700 (PDT)
Date: Tue, 16 Jun 2026 09:48:06 -0700
In-Reply-To: <20260616164819.370939-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260616061404.41929-1-irogers@google.com> <20260616164819.370939-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1189.g8c84645362-goog
Message-ID: <20260616164819.370939-2-irogers@google.com>
Subject: [PATCH v3 01/13] perf parse-events: Restrict core PMU bypass to
 --cputype option
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	leo.yan@arm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	thomas.falcon@intel.com, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Commit b1c5efbfd92e ("perf parse-events: Remove hard coded legacy hardware
and cache parsing") introduced a bypass to PMU filtering to prevent uncore
PMUs from being filtered out during event parsing, which was required for
resolving `duration_time` and `uncore_freq` when running with `--cputype`.
However, this bypass was active whenever `pmu_filter` was set, which also
incorrectly bypassed filtering for the `--pmu-filter` option.

Introduce a `cputype_filter` boolean flag in `parse_events_state` and
`parse_events_option_args` to distinguish filtering initiated by
`--cputype` from that initiated by `--pmu-filter`. Restrict the core-only
check in `parse_events__filter_pmu()` to when `cputype_filter` is true.

Fixes: b1c5efbfd92e ("perf parse-events: Remove hard coded legacy hardware and cache parsing")
Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-script.c      |  1 +
 tools/perf/builtin-stat.c        | 20 +++++++++++++++-----
 tools/perf/tests/expand-cgroup.c |  3 ++-
 tools/perf/tests/parse-events.c  | 11 +++++++----
 tools/perf/tests/parse-metric.c  |  3 ++-
 tools/perf/tests/pmu-events.c    | 10 +++++++---
 tools/perf/util/metricgroup.c    | 26 ++++++++++++++++++--------
 tools/perf/util/metricgroup.h    |  4 +++-
 tools/perf/util/parse-events.c   | 30 ++++++++++++++++++------------
 tools/perf/util/parse-events.h   | 17 +++++++++++------
 tools/perf/util/python.c         |  3 ++-
 11 files changed, 86 insertions(+), 42 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 9ac29bdc3cd5..6bd4d8627704 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -2174,6 +2174,7 @@ static int script_find_metrics(const struct pmu_metric *pm,
 	struct evsel *metric_evsel;
 	int ret = metricgroup__parse_groups(metric_evlist,
 					/*pmu=*/"all",
+					/*cputype_filter=*/false,
 					pm->metric_name,
 					/*metric_no_group=*/false,
 					/*metric_no_merge=*/false,
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index a04466ea3b0a..5e73e4b128a1 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1210,6 +1210,7 @@ static int parse_cputype(const struct option *opt,
 		return -1;
 	}
 	parse_events_option_args.pmu_filter = pmu->name;
+	parse_events_option_args.cputype_filter = true;
 
 	return 0;
 }
@@ -1226,6 +1227,7 @@ static int parse_pmu_filter(const struct option *opt,
 	}
 
 	parse_events_option_args.pmu_filter = str;
+	parse_events_option_args.cputype_filter = false;
 	return 0;
 }
 
@@ -1999,7 +2001,9 @@ static int add_default_events(void)
 			ret = -1;
 			goto out;
 		}
-		ret = metricgroup__parse_groups(evlist, pmu, "transaction",
+		ret = metricgroup__parse_groups(evlist, pmu,
+						parse_events_option_args.cputype_filter,
+						"transaction",
 						stat_config.metric_no_group,
 						stat_config.metric_no_merge,
 						stat_config.metric_no_threshold,
@@ -2036,7 +2040,9 @@ static int add_default_events(void)
 		if (!force_metric_only)
 			stat_config.metric_only = true;
 
-		ret = metricgroup__parse_groups(evlist, pmu, "smi",
+		ret = metricgroup__parse_groups(evlist, pmu,
+						parse_events_option_args.cputype_filter,
+						"smi",
 						stat_config.metric_no_group,
 						stat_config.metric_no_merge,
 						stat_config.metric_no_threshold,
@@ -2073,7 +2079,7 @@ static int add_default_events(void)
 		}
 		str[8] = stat_config.topdown_level + '0';
 		if (metricgroup__parse_groups(evlist,
-						pmu, str,
+					      pmu, parse_events_option_args.cputype_filter, str,
 						/*metric_no_group=*/false,
 						/*metric_no_merge=*/false,
 						/*metric_no_threshold=*/true,
@@ -2112,7 +2118,9 @@ static int add_default_events(void)
 				ret = -ENOMEM;
 				break;
 			}
-			if (metricgroup__parse_groups(metric_evlist, pmu, default_metricgroup_names[i],
+			if (metricgroup__parse_groups(metric_evlist, pmu,
+						      parse_events_option_args.cputype_filter,
+						      default_metricgroup_names[i],
 							/*metric_no_group=*/false,
 							/*metric_no_merge=*/false,
 							/*metric_no_threshold=*/true,
@@ -2848,7 +2856,9 @@ int cmd_stat(int argc, const char **argv)
 	 */
 	if (metrics) {
 		const char *pmu = parse_events_option_args.pmu_filter ?: "all";
-		int ret = metricgroup__parse_groups(evsel_list, pmu, metrics,
+		int ret = metricgroup__parse_groups(evsel_list, pmu,
+						    parse_events_option_args.cputype_filter,
+						    metrics,
 						stat_config.metric_no_group,
 						stat_config.metric_no_merge,
 						stat_config.metric_no_threshold,
diff --git a/tools/perf/tests/expand-cgroup.c b/tools/perf/tests/expand-cgroup.c
index dd547f2f77cc..19bc273c2984 100644
--- a/tools/perf/tests/expand-cgroup.c
+++ b/tools/perf/tests/expand-cgroup.c
@@ -179,7 +179,8 @@ static int expand_metric_events(void)
 	TEST_ASSERT_VAL("failed to get evlist", evlist);
 
 	pme_test = find_core_metrics_table("testarch", "testcpu");
-	ret = metricgroup__parse_groups_test(evlist, pme_test, metric_str);
+	ret = metricgroup__parse_groups_test(evlist, pme_test, metric_str,
+					     /*cputype_filter=*/false);
 	if (ret < 0) {
 		pr_debug("failed to parse '%s' metric\n", metric_str);
 		goto out;
diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index 05c3e899b425..2cbe81b9c886 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -2556,8 +2556,10 @@ static int test_event(const struct evlist_test *e)
 		return TEST_FAIL;
 	}
 	parse_events_error__init(&err);
-	ret = __parse_events(evlist, e->name, /*pmu_filter=*/NULL, &err, /*fake_pmu=*/false,
-			     /*warn_if_reordered=*/true, /*fake_tp=*/true);
+	ret = __parse_events(evlist, e->name, /*pmu_filter=*/NULL,
+			     /*cputype_filter=*/false, &err, /*fake_pmu=*/false,
+			     /*warn_if_reordered=*/true,
+			     /*fake_tp=*/true);
 	if (ret) {
 		pr_debug("failed to parse event '%s', err %d\n", e->name, ret);
 		parse_events_error__print(&err, e->name);
@@ -2584,8 +2586,9 @@ static int test_event_fake_pmu(const char *str)
 		return -ENOMEM;
 
 	parse_events_error__init(&err);
-	ret = __parse_events(evlist, str, /*pmu_filter=*/NULL, &err,
-			     /*fake_pmu=*/true, /*warn_if_reordered=*/true,
+	ret = __parse_events(evlist, str, /*pmu_filter=*/NULL,
+			     /*cputype_filter=*/false, &err, /*fake_pmu=*/true,
+			     /*warn_if_reordered=*/true,
 			     /*fake_tp=*/true);
 	if (ret) {
 		pr_debug("failed to parse event '%s', err %d\n",
diff --git a/tools/perf/tests/parse-metric.c b/tools/perf/tests/parse-metric.c
index 7c7f489a5eb0..eb456dd8cd9a 100644
--- a/tools/perf/tests/parse-metric.c
+++ b/tools/perf/tests/parse-metric.c
@@ -92,7 +92,8 @@ static int __compute_metric(const char *name, struct value *vals,
 
 	/* Parse the metric into metric_events list. */
 	pme_test = find_core_metrics_table("testarch", "testcpu");
-	err = metricgroup__parse_groups_test(evlist, pme_test, name);
+	err = metricgroup__parse_groups_test(evlist, pme_test, name,
+					     /*cputype_filter=*/false);
 	if (err)
 		goto out;
 
diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
index fd5630f0a13c..4febba3ab495 100644
--- a/tools/perf/tests/pmu-events.c
+++ b/tools/perf/tests/pmu-events.c
@@ -794,8 +794,10 @@ static int check_parse_id(const char *id, struct parse_events_error *error)
 	for (cur = strchr(dup, '@') ; cur; cur = strchr(++cur, '@'))
 		*cur = '/';
 
-	ret = __parse_events(evlist, dup, /*pmu_filter=*/NULL, error, /*fake_pmu=*/true,
-			     /*warn_if_reordered=*/true, /*fake_tp=*/false);
+	ret = __parse_events(evlist, dup, /*pmu_filter=*/NULL,
+			     /*cputype_filter=*/false, error, /*fake_pmu=*/true,
+			     /*warn_if_reordered=*/true,
+			     /*fake_tp=*/false);
 	free(dup);
 
 	evlist__delete(evlist);
@@ -871,7 +873,9 @@ static int test__parsing_callback(const struct pmu_metric *pm,
 
 	perf_evlist__set_maps(&evlist->core, cpus, NULL);
 
-	err = metricgroup__parse_groups_test(evlist, table, pm->metric_name);
+	err = metricgroup__parse_groups_test(evlist, table,
+					     pm->metric_name,
+					     /*cputype_filter=*/false);
 	if (err) {
 		if (is_expected_broken_metric(pm)) {
 			(*failures)--;
diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index c2ce3e53aaee..7584b7a32853 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -1262,7 +1262,8 @@ static int parse_ids(bool metric_no_merge, bool fake_pmu,
 		     struct expr_parse_ctx *ids, const char *modifier,
 		     bool group_events, const bool tool_events[TOOL_PMU__EVENT_MAX],
 		     struct evlist **out_evlist,
-		     const char *filter_pmu)
+		     const char *filter_pmu,
+		     bool cputype_filter)
 {
 	struct parse_events_error parse_error;
 	struct evlist *parsed_evlist;
@@ -1317,7 +1318,9 @@ static int parse_ids(bool metric_no_merge, bool fake_pmu,
 	pr_debug("Parsing metric events '%s'\n", events.buf);
 	parse_events_error__init(&parse_error);
 	ret = __parse_events(parsed_evlist, events.buf, filter_pmu,
-			     &parse_error, fake_pmu, /*warn_if_reordered=*/false,
+			     cputype_filter,
+			     &parse_error, fake_pmu,
+			     /*warn_if_reordered=*/false,
 			     /*fake_tp=*/false);
 	if (ret) {
 		parse_events_error__print(&parse_error, events.buf);
@@ -1382,7 +1385,7 @@ static struct evsel *pick_display_evsel(struct list_head *metric_list,
 }
 
 static int parse_groups(struct evlist *perf_evlist,
-			const char *pmu, const char *str,
+			const char *pmu, bool cputype_filter, const char *str,
 			bool metric_no_group,
 			bool metric_no_merge,
 			bool metric_no_threshold,
@@ -1420,7 +1423,8 @@ static int parse_groups(struct evlist *perf_evlist,
 					/*group_events=*/false,
 					tool_events,
 					&combined_evlist,
-					(pmu && strcmp(pmu, "all") == 0) ? NULL : pmu);
+					(pmu && strcmp(pmu, "all") == 0) ? NULL : pmu,
+					cputype_filter);
 		}
 		if (combined)
 			expr__ctx_free(combined);
@@ -1476,7 +1480,8 @@ static int parse_groups(struct evlist *perf_evlist,
 		if (!metric_evlist) {
 			ret = parse_ids(metric_no_merge, fake_pmu, m->pctx, m->modifier,
 					m->group_events, tool_events, &m->evlist,
-					(pmu && strcmp(pmu, "all") == 0) ? NULL : pmu);
+					(pmu && strcmp(pmu, "all") == 0) ? NULL : pmu,
+					cputype_filter);
 			if (ret)
 				goto out;
 
@@ -1543,6 +1548,7 @@ static int parse_groups(struct evlist *perf_evlist,
 	if (combined_evlist) {
 		evlist__splice_list_tail(perf_evlist, &combined_evlist->core.entries);
 		evlist__delete(combined_evlist);
+		combined_evlist = NULL;
 	}
 
 	list_for_each_entry(m, &metric_list, nd) {
@@ -1551,12 +1557,15 @@ static int parse_groups(struct evlist *perf_evlist,
 	}
 
 out:
+	if (combined_evlist)
+		evlist__delete(combined_evlist);
 	metricgroup__free_metrics(&metric_list);
 	return ret;
 }
 
 int metricgroup__parse_groups(struct evlist *perf_evlist,
 			      const char *pmu,
+			      bool cputype_filter,
 			      const char *str,
 			      bool metric_no_group,
 			      bool metric_no_merge,
@@ -1570,16 +1579,17 @@ int metricgroup__parse_groups(struct evlist *perf_evlist,
 	if (hardware_aware_grouping)
 		pr_debug("Use hardware aware grouping instead of traditional metric grouping method\n");
 
-	return parse_groups(perf_evlist, pmu, str, metric_no_group, metric_no_merge,
+	return parse_groups(perf_evlist, pmu, cputype_filter, str, metric_no_group, metric_no_merge,
 			    metric_no_threshold, user_requested_cpu_list, system_wide,
 			    /*fake_pmu=*/false, table);
 }
 
 int metricgroup__parse_groups_test(struct evlist *evlist,
 				   const struct pmu_metrics_table *table,
-				   const char *str)
+				   const char *str,
+				   bool cputype_filter)
 {
-	return parse_groups(evlist, "all", str,
+	return parse_groups(evlist, "all", cputype_filter, str,
 			    /*metric_no_group=*/false,
 			    /*metric_no_merge=*/false,
 			    /*metric_no_threshold=*/false,
diff --git a/tools/perf/util/metricgroup.h b/tools/perf/util/metricgroup.h
index 4be6bfc13c46..6a66f14dd01b 100644
--- a/tools/perf/util/metricgroup.h
+++ b/tools/perf/util/metricgroup.h
@@ -71,6 +71,7 @@ struct metric_event *metricgroup__lookup(struct rblist *metric_events,
 					 bool create);
 int metricgroup__parse_groups(struct evlist *perf_evlist,
 			      const char *pmu,
+			      bool cputype_filter,
 			      const char *str,
 			      bool metric_no_group,
 			      bool metric_no_merge,
@@ -80,7 +81,8 @@ int metricgroup__parse_groups(struct evlist *perf_evlist,
 			      bool hardware_aware_grouping);
 int metricgroup__parse_groups_test(struct evlist *evlist,
 				   const struct pmu_metrics_table *table,
-				   const char *str);
+				   const char *str,
+				   bool cputype_filter);
 
 int metricgroup__for_each_metric(const struct pmu_metrics_table *table, pmu_metric_iter_fn fn,
 				 void *data);
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 943569e82b82..c62453f97b9e 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -429,6 +429,9 @@ bool parse_events__filter_pmu(const struct parse_events_state *parse_state,
 	if (parse_state->pmu_filter == NULL)
 		return false;
 
+	if (parse_state->cputype_filter && !pmu->is_core)
+		return false;
+
 	return perf_pmu__wildcard_match(pmu, parse_state->pmu_filter) == 0;
 }
 
@@ -2288,18 +2291,20 @@ static int parse_events__sort_events_and_fix_groups(struct list_head *list)
 	return (idx_changed || num_leaders != orig_num_leaders) ? 1 : 0;
 }
 
-int __parse_events(struct evlist *evlist, const char *str, const char *pmu_filter,
+int __parse_events(struct evlist *evlist, const char *str,
+		   const char *pmu_filter, bool cputype_filter,
 		   struct parse_events_error *err, bool fake_pmu,
 		   bool warn_if_reordered, bool fake_tp)
 {
 	struct parse_events_state parse_state = {
-		.list	  = LIST_HEAD_INIT(parse_state.list),
-		.idx	  = evlist->core.nr_entries,
-		.error	  = err,
-		.stoken	  = PE_START_EVENTS,
-		.fake_pmu = fake_pmu,
-		.fake_tp  = fake_tp,
-		.pmu_filter = pmu_filter,
+		.list			  = LIST_HEAD_INIT(parse_state.list),
+		.idx			  = evlist->core.nr_entries,
+		.error			  = err,
+		.stoken			  = PE_START_EVENTS,
+		.fake_pmu		  = fake_pmu,
+		.fake_tp		  = fake_tp,
+		.pmu_filter		  = pmu_filter,
+		.cputype_filter		  = cputype_filter,
 		.match_legacy_cache_terms = true,
 	};
 	int ret, ret2;
@@ -2312,8 +2317,8 @@ int __parse_events(struct evlist *evlist, const char *str, const char *pmu_filte
 	}
 
 	ret2 = parse_events__sort_events_and_fix_groups(&parse_state.list);
-	if (ret2 < 0)
-		return ret;
+	if (ret2 < 0 && !ret)
+		ret = ret2;
 
 	/*
 	 * Add list to the evlist even with errors to allow callers to clean up.
@@ -2518,8 +2523,9 @@ int parse_events_option(const struct option *opt, const char *str,
 	int ret;
 
 	parse_events_error__init(&err);
-	ret = __parse_events(*args->evlistp, str, args->pmu_filter, &err,
-			     /*fake_pmu=*/false, /*warn_if_reordered=*/true,
+	ret = __parse_events(*args->evlistp, str, args->pmu_filter,
+			     args->cputype_filter, &err, /*fake_pmu=*/false,
+			     /*warn_if_reordered=*/true,
 			     /*fake_tp=*/false);
 
 	if (ret) {
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index 3577ab213730..b14c832b03a1 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -26,20 +26,23 @@ const char *event_type(size_t type);
 struct parse_events_option_args {
 	struct evlist **evlistp;
 	const char *pmu_filter;
+	bool cputype_filter;
 };
 int parse_events_option(const struct option *opt, const char *str, int unset);
 int parse_events_option_new_evlist(const struct option *opt, const char *str, int unset);
-__attribute__((nonnull(1, 2, 4)))
-int __parse_events(struct evlist *evlist, const char *str, const char *pmu_filter,
-		   struct parse_events_error *error, bool fake_pmu,
-		   bool warn_if_reordered, bool fake_tp);
+__attribute__((nonnull(1, 2, 5))) int
+__parse_events(struct evlist *evlist, const char *str, const char *pmu_filter,
+	       bool cputype_filter, struct parse_events_error *error,
+	       bool fake_pmu, bool warn_if_reordered, bool fake_tp);
 
 __attribute__((nonnull(1, 2, 3)))
 static inline int parse_events(struct evlist *evlist, const char *str,
 			       struct parse_events_error *err)
 {
-	return __parse_events(evlist, str, /*pmu_filter=*/NULL, err, /*fake_pmu=*/false,
-			      /*warn_if_reordered=*/true, /*fake_tp=*/false);
+	return __parse_events(evlist, str, /*pmu_filter=*/NULL,
+			      /*cputype_filter=*/false, err, /*fake_pmu=*/false,
+			      /*warn_if_reordered=*/true,
+			      /*fake_tp=*/false);
 }
 
 int parse_event(struct evlist *evlist, const char *str);
@@ -161,6 +164,8 @@ struct parse_events_state {
 	bool			   fake_tp;
 	/* If non-null, when wildcard matching only match the given PMU. */
 	const char		  *pmu_filter;
+	/* If true, the pmu_filter was set by --cputype option. */
+	bool cputype_filter;
 	/* Should PE_LEGACY_NAME tokens be generated for config terms? */
 	bool			   match_legacy_cache_terms;
 	/* Were multiple PMUs scanned to find events? */
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index cc1019d29a5d..63067ade4cbd 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -2104,7 +2104,8 @@ static PyObject *pyrf__parse_metrics(PyObject *self, PyObject *args)
 	cpus = pcpus ? ((struct pyrf_cpu_map *)pcpus)->cpus : NULL;
 
 	evlist__init(&evlist, cpus, threads);
-	ret = metricgroup__parse_groups(&evlist, pmu ?: "all", input,
+	ret = metricgroup__parse_groups(&evlist, pmu ?: "all",
+					/*cputype_filter=*/false, input,
 					/*metric_no_group=*/ false,
 					/*metric_no_merge=*/ false,
 					/*metric_no_threshold=*/ true,
-- 
2.54.0.1189.g8c84645362-goog

