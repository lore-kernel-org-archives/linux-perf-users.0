Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B87E267B68
	for <linux-perf-users@vger.kernel.org>; Mon, 14 Jul 2025 16:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752511472; cv=none; b=k2sa4jFe9zwyWL0KjWWh7VxfO2COLWckFKiw17H3Eq0YKnnoOpVnBxHxn8N6MsQopTo6CXgmjKFy1+xKKVLIjN09qN4hzfyZNk70B+vvIXNCmNkqYwzUbvPHQbMNtFYp4j8uo2wK3ph33rn1wl2JlFnf7vjB6JxQq4WZGUYiuS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752511472; c=relaxed/simple;
	bh=3FmPzwRiOKNT3fba6Wfb1kMWp17gbdje4Yfsc7a52d0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=RcvV/BhoJKPw9xLgRXNUDn/sSLkpGHjUhmwq7CydLXmeQIX4bI3h2u9v/ztzpu486M6rCST4EjGbRkPguLMiGMCtyRbvp+8ROQiyBiu+9Wto+qJF9+xk/8yMZdifEx4vDDeUOAcRNedKyo/5GUjViyaQu33chy8SB5GNmQhDOQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OOEZ9u+e; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OOEZ9u+e"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-235e1d66fa6so41452615ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 14 Jul 2025 09:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752511471; x=1753116271; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AU1HJREvTdMAeCwCe2SHqaTDwDwTBfrJl9a2Utoe8wA=;
        b=OOEZ9u+eqC1rI3LmV9g/1jxVzoBeq94/ujhk/Ot0dfL6njaAw/EtgmVYlsoL2/PgpI
         DxIS1UXCYeqizjFqbpSAeWeQ4xD3Y/jU4ReSgAH3XwCNY5awqek/ThzZvB7nUzfckJwc
         aqASrAxweoHbur59/JD59YXFKIQiB9vWEB5jgEWcqRlitdlS7b/vbTj3JRLRzeO5Juvb
         u1VVsyk2xBay2DzzSwJAVKSU3Y9QjWCadrXxodIVU2N4h0RtQG9vqN7zxUtenbYnplLH
         K6Q6aajmHwWHT6/qu7Sq/QA9K1H2ye41W05lPBu2p/t+7rRBtZlQEqLfvztGH7PhB3Hs
         T+eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752511471; x=1753116271;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AU1HJREvTdMAeCwCe2SHqaTDwDwTBfrJl9a2Utoe8wA=;
        b=IOWciqtl6u5+JrfcPL/r0AlEuyiR+RE9vVpoILOxfoM3uL+Ec9lXARFPi80QYJj8VR
         USiMXC833wScIhcjaLj5oG3Ra/wlDksleZPxKGMRYZWq/mCviSurXWeTyluyJ83l2yhE
         hP6rw9OTE2y/0SIegrwBR20MMqzTdb7bgG5m3/WALYrHhFi9iNzcaPjoKEDtIm0nDzqE
         R5eAK3yml99FZ457hmu7MRzu0p9YdG9qDlmByNWlTSt30ArCE9a59KZCyc0DhUDw0oLm
         lwQNjY04vTZeARt7nxdNOUvHLJn0avobUDCz+tnYxkxKChYpGsNU9MfOFeM2jp49ExN4
         MZcw==
X-Forwarded-Encrypted: i=1; AJvYcCVKk5hrXum/UsOW4cHIanIChQqaXRUr67Dg3NCsiQJJSi7iAc8hH1IZI5vb4Vnc79V80ER3YPE+iYkwwpUomRXY@vger.kernel.org
X-Gm-Message-State: AOJu0YwVCGy/Y70dtaGdhTCLBu1pt63m16lqljH6uIn5Z6mZbiZuIHVZ
	2h3RsZkbrz/J5higxOG7c7xz70hOChuyPZ4NpydTs/OIGu/23NfMmrQfe+d03mheQummTiwSa01
	VHIS0ZSUSMw==
X-Google-Smtp-Source: AGHT+IFxBNKMB7LBbvmpNpu1uevtEAUt3VwrN4MV8KA3G2Lq1jCOYE9PYsF67Dc4WOPgW2qr2/NFNehpvJeR
X-Received: from plbmi5.prod.google.com ([2002:a17:902:fcc5:b0:235:c96e:dd92])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e78d:b0:235:e76c:4353
 with SMTP id d9443c01a7336-23df0973c9cmr188321875ad.51.1752511470642; Mon, 14
 Jul 2025 09:44:30 -0700 (PDT)
Date: Mon, 14 Jul 2025 09:43:57 -0700
In-Reply-To: <20250714164405.111477-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250714164405.111477-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250714164405.111477-10-irogers@google.com>
Subject: [PATCH v7 09/16] perf python: Add basic PMU abstraction and pmus sequence
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
index 9d97affb79c1..860df6436f87 100644
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

