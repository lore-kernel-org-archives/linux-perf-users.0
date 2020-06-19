From: Andreas Gerstmayr <agerstmayr@redhat.com>
Subject: [PATCH v2] perf flamegraph: explicitly set utf-8 encoding
Date: Fri, 19 Jun 2020 17:32:31 +0200
Message-ID: <20200619153232.203537-1-agerstmayr@redhat.com>
References: <20200619130745.153113-1-agerstmayr@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200619130745.153113-1-agerstmayr@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-perf-users@vger.kernel.org
Cc: Michael Petlan <mpetlan@redhat.com>, Andreas Gerstmayr <agerstmayr@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

on some platforms the default encoding is not utf-8,
which causes an UnicodeDecodeError when reading the flamegraph template
and writing the flamegraph

Signed-off-by: Andreas Gerstmayr <agerstmayr@redhat.com>
---

changelog v2: also write to stdout with utf-8 encoding

 tools/perf/scripts/python/flamegraph.py | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/perf/scripts/python/flamegraph.py b/tools/perf/scripts/python/flamegraph.py
index 61f3be9add6b..65780013f745 100755
--- a/tools/perf/scripts/python/flamegraph.py
+++ b/tools/perf/scripts/python/flamegraph.py
@@ -17,6 +17,7 @@
 from __future__ import print_function
 import sys
 import os
+import io
 import argparse
 import json
 
@@ -81,7 +82,7 @@ class FlameGraphCLI:
 
         if self.args.format == "html":
             try:
-                with open(self.args.template) as f:
+                with io.open(self.args.template, encoding="utf-8") as f:
                     output_str = f.read().replace("/** @flamegraph_json **/",
                                                   json_str)
             except IOError as e:
@@ -93,11 +94,12 @@ class FlameGraphCLI:
             output_fn = self.args.output or "stacks.json"
 
         if output_fn == "-":
-            sys.stdout.write(output_str)
+            with io.open(sys.stdout.fileno(), "w", encoding="utf-8", closefd=False) as out:
+                out.write(output_str)
         else:
             print("dumping data to {}".format(output_fn))
             try:
-                with open(output_fn, "w") as out:
+                with io.open(output_fn, "w", encoding="utf-8") as out:
                     out.write(output_str)
             except IOError as e:
                 print("Error writing output file: {}".format(e), file=sys.stderr)
-- 
2.25.4
