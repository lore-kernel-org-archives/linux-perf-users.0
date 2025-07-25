Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F8A260590
	for <linux-perf-users@vger.kernel.org>; Fri, 25 Jul 2025 18:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753469565; cv=none; b=oMfo61ZXNdCjcizu1QzLChJxqcZhD101DLqWuRB3fVx0+sqciZUPTUOjDR+bStadV0VLibVljl9SDzA/IYYl7BKKkE9PppMZ+jAJv4B6ekTuCgdG1dUKqrIOcUeIBBf/pD6RP89p6SdaVlFxfL4oJ/BXU3mScMk+AOYqmY54CYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753469565; c=relaxed/simple;
	bh=QNymXMsh0+PDwJgBEIf87BOhNAAwdyMjmuDCswOESpQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ukTLqT4vqEWq/MJA+nI5sb24iCZgyoUwczK5/Ejsy3+tNO3M/0mxKbSg2SzllPqgWN4RDy6PYNOq2bKIBzfyBrSxvToHlTrAYZyjWht3SBhl3RmBaELbiujaBkXnKKB6poEEFmppx3/XN6SnWjHd1mBqS0LGV2bhsr1FKB+GZY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rK2w7CHB; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rK2w7CHB"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b31bc3128fcso3738363a12.0
        for <linux-perf-users@vger.kernel.org>; Fri, 25 Jul 2025 11:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753469563; x=1754074363; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eIGuclGiABh3QC0DEVnjdGmWupx/QA5phZrLpy71AEk=;
        b=rK2w7CHBc4mLbXjEwd84LikxU5TZzq5BD0cVY1NWQ1lEH4uZLmqawGLPd2hTVS1AS8
         GAO7jOCnG0OE/SlFGpsh7KdKloqH4p24DuLacmZ5l/m5MzH/jgiEy14wwM5AC7+h2SBr
         rBzLBq9HbioPgWmd7GOmOYEBJ8nAA/1oAO6GlSzdShofipsVZ06duu54Gy+RM9ovecgX
         C2v2DKjP4LGCQCbLEsdtipSTDfar5nltUDdaIwnjJUisY0Q+HOCEGYkC0TzZUGzVCUsH
         YO1xHvea8iypx5DgGg9xHux6wu3f56AB6uyi+2lg+lHYa/aFFqrPawy6BTqjlndtm46y
         PzOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753469563; x=1754074363;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eIGuclGiABh3QC0DEVnjdGmWupx/QA5phZrLpy71AEk=;
        b=KPW1k59NRXXolvOwCU9Z10lpAy9UgQhEUpYTuhHQIsGTYOy4xaVV5zEw2lLXiFKj6D
         kR0qxihGnH3e7oJuKm8i3ICsDf5t4rU2n3JoxUiQ4a0WRNnYFhAGZQG7CPxybhZOkp6k
         r6tS54xuMe7eQHkwTvQzu7nuXy7QHXQjFtyLx6CxjakQuOzQIARGxuvE0nEhDNbReJLp
         eieXxb8W+j+X5TsggL9A18khoL3Qb4ZENTkjOqqVL6Y+nO5McUCbgT/htwBsAyvXFkgM
         EUNDCYFFXJoU1apgYq2ngVKIBpk0+TSVYsHPb5hdibPpH37kqielQCyevnfcPbJNMh6E
         MLjw==
X-Forwarded-Encrypted: i=1; AJvYcCX86NF7W7r+uPl0/J+3siZX6SSzJZRPvwNMgnxjNd40oo9WJC/xOmPiLy+y2WPfaDMUtJsjEiY3mB7xmaXLvq5h@vger.kernel.org
X-Gm-Message-State: AOJu0YyY8uR0ovp358l3YyPWkQ/RotyP9kPNVPw9Yo+/bIS+Ok7hAymO
	51yF+Bp+hCxkr6L9pIfitwxeqIglafIND8u1FftaMiqI4tikprHeexQpHKHtekxPezGLtgN78u2
	uwIhyPc4dzA==
X-Google-Smtp-Source: AGHT+IHs6tlNj+93w5GJ6/PacV7fKa7xzryQVfnW20CZNa7JKwjGoSHXoYrDrxU6vRx2aNJFJLb3d0AbBEfS
X-Received: from plor11.prod.google.com ([2002:a17:902:8bcb:b0:220:ca3c:96bc])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e541:b0:23f:8bcc:e4f3
 with SMTP id d9443c01a7336-23fb30ab8bbmr49052845ad.32.1753469563354; Fri, 25
 Jul 2025 11:52:43 -0700 (PDT)
Date: Fri, 25 Jul 2025 11:52:00 -0700
In-Reply-To: <20250725185202.68671-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250725185202.68671-1-irogers@google.com>
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
Message-ID: <20250725185202.68671-15-irogers@google.com>
Subject: [PATCH v9 14/16] perf python: Add evlist compute_metric
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
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
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
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/python.c | 125 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 125 insertions(+)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index ccfa1ac4ad4b..bee7c8a69bad 100644
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
2.50.1.552.g942d659e1b-goog

