From: Jeremy Cline <jeremy@jcline.org>
Subject: [PATCH 2/8] perf scripts python: Add Python 3 support to Core.py
Date: Tue, 8 May 2018 21:27:45 +0000
Message-ID: <0100016341a72ebe-e572899e-f445-4765-98f0-c314935727f9-000000@email.amazonses.com>
References: <cover.1525811971.git.jeremy@jcline.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1525811971.git.jeremy@jcline.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, "Herton R . Krzesinski" <herton@redhat.com>, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, Jeremy Cline <jeremy@jcline.org>
List-Id: linux-perf-users.vger.kernel.org

Support both Python 2 and Python 3 in Core.py. This should have no
functional change.

Signed-off-by: Jeremy Cline <jeremy@jcline.org>
---
 .../Perf-Trace-Util/lib/Perf/Trace/Core.py    | 40 ++++++++-----------
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
2.17.0
