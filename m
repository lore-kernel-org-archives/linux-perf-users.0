From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 26/26] perf script: Add flamegraph.py script
Date: Mon, 13 Apr 2020 13:52:03 -0300
Message-ID: <20200413165203.1816-27-acme@kernel.org>
References: <20200413165203.1816-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200413165203.1816-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Andreas Gerstmayr <agerstmayr@redhat.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, Brendan Gregg <bgregg@netflix.com>, Martin Spier <mspier@netflix.com>
List-Id: linux-perf-users.vger.kernel.org

From: Andreas Gerstmayr <agerstmayr@redhat.com>

This script works in tandem with d3-flame-graph to generate flame graphs
from perf. It supports two output formats: JSON and HTML (the default).
The HTML format will look for a standalone d3-flame-graph template file
in /usr/share/d3-flame-graph/d3-flamegraph-base.html and fill in the
collected stacks.

Usage:

    perf record -a -g -F 99 sleep 60
    perf script report flamegraph

Combined:

    perf script flamegraph -a -F 99 sleep 60

Committer testing:

Tested both with "PYTHON=python3" and with the default, that uses
python2-devel:

Complete set of instructions:

  $ mkdir /tmp/build/perf
  $ make PYTHON=python3 -C tools/perf O=/tmp/build/perf install-bin
  $ export PATH=~/bin:$PATH
  $ perf record -a -g -F 99 sleep 60
  $ perf script report flamegraph

Now go and open the generated flamegraph.html file in a browser.

At first this required building with PYTHON=python3, but after I
reported this Andreas was kind enough to send a patch making it work
with both python and python3.

Signed-off-by: Andreas Gerstmayr <agerstmayr@redhat.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Brendan Gregg <bgregg@netflix.com>
Cc: Martin Spier <mspier@netflix.com>
Link: http://lore.kernel.org/lkml/20200320151355.66302-1-agerstmayr@redhat.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../perf/scripts/python/bin/flamegraph-record |   2 +
 .../perf/scripts/python/bin/flamegraph-report |   3 +
 tools/perf/scripts/python/flamegraph.py       | 124 ++++++++++++++++++
 3 files changed, 129 insertions(+)
 create mode 100755 tools/perf/scripts/python/bin/flamegraph-record
 create mode 100755 tools/perf/scripts/python/bin/flamegraph-report
 create mode 100755 tools/perf/scripts/python/flamegraph.py

diff --git a/tools/perf/scripts/python/bin/flamegraph-record b/tools/perf/scripts/python/bin/flamegraph-record
new file mode 100755
index 000000000000..725d66e71570
--- /dev/null
+++ b/tools/perf/scripts/python/bin/flamegraph-record
@@ -0,0 +1,2 @@
+#!/usr/bin/sh
+perf record -g "$@"
diff --git a/tools/perf/scripts/python/bin/flamegraph-report b/tools/perf/scripts/python/bin/flamegraph-report
new file mode 100755
index 000000000000..b1a79afd903b
--- /dev/null
+++ b/tools/perf/scripts/python/bin/flamegraph-report
@@ -0,0 +1,3 @@
+#!/usr/bin/sh
+# description: create flame graphs
+perf script -s "$PERF_EXEC_PATH"/scripts/python/flamegraph.py -- "$@"
diff --git a/tools/perf/scripts/python/flamegraph.py b/tools/perf/scripts/python/flamegraph.py
new file mode 100755
index 000000000000..61f3be9add6b
--- /dev/null
+++ b/tools/perf/scripts/python/flamegraph.py
@@ -0,0 +1,124 @@
+# flamegraph.py - create flame graphs from perf samples
+# SPDX-License-Identifier: GPL-2.0
+#
+# Usage:
+#
+#     perf record -a -g -F 99 sleep 60
+#     perf script report flamegraph
+#
+# Combined:
+#
+#     perf script flamegraph -a -F 99 sleep 60
+#
+# Written by Andreas Gerstmayr <agerstmayr@redhat.com>
+# Flame Graphs invented by Brendan Gregg <bgregg@netflix.com>
+# Works in tandem with d3-flame-graph by Martin Spier <mspier@netflix.com>
+
+from __future__ import print_function
+import sys
+import os
+import argparse
+import json
+
+
+class Node:
+    def __init__(self, name, libtype=""):
+        self.name = name
+        self.libtype = libtype
+        self.value = 0
+        self.children = []
+
+    def toJSON(self):
+        return {
+            "n": self.name,
+            "l": self.libtype,
+            "v": self.value,
+            "c": self.children
+        }
+
+
+class FlameGraphCLI:
+    def __init__(self, args):
+        self.args = args
+        self.stack = Node("root")
+
+        if self.args.format == "html" and \
+                not os.path.isfile(self.args.template):
+            print("Flame Graph template {} does not exist. Please install "
+                  "the js-d3-flame-graph (RPM) or libjs-d3-flame-graph (deb) "
+                  "package, specify an existing flame graph template "
+                  "(--template PATH) or another output format "
+                  "(--format FORMAT).".format(self.args.template),
+                  file=sys.stderr)
+            sys.exit(1)
+
+    def find_or_create_node(self, node, name, dso):
+        libtype = "kernel" if dso == "[kernel.kallsyms]" else ""
+        if name is None:
+            name = "[unknown]"
+
+        for child in node.children:
+            if child.name == name and child.libtype == libtype:
+                return child
+
+        child = Node(name, libtype)
+        node.children.append(child)
+        return child
+
+    def process_event(self, event):
+        node = self.find_or_create_node(self.stack, event["comm"], None)
+        if "callchain" in event:
+            for entry in reversed(event['callchain']):
+                node = self.find_or_create_node(
+                    node, entry.get("sym", {}).get("name"), event.get("dso"))
+        else:
+            node = self.find_or_create_node(
+                node, entry.get("symbol"), event.get("dso"))
+        node.value += 1
+
+    def trace_end(self):
+        json_str = json.dumps(self.stack, default=lambda x: x.toJSON())
+
+        if self.args.format == "html":
+            try:
+                with open(self.args.template) as f:
+                    output_str = f.read().replace("/** @flamegraph_json **/",
+                                                  json_str)
+            except IOError as e:
+                print("Error reading template file: {}".format(e), file=sys.stderr)
+                sys.exit(1)
+            output_fn = self.args.output or "flamegraph.html"
+        else:
+            output_str = json_str
+            output_fn = self.args.output or "stacks.json"
+
+        if output_fn == "-":
+            sys.stdout.write(output_str)
+        else:
+            print("dumping data to {}".format(output_fn))
+            try:
+                with open(output_fn, "w") as out:
+                    out.write(output_str)
+            except IOError as e:
+                print("Error writing output file: {}".format(e), file=sys.stderr)
+                sys.exit(1)
+
+
+if __name__ == "__main__":
+    parser = argparse.ArgumentParser(description="Create flame graphs.")
+    parser.add_argument("-f", "--format",
+                        default="html", choices=["json", "html"],
+                        help="output file format")
+    parser.add_argument("-o", "--output",
+                        help="output file name")
+    parser.add_argument("--template",
+                        default="/usr/share/d3-flame-graph/d3-flamegraph-base.html",
+                        help="path to flamegraph HTML template")
+    parser.add_argument("-i", "--input",
+                        help=argparse.SUPPRESS)
+
+    args = parser.parse_args()
+    cli = FlameGraphCLI(args)
+
+    process_event = cli.process_event
+    trace_end = cli.trace_end
-- 
2.21.1
