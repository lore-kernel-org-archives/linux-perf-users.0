Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A777839151A
	for <linux-perf-users@vger.kernel.org>; Fri, 22 May 2026 22:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779487513; cv=none; b=SIB0BdZxe6G0D9xJD4ytVt38+tZDcnJsRQ1NmSPCO9GAHWgRCGyf5dGI2PA0vA07pzIi64Hs7/58RGIWwv5dwKttfXXuPvMPABgrU5Qb2nPEREg+ozyM6RivYtUWSN+/19YOBtkLgAt0ZmHxXtB2gM+8QDrNJamUf7YGcydVLsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779487513; c=relaxed/simple;
	bh=gvBptQKaSgmfUfS145HUmhgpMcvrH5P5Pz4UOhnaArg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=J2vCD0zmkNr5x+srgzGhE6wILNlthAVjxJ2HVqaUxPwizzrmJUO6NBU2hmbiZJ1jFS7eZWiWVpbyr/RC3AFcI1hTlotjW5tTqh5dtRiLq050196O2zAlxtO1pLpApcrF7No2SVr5sQRmLtfXNNOPCDZXBOpHzQW0w/ExHNpBUu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dEfe6vdQ; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dEfe6vdQ"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-1353a6f29deso8911606c88.1
        for <linux-perf-users@vger.kernel.org>; Fri, 22 May 2026 15:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779487511; x=1780092311; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xoBU3gZcurjcKHYbf58ZwDiLxFElSjco1fizLq6p168=;
        b=dEfe6vdQyiA8Zi4f2iLVk3pUwmZ0fehShiUZSne5b3Fpa51WZwBwpm9ZadB4qyFJzE
         iJsp7axCNd+GIFbG8iyb9u44FeAM3aa17Vf7FhmKpbhVBdDVDwYiwhC1nR/ZF7wEdmGs
         VlWNt6GD3wu+KUpujiH8irxOOpU61bWP9qkP53zdK12LRZoUXoHxOZLwCXRKFS6hxJz5
         55GUfMSHAJLlM0p34KUP2/nhuMM7gXabdTputctvvajIegKK8URQssESJL0hObkJvWww
         dz7Gd1w3K+90N6njnrt2+WfVvpuEhZTM+oiEdvAE+MvL8/547DsJTO9ZltOBtqdTPuOL
         NWsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779487511; x=1780092311;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xoBU3gZcurjcKHYbf58ZwDiLxFElSjco1fizLq6p168=;
        b=I2wD/xPR8cJBnUSQ0wId43dkGNUDUUR2XMn4Ss2B2+cV8P+PRiRaLlV3kL1YnaGHIG
         6J3F0Q5M0XLD/dZATGebnEDg+pnsh8O/wHPVHydlDd/fdkp5VCN1eA8mKdVav9Ol37/c
         y/WvNl8YaOqe4ACLUxxTUaAJRmMR5xO3uH8Q4T5YAI+uIZSqmSOwkR2gNC10LmwjrRbj
         ozTWDlykVuBr2/ylu9T7S5nlTzK9Qsv/fFZpwrEF06xLXMY1mh5VRwRsvnuzm9IUMNPo
         rILanRX6MzAGXvWzQoR3dpWAsNR7fUBvivnHzhaFYAcFgd6cvtakM6e/jIS+2ZK/xnlz
         +L1A==
X-Forwarded-Encrypted: i=1; AFNElJ9K/1RmUygE0lj1r9G4yB1p4tPCN8zW/G3aMthJjtaCjq60kmPHe6MxDgl2jEb/QMBf+h4hIfzWgo1xC1W+eQ65@vger.kernel.org
X-Gm-Message-State: AOJu0YwZL34ooLHd/jV/t38cedG8VkHSerUzXri+isEuITkFBbFHOuK6
	2bnKRN+P3RuBUf5uKYD3obtlOB/OIk9cnzMYNL2z9NoshmjQIzFpRKHNCEGJSIldcZl8mUKfplT
	wnYuz+BSLiQ==
X-Received: from dlbrh17.prod.google.com ([2002:a05:7022:f311:b0:136:6230:5814])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:fa9:b0:11b:f056:a19b
 with SMTP id a92af1059eb24-1365f926a43mr2243202c88.18.1779487510178; Fri, 22
 May 2026 15:05:10 -0700 (PDT)
Date: Fri, 22 May 2026 15:04:25 -0700
In-Reply-To: <20260522220435.2378363-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260428071903.1886173-1-irogers@google.com> <20260522220435.2378363-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <20260522220435.2378363-15-irogers@google.com>
Subject: [PATCH v9 14/23] perf python: Add python session abstraction wrapping
 perf's session
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, alice.mei.rogers@gmail.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org, leo.yan@linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	tmricht@linux.ibm.com
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

v7:
- Fixed NULL comm handling.
- Avoided swallowing exceptions in module init.
- Fixed checkpatch warning for missing blank line.

v8:
- Switch from pyrf_session__init to pyrf_session__new to avoid dealing with=
 a
  potentially NULL session variable.
    - Added pid, tid, ppid, and cpu attributes to perf.thread.
---
 tools/perf/util/python.c | 310 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 304 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 82adc59ecd94..18a48779c591 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -11,8 +11,10 @@
 #include <structmember.h>
=20
 #include "callchain.h"
+#include "comm.h"
 #include "counts.h"
 #include "data.h"
+#include "debug.h"
 #include "event.h"
 #include "evlist.h"
 #include "evsel.h"
@@ -22,8 +24,12 @@
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
@@ -2417,6 +2423,287 @@ static int pyrf_data__setup_types(void)
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
+static PyObject *pyrf_thread__get_pid(struct pyrf_thread *pthread, void *c=
losure __maybe_unused)
+{
+	return PyLong_FromLong(thread__pid(pthread->thread));
+}
+
+static PyObject *pyrf_thread__get_tid(struct pyrf_thread *pthread, void *c=
losure __maybe_unused)
+{
+	return PyLong_FromLong(thread__tid(pthread->thread));
+}
+
+static PyObject *pyrf_thread__get_ppid(struct pyrf_thread *pthread, void *=
closure __maybe_unused)
+{
+	return PyLong_FromLong(thread__ppid(pthread->thread));
+}
+
+static PyObject *pyrf_thread__get_cpu(struct pyrf_thread *pthread, void *c=
losure __maybe_unused)
+{
+	return PyLong_FromLong(thread__cpu(pthread->thread));
+}
+
+static PyGetSetDef pyrf_thread__getset[] =3D {
+	{ .name =3D "pid", .get =3D (getter)pyrf_thread__get_pid, .doc =3D "proce=
ss ID" },
+	{ .name =3D "tid", .get =3D (getter)pyrf_thread__get_tid, .doc =3D "threa=
d ID" },
+	{ .name =3D "ppid", .get =3D (getter)pyrf_thread__get_ppid, .doc =3D "par=
ent process ID" },
+	{ .name =3D "cpu", .get =3D (getter)pyrf_thread__get_cpu, .doc =3D "cpu n=
umber" },
+	{ .name =3D NULL }
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
+	.tp_getset	=3D pyrf_thread__getset,
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
+};
+
+static int pyrf_session_tool__sample(const struct perf_tool *tool,
+				     union perf_event *event,
+				     struct perf_sample *sample,
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
+	if (evsel__parse_sample(sample->evsel, &pevent->event, &pevent->sample) <=
 0) {
+		Py_DECREF(pyevent);
+		return -1;
+	}
+
+	ret =3D PyObject_CallFunction(psession->sample, "O", pyevent);
+	if (!ret) {
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
+static PyObject *pyrf_session__new(PyTypeObject *type, PyObject *args, PyO=
bject *kwargs)
+{
+	struct pyrf_data *pdata;
+	PyObject *sample =3D NULL;
+	static char *kwlist[] =3D { "data", "sample", NULL };
+	struct pyrf_session *psession;
+	struct perf_session *session;
+
+	if (!PyArg_ParseTupleAndKeywords(args, kwargs, "O!|O", kwlist, &pyrf_data=
__type, &pdata,
+					 &sample))
+		return NULL;
+
+	psession =3D PyObject_New(struct pyrf_session, type);
+	if (!psession)
+		return NULL;
+
+	psession->session =3D NULL;
+	psession->sample =3D NULL;
+	psession->pdata =3D NULL;
+
+	Py_INCREF(pdata);
+	psession->pdata =3D pdata;
+
+	perf_tool__init(&psession->tool, /*ordered_events=3D*/true);
+	psession->tool.ordering_requires_timestamps =3D true;
+
+	#define ADD_TOOL(name)						\
+	do {								\
+		if (name) {						\
+			if (!PyCallable_Check(name)) {			\
+				PyErr_SetString(PyExc_TypeError, #name " must be callable"); \
+				goto err_out;				\
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
+	session =3D perf_session__new(&pdata->data, &psession->tool);
+	if (IS_ERR(session)) {
+		PyErr_Format(PyExc_IOError, "failed to create session: %ld", PTR_ERR(ses=
sion));
+		goto err_out;
+	}
+	psession->session =3D session;
+
+	if (symbol__init(perf_session__env(session)) < 0) {
+		PyErr_SetString(PyExc_OSError, "perf: symbol__init failed");
+		goto err_out;
+	}
+
+	if (perf_session__create_kernel_maps(session) < 0)
+		pr_warning("Cannot read kernel map\n");
+
+	return (PyObject *)psession;
+err_out:
+	Py_DECREF(psession);
+	return NULL;
+}
+
+static void pyrf_session__delete(struct pyrf_session *psession)
+{
+	perf_session__delete(psession->session);
+	Py_XDECREF(psession->pdata);
+	Py_XDECREF(psession->sample);
+	Py_TYPE(psession)->tp_free((PyObject *)psession);
+}
+
+static PyObject *pyrf_session__find_thread_events(struct pyrf_session *pse=
ssion)
+{
+	int err =3D perf_session__process_events(psession->session);
+
+	if (PyErr_Occurred())
+		return NULL;
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
+	.tp_new		=3D pyrf_session__new,
+};
+
+static int pyrf_session__setup_types(void)
+{
+	return PyType_Ready(&pyrf_session__type);
+}
+
 static PyMethodDef perf__methods[] =3D {
 	{
 		.ml_name  =3D "metrics",
@@ -2471,8 +2758,10 @@ PyMODINIT_FUNC PyInit_perf(void)
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
@@ -2480,8 +2769,12 @@ PyMODINIT_FUNC PyInit_perf(void)
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
@@ -2531,6 +2824,9 @@ PyMODINIT_FUNC PyInit_perf(void)
 	Py_INCREF(&pyrf_data__type);
 	PyModule_AddObject(module, "data", (PyObject *)&pyrf_data__type);
=20
+	Py_INCREF(&pyrf_session__type);
+	PyModule_AddObject(module, "session", (PyObject *)&pyrf_session__type);
+
 	dict =3D PyModule_GetDict(module);
 	if (dict =3D=3D NULL)
 		goto error;
@@ -2544,7 +2840,9 @@ PyMODINIT_FUNC PyInit_perf(void)
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
2.54.0.794.g4f17f83d09-goog

