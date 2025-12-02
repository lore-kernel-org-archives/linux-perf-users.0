Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E202D063A
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Dec 2025 17:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764697860; cv=none; b=bxsp0Z9TAqcg6kIg9zeZlV9ZTfCKI7ZQXhgvJVMFPnLL1WU+Y++H5CDPJQQNs9ytmXnyASc8L2fWYurK2yFmaVXLsFLZaRC5PSd9+s9BmiFLeBZJlzoMFkfXlNZSop5yre+Qbg+V8TkbUCExy5D7sMleItX/xvPGV4WtofX/Ldw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764697860; c=relaxed/simple;
	bh=4CvaCz7sbpDCz++WfvIXEkDI8xHMo6XbhLawTO7rjqo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=mn8sp60jCKVMQ5A/rXn65Q0ADG9KHUvP1SNCEb92Gz5PMkvrqUNyhvIwtwAG0WjRB8yx+Vh+U8GAaHR62/l4o4+lKUVAksq5gEyj9XS05sN8lv3xH8X1zXrLRcNSlL2FWJwW1WP46vOgCg4/RkaLRZBQkDz3zjFQAtAH9xLy2Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AvJ/Q2Xu; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AvJ/Q2Xu"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3416dc5752aso13705273a91.1
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Dec 2025 09:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764697858; x=1765302658; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DDGobjwIqYzfve+t1fxiKI0fetJRkLtvhmfsLaeAgOw=;
        b=AvJ/Q2XuSQ26SahLH1Xrf2m7bLrUnRQZS+KXZTsY8xfnVFu+sI2DMK2YBtSl7muUvK
         dIfhMxYIo/oDtXtzNhB0AZEB+q2QoUFdKBq3cnsclj552AjxLboJrP2dj7p3Z6Se93w4
         IrEezJHHT7IuNaScD1f7GUBx0Vpr7GT/sfzh58GgOJHNqlLoB+xsWJ9lZcknBjkCoZhl
         lTZsVAZSY3Bt0wyVx/numWn9CPj2Ljs6KUiGfmJZPj2gOSmNE+KI4arITGlewiUKQXdt
         JNT6nRHv5Xp89efORDWl35HxqnSGJZhMaxfF9SNCG1IBfwy+7MZzjOfJeeqVuvpGu1Em
         osqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764697858; x=1765302658;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DDGobjwIqYzfve+t1fxiKI0fetJRkLtvhmfsLaeAgOw=;
        b=LkzyZV5cjhBEoVL4g3R4qQvKTtKaIOE4DVy4CDvYkdQNyfDxme2gnBcDSGySWQo30U
         OWKc88/Y6VOifGr3zPRYVqIzbGipcjrqe2a6bzlEWnshEcy4kpAiDMXWWryKAM7GTYfc
         /g5b1pqMFrZ9o0mVfYKquhRwqt2jJLf9hV/VfvtgPDoESvjygnO9lOQGCAWztam0WGm6
         8hhve9XxyJH3gV+muk3FY14L6EVVx/oqbWvxMpGUbpzWAWa0s4r+ri2I9t7FGs+JB7K6
         OzDLIzqrh86cv68nKtmCMxaa7IW01O9++JnNsRJc/XPXsM9XPWoCtPk+aXai0yraNHjA
         rlGw==
X-Forwarded-Encrypted: i=1; AJvYcCUP+BUgsZdyyRbAq9UN/0h48Ad8gkfrgf7vS9ljub07P9QQj207QCosLw/vtzWwG/sjeIACzdahPFNYBlx+XhXl@vger.kernel.org
X-Gm-Message-State: AOJu0YzZiGwkEM8uJpdoDzrOjrP7Q2Anj7SrG06hRN3Ck+eNLXpNfypB
	m0F6Rhd7Y6bmDyAHaENklt1WNaCvDce30MW+FOgKkkrV15cokM1Md6zEPGtUdZRm1fKsWMTXgBa
	06t6mzQN9hg==
X-Google-Smtp-Source: AGHT+IFCmzu4P282ZrlfK9u3zPs89z4MHL3d7/7NBW74ANhLhqLty/ukvj63Nr6NGN5Cacuv5MkKFQ3iYgr8
X-Received: from dlee33.prod.google.com ([2002:a05:7022:62a1:b0:119:78ff:fe0f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:4423:b0:119:e56b:c745
 with SMTP id a92af1059eb24-11cb3ec27efmr24058630c88.10.1764697857614; Tue, 02
 Dec 2025 09:50:57 -0800 (PST)
Date: Tue,  2 Dec 2025 09:49:56 -0800
In-Reply-To: <20251202175043.623597-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251202175043.623597-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.158.g65b55ccf14-goog
Message-ID: <20251202175043.623597-2-irogers@google.com>
Subject: [PATCH v9 01/48] perf python: Correct copying of metric_leader in an evsel
From: Ian Rogers <irogers@google.com>
To: Adrian Hunter <adrian.hunter@intel.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Benjamin Gray <bgray@linux.ibm.com>, 
	Caleb Biggers <caleb.biggers@intel.com>, Edward Baker <edward.baker@intel.com>, 
	Ian Rogers <irogers@google.com>, Ingo Molnar <mingo@redhat.com>, 
	James Clark <james.clark@linaro.org>, Jing Zhang <renyu.zj@linux.alibaba.com>, 
	Jiri Olsa <jolsa@kernel.org>, John Garry <john.g.garry@oracle.com>, Leo Yan <leo.yan@arm.com>, 
	Namhyung Kim <namhyung@kernel.org>, Perry Taylor <perry.taylor@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Samantha Alt <samantha.alt@intel.com>, 
	Sandipan Das <sandipan.das@amd.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Weilin Wang <weilin.wang@intel.com>, Xu Yang <xu.yang_2@nxp.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Ensure the metric_leader is copied and set up correctly. In
compute_metric determine the correct metric_leader event to match the
requested CPU. Fixes the handling of metrics particularly on hybrid
machines.

Signed-off-by: Ian Rogers <irogers@google.com>
Tested-by: Thomas Falcon <thomas.falcon@intel.com>
---
 tools/perf/util/evsel.c  |  1 +
 tools/perf/util/python.c | 82 +++++++++++++++++++++++++++++-----------
 2 files changed, 61 insertions(+), 22 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index aee42666e882..5aae7f791bc2 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -538,6 +538,7 @@ struct evsel *evsel__clone(struct evsel *dest, struct evsel *orig)
 #endif
 	evsel->handler = orig->handler;
 	evsel->core.leader = orig->core.leader;
+	evsel->metric_leader = orig->metric_leader;
 
 	evsel->max_events = orig->max_events;
 	zfree(&evsel->unit);
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index fa5e4270d182..cc1019d29a5d 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -1340,27 +1340,48 @@ static int prepare_metric(const struct metric_expr *mexp,
 	struct metric_ref *metric_refs = mexp->metric_refs;
 
 	for (int i = 0; metric_events[i]; i++) {
-		char *n = strdup(evsel__metric_id(metric_events[i]));
+		struct evsel *cur = metric_events[i];
 		double val, ena, run;
-		int source_count = evsel__source_count(metric_events[i]);
-		int ret;
+		int ret, source_count = 0;
 		struct perf_counts_values *old_count, *new_count;
+		char *n = strdup(evsel__metric_id(cur));
 
 		if (!n)
 			return -ENOMEM;
 
+		/*
+		 * If there are multiple uncore PMUs and we're not reading the
+		 * leader's stats, determine the stats for the appropriate
+		 * uncore PMU.
+		 */
+		if (evsel && evsel->metric_leader &&
+		    evsel->pmu != evsel->metric_leader->pmu &&
+		    cur->pmu == evsel->metric_leader->pmu) {
+			struct evsel *pos;
+
+			evlist__for_each_entry(evsel->evlist, pos) {
+				if (pos->pmu != evsel->pmu)
+					continue;
+				if (pos->metric_leader != cur)
+					continue;
+				cur = pos;
+				source_count = 1;
+				break;
+			}
+		}
+
 		if (source_count == 0)
-			source_count = 1;
+			source_count = evsel__source_count(cur);
 
-		ret = evsel__ensure_counts(metric_events[i]);
+		ret = evsel__ensure_counts(cur);
 		if (ret)
 			return ret;
 
 		/* Set up pointers to the old and newly read counter values. */
-		old_count = perf_counts(metric_events[i]->prev_raw_counts, cpu_idx, thread_idx);
-		new_count = perf_counts(metric_events[i]->counts, cpu_idx, thread_idx);
-		/* Update the value in metric_events[i]->counts. */
-		evsel__read_counter(metric_events[i], cpu_idx, thread_idx);
+		old_count = perf_counts(cur->prev_raw_counts, cpu_idx, thread_idx);
+		new_count = perf_counts(cur->counts, cpu_idx, thread_idx);
+		/* Update the value in cur->counts. */
+		evsel__read_counter(cur, cpu_idx, thread_idx);
 
 		val = new_count->val - old_count->val;
 		ena = new_count->ena - old_count->ena;
@@ -1392,6 +1413,7 @@ static PyObject *pyrf_evlist__compute_metric(struct pyrf_evlist *pevlist,
 	struct metric_expr *mexp = NULL;
 	struct expr_parse_ctx *pctx;
 	double result = 0;
+	struct evsel *metric_evsel = NULL;
 
 	if (!PyArg_ParseTuple(args, "sii", &metric, &cpu, &thread))
 		return NULL;
@@ -1404,6 +1426,7 @@ static PyObject *pyrf_evlist__compute_metric(struct pyrf_evlist *pevlist,
 
 		list_for_each(pos, &me->head) {
 			struct metric_expr *e = container_of(pos, struct metric_expr, nd);
+			struct evsel *pos2;
 
 			if (strcmp(e->metric_name, metric))
 				continue;
@@ -1411,20 +1434,24 @@ static PyObject *pyrf_evlist__compute_metric(struct pyrf_evlist *pevlist,
 			if (e->metric_events[0] == NULL)
 				continue;
 
-			cpu_idx = perf_cpu_map__idx(e->metric_events[0]->core.cpus,
-						    (struct perf_cpu){.cpu = cpu});
-			if (cpu_idx < 0)
-				continue;
-
-			thread_idx = perf_thread_map__idx(e->metric_events[0]->core.threads,
-							  thread);
-			if (thread_idx < 0)
-				continue;
-
-			mexp = e;
-			break;
+			evlist__for_each_entry(&pevlist->evlist, pos2) {
+				if (pos2->metric_leader != e->metric_events[0])
+					continue;
+				cpu_idx = perf_cpu_map__idx(pos2->core.cpus,
+							    (struct perf_cpu){.cpu = cpu});
+				if (cpu_idx < 0)
+					continue;
+
+				thread_idx = perf_thread_map__idx(pos2->core.threads, thread);
+				if (thread_idx < 0)
+					continue;
+				metric_evsel = pos2;
+				mexp = e;
+				goto done;
+			}
 		}
 	}
+done:
 	if (!mexp) {
 		PyErr_Format(PyExc_TypeError, "Unknown metric '%s' for CPU '%d' and thread '%d'",
 			     metric, cpu, thread);
@@ -1435,7 +1462,7 @@ static PyObject *pyrf_evlist__compute_metric(struct pyrf_evlist *pevlist,
 	if (!pctx)
 		return PyErr_NoMemory();
 
-	ret = prepare_metric(mexp, mexp->metric_events[0], pctx, cpu_idx, thread_idx);
+	ret = prepare_metric(mexp, metric_evsel, pctx, cpu_idx, thread_idx);
 	if (ret) {
 		expr__ctx_free(pctx);
 		errno = -ret;
@@ -1996,6 +2023,17 @@ static PyObject *pyrf_evlist__from_evlist(struct evlist *evlist)
 			else if (leader == NULL)
 				evsel__set_leader(pos, pos);
 		}
+
+		leader = pos->metric_leader;
+
+		if (pos != leader) {
+			int idx = evlist__pos(evlist, leader);
+
+			if (idx >= 0)
+				pos->metric_leader = evlist__at(&pevlist->evlist, idx);
+			else if (leader == NULL)
+				pos->metric_leader = pos;
+		}
 	}
 	metricgroup__copy_metric_events(&pevlist->evlist, /*cgrp=*/NULL,
 					&pevlist->evlist.metric_events,
-- 
2.52.0.158.g65b55ccf14-goog

