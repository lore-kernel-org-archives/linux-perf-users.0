Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7241274B2F
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Jul 2025 23:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753312998; cv=none; b=KNON3ZC+VrsVm1h6Sy56BW6if9/SlbX+CFWoZvKP7sgRe2AL4YCk/xarD7mVZSYURfXDANKHssxq/iq7y2vGvTAA/eVtVc/KsaUFKqCKSiRekv1slAKrJensEayyqW0kajwrHkBO2WbaVL1Rl5q0pQVuo0hfJkTkO2tulv9ZNEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753312998; c=relaxed/simple;
	bh=Z/+V08XVG6YryTmJn6c7T1URaUgSv2I6HyIn21jzYQ8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FUB6I1SHn/6pOyKWYmGnKI6ILQGFF9Q5Le6d1AyA7tEiWzVpW7hHogmeTDyV5KaEQK22qbSKv64Igwpw0RqgVMg7VsTVbCRM833PGMTQ8uf8r5o7kCNjg0t63vG8aK7bEJ7Z71BckAszBUdIj6irj3Elwg16XtYdD9/UM8Xp5gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=w8/kJ6dh; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="w8/kJ6dh"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-31366819969so293325a91.0
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Jul 2025 16:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753312996; x=1753917796; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cdjlRlqcaaWl92SvJhsMHCXMRGPAo2TCVGBK4bniCoY=;
        b=w8/kJ6dhNhGcsIgAIcto62ozQ9u2ovlOkV7fa25qPOTq9XFOfkJboq06BBLxamp0TT
         tCDLG7WVukfQL9J6Tp46DosVWBpuwacDtR1G9TYL8L78i6+G07BgGNaMmXrluNzDymZ2
         HvqH306DJod13Kwj4SHOFjrmGL/C0Dy5ThnipoxewHOCg0NC2olV8YJsLtDULxOOdRd4
         ky3g2/LVgHpbe1Pm9hi3Skv3jHWZ/qgf+hUoVA59VdwWXyt7BC5uCTVyXLolvqCXxKwU
         AVnil80kn1aA+kYcIu/Ygtt3L6NuvGvv/m8b0rJ0V2hEXmLuTajUy0iOmPk1bsw/8odp
         zb9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753312996; x=1753917796;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cdjlRlqcaaWl92SvJhsMHCXMRGPAo2TCVGBK4bniCoY=;
        b=sRbbLqQQIKGRlanE2OjCaSL1OAr7ZEVFy3TnpVE+YsObIRjgji0qGKJk6aHbNWCiCv
         GeptGA0NNYuRHJGn6kMfjtDDSZtwH+cSeqcsOWM9mQbQxef/BTnMPK+DUDJGcqp/Vp5K
         6ezA57FPkEMlCAIE5KW7Q7pJGE+omvl1mttNzFsiaWVj2/OLVSXkyCc3U+324Yx4dMsf
         CgROeQ3j4kivPRBb2moW3rmDqkKlluwggx91K1wapypHA8U/FysIErXunYPbV9/xa8HR
         6/JjIn5Eue3ioXOv8ZKnsKB5HfSD7ePdiC1yYeJ2EHjbUnjGZZrEtFVy4wx8I+r7uoOU
         /mOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtokSNK7q+Nxa6f4d1OWk/4rMuUbMEuqPeUsrlzjflKL7G3rGzAWBAxYpViZEndmKDjc0U40f0inGH5RvIBoxh@vger.kernel.org
X-Gm-Message-State: AOJu0YxKAk6vLXNKyGrvA7+QLVT7qeqaqIs3eceux7eaZcdwYr+jLfEp
	pWY4+Yc4sSkVy85rTQK0Y6SeaIlYXSKEi7ETfTdqaD9PwblQwuBiXxUs7+givg55fbt9GqTJOm9
	5BDfoeQLqDg==
X-Google-Smtp-Source: AGHT+IHT6Yev26RC90YfzMfnzP3PbAYr9CxK1jbMxB7Z8IIbdYP59V9Rv/RmXqz2mIPJoxn4nStyu/gZufvF
X-Received: from pjvf6.prod.google.com ([2002:a17:90a:da86:b0:311:c197:70a4])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2e0d:b0:31e:3bbc:e9e6
 with SMTP id 98e67ed59e1d1-31e507e61a5mr7085372a91.19.1753312996032; Wed, 23
 Jul 2025 16:23:16 -0700 (PDT)
Date: Wed, 23 Jul 2025 16:22:10 -0700
In-Reply-To: <20250723232217.516179-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250723232217.516179-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250723232217.516179-10-irogers@google.com>
Subject: [PATCH v8 09/16] perf python: Add basic PMU abstraction and pmus sequence
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
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/python.c | 140 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 140 insertions(+)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 9c9972d77d1e..ddcb5d40ff14 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -639,6 +639,138 @@ static int pyrf_thread_map__setup_types(void)
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

