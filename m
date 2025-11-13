Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED75627FD6D
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Nov 2025 03:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763004060; cv=none; b=uudv4MilO75VYRbeyoRTsQf14mMJ0EBA29IityCm3YjjaQBOyFfAcuA14O7PXWcCruCbHny9gxGTDnnf1uEg1346MfkbKZvPKfuA1TMo9/tMrIzx0+cQBKoQRx3wPePe/Tbte0OVv6cHE6emhaduVd0P0DYZrgwnYGJwAFLaqgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763004060; c=relaxed/simple;
	bh=/wEuwYJacbKKFlQbisK53qhhUkEk1l0aXnBlIihbh9U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=WeJd1tbS0aNemQ/aEJ0acR6n6Xl6JMhuXzyYPV9QlRp4wyUYiJcXlcN7F6AESeIU3lqvmoy+aDvMKdmOTXAqpv4nqfmkYCi4x1beVI8QpgPn7vM4ugKGUeZCF2Y4tYtyxUNjkfzdrLKtRAo/52t7qHmiwvDV1xbGL52kfWk2sW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s5LgEgwg; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s5LgEgwg"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-29845b18d1aso4336705ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 12 Nov 2025 19:20:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763004057; x=1763608857; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OdnvPjUnvOTc/khADHyjd22NHmjVe0GcMSDru3c6rsg=;
        b=s5LgEgwg7/kEdIH5YM8+it5Rd0TkC6gKEoRd6CXxxiMGJ/1veWoxHeAy0JEnUlUWWs
         OWwEOAjODbhxImWB6Dm8NGwojfhls5S+sLpDXZXstowiX0QYilj+36HVxIX5OQ/2ABfJ
         8z8q+v0lj9p1+loNQ1ppwmpzqsDIa4GFHPOFi7cbgE0U154z+sKOoFM64s3CVeR0ZIdg
         wdq+8hI4YaBpU6abm6O1Znz/4bgLzW0T9GkEvQPZSNd0iHTF8seLapX63HmvyVlWE+R8
         x8GFwQPW2ZdPb9x+n4Gvq75tSrfo2RKuQTdiwENPCW6c9Kly/PblI3TfvlGXHW+BXgCV
         OqWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763004057; x=1763608857;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OdnvPjUnvOTc/khADHyjd22NHmjVe0GcMSDru3c6rsg=;
        b=uK+18hLuztj7BlWAZQMoHFf/nltEX2QoKhBKVLNkZijmP0lilomVULMmfZOi2ize65
         giVHzAegBPO5A4Gu5ub4tmTUtmHVuVx1mjHcZBOFZGc/RibujFfVWKr/4RKoiwHhvhlV
         bjqbOobsykDYzXSw0rK8h7TUJenFljlvKGJXCYsEiCT0iJr+dYtwI4W5yvi/nMxu6Ckp
         lCfVVVl9A9uGngxHJ/4ZSWeaWuDFYFAUQuXeX0uq8fWLmH2iqJEN49qb4NNlraa975SA
         jatHjv4X9UnLUCueLtKaz4K+XzrtQt1aOFy00uPIPkC1twVviNIJkmqQQE7V0oocQuuZ
         PE6A==
X-Forwarded-Encrypted: i=1; AJvYcCVf0fQNniAUx4L5/KoQWXXs/c3pbkJyxnjWEAZE99mv5hHml5H1Rl1X+NyeDJfarlmDRTGCL0MxBGN/jqVxEsYl@vger.kernel.org
X-Gm-Message-State: AOJu0YzsPxTroolvXTFad7WND/Gig+6rr4n5ZbCfduv7qDIVEWpgMBLU
	yfSrfa0VqLW2bXx6M2XFJSC8ojTIGyhiDp7hFs1KXjmACut6PrCYRokdHbUL6q7pdynTzUCkYOl
	usmuGzw0PHw==
X-Google-Smtp-Source: AGHT+IENUSd+lkjoZsq3X/mgYxckQizMTyTN+FLUqohdc7ToQ3zhL9b20/x+B5CLRvZiyi/W8aKKHcX7dAct
X-Received: from dybli13.prod.google.com ([2002:a05:7301:128d:b0:2a4:7052:5652])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3c46:b0:295:560a:e474
 with SMTP id d9443c01a7336-2984edacbedmr63481055ad.32.1763004057211; Wed, 12
 Nov 2025 19:20:57 -0800 (PST)
Date: Wed, 12 Nov 2025 19:19:49 -0800
In-Reply-To: <20251113032040.1994090-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251113032040.1994090-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251113032040.1994090-2-irogers@google.com>
Subject: [PATCH v8 01/52] perf python: Correct copying of metric_leader in an evsel
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
---
 tools/perf/util/evsel.c  |  1 +
 tools/perf/util/python.c | 82 +++++++++++++++++++++++++++++-----------
 2 files changed, 61 insertions(+), 22 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 989c56d4a23f..0918afe5c009 100644
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
2.51.2.1041.gc1ab5b90ca-goog

