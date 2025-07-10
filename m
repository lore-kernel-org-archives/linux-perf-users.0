Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D212FE33C
	for <linux-perf-users@vger.kernel.org>; Thu, 10 Jul 2025 20:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752179117; cv=none; b=o55mFMhanrYzM7iA9RlFv6zDgzIkMsGqbx2q4u/NKKu0yGEU/pp6jA9Zcc1mF/j0jS5ReuL8PXa2otcT01OVKFmHpQSEysjrDm+Uk5Nd8wnBn62fXmMortylkQySwfjjoX3PHELVPMCuN9lUJOmvc1IWkfu3+luwsokDC/WVcPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752179117; c=relaxed/simple;
	bh=WFS1g6kYY+XgrAAa5iSXxbIVXwge/aB1XoG8Q1Q1zEI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=cGycKKTGvMurUyW9zyxBw/oYOK61qXyievisrt8QnX2Ohs1cK5o0sMU0gBOrdhVHZHVtKEMzgWD98uYavC3UIBK+mWxQXkJ8Cde2J61RD7rDSTIZ9172QzfHs2Mh54qvndKl9KVvubJdANwESLD623Z+kwQ0sw65G/RwWRT2AWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fb9W3gVI; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fb9W3gVI"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3132c1942a1so2143609a91.2
        for <linux-perf-users@vger.kernel.org>; Thu, 10 Jul 2025 13:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752179115; x=1752783915; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nLmmHKES778Ih0J3i1L0ZkfJuaKP4hpTsElytjjdQfs=;
        b=fb9W3gVIVOr+pacZm50pzm1Ccihhu5zduZDNsNPM1W224DFEDdRphXktJvHGLHvq5h
         B6h3T/OahgTIrAo+6WYJPv4H2b1o7253YdY+jMiOx8MQMcMNNE/FIMOZ1K2PcW7ZEtN4
         en73YykXG+8n4DfrcWbvXM1cbxr9C6OPTXGGnxrwXfOCZvw0GBpTO9rMS08/DQ4Rm8Ef
         gxDQSHQa+lG2MisoN8a8jAJExIr+8AxKLPZ2c2XjEgMJ7JZRHbSLK9hxd+MPoB/yG/ny
         aoe1MeUdLBDa3xeqKzVbpSwdQziYysZH9XDa2xTxjVhMGkK5fI9Yj4FArdcTtQaor89c
         lekQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752179115; x=1752783915;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nLmmHKES778Ih0J3i1L0ZkfJuaKP4hpTsElytjjdQfs=;
        b=XmXB04qn3tHzEnJ7euT489uTwEKuKLAQQZj0xUSHMgruWSj+lwbnTc8An4S45WvxVH
         +C5rQA1QiDMbRcNopABzUpVM2zvH746eXCQefXGpYgCzRM+WJ7gO7t8LMv+QC4ofcE3a
         0W7DGPKHAQFus4sBbMa4RWDh2MheKBT95o+NK9y6xa0CO0+K0ek8EvX53GyVeUpis1a9
         2mPmpqGHS+G4lv1E3AgAR0mRs/D++FUMi5+ilNsBYdSoe2rqVUACIXOchhT/0biypL6C
         Yh9Ub+nBAco1bUOBe+xSGgoXKbILEmdBiiZLhbQYL45DToBORK7yHVKQD+3RgCyZTZhF
         xblA==
X-Forwarded-Encrypted: i=1; AJvYcCXq62Qv+1GEEGkXVHcJR/QmcAYcJLTjAI0enCikWn+BqiIlMX2juysstdb3NkByCG4y6d+QZeUH4gPVjQfxNRcv@vger.kernel.org
X-Gm-Message-State: AOJu0YxbgnfOvck1GwlXqmXY0P3iV5+r71fNKCfNMqCUusWlntX9VqaM
	c35BIJzSplv8O5oi2nInyYRWDj3SA/inblxRZ6nwDwQpq/+arBT+cPh8VH0YOYAWHRV3fe8Nxkd
	r+LUD4EhMDw==
X-Google-Smtp-Source: AGHT+IHzBHYcOb0ZjZYgjdQfhaAwhHVz+PNWGSCKUC+dRMctJvIIfCbhj3frakOoN6CUI8TBd5c/GQZjKiSs
X-Received: from pjbcz11.prod.google.com ([2002:a17:90a:d44b:b0:2fc:2c9c:880])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:48cf:b0:31c:260e:55e9
 with SMTP id 98e67ed59e1d1-31c4f591cebmr13217a91.24.1752179114802; Thu, 10
 Jul 2025 13:25:14 -0700 (PDT)
Date: Thu, 10 Jul 2025 13:24:42 -0700
In-Reply-To: <20250710202500.1959672-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250710202500.1959672-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250710202500.1959672-5-irogers@google.com>
Subject: [PATCH v5 02/14] perf python: Add function returning dictionary of
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
index 0124db5ab3d1..728ed27986b5 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -649,6 +649,67 @@ static PyObject *pyrf_pmu__name(PyObject *self)
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
@@ -659,6 +720,12 @@ static PyObject *pyrf_pmu__repr(PyObject *self)
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

