Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF56A2066CE
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Jun 2025 05:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750050960; cv=none; b=dCuMc2atsV89OQ2zkjKpVjT7EHDhhXj1SSPBdv9ApCyzL2nMIzbflTH8c+DGrAjuA6M+VOnhh1UaTi2rCkKug3aejjrcS+NRScSE6oL+Mb5pMmbCFknmSGp+wNKvCe0ScfZkfKB5ig/+pCMbk7Oi6kMq2msrdFx0PlE3gNoN21U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750050960; c=relaxed/simple;
	bh=vMpp3wE4YxxlsaW079icYYQfKWfxXZSmzDTouEee0nc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=o0aE0oEhh1XtKj/o/tsJ52jSLJ31+jm9hAkgqytLg1v2KqOM+ezo6vE3JzdOCaUgIwY45wmp16tm+UHp/WKAX64FSBLOpJka+PKK79FQEb/wPTqn2ThPfcmkK0LLkD2DnnymTYpvYcoaRu/OZEyTBVkdU5a7K/nO0zrZGWNHnMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oZhmwjsY; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oZhmwjsY"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-236725af87fso18331695ad.3
        for <linux-perf-users@vger.kernel.org>; Sun, 15 Jun 2025 22:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750050957; x=1750655757; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jEbchuSB875SLepbJuHjmJtYDConDg5qTi58URUH7g4=;
        b=oZhmwjsY/Ro68dNtUlXLE/X8+TxFQNEkf/hCVNQvRup0z3IX7yndHSszVjZNRI5ssS
         N+sh0d+kEgZV9kbc3yYlT2IliWDASANtM2xlr5RDSJf8WTwlDQjQ7xhh67H4Lel9Yb5j
         Iinec5VuPtxew8dzCNl96751/kMy867xT5TO9xLOtmm0yXk6YeG4+NhzHkheeMvRqJf8
         mUigVTodqC70J+n+FZkcIJDeFebU3O9rX/gHkQpkBjUP5aUHLjKKdPQUCUxujSUmrWwu
         naQcXswpxYuZMHSm10ddiMiGYIxna9rlY3ihFg57moR+Z68+FvA1bfLYxY7AsweC89Zg
         F2Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750050957; x=1750655757;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jEbchuSB875SLepbJuHjmJtYDConDg5qTi58URUH7g4=;
        b=LTF3cVPNZAjr5TZcdd/C6yRTDR6zkQNh7welcCrdyXrijXBUDbZPGzF/bdSTjzzztU
         1vdEvSyG03kN3/FkECZhYuXaAo/Frbt5N4cVmpyUP+rVikM4QN7NO0qkAsLfxsfPkQwx
         HHa0MNe9TdJlAWQ2qb3SFUgWq38QOXfUA5cjeDq3obaKuCy6CdXUbvb8vf19ehAjkrAt
         OhdG6ll1/bPVL+gTSaMEkHqt+sZKD+LRpxcTf7k3g5/FQSKbwPtuOpBM7kXJMviT2wOW
         VI9e+D5ce8PWHvwhNCuzVnDwx4AXWaSfYdB14DPWMva+xrUhFF7ITzLTTJ7P4mnDTYK7
         z6ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvJ0zSx5SREQlIe4vmbH4xfm1N7uEaf5gUV2vUDExrpwdclWSkR81KYbSHxIoxd+Hj0UfUnMuqtFACh3nOl5Qu@vger.kernel.org
X-Gm-Message-State: AOJu0YyTU5jKaoN6DxtYGYp4wAFwd9o2iJDShfE3jdoiNXOu+5RVw+lG
	iIBZFZGme9GnQ3hRk1x+MEoz42IW9wid0U/3SHG6U/DXSA8Fluh6jLSQnDB99cOi2/cbKuRqrCQ
	kWj8t3Qaiog==
X-Google-Smtp-Source: AGHT+IHKCKhRh5mvyE2Tcm3j094T49EqOlAYmNKvSEKLlJL9zq3tw4Dyo5ImZMUXVRQbYUKPZvJU7C88do6K
X-Received: from pllk22.prod.google.com ([2002:a17:902:7616:b0:220:eaab:51c4])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:da8c:b0:234:ed31:fcae
 with SMTP id d9443c01a7336-2366b3504b7mr123875505ad.22.1750050957000; Sun, 15
 Jun 2025 22:15:57 -0700 (PDT)
Date: Sun, 15 Jun 2025 22:15:00 -0700
In-Reply-To: <20250616051500.1047173-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250616051500.1047173-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.rc2.696.g1fc2a0284f-goog
Message-ID: <20250616051500.1047173-16-irogers@google.com>
Subject: [PATCH v3 15/15] perf ilist: Add new python ilist command
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, John Garry <john.g.garry@oracle.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Howard Chu <howardchu95@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Andi Kleen <ak@linux.intel.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	Gautam Menghani <gautam@linux.ibm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The perf ilist command is a textual app [1] similar to perf list. In
the top-left pane a tree of PMUs is displayed. Selecting a PMU expands
the events within it. Selecting an event displays the `perf list`
style event information in the top-right pane.

When an event is selected it is opened and the counters on each CPU
the event is for are periodically read. The bottom of the screen
contains a scrollable set of sparklines showing the events in total
and on each CPU. Scrolling below the sparklines shows the same data as
raw counts. The sparklines are small graphs where the height of the
bar is in relation to maximum of the other counts in the graph.

By default the counts are read with an interval of 0.1 seconds (10
times per second). A -I/--interval command line option allows the
interval to be changed. The oldest read counts are dropped when the
counts fill the line causing the sparkline to move from right to left.

A search box can be pulled up with the 's' key. 'n' and 'p' iterate
through the search results. As some PMUs have hundreds of events a 'c'
key will collapse the events in the current PMU to make navigating the
PMUs easier.

[1] https://textual.textualize.io/

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/python/ilist.py | 376 +++++++++++++++++++++++++++++++++++++
 1 file changed, 376 insertions(+)
 create mode 100755 tools/perf/python/ilist.py

diff --git a/tools/perf/python/ilist.py b/tools/perf/python/ilist.py
new file mode 100755
index 000000000000..b986447f8831
--- /dev/null
+++ b/tools/perf/python/ilist.py
@@ -0,0 +1,376 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
+"""Interactive perf list."""
+
+import argparse
+from typing import Any, Dict, Tuple
+import perf
+from textual import on
+from textual.app import App, ComposeResult
+from textual.binding import Binding
+from textual.containers import Horizontal, HorizontalGroup, Vertical, VerticalScroll
+from textual.command import SearchIcon
+from textual.screen import ModalScreen
+from textual.widgets import Button, Footer, Header, Input, Label, Sparkline, Static, Tree
+from textual.widgets.tree import TreeNode
+
+class ErrorScreen(ModalScreen[bool]):
+    """Pop up dialog for errors."""
+
+    CSS="""
+    ErrorScreen {
+        align: center middle;
+    }
+    """
+    def __init__(self, error: str):
+        self.error = error
+        super().__init__()
+
+    def compose(self) -> ComposeResult:
+        yield Button(f"Error: {self.error}", variant="primary", id="error")
+
+    def on_button_pressed(self, event: Button.Pressed) -> None:
+        self.dismiss(True)
+
+
+class SearchScreen(ModalScreen[str]):
+    """Pop up dialog for search."""
+
+    CSS="""
+    SearchScreen Horizontal {
+        align: center middle;
+        margin-top: 1;
+    }
+    SearchScreen Input {
+        width: 1fr;
+    }
+    """
+    def compose(self) -> ComposeResult:
+        yield Horizontal(SearchIcon(), Input(placeholder="Event name"))
+
+    def on_input_submitted(self, event: Input.Submitted) -> None:
+        """Handle the user pressing Enter in the input field."""
+        self.dismiss(event.value)
+
+
+class Counter(HorizontalGroup):
+    """Two labels for a CPU and its counter value."""
+
+    CSS="""
+    Label {
+        gutter: 1;
+    }
+    """
+
+    def __init__(self, cpu: int) -> None:
+        self.cpu = cpu
+        super().__init__()
+
+    def compose(self) -> ComposeResult:
+        label = f"cpu{self.cpu}" if self.cpu >= 0 else "total"
+        yield Label(label + " ")
+        yield Label("0", id=f"counter_{label}")
+
+
+class CounterSparkline(HorizontalGroup):
+    """A Sparkline for a performance counter."""
+
+    def __init__(self, cpu: int) -> None:
+        self.cpu = cpu
+        super().__init__()
+
+    def compose(self) -> ComposeResult:
+        label = f"cpu{self.cpu}" if self.cpu >= 0 else "total"
+        yield Label(label)
+        yield Sparkline([], summary_function=max, id=f"sparkline_{label}")
+
+
+class IListApp(App):
+    TITLE = "Interactive Perf List"
+
+    BINDINGS = [
+        Binding(key="s", action="search", description="Search",
+                tooltip="Search events and PMUs"),
+        Binding(key="n", action="next", description="Next",
+                tooltip="Next search result or item"),
+        Binding(key="p", action="prev", description="Previous",
+                tooltip="Previous search result or item"),
+        Binding(key="q", action="quit", description="Quit the app"),
+        Binding(key="c", action="collapse", description="Collapse",
+                tooltip="Collapse the current PMU"),
+    ]
+
+    # Make the 'total' sparkline a different color.
+    CSS = """
+        #sparkline_total > .sparkline--min-color {
+            color: $accent;
+        }
+        #sparkline_total > .sparkline--max-color {
+            color: $accent 30%;
+        }
+    """
+
+
+    def __init__(self, interval: float) -> None:
+        self.interval = interval
+        self.evlist = None
+        self.search_results: list[TreeNode[str]] = []
+        self.cur_search_result: TreeNode[str] | None = None
+        super().__init__()
+
+
+
+    def expand_and_select(self, node: TreeNode[Any]) -> None:
+        """Expand select a node in the tree."""
+        if node.parent:
+            node.parent.expand()
+            if node.parent.parent:
+                node.parent.parent.expand()
+        node.expand()
+        node.tree.select_node(node)
+        node.tree.scroll_to_node(node)
+
+
+    def set_searched_tree_node(self, previous: bool) -> None:
+        """Set the cur_search_result node to either the next or previous."""
+        l = len(self.search_results)
+
+        if l < 1:
+            tree: Tree[str] = self.query_one("#pmus", Tree)
+            if previous:
+                tree.action_cursor_up()
+            else:
+                tree.action_cursor_down()
+            return
+
+        if self.cur_search_result:
+            idx = self.search_results.index(self.cur_search_result)
+            if previous:
+                idx = idx - 1 if idx > 0 else l - 1
+            else:
+                idx = idx + 1 if idx < l - 1 else 0
+        else:
+            idx = l - 1 if previous else 0
+
+        node = self.search_results[idx]
+        if node == self.cur_search_result:
+            return
+
+        self.cur_search_result = node
+        self.expand_and_select(node)
+
+    def action_search(self) -> None:
+        """Search was chosen."""
+        def set_initial_focus(event: str | None) -> None:
+            """Sets the focus after the SearchScreen is dismissed."""
+            if not event:
+                return
+
+            event = event.lower()
+            self.query_one("#active_search", Label) \
+                .update(f'Searching for events matching "{event}"')
+            tree: Tree[str] = self.query_one("#pmus", Tree)
+            def find_search_results(event: str, node: TreeNode[str], \
+                                    cursor_seen: bool = False, \
+                                    match_after_cursor: TreeNode[str] | None = None) \
+                    -> Tuple[bool, TreeNode[str] | None]:
+                """Find nodes that match the search remembering the one after the cursor."""
+                if not cursor_seen and node == tree.cursor_node:
+                    cursor_seen = True
+                if node.data and event in node.data:
+                    if cursor_seen and not match_after_cursor:
+                        match_after_cursor = node
+                    self.search_results.append(node)
+
+                if node.children:
+                    for child in node.children:
+                        (cursor_seen, match_after_cursor) = \
+                            find_search_results(event, child, cursor_seen, match_after_cursor)
+                return (cursor_seen, match_after_cursor)
+
+            self.search_results.clear()
+            (_ , self.cur_search_result) = find_search_results(event, tree.root)
+            if len(self.search_results) < 1:
+                self.push_screen(ErrorScreen(f"Failed to find pmu/event {event}"))
+            elif self.cur_search_result:
+                self.expand_and_select(self.cur_search_result)
+            else:
+                self.set_searched_tree_node(previous=False)
+
+        self.push_screen(SearchScreen(), set_initial_focus)
+
+
+    def action_next(self) -> None:
+        """Next was chosen."""
+        self.set_searched_tree_node(previous=False)
+
+
+    def action_prev(self) -> None:
+        """Previous was chosen."""
+        self.set_searched_tree_node(previous=True)
+
+
+    def action_collapse(self) -> None:
+        """Collapse the potentially large number of events under a PMU."""
+        tree: Tree[str] = self.query_one("#pmus", Tree)
+        node = tree.cursor_node
+        if node and node.parent and node.parent.parent:
+            node.parent.collapse_all()
+            node.tree.scroll_to_node(node.parent)
+
+
+    def update_counts(self) -> None:
+        """Called every interval to update counts."""
+        if not self.evlist:
+            return
+
+        def update_count(cpu: int, count: int):
+            # Update the raw count display.
+            counter: Label = self.query(f"#counter_cpu{cpu}" if cpu >= 0 else "#counter_total")
+            if not counter:
+                return
+            counter = counter.first(Label)
+            counter.update(str(count))
+
+            # Update the sparkline.
+            line: Sparkline = self.query(f"#sparkline_cpu{cpu}" if cpu >= 0 else "#sparkline_total")
+            if not line:
+                return
+            line = line.first(Sparkline)
+            # If there are more events than the width, remove the front event.
+            if len(line.data) > line.size.width:
+                line.data.pop(0)
+            line.data.append(count)
+            line.mutate_reactive(Sparkline.data)
+
+        # Update the total and each CPU counts, assume there's just 1 evsel.
+        total = 0
+        self.evlist.disable()
+        for evsel in self.evlist:
+            for cpu in evsel.cpus():
+                aggr = 0
+                for thread in evsel.threads():
+                    counts = evsel.read(cpu, thread)
+                    aggr += counts.val
+                update_count(cpu, aggr)
+                total += aggr
+        update_count(-1, total)
+        self.evlist.enable()
+
+
+    def on_mount(self) -> None:
+        """When App starts set up periodic event updating."""
+        self.update_counts()
+        self.set_interval(self.interval, self.update_counts)
+
+
+    def set_pmu_and_event(self, pmu: str, event: str) -> None:
+        """Updates the event/description and starts the counters."""
+        # Remove previous event information.
+        if self.evlist:
+            self.evlist.disable()
+            self.evlist.close()
+            lines = self.query(CounterSparkline)
+            for line in lines:
+                line.remove()
+            lines = self.query(Counter)
+            for line in lines:
+                line.remove()
+
+        def pmu_event_description(pmu: str, event: str) -> str:
+            """Find and format event description for {pmu}/{event}/."""
+            def get_info(info: Dict[str, str], key: str):
+                return (info[key] + "\n") if key in info else ""
+
+            for p in perf.pmus():
+                if p.name() != pmu:
+                    continue
+                for info in p.events():
+                    if "name" not in info or info["name"] != event:
+                        continue
+
+                    desc = get_info(info, "topic")
+                    desc += get_info(info, "event_type_desc")
+                    desc += get_info(info, "desc")
+                    desc += get_info(info, "long_desc")
+                    desc += get_info(info, "encoding_desc")
+                    return desc
+            return "description"
+
+        # Parse event, update event text and description.
+        full_name = event if event.startswith(pmu) or ':' in event else f"{pmu}/{event}/"
+        self.query_one("#event_name", Label).update(full_name)
+        self.query_one("#event_description", Static).update(pmu_event_description(pmu, event))
+
+        # Open the event.
+        try:
+            self.evlist = perf.parse_events(full_name)
+            if self.evlist:
+                self.evlist.open()
+                self.evlist.enable()
+        except:
+            self.evlist = None
+
+        if not self.evlist:
+            self.push_screen(ErrorScreen(f"Failed to open {full_name}"))
+            return
+
+        # Add spark lines for all the CPUs. Note, must be done after
+        # open so that the evlist CPUs have been computed by propagate
+        # maps.
+        lines = self.query_one("#lines")
+        line = CounterSparkline(cpu=-1)
+        lines.mount(line)
+        for cpu in self.evlist.all_cpus():
+            line = CounterSparkline(cpu)
+            lines.mount(line)
+        line = Counter(cpu=-1)
+        lines.mount(line)
+        for cpu in self.evlist.all_cpus():
+            line = Counter(cpu)
+            lines.mount(line)
+
+
+    def compose(self) -> ComposeResult:
+        """Draws the app."""
+        def pmu_event_tree() -> Tree:
+            """Create tree of PMUs with events under."""
+            tree: Tree[str] = Tree("PMUs", id="pmus")
+            tree.root.expand()
+            for pmu in perf.pmus():
+                pmu_name = pmu.name().lower()
+                pmu_node = tree.root.add(pmu_name, data=pmu_name)
+                for event in sorted(pmu.events(), key=lambda x: x["name"]):
+                    if "name" in event:
+                        e = event["name"].lower()
+                        if "alias" in event:
+                            pmu_node.add_leaf(f'{e} ({event["alias"]})', data=e)
+                        else:
+                            pmu_node.add_leaf(e, data=e)
+            return tree
+
+        yield Header(id="header")
+        yield Horizontal(Vertical(pmu_event_tree(), id="events"),
+                         Vertical(Label("event name", id="event_name"),
+                                  Static("description", markup=False, id="event_description"),
+                                  Label(id="active_search")
+                                  ))
+        yield VerticalScroll(id="lines")
+        yield Footer(id="footer")
+
+
+    @on(Tree.NodeSelected)
+    def on_tree_node_selected(self, event: Tree.NodeSelected[str]) -> None:
+        """Called when a tree node is selected, selecting the event."""
+        if event.node.parent and event.node.parent.parent:
+            assert event.node.parent.data is not None
+            assert event.node.data is not None
+            self.set_pmu_and_event(event.node.parent.data, event.node.data)
+
+
+if __name__ == "__main__":
+    ap = argparse.ArgumentParser()
+    ap.add_argument('-I', '--interval', help="Counter update interval in seconds", default=0.1)
+    args = ap.parse_args()
+    app = IListApp(float(args.interval))
+    app.run()
-- 
2.50.0.rc2.696.g1fc2a0284f-goog

