Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5955678EB
	for <linux-perf-users@vger.kernel.org>; Thu, 10 Sep 2026 17:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789062288; cv=none; b=pNYppuNRT6KT8hEQQYed/I+TdorjGt1zOTgK4R81KxeyJJSwh+mWvEobrDX053Z+IIa6Mm3DVVk1U9b8k87kgpRO9ZrmqHVBSv0Zku+gbZpIVfftRKXUZEjY1e5/Sot1eV7JBJynb8cLEzyY7BZTxbjCw4RiW9ZWHdEBgvyfnuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789062288; c=relaxed/simple;
	bh=Kp1fVntnUgpr5dPhYFwdUa7mOtBV/Q8lqDeqvvAUmb8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=NZg7e1skLHQeV96MwFeCULDl7FgnjsXOjTw4IqLGRqLAnBTe+J57K6J4aOxn8wGg+9iauZOH7aBrbirXHw01K8QH49j/+cji+wqGacO+8KhH5JP6cXuYZ73YvOaFrLj5XnroPAIRrNxzksaVJj5Kyc92fwSxMVO/9HzaDLFt1bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=REyomxt3; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="REyomxt3"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cc1bbd7d6e6so70768a12.3
        for <linux-perf-users@vger.kernel.org>; Thu, 10 Sep 2026 10:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789062267; x=1789667067; darn=vger.kernel.org;
        h=content-type:to:from:subject:message-id:mime-version:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=+sBL53TWpOY5F37MHtUIstN8/huNjNwzJ60aXWk3Bq4=;
        b=REyomxt347b3jaYBWkXjwJMzs1Nptet9BNnn7ReTcM6l8ou3N/d/OCOHt5AFNYQsfK
         beVxlUCqx2IqkEbbnTE3hAnBx/e/9lXxmgzoiXP0h8znfPIAFKyjklsPwBP0jcxuMoTo
         8OZj6MkQIUb7we9BkXX7vGJNkfnZuu86FfQQ6pvlcxIDpKjpLNVsKH+1Vgm821UUoMBc
         wEpu/Cfqq9xIZlSPipwLNj4m6hI2HlZkEf3ygGZ+k41TNKWb1HFiBTU4VbDd86cVcwlB
         l5GKb9b2VXmMbwI3F5wGm/TwmAz9k9D6v0o6URarZacX9G90/HWM9+3Nrol6JES22pyP
         n0gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789062267; x=1789667067;
        h=content-type:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+sBL53TWpOY5F37MHtUIstN8/huNjNwzJ60aXWk3Bq4=;
        b=gvxyqXrE3PZ2oFIzoBhCOwG9lQrOXExusqLiOdaQgXw1VS/b77CmbMzXWbCICtky6r
         /aloadBDWJK/aZ67BC8U3E1kLjv2zDwjOzdBEdDxakYXB9HvwASAEB4z3VHhSdyjCafa
         p5J0imUj3KGMLJaoZBfSt/RREsjwf2y5MiR+x4BEocaYD3n722H6tQDkxMBs2lRvUOe4
         PC8n26wdY56sMTtQUWxhVwohU4ll/e+EiSH/8Am7eGU19pG/w3KtbPj2HkMPVkA5OKed
         +8/erh6k016QaD+/DY8hB5Vt/7k3Yox9Td0e+0qPbTn5djoJDE7dvafJw8/aO0Y6wYZA
         E4dA==
X-Forwarded-Encrypted: i=1; AKwUvBxPq4CNQ8XoCXTLri7FpfMxUqA5F5G9k3WM88zJQ/Xi2Kpo578ok03K4/OvmZv5Tm7q0EXUfB8EGYZUCnv7BbgH@vger.kernel.org
X-Gm-Message-State: AFuF++lqOqByT/SJkBrX4fVazBAV3FFXgi/bRVd0Rd8dAzs0n8DlVHy8
	kI7tBZKMjfmRa2K8siR5jBk8ZWiUmriTbZi/zrFpCvShI9tafRGpoJxAc0kZsLhGHMHCBgp99sO
	3y3YScFcV8A==
X-Received: from dlbrd11.prod.google.com ([2002:a05:7022:f10b:b0:13d:1c4d:901f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:458f:b0:3c3:a20f:f729
 with SMTP id adf61e73a8af0-3da39beaa21mr67910330637.7.1789062267123; Thu, 10
 Sep 2026 10:44:27 -0700 (PDT)
Date: Thu, 10 Sep 2026 10:44:20 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.1007.g17ff1f9808-goog
Message-ID: <20260910174420.3002597-1-irogers@google.com>
Subject: [PATCH v1] perf python: Fix ilist TreeNode string type drift
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Updates Tree type hints to correctly use TreeNode[TreeValue]
across all assignments preventing mypy strictness mismatches.

Address some other minor stylistic issues reported by mypy, pylint and
Sashiko.

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/python/ilist.py | 70 ++++++++++++++++++++------------------
 1 file changed, 37 insertions(+), 33 deletions(-)

diff --git a/tools/perf/python/ilist.py b/tools/perf/python/ilist.py
index 0d757ddb4795..4797818ef42e 100755
--- a/tools/perf/python/ilist.py
+++ b/tools/perf/python/ilist.py
@@ -6,7 +6,7 @@ from abc import ABC, abstractmethod
 import argparse
 from dataclasses import dataclass
 import math
-from typing import Any, Dict, Optional, Tuple
+from typing import Any, Dict, List, Optional, Set, Tuple
 import perf
 from textual import on
 from textual.app import App, ComposeResult
@@ -19,7 +19,7 @@ from textual.widgets import Button, Footer, Header, Input, Label, Sparkline, Sta
 from textual.widgets.tree import TreeNode
 
 
-def get_info(info: Dict[str, str], key: str):
+def get_info(info: Dict[str, Any], key: str):
     return (info[key] + "\n") if key in info else ""
 
 
@@ -234,7 +234,7 @@ class IListApp(App):
 
     def __init__(self, interval: float) -> None:
         self.interval = interval
-        self.evlist = None
+        self.evlist: Optional[perf.evlist] = None
         self.selected: Optional[TreeValue] = None
         self.search_results: list[TreeNode[TreeValue]] = []
         self.cur_search_result: TreeNode[TreeValue] | None = None
@@ -290,12 +290,12 @@ class IListApp(App):
             event = event.lower()
             search_label.update(f'Searching for events matching "{event}"')
 
-            tree: Tree[str] = self.query_one("#root", Tree)
+            tree: Tree[TreeValue] = self.query_one("#root", Tree)
 
-            def find_search_results(event: str, node: TreeNode[str],
+            def find_search_results(event: str, node: TreeNode[TreeValue],
                                     cursor_seen: bool = False,
-                                    match_after_cursor: Optional[TreeNode[str]] = None
-                                    ) -> Tuple[bool, Optional[TreeNode[str]]]:
+                                    match_after_cursor: Optional[TreeNode[TreeValue]] = None
+                                    ) -> Tuple[bool, Optional[TreeNode[TreeValue]]]:
                 """Find nodes that match the search remembering the one after the cursor."""
                 if not cursor_seen and node == tree.cursor_node:
                     cursor_seen = True
@@ -332,7 +332,7 @@ class IListApp(App):
 
     def action_collapse(self) -> None:
         """Collapse the part of the tree currently on."""
-        tree: Tree[str] = self.query_one("#root", Tree)
+        tree: Tree[TreeValue] = self.query_one("#root", Tree)
         node = tree.cursor_node
         if node and node.parent:
             node.parent.collapse_all()
@@ -343,31 +343,34 @@ class IListApp(App):
         if not self.selected or not self.evlist:
             return
 
-        def update_count(cpu: int, count: int):
+        def update_count(cpu: int, count: int | float):
             # Update the raw count display.
-            counter: Label = self.query(f"#counter_cpu{cpu}" if cpu >= 0 else "#counter_total")
-            if not counter:
+            counter_query = self.query(f"#counter_cpu{cpu}" if cpu >= 0 else "#counter_total")
+            if not counter_query:
                 return
-            counter = counter.first(Label)
+            counter: Label = counter_query.first(Label)
             counter.update(str(count))
 
             # Update the sparkline.
-            line: Sparkline = self.query(f"#sparkline_cpu{cpu}" if cpu >= 0 else "#sparkline_total")
-            if not line:
+            line_query = self.query(f"#sparkline_cpu{cpu}" if cpu >= 0 else "#sparkline_total")
+            if not line_query:
                 return
-            line = line.first(Sparkline)
+            line: Sparkline = line_query.first(Sparkline)
             # If there are more events than the width, remove the front event.
-            if len(line.data) > line.size.width:
-                line.data.pop(0)
-            line.data.append(count)
-            line.mutate_reactive(Sparkline.data)
+            if line.data is not None:
+                if len(line.data) > line.size.width:
+                    line.data = line.data[1:]
+                line.data = list(line.data) + [float(count)]
+            else:
+                line.data = [float(count)]
+            line.refresh()
 
         # Update the total and each CPU counts, assume there's just 1 evsel.
-        total = 0
+        total: float = 0.0
         self.evlist.disable()
         for evsel in self.evlist:
             for cpu in evsel.cpus():
-                aggr = 0
+                aggr: float = 0.0
                 for thread in evsel.threads():
                     aggr += self.selected.value(self.evlist, evsel, cpu, thread)
                 update_count(cpu, aggr)
@@ -424,16 +427,16 @@ class IListApp(App):
         # Add spark lines for all the CPUs. Note, must be done after
         # open so that the evlist CPUs have been computed by propagate
         # maps.
-        line = CounterSparkline(cpu=-1)
-        lines.mount(line)
+        line_sp = CounterSparkline(cpu=-1)
+        lines.mount(line_sp)
         for cpu in self.evlist.all_cpus():
-            line = CounterSparkline(cpu)
-            lines.mount(line)
-        line = Counter(cpu=-1)
-        lines.mount(line)
+            c_sp = CounterSparkline(cpu)
+            lines.mount(c_sp)
+        c_val = Counter(cpu=-1)
+        lines.mount(c_val)
         for cpu in self.evlist.all_cpus():
-            line = Counter(cpu)
-            lines.mount(line)
+            c_val2 = Counter(cpu)
+            lines.mount(c_val2)
 
     def compose(self) -> ComposeResult:
         """Draws the app."""
@@ -459,17 +462,18 @@ class IListApp(App):
                     # Reading events may fail with EPERM, ignore.
                     pass
             metrics = tree.root.add("Metrics")
-            groups = set()
+            groups: Set[str] = set()
             for metric in perf.metrics():
                 groups.update(metric["MetricGroup"])
 
-            def add_metrics_to_tree(node: TreeNode[TreeValue], parent: str, pmu: str = None):
+            def add_metrics_to_tree(node: TreeNode[TreeValue], parent: str, pmu: Optional[str] = None):
                 for metric in sorted(perf.metrics(), key=lambda x: x["MetricName"]):
-                    metric_pmu = metric.get('PMU')
+                    metric_pmu_raw = metric.get('PMU')
+                    metric_pmu = str(metric_pmu_raw) if metric_pmu_raw else ''
                     if pmu and metric_pmu and metric_pmu != pmu:
                         continue
                     if parent in metric["MetricGroup"]:
-                        name = metric["MetricName"]
+                        name = str(metric["MetricName"])
                         display_name = name
                         if metric_pmu:
                             display_name += f" ({metric_pmu})"
-- 
2.55.0.1007.g17ff1f9808-goog

