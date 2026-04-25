Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA593909B3
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 22:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777156925; cv=none; b=JRPnzJW38iz7s9gfWv7y00YbCXnAP1TWZBf7H0jQrwIS7Hk61WqkAV6ltdPMZV20rcaJfNxtz7OyZq2ICzWLx3vQRvc+zMkUFm4Oh+LD37rrTPqSQ/jDU0kecP6Zmqbzwl6MAUu8eqbEVsqYbXghGnV8jtTLJ0KXmUD000MCR+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777156925; c=relaxed/simple;
	bh=ozNykEEtUHxpduvqP4J+aLXrCBbkFXDFkwW7iCbRseM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iv9DFpTbIviTAoAk9wwHZj2/qdTzHf9D1DVVAtFbsCkcqaxVc+vgRKPzaZfL02CkrftQlUp2hzE8Ono4SxmTYOesP2hFvHzr6znKVXRoCj2epTgpOCt3UfuFtHD2mdAw2UpiXBERev/IlqQ3+p1IDMGHAyI25dtInF5nDPlKz+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Cx77kKY8; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Cx77kKY8"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2b458add85aso93067745ad.2
        for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 15:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777156922; x=1777761722; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ksoru2Zcnv41fS9ZZdiwot6rjc0ud5JoTNQnJ6ZzGMs=;
        b=Cx77kKY8YaiS3a/MOgqxzVM8KMy6UWrJw12997FQKaUn1O/4iPK2vZlmX3lIgu1crB
         FXswcRfHNTZasipVEVA19Q8Arr8AOrvkjo/Fx9QrehS1rq8ywBkT5KRx3b6m+KkooxeR
         BwkgqPJhEw9KjmG/L9VR3WpdsrVwV2AVLfkINLvDcDx7+HjyXlsY2Th4gs1F8DMEtww3
         naOUS3BTTcXEZmG7aprKz88ltH/+ZsWoWCLSJf53X1OmfEXi0i1zTw9GR1WG5jTIo8mB
         48Q0VhbHfjzPQo0dKdZlcYxa9NAyrUwgIa3nRJLbOAoPN1s4d9U6sZknQK2j+cLy9CTp
         wJ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777156922; x=1777761722;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ksoru2Zcnv41fS9ZZdiwot6rjc0ud5JoTNQnJ6ZzGMs=;
        b=ZqZX/OJVnGsWx3+3It1o222ywapwcU/cAXZGjF+cswTV+977KAmD6cGujoVLcWt2CR
         d20s5nb9kDitjLLNsSBOWX6yoSQ0WN05sdihz8vwJ2og+bJwaduhuwPxYoHHK8zzEBsR
         hltHPwCAnPB9sNYBQ19YQJkD7SIKQrpjacddoootZog/Bk2zcaV6Q612bQh6jI8QrsxO
         hpW7IVQq9zntnjiBf9mwGm//oeSfq4dJiWdPwVdJfibdBqkPZkDURU90ALhwcfQWBclU
         z8VRItu1UQzffmsoUM0QJbY3ZoUenLZDOnQh5hF4UepiTqt/0T39jIu7RMlLTc/t0DRG
         2nYw==
X-Forwarded-Encrypted: i=1; AFNElJ9R6ogDqqY1ViLkH3DudrzxEMW0s9E3lBhrQfrKltDXjT/Iw/F7K1yNbjDZ4lmqS3aCDBPoVyeb1hogl1BwT15/@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0lHa2FcYZ53lA7S3IlYJqiLxDoL8z3PD1V+1iJ+Y0mYMQS1v3
	UILNoJM51fefKFPem58/hB8fV+6VqVEic9N1qHKHgb14iLsgucpRZ+SQ94oSlzYtNwmwiQxsbO4
	lQ3a3wjJW0w==
X-Received: from plpl14.prod.google.com ([2002:a17:903:3dce:b0:2b2:4d97:2538])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:fa3:b0:2b2:ebed:7af8
 with SMTP id d9443c01a7336-2b5f9e5df98mr390689465ad.1.1777156922133; Sat, 25
 Apr 2026 15:42:02 -0700 (PDT)
Date: Sat, 25 Apr 2026 15:40:40 -0700
In-Reply-To: <20260425224125.160890-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260425174858.3922152-1-irogers@google.com> <20260425224125.160890-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260425224125.160890-16-irogers@google.com>
Subject: [PATCH v7 15/59] perf python: Add python session abstraction wrapping
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
v7:
- Fixed NULL comm handling.
- Avoided swallowing exceptions in module init.
- Fixed checkpatch warning for missing blank line.
---
 tools/perf/util/python.c | 279 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 273 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index aa63c7ffe822..1af53480661f 100644
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
@@ -2413,6 +2419,256 @@ static int pyrf_data__setup_types(void)
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
+	if (!str)
+		Py_RETURN_NONE;
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
+static PyObject *pyrf_session__find_thread(struct pyrf_session *psession, =
PyObject *args)
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
+static PyObject *pyrf_session__find_thread_events(struct pyrf_session *pse=
ssion)
+{
+	int err =3D perf_session__process_events(psession->session);
+
+	return PyLong_FromLong(err);
+}
+
+static PyMethodDef pyrf_session__methods[] =3D {
+	{
+		.ml_name  =3D "process_events",
+		.ml_meth  =3D (PyCFunction)pyrf_session__find_thread_events,
+		.ml_flags =3D METH_NOARGS,
+		.ml_doc	  =3D PyDoc_STR("Iterate and process events.")
+	},
+	{
+		.ml_name  =3D "find_thread",
+		.ml_meth  =3D (PyCFunction)pyrf_session__find_thread,
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
@@ -2467,8 +2723,10 @@ PyMODINIT_FUNC PyInit_perf(void)
 	};
 	PyObject *module =3D PyModule_Create(&moduledef);
=20
-	if (module =3D=3D NULL ||
-	    pyrf_event__setup_types() < 0 ||
+	if (module =3D=3D NULL)
+		return NULL;
+
+	if (pyrf_event__setup_types() < 0 ||
 	    pyrf_evlist__setup_types() < 0 ||
 	    pyrf_evsel__setup_types() < 0 ||
 	    pyrf_thread_map__setup_types() < 0 ||
@@ -2476,8 +2734,12 @@ PyMODINIT_FUNC PyInit_perf(void)
 	    pyrf_pmu_iterator__setup_types() < 0 ||
 	    pyrf_pmu__setup_types() < 0 ||
 	    pyrf_counts_values__setup_types() < 0 ||
-	    pyrf_data__setup_types() < 0)
-		return module;
+	    pyrf_data__setup_types() < 0 ||
+	    pyrf_session__setup_types() < 0 ||
+	    pyrf_thread__setup_types() < 0) {
+		Py_DECREF(module);
+		return NULL;
+	}
=20
 	/* The page_size is placed in util object. */
 	page_size =3D sysconf(_SC_PAGE_SIZE);
@@ -2527,6 +2789,9 @@ PyMODINIT_FUNC PyInit_perf(void)
 	Py_INCREF(&pyrf_data__type);
 	PyModule_AddObject(module, "data", (PyObject *)&pyrf_data__type);
=20
+	Py_INCREF(&pyrf_session__type);
+	PyModule_AddObject(module, "session", (PyObject *)&pyrf_session__type);
+
 	dict =3D PyModule_GetDict(module);
 	if (dict =3D=3D NULL)
 		goto error;
@@ -2540,7 +2805,9 @@ PyMODINIT_FUNC PyInit_perf(void)
 	}
=20
 error:
-	if (PyErr_Occurred())
-		PyErr_SetString(PyExc_ImportError, "perf: Init failed!");
+	if (PyErr_Occurred()) {
+		Py_XDECREF(module);
+		return NULL;
+	}
 	return module;
 }
--=20
2.54.0.545.g6539524ca2-goog

