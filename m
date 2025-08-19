Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4666227B4EE
	for <linux-perf-users@vger.kernel.org>; Tue, 19 Aug 2025 01:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755567635; cv=none; b=VGLN14Rk1Jd+9LBoJWFx+St6q//IQLO30qbVkhCHxcFJd3EyfB0krWU/3pryFAbFlYE59OjlqR+EpZhUboXRLqhMUOA1QeAGTY39js9+78Ww6GUBxYnNsRkiQQMVJVF6TVZ9vy3Jng9Ahfjh4gLc+Azx+9BQWawkvTE2jIR9pho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755567635; c=relaxed/simple;
	bh=IReQ/gDzDf181XNqMbXCjWaObwn2+z97Mfoo3hhvrIo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AUOn0uwOgDLrexgjYzh1Y2qPXiwLk+xMMliqTddI7c0cDF7IA0d16bVg3amfQ2kieoKyP7zTiFSM7em26b7BeaeQlvGidojn0gOoNJWWeNzGCLpK9OgZt4hN5VqDvrMszcGyPnU+wUjAme4fxNIV94CR3hrr7X7xuDNWBceZQsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pSszm8Yx; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pSszm8Yx"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-24458297be0so111381475ad.3
        for <linux-perf-users@vger.kernel.org>; Mon, 18 Aug 2025 18:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755567633; x=1756172433; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=r6OQKtyJgp17iiv1Y1ZPyP7AI0CwVjct8ec+x0FCacg=;
        b=pSszm8Yx2OZhFwXGGSdsAhGRwlkzk7/6hivvrNQa+Q7Ql+jLoA32uumyhyktP0R0VB
         jxOmkmiL/9B2mXcmnBvuJer1kzkvqwDyBTx57b3ugnxqz2VIH1903g66ZSa9mCGnHlgs
         f5mI2k9hXPKTC7G3Z78TJRqR+5kEvdX8v8202XEXUfISx4KGJCzborQP5ax8Hodue4ON
         arSYtUgMqydCRUzZdPEjVZLIcQ7C5KzKFXTZz4ScIg/IPhZTY69IKPHu7u4Z0EOVwaEB
         LUMmMRgtq9F3K6kpAXT2OTIx9sV7IVP9xPBaFP//tAkxdlPVMD0wqMuoqD0Xlg2TIG3m
         hW4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755567633; x=1756172433;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r6OQKtyJgp17iiv1Y1ZPyP7AI0CwVjct8ec+x0FCacg=;
        b=VrpwNN39r1dlq+JnLCMlyCDGvOfVvg5eaFE8XefUgkJ+iyrFIgonOub5BqpVcyMnUY
         gMdoGft+XOe1fauPCiUsK4iHCHCrSyWUZBBhXSDp9D3j7FFUVuuTJOL6JzjLfqeOTS9U
         ARzllOHZSwt4pA6n+CO2LEDrPBW3TC1RaA7DF8tIKPHHwgpUqLCyurr9kLly5wBYVZKD
         BQ3WL9XoDp3OzW4LsDDzsMjghYqWsTQXCKAsOQkUeb0uGXfZ58ncWlpy2CsHqZSuSnU1
         RZq1GNRiXURplBAaPMBtPtKBbF/jtIWHbhEForSjYuPvq8Vz4CVxTmXp7eTpo5RhYNpO
         zpWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVelu46WJUkPLM6gHFLLkaqOohQqJVqLTwy2SiVO23pITevBRZCVcR0tgGIPHCQdKuYj4S8n5VaTwafsqMPhdw4@vger.kernel.org
X-Gm-Message-State: AOJu0YyKVHf/zfrXw2ZoewrE/19zisrm92B5nCWI9cCu2Hfozwe7CqTv
	EyVasZYCGyMYiR1xNLZ1zL7hEL8Wxp9eN94tY4PTnPqxNqKde6lu3X3qnAsH8AQa6TCdNk2Y0Lm
	AgxLq+cf/PA==
X-Google-Smtp-Source: AGHT+IGB0qnLyrcD6hO1Jw97YHzv6tq7Xzuf4h17QXCNH+lxWlw/lRt8SYFEkMyo/+Eur40pWUYWjVycAEBq
X-Received: from plbkc6.prod.google.com ([2002:a17:903:33c6:b0:240:7619:64aa])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2443:b0:242:8a7:6a6c
 with SMTP id d9443c01a7336-245e02d7629mr10950045ad.17.1755567633423; Mon, 18
 Aug 2025 18:40:33 -0700 (PDT)
Date: Mon, 18 Aug 2025 18:39:38 -0700
In-Reply-To: <20250819013941.209033-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250819013941.209033-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.rc1.167.g924127e9c0-goog
Message-ID: <20250819013941.209033-9-irogers@google.com>
Subject: [PATCH v10 08/11] perf python: Add evlist compute_metric
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
Reviewed-by: Howard Chu <howardchu95@gmail.com>
---
 tools/perf/util/python.c | 125 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 125 insertions(+)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 31089f8e5519..e0769538b8d9 100644
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
@@ -1330,6 +1331,124 @@ static PyObject *pyrf_evlist__metrics(struct pyrf_evlist *pevlist)
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
@@ -1564,6 +1683,12 @@ static PyMethodDef pyrf_evlist__methods[] = {
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
2.51.0.rc1.167.g924127e9c0-goog

