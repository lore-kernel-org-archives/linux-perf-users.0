Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36F2276033
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Jul 2025 23:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753313037; cv=none; b=mhWVumj8qo1iCXbkkKpr4dWT0Et3+u4f2AvpwrwYVOJRuY/7teaetToJ7XOyDbJTg5BCniDvExH0OqkBip8jNTLf4/Fl/Nz48Zn3ZqOHwYQsLsV8uoUHItCHf1yBTonGVCO75b54QPtwDXe9eHtgTfCyIVkCUTRacA3PvGgCRLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753313037; c=relaxed/simple;
	bh=0p2VZhsqQDr6Aw2LuSDZ/RNj1w9ofDx+04KMdddf5DA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=a8ycYCp3/Myc/KQQ3o+hfOxqsbO8BG8CC8ujwkvJw5hYHXunblb5/pkVWkhVJDI8nGLKDyLk6oXoDHBlVzEpOXXaTCuXZf6PDzD1q7z7fYaz1CotIt64S1ewOaxalNRbXOszUw6QK95HONcLhEz6vIR0xAL+tlafOI+fmZcpiHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jbAd1ZAq; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jbAd1ZAq"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-74943a7cd9aso654644b3a.3
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Jul 2025 16:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753313035; x=1753917835; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6NNH/8/lvsRr+ontcNP33Y53kfjTOg19B0JPdMFPpCw=;
        b=jbAd1ZAqnV7xcoF64uriKfOWJDZH0WWpi0809lrlGyDtGbbhmbkbGuSMCQzcef/AfY
         MOXMsqtw3eJBwxnVll66qNJyAZW5u2AYHDHPiv2LX/iHx9nr40AEWQLTz7Y0Fl5zBPyG
         8Iq3niGsAKUjq7ZZQYLJLmyHPuXwtUgSQnPiHYpyzy8uYepoBeSaokpKfWW7xrz8KVHJ
         OKB0h876kHQgQ5rgu4ovchI9FVPDCgYvLKRR6jlvFFjKi3Ut2Q/8xkah9mvU0nBC42Cs
         7ryUa/UCvUHTglk3Ror3o7jC7keMeNMy3vdVKVQ7DXYyRa8X6juYfGB9jCDP5Szwy9Fb
         pPZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753313035; x=1753917835;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6NNH/8/lvsRr+ontcNP33Y53kfjTOg19B0JPdMFPpCw=;
        b=kNKFiSrJwtcE5dZ9J8C4+surClfSO+gCo35mQMnh+F75EkK8Fps/lzcjo9GxFAUjB9
         l7i6BkzTw8U5yEpUPqQg2ppP+/n/cs2mpJsEEhDhNBvvqwO1gUtcV41coRPqjP16gn6M
         n9OZCMVlXFNwZV0NBIIXTUdtgHbnJFUccWYErYrTDwO5C0dx7tFSpC68tA3G8V5DCEkC
         kPd6HUsGt7ncPOjhPKlXb19q8nhoH3iApzxtoDA9RD9KWXfzb2dfrMGjgwIwc7DLgwp1
         KAK7PL/WFuVbIu1soA39SalmGBV3Iu2SUUwg/A0SM2Kfsr2XyERO9yxqAMuXeCKzhyam
         RRcw==
X-Forwarded-Encrypted: i=1; AJvYcCU7U4wsINE4MNaQa7R8dblp3FKbITdYyOuu1zPAaPg35O3I4OtkOskrrUg3JXF7GnHtJeGqkCQXagqQ6/bY1fi5@vger.kernel.org
X-Gm-Message-State: AOJu0YzLwWHf9wm2DG53IEMIRZ5AOwz2PadvG67A5DVi4oDS+DPT7j2Z
	D1HHu18ul7IkuJYBETRwTFJIgdtXDeCWlgfZhtBL5yQLvzgu4GdEqk1hGqK993IVjXeHynN5uIo
	hgyd7s5zaVQ==
X-Google-Smtp-Source: AGHT+IE5/7Km/7y6LL7ZC1nZ1dlArFXrF9Rs15E8zp+UuKlziJbybSsz1F41qW+3osOWRyTHFJkvampGYN5J
X-Received: from pfbde7.prod.google.com ([2002:a05:6a00:4687:b0:748:ed01:df48])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2182:b0:736:35d4:f03f
 with SMTP id d2e1a72fcca58-76034c4cbadmr6204564b3a.6.1753313034970; Wed, 23
 Jul 2025 16:23:54 -0700 (PDT)
Date: Wed, 23 Jul 2025 16:22:17 -0700
In-Reply-To: <20250723232217.516179-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250723232217.516179-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250723232217.516179-17-irogers@google.com>
Subject: [PATCH v8 16/16] perf ilist: Add support for metrics
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
---
 tools/perf/python/ilist.py | 232 +++++++++++++++++++++++++++----------
 1 file changed, 170 insertions(+), 62 deletions(-)

diff --git a/tools/perf/python/ilist.py b/tools/perf/python/ilist.py
index b21f4c93247e..8ecd4a9f5034 100755
--- a/tools/perf/python/ilist.py
+++ b/tools/perf/python/ilist.py
@@ -2,18 +2,119 @@
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
 
@@ -123,8 +224,9 @@ class IListApp(App):
     def __init__(self, interval: float) -> None:
         self.interval = interval
         self.evlist = None
-        self.search_results: list[TreeNode[str]] = []
-        self.cur_search_result: TreeNode[str] | None = None
+        self.selected: Optional[TreeValue] = None
+        self.search_results: list[TreeNode[TreeValue]] = []
+        self.cur_search_result: TreeNode[TreeValue] | None = None
         super().__init__()
 
 
@@ -145,7 +247,7 @@ class IListApp(App):
         l = len(self.search_results)
 
         if l < 1:
-            tree: Tree[str] = self.query_one("#pmus", Tree)
+            tree: Tree[TreeValue] = self.query_one("#root", Tree)
             if previous:
                 tree.action_cursor_up()
             else:
@@ -180,15 +282,15 @@ class IListApp(App):
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
@@ -202,7 +304,7 @@ class IListApp(App):
             self.search_results.clear()
             (_ , self.cur_search_result) = find_search_results(event, tree.root)
             if len(self.search_results) < 1:
-                self.push_screen(ErrorScreen(f"Failed to find pmu/event {event}"))
+                self.push_screen(ErrorScreen(f"Failed to find pmu/event or metric {event}"))
                 search_label.display = False
             elif self.cur_search_result:
                 self.expand_and_select(self.cur_search_result)
@@ -223,17 +325,17 @@ class IListApp(App):
 
 
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
@@ -262,8 +364,7 @@ class IListApp(App):
             for cpu in evsel.cpus():
                 aggr = 0
                 for thread in evsel.threads():
-                    counts = evsel.read(cpu, thread)
-                    aggr += counts.val
+                    aggr += self.selected.value(self.evlist, evsel, cpu, thread)
                 update_count(cpu, aggr)
                 total += aggr
         update_count(-1, total)
@@ -276,47 +377,37 @@ class IListApp(App):
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
@@ -324,13 +415,12 @@ class IListApp(App):
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
@@ -345,28 +435,48 @@ class IListApp(App):
 
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
+                                pmu_node.add_leaf(f'{e} ({event["alias"]})', data=PmuEvent(pmu_name, e))
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
@@ -376,12 +486,10 @@ class IListApp(App):
 
 
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

