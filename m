Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096A326B2C4
	for <linux-perf-users@vger.kernel.org>; Mon, 14 Jul 2025 16:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752511480; cv=none; b=VZJg9OWgkw2q1d6BN8xKe9rZbutnQWytPce1O9pSr1rXm+oNhVRE0QDlDjepsSIBju7rFlwqLV+ExjInwboqNRDhSFZkaxMkvBxwxbABIMTL+jDXd6Ogx+3C0pRXkTp7qtpppWMbv033gibox72gtitOsaHbjI5RtlA3GthOHIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752511480; c=relaxed/simple;
	bh=ve0a3kiHbzdzL6vitXxRTN5F7iUejaRmRyIO53yAgos=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=BGXhuRNPrglvL2Af46wUA5y8n61RWEuQ/dF0TlhUwkNdjMo6mtRSz/cGPrZsakTrZhK8/B8BjNTyJR3eg6LItBFpipmTp09Ynp2sTFJQPDvykv/FpUvuxZKdZUNH9RB1qWHO/GkciczJNDiSJQGXmcnumEsw8vGL1ZfdyTJe7po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Cnrmz7bG; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Cnrmz7bG"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b2fa1a84566so3550234a12.1
        for <linux-perf-users@vger.kernel.org>; Mon, 14 Jul 2025 09:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752511476; x=1753116276; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LBrQjRD+RyRS4n3FD87eWVbCUfRizAfyHNyOJV4bxZg=;
        b=Cnrmz7bGqjdGILA2LmDr57trZQN8HF9TUszKW8vVYzGOgBet6Ap2NguPLHHTpUI/kT
         fa2XQp2sAc0SulFBewxIVvYcPrbYdt4+ly0kV25Rq7m6i33qfrFWJXBVEalhB7udeH36
         0RLmg7rSVRCx6JcGPi+nLi4XfyyKQO82iisoKDLzFCNoCWGVF2GQcmYVIaUXhT3fdHl3
         8JXJp7s6joAWtUCqKzVtAkkDuv4wU6+7rGKP7Ui6glGyLcyoNWBZXMkFXXoXDVMauytO
         qWSTQK0lSfMldlspe+5tke5PEo9MxKFAVVW9rs2UcYBx7yMZNzcfmEC58pmiFbHYLQTe
         fxKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752511476; x=1753116276;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LBrQjRD+RyRS4n3FD87eWVbCUfRizAfyHNyOJV4bxZg=;
        b=N02dV5y0SC1eqXid8ckW7IAzX7Ty5Z5jll6+WS5O4zFMndanezm3UOJwAIWj6K8b7r
         OsAaUwDLz1KKxyc9/dXFyC69c4o2sxqMyLjFkP0/v3LK/nWuv2JTJOT2faA+7fpnvl+o
         VnhMrFJ32ho2CCiDOycW97RjDffb1F/oVscg6Vm1EGCcKZrBO5/Q+Ryj/L0EOSTLxj5j
         oz2tFGMaqvE5XUH7LpuxggwrScQI23YI7bKY8hfnno7UiSYTZFaPAhT5ZW1ue/B0qZhN
         hKqytVGyOAhp6kAeQxyHtCqaGbAkWSu5/CA32b3JkLzs+2GjBBteZkzguuSGdfNFeCLH
         1OuA==
X-Forwarded-Encrypted: i=1; AJvYcCW+MfuKGX21fa6T0kT/dLlCJZDT8CokDS9ya3++ImP18df4n8OclFeKZZVfS/q8J4c76pUKyzLvFPBErBv3kZDW@vger.kernel.org
X-Gm-Message-State: AOJu0Yy458ds/l1JrRKfU0RZRphfZS5nLCIxbXIzi7cU7EZPDWtnfiHy
	upLzqJdYmlsGBP9oU+5mPvQW3fmlGoQ6Dt83tzur1s8F3hoErtB9sW213acj/vWE+hqqRqE5AAl
	iiCyzNOZ9hw==
X-Google-Smtp-Source: AGHT+IETg+t2Oyre4ygOG97JlGqU5OW3oMshn74NNHi8h6Y/ORY/rx+ofdV0WND0EMKSGYKQpk+QvVXQll2k
X-Received: from pjbnc5.prod.google.com ([2002:a17:90b:37c5:b0:31c:2fe4:33b6])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1b50:b0:318:f0cb:5a50
 with SMTP id 98e67ed59e1d1-31c4ccf3240mr19859859a91.26.1752511476425; Mon, 14
 Jul 2025 09:44:36 -0700 (PDT)
Date: Mon, 14 Jul 2025 09:44:00 -0700
In-Reply-To: <20250714164405.111477-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250714164405.111477-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250714164405.111477-13-irogers@google.com>
Subject: [PATCH v7 12/16] perf python: Add parse_metrics function
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
 tools/perf/util/python.c | 41 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 845476411576..6454f24cd810 100644
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

