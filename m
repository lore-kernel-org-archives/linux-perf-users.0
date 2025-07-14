Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9345726C3A0
	for <linux-perf-users@vger.kernel.org>; Mon, 14 Jul 2025 16:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752511484; cv=none; b=ZAH8IraFuSn93IfRG89gedsa/5m51qz7F9ytdX19NV5/f2LPgBQHX6Xq/6yvLnEOYA52a113ifddo2A5HhRo404Z3rPpQl9aFJtbdYk/e5vLsEPL+xfGLqtS3ogFUy4A4dSW33o+WUq+5cunqhLB9h92v4VoDDaCesQRn/6kUiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752511484; c=relaxed/simple;
	bh=aJ6/8ZhSvQzq5TY1hCj/xqap7KXItqlOsAv8EG5ebaw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=D6xY100ar83iRmVfheQOiyB9t8zO9DlR7g0LXA5NuQ1oz05uwFsE0bT+DocEaeuH2xstFmNCgHkgCeCN2KoTGV7X4jQvNxKSqpTtWlEUR/5dXL83PQvPR/jo8mA/3JVCU9kMpJHvRz2sMNnovqgK9kreQvSCpOpIvo2mExYmsaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M5yvLoZZ; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M5yvLoZZ"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-235e3f93687so68023225ad.2
        for <linux-perf-users@vger.kernel.org>; Mon, 14 Jul 2025 09:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752511482; x=1753116282; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PUFOv2lAYw6avEGImH+vbXrVUmOGfP5Tl2a811NS9bM=;
        b=M5yvLoZZrY27H4EY9xCeKgMlE98mHMtCEVEUoyrXil9U6/2w8/hBm21aoVA2UyLvmp
         dvjqSG5RxkUz4/ey/BT0HRvO57Nwc7i0oX4AGNLLFamHBvKXljKodBZIWsYkHq9aA/e2
         bvL2qJQ/rRIgRSWSLlqYCgQzO3hEDGUQZVxfnzJ1RQiTXU0KrinFVtKdsVoxRHc561x0
         elzpXWHO11ijkrwEEIesJsPU1G0CnZlv9PU9HyDpPdMGnW7UqQb6N5QUWnTzoBPYaLZR
         d5phU5A1bjDedFVd91M5eZiqIUM8UI0E/lfXASOv11c6P/xlbxIp4p034zYSHfr5X48A
         gLPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752511482; x=1753116282;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PUFOv2lAYw6avEGImH+vbXrVUmOGfP5Tl2a811NS9bM=;
        b=lVus8S7OS8Gndp/WCqKJ6nHsgksLQLSB5xzO+0qOBE45B3s1/qMtrb3AsZf1ooRJDt
         04P14w0w5Ul8HJHYV5dbQcNecIpkJC8m/VGiRdpoQlHatjEhTpIuXoc7B5c/fzueLTSp
         030E2MiKUUmuIEA//fb1xSfvh1zymbN1F58wm5e/Y6r3sTt6drTnq5bTDU4G+v48mYdy
         GKRbvvE5ZLmTfc/6YMb17wQr0pYjCSuW520WyqKeWTLEfxiXhB3/DzLjh6koTzY+jSIc
         T5S1e2kJzNtS2/vjNgpHWS1wa1k8a8twX7qqm9Qly47lKf26sQcu+B5kSePHFSwskH/9
         Jdvw==
X-Forwarded-Encrypted: i=1; AJvYcCXk5U7hu/bV+b7+j2WROu9HHKT4NKh2R8l9NZY0+aYIX0SfBgpW3a++p4g+ekX3VdLO6Le6tTrMS0Y3mzDYQOLP@vger.kernel.org
X-Gm-Message-State: AOJu0Yyeek6+XqOG9r8ssnMv86huaWoFX1KtosnoDWLk/abDpo6f1wBv
	c3zOcAD7/XozXRUO03DnOThwGBOhE8ljMukDEDWew2yyObAyglTq9+V3I92uywuT1+2bh1Vd8pQ
	vcHL4AlvthA==
X-Google-Smtp-Source: AGHT+IG1ZOKWVzJHHyDa673yvmMcz94zsQFKtt1swPkx1UN0RNqhTzSEzEVjcqGjhZ4/b2nkL0KuhOIVm1KR
X-Received: from plhv12.prod.google.com ([2002:a17:903:238c:b0:237:cedc:1467])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e946:b0:235:5a9:9769
 with SMTP id d9443c01a7336-23dede7d623mr175964595ad.25.1752511481915; Mon, 14
 Jul 2025 09:44:41 -0700 (PDT)
Date: Mon, 14 Jul 2025 09:44:03 -0700
In-Reply-To: <20250714164405.111477-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250714164405.111477-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250714164405.111477-16-irogers@google.com>
Subject: [PATCH v7 15/16] perf python: Add metrics function
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
index 980490684ab9..4ccf761335e9 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -2073,7 +2073,90 @@ static PyObject *pyrf__parse_metrics(PyObject *self, PyObject *args)
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

