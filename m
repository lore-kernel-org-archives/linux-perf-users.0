Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F8027EFFB
	for <linux-perf-users@vger.kernel.org>; Tue, 19 Aug 2025 01:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755567640; cv=none; b=VghkuHBXgqxOb7BC48r2DnKajPxV+5D3fMteTcqOqUYDsIWYYAN/zHYtHZTkn+QJzHKTK0ewwLU8vGH0OAVhPDXuYif8lhDEePMTMSkYuO5MeFVFJgjvEEycjO1f75SMFSGBbzAa7TfG1co2dtZtoITMZnlcKnUHTKnOgT2cJ0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755567640; c=relaxed/simple;
	bh=t4wvV9vwekMMrq2ydrKd6eNCnUoW4JbMeNG6gK6G9V4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NB9t3EiE9D89W0rVoW3v166CbLIKikfYtzjQdhuvz9Dm8YiaoYf3Pfi3uWMu2qMXxyjmunWtSyBvxFFxzQIKW2wa4EFF7qBlTOI6oQg/pXOoh7BOB9yZMEnCBue3VRHcKQiaU+z/Wdp1lgLSopLQ8VBC//oeqISToUCi4lvHRw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RGvcmBAM; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RGvcmBAM"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e94dfe01f8aso1013691276.0
        for <linux-perf-users@vger.kernel.org>; Mon, 18 Aug 2025 18:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755567638; x=1756172438; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Hl7AyxzldYvZFRTRgIoYqh+Kx2ZHoiUBsCMLQEtAIgk=;
        b=RGvcmBAMXK9TmiBdMjkygLXxvEZEG7Arx9tAw06Pec4jXYFa22m7n3XZtrSFHZC3pa
         WbnnpvUcmslLtwudz7/sc2665fFMah7I+tFtyHWyh4sR5jLUYrJ2rEIIzVBm2SfixeZF
         ysWMzzVRXkgA21d/k9G2gJiuJh/LYBWLHkYBfydLoiGIwsCaTyRenjIoLDDDd1SxCZB9
         B9SY2GMxuKWvIvJFsTt8ixTU50Vk9ZtCtmAM8GPdq2ITpeariSz4yhS7VTTPHMriHqa2
         dwRbdj7IUt/G5wH2DRRgfg8F70kLExS5i4rMUf3a8mLctq2OB6CtPccxhKWIj9c+BehX
         FjgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755567638; x=1756172438;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hl7AyxzldYvZFRTRgIoYqh+Kx2ZHoiUBsCMLQEtAIgk=;
        b=eEvtMH4umWx9lwgBQLNr0qygNsKfhMYzYytHY2js1HIf2gTJqhFEBvs+mrwk4jXsHV
         /51czbhum3Jm9i8dQKKQYNnV1byB4+e70ZPlhO/SmCBPVHTu+PAY0BIz+xQQcG/XkLG+
         NxbQC5EKNLr8fT8g7qkbH6mCI79XrNuslrSGRATF+ff6/DpbKpmliYxDn/u3PAki7u3z
         nzTsNYFFWk+7ksCZSmMQQuexFBOLmRQAUwt8wIAsjRdp3unBmj7BPmOxWHcegyiPHZjU
         jI2tUtYYcTWM5eL9b1ufgpp+6NWIdu+gJInL6FE09p2FMAtlb+QR8wQ+Qnb/Xrmq3vSi
         8xvw==
X-Forwarded-Encrypted: i=1; AJvYcCXU6ezNGUPXfPXAzGLB0N5og+2MtElo1lSO2YZmsTAqI10OYTt2Z04swtuyG8NmMEFrrckWP88ZeWZi/WBojYdh@vger.kernel.org
X-Gm-Message-State: AOJu0YxlwhKxKpxANpqe7voLRK3CFJWvtXUn6j5XcdEG5jRqxWaAHbyt
	bAjpMstl3KZ9GRyfbrUEVlXywtDzqrg9dDclz55cb7jad5gFtGt3o8rIiyXLRvs2ernRDOO95K7
	lQhi5GzV5Rg==
X-Google-Smtp-Source: AGHT+IGEy55mHjNSF8FticXDHLMT32LWX3I+ztnRk8dOjCjooAEx0eIdkQYy3vXz2DfomggqMRHv/JGZtMkA
X-Received: from ybbei5.prod.google.com ([2002:a05:6902:1b85:b0:e93:76f:4c57])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6902:4086:b0:e8f:eb74:24b7
 with SMTP id 3f1490d57ef6-e94e63b6330mr1225466276.49.1755567637753; Mon, 18
 Aug 2025 18:40:37 -0700 (PDT)
Date: Mon, 18 Aug 2025 18:39:40 -0700
In-Reply-To: <20250819013941.209033-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250819013941.209033-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.rc1.167.g924127e9c0-goog
Message-ID: <20250819013941.209033-11-irogers@google.com>
Subject: [PATCH v10 10/11] perf ilist: Add support for metrics
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
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Change tree nodes to having a value of either Metric or PmuEvent,
these values have the ability to match searches, be parsed to create
evlists and to give a value per CPU and per thread to display.  Use
perf.metrics to generate a tree of metrics. Most metrics are placed
under their metric group, if the metric group name ends with '_group'
then the metric group is placed next to the associated metric.

Signed-off-by: Ian Rogers <irogers@google.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Reviewed-by: Howard Chu <howardchu95@gmail.com>
---
 tools/perf/python/ilist.py | 226 +++++++++++++++++++++++++++----------
 1 file changed, 168 insertions(+), 58 deletions(-)

diff --git a/tools/perf/python/ilist.py b/tools/perf/python/ilist.py
index 22c70a8b31f3..9d6465c60df3 100755
--- a/tools/perf/python/ilist.py
+++ b/tools/perf/python/ilist.py
@@ -2,19 +2,121 @@
 # SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
 """Interactive perf list."""
 
+from abc import ABC, abstractmethod
 import argparse
+from dataclasses import dataclass
+import math
 from typing import Any, Dict, Optional, Tuple
 import perf
 from textual import on
 from textual.app import App, ComposeResult
 from textual.binding import Binding
 from textual.containers import Horizontal, HorizontalGroup, Vertical, VerticalScroll
+from textual.css.query import NoMatches
 from textual.command import SearchIcon
 from textual.screen import ModalScreen
 from textual.widgets import Button, Footer, Header, Input, Label, Sparkline, Static, Tree
 from textual.widgets.tree import TreeNode
 
 
+def get_info(info: Dict[str, str], key: str):
+    return (info[key] + "\n") if key in info else ""
+
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
 
@@ -126,8 +228,9 @@ class IListApp(App):
     def __init__(self, interval: float) -> None:
         self.interval = interval
         self.evlist = None
-        self.search_results: list[TreeNode[str]] = []
-        self.cur_search_result: TreeNode[str] | None = None
+        self.selected: Optional[TreeValue] = None
+        self.search_results: list[TreeNode[TreeValue]] = []
+        self.cur_search_result: TreeNode[TreeValue] | None = None
         super().__init__()
 
     def expand_and_select(self, node: TreeNode[Any]) -> None:
@@ -145,7 +248,7 @@ class IListApp(App):
         l = len(self.search_results)
 
         if l < 1:
-            tree: Tree[str] = self.query_one("#pmus", Tree)
+            tree: Tree[TreeValue] = self.query_one("#root", Tree)
             if previous:
                 tree.action_cursor_up()
             else:
@@ -180,7 +283,7 @@ class IListApp(App):
             event = event.lower()
             search_label.update(f'Searching for events matching "{event}"')
 
-            tree: Tree[str] = self.query_one("#pmus", Tree)
+            tree: Tree[str] = self.query_one("#root", Tree)
 
             def find_search_results(event: str, node: TreeNode[str],
                                     cursor_seen: bool = False,
@@ -189,7 +292,7 @@ class IListApp(App):
                 """Find nodes that match the search remembering the one after the cursor."""
                 if not cursor_seen and node == tree.cursor_node:
                     cursor_seen = True
-                if node.data and event in node.data:
+                if node.data and node.data.matches(event):
                     if cursor_seen and not match_after_cursor:
                         match_after_cursor = node
                     self.search_results.append(node)
@@ -203,7 +306,7 @@ class IListApp(App):
             self.search_results.clear()
             (_, self.cur_search_result) = find_search_results(event, tree.root)
             if len(self.search_results) < 1:
-                self.push_screen(ErrorScreen(f"Failed to find pmu/event {event}"))
+                self.push_screen(ErrorScreen(f"Failed to find pmu/event or metric {event}"))
                 search_label.display = False
             elif self.cur_search_result:
                 self.expand_and_select(self.cur_search_result)
@@ -221,16 +324,16 @@ class IListApp(App):
         self.set_searched_tree_node(previous=True)
 
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
@@ -259,8 +362,7 @@ class IListApp(App):
             for cpu in evsel.cpus():
                 aggr = 0
                 for thread in evsel.threads():
-                    counts = evsel.read(cpu, thread)
-                    aggr += counts.val
+                    aggr += self.selected.value(self.evlist, evsel, cpu, thread)
                 update_count(cpu, aggr)
                 total += aggr
         update_count(-1, total)
@@ -271,47 +373,37 @@ class IListApp(App):
         self.update_counts()
         self.set_interval(self.interval, self.update_counts)
 
-    def set_pmu_and_event(self, pmu: str, event: str) -> None:
+    def set_selected(self, value: TreeValue) -> None:
         """Updates the event/description and starts the counters."""
+        try:
+            label_name = self.query_one("#event_name", Label)
+            event_description = self.query_one("#event_description", Static)
+            lines = self.query_one("#lines")
+        except NoMatches:
+            # A race with rendering, ignore the update as we can't
+            # mount the assumed output widgets.
+            return
+
+        self.selected = value
+
         # Remove previous event information.
         if self.evlist:
             self.evlist.disable()
             self.evlist.close()
-            lines = self.query(CounterSparkline)
-            for line in lines:
-                line.remove()
-            lines = self.query(Counter)
-            for line in lines:
+            old_lines = self.query(CounterSparkline)
+            for line in old_lines:
                 line.remove()
+            old_counters = self.query(Counter)
+            for counter in old_counters:
+                counter.remove()
 
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
+        label_name.update(value.name())
+        event_description.update(value.description())
 
         # Open the event.
         try:
-            self.evlist = perf.parse_events(full_name)
+            self.evlist = value.parse()
             if self.evlist:
                 self.evlist.open()
                 self.evlist.enable()
@@ -319,13 +411,12 @@ class IListApp(App):
             self.evlist = None
 
         if not self.evlist:
-            self.push_screen(ErrorScreen(f"Failed to open {full_name}"))
+            self.push_screen(ErrorScreen(f"Failed to open {value.name()}"))
             return
 
         # Add spark lines for all the CPUs. Note, must be done after
         # open so that the evlist CPUs have been computed by propagate
         # maps.
-        lines = self.query_one("#lines")
         line = CounterSparkline(cpu=-1)
         lines.mount(line)
         for cpu in self.evlist.all_cpus():
@@ -339,28 +430,49 @@ class IListApp(App):
 
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
                 try:
                     for event in sorted(pmu.events(), key=lambda x: x["name"]):
                         if "name" in event:
                             e = event["name"].lower()
                             if "alias" in event:
-                                pmu_node.add_leaf(f'{e} ({event["alias"]})', data=e)
+                                pmu_node.add_leaf(f'{e} ({event["alias"]})',
+                                                  data=PmuEvent(pmu_name, e))
                             else:
-                                pmu_node.add_leaf(e, data=e)
+                                pmu_node.add_leaf(e, data=PmuEvent(pmu_name, e))
                 except:
                     # Reading events may fail with EPERM, ignore.
                     pass
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
@@ -369,12 +481,10 @@ class IListApp(App):
         yield Footer(id="footer")
 
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
2.51.0.rc1.167.g924127e9c0-goog

