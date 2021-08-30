Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 944FDC4320A
	for <linux-perf-users@archiver.kernel.org>; Mon, 30 Aug 2021 16:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79D0E60F5E
	for <linux-perf-users@archiver.kernel.org>; Mon, 30 Aug 2021 16:48:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237954AbhH3Qsz (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 30 Aug 2021 12:48:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39397 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237806AbhH3Qsv (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 30 Aug 2021 12:48:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630342077;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=f4OufpH9qoeJgHD/9Z6IN4NJ6YC/PYNscmRgK19yIN8=;
        b=Cm79XzUCrWhpn9fi3xFr18TbjLnXYEPN55arQVoaNmNPzDgXtUqjDDJ4Tb/nTEHcKpZusP
        5ADOzyJvH5384EWhPHk+Xn63JlmIq9HYjktW/jDgI2au8e/AP+aHRrWPP9hKJGjomJQjpm
        BK4HB7HQKiCcxsrD7kAsBZP09F7Z+EA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-471-mSQZjJqNN0eoQjhy8iHHGA-1; Mon, 30 Aug 2021 12:47:53 -0400
X-MC-Unique: mSQZjJqNN0eoQjhy8iHHGA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EE305185302A;
        Mon, 30 Aug 2021 16:47:51 +0000 (UTC)
Received: from agerstmayr-thinkpad.admin.vie.andihit.net (unknown [10.40.195.91])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3AA545D9F4;
        Mon, 30 Aug 2021 16:47:44 +0000 (UTC)
From:   Andreas Gerstmayr <agerstmayr@redhat.com>
To:     linux-perf-users@vger.kernel.org
Cc:     Andreas Gerstmayr <agerstmayr@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] perf: flamegraph.py script improvements
Date:   Mon, 30 Aug 2021 18:47:27 +0200
Message-Id: <20210830164729.116049-1-agerstmayr@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

* display perf.data header
* display PIDs of user stacks
* added option to change color scheme
* default to blue/green color scheme to improve accessibility
* correctly identify kernel stacks when kernel-debuginfo is installed

Signed-off-by: Andreas Gerstmayr <agerstmayr@redhat.com>
---
Tested with Fedora 34, RHEL 8.5 & 9-beta, and Ubuntu 20.04.

The updated flamegraph.py script works with the current d3-flame-graph template, but in order to use the new features (perf header, new color scheme), please run `wget -O /usr/share/d3-flame-graph/d3-flamegraph-base.html https://gist.githubusercontent.com/andreasgerstmayr/1f84a6ac04e6391bfc653a546cf3e1aa/raw/f67accc1873be66d14e90360c9b8cd15faa551f6/d3-flamegraph-base.html`
I'll update the js-d3-flame-graph package soon.


 tools/perf/scripts/python/flamegraph.py | 108 ++++++++++++++++++------
 1 file changed, 81 insertions(+), 27 deletions(-)

diff --git a/tools/perf/scripts/python/flamegraph.py b/tools/perf/scripts/python/flamegraph.py
index 65780013f745..b6af1dd5f816 100755
--- a/tools/perf/scripts/python/flamegraph.py
+++ b/tools/perf/scripts/python/flamegraph.py
@@ -13,6 +13,10 @@
 # Written by Andreas Gerstmayr <agerstmayr@redhat.com>
 # Flame Graphs invented by Brendan Gregg <bgregg@netflix.com>
 # Works in tandem with d3-flame-graph by Martin Spier <mspier@netflix.com>
+#
+# pylint: disable=missing-module-docstring
+# pylint: disable=missing-class-docstring
+# pylint: disable=missing-function-docstring
 
 from __future__ import print_function
 import sys
@@ -20,16 +24,19 @@ import os
 import io
 import argparse
 import json
+import subprocess
 
-
+# pylint: disable=too-few-public-methods
 class Node:
-    def __init__(self, name, libtype=""):
+    def __init__(self, name, libtype):
         self.name = name
+        # "root" | "kernel" | ""
+        # "" indicates user space
         self.libtype = libtype
         self.value = 0
         self.children = []
 
-    def toJSON(self):
+    def to_json(self):
         return {
             "n": self.name,
             "l": self.libtype,
@@ -41,7 +48,7 @@ class Node:
 class FlameGraphCLI:
     def __init__(self, args):
         self.args = args
-        self.stack = Node("root")
+        self.stack = Node("all", "root")
 
         if self.args.format == "html" and \
                 not os.path.isfile(self.args.template):
@@ -53,13 +60,21 @@ class FlameGraphCLI:
                   file=sys.stderr)
             sys.exit(1)
 
-    def find_or_create_node(self, node, name, dso):
-        libtype = "kernel" if dso == "[kernel.kallsyms]" else ""
-        if name is None:
-            name = "[unknown]"
+    @staticmethod
+    def get_libtype_from_dso(dso):
+        """
+        when kernel-debuginfo is installed,
+        dso points to /usr/lib/debug/lib/modules/*/vmlinux
+        """
+        if dso and (dso == "[kernel.kallsyms]" or dso.endswith("/vmlinux")):
+            return "kernel"
 
+        return ""
+
+    @staticmethod
+    def find_or_create_node(node, name, libtype):
         for child in node.children:
-            if child.name == name and child.libtype == libtype:
+            if child.name == name:
                 return child
 
         child = Node(name, libtype)
@@ -67,30 +82,65 @@ class FlameGraphCLI:
         return child
 
     def process_event(self, event):
-        node = self.find_or_create_node(self.stack, event["comm"], None)
+        pid = event.get("sample", {}).get("pid", 0)
+        # event["dso"] sometimes contains /usr/lib/debug/lib/modules/*/vmlinux
+        # for user-space processes; let's use pid for kernel or user-space distinction
+        if pid == 0:
+            comm = event["comm"]
+            libtype = "kernel"
+        else:
+            comm = "{} ({})".format(event["comm"], pid)
+            libtype = ""
+        node = self.find_or_create_node(self.stack, comm, libtype)
+
         if "callchain" in event:
-            for entry in reversed(event['callchain']):
-                node = self.find_or_create_node(
-                    node, entry.get("sym", {}).get("name"), event.get("dso"))
+            for entry in reversed(event["callchain"]):
+                name = entry.get("sym", {}).get("name", "[unknown]")
+                libtype = self.get_libtype_from_dso(entry.get("dso"))
+                node = self.find_or_create_node(node, name, libtype)
         else:
-            node = self.find_or_create_node(
-                node, entry.get("symbol"), event.get("dso"))
+            name = event.get("symbol", "[unknown]")
+            libtype = self.get_libtype_from_dso(event.get("dso"))
+            node = self.find_or_create_node(node, name, libtype)
         node.value += 1
 
+    def get_report_header(self):
+        if self.args.input == "-":
+            # when this script is invoked with "perf script flamegraph",
+            # no perf.data is created and we cannot read the header of it
+            return ""
+
+        try:
+            output = subprocess.check_output(["perf", "report", "--header-only"])
+            return output.decode("utf-8")
+        except Exception as err:  # pylint: disable=broad-except
+            print("Error reading report header: {}".format(err), file=sys.stderr)
+            return ""
+
     def trace_end(self):
-        json_str = json.dumps(self.stack, default=lambda x: x.toJSON())
+        stacks_json = json.dumps(self.stack, default=lambda x: x.to_json())
 
         if self.args.format == "html":
+            report_header = self.get_report_header()
+            options = {
+                "colorscheme": self.args.colorscheme,
+                "context": report_header
+            }
+            options_json = json.dumps(options)
+
             try:
-                with io.open(self.args.template, encoding="utf-8") as f:
-                    output_str = f.read().replace("/** @flamegraph_json **/",
-                                                  json_str)
-            except IOError as e:
-                print("Error reading template file: {}".format(e), file=sys.stderr)
+                with io.open(self.args.template, encoding="utf-8") as template:
+                    output_str = (
+                        template.read()
+                        .replace("/** @options_json **/", options_json)
+                        .replace("/** @flamegraph_json **/", stacks_json)
+                    )
+            except IOError as err:
+                print("Error reading template file: {}".format(err), file=sys.stderr)
                 sys.exit(1)
             output_fn = self.args.output or "flamegraph.html"
         else:
-            output_str = json_str
+            output_str = stacks_json
             output_fn = self.args.output or "stacks.json"
 
         if output_fn == "-":
@@ -101,8 +151,8 @@ class FlameGraphCLI:
             try:
                 with io.open(output_fn, "w", encoding="utf-8") as out:
                     out.write(output_str)
-            except IOError as e:
-                print("Error writing output file: {}".format(e), file=sys.stderr)
+            except IOError as err:
+                print("Error writing output file: {}".format(err), file=sys.stderr)
                 sys.exit(1)
 
 
@@ -115,12 +165,16 @@ if __name__ == "__main__":
                         help="output file name")
     parser.add_argument("--template",
                         default="/usr/share/d3-flame-graph/d3-flamegraph-base.html",
-                        help="path to flamegraph HTML template")
+                        help="path to flame graph HTML template")
+    parser.add_argument("--colorscheme",
+                        default="blue-green",
+                        help="flame graph color scheme",
+                        choices=["blue-green", "orange"])
     parser.add_argument("-i", "--input",
                         help=argparse.SUPPRESS)
 
-    args = parser.parse_args()
-    cli = FlameGraphCLI(args)
+    cli_args = parser.parse_args()
+    cli = FlameGraphCLI(cli_args)
 
     process_event = cli.process_event
     trace_end = cli.trace_end
-- 
2.31.1

