Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6EBE302046
	for <linux-perf-users@vger.kernel.org>; Thu, 10 Jul 2025 20:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752179846; cv=none; b=etMMLxsntU1KbdzoL6b8XC0KpFE+BAnWNFScdq7dmdLRdER2xaEfEQX0yQzyX6p3HCqRkpbUCByDNbRqZOj/nLtbxbiLBRzMMQlzHarXduEXFEck1XHlOy8vi8Qkcx3ZzGh7aSF+okOrZ02AnvSSfyEy6XPYAwQ3PSd/FDse6IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752179846; c=relaxed/simple;
	bh=3dXnQX59uCIqHGxrXpzMnI4Zl7s0lQpAP1vxN37XyBs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=GtTx5QnyHNSJEvxDnhYlV3OT6OfLApB0Ll0T7b677Bdalz+wxAtFtAum4O0CSY01Sg/nAmS09q0sR1Ombtn1qH7AK2FliLKlE7QrGbML43s3NJRd+iIQCNOP+caCWVRLj7SJ0rDiKlp5YXQFzD7JsqFtHBjdM5Ddb+IDSgBgpL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=duwXx3cb; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="duwXx3cb"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3141a9a6888so1395584a91.3
        for <linux-perf-users@vger.kernel.org>; Thu, 10 Jul 2025 13:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752179844; x=1752784644; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kKmR4p/5RIten4aKh3XJYKu49jHs+S3X2MC/LIpLWZY=;
        b=duwXx3cbvYWOJnQGvcPuwGMHhIw1ZrpLKlKYBq9qKkJGXVTmXLYu8KbC2bshZQ1ak4
         weYOSOn9cydMOV4lrCyUrah48eFfxH0MuBT9MUgJQCJPVrY2DMAv18moQhZHjmbNc4ir
         iRIlg8nCBoo+LeUz1ratyibRkOr+Z3obYM7dt7FL4G3lTq0sbnlAFlYtN4B4xSaeoR5g
         iBcDD8gfkf2CLzx2nzvhq9DvUorN3ayOA5PudkN2Te0ujMhHbWR8jO4O3X+NmWkJqa6F
         qjzugj0ZxiKtMcXB7bSZjeW3vruN6tyGtCdJvDtyvfiD4iNGM9kll9hLE3kwa0EPdWhp
         WY4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752179844; x=1752784644;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kKmR4p/5RIten4aKh3XJYKu49jHs+S3X2MC/LIpLWZY=;
        b=JColdlnTSgkQqf7B9F6y36DZPqU7LgxUkP9neWgAmhlGRzrPe9khz6jiKeW5fdN182
         RZ3+Kx5nXjaKlGylq0X9haGgZa7TyK2zsFsw3iYnxwUS7Tx1s0vcwAuKxVWfUuIS4NNo
         egkBhgTXg6YT2Z9jV0N/JQ921TeRdyzA2fDNPzqLxFX1WKor2GCK1sdrLSjv5NXJRci/
         MA6+sqRGCxN/Qbyi3yPST3GRh0MioxSjAPb94ofwuHuhrPy10xxk41BZZyS2nt+izkcY
         U1N4EFSYEvp5UVFmF6eRgj+N0g/OweSL23bY9dV1M0Z7WlJCtf7q6efTZ0j4srNYhMFk
         KwMA==
X-Forwarded-Encrypted: i=1; AJvYcCXt7oHkP0HTk6gOKURwRIU/SGAdZKtNO82P8I50kkWhhrFfrHXyV/AxwoJ9Q9OLp/ONwcAe5BQtR35z8Mlcg9Kz@vger.kernel.org
X-Gm-Message-State: AOJu0YwlKU3pZX1eYRUAAloVXZ3BVyW2KD7fpPqxyuWyqddGv0pyLqGo
	Hdv/t2c4n2ZkQkJ4EUSriTK/5Y+/m2dcb+5/SInWQx9hAI7/HcDBiiphZBzFih5p1qoncbOlumx
	liD860PDPTw==
X-Google-Smtp-Source: AGHT+IG4OgWR5u3m+0wBX5Xcr0bVIw2EUh3aGbGceiiEIUatTiAZny541Zi1rcyfgc4ESr53PHDDjRTOtMy3
X-Received: from pjbnd12.prod.google.com ([2002:a17:90b:4ccc:b0:311:c20d:676d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1f82:b0:311:b3e7:fb3c
 with SMTP id 98e67ed59e1d1-31c4cd1b92bmr1090992a91.31.1752179844197; Thu, 10
 Jul 2025 13:37:24 -0700 (PDT)
Date: Thu, 10 Jul 2025 13:36:52 -0700
In-Reply-To: <20250710203656.1963075-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250710203656.1963075-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250710203656.1963075-11-irogers@google.com>
Subject: [PATCH v5 10/14] perf python: Add parse_metrics function
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

Add parse_metrics function that takes a string of metrics and/or
metric groups and returns the evlist containing the events and
metrics.

For example:
```
>>> import perf
>>> perf.parse_metrics("TopdownL1")
evlist([cpu/TOPDOWN.SLOTS/,cpu/topdown-retiring/,cpu/topdown-fe-bound/,
cpu/topdown-be-bound/,cpu/topdown-bad-spec/,cpu/INT_MISC.CLEARS_COUNT/,
cpu/INT_MISC.UOP_DROPPING/])
```

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/python.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 728ed27986b5..2a8026a261ce 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -1849,6 +1849,40 @@ static PyObject *pyrf__parse_events(PyObject *self, PyObject *args)
 	return result;
 }
 
+static PyObject *pyrf__parse_metrics(PyObject *self, PyObject *args)
+{
+	const char *input;
+	struct evlist evlist = {};
+	PyObject *result;
+	PyObject *pcpus = NULL, *pthreads = NULL;
+	struct perf_cpu_map *cpus;
+	struct perf_thread_map *threads;
+	int ret;
+
+	if (!PyArg_ParseTuple(args, "s|OO", &input, &pcpus, &pthreads))
+		return NULL;
+
+	threads = pthreads ? ((struct pyrf_thread_map *)pthreads)->threads : NULL;
+	cpus = pcpus ? ((struct pyrf_cpu_map *)pcpus)->cpus : NULL;
+
+	evlist__init(&evlist, cpus, threads);
+	ret = metricgroup__parse_groups(&evlist, /*pmu=*/"all", input,
+					/*metric_no_group=*/ false,
+					/*metric_no_merge=*/ false,
+					/*metric_no_threshold=*/ true,
+					/*user_requested_cpu_list=*/ NULL,
+					/*system_wide=*/true,
+					/*hardware_aware_grouping=*/ false);
+	if (ret) {
+		errno = -ret;
+		PyErr_SetFromErrno(PyExc_OSError);
+		return NULL;
+	}
+	result = pyrf_evlist__from_evlist(&evlist);
+	evlist__exit(&evlist);
+	return result;
+}
+
 static PyMethodDef perf__methods[] = {
 	{
 		.ml_name  = "tracepoint",
@@ -1862,6 +1896,12 @@ static PyMethodDef perf__methods[] = {
 		.ml_flags = METH_VARARGS,
 		.ml_doc	  = PyDoc_STR("Parse a string of events and return an evlist.")
 	},
+	{
+		.ml_name  = "parse_metrics",
+		.ml_meth  = (PyCFunction) pyrf__parse_metrics,
+		.ml_flags = METH_VARARGS,
+		.ml_doc	  = PyDoc_STR("Parse a string of metics or metric groups and return an evlist.")
+	},
 	{
 		.ml_name  = "pmus",
 		.ml_meth  = (PyCFunction) pyrf__pmus,
-- 
2.50.0.727.gbf7dc18ff4-goog

