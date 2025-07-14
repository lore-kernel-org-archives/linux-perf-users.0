Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A429426B750
	for <linux-perf-users@vger.kernel.org>; Mon, 14 Jul 2025 16:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752511482; cv=none; b=a+brbicVmc7U+nTMMDyv+byeYhkKU6Ef6tMeuaWa+tsNGzjhYfui21jVB68LhfRS2SByZaTlMp0PSfGUHMW0zl5cWnWIPx7f+dG8PLLIwLT8A7iw3H0EPLnVnYNUq/MZymFIMzsrfbQBAccKKKTVOUV21li/KIJNkYPEZNM/xOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752511482; c=relaxed/simple;
	bh=sbjvkF4YKyervP88WGj1YR1nyifbLnupU2YeLz7xqm0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=a4ZgrmpL7RCDBUmHPjO/InmRyfTmTQG7Buvqxa8BU6EkbBHvVjAf4j8diFvWkzoyPJRDBJ+KOzxB1Ewn5lfneXbX8Kw/kOWTL6mpItwK/OJ8taNdTTXS5GMJLTznvk458pOmyVGa2j3rF73N+n72vggy4a16g1u7NkTEspo4GyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X/cZjI2v; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X/cZjI2v"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b2c37558eccso4033671a12.1
        for <linux-perf-users@vger.kernel.org>; Mon, 14 Jul 2025 09:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752511480; x=1753116280; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J+TnLqX8lliYddeE0Tj0w2agkrVZRA9du6A+5iW4FYA=;
        b=X/cZjI2vYp+qLMZ9ZNgLw5QeNnMpJAJriRNqJCwDCENLPRKu8/C63QgwtkjVyP566F
         GJlkNuCqfjQNnoQ1SKXiud9ZqOVKb+MC2sWNxyklzJBfiI0QGD5qcEwTenKBoKcoDOhY
         wuDCF8+5V9U7Gl7uhkP1w0DTFgW+mwP+lySCEK8Uonmn14uBDMWsCQprXzOv2LhRPTxb
         3YMNuBOWDwHhLM7rfp6DWReb4KuvjM9ZOc6ab/9sOx4xL4NdE7tONiRzGjr8qjPURPM9
         t2vxbqH/3LpLJBvdPtFR/EcH/M/5Wx9E5kp33K2XZExf6Y0qzxlNtJzGbtZnyF+jd6sL
         4PLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752511480; x=1753116280;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J+TnLqX8lliYddeE0Tj0w2agkrVZRA9du6A+5iW4FYA=;
        b=NVZpxLKh9l6gbD5n1HKfE1cU13/3JVVay/VZgvLCAbfbx2qA9kzjf566Y7ATty/vLd
         Z34pVnktOu+sfpmWn96/fqpJNJd2HZiv71zOfEMYg87n6LyTD+fB3bG8T+dtJoqu6Uls
         vawN09/HZMZBHOUzTThmIl3/lyZJZWQPQklL3SFAMdCMVG5g4lAVcjkm/vDpQxTdPn7a
         g2jKkEyTdaewt8t2w0Wd6i/4+LIJ1CHFLusaTdEA1QuBR1WuJr0lfCw112NjjODyhwzW
         G3OjNcK/7DaMnzJcTTYJIMrqZuKIch8h6esWrG7slQj+X2B/Qd2C0lmaTdn+/9J8t0bc
         Q7kA==
X-Forwarded-Encrypted: i=1; AJvYcCViBxEIDEHuwyzv2SWG+h2uylo8hUWSeB5R/zgrlizITXEPbOlqhTxKota4N3w2igVDRV2lAM+kVfq7rivigBaz@vger.kernel.org
X-Gm-Message-State: AOJu0YwV/Bty6yxpqDgkObBabzFgKNTrSiwjLTZUkI2d21DgylE6j88G
	tBmkSKykkyTMyM9776lFphj0r6HMS+rycnv8mn5odovPozGx6qtwikovpFng7B8lAHZ0haA7gEJ
	Q7O8F+eBwnA==
X-Google-Smtp-Source: AGHT+IHcxYphFCUl4TIJtCVyxRhXbLg4gFzYTtPXJmfT3ON1GTTp5btpt90BAenijqIDiDDS6IcUjUzZmzgp
X-Received: from pjbtd3.prod.google.com ([2002:a17:90b:5443:b0:312:2b3:7143])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5868:b0:312:29e:9ed5
 with SMTP id 98e67ed59e1d1-31c4cd9c12cmr19991525a91.23.1752511480052; Mon, 14
 Jul 2025 09:44:40 -0700 (PDT)
Date: Mon, 14 Jul 2025 09:44:02 -0700
In-Reply-To: <20250714164405.111477-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250714164405.111477-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250714164405.111477-15-irogers@google.com>
Subject: [PATCH v7 14/16] perf python: Add evlist compute_metric
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
 tools/perf/util/python.c | 125 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 125 insertions(+)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index c1eab506f55b..980490684ab9 100644
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
@@ -1320,6 +1321,124 @@ static PyObject *pyrf_evlist__metrics(struct pyrf_evlist *pevlist)
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
+	for (node = rb_first_cached(&pevlist->evlist.metric_events.entries);
+	     mexp == NULL && node;
+	     node = rb_next(node)) {
+		struct metric_event *me = container_of(node, struct metric_event, nd);
+		struct list_head *pos;
+
+		list_for_each(pos, &me->head) {
+			struct metric_expr *e = container_of(pos, struct metric_expr, nd);
+
+			if (strcmp(e->metric_name, metric))
+				continue;
+
+			if (e->metric_events[0] == NULL)
+				continue;
+
+			cpu_idx = perf_cpu_map__idx(e->metric_events[0]->core.cpus,
+						    (struct perf_cpu){.cpu = cpu});
+			if (cpu_idx < 0)
+				continue;
+
+			thread_idx = perf_thread_map__idx(e->metric_events[0]->core.threads,
+							  thread);
+			if (thread_idx < 0)
+				continue;
+
+			mexp = e;
+			break;
+		}
+	}
+	if (!mexp) {
+		PyErr_Format(PyExc_TypeError, "Unknown metric '%s' for CPU '%d' and thread '%d'",
+			     metric, cpu, thread);
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
@@ -1554,6 +1673,12 @@ static PyMethodDef pyrf_evlist__methods[] = {
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

