Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF672765E4
	for <linux-perf-users@vger.kernel.org>; Tue, 19 Aug 2025 01:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755567631; cv=none; b=iwMAo956nVX3MPnqqT8UHvcqf+xaJA6a9yXx6eONAi5Q264Vh9oDfNJritsPSJ5AnNX/uzXpuSWelXOq0U3ZRkrodC7ZYiCNHNnNGjpEZNv8ux/j2kw95Xa6YGCiahlj/LIN1g0c9xhaLI2XqKD4Dv5gjcK4goVz62skKVGfiRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755567631; c=relaxed/simple;
	bh=bMogRmk2v/hpy/Se06GD5oraPWc0hCml5uLqL0OQKyM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tIlYO5DKBIOm/RlNJwJJM4lJUAL5K5REp+rJ1o7/tl/X9JixY7pzIsSghvLVgUXKys/MwdoNt7s+5Yb3T8mhTnWl7lO/gibRunmOVe/qwhSMRjtVGFGV81CE+XLSWTga27P0c8I6KJLzteLm2+8hZktAKkwnhBng1FnLDxDF2MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PtGqpq13; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PtGqpq13"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-24458027f67so112492325ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 18 Aug 2025 18:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755567629; x=1756172429; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=g9s37lLgOScEp8T9bbq+nm4+bsOcVBIeJ4ZJysGLqso=;
        b=PtGqpq13z2SmZT2vvlPtEChZaQWslFM2FXAO8N0xi0A5K5xwriLPV977EXWLCAoF66
         jJm04aEywfFj15Ixh2wJE1+pXrjQwaz2nPEozQCeBh2M3+8/6OJyzI0fAYKLXEQqCchb
         qBn9KDKdz4ti/N7IGApYjDnPSOk5vEmcy15JneX6rihBZk9RuxA6Gsyd5NRIdHr5h3y7
         AYcbY0V3siSrRl46cgUygzkTouXONV6anGHIWfHQy8jJGP1dzbBKZ4tHu0apVIpOeMT5
         7vmRyOUXfoJ9KyqXuR1x8qvZxikmGz32Su4jrE56r3e4O6lCVeKZ1eWFVa8AK32zvF7y
         sDnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755567629; x=1756172429;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g9s37lLgOScEp8T9bbq+nm4+bsOcVBIeJ4ZJysGLqso=;
        b=EjJ9LmGAt4Dv64SY2U/AUZPN55yNw9qqFvi110v0GLzqWvcXxlS1XpHpYGs8RioKvM
         Ya5rwpz5oG+E5R4ntnxcvg51FDuONmzzN1GAQ5+8PKAuFMDSSykngUjIvfgEAeTvVZBa
         CJocYTcuNfbvsjsvBk4POWvJrYu8liDianLZ1xFrkiTRCOv+xW0/puq2t+xGAaBR2GIB
         qIMeJuH6LDGwUkl0ZrDduM+ZHQW+8GyV7pK03oZC6zXLyt6hL3l4iH/78EGg0sXQRKIC
         bO4XlsE3jMtswtkq+jCFNdFTaEGX5cg7fIpMty1dJgNZb5jp1oHJZuYgYhUuQMm9SHwf
         xp7w==
X-Forwarded-Encrypted: i=1; AJvYcCWSaHAR7G7gSG1q0I20flDhBpzoRaqxRol2nKBjXuAae076O2vkX3AnjM0QeS0/51Al4wX/OLuL1ktHrBRLFBTp@vger.kernel.org
X-Gm-Message-State: AOJu0YxwCUqv+AXiIxBxD/Yxe+AG5T96Sjr09u9yU2f2kbAMNs5KeThC
	5Vu7pxQvsI+T4IGq6qZ8WXqCrlrS8B++lEMcrTm2sTmnauSN6R7gQ02OUaqTisJ06CoWXGSHCUF
	P6UQx9ozlYw==
X-Google-Smtp-Source: AGHT+IEIIVLT8RvPny3ldxOSOzYu2i+t0KStGenB8Zlxi31UoojIJ+9B54z5+AojHycbg81m1BXFqNuAJvIK
X-Received: from pldw5.prod.google.com ([2002:a17:902:ca05:b0:23f:fa41:1de3])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1251:b0:240:96a:b81d
 with SMTP id d9443c01a7336-245e02a4fd7mr11046085ad.5.1755567628966; Mon, 18
 Aug 2025 18:40:28 -0700 (PDT)
Date: Mon, 18 Aug 2025 18:39:36 -0700
In-Reply-To: <20250819013941.209033-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250819013941.209033-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.rc1.167.g924127e9c0-goog
Message-ID: <20250819013941.209033-7-irogers@google.com>
Subject: [PATCH v10 06/11] perf python: Add parse_metrics function
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
Reviewed-by: Howard Chu <howardchu95@gmail.com>
---
 tools/perf/util/python.c | 41 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index cf1128435022..48308ed4e1c7 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -1891,6 +1891,40 @@ static PyObject *pyrf__parse_events(PyObject *self, PyObject *args)
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
@@ -1904,6 +1938,13 @@ static PyMethodDef perf__methods[] = {
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
2.51.0.rc1.167.g924127e9c0-goog

