Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC79E3196AF
	for <linux-perf-users@vger.kernel.org>; Thu, 10 Jul 2025 23:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752191914; cv=none; b=RjqnTGShrBaBLvGww8H1Ul9ppGHLi7w6VtYVhqzTlLDgA5Ej9DmUvtw93v32kwuWbliywK4mly0WDv+0xnG2JAKlN8gsfTnwNhVSqwZNO+A6KwXm9ToQkJyKzvxAx2e552kJLBGwk3LU3qSAkWY907ymZJ2rkqsh6FiSGHBZlnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752191914; c=relaxed/simple;
	bh=4DBEBdTfWfkhLt8ag7FL9lGLt+srCnvLuSveHjPSawA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=GTO7kJuLoxGGg70u/bHFePGZTx0PQON2iOZb8fE6o1/Px9nb8GzMc+pZwJZRo5XgwnxK73oyOLsQrtwrKbSI9x1mzpS2DfJRlvhd1y2s28B/ntPAmTctUmYAuB/zyzJz9J3ZEuZO6TSlQc/1U1w2/aRI71b9+vOx0Asq3HgHZ1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RX+/nNnd; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RX+/nNnd"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b2fcbd76b61so1896653a12.3
        for <linux-perf-users@vger.kernel.org>; Thu, 10 Jul 2025 16:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752191912; x=1752796712; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BsThzVLcGqNGlV+OXH+rg8cRsNmgOdp9nQeDnnzr9WU=;
        b=RX+/nNndH0YhHcbOok2dDHaJH1tYqrKJ9jhYz4CZZMD8J5rtU8hnKXNnzS7Wb0PBK+
         RQBR7/NGOohBYUUfgFT6HDx/uvRTIVyEu6ST+nOFJbG/OWzvMDlz3mzwppExbaPWYWff
         SO1WyTY9S/y3cykKn2ATB9ZzG4hQkqkno4nz5Do3rgDXulgC6fYJ1HZrYJdTDMo6pdR5
         catR+oVGLwv7ETAA7tLMxPpXdEG80xTrrgUsI6kEMgq//0mlLh5tnznjd1z5qoiIkRJy
         Wx/lDKLcaGvv1jjI9qymJIn3uayDHTaHmNjofe6Q1oU/ilEYJqku2B5pGqdIFyOSm8A7
         ow/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752191912; x=1752796712;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BsThzVLcGqNGlV+OXH+rg8cRsNmgOdp9nQeDnnzr9WU=;
        b=F4OoDrYgXSYPwDUXJFazWq/C5xLKvok0FEbVP5H90rn0Ep0DeBpkR29qHihHRH4+sz
         5Zp8h+aKTNOyOQSU34KSg/MHv/skXwRf7AwMRUf1U8JL1OyOMsD5/jm0+HyQOx6sqG0D
         SP9A51++PSUBYblDY2nlCvfjRXKi5H3/WrBq90kFXjSzHvelbURDIMlzimIl3A/bsuVE
         KkdKnH8ZQpGjWZA8qEyNSYA/ARMjI/Fk5TtEQPnDP9o+t4grx/Lczp9WcoNbBYwnfDFl
         7HWKrHEoAJDOFMd2czbAHPNrLDxtMUGB1WCi91us4BN195x81zFlw5s3zFZ/K6COjPzT
         DHnw==
X-Forwarded-Encrypted: i=1; AJvYcCUYvcDSe8MVG3jQcf/8/rZiw6TGLJKuhONmzdIKf5gl7fuO5KqL/UPVpW9mo2zT22z6JNmiejeYWsfFsk3DfObs@vger.kernel.org
X-Gm-Message-State: AOJu0YylN9TW83V863dCscEbyZ3pi/OVjd+cYzwu/BRX32sgwyXTs0mx
	6Kht3fZxExSsPGfOqGo78PXZKsnnbLykBZ96MbZnpIb0G2OYOnjOZ4x4kvu8hfPhymL7Z7b1f7f
	HQaPVYuPULw==
X-Google-Smtp-Source: AGHT+IHwwifwYLIYk/0rs9JVC1jLVNUSQ2XyDd1ZHWXgQdOcnurgh4WPsY87t4mgJqxvt+CX1/YduFsU/Xhk
X-Received: from pgbfq20.prod.google.com ([2002:a05:6a02:2994:b0:b31:be7c:3c6b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:431a:b0:215:efe1:a680
 with SMTP id adf61e73a8af0-231367675ebmr1366518637.16.1752191912159; Thu, 10
 Jul 2025 16:58:32 -0700 (PDT)
Date: Thu, 10 Jul 2025 16:57:35 -0700
In-Reply-To: <20250710235735.1089240-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250710235735.1089240-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250710235735.1089240-15-irogers@google.com>
Subject: [PATCH v6 14/14] perf ilist: Add support for metrics
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
	Collin Funk <collin.funk1@gmail.com>, Howard Chu <howardchu95@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Andi Kleen <ak@linux.intel.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Thomas Richter <tmricht@linux.ibm.com>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, Gautam Menghani <gautam@linux.ibm.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Chun-Tse Shao <ctshao@google.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Change tree nodes to having a value of either Metric or PmuEvent,
these values have the ability to match searches, be parsed to create
evlists and to give a value per CPU and per thread to display.  Use
perf.metrics to generate a tree of metrics. Most metrics are placed
under their metric group, if the metric group name ends with '_group'
then the metric group is placed next to the associated metric.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/python/ilist.py | 207 +++++++++++++++++++++++++++----------
 1 file changed, 153 insertions(+), 54 deletions(-)

diff --git a/tools/perf/python/ilist.py b/tools/perf/python/ilist.py
index 3e2fae1db738..0d46b44d2961 100755
--- a/tools/perf/python/ilist.py
+++ b/tools/perf/python/ilist.py
@@ -2,8 +2,11 @@
 # SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
 """Interactive perf list."""
 
+from abc import ABC, abstractmethod
 import argparse
-from typing import Any, Dict, Tuple
+from dataclasses import dataclass
+from typing import Any, Dict, Optional, Tuple
+import math
 import perf
 from textual import on
 from textual.app import App, ComposeResult
@@ -14,6 +17,103 @@ from textual.screen import ModalScreen
 from textual.widgets import Button, Footer, Header, Input, Label, Sparkline, Static, Tree
 from textual.widgets.tree import TreeNode
 
+def get_info(info: Dict[str, str], key: str):
+    return (info[key] + "\n") if key in info else ""
+
+class TreeValue(ABC):
+    """Abstraction for the data of value in the tree."""
+
+    @abstractmethod
+    def name(self) -> str:
+        pass
+
+    @abstractmethod
+    def description(self) -> str:
+        pass
+
+    @abstractmethod
+    def matches(self, query: str) -> bool:
+        pass
+
+    @abstractmethod
+    def parse(self) -> perf.evlist:
+        pass
+
+    @abstractmethod
+    def value(self, evlist: perf.evlist, evsel: perf.evsel, cpu: int, thread: int) -> float:
+        pass
+
+
+@dataclass
+class Metric(TreeValue):
+    """A metric in the tree."""
+    metric_name: str
+
+    def name(self) -> str:
+        return self.metric_name
+
+    def description(self) -> str:
+        """Find and format metric description."""
+        for metric in perf.metrics():
+            if metric["MetricName"] != self.metric_name:
+                continue
+            desc = get_info(metric, "BriefDescription")
+            desc += get_info(metric, "PublicDescription")
+            desc += get_info(metric, "MetricExpr")
+            desc += get_info(metric, "MetricThreshold")
+            return desc
+        return "description"
+
+    def matches(self, query: str) -> bool:
+        return query in self.metric_name
+
+    def parse(self) -> perf.evlist:
+        return perf.parse_metrics(self.metric_name)
+
+    def value(self, evlist: perf.evlist, evsel: perf.evsel, cpu: int, thread: int) -> float:
+        val = evlist.compute_metric(self.metric_name, cpu, thread)
+        return 0 if math.isnan(val) else val
+
+
+@dataclass
+class PmuEvent(TreeValue):
+    """A PMU and event within the tree."""
+    pmu: str
+    event: str
+
+    def name(self) -> str:
+        if self.event.startswith(self.pmu) or ':' in self.event:
+            return self.event
+        else:
+            return f"{self.pmu}/{self.event}/"
+
+    def description(self) -> str:
+        """Find and format event description for {pmu}/{event}/."""
+        for p in perf.pmus():
+            if p.name() != self.pmu:
+                continue
+            for info in p.events():
+                if "name" not in info or info["name"] != self.event:
+                    continue
+
+                desc = get_info(info, "topic")
+                desc += get_info(info, "event_type_desc")
+                desc += get_info(info, "desc")
+                desc += get_info(info, "long_desc")
+                desc += get_info(info, "encoding_desc")
+                return desc
+        return "description"
+
+    def matches(self, query: str) -> bool:
+        return query in self.pmu or query in self.event
+
+    def parse(self) -> perf.evlist:
+        return perf.parse_events(self.name())
+
+    def value(self, evlist: perf.evlist, evsel: perf.evsel, cpu: int, thread: int) -> float:
+        return evsel.read(cpu, thread).val
+
+
 class ErrorScreen(ModalScreen[bool]):
     """Pop up dialog for errors."""
 
@@ -123,8 +223,9 @@ class IListApp(App):
     def __init__(self, interval: float) -> None:
         self.interval = interval
         self.evlist = None
-        self.search_results: list[TreeNode[str]] = []
-        self.cur_search_result: TreeNode[str] | None = None
+        self.selected: Optional[TreeValue] = None
+        self.search_results: list[TreeNode[TreeValue]] = []
+        self.cur_search_result: TreeNode[TreeValue] | None = None
         super().__init__()
 
 
@@ -180,15 +281,15 @@ class IListApp(App):
             event = event.lower()
             search_label.update(f'Searching for events matching "{event}"')
 
-            tree: Tree[str] = self.query_one("#pmus", Tree)
-            def find_search_results(event: str, node: TreeNode[str], \
+            tree: Tree[TreeValue] = self.query_one("#root", Tree)
+            def find_search_results(event: str, node: TreeNode[TreeValue], \
                                     cursor_seen: bool = False, \
-                                    match_after_cursor: TreeNode[str] | None = None) \
-                    -> Tuple[bool, TreeNode[str] | None]:
+                                    match_after_cursor: TreeNode[TreeValue] | None = None) \
+                    -> Tuple[bool, TreeNode[TreeValue] | None]:
                 """Find nodes that match the search remembering the one after the cursor."""
                 if not cursor_seen and node == tree.cursor_node:
                     cursor_seen = True
-                if node.data and event in node.data:
+                if node.data and node.data.matches(event):
                     if cursor_seen and not match_after_cursor:
                         match_after_cursor = node
                     self.search_results.append(node)
@@ -222,17 +323,17 @@ class IListApp(App):
 
 
     def action_collapse(self) -> None:
-        """Collapse the potentially large number of events under a PMU."""
-        tree: Tree[str] = self.query_one("#pmus", Tree)
+        """Collapse the part of the tree currently on."""
+        tree: Tree[str] = self.query_one("#root", Tree)
         node = tree.cursor_node
-        if node and node.parent and node.parent.parent:
+        if node and node.parent:
             node.parent.collapse_all()
             node.tree.scroll_to_node(node.parent)
 
 
     def update_counts(self) -> None:
         """Called every interval to update counts."""
-        if not self.evlist:
+        if not self.selected or not self.evlist:
             return
 
         def update_count(cpu: int, count: int):
@@ -261,8 +362,7 @@ class IListApp(App):
             for cpu in evsel.cpus():
                 aggr = 0
                 for thread in evsel.threads():
-                    counts = evsel.read(cpu, thread)
-                    aggr += counts.val
+                    aggr += self.selected.value(self.evlist, evsel, cpu, thread)
                 update_count(cpu, aggr)
                 total += aggr
         update_count(-1, total)
@@ -275,8 +375,10 @@ class IListApp(App):
         self.set_interval(self.interval, self.update_counts)
 
 
-    def set_pmu_and_event(self, pmu: str, event: str) -> None:
+    def set_selected(self, value: TreeValue) -> None:
         """Updates the event/description and starts the counters."""
+        self.selected = value
+
         # Remove previous event information.
         if self.evlist:
             self.evlist.disable()
@@ -288,34 +390,13 @@ class IListApp(App):
             for line in lines:
                 line.remove()
 
-        def pmu_event_description(pmu: str, event: str) -> str:
-            """Find and format event description for {pmu}/{event}/."""
-            def get_info(info: Dict[str, str], key: str):
-                return (info[key] + "\n") if key in info else ""
-
-            for p in perf.pmus():
-                if p.name() != pmu:
-                    continue
-                for info in p.events():
-                    if "name" not in info or info["name"] != event:
-                        continue
-
-                    desc = get_info(info, "topic")
-                    desc += get_info(info, "event_type_desc")
-                    desc += get_info(info, "desc")
-                    desc += get_info(info, "long_desc")
-                    desc += get_info(info, "encoding_desc")
-                    return desc
-            return "description"
-
-        # Parse event, update event text and description.
-        full_name = event if event.startswith(pmu) or ':' in event else f"{pmu}/{event}/"
-        self.query_one("#event_name", Label).update(full_name)
-        self.query_one("#event_description", Static).update(pmu_event_description(pmu, event))
+        # Update event/metric text and description.
+        self.query_one("#event_name", Label).update(value.name())
+        self.query_one("#event_description", Static).update(value.description())
 
         # Open the event.
         try:
-            self.evlist = perf.parse_events(full_name)
+            self.evlist = value.parse()
             if self.evlist:
                 self.evlist.open()
                 self.evlist.enable()
@@ -323,7 +404,7 @@ class IListApp(App):
             self.evlist = None
 
         if not self.evlist:
-            self.push_screen(ErrorScreen(f"Failed to open {full_name}"))
+            self.push_screen(ErrorScreen(f"Failed to open {value.name()}"))
             return
 
         # Add spark lines for all the CPUs. Note, must be done after
@@ -344,24 +425,44 @@ class IListApp(App):
 
     def compose(self) -> ComposeResult:
         """Draws the app."""
-        def pmu_event_tree() -> Tree:
-            """Create tree of PMUs with events under."""
-            tree: Tree[str] = Tree("PMUs", id="pmus")
-            tree.root.expand()
+        def metric_event_tree() -> Tree:
+            """Create tree of PMUs and metricgroups with events or metrics under."""
+            tree: Tree[TreeValue] = Tree("Root", id="root")
+            pmus = tree.root.add("PMUs")
             for pmu in perf.pmus():
                 pmu_name = pmu.name().lower()
-                pmu_node = tree.root.add(pmu_name, data=pmu_name)
+                pmu_node = pmus.add(pmu_name)
                 for event in sorted(pmu.events(), key=lambda x: x["name"]):
                     if "name" in event:
                         e = event["name"].lower()
                         if "alias" in event:
-                            pmu_node.add_leaf(f'{e} ({event["alias"]})', data=e)
+                            pmu_node.add_leaf(f'{e} ({event["alias"]})', data=PmuEvent(pmu_name, e))
                         else:
-                            pmu_node.add_leaf(e, data=e)
+                            pmu_node.add_leaf(e, data=PmuEvent(pmu_name, e))
+            metrics = tree.root.add("Metrics")
+            groups = set()
+            for metric in perf.metrics():
+                groups.update(metric["MetricGroup"])
+
+            def add_metrics_to_tree(node: TreeNode[TreeValue], parent: str):
+                for metric in sorted(perf.metrics(), key=lambda x: x["MetricName"]):
+                    if parent in metric["MetricGroup"]:
+                        name = metric["MetricName"]
+                        node.add_leaf(name, data=Metric(name))
+                        child_group_name = f'{name}_group'
+                        if child_group_name in groups:
+                            add_metrics_to_tree(node.add(child_group_name), child_group_name)
+
+            for group in sorted(groups):
+                if group.endswith('_group'):
+                    continue
+                add_metrics_to_tree(metrics.add(group), group)
+
+            tree.root.expand()
             return tree
 
         yield Header(id="header")
-        yield Horizontal(Vertical(pmu_event_tree(), id="events"),
+        yield Horizontal(Vertical(metric_event_tree(), id="events"),
                          Vertical(Label("event name", id="event_name"),
                                   Static("description", markup=False, id="event_description"),
                                   ))
@@ -371,12 +472,10 @@ class IListApp(App):
 
 
     @on(Tree.NodeSelected)
-    def on_tree_node_selected(self, event: Tree.NodeSelected[str]) -> None:
+    def on_tree_node_selected(self, event: Tree.NodeSelected[TreeValue]) -> None:
         """Called when a tree node is selected, selecting the event."""
-        if event.node.parent and event.node.parent.parent:
-            assert event.node.parent.data is not None
-            assert event.node.data is not None
-            self.set_pmu_and_event(event.node.parent.data, event.node.data)
+        if event.node.data:
+            self.set_selected(event.node.data)
 
 
 if __name__ == "__main__":
-- 
2.50.0.727.gbf7dc18ff4-goog

