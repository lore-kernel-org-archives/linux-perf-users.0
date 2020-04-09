From: Andreas Gerstmayr <agerstmayr@redhat.com>
Subject: [PATCH] perf script flamegraph: python2 support, update cli args
Date: Thu,  9 Apr 2020 18:57:31 +0200
Message-ID: <20200409165734.165260-1-agerstmayr@redhat.com>
References: <20200406151118.GC32649@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200406151118.GC32649@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-perf-users@vger.kernel.org
Cc: Andreas Gerstmayr <agerstmayr@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

* removed --indent argument
* renamed -F to -f argument to be consistent with other arguments

Signed-off-by: Andreas Gerstmayr <agerstmayr@redhat.com>
---
 tools/perf/scripts/python/flamegraph.py | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/tools/perf/scripts/python/flamegraph.py b/tools/perf/scripts=
/python/flamegraph.py
index 5835d190ca42..61f3be9add6b 100755
--- a/tools/perf/scripts/python/flamegraph.py
+++ b/tools/perf/scripts/python/flamegraph.py
@@ -14,6 +14,7 @@
 # Flame Graphs invented by Brendan Gregg <bgregg@netflix.com>
 # Works in tandem with d3-flame-graph by Martin Spier <mspier@netflix.co=
m>
=20
+from __future__ import print_function
 import sys
 import os
 import argparse
@@ -43,11 +44,11 @@ class FlameGraphCLI:
=20
         if self.args.format =3D=3D "html" and \
                 not os.path.isfile(self.args.template):
-            print(f"Flame Graph template {self.args.template} does not "=
 +
-                  f"exist. Please install the js-d3-flame-graph (RPM) or=
 " +
-                  f"libjs-d3-flame-graph (deb) package, specify an " +
-                  f"existing flame graph template (--template PATH) or "=
 +
-                  f"another output format (--format FORMAT).",
+            print("Flame Graph template {} does not exist. Please instal=
l "
+                  "the js-d3-flame-graph (RPM) or libjs-d3-flame-graph (=
deb) "
+                  "package, specify an existing flame graph template "
+                  "(--template PATH) or another output format "
+                  "(--format FORMAT).".format(self.args.template),
                   file=3Dsys.stderr)
             sys.exit(1)
=20
@@ -76,8 +77,7 @@ class FlameGraphCLI:
         node.value +=3D 1
=20
     def trace_end(self):
-        json_str =3D json.dumps(self.stack, default=3Dlambda x: x.toJSON=
(),
-                              indent=3Dself.args.indent)
+        json_str =3D json.dumps(self.stack, default=3Dlambda x: x.toJSON=
())
=20
         if self.args.format =3D=3D "html":
             try:
@@ -85,7 +85,7 @@ class FlameGraphCLI:
                     output_str =3D f.read().replace("/** @flamegraph_jso=
n **/",
                                                   json_str)
             except IOError as e:
-                print(f"Error reading template file: {e}", file=3Dsys.st=
derr)
+                print("Error reading template file: {}".format(e), file=3D=
sys.stderr)
                 sys.exit(1)
             output_fn =3D self.args.output or "flamegraph.html"
         else:
@@ -95,24 +95,22 @@ class FlameGraphCLI:
         if output_fn =3D=3D "-":
             sys.stdout.write(output_str)
         else:
-            print(f"dumping data to {output_fn}")
+            print("dumping data to {}".format(output_fn))
             try:
                 with open(output_fn, "w") as out:
                     out.write(output_str)
             except IOError as e:
-                print(f"Error writing output file: {e}", file=3Dsys.stde=
rr)
+                print("Error writing output file: {}".format(e), file=3D=
sys.stderr)
                 sys.exit(1)
=20
=20
 if __name__ =3D=3D "__main__":
     parser =3D argparse.ArgumentParser(description=3D"Create flame graph=
s.")
-    parser.add_argument("-F", "--format",
+    parser.add_argument("-f", "--format",
                         default=3D"html", choices=3D["json", "html"],
                         help=3D"output file format")
     parser.add_argument("-o", "--output",
                         help=3D"output file name")
-    parser.add_argument("--indent",
-                        type=3Dint, help=3D"JSON indentation")
     parser.add_argument("--template",
                         default=3D"/usr/share/d3-flame-graph/d3-flamegra=
ph-base.html",
                         help=3D"path to flamegraph HTML template")
--=20
2.25.2
