Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5719C2F4A0B;
	Wed,  3 Sep 2025 13:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756906564; cv=none; b=FWEsg7oj91f6D8ZeXiv3wgonDlnmNO/mImnVofzGRoVPe2QONUhxWWAlmOYquGsbJtAJ/LiKHqcqd4C5/yKuAVVdCihm/wn6E/yiYFHVSG3bDuVhzyP5xM/eZ09j1UV+IIrJu2m4qYvunQOUcL17aKfiRDxbCw2jw4LiBErxKug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756906564; c=relaxed/simple;
	bh=vGFz3odNyr8060Aa2TccDkThKx77JB9ylQrhp0r0nC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T+HwRYBo5d2pyO/rzF3d8t2K/JrIpD2SCUe9M0qMeObxePb1Y94g412BWFslQilxOg3BorRu3kJg/fSl8m9tJ68N2EpR7Oj1ChtzDFrE9C/9+mDOggykQcUHC5u5vXF+A3/nFq47GQ6CdFxWmMyoI+VJGMoV3msVvk31PEPH7NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mz8tPaow; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mz8tPaow"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52123C4CEF0;
	Wed,  3 Sep 2025 13:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756906560;
	bh=vGFz3odNyr8060Aa2TccDkThKx77JB9ylQrhp0r0nC8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mz8tPaowswg6VTNwTTlRgZusJ5DA7a65+mPIW3iirWWm6b+sfIs4RhyeNJXtLvFjn
	 dDpao0baMbTU3nz6gWxHn6Dz2ZfLT0nhgwkB5TKBQJsB5QYfrzICmNgODpOoAAp+MM
	 pFGuZRGroPiqM3+5hUTSDXun1xDoWyQGG1WcCC9Eqhb1c9OgQqtPWJNBrg9wM9tLhw
	 7pFRoCi9PvbVk/7kGPBwxHx4g0cq1UtLyNHnA98bFCwfxD3Je0nu/1ZBv5/WSKjTUD
	 51IJtZbTlfQkhsVgERCUCeJdJltRflNaxd4KIXbBUWa2J3hAYgzHDR6n0eU3XTfV5U
	 TJZ7r8yJRV5Rw==
Date: Wed, 3 Sep 2025 10:35:57 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>, Xu Yang <xu.yang_2@nxp.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Collin Funk <collin.funk1@gmail.com>,
	Howard Chu <howardchu95@gmail.com>,
	Weilin Wang <weilin.wang@intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Gautam Menghani <gautam@linux.ibm.com>,
	Thomas Falcon <thomas.falcon@intel.com>,
	Chun-Tse Shao <ctshao@google.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH v10 08/11] perf python: Add evlist compute_metric
Message-ID: <aLhEPS6T-Sxnujrp@x1>
References: <20250819013941.209033-1-irogers@google.com>
 <20250819013941.209033-9-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250819013941.209033-9-irogers@google.com>

On Mon, Aug 18, 2025 at 06:39:38PM -0700, Ian Rogers wrote:
> Add a compute_metric function that computes a metric double value for a
> given evlist, metric name, CPU and thread. For example:
> ```
> >>> import perf
> >>> x = perf.parse_metrics("TopdownL1")
> >>> x.open()
> >>> x.enable()
> >>> x.disable()
> >>> x.metrics()
> ['tma_bad_speculation', 'tma_frontend_bound', 'tma_backend_bound', 'tma_retiring']
> >>> x.compute_metric('tma_bad_speculation', 0, -1)
> 0.08605342847131037
> ```

Added the following to fix the build on the still not EOLed OpenSUSE
15, ok?

- Arnaldo

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 56102034d5b8c469..47178404802f4069 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -1386,7 +1386,7 @@ static int prepare_metric(const struct metric_expr *mexp,
 static PyObject *pyrf_evlist__compute_metric(struct pyrf_evlist *pevlist,
 					     PyObject *args, PyObject *kwargs)
 {
-	int ret, cpu = 0, cpu_idx, thread = 0, thread_idx;
+	int ret, cpu = 0, cpu_idx = 0, thread = 0, thread_idx = 0;
 	const char *metric;
 	struct rb_node *node;
 	struct metric_expr *mexp = NULL;

Committer notes:

Initialize thread_idx and cpu_idx to zero as albeit them not possibly
coming out unitialized from the loop as mexp would be not NULL only if
they were initialized, some older compilers don't notice that and error
with:

    GEN     /tmp/build/perf/python/perf.cpython-36m-x86_64-linux-gnu.so
  /git/perf-6.17.0-rc3/tools/perf/util/python.c: In function ‘pyrf_evlist__compute_metric’:
  /git/perf-6.17.0-rc3/tools/perf/util/python.c:1363:3: error: ‘thread_idx’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
     evsel__read_counter(metric_events[i], cpu_idx, thread_idx);
     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  /git/perf-6.17.0-rc3/tools/perf/util/python.c:1389:41: note: ‘thread_idx’ was declared here
    int ret, cpu = 0, cpu_idx, thread = 0, thread_idx;
                                           ^~~~~~~~~~
  /git/perf-6.17.0-rc3/tools/perf/util/python.c:1363:3: error: ‘cpu_idx’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
     evsel__read_counter(metric_events[i], cpu_idx, thread_idx);
     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  /git/perf-6.17.0-rc3/tools/perf/util/python.c:1389:20: note: ‘cpu_idx’ was declared here
    int ret, cpu = 0, cpu_idx, thread = 0, thread_idx;
                      ^~~~~~~
  /git/perf-6.17.0-rc3/tools/perf/util/python.c: At top level:
  cc1: error: unrecognized command line option ‘-Wno-cast-function-type’ [-Werror]
  cc1: all warnings being treated as errors
  error: command 'gcc' failed with exit status 1
  cp: cannot stat '/tmp/build/perf/python_ext_build/lib/perf*.so': No such file or directory

- Arnaldo
 
> Signed-off-by: Ian Rogers <irogers@google.com>
> Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> Reviewed-by: Howard Chu <howardchu95@gmail.com>
> ---
>  tools/perf/util/python.c | 125 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 125 insertions(+)
> 
> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index 31089f8e5519..e0769538b8d9 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
> @@ -14,6 +14,7 @@
>  #include "evlist.h"
>  #include "evsel.h"
>  #include "event.h"
> +#include "expr.h"
>  #include "print_binary.h"
>  #include "record.h"
>  #include "strbuf.h"
> @@ -1330,6 +1331,124 @@ static PyObject *pyrf_evlist__metrics(struct pyrf_evlist *pevlist)
>  	return list;
>  }
>  
> +static int prepare_metric(const struct metric_expr *mexp,
> +			  const struct evsel *evsel,
> +			  struct expr_parse_ctx *pctx,
> +			  int cpu_idx, int thread_idx)
> +{
> +	struct evsel * const *metric_events = mexp->metric_events;
> +	struct metric_ref *metric_refs = mexp->metric_refs;
> +
> +	for (int i = 0; metric_events[i]; i++) {
> +		char *n = strdup(evsel__metric_id(metric_events[i]));
> +		double val, ena, run;
> +		int source_count = evsel__source_count(metric_events[i]);
> +		int ret;
> +		struct perf_counts_values *old_count, *new_count;
> +
> +		if (!n)
> +			return -ENOMEM;
> +
> +		if (source_count == 0)
> +			source_count = 1;
> +
> +		ret = evsel__ensure_counts(metric_events[i]);
> +		if (ret)
> +			return ret;
> +
> +		/* Set up pointers to the old and newly read counter values. */
> +		old_count = perf_counts(metric_events[i]->prev_raw_counts, cpu_idx, thread_idx);
> +		new_count = perf_counts(metric_events[i]->counts, cpu_idx, thread_idx);
> +		/* Update the value in metric_events[i]->counts. */
> +		evsel__read_counter(metric_events[i], cpu_idx, thread_idx);
> +
> +		val = new_count->val - old_count->val;
> +		ena = new_count->ena - old_count->ena;
> +		run = new_count->run - old_count->run;
> +
> +		if (ena != run && run != 0)
> +			val = val * ena / run;
> +		ret = expr__add_id_val_source_count(pctx, n, val, source_count);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	for (int i = 0; metric_refs && metric_refs[i].metric_name; i++) {
> +		int ret = expr__add_ref(pctx, &metric_refs[i]);
> +
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static PyObject *pyrf_evlist__compute_metric(struct pyrf_evlist *pevlist,
> +					     PyObject *args, PyObject *kwargs)
> +{
> +	int ret, cpu = 0, cpu_idx, thread = 0, thread_idx;
> +	const char *metric;
> +	struct rb_node *node;
> +	struct metric_expr *mexp = NULL;
> +	struct expr_parse_ctx *pctx;
> +	double result = 0;
> +
> +	if (!PyArg_ParseTuple(args, "sii", &metric, &cpu, &thread))
> +		return NULL;
> +
> +	for (node = rb_first_cached(&pevlist->evlist.metric_events.entries);
> +	     mexp == NULL && node;
> +	     node = rb_next(node)) {
> +		struct metric_event *me = container_of(node, struct metric_event, nd);
> +		struct list_head *pos;
> +
> +		list_for_each(pos, &me->head) {
> +			struct metric_expr *e = container_of(pos, struct metric_expr, nd);
> +
> +			if (strcmp(e->metric_name, metric))
> +				continue;
> +
> +			if (e->metric_events[0] == NULL)
> +				continue;
> +
> +			cpu_idx = perf_cpu_map__idx(e->metric_events[0]->core.cpus,
> +						    (struct perf_cpu){.cpu = cpu});
> +			if (cpu_idx < 0)
> +				continue;
> +
> +			thread_idx = perf_thread_map__idx(e->metric_events[0]->core.threads,
> +							  thread);
> +			if (thread_idx < 0)
> +				continue;
> +
> +			mexp = e;
> +			break;
> +		}
> +	}
> +	if (!mexp) {
> +		PyErr_Format(PyExc_TypeError, "Unknown metric '%s' for CPU '%d' and thread '%d'",
> +			     metric, cpu, thread);
> +		return NULL;
> +	}
> +
> +	pctx = expr__ctx_new();
> +	if (!pctx)
> +		return PyErr_NoMemory();
> +
> +	ret = prepare_metric(mexp, mexp->metric_events[0], pctx, cpu_idx, thread_idx);
> +	if (ret) {
> +		expr__ctx_free(pctx);
> +		errno = -ret;
> +		PyErr_SetFromErrno(PyExc_OSError);
> +		return NULL;
> +	}
> +	if (expr__parse(&result, pctx, mexp->metric_expr))
> +		result = 0.0;
> +
> +	expr__ctx_free(pctx);
> +	return PyFloat_FromDouble(result);
> +}
> +
>  static PyObject *pyrf_evlist__mmap(struct pyrf_evlist *pevlist,
>  				   PyObject *args, PyObject *kwargs)
>  {
> @@ -1564,6 +1683,12 @@ static PyMethodDef pyrf_evlist__methods[] = {
>  		.ml_flags = METH_NOARGS,
>  		.ml_doc	  = PyDoc_STR("List of metric names within the evlist.")
>  	},
> +	{
> +		.ml_name  = "compute_metric",
> +		.ml_meth  = (PyCFunction)pyrf_evlist__compute_metric,
> +		.ml_flags = METH_VARARGS | METH_KEYWORDS,
> +		.ml_doc	  = PyDoc_STR("compute metric for given name, cpu and thread")
> +	},
>  	{
>  		.ml_name  = "mmap",
>  		.ml_meth  = (PyCFunction)pyrf_evlist__mmap,
> -- 
> 2.51.0.rc1.167.g924127e9c0-goog
