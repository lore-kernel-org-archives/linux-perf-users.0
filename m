Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1E92750FC
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Jul 2025 23:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753313014; cv=none; b=kuqgRtwxmw/9941GRouQlDG0jxeIiJ94jcO3suiSO0TgoNWasWfkJ2ucd/tP4fvPMMaq/nmD5tmgoPnIUj1tNG6NLNo/FYjSFK9S5RyV04HCoiU0QGvrz74bRxMM/27LU5OHCZ2ZCM2VOfrMIHwEYtuiJt+jOYXSLX7PM9AVSm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753313014; c=relaxed/simple;
	bh=/himY3eC7Z230jJ9df7QB/QiKXUXmGuN5KAZQf/rp6M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CKkmDVfQ6NyRO/idH+j4MmnSGwa5TOCl7RKYbLW2vEs16sFSKpcd7MDt3dhOxzDrrPZkdtnjSN579xcR4ZzCZYDRqbXUSoHHQu9AUqZ10cba/kkDGPYXYYHhndZd792IDTEbucAgt2HLcYAWuK428gr5nltVBhdBjRHqy8z+Mx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U/vxKKkA; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U/vxKKkA"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3141a9a6888so266658a91.3
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Jul 2025 16:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753313012; x=1753917812; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DG/WMio8wVCpnUQBjwF3J5hHGj8AkOoD74Vnrlwpzz4=;
        b=U/vxKKkADIG2raZyehZvQuTA6tpnEJ0IUY6vWCYYkLVzHVEIOVPhnhA6omYUZbBW94
         OmJI53luhsDiN6SaHlpUqt7FsdvSKx/PXniVdiPXYMowPxxK9GCjWGU0YA0OkDxLMnZn
         EF1sxO1e1gA+Kg9HSrZ9MtSlIAH0BVRucjqLVHOyh7A8tHQL/jnlrfVNiINA+HN/xzdU
         Ek34WCfTgiB/FUbrwkAXJuf9tXCGaj3FSdBKHAcGYj3dK9ne4GiTmD+UizqU3NOHWXdO
         W2DJjWSxuTsUD1LwzuqzUYuOxRLjMPDBE3WRRQJLvfmVy7bG5y8l/USK5q8Ho1+yPhN2
         3OvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753313012; x=1753917812;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DG/WMio8wVCpnUQBjwF3J5hHGj8AkOoD74Vnrlwpzz4=;
        b=VaulGhzo1fWwlOE0x0DvXYzGzLCYDUqWIRZEVWt33nRRDXDoDfyntxNXsxxUWxuAX2
         PdjuC9ID2PtII4A9UpkwagCCr19t1RLKqHosOD8Pe6tP3qx9Z1D/kQ/6KcbsuMQkW/IZ
         27zHlGI0/iGBK2iC1qhv8ZSwYqfmySDYwRVIuqC+GgsTw1hMuR8os4n+qAHLQLeITEQs
         YiyUYBcspWzbJNPBSV2mRh98O0esvd6p/s0BiyvgYJcnAIaNNNP2Uy6a+G7pf4CBdmhd
         6WA7CSy4QK3BaY3D/+0y0VJpfmv9AabU82ynhUbT93RHYJ19HMoK48FQAExEcyKVd8Xa
         Frlw==
X-Forwarded-Encrypted: i=1; AJvYcCV8B4aOfI90yYEN//pSMtRGcW6505H6GhBxrP+fklTrpSkHlxDq26DPRpk6iolZbQyVdhZ0qeDUXH01yTP5CPHZ@vger.kernel.org
X-Gm-Message-State: AOJu0YxHnf5jr8ADkQb62YGEsHOVXL/wsW+0yDSnRylqxPJn0yxY6cqd
	vd++9XKix8prGp0FM717XzwZlZ9CGE5goHD105/xjjfrUEvlc9lQ7Y09B3pi5mSSXB6EzcArxOb
	7ZSnqgTMX7A==
X-Google-Smtp-Source: AGHT+IEIcgmHXPNBSG6BQ36NaMOBP7BbcFIM4B+zrx3GD0vSuUDAyeqf9MFMWze7IE4f03SMmi0lIAe3GQvx
X-Received: from pjbqj14.prod.google.com ([2002:a17:90b:28ce:b0:313:2213:1f54])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2d0e:b0:312:f88d:25f9
 with SMTP id 98e67ed59e1d1-31e5073f879mr7422728a91.7.1753313011856; Wed, 23
 Jul 2025 16:23:31 -0700 (PDT)
Date: Wed, 23 Jul 2025 16:22:13 -0700
In-Reply-To: <20250723232217.516179-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250723232217.516179-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250723232217.516179-13-irogers@google.com>
Subject: [PATCH v8 12/16] perf python: Add parse_metrics function
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
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/python.c | 41 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index d49b4401ab7e..3a58080bab24 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -1881,6 +1881,40 @@ static PyObject *pyrf__parse_events(PyObject *self, PyObject *args)
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
@@ -1894,6 +1928,13 @@ static PyMethodDef perf__methods[] = {
 		.ml_flags = METH_VARARGS,
 		.ml_doc	  = PyDoc_STR("Parse a string of events and return an evlist.")
 	},
+	{
+		.ml_name  = "parse_metrics",
+		.ml_meth  = (PyCFunction) pyrf__parse_metrics,
+		.ml_flags = METH_VARARGS,
+		.ml_doc	  = PyDoc_STR(
+			"Parse a string of metics or metric groups and return an evlist.")
+	},
 	{
 		.ml_name  = "pmus",
 		.ml_meth  = (PyCFunction) pyrf__pmus,
-- 
2.50.0.727.gbf7dc18ff4-goog

