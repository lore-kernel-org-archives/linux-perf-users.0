Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A79770827
	for <linux-perf-users@vger.kernel.org>; Tue, 19 Nov 2024 01:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731979027; cv=none; b=sUrHYmWghS8BfuMI9RODdzSB6iCW5HSi3utCiLEHqxNnUXGmLXUUGEISs4HucRC5B8XC9KWMTS9ifFKAfFf946bKc0PnuKjQYbGrdRBAl87y3zdzHY2ymDgAFJ483/D9xrBkqW5D16ZOxUjcqaUYMMAEVFFr8AxHozXkvkagsOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731979027; c=relaxed/simple;
	bh=TRzdyrr83yFOHaaZp1XKONQ1u8411y5W18H7l2Lixew=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=qkogcaRwNd8OOxZ4tz+FU6h39QIUPARt4hFiYhVY0yqQVhh4JvLJKqvb42+OowrxUpsOyTEWMhkkQ0hKeVy9jQwx6599hPNL1O010Jun2TBZo3AkyO/v0tNBFnzmWddg+rH3X+gqfR6jK/Ushb1+e7xlPDIuziZSnX+tdsGjD7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wpMvXUCi; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wpMvXUCi"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6ee51558e90so67598577b3.1
        for <linux-perf-users@vger.kernel.org>; Mon, 18 Nov 2024 17:17:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731979023; x=1732583823; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=e5R7N5m+a9zmfRArLdBFQ3oPGXQCBbIT9nqOcsc0Xic=;
        b=wpMvXUCikEG8xPXAfP6G/hg+WYfCfr9d/zAmn+SVUcIrHWi/Nz3s3okgYdbe2d6Kwe
         aTlN0sotq25bfUoxWoqU0AmgJzi5SKWbhOKd5znX/PvKPzsvYflLmDnka6YvlkgnsNkq
         eM25Lp9+6NENYmy7pfrs5cxNCdtvN+0Q15qmoajCNjpcOx+e1GdlwK03zq+0C/ulzSR0
         43aUWpJPKJqbBtBqtowdu5yH9k+0l6sW5zJR2k3Nqq/S3Nxwoqp/JKLLj2i/oWKaa4x4
         wJxm7r5KtMihnGBUmcrdDvwEEDxXVOgG1I6OlrlQKEIHvnS8nKfXvl7omff0Xhwf/ni8
         DSDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731979023; x=1732583823;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e5R7N5m+a9zmfRArLdBFQ3oPGXQCBbIT9nqOcsc0Xic=;
        b=V+maUMW6mBfkXALIifHxyIq6o1KLMThK8IKFIoN5Ea1yolJaw2HLxBlQz5EKrOsrm+
         LhTV5kKfWZGtck+Wk056l6UJff0gzmfYrqpGH+Lz/w6Q61BmLcVNMCg0zRjK+iJCaL2e
         s3y5HFKc2ilalAbcbYM6RBdTXAXXxM+YpPWXVj+zfkTuiW4GVVW/x+9R6cQCUM1bEaIX
         Leba9CNoik03US0ZW+ASZJ/oswFoI26Uro96Jt0hAC3F79i/T3GWQCmD4DoMfjiWmAQS
         zjKW5Obq4nec2GWNw5Jg/e1PJt5S8Lv35odEnJtrbeOuNgfmAbow6+36v2qQkETO55VS
         h43A==
X-Forwarded-Encrypted: i=1; AJvYcCWeTWU5y9+aW18K7uQs5L2oVhKCJlW9R/W4olQRxzGhkKdEv5stCJhiVOmxeo7NWJMhzDJizq5qLThit1p3c8rc@vger.kernel.org
X-Gm-Message-State: AOJu0YyyRsujpY2lnMq/iHS67cFTlg7BdptbN241pjrFwp5BIhad68aB
	TeDswR0tqmeYKzQ4/NV91ns4uRO/D4oSGJInpOl8XCHGD9LFdcYFFhKjBBs/tH3JOkEc2QS2YE3
	lxkOS8A==
X-Google-Smtp-Source: AGHT+IEVB+QEv1B58NiPQwBfZyIOt1tj2t1pVEM3PPvhzdzHVO4jhLeP34Iu6kgscgaXruipXnyyh0ugXJnn
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:22a4:ded5:5c37:fcc7])
 (user=irogers job=sendgmr) by 2002:a05:690c:8110:b0:6ee:3f5e:1c1b with SMTP
 id 00721157ae682-6ee558f3375mr446637b3.0.1731979023191; Mon, 18 Nov 2024
 17:17:03 -0800 (PST)
Date: Mon, 18 Nov 2024 17:16:23 -0800
In-Reply-To: <20241119011644.971342-1-irogers@google.com>
Message-Id: <20241119011644.971342-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241119011644.971342-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Subject: [PATCH v7 01/22] perf python: Remove python 2 scripting support
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Howard Chu <howardchu95@gmail.com>, Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	Michael Petlan <mpetlan@redhat.com>, Veronika Molnarova <vmolnaro@redhat.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Josh Poimboeuf <jpoimboe@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Python2 was deprecated 4 years ago, remove support and workarounds.

Signed-off-by: Ian Rogers <irogers@google.com>
Acked-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../scripts/python/Perf-Trace-Util/Context.c  | 18 -----
 tools/perf/util/python.c                      | 73 +++----------------
 .../scripting-engines/trace-event-python.c    | 63 +---------------
 3 files changed, 15 insertions(+), 139 deletions(-)

diff --git a/tools/perf/scripts/python/Perf-Trace-Util/Context.c b/tools/perf/scripts/python/Perf-Trace-Util/Context.c
index 01f54d6724a5..d742daaa5d5a 100644
--- a/tools/perf/scripts/python/Perf-Trace-Util/Context.c
+++ b/tools/perf/scripts/python/Perf-Trace-Util/Context.c
@@ -24,16 +24,6 @@
 #include "../../../util/srcline.h"
 #include "../../../util/srccode.h"
 
-#if PY_MAJOR_VERSION < 3
-#define _PyCapsule_GetPointer(arg1, arg2) \
-  PyCObject_AsVoidPtr(arg1)
-#define _PyBytes_FromStringAndSize(arg1, arg2) \
-  PyString_FromStringAndSize((arg1), (arg2))
-#define _PyUnicode_AsUTF8(arg) \
-  PyString_AsString(arg)
-
-PyMODINIT_FUNC initperf_trace_context(void);
-#else
 #define _PyCapsule_GetPointer(arg1, arg2) \
   PyCapsule_GetPointer((arg1), (arg2))
 #define _PyBytes_FromStringAndSize(arg1, arg2) \
@@ -42,7 +32,6 @@ PyMODINIT_FUNC initperf_trace_context(void);
   PyUnicode_AsUTF8(arg)
 
 PyMODINIT_FUNC PyInit_perf_trace_context(void);
-#endif
 
 static struct scripting_context *get_args(PyObject *args, const char *name, PyObject **arg2)
 {
@@ -213,12 +202,6 @@ static PyMethodDef ContextMethods[] = {
 	{ NULL, NULL, 0, NULL}
 };
 
-#if PY_MAJOR_VERSION < 3
-PyMODINIT_FUNC initperf_trace_context(void)
-{
-	(void) Py_InitModule("perf_trace_context", ContextMethods);
-}
-#else
 PyMODINIT_FUNC PyInit_perf_trace_context(void)
 {
 	static struct PyModuleDef moduledef = {
@@ -240,4 +223,3 @@ PyMODINIT_FUNC PyInit_perf_trace_context(void)
 
 	return mod;
 }
-#endif
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 2096cdbaa53b..ea6dbe6e4317 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -26,40 +26,14 @@
 #include <internal/lib.h>
 #include "../builtin.h"
 
-#if PY_MAJOR_VERSION < 3
-#define _PyUnicode_FromString(arg) \
-  PyString_FromString(arg)
-#define _PyUnicode_AsString(arg) \
-  PyString_AsString(arg)
-#define _PyUnicode_FromFormat(...) \
-  PyString_FromFormat(__VA_ARGS__)
-#define _PyLong_FromLong(arg) \
-  PyInt_FromLong(arg)
-
-#else
-
 #define _PyUnicode_FromString(arg) \
   PyUnicode_FromString(arg)
 #define _PyUnicode_FromFormat(...) \
   PyUnicode_FromFormat(__VA_ARGS__)
 #define _PyLong_FromLong(arg) \
   PyLong_FromLong(arg)
-#endif
 
-#ifndef Py_TYPE
-#define Py_TYPE(ob) (((PyObject*)(ob))->ob_type)
-#endif
-
-/* Define PyVarObject_HEAD_INIT for python 2.5 */
-#ifndef PyVarObject_HEAD_INIT
-# define PyVarObject_HEAD_INIT(type, size) PyObject_HEAD_INIT(type) size,
-#endif
-
-#if PY_MAJOR_VERSION < 3
-PyMODINIT_FUNC initperf(void);
-#else
 PyMODINIT_FUNC PyInit_perf(void);
-#endif
 
 #define member_def(type, member, ptype, help) \
 	{ #member, ptype, \
@@ -117,7 +91,7 @@ static PyObject *pyrf_mmap_event__repr(struct pyrf_event *pevent)
 		     pevent->event.mmap.pgoff, pevent->event.mmap.filename) < 0) {
 		ret = PyErr_NoMemory();
 	} else {
-		ret = _PyUnicode_FromString(s);
+		ret = PyUnicode_FromString(s);
 		free(s);
 	}
 	return ret;
@@ -148,7 +122,7 @@ static PyMemberDef pyrf_task_event__members[] = {
 
 static PyObject *pyrf_task_event__repr(struct pyrf_event *pevent)
 {
-	return _PyUnicode_FromFormat("{ type: %s, pid: %u, ppid: %u, tid: %u, "
+	return PyUnicode_FromFormat("{ type: %s, pid: %u, ppid: %u, tid: %u, "
 				   "ptid: %u, time: %" PRI_lu64 "}",
 				   pevent->event.header.type == PERF_RECORD_FORK ? "fork" : "exit",
 				   pevent->event.fork.pid,
@@ -181,7 +155,7 @@ static PyMemberDef pyrf_comm_event__members[] = {
 
 static PyObject *pyrf_comm_event__repr(struct pyrf_event *pevent)
 {
-	return _PyUnicode_FromFormat("{ type: comm, pid: %u, tid: %u, comm: %s }",
+	return PyUnicode_FromFormat("{ type: comm, pid: %u, tid: %u, comm: %s }",
 				   pevent->event.comm.pid,
 				   pevent->event.comm.tid,
 				   pevent->event.comm.comm);
@@ -212,7 +186,7 @@ static PyObject *pyrf_throttle_event__repr(struct pyrf_event *pevent)
 {
 	struct perf_record_throttle *te = (struct perf_record_throttle *)(&pevent->event.header + 1);
 
-	return _PyUnicode_FromFormat("{ type: %sthrottle, time: %" PRI_lu64 ", id: %" PRI_lu64
+	return PyUnicode_FromFormat("{ type: %sthrottle, time: %" PRI_lu64 ", id: %" PRI_lu64
 				   ", stream_id: %" PRI_lu64 " }",
 				   pevent->event.header.type == PERF_RECORD_THROTTLE ? "" : "un",
 				   te->time, te->id, te->stream_id);
@@ -247,7 +221,7 @@ static PyObject *pyrf_lost_event__repr(struct pyrf_event *pevent)
 		     pevent->event.lost.id, pevent->event.lost.lost) < 0) {
 		ret = PyErr_NoMemory();
 	} else {
-		ret = _PyUnicode_FromString(s);
+		ret = PyUnicode_FromString(s);
 		free(s);
 	}
 	return ret;
@@ -274,7 +248,7 @@ static PyMemberDef pyrf_read_event__members[] = {
 
 static PyObject *pyrf_read_event__repr(struct pyrf_event *pevent)
 {
-	return _PyUnicode_FromFormat("{ type: read, pid: %u, tid: %u }",
+	return PyUnicode_FromFormat("{ type: read, pid: %u, tid: %u }",
 				   pevent->event.read.pid,
 				   pevent->event.read.tid);
 	/*
@@ -309,7 +283,7 @@ static PyObject *pyrf_sample_event__repr(struct pyrf_event *pevent)
 	if (asprintf(&s, "{ type: sample }") < 0) {
 		ret = PyErr_NoMemory();
 	} else {
-		ret = _PyUnicode_FromString(s);
+		ret = PyUnicode_FromString(s);
 		free(s);
 	}
 	return ret;
@@ -343,7 +317,7 @@ tracepoint_field(struct pyrf_event *pe, struct tep_format_field *field)
 		}
 		if (field->flags & TEP_FIELD_IS_STRING &&
 		    is_printable_array(data + offset, len)) {
-			ret = _PyUnicode_FromString((char *)data + offset);
+			ret = PyUnicode_FromString((char *)data + offset);
 		} else {
 			ret = PyByteArray_FromStringAndSize((const char *) data + offset, len);
 			field->flags &= ~TEP_FIELD_IS_STRING;
@@ -432,7 +406,7 @@ static PyObject *pyrf_context_switch_event__repr(struct pyrf_event *pevent)
 		     !!(pevent->event.header.misc & PERF_RECORD_MISC_SWITCH_OUT)) < 0) {
 		ret = PyErr_NoMemory();
 	} else {
-		ret = _PyUnicode_FromString(s);
+		ret = PyUnicode_FromString(s);
 		free(s);
 	}
 	return ret;
@@ -918,17 +892,8 @@ static PyObject *pyrf_evlist__get_pollfd(struct pyrf_evlist *pevlist,
 
 	for (i = 0; i < evlist->core.pollfd.nr; ++i) {
 		PyObject *file;
-#if PY_MAJOR_VERSION < 3
-		FILE *fp = fdopen(evlist->core.pollfd.entries[i].fd, "r");
-
-		if (fp == NULL)
-			goto free_list;
-
-		file = PyFile_FromFile(fp, "perf", "r", NULL);
-#else
 		file = PyFile_FromFd(evlist->core.pollfd.entries[i].fd, "perf", "r", -1,
 				     NULL, NULL, NULL, 0);
-#endif
 		if (file == NULL)
 			goto free_list;
 
@@ -1234,9 +1199,9 @@ static PyObject *pyrf__tracepoint(struct pyrf_evsel *pevsel,
 
 	tp_format = trace_event__tp_format(sys, name);
 	if (IS_ERR(tp_format))
-		return _PyLong_FromLong(-1);
+		return PyLong_FromLong(-1);
 
-	return _PyLong_FromLong(tp_format->id);
+	return PyLong_FromLong(tp_format->id);
 #endif // HAVE_LIBTRACEEVENT
 }
 
@@ -1250,18 +1215,11 @@ static PyMethodDef perf__methods[] = {
 	{ .ml_name = NULL, }
 };
 
-#if PY_MAJOR_VERSION < 3
-PyMODINIT_FUNC initperf(void)
-#else
 PyMODINIT_FUNC PyInit_perf(void)
-#endif
 {
 	PyObject *obj;
 	int i;
 	PyObject *dict;
-#if PY_MAJOR_VERSION < 3
-	PyObject *module = Py_InitModule("perf", perf__methods);
-#else
 	static struct PyModuleDef moduledef = {
 		PyModuleDef_HEAD_INIT,
 		"perf",			/* m_name */
@@ -1274,7 +1232,6 @@ PyMODINIT_FUNC PyInit_perf(void)
 		NULL,			/* m_free */
 	};
 	PyObject *module = PyModule_Create(&moduledef);
-#endif
 
 	if (module == NULL ||
 	    pyrf_event__setup_types() < 0 ||
@@ -1282,11 +1239,7 @@ PyMODINIT_FUNC PyInit_perf(void)
 	    pyrf_evsel__setup_types() < 0 ||
 	    pyrf_thread_map__setup_types() < 0 ||
 	    pyrf_cpu_map__setup_types() < 0)
-#if PY_MAJOR_VERSION < 3
-		return;
-#else
 		return module;
-#endif
 
 	/* The page_size is placed in util object. */
 	page_size = sysconf(_SC_PAGE_SIZE);
@@ -1335,7 +1288,7 @@ PyMODINIT_FUNC PyInit_perf(void)
 		goto error;
 
 	for (i = 0; perf__constants[i].name != NULL; i++) {
-		obj = _PyLong_FromLong(perf__constants[i].value);
+		obj = PyLong_FromLong(perf__constants[i].value);
 		if (obj == NULL)
 			goto error;
 		PyDict_SetItemString(dict, perf__constants[i].name, obj);
@@ -1345,9 +1298,7 @@ PyMODINIT_FUNC PyInit_perf(void)
 error:
 	if (PyErr_Occurred())
 		PyErr_SetString(PyExc_ImportError, "perf: Init failed!");
-#if PY_MAJOR_VERSION >= 3
 	return module;
-#endif
 }
 
 
diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index 8bdae066e839..19eadce50ca1 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -58,22 +58,6 @@
 #include "mem-events.h"
 #include "util/perf_regs.h"
 
-#if PY_MAJOR_VERSION < 3
-#define _PyUnicode_FromString(arg) \
-  PyString_FromString(arg)
-#define _PyUnicode_FromStringAndSize(arg1, arg2) \
-  PyString_FromStringAndSize((arg1), (arg2))
-#define _PyBytes_FromStringAndSize(arg1, arg2) \
-  PyString_FromStringAndSize((arg1), (arg2))
-#define _PyLong_FromLong(arg) \
-  PyInt_FromLong(arg)
-#define _PyLong_AsLong(arg) \
-  PyInt_AsLong(arg)
-#define _PyCapsule_New(arg1, arg2, arg3) \
-  PyCObject_FromVoidPtr((arg1), (arg2))
-
-PyMODINIT_FUNC initperf_trace_context(void);
-#else
 #define _PyUnicode_FromString(arg) \
   PyUnicode_FromString(arg)
 #define _PyUnicode_FromStringAndSize(arg1, arg2) \
@@ -88,7 +72,6 @@ PyMODINIT_FUNC initperf_trace_context(void);
   PyCapsule_New((arg1), (arg2), (arg3))
 
 PyMODINIT_FUNC PyInit_perf_trace_context(void);
-#endif
 
 #ifdef HAVE_LIBTRACEEVENT
 #define TRACE_EVENT_TYPE_MAX				\
@@ -181,17 +164,7 @@ static int get_argument_count(PyObject *handler)
 {
 	int arg_count = 0;
 
-	/*
-	 * The attribute for the code object is func_code in Python 2,
-	 * whereas it is __code__ in Python 3.0+.
-	 */
-	PyObject *code_obj = PyObject_GetAttrString(handler,
-		"func_code");
-	if (PyErr_Occurred()) {
-		PyErr_Clear();
-		code_obj = PyObject_GetAttrString(handler,
-			"__code__");
-	}
+	PyObject *code_obj = code_obj = PyObject_GetAttrString(handler, "__code__");
 	PyErr_Clear();
 	if (code_obj) {
 		PyObject *arg_count_obj = PyObject_GetAttrString(code_obj,
@@ -1902,12 +1875,6 @@ static void set_table_handlers(struct tables *tables)
 	tables->synth_handler = get_handler("synth_data");
 }
 
-#if PY_MAJOR_VERSION < 3
-static void _free_command_line(const char **command_line, int num)
-{
-	free(command_line);
-}
-#else
 static void _free_command_line(wchar_t **command_line, int num)
 {
 	int i;
@@ -1915,7 +1882,6 @@ static void _free_command_line(wchar_t **command_line, int num)
 		PyMem_RawFree(command_line[i]);
 	free(command_line);
 }
-#endif
 
 
 /*
@@ -1925,30 +1891,12 @@ static int python_start_script(const char *script, int argc, const char **argv,
 			       struct perf_session *session)
 {
 	struct tables *tables = &tables_global;
-#if PY_MAJOR_VERSION < 3
-	const char **command_line;
-#else
 	wchar_t **command_line;
-#endif
-	/*
-	 * Use a non-const name variable to cope with python 2.6's
-	 * PyImport_AppendInittab prototype
-	 */
-	char buf[PATH_MAX], name[19] = "perf_trace_context";
+	char buf[PATH_MAX];
 	int i, err = 0;
 	FILE *fp;
 
 	scripting_context->session = session;
-#if PY_MAJOR_VERSION < 3
-	command_line = malloc((argc + 1) * sizeof(const char *));
-	if (!command_line)
-		return -1;
-
-	command_line[0] = script;
-	for (i = 1; i < argc + 1; i++)
-		command_line[i] = argv[i - 1];
-	PyImport_AppendInittab(name, initperf_trace_context);
-#else
 	command_line = malloc((argc + 1) * sizeof(wchar_t *));
 	if (!command_line)
 		return -1;
@@ -1956,15 +1904,10 @@ static int python_start_script(const char *script, int argc, const char **argv,
 	command_line[0] = Py_DecodeLocale(script, NULL);
 	for (i = 1; i < argc + 1; i++)
 		command_line[i] = Py_DecodeLocale(argv[i - 1], NULL);
-	PyImport_AppendInittab(name, PyInit_perf_trace_context);
-#endif
+	PyImport_AppendInittab("perf_trace_context", PyInit_perf_trace_context);
 	Py_Initialize();
 
-#if PY_MAJOR_VERSION < 3
-	PySys_SetArgv(argc + 1, (char **)command_line);
-#else
 	PySys_SetArgv(argc + 1, command_line);
-#endif
 
 	fp = fopen(script, "r");
 	if (!fp) {
-- 
2.47.0.338.g60cca15819-goog

