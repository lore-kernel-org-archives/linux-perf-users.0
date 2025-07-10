Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6095B30AAC0
	for <linux-perf-users@vger.kernel.org>; Thu, 10 Jul 2025 23:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752191899; cv=none; b=BPjG8jME3FTqxAKux7JJzkWRS3vPtGjVQqecwWrwa8ALhDVW8PtelioAvDh3WOnC8ZcrtNDooTiGSG2dCOKaJhxsODcFh+x/5d1dD7VxXXgkebqCEwF81q/lIYGX7udIGqRVMlGv1gkp1rOYibDQQhc6Y32XljPd1KzVWZ7xMW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752191899; c=relaxed/simple;
	bh=RB31l5rvv7bXNl751djYesBa+aOb9K+m93D0BvwGHmg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=RGxOT52vKOR+tYLA4Ull6neh7/ZZRM2uuKuACPARx+PVMfMCdrh2mP9Yw4PvGVKrfC3IS35W3dS+Ar7laKO7MhAyOI4e7LT36bxXQ/uLowQyILE8c8HZ1uBSRDCIZ8yGpCm3C2bDPXCNf8ldnSsvDKX/wpuxckaEFoiboFTc3q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y55IGV17; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y55IGV17"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-235eefe6a8fso12509515ad.1
        for <linux-perf-users@vger.kernel.org>; Thu, 10 Jul 2025 16:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752191898; x=1752796698; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NEm6BmU3nejut5IA8hvIiLbgDct6ibXEQqve0f3fFRM=;
        b=Y55IGV17GR7ezK0EBNSENfE2dRxQKP8Y7cjrOOqwE0FPRBDkOpIGZgA4t151WUHObi
         CbXAjelPbQDLtEM/hFI+fvvVIkryXBA8vKpByiu9ICTMDf1ssQJvW6aea/KXksmmBDxg
         d4dMsstv1dgOqongeFlpPyRwvBxg7WwuBlGNftUwrvpqe964H2xh/WNtjfrSVKN1XyUy
         dij1l3rkXHn6PBhkgIA/44aZz6hmDZPk6VQV84ongI5oyhf2hVM3kKDu5BnNK+ZcG/nF
         1aLObs5zaKXvHO0SIIBTfnsrDDUeCRtlWSyOT6wHwTFp/Hi+4MeOjvloWF3vAIWfhWLN
         SdwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752191898; x=1752796698;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NEm6BmU3nejut5IA8hvIiLbgDct6ibXEQqve0f3fFRM=;
        b=PAOyw7xkjtqs+AS36m3enT6luR+4lRgSCdNAoi911y3NBHJEPRuW6Zsl4vzAxF08dk
         vonT4k8+MMPrMdMynE5RscgUSlGdB2X6O90+nUAdyuDkg/WtDgJw8DPAqHirGkJNyPX2
         Qh/VaStmyJn6ZKvHpfGRubGKnPEOlTer4cI+bPa1dYOjqgI1NjpE0wKWQDQT2TBJFJbW
         iFPP/J0bsoVDU26bcjMMaEJ/of6qJImMF8gmGqbKGicLVJip2FqLZCm8oCMreYkAe/tg
         WR2e4bhvi0ZzQ1idlgg5/Z2zi3XkvtGxA2ybUYk82l9ue+ErGKL0zH4jjb45NyG/GY7E
         Mz4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUZUoI6+jpvZ6qDIkUuVpv77On/Lz2ARUAwnZjm1AVuKIDeoYptPygcPpxFkz2/0AuYYT4pXN+kGCr9OurRcpnl@vger.kernel.org
X-Gm-Message-State: AOJu0YwUus3rVf1XXy1V9+XAzqK29hrnfI2u25U4aI64Q5JjmCpmJ/rZ
	g5gMhb443pMIy7Zz3/nysLsT2gIAyTn9/04c4C9jRS9Z2QkEFmcJW7xhtG3ixEB8iWTzCIGfKrz
	Oer/9BU4h+A==
X-Google-Smtp-Source: AGHT+IGfWOoAN8B6DF6uTCCRlm7nDnsNkzPD0PDOFWef/wSPXpUWs0n7d3KCRyajMm75YCnlkNO0t/uiCvsR
X-Received: from plil11.prod.google.com ([2002:a17:903:17cb:b0:23d:dd69:dd11])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:c951:b0:237:ec18:eab9
 with SMTP id d9443c01a7336-23dede856d2mr20908525ad.32.1752191897699; Thu, 10
 Jul 2025 16:58:17 -0700 (PDT)
Date: Thu, 10 Jul 2025 16:57:31 -0700
In-Reply-To: <20250710235735.1089240-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250710235735.1089240-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250710235735.1089240-11-irogers@google.com>
Subject: [PATCH v6 10/14] perf python: Add parse_metrics function
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
index b0bd4dc27409..46153a031dc5 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -1877,6 +1877,40 @@ static PyObject *pyrf__parse_events(PyObject *self, PyObject *args)
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
@@ -1890,6 +1924,12 @@ static PyMethodDef perf__methods[] = {
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

