Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E761E2614
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Jun 2025 05:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750050940; cv=none; b=f0C6n8jTjRPZbBQm6DwEhVOl3iC9dmAcrIXjTfYCttfwrblaXNCORyieCkxpT8meQV+aA9r9gD+HSDQBA790ErDnc/BKwFmH372Kzt2wt2Zw//xVQMWifYM5jjHXhFh9ThjpcR+o9+eojpb9FdxaZTVPQDrHWj5LvcFvu5B+DfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750050940; c=relaxed/simple;
	bh=FDHXLU4J2D78n30kero/Zz2zkovLAiNRWMXuqyzrGCw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=nWDSZ4pghCqyUqMJRPDryOYvBsasMEms39GvqMp/E3R6ALBSHW5+HZWLrvFjt7HM5tjXEdiqTv/gHsaVXB+VUGhd2VJt9TK1c74blPNsRFuJbhlWs4PYx6UAL7ejWmjgJs+ZsmVnD99eOzfzA+22xKcoyN571AqazgUTOgnRsOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mkcTB7jE; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mkcTB7jE"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-236445722f9so23646465ad.1
        for <linux-perf-users@vger.kernel.org>; Sun, 15 Jun 2025 22:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750050938; x=1750655738; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sTKqdcYyHF9clcVtgl1QXOADzr9s/Gb9doCvReUrwZ4=;
        b=mkcTB7jE+SJuvZ0mTKmqpnoE1Iy64bu4kEq35lEUxKb2c4jaJjWf2y++isIR62H3bI
         +s14KXUyc/8/Ek3n0Cn2MxoqAnxz8DbkSTQRWerEjLxvBfFcKlaKNg4MJTFrZuUhafgB
         Cu9I+dhNk29hBuvWMLYpg4rr6YJQzpT2VGz14+j2C/NSDsW1opWkLAvYUEhEynpplJdw
         a349DyIadYdV1jYiz90lY+14udy6vVkbbigoMJmkx6wl4ms4DFh3A+akexdcYayQ5yfs
         jk5n4ZckHjYknY44gXMRYKBhfTKI6ieV+FrMyF0cRk1cuvKLyM3a+vYPapGZp+m8/4/1
         BMIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750050938; x=1750655738;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sTKqdcYyHF9clcVtgl1QXOADzr9s/Gb9doCvReUrwZ4=;
        b=UNlUG1uMv9LGYb5W6mXBHDvYu86SaZZyyzWAIES5ERZTP2v9HA5VicPpv/Dl9uMCib
         tQbR/HuXLzFRJXmdqKxdxGRH2IXNZhCZxYYHwuM3KCqR2rC0NosOqOidGjqzX3xvZGjX
         WLVfOSjQaE4bH0D0URmSfNKy7JfWP4UOUIbBLona6WIila3JtbF1jlIIV5BXWbAMN+zn
         BFB5woWiyJjOO2Kvbd6mDW70west9GJ9RtrQ2kYpGeMuwlzZ+iydxbQShJRxgDlEsrYA
         jLpS/QCB6Cy+Lz7Hj4H0o+CEZEHOU6yXWns7XeU4h/UVJ8IIIxr0gOP8ApLwFhNYYdT8
         kQpg==
X-Forwarded-Encrypted: i=1; AJvYcCUQyloYTIfLfpbSVWn/ogtTCvI0wDrUyiA5FNINUin3h7JVVC6aJ68HhGtaAOHpdZENawa9EmXtfOC515q8alht@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ52wSErtaqLA8reALMrkhx/xuQsAEbnHEju4KHNOZlPJC1nbd
	y7LUXT3d8S3ZvUFQxc6F/f1s6or7OCIDNGBEle5h5MkJTws/22sGro/vUpYALWgd2HVa96+4+It
	BBr+mSzBf6w==
X-Google-Smtp-Source: AGHT+IHAPYNAv465eOEq5YoSg/nkLLSoi5rsqXTEcUYGxPxVFq2qs/MG23h5xOFSmuKncDzY5lZ2sYPF0mxQ
X-Received: from pgar5.prod.google.com ([2002:a05:6a02:2e85:b0:b2c:4702:db0e])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:f90:b0:225:abd2:5e4b
 with SMTP id d9443c01a7336-2366afe7c13mr124614375ad.16.1750050938284; Sun, 15
 Jun 2025 22:15:38 -0700 (PDT)
Date: Sun, 15 Jun 2025 22:14:51 -0700
In-Reply-To: <20250616051500.1047173-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250616051500.1047173-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.rc2.696.g1fc2a0284f-goog
Message-ID: <20250616051500.1047173-7-irogers@google.com>
Subject: [PATCH v3 06/15] perf python: Add basic PMU abstraction and pmus sequence
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, John Garry <john.g.garry@oracle.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Howard Chu <howardchu95@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Andi Kleen <ak@linux.intel.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	Gautam Menghani <gautam@linux.ibm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
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
index 201fe04fb6dd..33b23d56dfb1 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -627,6 +627,138 @@ static int pyrf_thread_map__setup_types(void)
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
 
@@ -1613,6 +1745,12 @@ static PyMethodDef perf__methods[] = {
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
 
@@ -1640,6 +1778,8 @@ PyMODINIT_FUNC PyInit_perf(void)
 	    pyrf_evsel__setup_types() < 0 ||
 	    pyrf_thread_map__setup_types() < 0 ||
 	    pyrf_cpu_map__setup_types() < 0 ||
+	    pyrf_pmu_iterator__setup_types() < 0 ||
+	    pyrf_pmu__setup_types() < 0 ||
 	    pyrf_counts_values__setup_types() < 0)
 		return module;
 
-- 
2.50.0.rc2.696.g1fc2a0284f-goog

