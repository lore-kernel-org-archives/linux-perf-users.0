Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2997D27B4FB
	for <linux-perf-users@vger.kernel.org>; Tue, 19 Aug 2025 01:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755567637; cv=none; b=J31YKJc+eB5J7EEHZHwf1VW3nfrUpF8Rc7oOIrrz0/sBocXTYO4CXjdKwrGqR3Wj+BXgHqbQmN45uwCKoi38gTlQuMDixdwoBBY8SHWcHgbtsvVfn1TujUqKJcBQFtb6wa/q8ug5o4PyClNC2J1xSk4kyAEVd/7SMGJuUwV2PiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755567637; c=relaxed/simple;
	bh=54O4qwPl3pYABWv4bHwl6c0YHU2Dn9GO8qnhYsTvTU8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZGD4z2mNJnTVlk/hXBrg7gnCP7lAYCMWQdmTw55CSv+3bjQTTFujlQYgZQkAE1PO0aWlWpMJxxErraFZMAYWkz1hUiM49b6ptp5vaZ2ysxtzFirvkLHZzbCqk/fipelwY//yvRZ75d6Q+0yPUr457mZ/S8rCTM3o/mxKQopSEog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r31LgyI1; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r31LgyI1"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-323267c0292so4404959a91.1
        for <linux-perf-users@vger.kernel.org>; Mon, 18 Aug 2025 18:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755567635; x=1756172435; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rmibaETcnJ3KysxuOmPon6EiiVF0b4+yUjRDx5iYegU=;
        b=r31LgyI1QvWI/uR4+CkHhOQyw6peNq2/+uQ8SfsVjh4qcetoGnjuMBVkSzWbEgwUGK
         aY8Hg3EzOFQr/Cec8boLXtJ4QWvkJy8/fmnpdWyoDa5efO60KNEnibkqYLZ1qcbt4An+
         efxY3X8HCAftmQ3mQ6mYNzvvWyeuWDWi3upqnIOzblU0beHlvXseUWfzGg8/R8prIorc
         8ipwosiOqOobDCL93562Fn2WexXGNnvWf7mayR48GXCFqQTCBbZYf0UmGzvbHJG6ZI3v
         Vfq6Z5I5GTwFniEimAWCMcPUR6PinzEfKXMqS6TGLBPh3pTZeyGIbsu8/8EDpAz8zr1o
         VPzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755567635; x=1756172435;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rmibaETcnJ3KysxuOmPon6EiiVF0b4+yUjRDx5iYegU=;
        b=jA4amCgwOHjvGARrCBrAH/vPUA5AciqxMFbgNdJ4YVox7WTlNZYQRhw3QwwHHINvH8
         jZMxY0nL+rokUF6RyQIC1Hf2/jJmZQwpDp0mwJ1efHKq0uD4g3HCqc/6ISf2E1hUwkw0
         xix2u+510pslih3EBetySDLP7xizyGftqNRETvGv7pFaCOiC4UCM2CxWsfkiPBt/Nq7T
         IFdif4CfR383iNhmUZ21OQ0bDyYe14mU5Cy0sEpcKXNP6D3iV7zH/nR6i5P6AcntYSb7
         W4uct4aGJ/nKVbi8TJvdltkxDr5fYfjLSQIESmdjXASFKizqqeVvKU6NM6/5q3bn1vQ3
         RINg==
X-Forwarded-Encrypted: i=1; AJvYcCXk1gzBgtmtr6+4PuBWYkSmA35YssxduDfWDPi6Wbe+Duztsm+QxtHpbpmo+oFRfXppjec4fcui4zDcQsH0B0pl@vger.kernel.org
X-Gm-Message-State: AOJu0YzWtfY/i3C9cQku1YoVc7mtyCtcbLpMGNKesdRjuL+wSmSBFMix
	RJCKwpQU6/Ij8fPHqlR+45/AimG8+c32qWBExGWKhJ3MzYd0Ej1qhT4uMd5IhUAWvjo56MMlqFl
	3rASnabVunQ==
X-Google-Smtp-Source: AGHT+IF8dlH5fhV/I4zHE0ctt3jtWDWmAghBmvFvbGWFwUX1pXP8P4UaRWIlz+JUjNVacfJJ9QXbdTj8JyZv
X-Received: from pjee16.prod.google.com ([2002:a17:90b:5790:b0:321:c567:44cf])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:42:b0:313:352f:6620
 with SMTP id 98e67ed59e1d1-32476a4a2b6mr1363114a91.4.1755567635430; Mon, 18
 Aug 2025 18:40:35 -0700 (PDT)
Date: Mon, 18 Aug 2025 18:39:39 -0700
In-Reply-To: <20250819013941.209033-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250819013941.209033-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.rc1.167.g924127e9c0-goog
Message-ID: <20250819013941.209033-10-irogers@google.com>
Subject: [PATCH v10 09/11] perf python: Add metrics function
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

The metrics function returns a list dictionaries describing metrics as
strings mapping to strings, except for metric groups that are a string
mapping to a list of strings. For example:
```
>>> import perf
>>> perf.metrics()[0]
{'MetricGroup': ['Power'], 'MetricName': 'C10_Pkg_Residency',
 'PMU': 'default_core', 'MetricExpr': 'cstate_pkg@c10\\-residency@ / TSC',
 'ScaleUnit': '100%', 'BriefDescription': 'C10 residency percent per package'}
```

Signed-off-by: Ian Rogers <irogers@google.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Reviewed-by: Howard Chu <howardchu95@gmail.com>
---
 tools/perf/util/python.c | 86 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index e0769538b8d9..56102034d5b8 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -2083,7 +2083,93 @@ static PyObject *pyrf__parse_metrics(PyObject *self, PyObject *args)
 	return result;
 }
 
+static PyObject *pyrf__metrics_groups(const struct pmu_metric *pm)
+{
+	PyObject *groups = PyList_New(/*len=*/0);
+	const char *mg = pm->metric_group;
+
+	if (!groups)
+		return NULL;
+
+	while (mg) {
+		PyObject *val = NULL;
+		const char *sep = strchr(mg, ';');
+		size_t len = sep ? (size_t)(sep - mg) : strlen(mg);
+
+		if (len > 0) {
+			val = PyUnicode_FromStringAndSize(mg, len);
+			if (val)
+				PyList_Append(groups, val);
+
+			Py_XDECREF(val);
+		}
+		mg = sep ? sep + 1 : NULL;
+	}
+	return groups;
+}
+
+static int pyrf__metrics_cb(const struct pmu_metric *pm,
+			    const struct pmu_metrics_table *table __maybe_unused,
+			    void *vdata)
+{
+	PyObject *py_list = vdata;
+	PyObject *dict = PyDict_New();
+	PyObject *key = dict ? PyUnicode_FromString("MetricGroup") : NULL;
+	PyObject *value = key ? pyrf__metrics_groups(pm) : NULL;
+
+	if (!value || PyDict_SetItem(dict, key, value) != 0) {
+		Py_XDECREF(key);
+		Py_XDECREF(value);
+		Py_XDECREF(dict);
+		return -ENOMEM;
+	}
+
+	if (!add_to_dict(dict, "MetricName", pm->metric_name) ||
+	    !add_to_dict(dict, "PMU", pm->pmu) ||
+	    !add_to_dict(dict, "MetricExpr", pm->metric_expr) ||
+	    !add_to_dict(dict, "MetricThreshold", pm->metric_threshold) ||
+	    !add_to_dict(dict, "ScaleUnit", pm->unit) ||
+	    !add_to_dict(dict, "Compat", pm->compat) ||
+	    !add_to_dict(dict, "BriefDescription", pm->desc) ||
+	    !add_to_dict(dict, "PublicDescription", pm->long_desc) ||
+	    PyList_Append(py_list, dict) != 0) {
+		Py_DECREF(dict);
+		return -ENOMEM;
+	}
+	Py_DECREF(dict);
+	return 0;
+}
+
+static PyObject *pyrf__metrics(PyObject *self, PyObject *args)
+{
+	const struct pmu_metrics_table *table = pmu_metrics_table__find();
+	PyObject *list = PyList_New(/*len=*/0);
+	int ret;
+
+	if (!list)
+		return NULL;
+
+	ret = pmu_metrics_table__for_each_metric(table, pyrf__metrics_cb, list);
+	if (!ret)
+		ret = pmu_for_each_sys_metric(pyrf__metrics_cb, list);
+
+	if (ret) {
+		Py_DECREF(list);
+		errno = -ret;
+		PyErr_SetFromErrno(PyExc_OSError);
+		return NULL;
+	}
+	return list;
+}
+
 static PyMethodDef perf__methods[] = {
+	{
+		.ml_name  = "metrics",
+		.ml_meth  = (PyCFunction) pyrf__metrics,
+		.ml_flags = METH_NOARGS,
+		.ml_doc	  = PyDoc_STR(
+			"Returns a list of metrics represented as string values in dictionaries.")
+	},
 	{
 		.ml_name  = "tracepoint",
 		.ml_meth  = (PyCFunction) pyrf__tracepoint,
-- 
2.51.0.rc1.167.g924127e9c0-goog

