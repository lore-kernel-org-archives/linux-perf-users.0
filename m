Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA8B30C34A
	for <linux-perf-users@vger.kernel.org>; Fri, 24 Apr 2026 16:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777049302; cv=none; b=gmvjoy85x5ZLFwNnM4zTagu5DYjZgWj0oycSwi1+yGMV3HoxalV9bY+Hlzz7+b/buBN93cAI3PMZzmmQuZByzw9jE98Ww3+bzPAyo4vDMFvnPMT4DWAUdxTN7yEPa/UWqz0DSvdAPceb1iHRhZp2LpIEdPyRoWjtYtVkhKSaNBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777049302; c=relaxed/simple;
	bh=X+phwvhz/TuIkRteUktaS82i0Fhvlo5nOHYBUvDxVd0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bYxEFyn4hajS2WzFzNVOxBjKmh+qBW38qa2A0r0pWZYu2hqiY6CzaZY9cTcfeCD4tDhjiS8CmaB1kWt5oAQgaEvJSKpUAe4M3ePY/U4lcR53yPx6EaDUaBByM1lNs5gHUlcPdMcrpHNtcFtWW1vlhf3MSMyiM7gzaQBBn+wY2/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aqKYPsUp; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aqKYPsUp"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2bdf6fe90a9so11663474eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 24 Apr 2026 09:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777049299; x=1777654099; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IMeuKk3N1KumGCYaMtfihPo8p3bGRkb9IZElwKpDHwU=;
        b=aqKYPsUpVVW5oyw3dIFOkdPZcQ8nnIaZTIMGsS0yjuJVH3kYTmet/Xq0/r6ZzpbDmt
         72bmD/7erBrNMVTRpEqbBO11+/ZQy8A0hSXd9j6G2Q2G3NNwKWag+A22tTQVlvK5SVd1
         LwOjNUC/AIE/sJuLcCNLiZyMl6WVvPnmQFxXw8K1LTRadUjrycTVIQeiRi0t+3yLq3qQ
         D+3dRfhnblBmZDdJXCk16c1LXfFiaXq6iD7OUlZkom9vDOOJyb3DkMR5EEGax+WK8DpR
         pbLWnhZbDSqrk+9/3NvYQZW8oz9gwEH80rqXAMv0WlJToffd+uwAFUxbry96hAsdx8LH
         gIqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777049299; x=1777654099;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IMeuKk3N1KumGCYaMtfihPo8p3bGRkb9IZElwKpDHwU=;
        b=i8vH2g2oYAgf8XA6hyU1fV8S/k5R7+qXgfhrBlAhoxIQQwkfkoRRojw6SbyiDLEmam
         Tks8d90NomgY8aBS9brUL0fuh+EzlIwoAIr/VLZkFTe4TPdu5Nl/qRa7XXI/9xm+8Q9t
         7MugRt3TIE5vtQWZkZkFQEj7QFCSC35auDpg3o211k8v54gLVlSY3eZq5Pxz3szkb93t
         zq37SBnlhvh+51jWx5l3vhjaraLC4aCYhSGSgJO8MvqcQStvaZ8VlqZ/SV33LKOozEjX
         7WrFKeqKQ3k5r1WqvtXZUUL+iVEkiF5X38omVYZ80PiDAaRFTAXZlNpsWFxpo3Psccz0
         27OA==
X-Forwarded-Encrypted: i=1; AFNElJ+G85YqEAipqb720tZB92X0Hk0Aay2qJ3sSXU3XFirTcv+8D2Hl1iN695hdsO0gnts0Fwjuu8yM3RS0gtsv/tPW@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0wBaTcDOSGgTM5quaK06SU+hoUkzyHtqIlq3Qaj0W9g2b8sPt
	LwL5kepN9jqZUiwV/eonmhhdpL+FQIpoNLQ8PJfX1jj3z5NLPjz5aw4cjPOGZTw1NfyUjCbyej8
	arFpFPHVRNw==
X-Received: from dlbut4.prod.google.com ([2002:a05:7022:7e04:b0:12b:e83a:8d31])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6988:b0:128:ceac:6da6
 with SMTP id a92af1059eb24-12c73fad1e2mr15100379c88.30.1777049299072; Fri, 24
 Apr 2026 09:48:19 -0700 (PDT)
Date: Fri, 24 Apr 2026 09:46:37 -0700
In-Reply-To: <20260424164721.2229025-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260423163406.1779809-1-irogers@google.com> <20260424164721.2229025-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260424164721.2229025-16-irogers@google.com>
Subject: [PATCH v5 15/58] perf python: Add python session abstraction wrapping
 perf's session
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, adrian.hunter@intel.com, james.clark@linaro.org, 
	leo.yan@linux.dev, namhyung@kernel.org, tmricht@linux.ibm.com
Cc: alice.mei.rogers@gmail.com, dapeng1.mi@linux.intel.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	Ian Rogers <irogers@google.com>
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

Also, add the ability to get the thread associated with a session. For
threads, allow the comm string to be retrieved. This can be useful for
filtering threads. Connect up some of the standard event handling in
psession->tool to better support queries of the machine. Also connect
up the symbols.

Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---
v2:

1. Fixed Potential Crash in pyrf_thread__comm : Used
   thread__comm_str() to safely retrieve the command name, avoiding a
   crash if thread__comm() returns NULL.

2. Fixed Double Free Risk: Zeroed out user_regs , intr_regs , and
   callchain in the shallow copy of perf_sample to prevent Python from
   attempting to free pointers it doesn't own.

3. Fixed Memory Leak & Exception Handling in Callback: Handled the
   return value of PyObject_CallFunction() to avoid leaks, and checked
   for failure to abort the loop and propagate Python exceptions
   cleanly.

4. Enforced Type Safety: Used O!  with &pyrf_data__type in
   PyArg_ParseTupleAndKeywords to prevent bad casts from passing
   arbitrary objects as perf.data.

5. Added Missing Build ID Handler: Registered
   perf_event__process_build_id to allow correct symbol resolution.

6. Fixed Double Free Crash on Init Failure: Set session and pdata to
   NULL on failure to prevent tp_dealloc from double-freeing them.

7. Preserved C-level Errors: Made pyrf_session__process_events return
   the error code integer rather than always returning None .
---
 tools/perf/util/python.c | 259 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 258 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index a2cdd92e0548..35eda69a32e1 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -9,8 +9,10 @@
 #include <perf/mmap.h>
=20
 #include "callchain.h"
+#include "comm.h"
 #include "counts.h"
 #include "data.h"
+#include "debug.h"
 #include "event.h"
 #include "evlist.h"
 #include "evsel.h"
@@ -20,8 +22,12 @@
 #include "pmus.h"
 #include "print_binary.h"
 #include "record.h"
+#include "session.h"
 #include "strbuf.h"
+#include "symbol.h"
+#include "thread.h"
 #include "thread_map.h"
+#include "tool.h"
 #include "tp_pmu.h"
 #include "trace-event.h"
 #include "util/sample.h"
@@ -2383,6 +2389,252 @@ static int pyrf_data__setup_types(void)
 	return PyType_Ready(&pyrf_data__type);
 }
=20
+struct pyrf_thread {
+	PyObject_HEAD
+
+	struct thread *thread;
+};
+
+static void pyrf_thread__delete(struct pyrf_thread *pthread)
+{
+	thread__put(pthread->thread);
+	Py_TYPE(pthread)->tp_free((PyObject *)pthread);
+}
+
+static PyObject *pyrf_thread__comm(PyObject *obj)
+{
+	struct pyrf_thread *pthread =3D (void *)obj;
+	const char *str =3D thread__comm_str(pthread->thread);
+
+	return PyUnicode_FromString(str);
+}
+
+static PyMethodDef pyrf_thread__methods[] =3D {
+	{
+		.ml_name  =3D "comm",
+		.ml_meth  =3D (PyCFunction)pyrf_thread__comm,
+		.ml_flags =3D METH_NOARGS,
+		.ml_doc	  =3D PyDoc_STR("Comm(and) associated with this thread.")
+	},
+	{ .ml_name =3D NULL, }
+};
+
+static const char pyrf_thread__doc[] =3D PyDoc_STR("perf thread object.");
+
+static PyTypeObject pyrf_thread__type =3D {
+	PyVarObject_HEAD_INIT(NULL, 0)
+	.tp_name	=3D "perf.thread",
+	.tp_basicsize	=3D sizeof(struct pyrf_thread),
+	.tp_dealloc	=3D (destructor)pyrf_thread__delete,
+	.tp_flags	=3D Py_TPFLAGS_DEFAULT|Py_TPFLAGS_BASETYPE,
+	.tp_methods	=3D pyrf_thread__methods,
+	.tp_doc		=3D pyrf_thread__doc,
+};
+
+static int pyrf_thread__setup_types(void)
+{
+	return PyType_Ready(&pyrf_thread__type);
+}
+
+static PyObject *pyrf_thread__from_thread(struct thread *thread)
+{
+	struct pyrf_thread *pthread =3D PyObject_New(struct pyrf_thread, &pyrf_th=
read__type);
+
+	if (!pthread)
+		return NULL;
+
+	pthread->thread =3D thread__get(thread);
+	return (PyObject *)pthread;
+}
+
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
+	PyObject *ret;
+
+	if (pyevent =3D=3D NULL)
+		return -ENOMEM;
+
+	memcpy(&pevent->event, event, event->header.size);
+	if (evsel__parse_sample(evsel, &pevent->event, &pevent->sample) < 0) {
+		Py_DECREF(pyevent);
+		return -1;
+	}
+	/* Avoid shallow copy pointing to lazily allocated memory that would be d=
ouble freed. */
+	pevent->sample.user_regs =3D NULL;
+	pevent->sample.intr_regs =3D NULL;
+	if (pevent->sample.merged_callchain)
+		pevent->sample.callchain =3D NULL;
+
+	ret =3D PyObject_CallFunction(psession->sample, "O", pyevent);
+	if (!ret) {
+		PyErr_Print();
+		Py_DECREF(pyevent);
+		return -1;
+	}
+	Py_DECREF(ret);
+	Py_DECREF(pyevent);
+	return 0;
+}
+
+static PyObject *pyrf_session__process(struct pyrf_session *psession, PyOb=
ject *args)
+{
+	struct machine *machine;
+	struct thread *thread =3D NULL;
+	PyObject *result;
+	int pid;
+
+	if (!PyArg_ParseTuple(args, "i", &pid))
+		return NULL;
+
+	machine =3D &psession->session->machines.host;
+	thread =3D machine__find_thread(machine, pid, pid);
+
+	if (!thread) {
+		machine =3D perf_session__find_machine(psession->session, pid);
+		if (machine)
+			thread =3D machine__find_thread(machine, pid, pid);
+	}
+
+	if (!thread) {
+		PyErr_Format(PyExc_TypeError, "Failed to find thread %d", pid);
+		return NULL;
+	}
+	result =3D pyrf_thread__from_thread(thread);
+	thread__put(thread);
+	return result;
+}
+
+static int pyrf_session__init(struct pyrf_session *psession, PyObject *arg=
s, PyObject *kwargs)
+{
+	struct pyrf_data *pdata;
+	PyObject *sample =3D NULL;
+	static char *kwlist[] =3D { "data", "sample", NULL };
+
+	if (!PyArg_ParseTupleAndKeywords(args, kwargs, "O!|O", kwlist, &pyrf_data=
__type, &pdata,
+					 &sample))
+		return -1;
+
+	Py_INCREF(pdata);
+	psession->pdata =3D pdata;
+	perf_tool__init(&psession->tool, /*ordered_events=3D*/true);
+	psession->tool.ordering_requires_timestamps =3D true;
+
+	#define ADD_TOOL(name)						\
+	do {								\
+		if (name) {						\
+			if (!PyCallable_Check(name)) {			\
+				PyErr_SetString(PyExc_TypeError, #name " must be callable"); \
+				return -1;				\
+			}						\
+			psession->tool.name =3D pyrf_session_tool__##name; \
+			Py_INCREF(name);				\
+			psession->name =3D name;				\
+		}							\
+	} while (0)
+
+	ADD_TOOL(sample);
+	#undef ADD_TOOL
+
+	psession->tool.comm		=3D perf_event__process_comm;
+	psession->tool.mmap		=3D perf_event__process_mmap;
+	psession->tool.mmap2            =3D perf_event__process_mmap2;
+	psession->tool.namespaces       =3D perf_event__process_namespaces;
+	psession->tool.cgroup           =3D perf_event__process_cgroup;
+	psession->tool.exit             =3D perf_event__process_exit;
+	psession->tool.fork             =3D perf_event__process_fork;
+	psession->tool.ksymbol          =3D perf_event__process_ksymbol;
+	psession->tool.text_poke        =3D perf_event__process_text_poke;
+	psession->tool.build_id         =3D perf_event__process_build_id;
+	psession->session =3D perf_session__new(&pdata->data, &psession->tool);
+	if (IS_ERR(psession->session)) {
+		PyErr_Format(PyExc_IOError, "failed to create session: %ld",
+			     PTR_ERR(psession->session));
+		psession->session =3D NULL;
+		Py_DECREF(pdata);
+		psession->pdata =3D NULL;
+		return -1;
+	}
+
+	if (symbol__init(perf_session__env(psession->session)) < 0) {
+		perf_session__delete(psession->session);
+		psession->session =3D NULL;
+		Py_DECREF(psession->pdata);
+		psession->pdata =3D NULL;
+		return -1;
+	}
+
+	if (perf_session__create_kernel_maps(psession->session) < 0)
+		pr_warning("Cannot read kernel map\n");
+
+	return 0;
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
+	int err =3D perf_session__process_events(psession->session);
+	return PyLong_FromLong(err);
+}
+
+static PyMethodDef pyrf_session__methods[] =3D {
+	{
+		.ml_name  =3D "process_events",
+		.ml_meth  =3D (PyCFunction)pyrf_session__process_events,
+		.ml_flags =3D METH_NOARGS,
+		.ml_doc	  =3D PyDoc_STR("Iterate and process events.")
+	},
+	{
+		.ml_name  =3D "process",
+		.ml_meth  =3D (PyCFunction)pyrf_session__process,
+		.ml_flags =3D METH_VARARGS,
+		.ml_doc	  =3D PyDoc_STR("Returns the thread associated with a pid.")
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
@@ -2446,7 +2698,9 @@ PyMODINIT_FUNC PyInit_perf(void)
 	    pyrf_pmu_iterator__setup_types() < 0 ||
 	    pyrf_pmu__setup_types() < 0 ||
 	    pyrf_counts_values__setup_types() < 0 ||
-	    pyrf_data__setup_types() < 0)
+	    pyrf_data__setup_types() < 0 ||
+	    pyrf_session__setup_types() < 0 ||
+	    pyrf_thread__setup_types() < 0)
 		return module;
=20
 	/* The page_size is placed in util object. */
@@ -2497,6 +2751,9 @@ PyMODINIT_FUNC PyInit_perf(void)
 	Py_INCREF(&pyrf_data__type);
 	PyModule_AddObject(module, "data", (PyObject *)&pyrf_data__type);
=20
+	Py_INCREF(&pyrf_session__type);
+	PyModule_AddObject(module, "session", (PyObject *)&pyrf_session__type);
+
 	dict =3D PyModule_GetDict(module);
 	if (dict =3D=3D NULL)
 		goto error;
--=20
2.54.0.545.g6539524ca2-goog

