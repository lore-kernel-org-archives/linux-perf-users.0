From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 33/40] perf script python: Add sample_read to dict
Date: Wed, 26 Jul 2017 11:17:23 -0300
Message-ID: <20170726141730.30750-34-acme@kernel.org>
References: <20170726141730.30750-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170726141730.30750-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arun Kalyanasundaram <arunkaly@google.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Daniel Borkmann <daniel@iogearbox.net>, David Carrillo-Cisneros <davidcc@google.com>, "David S . Miller" <davem@davemloft.net>, Peter Zijlstra <peterz@infradead.org>, Seongjae Park <sj38.park@gmail.com>, Stephane Eranian <eranian@google.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arun Kalyanasundaram <arunkaly@google.com>

Provide time_enabled, time_running and counter value in the perf_sample
dict.

Signed-off-by: Arun Kalyanasundaram <arunkaly@google.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: David Carrillo-Cisneros <davidcc@google.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Seongjae Park <sj38.park@gmail.com>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lkml.kernel.org/r/20170721220422.63962-4-arunkaly@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../util/scripting-engines/trace-event-python.c    | 51 ++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index 69d1b6db96f6..55a45784c910 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -391,6 +391,56 @@ static PyObject *python_process_callchain(struct perf_sample *sample,
 	return pylist;
 }
 
+static PyObject *get_sample_value_as_tuple(struct sample_read_value *value)
+{
+	PyObject *t;
+
+	t = PyTuple_New(2);
+	if (!t)
+		Py_FatalError("couldn't create Python tuple");
+	PyTuple_SetItem(t, 0, PyLong_FromUnsignedLongLong(value->id));
+	PyTuple_SetItem(t, 1, PyLong_FromUnsignedLongLong(value->value));
+	return t;
+}
+
+static void set_sample_read_in_dict(PyObject *dict_sample,
+					 struct perf_sample *sample,
+					 struct perf_evsel *evsel)
+{
+	u64 read_format = evsel->attr.read_format;
+	PyObject *values;
+	unsigned int i;
+
+	if (read_format & PERF_FORMAT_TOTAL_TIME_ENABLED) {
+		pydict_set_item_string_decref(dict_sample, "time_enabled",
+			PyLong_FromUnsignedLongLong(sample->read.time_enabled));
+	}
+
+	if (read_format & PERF_FORMAT_TOTAL_TIME_RUNNING) {
+		pydict_set_item_string_decref(dict_sample, "time_running",
+			PyLong_FromUnsignedLongLong(sample->read.time_running));
+	}
+
+	if (read_format & PERF_FORMAT_GROUP)
+		values = PyList_New(sample->read.group.nr);
+	else
+		values = PyList_New(1);
+
+	if (!values)
+		Py_FatalError("couldn't create Python list");
+
+	if (read_format & PERF_FORMAT_GROUP) {
+		for (i = 0; i < sample->read.group.nr; i++) {
+			PyObject *t = get_sample_value_as_tuple(&sample->read.group.values[i]);
+			PyList_SET_ITEM(values, i, t);
+		}
+	} else {
+		PyObject *t = get_sample_value_as_tuple(&sample->read.one);
+		PyList_SET_ITEM(values, 0, t);
+	}
+	pydict_set_item_string_decref(dict_sample, "values", values);
+}
+
 static PyObject *get_perf_sample_dict(struct perf_sample *sample,
 					 struct perf_evsel *evsel,
 					 struct addr_location *al,
@@ -422,6 +472,7 @@ static PyObject *get_perf_sample_dict(struct perf_sample *sample,
 			PyLong_FromUnsignedLongLong(sample->time));
 	pydict_set_item_string_decref(dict_sample, "period",
 			PyLong_FromUnsignedLongLong(sample->period));
+	set_sample_read_in_dict(dict_sample, sample, evsel);
 	pydict_set_item_string_decref(dict, "sample", dict_sample);
 
 	pydict_set_item_string_decref(dict, "raw_buf", PyString_FromStringAndSize(
-- 
2.9.4
