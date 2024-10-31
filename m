Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B033841C77
	for <linux-perf-users@vger.kernel.org>; Thu, 31 Oct 2024 01:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730339004; cv=none; b=pevpbDVsgBINtVD263iZgqY/LnrhrUugmlcPOjyHtKk6zqnc4J81EV5puifKc7dZ5K6m5OPRRBxZy7wmWtaH1vIjJvYm0aFV6ikKPbJsFj7QBoM/hPK4TNnIt67xrUT0YxjLtkdeeNRpEImlcgC98as7ac/s6IbDFcYfHq+AXzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730339004; c=relaxed/simple;
	bh=06rUym8mEKwnrNebRhLzrvBcLI6yg+52u2nqnHXOz4k=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=jLkwdw6/UudpUrYQvG6EkYphnM9qU0He61GEAqaUUSbqxGiGrGrKI7piAD99VeDsZ3AybWRT5myKcSLBBf54WvH28hPebDa4i05txEYn+AwtslYF4SpHPpqSKFNB0zHjyy1FqS6Xt2lJA6hEdtpT79Ag1Gu9SIQVU+r2bcWDsdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YhmocM1I; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YhmocM1I"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e30cf48435fso1047875276.0
        for <linux-perf-users@vger.kernel.org>; Wed, 30 Oct 2024 18:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730339001; x=1730943801; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xl5YYT6/j2snqAzcSfRTiY37ktA1YE2VwqMAMMgNcVo=;
        b=YhmocM1IvSp8FhhefMS9WMqo4eZjg1daKzO9db/1eG2sQZiTr9mD8GdXXS2EwmtxbR
         0AhhRwkaldWPibDX50YCIY4zVpab6+Ue2LxpuXq5hKeBxLF4zt/6enc0G1NbyxZ80d45
         zCpIlaTbduotk1i4Wl3IY3Bbe0jtKsdw3ZEdrlao8sblKZyGLA4UCjknUCdnKDS4rt9H
         R1V1zx7LEQGjgMSzyGymYvc5ipfwvJqqSyw9Jqt44jXxKz320vvhxX1yYBkACH9pgFKp
         9XD6O+asqWuBtxVu0cfyWWxRwqBGqRm/59EIlkZ09He/p36OjS7eDIipe9zq8bH70zEJ
         z74w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730339001; x=1730943801;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xl5YYT6/j2snqAzcSfRTiY37ktA1YE2VwqMAMMgNcVo=;
        b=sgJW9MsrzBrlMXg7F7wqZEVnOhoaci4bWE82O/VkfX/DXn6LoQV8BH/po7DlLDLpBE
         yL7AahGSVj5FB7eqvY6sBmlB7U012A/myW0Z0kCLwBs9EWqDOtBDy1r86TAo1pBG0+qY
         Z2MaGFTjaEuZUKApoYw3bOZ5/yPVqfCgcz7TiwSfuby6Lk031pMx5aRbkMKgw0jCblSC
         bFTP4qjqIjfLekCqKws5nwVifguZfiUFfuQhHSpvjtqoQtTXklJ5QZfpcBwCx7gvytfy
         fJbYAwhPNJlVHtRJGDRqDK27l6IuLYB56NL7UtNwyaVQiSZARtRs8TJlWN+DuCeklizt
         0ZXw==
X-Forwarded-Encrypted: i=1; AJvYcCXVy8QiC/n6w0j9/p9BPD1EkATMtB2iUldireJadQ83AdWMp9GnKLZgJgt2XxxnZUAKiIFM2E5EjREi7t4tllWp@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6tjJM2GpVVbrfGGXic1iW7fUNlJl5Ns5tYvjW70RS5w2GqilV
	OvaFELjqEUKkYoE10F/sDpqHEf9AsrgSz/SHHEoBC9BlYSvgIz+8mPocrMYSqncWc+o6UvFrhVL
	Z/xqXFw==
X-Google-Smtp-Source: AGHT+IHxzI6JqY6DFUSa9U4BkLnn0HNVUkF4luAUVdlH1zuSlXQhCe3P1dIsbxWxok9ixWm1zO9ItoBBiKMt
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:ad0f:67e7:f1a6:84c4])
 (user=irogers job=sendgmr) by 2002:a25:9012:0:b0:e2e:44ae:111a with SMTP id
 3f1490d57ef6-e30cf4c9ffamr3762276.8.1730339000801; Wed, 30 Oct 2024 18:43:20
 -0700 (PDT)
Date: Wed, 30 Oct 2024 18:42:32 -0700
In-Reply-To: <20241031014252.753588-1-irogers@google.com>
Message-Id: <20241031014252.753588-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241031014252.753588-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Subject: [PATCH v5 01/21] perf python: Remove python 2 scripting support
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
Content-Type: text/plain; charset="UTF-8"

Python2 was deprecated 4 years ago, remove support and workarounds.

Signed-off-by: Ian Rogers <irogers@google.com>
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
index 31a223eaf8e6..02279ab4967c 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -25,40 +25,14 @@
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
@@ -116,7 +90,7 @@ static PyObject *pyrf_mmap_event__repr(struct pyrf_event *pevent)
 		     pevent->event.mmap.pgoff, pevent->event.mmap.filename) < 0) {
 		ret = PyErr_NoMemory();
 	} else {
-		ret = _PyUnicode_FromString(s);
+		ret = PyUnicode_FromString(s);
 		free(s);
 	}
 	return ret;
@@ -147,7 +121,7 @@ static PyMemberDef pyrf_task_event__members[] = {
 
 static PyObject *pyrf_task_event__repr(struct pyrf_event *pevent)
 {
-	return _PyUnicode_FromFormat("{ type: %s, pid: %u, ppid: %u, tid: %u, "
+	return PyUnicode_FromFormat("{ type: %s, pid: %u, ppid: %u, tid: %u, "
 				   "ptid: %u, time: %" PRI_lu64 "}",
 				   pevent->event.header.type == PERF_RECORD_FORK ? "fork" : "exit",
 				   pevent->event.fork.pid,
@@ -180,7 +154,7 @@ static PyMemberDef pyrf_comm_event__members[] = {
 
 static PyObject *pyrf_comm_event__repr(struct pyrf_event *pevent)
 {
-	return _PyUnicode_FromFormat("{ type: comm, pid: %u, tid: %u, comm: %s }",
+	return PyUnicode_FromFormat("{ type: comm, pid: %u, tid: %u, comm: %s }",
 				   pevent->event.comm.pid,
 				   pevent->event.comm.tid,
 				   pevent->event.comm.comm);
@@ -211,7 +185,7 @@ static PyObject *pyrf_throttle_event__repr(struct pyrf_event *pevent)
 {
 	struct perf_record_throttle *te = (struct perf_record_throttle *)(&pevent->event.header + 1);
 
-	return _PyUnicode_FromFormat("{ type: %sthrottle, time: %" PRI_lu64 ", id: %" PRI_lu64
+	return PyUnicode_FromFormat("{ type: %sthrottle, time: %" PRI_lu64 ", id: %" PRI_lu64
 				   ", stream_id: %" PRI_lu64 " }",
 				   pevent->event.header.type == PERF_RECORD_THROTTLE ? "" : "un",
 				   te->time, te->id, te->stream_id);
@@ -246,7 +220,7 @@ static PyObject *pyrf_lost_event__repr(struct pyrf_event *pevent)
 		     pevent->event.lost.id, pevent->event.lost.lost) < 0) {
 		ret = PyErr_NoMemory();
 	} else {
-		ret = _PyUnicode_FromString(s);
+		ret = PyUnicode_FromString(s);
 		free(s);
 	}
 	return ret;
@@ -273,7 +247,7 @@ static PyMemberDef pyrf_read_event__members[] = {
 
 static PyObject *pyrf_read_event__repr(struct pyrf_event *pevent)
 {
-	return _PyUnicode_FromFormat("{ type: read, pid: %u, tid: %u }",
+	return PyUnicode_FromFormat("{ type: read, pid: %u, tid: %u }",
 				   pevent->event.read.pid,
 				   pevent->event.read.tid);
 	/*
@@ -308,7 +282,7 @@ static PyObject *pyrf_sample_event__repr(struct pyrf_event *pevent)
 	if (asprintf(&s, "{ type: sample }") < 0) {
 		ret = PyErr_NoMemory();
 	} else {
-		ret = _PyUnicode_FromString(s);
+		ret = PyUnicode_FromString(s);
 		free(s);
 	}
 	return ret;
@@ -342,7 +316,7 @@ tracepoint_field(struct pyrf_event *pe, struct tep_format_field *field)
 		}
 		if (field->flags & TEP_FIELD_IS_STRING &&
 		    is_printable_array(data + offset, len)) {
-			ret = _PyUnicode_FromString((char *)data + offset);
+			ret = PyUnicode_FromString((char *)data + offset);
 		} else {
 			ret = PyByteArray_FromStringAndSize((const char *) data + offset, len);
 			field->flags &= ~TEP_FIELD_IS_STRING;
@@ -431,7 +405,7 @@ static PyObject *pyrf_context_switch_event__repr(struct pyrf_event *pevent)
 		     !!(pevent->event.header.misc & PERF_RECORD_MISC_SWITCH_OUT)) < 0) {
 		ret = PyErr_NoMemory();
 	} else {
-		ret = _PyUnicode_FromString(s);
+		ret = PyUnicode_FromString(s);
 		free(s);
 	}
 	return ret;
@@ -917,17 +891,8 @@ static PyObject *pyrf_evlist__get_pollfd(struct pyrf_evlist *pevlist,
 
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
 
@@ -1233,9 +1198,9 @@ static PyObject *pyrf__tracepoint(struct pyrf_evsel *pevsel,
 
 	tp_format = trace_event__tp_format(sys, name);
 	if (IS_ERR(tp_format))
-		return _PyLong_FromLong(-1);
+		return PyLong_FromLong(-1);
 
-	return _PyLong_FromLong(tp_format->id);
+	return PyLong_FromLong(tp_format->id);
 #endif // HAVE_LIBTRACEEVENT
 }
 
@@ -1249,18 +1214,11 @@ static PyMethodDef perf__methods[] = {
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
@@ -1273,7 +1231,6 @@ PyMODINIT_FUNC PyInit_perf(void)
 		NULL,			/* m_free */
 	};
 	PyObject *module = PyModule_Create(&moduledef);
-#endif
 
 	if (module == NULL ||
 	    pyrf_event__setup_types() < 0 ||
@@ -1281,11 +1238,7 @@ PyMODINIT_FUNC PyInit_perf(void)
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
@@ -1334,7 +1287,7 @@ PyMODINIT_FUNC PyInit_perf(void)
 		goto error;
 
 	for (i = 0; perf__constants[i].name != NULL; i++) {
-		obj = _PyLong_FromLong(perf__constants[i].value);
+		obj = PyLong_FromLong(perf__constants[i].value);
 		if (obj == NULL)
 			goto error;
 		PyDict_SetItemString(dict, perf__constants[i].name, obj);
@@ -1344,9 +1297,7 @@ PyMODINIT_FUNC PyInit_perf(void)
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
2.47.0.163.g1226f6d8fa-goog

