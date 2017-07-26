From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 34/40] perf script python: Add perf_sample dict to tracepoint handlers
Date: Wed, 26 Jul 2017 11:17:24 -0300
Message-ID: <20170726141730.30750-35-acme@kernel.org>
References: <20170726141730.30750-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170726141730.30750-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arun Kalyanasundaram <arunkaly@google.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Daniel Borkmann <daniel@iogearbox.net>, David Carrillo-Cisneros <davidcc@google.com>, "David S . Miller" <davem@davemloft.net>, Peter Zijlstra <peterz@infradead.org>, Seongjae Park <sj38.park@gmail.com>, Stephane Eranian <eranian@google.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arun Kalyanasundaram <arunkaly@google.com>

The process_event python hook receives a dict with all perf_sample
entries, but the tracepoint specific and trace_unhandled hooks predate
the introduction of this dict, and do not receive it.

Add the aforementioned dict as an additional argument to the affected
handlers. To keep backwards compatibility (and avoid unnecessary work),
do not pass the dict if the number of arguments signals that handler
version predates this change.

Signed-off-by: Arun Kalyanasundaram <arunkaly@google.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: David Carrillo-Cisneros <davidcc@google.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Seongjae Park <sj38.park@gmail.com>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lkml.kernel.org/r/20170721220422.63962-5-arunkaly@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../util/scripting-engines/trace-event-python.c    | 41 +++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index 55a45784c910..938b39f6ad31 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -116,6 +116,34 @@ static PyObject *get_handler(const char *handler_name)
 	return handler;
 }
 
+static int get_argument_count(PyObject *handler)
+{
+	int arg_count = 0;
+
+	/*
+	 * The attribute for the code object is func_code in Python 2,
+	 * whereas it is __code__ in Python 3.0+.
+	 */
+	PyObject *code_obj = PyObject_GetAttrString(handler,
+		"func_code");
+	if (PyErr_Occurred()) {
+		PyErr_Clear();
+		code_obj = PyObject_GetAttrString(handler,
+			"__code__");
+	}
+	PyErr_Clear();
+	if (code_obj) {
+		PyObject *arg_count_obj = PyObject_GetAttrString(code_obj,
+			"co_argcount");
+		if (arg_count_obj) {
+			arg_count = (int) PyInt_AsLong(arg_count_obj);
+			Py_DECREF(arg_count_obj);
+		}
+		Py_DECREF(code_obj);
+	}
+	return arg_count;
+}
+
 static void call_object(PyObject *handler, PyObject *args, const char *die_msg)
 {
 	PyObject *retval;
@@ -499,7 +527,7 @@ static void python_process_tracepoint(struct perf_sample *sample,
 {
 	struct event_format *event = evsel->tp_format;
 	PyObject *handler, *context, *t, *obj = NULL, *callchain;
-	PyObject *dict = NULL;
+	PyObject *dict = NULL, *all_entries_dict = NULL;
 	static char handler_name[256];
 	struct format_field *field;
 	unsigned long s, ns;
@@ -552,6 +580,8 @@ static void python_process_tracepoint(struct perf_sample *sample,
 
 	/* ip unwinding */
 	callchain = python_process_callchain(sample, evsel, al);
+	/* Need an additional reference for the perf_sample dict */
+	Py_INCREF(callchain);
 
 	if (!dict) {
 		PyTuple_SetItem(t, n++, PyInt_FromLong(cpu));
@@ -602,6 +632,14 @@ static void python_process_tracepoint(struct perf_sample *sample,
 	if (dict)
 		PyTuple_SetItem(t, n++, dict);
 
+	if (get_argument_count(handler) == (int) n + 1) {
+		all_entries_dict = get_perf_sample_dict(sample, evsel, al,
+			callchain);
+		PyTuple_SetItem(t, n++,	all_entries_dict);
+	} else {
+		Py_DECREF(callchain);
+	}
+
 	if (_PyTuple_Resize(&t, n) == -1)
 		Py_FatalError("error resizing Python tuple");
 
@@ -612,6 +650,7 @@ static void python_process_tracepoint(struct perf_sample *sample,
 		Py_DECREF(dict);
 	}
 
+	Py_XDECREF(all_entries_dict);
 	Py_DECREF(t);
 }
 
-- 
2.9.4
