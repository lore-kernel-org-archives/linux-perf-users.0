Received: from submarine.notk.org (62-210-214-84.rev.poneytelecom.eu [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA66129E86;
	Thu,  9 May 2024 22:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715293511; cv=none; b=pInhAkVQGf52Bsbmn3TcYrmagzKt9iQVyjvIsn+FfprDD+kxzPdk4JGJEAZcF4MEa6TKq4/1cGvpnn9WPHcvLhq5RMq74TNaSnughLR9zG7TOT3ajmfK3cmtcMdWh6WxcE0S8j9YJ8IvGFgdHu2ai/naTc7/oCldBNAj9oqDeg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715293511; c=relaxed/simple;
	bh=fN4ufz3Y1kRTbivEXYzNImgKWuIAekp2n+qBPkJublU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Hz5XhBPMuLLyLR2Sz+0Q12J+b5V9NVJ8AtURRf6aQXDNNDuyE2SKXhYKElprDoDhwVsqnwfMyHyLe4kcSvPKSxJS3wXZ+bnRUjO+pup7eQ63ave2Onm47wpp102bxxmfkAvbvo7j2ad0QKEFPDBZ27MY4aOEYlbEowhNG1E/G0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=oQZBv+O7; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="oQZBv+O7"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 287AF14C2DD;
	Fri, 10 May 2024 00:25:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1715293507;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5V9r1VV+2F+sgHWeR0/4ne1F1lK/DMZyCeDq+XDAAW8=;
	b=oQZBv+O7GbH/tqFTALDmDlWU4Zukrz1lX1F+JF8IxkJ3VtvcphIeJnPWnfoyHHCr0YfqiS
	aWvVZhxM7lmnr3dnI+xC6oqT6FfCDI/MCc2zhJs3UFLerL8SpJ0wAgqYHBo8eM5UMrZNFi
	CZ1CDRo9HuZ0sIsxCokArcZdzFacNIgBifaN6Tjpx1g7LyZWoLVttUnAkwmAcqdL3Oihv4
	J8l1cYvJ/AFR111GLZBDBRc7Z1s7iF2XmIeHkviVlILz5NEpqF6FjpREB96i3ow+lZ7yHV
	o19yMkx8K5v4/EdS8wU+3DYl2DOdu/FnnsGHcQQIyFvyZcLIFeLepRur68xMSw==
Received: from [127.0.0.1] (localhost.lan [::1])
	by gaia.codewreck.org (OpenSMTPD) with ESMTP id 32a8a39f;
	Thu, 9 May 2024 22:24:55 +0000 (UTC)
From: Dominique Martinet <asmadeus@codewreck.org>
Date: Fri, 10 May 2024 07:24:31 +0900
Subject: [PATCH v4 2/3] perf parse-events: Add new 'fake_tp' parameter for
 tests
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240510-perf_digit-v4-2-db1553f3233b@codewreck.org>
References: <20240510-perf_digit-v4-0-db1553f3233b@codewreck.org>
In-Reply-To: <20240510-perf_digit-v4-0-db1553f3233b@codewreck.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dominique Martinet <asmadeus@codewreck.org>
X-Mailer: b4 0.14-dev-87f09
X-Developer-Signature: v=1; a=openpgp-sha256; l=9031;
 i=asmadeus@codewreck.org; h=from:subject:message-id;
 bh=fN4ufz3Y1kRTbivEXYzNImgKWuIAekp2n+qBPkJublU=;
 b=owEBbQKS/ZANAwAIAatOm+xqmOZwAcsmYgBmPU02zQ/qevNCFDcC5biLweAND2R0o9k/T94sQ
 GKYjORpMuWJAjMEAAEIAB0WIQT8g9txgG5a3TOhiE6rTpvsapjmcAUCZj1NNgAKCRCrTpvsapjm
 cOW4EAC6ZeG2sJ+xJDWQuBzNdR2wjb5AauAdgteELZY2vo3bbkfq1/sWOpABga/ef5ad13ptRs9
 R9yBkllCYdIvyL5FmcKT82qieL8Kn49/nhnRBASq88JIX8JlMXJ9CdBGhnmu606QMkBthB/yDsR
 Rw6NttyAGgNizc/qa8/Sffen2eZsd/lTK6W+zAzKdBoW4+0Oon1M5Tuu153lVa8kEkjob8ICvTA
 oVP5YmQ5UTLWcIb+MIDh38wot5pdQ8vMycNdhNYVGx4rk6H9XfKgqpg1rF0dyFiL0uTlAF7BVmu
 MYjfG2uW6/KEx+dVcpgJiOi50GH9TeQb9kYMLuXG79W8nD9388XccRAcgm0gy4a106rdpKQAqZ6
 YuJIET8wQOod2LKi7ZRbm1akJmkr1BGaAtmv25oivAhniKjqRbjkIGtztSQeNi7HjB8+f7u15lo
 dL9BCRBOWdRDf9y1MZumptAO7PA0E4fJEOKuCBjoODk9jOpQFeW9VIZKXNVS6QlbW2t3u7Esyam
 ZH1w4Sjq6G4u3M4FtX989MaRYTXwq3RtRrzPoIJhym+kGpJRkAOAXO2ZpUVTXjWhzgUpW+H29tb
 Tf28EhjmgXWDUDXdivmRqwN+Hp8GuJTbepIG2Et9w0b6EG+xUaQcppQ4wYVY77O33Z30bi2Hkst
 Kp0//e/d0csnomA==
X-Developer-Key: i=asmadeus@codewreck.org; a=openpgp;
 fpr=B894379F662089525B3FB1B9333F1F391BBBB00A

The next commit will allow tracepoints starting with digits, but most
systems do not have any available by default so tests should skip the
actual "check if it exists in /sys/kernel/debug/tracing" step.

In order to do that, add a new boolean flag specifying if we should
actually "format" the probe or not.

Originally-by: Jiri Olsa <jolsa@kernel.org>
Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
---
 tools/perf/tests/parse-events.c |  6 ++++--
 tools/perf/tests/pmu-events.c   |  2 +-
 tools/perf/util/evlist.c        |  3 ++-
 tools/perf/util/evsel.c         | 20 +++++++++++++-------
 tools/perf/util/evsel.h         |  4 ++--
 tools/perf/util/metricgroup.c   |  3 ++-
 tools/perf/util/parse-events.c  |  9 ++++++---
 tools/perf/util/parse-events.h  |  6 ++++--
 8 files changed, 34 insertions(+), 19 deletions(-)

diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index 993e482f094c..c3b77570bb57 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -2493,7 +2493,8 @@ static int test_event(const struct evlist_test *e)
 		return TEST_FAIL;
 	}
 	parse_events_error__init(&err);
-	ret = parse_events(evlist, e->name, &err);
+	ret = __parse_events(evlist, e->name, /*pmu_filter=*/NULL, &err, /*fake_pmu=*/NULL,
+			     /*warn_if_reordered=*/true, /*fake_tp=*/true);
 	if (ret) {
 		pr_debug("failed to parse event '%s', err %d\n", e->name, ret);
 		parse_events_error__print(&err, e->name);
@@ -2521,7 +2522,8 @@ static int test_event_fake_pmu(const char *str)
 
 	parse_events_error__init(&err);
 	ret = __parse_events(evlist, str, /*pmu_filter=*/NULL, &err,
-			     &perf_pmu__fake, /*warn_if_reordered=*/true);
+			     &perf_pmu__fake, /*warn_if_reordered=*/true,
+			     /*fake_tp=*/true);
 	if (ret) {
 		pr_debug("failed to parse event '%s', err %d\n",
 			 str, ret);
diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
index f39aadacd7a6..ff3e7bc0a77f 100644
--- a/tools/perf/tests/pmu-events.c
+++ b/tools/perf/tests/pmu-events.c
@@ -842,7 +842,7 @@ static int check_parse_id(const char *id, struct parse_events_error *error,
 		*cur = '/';
 
 	ret = __parse_events(evlist, dup, /*pmu_filter=*/NULL, error, fake_pmu,
-			     /*warn_if_reordered=*/true);
+			     /*warn_if_reordered=*/true, /*fake_tp=*/false);
 	free(dup);
 
 	evlist__delete(evlist);
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 55a300a0977b..3a719edafc7a 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -298,7 +298,8 @@ struct evsel *evlist__add_aux_dummy(struct evlist *evlist, bool system_wide)
 #ifdef HAVE_LIBTRACEEVENT
 struct evsel *evlist__add_sched_switch(struct evlist *evlist, bool system_wide)
 {
-	struct evsel *evsel = evsel__newtp_idx("sched", "sched_switch", 0);
+	struct evsel *evsel = evsel__newtp_idx("sched", "sched_switch", 0,
+					       /*format=*/true);
 
 	if (IS_ERR(evsel))
 		return evsel;
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 3536404e9447..4f818ab6b662 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -452,7 +452,7 @@ struct evsel *evsel__clone(struct evsel *orig)
  * Returns pointer with encoded error via <linux/err.h> interface.
  */
 #ifdef HAVE_LIBTRACEEVENT
-struct evsel *evsel__newtp_idx(const char *sys, const char *name, int idx)
+struct evsel *evsel__newtp_idx(const char *sys, const char *name, int idx, bool format)
 {
 	struct evsel *evsel = zalloc(perf_evsel__object.size);
 	int err = -ENOMEM;
@@ -469,14 +469,20 @@ struct evsel *evsel__newtp_idx(const char *sys, const char *name, int idx)
 		if (asprintf(&evsel->name, "%s:%s", sys, name) < 0)
 			goto out_free;
 
-		evsel->tp_format = trace_event__tp_format(sys, name);
-		if (IS_ERR(evsel->tp_format)) {
-			err = PTR_ERR(evsel->tp_format);
-			goto out_free;
+		event_attr_init(&attr);
+
+		if (format) {
+			evsel->tp_format = trace_event__tp_format(sys, name);
+			if (IS_ERR(evsel->tp_format)) {
+				err = PTR_ERR(evsel->tp_format);
+				goto out_free;
+			}
+			attr.config = evsel->tp_format->id;
+		} else {
+			attr.config = (__u64) -1;
 		}
 
-		event_attr_init(&attr);
-		attr.config = evsel->tp_format->id;
+
 		attr.sample_period = 1;
 		evsel__init(evsel, &attr, idx);
 	}
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 517cff431de2..375a38e15cd9 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -234,14 +234,14 @@ void free_config_terms(struct list_head *config_terms);
 
 
 #ifdef HAVE_LIBTRACEEVENT
-struct evsel *evsel__newtp_idx(const char *sys, const char *name, int idx);
+struct evsel *evsel__newtp_idx(const char *sys, const char *name, int idx, bool format);
 
 /*
  * Returns pointer with encoded error via <linux/err.h> interface.
  */
 static inline struct evsel *evsel__newtp(const char *sys, const char *name)
 {
-	return evsel__newtp_idx(sys, name, 0);
+	return evsel__newtp_idx(sys, name, 0, true);
 }
 #endif
 
diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 9be406524617..69f6a46402c3 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -1502,7 +1502,8 @@ static int parse_ids(bool metric_no_merge, struct perf_pmu *fake_pmu,
 	pr_debug("Parsing metric events '%s'\n", events.buf);
 	parse_events_error__init(&parse_error);
 	ret = __parse_events(parsed_evlist, events.buf, /*pmu_filter=*/NULL,
-			     &parse_error, fake_pmu, /*warn_if_reordered=*/false);
+			     &parse_error, fake_pmu, /*warn_if_reordered=*/false,
+			     /*fake_tp=*/false);
 	if (ret) {
 		parse_events_error__print(&parse_error, events.buf);
 		goto err_out;
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index e6a2a80b02df..30f958069076 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -550,7 +550,8 @@ static int add_tracepoint(struct parse_events_state *parse_state,
 			  struct parse_events_terms *head_config, void *loc_)
 {
 	YYLTYPE *loc = loc_;
-	struct evsel *evsel = evsel__newtp_idx(sys_name, evt_name, parse_state->idx++);
+	struct evsel *evsel = evsel__newtp_idx(sys_name, evt_name, parse_state->idx++,
+					       !parse_state->fake_tp);
 
 	if (IS_ERR(evsel)) {
 		tracepoint_error(err, PTR_ERR(evsel), sys_name, evt_name, loc->first_column);
@@ -2135,7 +2136,7 @@ static int parse_events__sort_events_and_fix_groups(struct list_head *list)
 
 int __parse_events(struct evlist *evlist, const char *str, const char *pmu_filter,
 		   struct parse_events_error *err, struct perf_pmu *fake_pmu,
-		   bool warn_if_reordered)
+		   bool warn_if_reordered, bool fake_tp)
 {
 	struct parse_events_state parse_state = {
 		.list	  = LIST_HEAD_INIT(parse_state.list),
@@ -2143,6 +2144,7 @@ int __parse_events(struct evlist *evlist, const char *str, const char *pmu_filte
 		.error	  = err,
 		.stoken	  = PE_START_EVENTS,
 		.fake_pmu = fake_pmu,
+		.fake_tp  = fake_tp,
 		.pmu_filter = pmu_filter,
 		.match_legacy_cache_terms = true,
 	};
@@ -2352,7 +2354,8 @@ int parse_events_option(const struct option *opt, const char *str,
 
 	parse_events_error__init(&err);
 	ret = __parse_events(*args->evlistp, str, args->pmu_filter, &err,
-			     /*fake_pmu=*/NULL, /*warn_if_reordered=*/true);
+			     /*fake_pmu=*/NULL, /*warn_if_reordered=*/true,
+			     /*fake_tp=*/false);
 
 	if (ret) {
 		parse_events_error__print(&err, str);
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index c06984bd3af8..f2baa69fff98 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -32,14 +32,14 @@ int parse_events_option_new_evlist(const struct option *opt, const char *str, in
 __attribute__((nonnull(1, 2, 4)))
 int __parse_events(struct evlist *evlist, const char *str, const char *pmu_filter,
 		   struct parse_events_error *error, struct perf_pmu *fake_pmu,
-		   bool warn_if_reordered);
+		   bool warn_if_reordered, bool fake_tp);
 
 __attribute__((nonnull(1, 2, 3)))
 static inline int parse_events(struct evlist *evlist, const char *str,
 			       struct parse_events_error *err)
 {
 	return __parse_events(evlist, str, /*pmu_filter=*/NULL, err, /*fake_pmu=*/NULL,
-			      /*warn_if_reordered=*/true);
+			      /*warn_if_reordered=*/true, /*fake_tp=*/false);
 }
 
 int parse_event(struct evlist *evlist, const char *str);
@@ -152,6 +152,8 @@ struct parse_events_state {
 	int			   stoken;
 	/* Special fake PMU marker for testing. */
 	struct perf_pmu		  *fake_pmu;
+	/* Skip actual tracepoint processing for testing. */
+	bool			   fake_tp;
 	/* If non-null, when wildcard matching only match the given PMU. */
 	const char		  *pmu_filter;
 	/* Should PE_LEGACY_NAME tokens be generated for config terms? */

-- 
2.44.0

