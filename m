From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 09/22] perf script: Use fallbacks for branch stacks
Date: Fri, 30 Nov 2018 15:26:39 -0300
Message-ID: <20181130182652.23620-10-acme@kernel.org>
References: <20181130182652.23620-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181130182652.23620-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Andi Kleen <ak@linux.intel.com>, "David S . Miller" <davem@davemloft.net>, Jiri Olsa <jolsa@redhat.com>, Leo Yan <leo.yan@linaro.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, stable@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Branch stacks do not necessarily have the same cpumode as the 'ip'. Use
the fallback functions in those cases.

This patch depends on patch "perf tools: Add fallback functions for cases
where cpumode is insufficient".

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: stable@vger.kernel.org
Link: http://lkml.kernel.org/r/20181106210712.12098-4-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-script.c                      | 12 ++++++------
 .../util/scripting-engines/trace-event-python.c  | 16 ++++++++--------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 04913136bac9..3ea98fe72f7f 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -724,8 +724,8 @@ static int perf_sample__fprintf_brstack(struct perf_sample *sample,
 		if (PRINT_FIELD(DSO)) {
 			memset(&alf, 0, sizeof(alf));
 			memset(&alt, 0, sizeof(alt));
-			thread__find_map(thread, sample->cpumode, from, &alf);
-			thread__find_map(thread, sample->cpumode, to, &alt);
+			thread__find_map_fb(thread, sample->cpumode, from, &alf);
+			thread__find_map_fb(thread, sample->cpumode, to, &alt);
 		}
 
 		printed += fprintf(fp, " 0x%"PRIx64, from);
@@ -771,8 +771,8 @@ static int perf_sample__fprintf_brstacksym(struct perf_sample *sample,
 		from = br->entries[i].from;
 		to   = br->entries[i].to;
 
-		thread__find_symbol(thread, sample->cpumode, from, &alf);
-		thread__find_symbol(thread, sample->cpumode, to, &alt);
+		thread__find_symbol_fb(thread, sample->cpumode, from, &alf);
+		thread__find_symbol_fb(thread, sample->cpumode, to, &alt);
 
 		printed += symbol__fprintf_symname_offs(alf.sym, &alf, fp);
 		if (PRINT_FIELD(DSO)) {
@@ -816,11 +816,11 @@ static int perf_sample__fprintf_brstackoff(struct perf_sample *sample,
 		from = br->entries[i].from;
 		to   = br->entries[i].to;
 
-		if (thread__find_map(thread, sample->cpumode, from, &alf) &&
+		if (thread__find_map_fb(thread, sample->cpumode, from, &alf) &&
 		    !alf.map->dso->adjust_symbols)
 			from = map__map_ip(alf.map, from);
 
-		if (thread__find_map(thread, sample->cpumode, to, &alt) &&
+		if (thread__find_map_fb(thread, sample->cpumode, to, &alt) &&
 		    !alt.map->dso->adjust_symbols)
 			to = map__map_ip(alt.map, to);
 
diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index 69aa93d4ee99..0c4b050f6fc2 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -494,14 +494,14 @@ static PyObject *python_process_brstack(struct perf_sample *sample,
 		pydict_set_item_string_decref(pyelem, "cycles",
 		    PyLong_FromUnsignedLongLong(br->entries[i].flags.cycles));
 
-		thread__find_map(thread, sample->cpumode,
-				 br->entries[i].from, &al);
+		thread__find_map_fb(thread, sample->cpumode,
+				    br->entries[i].from, &al);
 		dsoname = get_dsoname(al.map);
 		pydict_set_item_string_decref(pyelem, "from_dsoname",
 					      _PyUnicode_FromString(dsoname));
 
-		thread__find_map(thread, sample->cpumode,
-				 br->entries[i].to, &al);
+		thread__find_map_fb(thread, sample->cpumode,
+				    br->entries[i].to, &al);
 		dsoname = get_dsoname(al.map);
 		pydict_set_item_string_decref(pyelem, "to_dsoname",
 					      _PyUnicode_FromString(dsoname));
@@ -576,14 +576,14 @@ static PyObject *python_process_brstacksym(struct perf_sample *sample,
 		if (!pyelem)
 			Py_FatalError("couldn't create Python dictionary");
 
-		thread__find_symbol(thread, sample->cpumode,
-				    br->entries[i].from, &al);
+		thread__find_symbol_fb(thread, sample->cpumode,
+				       br->entries[i].from, &al);
 		get_symoff(al.sym, &al, true, bf, sizeof(bf));
 		pydict_set_item_string_decref(pyelem, "from",
 					      _PyUnicode_FromString(bf));
 
-		thread__find_symbol(thread, sample->cpumode,
-				    br->entries[i].to, &al);
+		thread__find_symbol_fb(thread, sample->cpumode,
+				       br->entries[i].to, &al);
 		get_symoff(al.sym, &al, true, bf, sizeof(bf));
 		pydict_set_item_string_decref(pyelem, "to",
 					      _PyUnicode_FromString(bf));
-- 
2.19.1
