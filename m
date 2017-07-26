From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 32/40] perf script python: Refactor creation of perf sample dict
Date: Wed, 26 Jul 2017 11:17:22 -0300
Message-ID: <20170726141730.30750-33-acme@kernel.org>
References: <20170726141730.30750-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170726141730.30750-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arun Kalyanasundaram <arunkaly@google.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Daniel Borkmann <daniel@iogearbox.net>, David Carrillo-Cisneros <davidcc@google.com>, "David S . Miller" <davem@davemloft.net>, Peter Zijlstra <peterz@infradead.org>, Seongjae Park <sj38.park@gmail.com>, Stephane Eranian <eranian@google.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arun Kalyanasundaram <arunkaly@google.com>

Move the creation of the dict containing perf_sample entries into a
helper function to enable its reuse in other sample processing routines.

Signed-off-by: Arun Kalyanasundaram <arunkaly@google.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: David Carrillo-Cisneros <davidcc@google.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Seongjae Park <sj38.park@gmail.com>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lkml.kernel.org/r/20170721220422.63962-3-arunkaly@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../util/scripting-engines/trace-event-python.c    | 94 ++++++++++++----------
 1 file changed, 53 insertions(+), 41 deletions(-)

diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index 8a8f4829d3e2..69d1b6db96f6 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -391,6 +391,57 @@ static PyObject *python_process_callchain(struct perf_sample *sample,
 	return pylist;
 }
 
+static PyObject *get_perf_sample_dict(struct perf_sample *sample,
+					 struct perf_evsel *evsel,
+					 struct addr_location *al,
+					 PyObject *callchain)
+{
+	PyObject *dict, *dict_sample;
+
+	dict = PyDict_New();
+	if (!dict)
+		Py_FatalError("couldn't create Python dictionary");
+
+	dict_sample = PyDict_New();
+	if (!dict_sample)
+		Py_FatalError("couldn't create Python dictionary");
+
+	pydict_set_item_string_decref(dict, "ev_name", PyString_FromString(perf_evsel__name(evsel)));
+	pydict_set_item_string_decref(dict, "attr", PyString_FromStringAndSize(
+			(const char *)&evsel->attr, sizeof(evsel->attr)));
+
+	pydict_set_item_string_decref(dict_sample, "pid",
+			PyInt_FromLong(sample->pid));
+	pydict_set_item_string_decref(dict_sample, "tid",
+			PyInt_FromLong(sample->tid));
+	pydict_set_item_string_decref(dict_sample, "cpu",
+			PyInt_FromLong(sample->cpu));
+	pydict_set_item_string_decref(dict_sample, "ip",
+			PyLong_FromUnsignedLongLong(sample->ip));
+	pydict_set_item_string_decref(dict_sample, "time",
+			PyLong_FromUnsignedLongLong(sample->time));
+	pydict_set_item_string_decref(dict_sample, "period",
+			PyLong_FromUnsignedLongLong(sample->period));
+	pydict_set_item_string_decref(dict, "sample", dict_sample);
+
+	pydict_set_item_string_decref(dict, "raw_buf", PyString_FromStringAndSize(
+			(const char *)sample->raw_data, sample->raw_size));
+	pydict_set_item_string_decref(dict, "comm",
+			PyString_FromString(thread__comm_str(al->thread)));
+	if (al->map) {
+		pydict_set_item_string_decref(dict, "dso",
+			PyString_FromString(al->map->dso->name));
+	}
+	if (al->sym) {
+		pydict_set_item_string_decref(dict, "symbol",
+			PyString_FromString(al->sym->name));
+	}
+
+	pydict_set_item_string_decref(dict, "callchain", callchain);
+
+	return dict;
+}
+
 static void python_process_tracepoint(struct perf_sample *sample,
 				      struct perf_evsel *evsel,
 				      struct addr_location *al)
@@ -801,7 +852,7 @@ static void python_process_general_event(struct perf_sample *sample,
 					 struct perf_evsel *evsel,
 					 struct addr_location *al)
 {
-	PyObject *handler, *t, *dict, *callchain, *dict_sample;
+	PyObject *handler, *t, *dict, *callchain;
 	static char handler_name[64];
 	unsigned n = 0;
 
@@ -819,48 +870,9 @@ static void python_process_general_event(struct perf_sample *sample,
 	if (!t)
 		Py_FatalError("couldn't create Python tuple");
 
-	dict = PyDict_New();
-	if (!dict)
-		Py_FatalError("couldn't create Python dictionary");
-
-	dict_sample = PyDict_New();
-	if (!dict_sample)
-		Py_FatalError("couldn't create Python dictionary");
-
-	pydict_set_item_string_decref(dict, "ev_name", PyString_FromString(perf_evsel__name(evsel)));
-	pydict_set_item_string_decref(dict, "attr", PyString_FromStringAndSize(
-			(const char *)&evsel->attr, sizeof(evsel->attr)));
-
-	pydict_set_item_string_decref(dict_sample, "pid",
-			PyInt_FromLong(sample->pid));
-	pydict_set_item_string_decref(dict_sample, "tid",
-			PyInt_FromLong(sample->tid));
-	pydict_set_item_string_decref(dict_sample, "cpu",
-			PyInt_FromLong(sample->cpu));
-	pydict_set_item_string_decref(dict_sample, "ip",
-			PyLong_FromUnsignedLongLong(sample->ip));
-	pydict_set_item_string_decref(dict_sample, "time",
-			PyLong_FromUnsignedLongLong(sample->time));
-	pydict_set_item_string_decref(dict_sample, "period",
-			PyLong_FromUnsignedLongLong(sample->period));
-	pydict_set_item_string_decref(dict, "sample", dict_sample);
-
-	pydict_set_item_string_decref(dict, "raw_buf", PyString_FromStringAndSize(
-			(const char *)sample->raw_data, sample->raw_size));
-	pydict_set_item_string_decref(dict, "comm",
-			PyString_FromString(thread__comm_str(al->thread)));
-	if (al->map) {
-		pydict_set_item_string_decref(dict, "dso",
-			PyString_FromString(al->map->dso->name));
-	}
-	if (al->sym) {
-		pydict_set_item_string_decref(dict, "symbol",
-			PyString_FromString(al->sym->name));
-	}
-
 	/* ip unwinding */
 	callchain = python_process_callchain(sample, evsel, al);
-	pydict_set_item_string_decref(dict, "callchain", callchain);
+	dict = get_perf_sample_dict(sample, evsel, al, callchain);
 
 	PyTuple_SetItem(t, n++, dict);
 	if (_PyTuple_Resize(&t, n) == -1)
-- 
2.9.4
