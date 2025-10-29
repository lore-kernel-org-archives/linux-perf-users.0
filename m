Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E97D305E27
	for <linux-perf-users@vger.kernel.org>; Wed, 29 Oct 2025 05:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761716080; cv=none; b=p9fA50KkZTWbelMGzv/tPpD3c/QblRRwNDYtetPf35BOT+uCykRO3HJUFzrpZ2VvZTwKp6TBG0611WswkmpAzDmFgHdma3B406cXXqN4zcdehlr4JCXFceD7t2GL7otN/3WTUu1Qh+VNaru8/+3/lAzJoQTrMOQACr17OkfZjJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761716080; c=relaxed/simple;
	bh=3gJJs/cKyH4mv+4ETps0tCMJbEWbE+kP2uDKqKle03E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=ic20OLw2Hk/NzohAIE3MrbjkHhzbBMZEek5iXsVPbym4O5OdW/1sSsdvFmiHcyv8ZP4y23xoCnVIumE1VQkgnpZm7OOBKeO9tKE8RohhKJ62uUouu1YNZ0xeSGnWvM0ZiuaHEadV3OL8FzKwAOXiS0uoG0CyiBjwgY9elsWim1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Xmr3EqTS; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xmr3EqTS"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-290c07feb72so54148485ad.2
        for <linux-perf-users@vger.kernel.org>; Tue, 28 Oct 2025 22:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761716078; x=1762320878; darn=vger.kernel.org;
        h=content-transfer-encoding:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3Cw/3sMiecO8APVzgVFRs1sMzit7Si8lcEDrQ/T37n8=;
        b=Xmr3EqTSL0gjIYzH5oG9V9Zx9GCQTXKZ9TjYF5IdwdLDIdihqjgpCBhWr3qKO8U4Rp
         VEYER43+C/AnAFLfZlQg16jYqRuBKbwNrpP6WGe/3yj62bflrPNzSySG43BvaV1yjQBo
         n8wMTKxLZ0m8gb9zAyF0/9NQW1rhjMRSnckVFzLoL8uDEb+eRxIk3ux0ne03R/RLUtDm
         GPjF1A/bp0akAzfm0/C0I0FL1JTozDJMUg0WSYwFFEWX5jD5chGRlOStx0/xytz9Ip3P
         UNqx22dzWxoVu0s4hrr5X3wsb4XtGQxSIgCcsn8au3LM06Fv2VhRBBB+VD/PdzBAm2k7
         bgmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761716078; x=1762320878;
        h=content-transfer-encoding:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3Cw/3sMiecO8APVzgVFRs1sMzit7Si8lcEDrQ/T37n8=;
        b=SAcOjiBXamKwyFuVB5tx3KicQcdyLkoRo7L63+6JjvX6Fa06jPuJfmbz9SF15tKycK
         YLL4gEAEAxh5S9jD4ovxMn5y0Vo/Dn93DLhQjq33Yeekt6VwqA4s3Wavz6Bv3rt5oLGb
         kLJKpbtRQaJ2WaG6fRx6XS72ee6ps97X93os/MD/q1EObx7frOUsbS0dAbZeOVInHvtn
         fTeVq8Mhg/Dis2HDfNNVpCGaq6itymeSskr3S1jpu3i1LyhZItCUE/Fc0liw4Ju52Dt/
         /Y6NsE8R2JmlttOmQgX5p3n8+2hmCaYs4qq6OBJU1Gqv/IlVd8Y+ylYHElbvfskALgeP
         fYCA==
X-Forwarded-Encrypted: i=1; AJvYcCVm70dDTNb1+7X5W5wHwMkW9HwabDsmhvThw2FYaK8uH0ttNdu3k3YrBXulI1BvOchbeLS3JMNyBh0+6Kfd+4aJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5IBEgNWZrrv1Bx/OpiNkF3nHgJ7/REW2Q9o5aFkFmOq+BRQaM
	Flq9BfZhB17VOuIScc7RFc0dvelXLke4ULqkwAeXLdEGAgxVFOMimb8uqKt6I4EXzQXeWnRRWUt
	lAi08k8gTgw==
X-Google-Smtp-Source: AGHT+IFfoyQMg5EWaL68EG2WIFdLmz5ML5FPEnKP1GI/SlQzNqJrph73+HiTtd7C+V5QRkXlyD/WNRl8fZbt
X-Received: from plsm19.prod.google.com ([2002:a17:902:bb93:b0:28e:7fd3:5812])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:230b:b0:235:e8da:8d1
 with SMTP id d9443c01a7336-294dedfc92bmr15592975ad.8.1761716077910; Tue, 28
 Oct 2025 22:34:37 -0700 (PDT)
Date: Tue, 28 Oct 2025 22:34:09 -0700
In-Reply-To: <20251029053413.355154-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251029053413.355154-1-irogers@google.com>
X-Mailer: git-send-email 2.51.1.851.g4ebd6896fd-goog
Message-ID: <20251029053413.355154-12-irogers@google.com>
Subject: [RFC PATCH v1 11/15] perf python: Add python session abstraction
 wrapping perf's session
From: Ian Rogers <irogers@google.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach <mike.leach@linaro.org>, 
	James Clark <james.clark@linaro.org>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linux.dev>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Charlie Jenkins <charlie@rivosinc.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Athira Rajeev <atrajeev@linux.ibm.com>, 
	Howard Chu <howardchu95@gmail.com>, Song Liu <song@kernel.org>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Levi Yun <yeoreum.yun@arm.com>, 
	Zhongqiu Han <quic_zhonhan@quicinc.com>, Blake Jones <blakejones@google.com>, 
	Anubhav Shelat <ashelat@redhat.com>, Chun-Tse Shao <ctshao@google.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Gautam Menghani <gautam@linux.ibm.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Yang Li <yang.lee@linux.alibaba.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Andi Kleen <ak@linux.intel.com>, Weilin Wang <weilin.wang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sessions are necessary to be able to use perf.data files within a
tool. Add a wrapper python type that incorporates the tool. Allow a
sample callback to be passed when creating the session. When
process_events is run this callback will be called, if supplied, for
sample events.

An example use looks like:
```
$ perf record -e cycles,instructions -a sleep 3
$ PYTHONPATH=3D..../perf/python python3
Python 3.13.7 (main, Aug 20 2025, 22:17:40) [GCC 14.2.0] on linux
Type "help", "copyright", "credits" or "license" for more information.
>>> import perf
>>> count=3D0
... def handle_sample(x):
...   global count
...   if count < 3:
...     print(dir(x))
...   count =3D count + 1
... perf.session(perf.data("perf.data"),sample=3Dhandle_sample).process_eve=
nts()
...
['__class__', '__delattr__', '__dir__', '__doc__', '__eq__', '__format__', =
'__ge__', '__getattribute__', '__getstate__', '__gt__', '__hash__', '__init=
__', '__init_subclass__', '__le__', '__lt__', '__ne__', '__new__', '__reduc=
e__', '__reduce_ex__', '__repr__', '__setattr__', '__sizeof__', '__str__', =
'__subclasshook__', 'sample_addr', 'sample_cpu', 'sample_id', 'sample_ip', =
'sample_period', 'sample_pid', 'sample_stream_id', 'sample_tid', 'sample_ti=
me', 'type']
['__class__', '__delattr__', '__dir__', '__doc__', '__eq__', '__format__', =
'__ge__', '__getattribute__', '__getstate__', '__gt__', '__hash__', '__init=
__', '__init_subclass__', '__le__', '__lt__', '__ne__', '__new__', '__reduc=
e__', '__reduce_ex__', '__repr__', '__setattr__', '__sizeof__', '__str__', =
'__subclasshook__', 'sample_addr', 'sample_cpu', 'sample_id', 'sample_ip', =
'sample_period', 'sample_pid', 'sample_stream_id', 'sample_tid', 'sample_ti=
me', 'type']
['__class__', '__delattr__', '__dir__', '__doc__', '__eq__', '__format__', =
'__ge__', '__getattribute__', '__getstate__', '__gt__', '__hash__', '__init=
__', '__init_subclass__', '__le__', '__lt__', '__ne__', '__new__', '__reduc=
e__', '__reduce_ex__', '__repr__', '__setattr__', '__sizeof__', '__str__', =
'__subclasshook__', 'sample_addr', 'sample_cpu', 'sample_id', 'sample_ip', =
'sample_period', 'sample_pid', 'sample_stream_id', 'sample_tid', 'sample_ti=
me', 'type']
```

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/python.c | 114 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 113 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index f96c1f6dca56..dfc6e9299af9 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -19,8 +19,10 @@
 #include "pmus.h"
 #include "print_binary.h"
 #include "record.h"
+#include "session.h"
 #include "strbuf.h"
 #include "thread_map.h"
+#include "tool.h"
 #include "tp_pmu.h"
 #include "trace-event.h"
 #include "metricgroup.h"
@@ -2219,6 +2221,112 @@ static int pyrf_data__setup_types(void)
 	return PyType_Ready(&pyrf_data__type);
 }
=20
+struct pyrf_session {
+	PyObject_HEAD
+
+	struct perf_session *session;
+	struct perf_tool tool;
+	struct pyrf_data *pdata;
+	PyObject *sample;
+	PyObject *stat;
+};
+
+static int pyrf_session_tool__sample(const struct perf_tool *tool,
+				     union perf_event *event,
+				     struct perf_sample *sample,
+				     struct evsel *evsel,
+				     struct machine *machine __maybe_unused)
+{
+	struct pyrf_session *psession =3D container_of(tool, struct pyrf_session,=
 tool);
+	PyObject *pyevent =3D pyrf_event__new(event);
+	struct pyrf_event *pevent =3D (struct pyrf_event *)pyevent;
+
+	if (pyevent =3D=3D NULL)
+		return -ENOMEM;
+
+	pevent->evsel =3D evsel;
+	memcpy(&pevent->sample, sample, sizeof(struct perf_sample));
+
+	PyObject_CallFunction(psession->sample, "O", pyevent);
+	Py_DECREF(pyevent);
+	return 0;
+}
+
+static int pyrf_session__init(struct pyrf_session *psession, PyObject *arg=
s, PyObject *kwargs)
+{
+	struct pyrf_data *pdata;
+	PyObject *sample =3D NULL;
+	static char *kwlist[] =3D { "data", "sample", NULL };
+
+	if (!PyArg_ParseTupleAndKeywords(args, kwargs, "O|O", kwlist, &pdata, &sa=
mple))
+		return -1;
+
+	Py_INCREF(pdata);
+	psession->pdata =3D pdata;
+	perf_tool__init(&psession->tool, /*ordered_events=3D*/true);
+
+	#define ADD_TOOL(name) \
+	if (name) {					\
+		if (!PyCallable_Check(name)) {\
+			PyErr_SetString(PyExc_TypeError, #name " must be callable"); \
+			return -1;\
+		}\
+		psession->tool.name =3D pyrf_session_tool__##name;	\
+		Py_INCREF(name); \
+		psession->name =3D name; \
+	}
+
+	ADD_TOOL(sample);
+	#undef ADD_TOOL
+
+	psession->session =3D perf_session__new(&pdata->data, &psession->tool);
+	return psession->session ? 0 : -1;
+}
+
+static void pyrf_session__delete(struct pyrf_session *psession)
+{
+	Py_XDECREF(psession->pdata);
+	Py_XDECREF(psession->sample);
+	perf_session__delete(psession->session);
+	Py_TYPE(psession)->tp_free((PyObject *)psession);
+}
+
+static PyObject *pyrf_session__process_events(struct pyrf_session *psessio=
n)
+{
+	perf_session__process_events(psession->session);
+	Py_INCREF(Py_None);
+	return Py_None;
+}
+
+static PyMethodDef pyrf_session__methods[] =3D {
+	{
+		.ml_name  =3D "process_events",
+		.ml_meth  =3D (PyCFunction)pyrf_session__process_events,
+		.ml_flags =3D METH_NOARGS,
+		.ml_doc	  =3D PyDoc_STR("Iterate and process events.")
+	},
+	{ .ml_name =3D NULL, }
+};
+
+static const char pyrf_session__doc[] =3D PyDoc_STR("perf session object."=
);
+
+static PyTypeObject pyrf_session__type =3D {
+	PyVarObject_HEAD_INIT(NULL, 0)
+	.tp_name	=3D "perf.session",
+	.tp_basicsize	=3D sizeof(struct pyrf_session),
+	.tp_dealloc	=3D (destructor)pyrf_session__delete,
+	.tp_flags	=3D Py_TPFLAGS_DEFAULT|Py_TPFLAGS_BASETYPE,
+	.tp_methods	=3D pyrf_session__methods,
+	.tp_doc		=3D pyrf_session__doc,
+	.tp_init	=3D (initproc)pyrf_session__init,
+};
+
+static int pyrf_session__setup_types(void)
+{
+	pyrf_session__type.tp_new =3D PyType_GenericNew;
+	return PyType_Ready(&pyrf_session__type);
+}
+
 static PyMethodDef perf__methods[] =3D {
 	{
 		.ml_name  =3D "metrics",
@@ -2282,7 +2390,8 @@ PyMODINIT_FUNC PyInit_perf(void)
 	    pyrf_pmu_iterator__setup_types() < 0 ||
 	    pyrf_pmu__setup_types() < 0 ||
 	    pyrf_counts_values__setup_types() < 0 ||
-	    pyrf_data__setup_types() < 0)
+	    pyrf_data__setup_types() < 0 ||
+	    pyrf_session__setup_types() < 0)
 		return module;
=20
 	/* The page_size is placed in util object. */
@@ -2333,6 +2442,9 @@ PyMODINIT_FUNC PyInit_perf(void)
 	Py_INCREF(&pyrf_data__type);
 	PyModule_AddObject(module, "data", (PyObject *)&pyrf_data__type);
=20
+	Py_INCREF(&pyrf_data__type);
+	PyModule_AddObject(module, "session", (PyObject *)&pyrf_session__type);
+
 	dict =3D PyModule_GetDict(module);
 	if (dict =3D=3D NULL)
 		goto error;
--=20
2.51.1.851.g4ebd6896fd-goog

