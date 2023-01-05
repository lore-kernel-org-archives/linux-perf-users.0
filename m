Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBB5FC46467
	for <linux-perf-users@archiver.kernel.org>; Thu,  5 Jan 2023 03:04:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbjAEDEr (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 4 Jan 2023 22:04:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjAEDEp (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 4 Jan 2023 22:04:45 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC83E42E2E
        for <linux-perf-users@vger.kernel.org>; Wed,  4 Jan 2023 19:04:44 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-46a518991cfso334869187b3.18
        for <linux-perf-users@vger.kernel.org>; Wed, 04 Jan 2023 19:04:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lfkNLp5G5wuHv2XWWcgX8O/KJXZf1fcYl8/hPFMILT0=;
        b=DwzvpEzrUCyVoe99pSECCLFmrkStqGsbEM+qZOvLcYPEbAM6sHAlnMtuj4IVTj4CG9
         XymFGvFvyydvhs04qS/xBHcIVzVLJ6qfGb9tmbKq9qnVNUaonzTHEZv+0eixCiPIeIRt
         fHXrlHqtby4RIuQ8gp3knFd7VdOWixUUaKOWVVjHiOeVsiF+RR4/Jo+9ziTN8dJ4MuEj
         Jd5oi2nM6nW2muRVQ5BWFbXYKY9k5XBaWEj02OP2iwLtX2DzEPZtDypoUcTRyZ+Rh7r/
         qq4IdoKLw9LvpcUke2XolHKpu/g4Mju0uI79l09ljFhK9Zmj+ZRhJWvwZiew2Tswixlk
         vYKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lfkNLp5G5wuHv2XWWcgX8O/KJXZf1fcYl8/hPFMILT0=;
        b=p1LonOCk2lsWCehfnqEpbsQCQM/HCd2WRtJ9NElaenvjeHyKG9WVFrXaycCuyc6Gte
         3TEdr2WxE3hQKqHtc3n97WGc4qXdNzeh05N4Xez+/EZ7TmSBuov9mpOKpdHwcKXvdsuy
         3EnmsyJ5Y8fctZZl7Wfo3hFeT8RNdY86d3EQxb7ZUKcM3wBQDLUnBfLyNlcOAbROP2yQ
         QtQXLBiiwQxOBfu8DDPE66CyjnF3GVdvdGCe7cNQoZKARCFmWaaz0GXy0UL1oPs6zDu2
         Hc782LGoDZGUbuPt1AdFA76eIocTIeEQq/3+7A43PlROwD4TdQXhonTQ8y2NUrYXaPGw
         gJXw==
X-Gm-Message-State: AFqh2krqqPRncVbQmYx3WW/3A0YiJDMQgiBhGJC6D67LlycUeCLyTERT
        QmdnxUvkyAZ69RUdy4SrU07amgr2+3ev
X-Google-Smtp-Source: AMrXdXuisK5mAqlwmvkpFdxhPjG8DpYhx5FFU3xnFObYy1LV8aptLQvUkfB/FW5qEwEAzG/vzfyNqMD0xDoA
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:1e55:c3f8:c203:8c48])
 (user=irogers job=sendgmr) by 2002:a25:2fc5:0:b0:706:bafd:6f95 with SMTP id
 v188-20020a252fc5000000b00706bafd6f95mr4072901ybv.55.1672887883928; Wed, 04
 Jan 2023 19:04:43 -0800 (PST)
Date:   Wed,  4 Jan 2023 19:04:34 -0800
Message-Id: <20230105030434.255603-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Subject: [PATCH v1] perf script flamegraph: Avoid d3-flame-graph package dependency
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        996839@bugs.debian.org, Andreas Gerstmayr <agerstmayr@redhat.com>,
        Martin Spier <mspier@netflix.com>,
        Brendan Gregg <brendan@intel.com>
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Currently flame graph generation requires a d3-flame-graph template to
be installed. Unfortunately this is hard to come by for things like
Debian [1]. If the template isn't installed warn and download it from
jsdelivr CDN. If downloading fails generate a minimal flame graph
again with the javascript coming from jsdelivr CDN.

[1] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=996839

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/scripts/python/flamegraph.py | 63 ++++++++++++++++++-------
 1 file changed, 45 insertions(+), 18 deletions(-)

diff --git a/tools/perf/scripts/python/flamegraph.py b/tools/perf/scripts/python/flamegraph.py
index b6af1dd5f816..808b0e1c9be5 100755
--- a/tools/perf/scripts/python/flamegraph.py
+++ b/tools/perf/scripts/python/flamegraph.py
@@ -25,6 +25,27 @@ import io
 import argparse
 import json
 import subprocess
+import urllib.request
+
+minimal_html = """<head>
+  <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/d3-flame-graph@4.1.3/dist/d3-flamegraph.css">
+</head>
+<body>
+  <div id="chart"></div>
+  <script type="text/javascript" src="https://d3js.org/d3.v7.js"></script>
+  <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/d3-flame-graph@4.1.3/dist/d3-flamegraph.min.js"></script>
+  <script type="text/javascript">
+  const stacks = [/** @flamegraph_json **/];
+  // Note, options is unused.
+  const options = [/** @options_json **/];
+
+  var chart = flamegraph();
+  d3.select("#chart")
+        .datum(stacks[0])
+        .call(chart);
+  </script>
+</body>
+"""
 
 # pylint: disable=too-few-public-methods
 class Node:
@@ -50,15 +71,18 @@ class FlameGraphCLI:
         self.args = args
         self.stack = Node("all", "root")
 
-        if self.args.format == "html" and \
-                not os.path.isfile(self.args.template):
-            print("Flame Graph template {} does not exist. Please install "
-                  "the js-d3-flame-graph (RPM) or libjs-d3-flame-graph (deb) "
-                  "package, specify an existing flame graph template "
-                  "(--template PATH) or another output format "
-                  "(--format FORMAT).".format(self.args.template),
-                  file=sys.stderr)
-            sys.exit(1)
+        if self.args.format == "html":
+            if os.path.isfile(self.args.template):
+                self.template = f"file://{self.args.template}"
+            else:
+                print(f"""
+Warning: Flame Graph template '{self.args.template}'
+does not exist, a template will be downloaded via http. To avoid this
+please install a package such as the js-d3-flame-graph or
+libjs-d3-flame-graph, specify an existing flame graph template
+(--template PATH) or another output format (--format FORMAT).
+""", file=sys.stderr)
+            self.template = "https://cdn.jsdelivr.net/npm/d3-flame-graph@4.1.3/dist/templates/d3-flamegraph-base.html"
 
     @staticmethod
     def get_libtype_from_dso(dso):
@@ -129,15 +153,18 @@ class FlameGraphCLI:
             options_json = json.dumps(options)
 
             try:
-                with io.open(self.args.template, encoding="utf-8") as template:
-                    output_str = (
-                        template.read()
-                        .replace("/** @options_json **/", options_json)
-                        .replace("/** @flamegraph_json **/", stacks_json)
-                    )
-            except IOError as err:
-                print("Error reading template file: {}".format(err), file=sys.stderr)
-                sys.exit(1)
+                with urllib.request.urlopen(self.template) as template:
+                    output_str = '\n'.join([
+                        l.decode('utf-8') for l in template.readlines()
+                    ])
+            except Exception as err:
+                print(f"Error reading template {self.template}: {err}\n"
+                      "a minimal flame graph will be generated", file=sys.stderr)
+                output_str = minimal_html
+
+            output_str = output_str.replace("/** @options_json **/", options_json)
+            output_str = output_str.replace("/** @flamegraph_json **/", stacks_json)
+
             output_fn = self.args.output or "flamegraph.html"
         else:
             output_str = stacks_json
-- 
2.39.0.314.g84b9a713c41-goog

