Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C983307AFD
	for <linux-perf-users@vger.kernel.org>; Thu, 10 Jul 2025 20:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752179150; cv=none; b=CYr4NJPJF+ZpezatgPovs7hvjl/RgPpr0+x30o7XqYUTboRbYwJXhP9cN8ZaBe1fMrdMbpZoKjNNjtDSjDKPAQ0KSV9ZjdB6smSFF4atfrrLJ8B/f/k4dFbs2gIs8HGzNB5+DhTI7F0KcQrrfl6vDN58/pcz296IQU9C0/2Bs+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752179150; c=relaxed/simple;
	bh=CfdxWrvHXRSBK1tr4aMkg7yCSGisXTuq2p3EGoheCNk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=k3aUkZA8Q3G4jEtAtRLDwodr/caWYy0YJkhG0UFZkUfaTLO46q8L93x9ZEH7FehiVSiR+j0OojqwqIsyxXCIoabwkpipkzH8NfIMHZSqBsM/VLC3sqLO50qztUKzMGzxyKqKIjxHBNu7LC3zyUOASTmxi5ibIhHT4tsovzajvcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I2Yo4mnD; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I2Yo4mnD"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b321087b1cdso1612428a12.2
        for <linux-perf-users@vger.kernel.org>; Thu, 10 Jul 2025 13:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752179148; x=1752783948; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HXg6Ojthczu4oDT6PdQgfIf2viuURWIg6eqEDP0OVjo=;
        b=I2Yo4mnD4TlA8cfiDV1AfiRP8okpc0nXlo8SVIgeGQC9EpEGElGpkBl5OSjyHAB7CQ
         upx8ftcdG01XQSixJYCrF9BqJ09BajWttF8xdDgsAPxOuHJJXeuN1DE2nO0+1mPbkHKV
         NM0hxg6got3cfmNWXRM05Tp1B8GDW7iacIMYwNHeffgb/uA6jmnJhXJamsIrDUHUD+7D
         FCfqpcPGpf4xQXGZyfA69FBqKrWyk8paCrk80evgtb3GztQJeq7h9lGWOj1HI99JQurB
         HoGQCupsUQb0mWHv4juJlHOUGF88ZT2dCrM9y33K5Wx2IezaBYDjN0PtKH/puHIbhmgD
         vWCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752179148; x=1752783948;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HXg6Ojthczu4oDT6PdQgfIf2viuURWIg6eqEDP0OVjo=;
        b=V8oVjnXJGwgk8o+BE2d9w9I1hx2LSMtGhH3F2lO0HmRdJ3D6vpx1z/ZV1+HhVc2N+5
         CHvHzESPAUfd/YiHi4CW7q/j2ZXZnSIlOCtqIAnMNEdfZLqAITnZZtt/+q4vHICkRrEJ
         m4OPJe2xaCv26vZqCsov9x6uiA6EmQmglPIq0goiU4X/LTYpP8K+RFzbnNOdEpD8Xaxz
         xa4n3U1xegg9uAyuz9VtSCT/1UAXAsuMk5b9ax/67qvax66HNAW66a7DNFi8nDxIXSYY
         hnnDZ+ewRFme4saQpm1+nXztJEvjCGQEAu22YpmBrd2fGFEUkGqjv7u3bxwZMEzjxghX
         qOCg==
X-Forwarded-Encrypted: i=1; AJvYcCXCayk/Enu2vW24NJ4PgkaCKVenmViy5pWTZQ7Ge4zx0epijy5TIv8z1FU7T+LhXAtsrANAGIC0r9ufmYEmco/m@vger.kernel.org
X-Gm-Message-State: AOJu0Yxxyp21Avl9JyVnRZYk4fH5IggtsS7JP7J3XLr+eb46Wh4BNcMo
	yVCo5cc/jMIc0al8u0NXYF2rsleARYC8K69clh5ONwNVnqPsY56269ngfQKcgp1lWgBJjg4vx/I
	Y7h66sO+3FA==
X-Google-Smtp-Source: AGHT+IE/yLU0KCHJE4cQoL2XbEQ6RMGpKhtOlCJ+gDFn6pJdPy7axGkjhkFT/EE84qlViWiNcqSdUV4YgL+M
X-Received: from plgk2.prod.google.com ([2002:a17:902:ce02:b0:231:de34:f9f6])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1211:b0:234:ef42:5d5b
 with SMTP id d9443c01a7336-23dede42694mr8470935ad.16.1752179148045; Thu, 10
 Jul 2025 13:25:48 -0700 (PDT)
Date: Thu, 10 Jul 2025 13:24:58 -0700
In-Reply-To: <20250710202500.1959672-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250710202500.1959672-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250710202500.1959672-21-irogers@google.com>
Subject: [PATCH v5 12/14] perf python: Add evlist compute_metric
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
	Collin Funk <collin.funk1@gmail.com>, Howard Chu <howardchu95@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Andi Kleen <ak@linux.intel.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Thomas Richter <tmricht@linux.ibm.com>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, Gautam Menghani <gautam@linux.ibm.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Chun-Tse Shao <ctshao@google.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add a compute_metric function that computes a metric double value for a
given evlist, metric name, CPU and thread. For example:
```
>>> import perf
>>> x = perf.parse_metrics("TopdownL1")
>>> x.open()
>>> x.enable()
>>> x.disable()
>>> x.metrics()
['tma_bad_speculation', 'tma_frontend_bound', 'tma_backend_bound', 'tma_retiring']
>>> x.compute_metric('tma_bad_speculation', 0, -1)
0.08605342847131037
```

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/python.c | 121 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 121 insertions(+)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 9377b64d73af..41d290c43b7e 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -14,6 +14,7 @@
 #include "evlist.h"
 #include "evsel.h"
 #include "event.h"
+#include "expr.h"
 #include "print_binary.h"
 #include "record.h"
 #include "strbuf.h"
@@ -1305,6 +1306,120 @@ static PyObject *pyrf_evlist__metrics(struct pyrf_evlist *pevlist)
 	return list;
 }
 
+static int prepare_metric(const struct metric_expr *mexp,
+			  const struct evsel *evsel,
+			  struct expr_parse_ctx *pctx,
+			  int cpu_idx, int thread_idx)
+{
+	struct evsel * const *metric_events = mexp->metric_events;
+	struct metric_ref *metric_refs = mexp->metric_refs;
+
+	for (int i = 0; metric_events[i]; i++) {
+		char *n = strdup(evsel__metric_id(metric_events[i]));
+		double val, ena, run;
+		int source_count = evsel__source_count(metric_events[i]);
+		int ret;
+		struct perf_counts_values *old_count, *new_count;
+
+		if (!n)
+			return -ENOMEM;
+
+		if (source_count == 0)
+			source_count = 1;
+
+		ret = evsel__ensure_counts(metric_events[i]);
+		if (ret)
+			return ret;
+
+		/* Set up pointers to the old and newly read counter values. */
+		old_count = perf_counts(metric_events[i]->prev_raw_counts, cpu_idx, thread_idx);
+		new_count = perf_counts(metric_events[i]->counts, cpu_idx, thread_idx);
+		/* Update the value in metric_events[i]->counts. */
+		evsel__read_counter(metric_events[i], cpu_idx, thread_idx);
+
+		val = new_count->val - old_count->val;
+		ena = new_count->ena - old_count->ena;
+		run = new_count->run - old_count->run;
+
+		if (ena != run && run != 0)
+			val = val * ena / run;
+		ret = expr__add_id_val_source_count(pctx, n, val, source_count);
+		if (ret)
+			return ret;
+	}
+
+	for (int i = 0; metric_refs && metric_refs[i].metric_name; i++) {
+		int ret = expr__add_ref(pctx, &metric_refs[i]);
+
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static PyObject *pyrf_evlist__compute_metric(struct pyrf_evlist *pevlist,
+					     PyObject *args, PyObject *kwargs)
+{
+	int ret, cpu = 0, cpu_idx, thread = 0, thread_idx;
+	const char *metric;
+	struct rb_node *node;
+	struct metric_expr *mexp = NULL;
+	struct expr_parse_ctx *pctx;
+	double result = 0;
+
+	if (!PyArg_ParseTuple(args, "sii", &metric, &cpu, &thread))
+		return NULL;
+
+	cpu_idx = perf_cpu_map__idx(pevlist->evlist.core.all_cpus, (struct perf_cpu){.cpu = cpu});
+	if (cpu_idx < 0) {
+		PyErr_Format(PyExc_TypeError, "CPU %d is not part of evsel's CPUs", cpu);
+		return NULL;
+	}
+	thread_idx = perf_thread_map__idx(pevlist->evlist.core.threads, thread);
+	if (thread_idx < 0) {
+		PyErr_Format(PyExc_TypeError, "Thread %d is not part of evsel's threads",
+			     thread);
+		return NULL;
+	}
+
+	for (node = rb_first_cached(&pevlist->evlist.metric_events.entries); node;
+	     node = rb_next(node)) {
+		struct metric_event *me = container_of(node, struct metric_event, nd);
+		struct list_head *pos;
+
+		list_for_each(pos, &me->head) {
+			struct metric_expr *e = container_of(pos, struct metric_expr, nd);
+
+			if (!strcmp(e->metric_name, metric)) {
+				mexp = e;
+				break;
+			}
+		}
+	}
+	if (!mexp) {
+		PyErr_Format(PyExc_TypeError, "Unknown metric '%s'", metric);
+		return NULL;
+	}
+
+	pctx = expr__ctx_new();
+	if (!pctx)
+		return PyErr_NoMemory();
+
+	ret = prepare_metric(mexp, mexp->metric_events[0], pctx, cpu_idx, thread_idx);
+	if (ret) {
+		expr__ctx_free(pctx);
+		errno = -ret;
+		PyErr_SetFromErrno(PyExc_OSError);
+		return NULL;
+	}
+	if (expr__parse(&result, pctx, mexp->metric_expr))
+		result = 0.0;
+
+	expr__ctx_free(pctx);
+	return PyFloat_FromDouble(result);
+}
+
 static PyObject *pyrf_evlist__mmap(struct pyrf_evlist *pevlist,
 				   PyObject *args, PyObject *kwargs)
 {
@@ -1537,6 +1652,12 @@ static PyMethodDef pyrf_evlist__methods[] = {
 		.ml_flags = METH_NOARGS,
 		.ml_doc	  = PyDoc_STR("List of metric names within the evlist.")
 	},
+	{
+		.ml_name  = "compute_metric",
+		.ml_meth  = (PyCFunction)pyrf_evlist__compute_metric,
+		.ml_flags = METH_VARARGS | METH_KEYWORDS,
+		.ml_doc	  = PyDoc_STR("compute metric for given name, cpu and thread")
+	},
 	{
 		.ml_name  = "mmap",
 		.ml_meth  = (PyCFunction)pyrf_evlist__mmap,
-- 
2.50.0.727.gbf7dc18ff4-goog

