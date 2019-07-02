From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 09/43] perf db-export: Export synth events
Date: Mon,  1 Jul 2019 23:25:42 -0300
Message-ID: <20190702022616.1259-10-acme@kernel.org>
References: <20190702022616.1259-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190702022616.1259-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@redhat.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Synthesized events are samples but with architecture-specific data
stored in sample->raw_data. They are identified by attribute type
PERF_TYPE_SYNTH.  Add a function to export them.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190622093248.581-6-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../scripting-engines/trace-event-python.c    | 46 ++++++++++++++++++-
 1 file changed, 44 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index 6acb379b53ec..112bed65232f 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -112,6 +112,7 @@ struct tables {
 	PyObject		*sample_handler;
 	PyObject		*call_path_handler;
 	PyObject		*call_return_handler;
+	PyObject		*synth_handler;
 	bool			db_export_mode;
 };
 
@@ -947,6 +948,12 @@ static int tuple_set_string(PyObject *t, unsigned int pos, const char *s)
 	return PyTuple_SetItem(t, pos, _PyUnicode_FromString(s));
 }
 
+static int tuple_set_bytes(PyObject *t, unsigned int pos, void *bytes,
+			   unsigned int sz)
+{
+	return PyTuple_SetItem(t, pos, _PyBytes_FromStringAndSize(bytes, sz));
+}
+
 static int python_export_evsel(struct db_export *dbe, struct perf_evsel *evsel)
 {
 	struct tables *tables = container_of(dbe, struct tables, dbe);
@@ -1105,8 +1112,8 @@ static int python_export_branch_type(struct db_export *dbe, u32 branch_type,
 	return 0;
 }
 
-static int python_export_sample(struct db_export *dbe,
-				struct export_sample *es)
+static void python_export_sample_table(struct db_export *dbe,
+				       struct export_sample *es)
 {
 	struct tables *tables = container_of(dbe, struct tables, dbe);
 	PyObject *t;
@@ -1141,6 +1148,33 @@ static int python_export_sample(struct db_export *dbe,
 	call_object(tables->sample_handler, t, "sample_table");
 
 	Py_DECREF(t);
+}
+
+static void python_export_synth(struct db_export *dbe, struct export_sample *es)
+{
+	struct tables *tables = container_of(dbe, struct tables, dbe);
+	PyObject *t;
+
+	t = tuple_new(3);
+
+	tuple_set_u64(t, 0, es->db_id);
+	tuple_set_u64(t, 1, es->evsel->attr.config);
+	tuple_set_bytes(t, 2, es->sample->raw_data, es->sample->raw_size);
+
+	call_object(tables->synth_handler, t, "synth_data");
+
+	Py_DECREF(t);
+}
+
+static int python_export_sample(struct db_export *dbe,
+				struct export_sample *es)
+{
+	struct tables *tables = container_of(dbe, struct tables, dbe);
+
+	python_export_sample_table(dbe, es);
+
+	if (es->evsel->attr.type == PERF_TYPE_SYNTH && tables->synth_handler)
+		python_export_synth(dbe, es);
 
 	return 0;
 }
@@ -1477,6 +1511,14 @@ static void set_table_handlers(struct tables *tables)
 	SET_TABLE_HANDLER(sample);
 	SET_TABLE_HANDLER(call_path);
 	SET_TABLE_HANDLER(call_return);
+
+	/*
+	 * Synthesized events are samples but with architecture-specific data
+	 * stored in sample->raw_data. They are exported via
+	 * python_export_sample() and consequently do not need a separate export
+	 * callback.
+	 */
+	tables->synth_handler = get_handler("synth_data");
 }
 
 #if PY_MAJOR_VERSION < 3
-- 
2.20.1
