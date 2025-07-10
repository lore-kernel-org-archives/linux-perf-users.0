Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B863093CE
	for <linux-perf-users@vger.kernel.org>; Thu, 10 Jul 2025 23:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752191890; cv=none; b=TcYC8dFG7n2HRzXghTeDOMWrldazgdy1ZCPpQnmBa5T04oZQ/nZYmErnryaCac0xTt9bomlo+CEhPcfXeC/QcILdBSKyEszcS9mNZghQjyJJ3kmeUMi5V2mZMV/7nZuo/qJuq79GiEqHNulRR7CMw2J7uKyCYWLnNNPj+k6vUIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752191890; c=relaxed/simple;
	bh=O4zCSkEPk7layLupk5rHejxk37JQtJ2nCvIHezM8pok=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=DkK6xyDtY9a3RGaQcSEYIeEiCf6vOUlPNi1Z2Y+xSE22sCKjD5M9kjKFshTw0VenI1eFsiokg3F9y4fQj8rgetw5oun+ASBFqJUFHnrkA9/VhGOY2+E/U6Mi7CnkUUoNkv6By9lWHV6Sd9SgmkA/OAj0RVV48d9Vxkdlp5fb5Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r8bkpVRW; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r8bkpVRW"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b34ca003f1cso1172867a12.2
        for <linux-perf-users@vger.kernel.org>; Thu, 10 Jul 2025 16:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752191888; x=1752796688; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=okfynnfTcY6a4dpfoTRNkP2fBbP3FmMQUHtvEbp4wnw=;
        b=r8bkpVRWlXkgP5mIYeUyrkSrT8svP13J8l+PU5bloqEj0NpxLgOZqMw4/YhgqqmV7H
         ylLfCAks5zlbpB+dwpImFAMWzrHqpt9nur/+o/xzQbL/AyP9WctDuJtb9e0UL1MO82qV
         Hu00WPkA/HdmRxifUJOLXGY8e67Yw2Nbl+c7Peof1yYwJvAxkoKo206zTkZOg2iX0p8v
         +PbwqWzNi7VKto3x5VMWcBIKHxPEXNCxonjMy9xJvi5RwPvKX50NzPSuFZv6nkRvmjP5
         nZUSh/K73WhMs3cLxEbSVJop6dgQWTuTPFy7huRffTYIDi+uckhb8cZFtzMhLbl1wPL4
         pGJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752191888; x=1752796688;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=okfynnfTcY6a4dpfoTRNkP2fBbP3FmMQUHtvEbp4wnw=;
        b=CrMdHi1IhUNswGdJvu6HFMqen/fNzKqeUmBJQWp3+ycnx/t9h/zA1lpkxnyYeCxECJ
         P6enKnJ0WxAhH4DW7odiNt0Tv4baqldeNDsn7LthzvuiRMnFNafr4Va+Le3W2cALGrM8
         9VZ9e78Tu83TIqx+2ndI6azwpmvIkxhCDJc5lheNW0IBZo0v+N5PMU1WVZ6YMShwzAGS
         Qgb6H4ArX/xnC26SyKB2hZpunfCgQsCwxCDUtQ3K1Eap6I5nNGY4okXodExBaxc4XstI
         ncepmdK/YvOv2rifN0QYk4/Pl5JzbfQGCGcWVhm9gJIazZNfdBUuYyO7UrNvgHZy11SJ
         J21Q==
X-Forwarded-Encrypted: i=1; AJvYcCUf9Owh5iZwfpOccGF/5g3DRtcjJCEdv2Hx30yn78XAWS8P6LwpftSuPgYh4hpsp/YdwiUvjdKkdDefzMlnvkUN@vger.kernel.org
X-Gm-Message-State: AOJu0YwtQiEdQ8zfwPdHnhp7OpFUyWYX0H9T5NIaDv9gXyzJ4utTvTt1
	OvxDqT4OXkMSrNdOnv3PuXeUpWIxyyHgBoymLLKiAkkXopdjYd/KVeLqmli5ykNOKvGbze2d2JR
	8ZIcoWCNC4w==
X-Google-Smtp-Source: AGHT+IH0CZfVvFq8nOxEpctFWHh2yDfhfTyYo4/gSQLU0bjvedikN3xeeThowx1pzzRLR5oZjlFWmnpPEz4b
X-Received: from pfbjt14.prod.google.com ([2002:a05:6a00:91ce:b0:748:e8fc:e9f0])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:a108:b0:220:3ab2:b50e
 with SMTP id adf61e73a8af0-23134a6a353mr1486314637.6.1752191888475; Thu, 10
 Jul 2025 16:58:08 -0700 (PDT)
Date: Thu, 10 Jul 2025 16:57:28 -0700
In-Reply-To: <20250710235735.1089240-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250710235735.1089240-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250710235735.1089240-8-irogers@google.com>
Subject: [PATCH v6 07/14] perf python: Add basic PMU abstraction and pmus sequence
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

Add an ability to iterate over PMUs and a basic PMU type then can just
show the PMU's name.

An example usage:
```
$ python
Python 3.12.9 (main, Feb  5 2025, 01:31:18) [GCC 14.2.0] on linux
>>> import perf
>>> list(perf.pmus())
[pmu(cpu), pmu(breakpoint), pmu(cstate_core), pmu(cstate_pkg),
pmu(hwmon_acpitz), pmu(hwmon_ac), pmu(hwmon_bat0),
pmu(hwmon_coretemp), pmu(hwmon_iwlwifi_1), pmu(hwmon_nvme),
pmu(hwmon_thinkpad), pmu(hwmon_ucsi_source_psy_usbc000_0),
pmu(hwmon_ucsi_source_psy_usbc000_0), pmu(i915), pmu(intel_bts),
pmu(intel_pt), pmu(kprobe), pmu(msr), pmu(power), pmu(software),
pmu(tool), pmu(tracepoint), pmu(uncore_arb), pmu(uncore_cbox_0),
pmu(uncore_cbox_1), pmu(uncore_cbox_2), pmu(uncore_cbox_3),
pmu(uncore_cbox_4), pmu(uncore_cbox_5), pmu(uncore_cbox_6),
pmu(uncore_cbox_7), pmu(uncore_clock), pmu(uncore_imc_free_running_0),
pmu(uncore_imc_free_running_1), pmu(uprobe)]
```

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/python.c | 140 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 140 insertions(+)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 2f28f71325a8..2b4f10a9b8fe 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -632,6 +632,138 @@ static int pyrf_thread_map__setup_types(void)
 	return PyType_Ready(&pyrf_thread_map__type);
 }
 
+/**
+ * A python wrapper for perf_pmus that are globally owned by the pmus.c code.
+ */
+struct pyrf_pmu {
+	PyObject_HEAD
+
+	struct perf_pmu *pmu;
+};
+
+static void pyrf_pmu__delete(struct pyrf_pmu *ppmu)
+{
+	Py_TYPE(ppmu)->tp_free((PyObject *)ppmu);
+}
+
+static PyObject *pyrf_pmu__name(PyObject *self)
+{
+	struct pyrf_pmu *ppmu = (void *)self;
+
+	return PyUnicode_FromString(ppmu->pmu->name);
+}
+
+static PyObject *pyrf_pmu__repr(PyObject *self)
+{
+	struct pyrf_pmu *ppmu = (void *)self;
+
+	return PyUnicode_FromFormat("pmu(%s)", ppmu->pmu->name);
+}
+
+static const char pyrf_pmu__doc[] = PyDoc_STR("perf Performance Monitoring Unit (PMU) object.");
+
+static PyMethodDef pyrf_pmu__methods[] = {
+	{
+		.ml_name  = "name",
+		.ml_meth  = (PyCFunction)pyrf_pmu__name,
+		.ml_flags = METH_NOARGS,
+		.ml_doc	  = PyDoc_STR("Name of the PMU including suffixes.")
+	},
+	{ .ml_name = NULL, }
+};
+
+/** The python type for a perf.pmu. */
+static PyTypeObject pyrf_pmu__type = {
+	PyVarObject_HEAD_INIT(NULL, 0)
+	.tp_name	= "perf.pmu",
+	.tp_basicsize	= sizeof(struct pyrf_pmu),
+	.tp_dealloc	= (destructor)pyrf_pmu__delete,
+	.tp_flags	= Py_TPFLAGS_DEFAULT|Py_TPFLAGS_BASETYPE,
+	.tp_doc		= pyrf_pmu__doc,
+	.tp_methods	= pyrf_pmu__methods,
+	.tp_str         = pyrf_pmu__name,
+	.tp_repr        = pyrf_pmu__repr,
+};
+
+static int pyrf_pmu__setup_types(void)
+{
+	pyrf_pmu__type.tp_new = PyType_GenericNew;
+	return PyType_Ready(&pyrf_pmu__type);
+}
+
+
+/** A python iterator for pmus that has no equivalent in the C code. */
+struct pyrf_pmu_iterator {
+	PyObject_HEAD
+	struct perf_pmu *pmu;
+};
+
+static void pyrf_pmu_iterator__dealloc(struct pyrf_pmu_iterator *self)
+{
+	Py_TYPE(self)->tp_free((PyObject *) self);
+}
+
+static PyObject *pyrf_pmu_iterator__new(PyTypeObject *type, PyObject *args __maybe_unused,
+					PyObject *kwds __maybe_unused)
+{
+	struct pyrf_pmu_iterator *itr = (void *)type->tp_alloc(type, 0);
+
+	if (itr != NULL)
+		itr->pmu = perf_pmus__scan(/*pmu=*/NULL);
+
+	return (PyObject *) itr;
+}
+
+static PyObject *pyrf_pmu_iterator__iter(PyObject *self)
+{
+	Py_INCREF(self);
+	return self;
+}
+
+static PyObject *pyrf_pmu_iterator__iternext(PyObject *self)
+{
+	struct pyrf_pmu_iterator *itr = (void *)self;
+	struct pyrf_pmu *ppmu;
+
+	if (itr->pmu == NULL) {
+		PyErr_SetNone(PyExc_StopIteration);
+		return NULL;
+	}
+	// Create object to return.
+	ppmu = PyObject_New(struct pyrf_pmu, &pyrf_pmu__type);
+	if (ppmu) {
+		ppmu->pmu = itr->pmu;
+		// Advance iterator.
+		itr->pmu = perf_pmus__scan(itr->pmu);
+	}
+	return (PyObject *)ppmu;
+}
+
+/** The python type for the PMU iterator. */
+static PyTypeObject pyrf_pmu_iterator__type = {
+	PyVarObject_HEAD_INIT(NULL, 0)
+	.tp_name = "pmus.iterator",
+	.tp_doc = "Iterator for the pmus string sequence.",
+	.tp_basicsize = sizeof(struct pyrf_pmu_iterator),
+	.tp_itemsize = 0,
+	.tp_flags = Py_TPFLAGS_DEFAULT,
+	.tp_new = pyrf_pmu_iterator__new,
+	.tp_dealloc = (destructor) pyrf_pmu_iterator__dealloc,
+	.tp_iter = pyrf_pmu_iterator__iter,
+	.tp_iternext = pyrf_pmu_iterator__iternext,
+};
+
+static int pyrf_pmu_iterator__setup_types(void)
+{
+	return PyType_Ready(&pyrf_pmu_iterator__type);
+}
+
+static PyObject *pyrf__pmus(PyObject *self, PyObject *args)
+{
+	// Calling the class creates an instance of the iterator.
+	return PyObject_CallObject((PyObject *) &pyrf_pmu_iterator__type, /*args=*/NULL);
+}
+
 struct pyrf_counts_values {
 	PyObject_HEAD
 
@@ -1691,6 +1823,12 @@ static PyMethodDef perf__methods[] = {
 		.ml_flags = METH_VARARGS,
 		.ml_doc	  = PyDoc_STR("Parse a string of events and return an evlist.")
 	},
+	{
+		.ml_name  = "pmus",
+		.ml_meth  = (PyCFunction) pyrf__pmus,
+		.ml_flags = METH_NOARGS,
+		.ml_doc	  = PyDoc_STR("Returns a sequence of pmus.")
+	},
 	{ .ml_name = NULL, }
 };
 
@@ -1718,6 +1856,8 @@ PyMODINIT_FUNC PyInit_perf(void)
 	    pyrf_evsel__setup_types() < 0 ||
 	    pyrf_thread_map__setup_types() < 0 ||
 	    pyrf_cpu_map__setup_types() < 0 ||
+	    pyrf_pmu_iterator__setup_types() < 0 ||
+	    pyrf_pmu__setup_types() < 0 ||
 	    pyrf_counts_values__setup_types() < 0)
 		return module;
 
-- 
2.50.0.727.gbf7dc18ff4-goog

