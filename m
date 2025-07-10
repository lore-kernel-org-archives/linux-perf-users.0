Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C739302CC4
	for <linux-perf-users@vger.kernel.org>; Thu, 10 Jul 2025 20:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752179852; cv=none; b=pOJLMXiyjWR1irl6YNTpjDi2xRm15I9hAFckFBkQplDl7UvH/hVjdUmGrcegY6+lNiJFuWQ7Zak54sPELwoCyOXI2DMab2oQbBkLm97qIg39JD01mPSLDZfhNTFVnapIsVvYTWjMtaRqKsid3lDKnpc1P6/qPbAOtzfgohRqDUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752179852; c=relaxed/simple;
	bh=kDqb/r0HccawH5czjXeqp65wkcljd4SqQ1ZhN3nUBRU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=f6OxWfFaB5LjJJIgEULHByEIQdfcpjq5DT/McqRWp4tfdU5r2gjt9UTP9UyI1Y2ObuWk5WTrLyhV7uWonJYpOrwvkD+Jt33i3KK4NnGQ7B7BGtzLaVB7KWcV4bbWUMC+NwBddz9vORfDfwFS9ivCiECToPR59+osdprks+Vo59A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4F049aKs; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4F049aKs"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-23638e1605dso10746615ad.0
        for <linux-perf-users@vger.kernel.org>; Thu, 10 Jul 2025 13:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752179850; x=1752784650; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ORft+ikg92kHFRcEMbKO4fnQ+ouMdhF5CZrp1etPobk=;
        b=4F049aKsEMGmfAAiwqVL+mfRLNKiEhj6ehgcIlJMgSQc7+uvQrIxlNM23VRMEfaoRK
         hu7ibS8SoH2rjvfd//oLlJgm+1K1VXn0kfEoatnFyB5zSNz+iMmjhKI7D6XSzq+Syt7N
         WXfZ1L2+wmpVs3V7uzzmiAp05d/WK+BXBw+wwfezJw+OcEyznDVAj0KmkVVz7GMF7kTi
         /mtJO8dxk+Bp/4UM5LwXHtmijRUlMQmUzMGBL+aTmnEfOEdfXSQ/1mwaha6Fgdj131RU
         GiP3EM1Asr6M8QxPn9DbardzNGjaL2l1dvi1gs5qr6PIEaygnjpvXkCtu+bYIAh2P0gu
         nUoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752179850; x=1752784650;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ORft+ikg92kHFRcEMbKO4fnQ+ouMdhF5CZrp1etPobk=;
        b=Lu6a9KgIvKOfPuKUZaxbz7V/IpZtCB+G0QvV1f1cBFgcw0zrjpJhPBWMLjvWUFqOTq
         tvGY3P3e5bEBOIK7M9imxGXEiOne/mYSHelm98LIWHxZetQLb4SHAm2uNbhYFlcGA6pQ
         aeBFRkZgc7g0bENxXKlVEVuYMnA6vrqb/4+ITKYrzzul0C5HrI6NjXEaolDDs+lOo5ZA
         mJH1EiLMGTsk7pdbVKiVClaDO6b2arX6YHlCDhhLoj8ESW/At6RT3y/CLWdkGWGuv9jT
         8Vof/cro4ufhLa5en0JxWGuZ40eNHq2E+YdoHJ7WZ1V/6eYOKEkBMCbnWyvr1oemgs5s
         mUrg==
X-Forwarded-Encrypted: i=1; AJvYcCWxN6YcalgT3zzSwuiMMdW6bsc+5bXL1Q79p4HBRWLIkGWbGphHcfSKtfyOx7yDIia7/UZ1dl3Xdb85EbW0hsGO@vger.kernel.org
X-Gm-Message-State: AOJu0YwivluAFSYbJjN8s1jgXvngT+fRj54WWw/sncVHP0Nq5+jMz3md
	HD+UJyS49Kg0CMbJnfnDmVIEp5HwtlC01N7IlKUxgVKOBgN0Y/dsWuICSYQ2gGFenbAKAc9PrfN
	iCEKMQN9fLw==
X-Google-Smtp-Source: AGHT+IF7CSSnIYMAeDnJXc34vUK1+ayrl+mTIe36PEYwSo090qFJfj9JokivN5DZncRiX8QFfjRbhMExHqIZ
X-Received: from plhq13.prod.google.com ([2002:a17:903:11cd:b0:23d:dff4:2060])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f70d:b0:235:be0:db4c
 with SMTP id d9443c01a7336-23dee28f150mr7139595ad.41.1752179850024; Thu, 10
 Jul 2025 13:37:30 -0700 (PDT)
Date: Thu, 10 Jul 2025 13:36:55 -0700
In-Reply-To: <20250710203656.1963075-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250710203656.1963075-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250710203656.1963075-14-irogers@google.com>
Subject: [PATCH v5 13/14] perf python: Add metrics function
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
---
 tools/perf/util/python.c | 83 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 41d290c43b7e..0ad14204c144 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -2037,7 +2037,90 @@ static PyObject *pyrf__parse_metrics(PyObject *self, PyObject *args)
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
2.50.0.727.gbf7dc18ff4-goog

