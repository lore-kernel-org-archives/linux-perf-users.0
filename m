Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DD7260585
	for <linux-perf-users@vger.kernel.org>; Fri, 25 Jul 2025 18:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753469567; cv=none; b=i9VMTkDgHoLV7skx8/hI3B9i8A0COPXfYZcNaFtGoV7qtcc3Ij8j7NFw6CTXS0BBOdeNhureDLLPub7D2lJjxc7iQ8CGgNzmA7CZyDTMdLHu9jM+BUZ+nmpXgOpafStws7dBlYvwEWO83Iw5Q49LObp3dsD9i95IpABe7qSqJoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753469567; c=relaxed/simple;
	bh=nwIPXmddXA1zM4816Vbz6lPdTIjBK/CaMTkmHr5EAk4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kyM+cwrFqyqxuYEarrBVADC+belEpMDsJ5YO1SOXW+XW+Q+8klWKQU40J5JsoJzKoIhwfLmNhwfJAo5FzhIEVY8v3ylmIqqCyhjceFqts7AhN+SidhfJTm2rGMbFvq0Mzg9LiWEovklLjf3xlZqDfoht1i7uaDJ/wC0HYqd6AFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EcYnRGsZ; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EcYnRGsZ"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-74943a7cd9aso4209251b3a.3
        for <linux-perf-users@vger.kernel.org>; Fri, 25 Jul 2025 11:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753469565; x=1754074365; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zTJ3W0ByLpHZ9CXRNmMdi9xgwMpplNAcPbcEQMrdjtY=;
        b=EcYnRGsZsq2lKyJxQPjsvJip36Z044qPci8sDCSiCI89eg5blL3KvxfeFI9gQt0Bo1
         dQ5RaxwsDh3ol7zkNxx5RhyQ8VHPpVAuvS8BBhkv7k2gTdauOFuDVqf2+uU7UzbJ7Tnb
         PtS6Jpd9mWqUcOMSE87dmjojgKaIGtGwUZZsilDHRvjnUqbhwA/O/DPIvRDWW9v5XPGC
         NzhCcjM57n3NMHVOB4vGK/3A5w6L0K1aLq9r+yU/DMe5ui8HrxrSYQ4AuS+AYbekFG5l
         oiOR2G39q2aMAkWu1IgvT+Wi2yakWhBSsc/l1WxKxRFE+E8YJE6xEI6eNhtznRpiKMhw
         L8Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753469565; x=1754074365;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zTJ3W0ByLpHZ9CXRNmMdi9xgwMpplNAcPbcEQMrdjtY=;
        b=NzxhtcgaUpVOw+ZnFpSN54oHEDM3g9BUnpCfoe8B9PIpGsZRelGVcIqjXbJIu7x+4h
         /QOSRqGRGfPU3hAIg4VCOKhWC4qldtJxZgHEMeHCwF7k/1EI0OrzNRwxJwTHgA9vKH0w
         jEk52tufwkgLUuEU5Pw2aCMFYYtqyGLnq7n4lTEDmrG0zt8ZPjb3m6x4FE0GDGu/OpbS
         dlY2v4EoJjRBTkstwnI1vhjvZaZy+7s0hRtlrYE8yApnCu8al7N2HT3v5oswoErrjyAt
         QrHEbKSc3rMYmbgytyylzVFryLLEfDSvVmEyrpvuDBgr9EFDIHwdMAVQ/g46uDX0wKNl
         k6zQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5Suxu3Pz5ExVsHsyd8Qab3UIa1tfOPaQxJAktT53I275dqt+txUiNdB2h2Gw+E9LuVA+X2CcOM8RM4fk1xEZr@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc4pDYkMqBXOzfgEGdVfN+rXXx0hoKpIMtsr8paIOP0lrF9ocW
	dGz3VgJ6xkSZ8WnW6u/mMSnZrqaSo1k0f4g+qR2KcpRvt7p4O/RplGOEW1sWcpiDuVFZmAZDmXL
	ReZeUTYzomA==
X-Google-Smtp-Source: AGHT+IFxSOul8ScKq/4q+dfu++ZwKGFNHTMTnkU9owlfUOg4oAViLuM+aVMlEXBYML2I8AovmEy1y4dJRHm9
X-Received: from pfbei31.prod.google.com ([2002:a05:6a00:80df:b0:746:22b3:4c0d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:970c:b0:215:ead1:b867
 with SMTP id adf61e73a8af0-23d700d3688mr4110328637.14.1753469565477; Fri, 25
 Jul 2025 11:52:45 -0700 (PDT)
Date: Fri, 25 Jul 2025 11:52:01 -0700
In-Reply-To: <20250725185202.68671-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250725185202.68671-1-irogers@google.com>
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
Message-ID: <20250725185202.68671-16-irogers@google.com>
Subject: [PATCH v9 15/16] perf python: Add metrics function
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
---
 tools/perf/util/python.c | 86 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index bee7c8a69bad..aaed7745df22 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -2073,7 +2073,93 @@ static PyObject *pyrf__parse_metrics(PyObject *self, PyObject *args)
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
2.50.1.552.g942d659e1b-goog

