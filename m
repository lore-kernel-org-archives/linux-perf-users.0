From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 02/14] perf scripts python: Add Python 3 support to Core.py
Date: Wed, 11 Jul 2018 16:42:53 -0400
Message-ID: <20180711204305.12924-3-acme@kernel.org>
References: <20180711204305.12924-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180711204305.12924-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jeremy Cline <jeremy@jcline.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Herton Krzesinski <herton@redhat.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jeremy Cline <jeremy@jcline.org>

Support both Python 2 and Python 3 in Core.py. This should have no
functional change.

Signed-off-by: Jeremy Cline <jeremy@jcline.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Herton Krzesinski <herton@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/0100016341a72ebe-e572899e-f445-4765-98f0-c314935727f9-000000@email.amazonses.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../python/Perf-Trace-Util/lib/Perf/Trace/Core.py  | 40 +++++++++-------------
 1 file changed, 17 insertions(+), 23 deletions(-)

diff --git a/tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/Core.py b/tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/Core.py
index 38dfb720fb6f..54ace2f6bc36 100644
--- a/tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/Core.py
+++ b/tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/Core.py
@@ -31,10 +31,8 @@ def flag_str(event_name, field_name, value):
     string = ""
 
     if flag_fields[event_name][field_name]:
-	print_delim = 0
-        keys = flag_fields[event_name][field_name]['values'].keys()
-        keys.sort()
-        for idx in keys:
+        print_delim = 0
+        for idx in sorted(flag_fields[event_name][field_name]['values']):
             if not value and not idx:
                 string += flag_fields[event_name][field_name]['values'][idx]
                 break
@@ -51,14 +49,12 @@ def symbol_str(event_name, field_name, value):
     string = ""
 
     if symbolic_fields[event_name][field_name]:
-        keys = symbolic_fields[event_name][field_name]['values'].keys()
-        keys.sort()
-        for idx in keys:
+        for idx in sorted(symbolic_fields[event_name][field_name]['values']):
             if not value and not idx:
-		string = symbolic_fields[event_name][field_name]['values'][idx]
+                string = symbolic_fields[event_name][field_name]['values'][idx]
                 break
-	    if (value == idx):
-		string = symbolic_fields[event_name][field_name]['values'][idx]
+            if (value == idx):
+                string = symbolic_fields[event_name][field_name]['values'][idx]
                 break
 
     return string
@@ -74,19 +70,17 @@ def trace_flag_str(value):
     string = ""
     print_delim = 0
 
-    keys = trace_flags.keys()
-
-    for idx in keys:
-	if not value and not idx:
-	    string += "NONE"
-	    break
-
-	if idx and (value & idx) == idx:
-	    if print_delim:
-		string += " | ";
-	    string += trace_flags[idx]
-	    print_delim = 1
-	    value &= ~idx
+    for idx in trace_flags:
+        if not value and not idx:
+            string += "NONE"
+            break
+
+        if idx and (value & idx) == idx:
+            if print_delim:
+                string += " | ";
+            string += trace_flags[idx]
+            print_delim = 1
+            value &= ~idx
 
     return string
 
-- 
2.14.4
