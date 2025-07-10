Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B870830E857
	for <linux-perf-users@vger.kernel.org>; Thu, 10 Jul 2025 23:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752191907; cv=none; b=iMJP9z54MMxWwbyuP2HGbOH92vIz+sa67purOLbujdak/is5LVscorafw6j9QaML5gJmpud1tHxvwUUGoier2EJY8h47gsYho3r+Iknxxph8aX40qu2ZRlmnVPgxAwCdxy5zOJHjtb+wG+23P6blbrqcUKct5st3Bz1FuUqpsJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752191907; c=relaxed/simple;
	bh=bRaMZqW4tXa2j8xH86LuL42mTy4YPUnO7esRI3dJKxc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=WL8sFhTcj80Ma+0bxtMzpgUBxQ4vZcU8a0JslNefg64I3iUHvJ5XCdENK6ACBeZzx2qXwtPw4VY98H7NfMdSOv2jOhG3bY0Qq/hmMStr2kGK1ECqQvXwgWB2bEU35jMltSF+h+ELs/Ba+t3IHwfEnkxQaWPuxF8Q//vyiIn+dNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f4jadGyV; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f4jadGyV"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-313fab41f4bso2057533a91.0
        for <linux-perf-users@vger.kernel.org>; Thu, 10 Jul 2025 16:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752191905; x=1752796705; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=naYhFRnWg94tGkirYAW6OZwAYXTzv1STqodk0oU/6Ys=;
        b=f4jadGyVRyHK3chJsaL7VR9pzRQWc/s9YuQwitRxhOvLpqJ8p6HwSMY5B8pVeKDpPQ
         K/RFsL8+O9gVaUdN5aVNf3gaZfuTVVtmIGCWDli8YTd8yQRhMsWmZBrlYmQH65eg5EQv
         aXmyKOB4ZWv29KOj8zo7ZF4AkMCn95Tt/gN5MO2eLwzpRW71BAnFnoQu9k1BAqE+KVmg
         tLgX+5zzapVoMMlZ+/2TeQNOypY1Kl8CPTMVnPZdvNzh6cKfBpaSs4w3J0A7PI3yQ/Ud
         nNO/UPDN82djjwVe1SJcIWqEpDfcbwvZygyr/UjJUaKcLR9LpaCG2+MMrQhf5+KrQGQZ
         HrSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752191905; x=1752796705;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=naYhFRnWg94tGkirYAW6OZwAYXTzv1STqodk0oU/6Ys=;
        b=E7IOoO/vuFd/e6kug+cd15sEiM8w+yRTwgVRWRb79306ZPZUHKgjNjohCrJINXUvGW
         v6h9JJaZpXAzlsbCsMrr7Q1tY21XrBmX5fMwiFPokw5yDs0T1/mp6Pf6sgTCvIc2kVqU
         2/62AvYSqiF4busxxoabd3Z4/81DUUnalVYb/H7iUUXy+Zn73YXbjxo/flSX+iVq5mD0
         Qy+k9c8bfbyKrRpsHdnVFE59czdhv7o+kIZHGQ0hj4h12JaTGDmnpfmMZapicK2D468l
         hWcbf1K6rOuEvB/R+JkLJWg2z/hQ0Go4UI6UBik8IW80S7Jhb+wvl02u0+TSrsEYiwr/
         SlJw==
X-Forwarded-Encrypted: i=1; AJvYcCWS6RjIpIco96TUVNLew9bR4djyPslcQTFOGE55vpxnuni+o8zSuEnaODzEzxBQK+1BLvPSHKltMi/kNSSLfDpx@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2Ctp6Avcx3qvm8vluIGL+uYW5hnyDruX+JX0rGmT1Uf4iEFPd
	O45kcrTjjColC4xhvYJQErllHf9/qJIZ2QSD6vG2Klr7k/LxKfjL94tF+yfAPcpc6vNzLJY4vZX
	MkzDphs2oew==
X-Google-Smtp-Source: AGHT+IFVCBcPSsgC1O992AHvehDpxUn92IVL8Jl0Pkij7ZW4PcEopY719BADW2hcdEBSBSsuVGZCsEpXd4wb
X-Received: from pjyp6.prod.google.com ([2002:a17:90a:e706:b0:2fc:e37d:85dc])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3d4d:b0:313:f883:5d36
 with SMTP id 98e67ed59e1d1-31c4ca66f8fmr1629818a91.1.1752191905162; Thu, 10
 Jul 2025 16:58:25 -0700 (PDT)
Date: Thu, 10 Jul 2025 16:57:33 -0700
In-Reply-To: <20250710235735.1089240-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250710235735.1089240-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250710235735.1089240-13-irogers@google.com>
Subject: [PATCH v6 12/14] perf python: Add evlist compute_metric
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
 tools/perf/util/python.c | 122 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 122 insertions(+)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 639c1587d629..fc62ecd3172f 100644
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
@@ -1309,6 +1310,121 @@ static PyObject *pyrf_evlist__metrics(struct pyrf_evlist *pevlist)
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
+			cpu_idx = perf_cpu_map__idx(e->metric_events[0]->core.cpus, (struct perf_cpu){.cpu = cpu});
+			if (cpu_idx < 0)
+				continue;
+
+			thread_idx = perf_thread_map__idx(e->metric_events[0]->core.threads, thread);
+			if (thread_idx < 0)
+				continue;
+
+			mexp = e;
+			break;
+		}
+	}
+	if (!mexp) {
+		PyErr_Format(PyExc_TypeError, "Unknown metric '%s' for CPU '%d' and thread '%d'", metric, cpu, thread);
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
@@ -1541,6 +1657,12 @@ static PyMethodDef pyrf_evlist__methods[] = {
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

