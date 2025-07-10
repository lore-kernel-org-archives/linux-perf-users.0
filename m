Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF1A3093C5
	for <linux-perf-users@vger.kernel.org>; Thu, 10 Jul 2025 23:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752191896; cv=none; b=nv1qk9i1xzTkz7ul6DLVkPn3Qweg+kmfvJjlVpBrqXr1EhlCRfzD9oYesH3/U9LwYfJI8wy1LyS43QB8qGYq6qAP70QU+TD9Ovnsbhq5zRByeiqHGc+XO6u9YNQhNoKgWpzxB2qpraH0OD96ICCotdX9ZuRXc9nbqcCWp7JP12w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752191896; c=relaxed/simple;
	bh=12yJFp+ZPyq7VIWySRLKkGC0LH/3/sqX9XbjRxQaNbc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=XaGy3dQB/lsL2elgqYwzDg2WZmI1DB06GI11N7FPZRILD0BQhM4q2Dtz5THresaIuGFnSfkSmEJrraMzod2OLfnYwJ0XoOLe2lfvL4zethwsxl7WJDJSIF3QZRXySd9e2WfdvX10xfkrupKd/754tQsquXnM59BbdZ2ZEDZ/+gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NY6gYPif; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NY6gYPif"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b38ffb62492so1719702a12.0
        for <linux-perf-users@vger.kernel.org>; Thu, 10 Jul 2025 16:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752191894; x=1752796694; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6GmxHwehNANjslAlbEN827g4sdD+kiWgzyjC/AAO5fc=;
        b=NY6gYPifGRyYUTU31A3Sze6qYaLBER2VCz24MgJV8a7OHPt/qrtOTJ1NDIs8RnTbWV
         UfegW095ju2dSyPXWE7pv5UhoVTthbFlEjd8/Bcl25cv2WHob5KDQDsa0L1E9l4MHMVz
         qpKZv0EWuJq6cfkTAQTpyTySvzBzXViB73sAz6B2oOJMz7DdiA/xL5Ic13PKdI/8CPwu
         kVZwjtHe985fLo2xazY7M3XbDFSV25MinUwBujEeU2Nz9LK4cDQcrqPEGSLHaHLLDsck
         5A+eqFbZP9ls6VeOHRmVAZVUdqlhpW0il9yl6u9V/1WGb95SVHfWByKDgGoGns1zv+I1
         9fLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752191894; x=1752796694;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6GmxHwehNANjslAlbEN827g4sdD+kiWgzyjC/AAO5fc=;
        b=cKLDt3HPs45W8+yhZOEr3o9j19oDbGE0kgNemdabgFGKVqgWwWlHchRo0rSSHchACH
         KVfm5yAw/6Ib35vZXeKP9zGyjKYa2znMbibefjsw6Zr0a9IAXZyfACvJJmaFGcKbIcWu
         g7bmMuWvYqwHuR88hQ74wpFfxGGTWxFN9btZwNYfBEcuXzngEc7/YFZSMFesuCuzgsWB
         16k4zBNLPrx7QvYoi/rjJq5dq+VNViGCFv5SBJPlCXl7JQFT7koOhyCOrTfbfePD48Ef
         7a1HvNIS8OU2n1slfde1qjc2R4g2glRIZzjjWhkHF833zzxXm7iKpF4fna5RjxE7Cn8/
         V0Pw==
X-Forwarded-Encrypted: i=1; AJvYcCWB6UOdzBWutbM6tOHr4zEsiSXIMdlpDd3PxOarZFeelO3d9Yyg+mtpcXGIa8iXK0Ee3LbkS/agCVdCd2GaT0yf@vger.kernel.org
X-Gm-Message-State: AOJu0YydTh7Zgytm615QcbDSvn/JpLJ+s1q+jY4yghtdSzBbxj9uHz90
	KJTwSZDAiBp9pJf8EmYO1PbsBk2Sbo32sHlVGpi5dCIXSTxKNgecQM1mg1IQlWxN3tnEaXi4TnQ
	UdREVnSgY8A==
X-Google-Smtp-Source: AGHT+IHab2nPLVhZMvMV0JeGUHv+oB3+dmQtdHOC6bLBDlha9CcopcXmtLsynh9knoF2yBJxVnBK4yMwIrNG
X-Received: from plblc5.prod.google.com ([2002:a17:902:fa85:b0:236:91fa:131a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f547:b0:234:a139:1208
 with SMTP id d9443c01a7336-23dede3874dmr15831295ad.16.1752191893843; Thu, 10
 Jul 2025 16:58:13 -0700 (PDT)
Date: Thu, 10 Jul 2025 16:57:29 -0700
In-Reply-To: <20250710235735.1089240-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250710235735.1089240-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250710235735.1089240-9-irogers@google.com>
Subject: [PATCH v6 08/14] perf python: Add function returning dictionary of
 all events on a PMU
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

Allow all events on a PMU to be gathered, similar to how perf list
gathers event information.

An example usage:
```
$ python
Python 3.12.9 (main, Feb  5 2025, 01:31:18) [GCC 14.2.0] on linux
>>> import perf
>>> for pmu in perf.pmus():
...   print(pmu.events())
...
[{'name': 'mem_load_retired.l3_hit', 'desc': 'Retired load instructions...
```

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/python.c | 67 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 2b4f10a9b8fe..b0bd4dc27409 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -653,6 +653,67 @@ static PyObject *pyrf_pmu__name(PyObject *self)
 	return PyUnicode_FromString(ppmu->pmu->name);
 }
 
+static bool add_to_dict(PyObject *dict, const char *key, const char *value)
+{
+	PyObject *pkey, *pvalue;
+	bool ret;
+
+	if (value == NULL)
+		return true;
+
+	pkey = PyUnicode_FromString(key);
+	pvalue = PyUnicode_FromString(value);
+
+	ret = pkey && pvalue && PyDict_SetItem(dict, pkey, pvalue) == 0;
+	Py_XDECREF(pkey);
+	Py_XDECREF(pvalue);
+	return ret;
+}
+
+static int pyrf_pmu__events_cb(void *state, struct pmu_event_info *info)
+{
+	PyObject *py_list = state;
+	PyObject *dict = PyDict_New();
+
+	if (!dict)
+		return -ENOMEM;
+
+	if (!add_to_dict(dict, "name", info->name) ||
+	    !add_to_dict(dict, "alias", info->alias) ||
+	    !add_to_dict(dict, "scale_unit", info->scale_unit) ||
+	    !add_to_dict(dict, "desc", info->desc) ||
+	    !add_to_dict(dict, "long_desc", info->long_desc) ||
+	    !add_to_dict(dict, "encoding_desc", info->encoding_desc) ||
+	    !add_to_dict(dict, "topic", info->topic) ||
+	    !add_to_dict(dict, "event_type_desc", info->event_type_desc) ||
+	    !add_to_dict(dict, "str", info->str) ||
+	    !add_to_dict(dict, "deprecated", info->deprecated ? "deprecated" : NULL) ||
+	    PyList_Append(py_list, dict) != 0) {
+		Py_DECREF(dict);
+		return -ENOMEM;
+	}
+	Py_DECREF(dict);
+	return 0;
+}
+
+static PyObject *pyrf_pmu__events(PyObject *self)
+{
+	struct pyrf_pmu *ppmu = (void *)self;
+	PyObject *py_list = PyList_New(0);
+
+	if (!py_list)
+		return NULL;
+
+	if (perf_pmu__for_each_event(ppmu->pmu,
+				     /*skip_duplicate_pmus=*/false,
+				     py_list,
+				     pyrf_pmu__events_cb) != 0) {
+		Py_DECREF(py_list);
+		return NULL;
+	}
+	return py_list;
+}
+
 static PyObject *pyrf_pmu__repr(PyObject *self)
 {
 	struct pyrf_pmu *ppmu = (void *)self;
@@ -663,6 +724,12 @@ static PyObject *pyrf_pmu__repr(PyObject *self)
 static const char pyrf_pmu__doc[] = PyDoc_STR("perf Performance Monitoring Unit (PMU) object.");
 
 static PyMethodDef pyrf_pmu__methods[] = {
+	{
+		.ml_name  = "events",
+		.ml_meth  = (PyCFunction)pyrf_pmu__events,
+		.ml_flags = METH_NOARGS,
+		.ml_doc	  = PyDoc_STR("Name of the PMU including suffixes.")
+	},
 	{
 		.ml_name  = "name",
 		.ml_meth  = (PyCFunction)pyrf_pmu__name,
-- 
2.50.0.727.gbf7dc18ff4-goog

