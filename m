Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976EC302063
	for <linux-perf-users@vger.kernel.org>; Thu, 10 Jul 2025 20:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752179850; cv=none; b=uuqnmyaE7Njc1bxEJOF+3yTIBtQtoMBuIag0z7T7FIdPHHvqyQRW1xK0smV4mQyNm8SJdqyu5q91pZ4IKsxP0vaKS6BufkiQ5zS1eTx05APfHrhHRWlJFcEl/ZbQAwZG83h1MpleelpQiCBXPstULniD0M3vK07hQD/Rb7egvEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752179850; c=relaxed/simple;
	bh=CfdxWrvHXRSBK1tr4aMkg7yCSGisXTuq2p3EGoheCNk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=XIunMtZryhJqkKHdQ6owPv1QjQqDdrY+mgd2S8CDZ9ZdoJGfX2Ny3w2Jn5PZNZoPh1jFcfb065lfqBclKIRiCm/sSSNs6jLGenaFGoQ2fKdvd2jzJx+WunMx6KKIlXG3P88pkO8kyWCUA4nisGisuSLYztX6Qhdf/DnGnn6qtxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pLVyaEIo; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pLVyaEIo"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3138e64b3f1so1842475a91.3
        for <linux-perf-users@vger.kernel.org>; Thu, 10 Jul 2025 13:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752179848; x=1752784648; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HXg6Ojthczu4oDT6PdQgfIf2viuURWIg6eqEDP0OVjo=;
        b=pLVyaEIoxhBzs0Qm2ZdABEmmieV867lfy1ens+eKcqpMpRJh+42DJD0wXznzwBVcmw
         ArNYWUAnJvHsWpmOsUDWh0v5FTV3ye5GzurrDQjYNhA9hDNDvCYjoCvsQzpeb1+4PXCn
         ktsQnoAWcNvhhJ9Bikhn8e8Gukx6IQo/CdKNs8KNhpSfreJsB5d95ZFVcGsvNY2tx4Yo
         qGByQaqZHZjrZW5E9+v5KIoGUHGuNeGuqv4i7V0iuGkAKftHR2owOeSqknJAzV0hA37x
         meJT5n+ZIEdBPiKQoxxQIXLIurk0gIP+4QLwcE+g/MPQZtM0DGMYe9ULGkbPyy99Xjf1
         i5Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752179848; x=1752784648;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HXg6Ojthczu4oDT6PdQgfIf2viuURWIg6eqEDP0OVjo=;
        b=VRwnNrUlK4AiBCnQER/IgLIic6KzhIfwBWXj97gUE+n6zb5+gz1Aew09mvzP5JaUYT
         AntJpnZSDIwJkCpf/OdN06g9R2KesdDdSLQLIqgHthPHruXvypZQYqx2RbrNeCv7OPaY
         uNNxtxDkFcUXYoj77ibBwWLHx+Agnpp9moBdU3T8ij2kY+LU3j7IZNM6z64CeADFmH74
         nTKPa1FEcdNFUgdM+vd1qyAzq90a2jwIrxZnRbw2vHuf0HwhfQjyQyA+ifDWWWDmQ9ha
         nfKWwfdWqUe7b//0gp+9vr6/3DLKY+dSr+BLahEoFLyaYjqPvO76ZFGEnDsmJa9wMFhV
         RPWw==
X-Forwarded-Encrypted: i=1; AJvYcCWwi3mATGWoLjBjKq/81TogUkk7QxFt9mlN1eQw3f4Y17jGVbWXqeucUEpFqepVifoqbupBtVImZIdXUJpwt1BP@vger.kernel.org
X-Gm-Message-State: AOJu0Yzicbdbr+nKspihgXmc5z1R5idr470xaXknCzYg5K/R3u6Sch5w
	bITToto2JZEcopPLvftw/ma9zcYJV4j/HOVe2bxcdWr3NECwai4FLhIcj2o8+zhtOXtnf7D8uE7
	io/mRaE65dA==
X-Google-Smtp-Source: AGHT+IGBCGuQR9pUcG1fIxTZrGRSMHJn8DU/xd4Z6xmnnoxo1JZTJaBLRYK/Q83N9rxMzt1BYkhOqXurPhLf
X-Received: from pjbsq16.prod.google.com ([2002:a17:90b:5310:b0:313:221f:6571])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3942:b0:311:c1ec:7d12
 with SMTP id 98e67ed59e1d1-31c4f591c3amr45894a91.23.1752179848120; Thu, 10
 Jul 2025 13:37:28 -0700 (PDT)
Date: Thu, 10 Jul 2025 13:36:54 -0700
In-Reply-To: <20250710203656.1963075-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250710203656.1963075-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250710203656.1963075-13-irogers@google.com>
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

