Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D2812FB34
	for <linux-perf-users@vger.kernel.org>; Sat,  7 Sep 2024 05:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725685727; cv=none; b=naU0NUxu/hYZiRoxCr3AoQfaUinkq6JEWMS86OFYdcUt7il5idh8PThiYHUu42WC5mCnGjvEo1c/p4XV9xu4RVIQXzf2MOJSQadng+Qbg2u149UPqm0kPkgCh1XlXD+xBJrGc+xfRJAinG0LBlkffkGW3jCvkQD3/19hC/w5ZFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725685727; c=relaxed/simple;
	bh=2GbShflx1OPw5Hbs1ieTu8gN+brQN8XBGn8Xey2e14o=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=tCdgLk9WhwmWr8rq10dFxPy6XeAM6Q1TiwjGecpe6ma1zTQH/4n/ymHEAN8GKm0qQ3HyYWRCyIe9+wlMGk6qpCNdpGbOvGOBvPk0uAkV1zGnjmx38I6TaU1qhznHrNKSTb1cIf+ojzz3b+LSnHFj2/Gj3NRSpyk4z6KJVuSr0/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tx/aTRk5; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tx/aTRk5"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6d3e062dbeeso70670277b3.0
        for <linux-perf-users@vger.kernel.org>; Fri, 06 Sep 2024 22:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725685725; x=1726290525; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4qvnGpoqY98o8DkcV53COwqz0b4ydGD421TbHN+KxuU=;
        b=tx/aTRk5O4VXSZbhVrcjA0Q2KNdxlaFmE4yr60imD7Bhrbs8MhbxePi74+GY9BV914
         Y6QFTLbW6gbu0DJVbsn+2NDIL6453r2+f3vIyCX5ahQFF852MZ/y7xDKKP2YZ2V7vf73
         0ToLEFfCwyBvXICRZ91AS5VSamJDVC/i7lG2rlcmHLt3M/qRzEiXhRKrMMxzNzuRD+R9
         zV2bgz4O2AIpg9d+nIDeVypgzMSVFFbiF6jwPvJOEDJEXQXr5W2Twdr8vZ5AccCVNFjy
         Beozr+iOIj+X3uOnRqOEDMIJzRxkEC8CmVU2gosUKiKzfNlR/ymIr/SxoMALrfdRA+FQ
         MxnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725685725; x=1726290525;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4qvnGpoqY98o8DkcV53COwqz0b4ydGD421TbHN+KxuU=;
        b=TfRrsqCvASCDyhbT8MLcrGVGVu4tX0+TRVLodTAs51wdeOV5mJmWD1YgAzLrYsUkYA
         AdXITRkrWnPyBULjPnsAXMq2QQPAvSziepva0nHBW3KmJJAK6lFNzBpSOdm9zT5wpTsd
         8D2O/7BqxC5Nq7pnM4hUXWxZsPOSEAWGNQJDkGA5biREb1ia7HhHiJp2eaGrAOmssy7+
         USuTkzKqC0Qt3K0poCXZbO4lNA6TbZj85wIhBjAKgIB9yu8mXjz20b2U9+tEIGLVmN1v
         CLaDJq0zfZk0eymWFGAau8nN4nZI+cw8lW2ctuv3UwTkCe1e7pBazTa1LBvLOtRrl/bE
         l0FA==
X-Forwarded-Encrypted: i=1; AJvYcCVvMBLriRB8hxdoykgSraEixz8JXN55tUpEANvOLiiH468pTiHbZVSPGOYnQOrpKUNBIPPLgxioz5nmYwXYDwdC@vger.kernel.org
X-Gm-Message-State: AOJu0YxWTAyVs2slgS+Z8crVFN2Iy8VJ0IMpDXNKIL+06l2bzxSkAG/p
	hYDvxAvIvN0BOFqKS5BJIlfi8ETy++pWe4ywwwfaFC+mJiEhKx3XL5eXIYtLL2zZpBRKPZlBqNU
	D/fhOjw==
X-Google-Smtp-Source: AGHT+IHXWJ46JY3jkQNVeV0QMNhgFfqcqA+JJTd2bTX6fyr7eZn1QoFO0U14ouPnFLalZCsSfINQHClIb6Lf
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:90e5:a813:c3d3:daed])
 (user=irogers job=sendgmr) by 2002:a05:690c:4b85:b0:6a1:741b:b723 with SMTP
 id 00721157ae682-6db2606a8fbmr6772437b3.5.1725685724868; Fri, 06 Sep 2024
 22:08:44 -0700 (PDT)
Date: Fri,  6 Sep 2024 22:08:17 -0700
In-Reply-To: <20240907050830.6752-1-irogers@google.com>
Message-Id: <20240907050830.6752-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240907050830.6752-1-irogers@google.com>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Subject: [PATCH v1 02/15] perf pmus: Fake PMU clean up
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Weilin Wang <weilin.wang@intel.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Xu Yang <xu.yang_2@nxp.com>, 
	Sandipan Das <sandipan.das@amd.com>, Benjamin Gray <bgray@linux.ibm.com>, 
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>, Howard Chu <howardchu95@gmail.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, Yang Jihong <yangjihong@bytedance.com>, 
	Colin Ian King <colin.i.king@gmail.com>, Veronika Molnarova <vmolnaro@redhat.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Changbin Du <changbin.du@huawei.com>, Ze Gao <zegao2021@gmail.com>, 
	Andi Kleen <ak@linux.intel.com>, 
	"=?UTF-8?q?Cl=C3=A9ment=20Le=20Goffic?=" <clement.legoffic@foss.st.com>, Sun Haiyong <sunhaiyong@loongson.cn>, 
	Junhao He <hejunhao3@huawei.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	Yicong Yang <yangyicong@hisilicon.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Rather than passing a fake PMU around, just pass that the fake PMU
should be used - true when doing testing. Move the fake PMU into
pmus.[ch] and try to abstract the PMU's properties in pmu.c, ie so
there is less "if fake_pmu" in non-PMU code. Give the fake PMU a made
up type number.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/parse-events.c |  4 ++--
 tools/perf/tests/pmu-events.c   | 12 +++++-------
 tools/perf/util/metricgroup.c   | 10 +++++-----
 tools/perf/util/parse-events.c  | 33 +++++++++++++++++----------------
 tools/perf/util/parse-events.h  |  8 ++++----
 tools/perf/util/pmu.c           | 21 +++++++++++++++------
 tools/perf/util/pmu.h           |  7 ++++---
 tools/perf/util/pmus.c          | 11 +++++++++++
 tools/perf/util/pmus.h          |  1 +
 9 files changed, 64 insertions(+), 43 deletions(-)

diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index edc2adcf1bae..a9a77dfe0e97 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -2500,7 +2500,7 @@ static int test_event(const struct evlist_test *e)
 		return TEST_FAIL;
 	}
 	parse_events_error__init(&err);
-	ret = __parse_events(evlist, e->name, /*pmu_filter=*/NULL, &err, /*fake_pmu=*/NULL,
+	ret = __parse_events(evlist, e->name, /*pmu_filter=*/NULL, &err, /*fake_pmu=*/false,
 			     /*warn_if_reordered=*/true, /*fake_tp=*/true);
 	if (ret) {
 		pr_debug("failed to parse event '%s', err %d\n", e->name, ret);
@@ -2529,7 +2529,7 @@ static int test_event_fake_pmu(const char *str)
 
 	parse_events_error__init(&err);
 	ret = __parse_events(evlist, str, /*pmu_filter=*/NULL, &err,
-			     &perf_pmu__fake, /*warn_if_reordered=*/true,
+			     /*fake_pmu=*/true, /*warn_if_reordered=*/true,
 			     /*fake_tp=*/true);
 	if (ret) {
 		pr_debug("failed to parse event '%s', err %d\n",
diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
index ff3e7bc0a77f..db004d26fcb0 100644
--- a/tools/perf/tests/pmu-events.c
+++ b/tools/perf/tests/pmu-events.c
@@ -819,8 +819,7 @@ static bool is_number(const char *str)
 	return errno == 0 && end_ptr != str;
 }
 
-static int check_parse_id(const char *id, struct parse_events_error *error,
-			  struct perf_pmu *fake_pmu)
+static int check_parse_id(const char *id, struct parse_events_error *error)
 {
 	struct evlist *evlist;
 	int ret;
@@ -841,7 +840,7 @@ static int check_parse_id(const char *id, struct parse_events_error *error,
 	for (cur = strchr(dup, '@') ; cur; cur = strchr(++cur, '@'))
 		*cur = '/';
 
-	ret = __parse_events(evlist, dup, /*pmu_filter=*/NULL, error, fake_pmu,
+	ret = __parse_events(evlist, dup, /*pmu_filter=*/NULL, error, /*fake_pmu=*/true,
 			     /*warn_if_reordered=*/true, /*fake_tp=*/false);
 	free(dup);
 
@@ -855,7 +854,7 @@ static int check_parse_fake(const char *id)
 	int ret;
 
 	parse_events_error__init(&error);
-	ret = check_parse_id(id, &error, &perf_pmu__fake);
+	ret = check_parse_id(id, &error);
 	parse_events_error__exit(&error);
 	return ret;
 }
@@ -1051,9 +1050,8 @@ static int test__parsing_fake_callback(const struct pmu_metric *pm,
 }
 
 /*
- * Parse all the metrics for current architecture,
- * or all defined cpus via the 'fake_pmu'
- * in parse_events.
+ * Parse all the metrics for current architecture, or all defined cpus via the
+ * 'fake_pmu' in parse_events.
  */
 static int test__parsing_fake(struct test_suite *test __maybe_unused,
 			      int subtest __maybe_unused)
diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 69f6a46402c3..4dff3e925a47 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -1436,7 +1436,7 @@ static int build_combined_expr_ctx(const struct list_head *metric_list,
  * parse_ids - Build the event string for the ids and parse them creating an
  *             evlist. The encoded metric_ids are decoded.
  * @metric_no_merge: is metric sharing explicitly disabled.
- * @fake_pmu: used when testing metrics not supported by the current CPU.
+ * @fake_pmu: use a fake PMU when testing metrics not supported by the current CPU.
  * @ids: the event identifiers parsed from a metric.
  * @modifier: any modifiers added to the events.
  * @group_events: should events be placed in a weak group.
@@ -1444,7 +1444,7 @@ static int build_combined_expr_ctx(const struct list_head *metric_list,
  *               the overall list of metrics.
  * @out_evlist: the created list of events.
  */
-static int parse_ids(bool metric_no_merge, struct perf_pmu *fake_pmu,
+static int parse_ids(bool metric_no_merge, bool fake_pmu,
 		     struct expr_parse_ctx *ids, const char *modifier,
 		     bool group_events, const bool tool_events[PERF_TOOL_MAX],
 		     struct evlist **out_evlist)
@@ -1528,7 +1528,7 @@ static int parse_groups(struct evlist *perf_evlist,
 			bool metric_no_threshold,
 			const char *user_requested_cpu_list,
 			bool system_wide,
-			struct perf_pmu *fake_pmu,
+			bool fake_pmu,
 			struct rblist *metric_events_list,
 			const struct pmu_metrics_table *table)
 {
@@ -1703,7 +1703,7 @@ int metricgroup__parse_groups(struct evlist *perf_evlist,
 
 	return parse_groups(perf_evlist, pmu, str, metric_no_group, metric_no_merge,
 			    metric_no_threshold, user_requested_cpu_list, system_wide,
-			    /*fake_pmu=*/NULL, metric_events, table);
+			    /*fake_pmu=*/false, metric_events, table);
 }
 
 int metricgroup__parse_groups_test(struct evlist *evlist,
@@ -1717,7 +1717,7 @@ int metricgroup__parse_groups_test(struct evlist *evlist,
 			    /*metric_no_threshold=*/false,
 			    /*user_requested_cpu_list=*/NULL,
 			    /*system_wide=*/false,
-			    &perf_pmu__fake, metric_events, table);
+			    /*fake_pmu=*/true, metric_events, table);
 }
 
 struct metricgroup__has_metric_data {
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index fab01ba54e34..081ceff467f2 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1478,8 +1478,8 @@ static int parse_events_add_pmu(struct parse_events_state *parse_state,
 	}
 
 	/* Look for event names in the terms and rewrite into format based terms. */
-	if (!parse_state->fake_pmu && perf_pmu__check_alias(pmu, &parsed_terms,
-							    &info, &alias_rewrote_terms, err)) {
+	if (perf_pmu__check_alias(pmu, &parsed_terms,
+				  &info, &alias_rewrote_terms, err)) {
 		parse_events_terms__exit(&parsed_terms);
 		return -EINVAL;
 	}
@@ -1515,8 +1515,7 @@ static int parse_events_add_pmu(struct parse_events_state *parse_state,
 		return -ENOMEM;
 	}
 
-	if (!parse_state->fake_pmu &&
-	    perf_pmu__config(pmu, &attr, &parsed_terms, parse_state->error)) {
+	if (perf_pmu__config(pmu, &attr, &parsed_terms, parse_state->error)) {
 		free_config_terms(&config_terms);
 		parse_events_terms__exit(&parsed_terms);
 		return -EINVAL;
@@ -1536,11 +1535,6 @@ static int parse_events_add_pmu(struct parse_events_state *parse_state,
 
 	evsel->percore = config_term_percore(&evsel->config_terms);
 
-	if (parse_state->fake_pmu) {
-		parse_events_terms__exit(&parsed_terms);
-		return 0;
-	}
-
 	parse_events_terms__exit(&parsed_terms);
 	free((char *)evsel->unit);
 	evsel->unit = strdup(info.unit);
@@ -1616,13 +1610,13 @@ int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
 	}
 
 	if (parse_state->fake_pmu) {
-		if (!parse_events_add_pmu(parse_state, list, parse_state->fake_pmu, &parsed_terms,
+		if (!parse_events_add_pmu(parse_state, list, perf_pmus__fake_pmu(), &parsed_terms,
 					  /*auto_merge_stats=*/true)) {
 			struct strbuf sb;
 
 			strbuf_init(&sb, /*hint=*/ 0);
 			parse_events_terms__to_strbuf(&parsed_terms, &sb);
-			pr_debug("%s -> %s/%s/\n", event_name, "fake_pmu", sb.buf);
+			pr_debug("%s -> fake/%s/\n", event_name, sb.buf);
 			strbuf_release(&sb);
 			ok++;
 		}
@@ -1656,11 +1650,18 @@ int parse_events_multi_pmu_add_or_add_pmu(struct parse_events_state *parse_state
 	INIT_LIST_HEAD(*listp);
 
 	/* Attempt to add to list assuming event_or_pmu is a PMU name. */
-	pmu = parse_state->fake_pmu ?: perf_pmus__find(event_or_pmu);
+	pmu = perf_pmus__find(event_or_pmu);
 	if (pmu && !parse_events_add_pmu(parse_state, *listp, pmu, const_parsed_terms,
 					/*auto_merge_stats=*/false))
 		return 0;
 
+	if (parse_state->fake_pmu) {
+		if (!parse_events_add_pmu(parse_state, *listp, perf_pmus__fake_pmu(),
+					  const_parsed_terms,
+					  /*auto_merge_stats=*/false))
+			return 0;
+	}
+
 	pmu = NULL;
 	/* Failed to add, try wildcard expansion of event_or_pmu as a PMU name. */
 	while ((pmu = perf_pmus__scan(pmu)) != NULL) {
@@ -1961,8 +1962,8 @@ static int evsel__compute_group_pmu_name(struct evsel *evsel,
 			}
 		}
 	}
-	/* Assign the actual name taking care that the fake PMU lacks a name. */
-	evsel->group_pmu_name = strdup(group_pmu_name ?: "fake");
+	/* Record computed name. */
+	evsel->group_pmu_name = strdup(group_pmu_name);
 	return evsel->group_pmu_name ? 0 : -ENOMEM;
 }
 
@@ -2124,7 +2125,7 @@ static int parse_events__sort_events_and_fix_groups(struct list_head *list)
 }
 
 int __parse_events(struct evlist *evlist, const char *str, const char *pmu_filter,
-		   struct parse_events_error *err, struct perf_pmu *fake_pmu,
+		   struct parse_events_error *err, bool fake_pmu,
 		   bool warn_if_reordered, bool fake_tp)
 {
 	struct parse_events_state parse_state = {
@@ -2343,7 +2344,7 @@ int parse_events_option(const struct option *opt, const char *str,
 
 	parse_events_error__init(&err);
 	ret = __parse_events(*args->evlistp, str, args->pmu_filter, &err,
-			     /*fake_pmu=*/NULL, /*warn_if_reordered=*/true,
+			     /*fake_pmu=*/false, /*warn_if_reordered=*/true,
 			     /*fake_tp=*/false);
 
 	if (ret) {
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index b735cd9e0acf..bfbf391451d9 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -31,14 +31,14 @@ int parse_events_option(const struct option *opt, const char *str, int unset);
 int parse_events_option_new_evlist(const struct option *opt, const char *str, int unset);
 __attribute__((nonnull(1, 2, 4)))
 int __parse_events(struct evlist *evlist, const char *str, const char *pmu_filter,
-		   struct parse_events_error *error, struct perf_pmu *fake_pmu,
+		   struct parse_events_error *error, bool fake_pmu,
 		   bool warn_if_reordered, bool fake_tp);
 
 __attribute__((nonnull(1, 2, 3)))
 static inline int parse_events(struct evlist *evlist, const char *str,
 			       struct parse_events_error *err)
 {
-	return __parse_events(evlist, str, /*pmu_filter=*/NULL, err, /*fake_pmu=*/NULL,
+	return __parse_events(evlist, str, /*pmu_filter=*/NULL, err, /*fake_pmu=*/false,
 			      /*warn_if_reordered=*/true, /*fake_tp=*/false);
 }
 
@@ -150,8 +150,8 @@ struct parse_events_state {
 	struct parse_events_terms *terms;
 	/* Start token. */
 	int			   stoken;
-	/* Special fake PMU marker for testing. */
-	struct perf_pmu		  *fake_pmu;
+	/* Use the fake PMU marker for testing. */
+	bool			   fake_pmu;
 	/* Skip actual tracepoint processing for testing. */
 	bool			   fake_tp;
 	/* If non-null, when wildcard matching only match the given PMU. */
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 0b38c51bd6eb..50e2e7abffab 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -30,10 +30,6 @@
 #include "util/evsel_config.h"
 #include <regex.h>
 
-struct perf_pmu perf_pmu__fake = {
-	.name = "fake",
-};
-
 #define UNIT_MAX_LEN	31 /* max length for event unit name */
 
 enum event_source {
@@ -1173,6 +1169,11 @@ struct perf_pmu *perf_pmu__create_placeholder_core_pmu(struct list_head *core_pm
 	return pmu;
 }
 
+static bool perf_pmu__is_fake(const struct perf_pmu *pmu)
+{
+	return pmu->type == PERF_PMU_TYPE_FAKE;
+}
+
 void perf_pmu__warn_invalid_formats(struct perf_pmu *pmu)
 {
 	struct perf_pmu_format *format;
@@ -1183,7 +1184,7 @@ void perf_pmu__warn_invalid_formats(struct perf_pmu *pmu)
 	pmu->formats_checked = true;
 
 	/* fake pmu doesn't have format list */
-	if (pmu == &perf_pmu__fake)
+	if (perf_pmu__is_fake(pmu))
 		return;
 
 	list_for_each_entry(format, &pmu->format, list) {
@@ -1511,6 +1512,10 @@ int perf_pmu__config(struct perf_pmu *pmu, struct perf_event_attr *attr,
 {
 	bool zero = !!pmu->perf_event_attr_init_default;
 
+	/* Fake PMU doesn't have proper terms so nothing to configure in attr. */
+	if (perf_pmu__is_fake(pmu))
+		return 0;
+
 	return perf_pmu__config_terms(pmu, attr, head_terms, zero, err);
 }
 
@@ -1619,6 +1624,10 @@ int perf_pmu__check_alias(struct perf_pmu *pmu, struct parse_events_terms *head_
 	info->scale    = 0.0;
 	info->snapshot = false;
 
+	/* Fake PMU doesn't rewrite terms. */
+	if (perf_pmu__is_fake(pmu))
+		goto out;
+
 	list_for_each_entry_safe(term, h, &head_terms->terms, list) {
 		alias = pmu_find_alias(pmu, term);
 		if (!alias)
@@ -1641,7 +1650,7 @@ int perf_pmu__check_alias(struct perf_pmu *pmu, struct parse_events_terms *head_
 		list_del_init(&term->list);
 		parse_events_term__delete(term);
 	}
-
+out:
 	/*
 	 * if no unit or scale found in aliases, then
 	 * set defaults as for evsel
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index b2d3fd291f02..d6f702e55a05 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -36,6 +36,10 @@ struct perf_pmu_caps {
 	struct list_head list;
 };
 
+enum {
+	PERF_PMU_TYPE_FAKE = 0xFFFFFFFF,
+};
+
 /**
  * struct perf_pmu
  */
@@ -173,9 +177,6 @@ struct perf_pmu {
 	struct perf_mem_event *mem_events;
 };
 
-/** @perf_pmu__fake: A special global PMU used for testing. */
-extern struct perf_pmu perf_pmu__fake;
-
 struct perf_pmu_info {
 	const char *unit;
 	double scale;
diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
index 3fcabfd8fca1..864cbfa1f960 100644
--- a/tools/perf/util/pmus.c
+++ b/tools/perf/util/pmus.c
@@ -720,3 +720,14 @@ struct perf_pmu *perf_pmus__add_test_pmu(int test_sysfs_dirfd, const char *name)
 	 */
 	return perf_pmu__lookup(&other_pmus, test_sysfs_dirfd, name, /*eager_load=*/true);
 }
+
+struct perf_pmu *perf_pmus__fake_pmu(void)
+{
+	static struct perf_pmu fake = {
+		.name = "fake",
+		.type = PERF_PMU_TYPE_FAKE,
+		.format = LIST_HEAD_INIT(fake.format),
+	};
+
+	return &fake;
+}
diff --git a/tools/perf/util/pmus.h b/tools/perf/util/pmus.h
index bdbff02324bb..e1742b56eec7 100644
--- a/tools/perf/util/pmus.h
+++ b/tools/perf/util/pmus.h
@@ -30,5 +30,6 @@ bool perf_pmus__supports_extended_type(void);
 char *perf_pmus__default_pmu_name(void);
 
 struct perf_pmu *perf_pmus__add_test_pmu(int test_sysfs_dirfd, const char *name);
+struct perf_pmu *perf_pmus__fake_pmu(void);
 
 #endif /* __PMUS_H */
-- 
2.46.0.469.g59c65b2a67-goog

