Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39D413C9A9
	for <linux-perf-users@vger.kernel.org>; Sat,  9 Nov 2024 06:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731133106; cv=none; b=JGrk+6b2ELanVwLTWz9PdgMvDi7HUH2eUU4F2IHgnaJLKcNENd6HJ4r7mhBQexcLxCe9459xr9ZqjCypaLMBOV4nfI6mS1ZQG81qB8Q/MXquD/9GjMgqoarAtrzKVgsbwbwER+Mztu37ZugVFEc9oKvT6v8HRH3HdICdweJe7YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731133106; c=relaxed/simple;
	bh=vC6VDGUd7M5nDdVYGfpAA4B9K/qTvKH80O1wB+ap9vo=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=QMIKGHZkuHQ/zmyNj1MstnNgCIipY7ExFKHSBHc7AY3q/gL47V8G3ujf0M5KCkHAmIHLL4O0vyiTYuNkhwm7KoYENBxVhNfLzyVTFh9V/AIkQmp3ROqnyk8wsqdWe1v8IcuQYV7HZ6djmDYUoR6SHYkoaeuKCi3cTejZDvh1FIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qSddyWkY; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qSddyWkY"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e9d6636498so60558187b3.2
        for <linux-perf-users@vger.kernel.org>; Fri, 08 Nov 2024 22:18:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731133104; x=1731737904; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rMx8WS7Or6vnwP2Wj4AZt+dV2nEuWPARZ88hJH/Dy3s=;
        b=qSddyWkYcdqPY7IIq7oLe78gzk+sFY3r/vOEKdj9HB1K0MfbBzT0FHwBad2h3IbGAJ
         J74pOGyguVjUdhhCPdt8X7gC0uycJRo8wwWlskEM0gvwgK+94hRMCFq/IrtEpQsEAH5h
         E5dmhH5v+DKpYCu9oKXZUXk0pn3N+QPUIxeOS8LPe4sLPlaWBPh1ocROkpPwF1M7IS5i
         JM2wNbWAlflqESnBAmyP3hbat4EWmDc6ce4Fp/F8RcSV1Wz10U8sTUTZut2gDffL3hgx
         cU7rZvYnmPI5NdWJbeQD8/pYUfDzJxvJpVBYOgQfv8jh8iogRlz5OP1CfRss5Qthg+2V
         prtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731133104; x=1731737904;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rMx8WS7Or6vnwP2Wj4AZt+dV2nEuWPARZ88hJH/Dy3s=;
        b=tUSCC8mPVCs2QhdemE/xQjzeLynCn4fjgpRecyNwn5qZJV1t2uDckkUaH3VE/fIMMG
         ez6/5lU5wR9PB0F84yCMtrVxH/+dZMVfJB4aTZ27+FQII2B115tSdgbUQ3ss+823Uf2w
         WwYu8eY0BX+flZYATXNxxRJWr3IIUEEtms94G5Ie+1/DCFvJ11JvgtO+PUtYqjLSeNpA
         +f1FMSXX/tK1GuwffLimORpaBjDRUNJjAxHBHTlBmLReHKU14sBLg9vnmCsat+2grsxv
         9mSBMX2qNDD/DpRiLOD2N9GPErx23jxkFviIRKbI0AqqLIqeN5n8CZpQxB/D8+uo2hOd
         ju1g==
X-Forwarded-Encrypted: i=1; AJvYcCWv85Dn/AxfjWvlSYcW0uEfy/dYs1KYMIjlb2MPR2Da71THXk5P55upLttbMbZ5JxhETyWl7ABt2PWgyH/ugSQy@vger.kernel.org
X-Gm-Message-State: AOJu0YwEXJCctc+KbVlVKkUuwqitCMZV2eBjRBBWmAsOqCkgslDnJllz
	QREJnFSQ0guuetGD+cbh45miPALSuwU5SLqi74qVVGkRbUY18OwC1KPdJnPM8KM+EXFZJHuGOMH
	D0Xkv5A==
X-Google-Smtp-Source: AGHT+IEjNBHFWLiQ81KvGKqFcr70m8pZFWDCNN4WKYA/AhNrwEI9W/Zw1LoiQw1RnfmPL53/rxWDaFJZlLAo
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:acc2:d48f:a998:5915])
 (user=irogers job=sendgmr) by 2002:a81:a789:0:b0:6ea:1f5b:1f5e with SMTP id
 00721157ae682-6eadde3c8d3mr59237b3.4.1731133103476; Fri, 08 Nov 2024 22:18:23
 -0800 (PST)
Date: Fri,  8 Nov 2024 22:17:48 -0800
In-Reply-To: <20241109061809.811922-1-irogers@google.com>
Message-Id: <20241109061809.811922-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241109061809.811922-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Subject: [PATCH v6 01/22] perf python: Remove python 2 scripting support
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
index ee3d43a7ba45..6fc283ac5498 100644
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
index d7183134b669..f1d461d47d73 100644
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
@@ -1899,12 +1872,6 @@ static void set_table_handlers(struct tables *tables)
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
@@ -1912,7 +1879,6 @@ static void _free_command_line(wchar_t **command_line, int num)
 		PyMem_RawFree(command_line[i]);
 	free(command_line);
 }
-#endif
 
 
 /*
@@ -1922,30 +1888,12 @@ static int python_start_script(const char *script, int argc, const char **argv,
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
@@ -1953,15 +1901,10 @@ static int python_start_script(const char *script, int argc, const char **argv,
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
2.47.0.277.g8800431eea-goog

