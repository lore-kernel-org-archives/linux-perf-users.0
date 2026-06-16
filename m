Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA55B373BEC
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 01:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781573141; cv=none; b=mBQ4GP5ZABUYdOI66sGrLkMVUDzHSWoKZEUjjG0reMzPAS+R5UPVFWt1Vgl4TJTFS/KFR6VC0Z0Ioss0Oy7tf4JU8wa4dLgmPbNMw7mpVCnipWKkuxb6LWgy5tNUajPdYHvqn6CHU3LeRkEz6psQGESefC//H5z+tQT0SgNIHRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781573141; c=relaxed/simple;
	bh=K/W1lVcpmya+VP9KdWG9uGD/EzSh1ZXCbuYeg3jRldQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=h8fTXiBE/L5NCa2i7EjrFciAksmLT1y9UsTpJE3EbPLcgGuStHuoy6GxkTFp+Kzjwtz+RRcc/f3ScWcJSWfHmxfCN7wIqCzlY/aAuKsbqPMEvOGqaXts+PpaAkjTVOmO0fpoRVIENhb8BzklN8NTqnZN1kyvCT0Ouc4bkbuG054=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ibo+vvO5; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ibo+vvO5"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-138156c0492so16371718c88.1
        for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 18:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781573139; x=1782177939; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LUruLglFpH/cC4DpeBHQDfJ1vbOPWeXDSJiNtb0u9ZY=;
        b=ibo+vvO5LpNCh23qS2Kd0CkMpoQkzirYEQog5nOeGZngP7OgqNemTEKjpsEr1fv0/B
         SkO2qUklpO+KnjcHJ56ONf7x49SGbtfcLmDKEK4xI1ENiCaFMNp23K7eGZhw1Mmu1uQi
         TWhhwbfI/NOcBiZ/RRvZmQ4y3umsj+GitvV8OAeHMowJKEVqpuNJscHDYWtOq727E/aM
         03jiiN4eZgoZXXfTTlHEjbfbpCYdhWizOUDpN7Vqh77ulErfIfiXvCmLXe5KfUea4l7h
         k0nFa/onIpDjYNrbANBKeXbERtiznIVFVnGqhll4gyKfU/0HdFKa3g6diyPseAhZlo0o
         7xcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781573139; x=1782177939;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LUruLglFpH/cC4DpeBHQDfJ1vbOPWeXDSJiNtb0u9ZY=;
        b=QTlv0+tiNTNwjyqUGCEV1+09N+RnWDrC+SBj60mqW0qlQUfCaKNSfttGtMp/cmMkFw
         83iukdGZxUyrrdQAIrWDvzCJNdpbR1sssEoH1VhCbaEEvUWR6OzWWr1zddnsW1g7GxnL
         Hoxwba6CRe7/l7kaV31etKfNhlFYs5YmJXx3+PWXN56oBpu9iAofVoPNqSRPpTazNHb1
         zUZ1cx9VFh9bBWb92RTAt660d+8kZZ1olwms1+l4DgUnaz4xhWUxHglND7G+D7qi1x+h
         GAx9TOvUFumOB/nVDim5+8zJIUNw0qyZmstRmYMIxKpIXljxZIOcP+1T7rb+PYmYXkkI
         CTYA==
X-Forwarded-Encrypted: i=1; AFNElJ/TEFkUSWUEkOcAqasrrvBlTXIC8Rpv8CdsoPIpUeo2RkrOLFpFRA8lfp4DUogT2gIHEFIVq4Z02uNM1Arqd0ub@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3DKJQkfUTWU2qxsXx9VzkAVdo6tb4DI/UUvRP2cNuUtzRs60Y
	1GaKkpCGYkMcGQihYfwAD4C2sGhFF09gO+fdz3xxhzjCpUMMbQi6SJTUUH62xwkXKZXYPRKXbOa
	C9hu7erS5Lg==
X-Received: from dyeq5.prod.google.com ([2002:a05:7300:42c5:b0:2f9:af7:504e])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:1a82:b0:12d:ea4f:99de
 with SMTP id a92af1059eb24-1384b976fb7mr7991939c88.0.1781573138439; Mon, 15
 Jun 2026 18:25:38 -0700 (PDT)
Date: Mon, 15 Jun 2026 18:25:10 -0700
In-Reply-To: <20260616012521.4045202-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260616012521.4045202-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260616012521.4045202-2-irogers@google.com>
Subject: [PATCH v1 01/12] perf parse-events: Restrict core PMU bypass to
 --cputype option
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Thomas Falcon <thomas.falcon@intel.com>, 
	Leo Yan <leo.yan@arm.com>, Thomas Richter <tmricht@linux.ibm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Commit b1c5efbfd92e ("perf parse-events: Remove hard coded legacy hardware
and cache parsing") introduced a bypass to PMU filtering to prevent uncore PMUs
from being filtered out during event parsing, which was required for resolving
`duration_time` and `uncore_freq` when running with `--cputype`. However, this
bypass was active whenever `pmu_filter` was set, which also incorrectly bypassed
filtering for the `--pmu-filter` option.

Introduce a `cputype_filter` boolean flag in `parse_events_state` and
`parse_events_option_args` to distinguish filtering initiated by `--cputype`
from that initiated by `--pmu-filter`. Restrict the core-only check in
`parse_events__filter_pmu()` to when `cputype_filter` is true.

Fixes: b1c5efbfd92e ("perf parse-events: Remove hard coded legacy hardware and cache parsing")
Signed-off-by: Ian Rogers <irogers@google.com>
TAG=agy
CONV=7e7ee33a-e940-4a8a-8e64-878da6a68b59
---
 tools/perf/builtin-stat.c       |  2 ++
 tools/perf/tests/parse-events.c | 11 +++++++----
 tools/perf/tests/pmu-events.c   |  6 ++++--
 tools/perf/util/metricgroup.c   |  4 +++-
 tools/perf/util/parse-events.c  | 22 ++++++++++++++--------
 tools/perf/util/parse-events.h  | 17 +++++++++++------
 6 files changed, 41 insertions(+), 21 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index a04466ea3b0a..cc682740dccb 100644
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
diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
index fd5630f0a13c..962bc101e967 100644
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
diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index c2ce3e53aaee..e9854d7bf07a 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -1317,7 +1317,9 @@ static int parse_ids(bool metric_no_merge, bool fake_pmu,
 	pr_debug("Parsing metric events '%s'\n", events.buf);
 	parse_events_error__init(&parse_error);
 	ret = __parse_events(parsed_evlist, events.buf, filter_pmu,
-			     &parse_error, fake_pmu, /*warn_if_reordered=*/false,
+			     /*cputype_filter=*/filter_pmu != NULL,
+			     &parse_error, fake_pmu,
+			     /*warn_if_reordered=*/false,
 			     /*fake_tp=*/false);
 	if (ret) {
 		parse_events_error__print(&parse_error, events.buf);
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 943569e82b82..9f64d5197b8a 100644
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
+		.list = LIST_HEAD_INIT(parse_state.list),
+		.idx = evlist->core.nr_entries,
+		.error = err,
+		.stoken = PE_START_EVENTS,
 		.fake_pmu = fake_pmu,
-		.fake_tp  = fake_tp,
+		.fake_tp = fake_tp,
 		.pmu_filter = pmu_filter,
+		.cputype_filter = cputype_filter,
 		.match_legacy_cache_terms = true,
 	};
 	int ret, ret2;
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
-- 
2.54.0.1136.gdb2ca164c4-goog

