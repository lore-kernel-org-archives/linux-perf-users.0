From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 31/40] perf script python: Allocate memory only if handler exists
Date: Wed, 26 Jul 2017 11:17:21 -0300
Message-ID: <20170726141730.30750-32-acme@kernel.org>
References: <20170726141730.30750-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170726141730.30750-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arun Kalyanasundaram <arunkaly@google.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Daniel Borkmann <daniel@iogearbox.net>, David Carrillo-Cisneros <davidcc@google.com>, "David S . Miller" <davem@davemloft.net>, Peter Zijlstra <peterz@infradead.org>, Seongjae Park <sj38.park@gmail.com>, Stephane Eranian <eranian@google.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arun Kalyanasundaram <arunkaly@google.com>

Avoid allocating memory if hook handler is not available. This saves
unused memory allocation and simplifies error path.

Let handler in python_process_tracepoint point to either tracepoint
specific or trace_unhandled hook. Use dict to check if handler points to
trace_unhandled.

Remove the exit label in python_process_general_event and return when no
handler is available.

Signed-off-by: Arun Kalyanasundaram <arunkaly@google.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: David Carrillo-Cisneros <davidcc@google.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Seongjae Park <sj38.park@gmail.com>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lkml.kernel.org/r/20170721220422.63962-2-arunkaly@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../util/scripting-engines/trace-event-python.c    | 38 +++++++++++++---------
 1 file changed, 22 insertions(+), 16 deletions(-)

diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index 57b7a00e6f16..8a8f4829d3e2 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -407,10 +407,7 @@ static void python_process_tracepoint(struct perf_sample *sample,
 	void *data = sample->raw_data;
 	unsigned long long nsecs = sample->time;
 	const char *comm = thread__comm_str(al->thread);
-
-	t = PyTuple_New(MAX_FIELDS);
-	if (!t)
-		Py_FatalError("couldn't create Python tuple");
+	const char *default_handler_name = "trace_unhandled";
 
 	if (!event) {
 		snprintf(handler_name, sizeof(handler_name),
@@ -427,10 +424,19 @@ static void python_process_tracepoint(struct perf_sample *sample,
 
 	handler = get_handler(handler_name);
 	if (!handler) {
+		handler = get_handler(default_handler_name);
+		if (!handler)
+			return;
 		dict = PyDict_New();
 		if (!dict)
 			Py_FatalError("couldn't create Python dict");
 	}
+
+	t = PyTuple_New(MAX_FIELDS);
+	if (!t)
+		Py_FatalError("couldn't create Python tuple");
+
+
 	s = nsecs / NSEC_PER_SEC;
 	ns = nsecs - s * NSEC_PER_SEC;
 
@@ -445,7 +451,7 @@ static void python_process_tracepoint(struct perf_sample *sample,
 	/* ip unwinding */
 	callchain = python_process_callchain(sample, evsel, al);
 
-	if (handler) {
+	if (!dict) {
 		PyTuple_SetItem(t, n++, PyInt_FromLong(cpu));
 		PyTuple_SetItem(t, n++, PyInt_FromLong(s));
 		PyTuple_SetItem(t, n++, PyInt_FromLong(ns));
@@ -484,23 +490,23 @@ static void python_process_tracepoint(struct perf_sample *sample,
 		} else { /* FIELD_IS_NUMERIC */
 			obj = get_field_numeric_entry(event, field, data);
 		}
-		if (handler)
+		if (!dict)
 			PyTuple_SetItem(t, n++, obj);
 		else
 			pydict_set_item_string_decref(dict, field->name, obj);
 
 	}
 
-	if (!handler)
+	if (dict)
 		PyTuple_SetItem(t, n++, dict);
 
 	if (_PyTuple_Resize(&t, n) == -1)
 		Py_FatalError("error resizing Python tuple");
 
-	if (handler) {
+	if (!dict) {
 		call_object(handler, t, handler_name);
 	} else {
-		try_call_object("trace_unhandled", t);
+		call_object(handler, t, default_handler_name);
 		Py_DECREF(dict);
 	}
 
@@ -799,6 +805,12 @@ static void python_process_general_event(struct perf_sample *sample,
 	static char handler_name[64];
 	unsigned n = 0;
 
+	snprintf(handler_name, sizeof(handler_name), "%s", "process_event");
+
+	handler = get_handler(handler_name);
+	if (!handler)
+		return;
+
 	/*
 	 * Use the MAX_FIELDS to make the function expandable, though
 	 * currently there is only one item for the tuple.
@@ -815,12 +827,6 @@ static void python_process_general_event(struct perf_sample *sample,
 	if (!dict_sample)
 		Py_FatalError("couldn't create Python dictionary");
 
-	snprintf(handler_name, sizeof(handler_name), "%s", "process_event");
-
-	handler = get_handler(handler_name);
-	if (!handler)
-		goto exit;
-
 	pydict_set_item_string_decref(dict, "ev_name", PyString_FromString(perf_evsel__name(evsel)));
 	pydict_set_item_string_decref(dict, "attr", PyString_FromStringAndSize(
 			(const char *)&evsel->attr, sizeof(evsel->attr)));
@@ -861,7 +867,7 @@ static void python_process_general_event(struct perf_sample *sample,
 		Py_FatalError("error resizing Python tuple");
 
 	call_object(handler, t, handler_name);
-exit:
+
 	Py_DECREF(dict);
 	Py_DECREF(t);
 }
-- 
2.9.4
