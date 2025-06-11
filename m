Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6772A23373B
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Jun 2025 03:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749613604; cv=none; b=kUatzm/44Nd8bQBJ8eSpUNqJWvNPJeKsRx6exUNfEzUSPMdUcZ4GSA6NUG5ORUZBvuM6A6U/Zn2koaFqH3KHnSaeIB92k12MJBXW7ZwEN2l1d1Z8f0eCOvRp5NPVaoIPPfUxZxAUoaCq5sryA2zdJOwqIgmBAt2u322ti3Ph6DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749613604; c=relaxed/simple;
	bh=UhDacTxzGBlAhgf5EQouh306VnId5+8DUuadwaTOx0A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=AYa8eka+dPCQcD0jfoGbTySvKun13GI/Wr2RpNNO7d5q14ZK1UwwSYR/sPCUs4lXWpMubxO2ZxuO4foGv5KR9SPsx6G4kSQshxiB0vbQkZDpexeqGJFZCgRUOwatzlJDTKekEcdx16tUjvFKUY7U9zQYPl91DPltigkGYJ3Kv5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CH+FAVeO; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CH+FAVeO"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7462aff55bfso5177621b3a.2
        for <linux-perf-users@vger.kernel.org>; Tue, 10 Jun 2025 20:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749613602; x=1750218402; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CArExhgG4tSc5pEJvn7VsqeZBJ/Kf/ScNPd3hlaxRoY=;
        b=CH+FAVeONZP17su0CknJKipya8uht6/fk8E3wwlpgQ57JPJYqCh7yuZpLHDahga1e/
         cTynKk0aVbbWA3RWwp/jgZK7JXTrab0zhSEmQ5i0TIbJg4ddsUyzldNEYlP3eusLXRUj
         z53yINcWbpDJkT8H05THA0XOJ6QLp+Sa0BuMeBIHivOtYbDVnjUCYM9esit1+ce35iwY
         055YI1iPG5cLRHwYXAHu4mTBkM9nG4xzEDKuQMoAIhFkK8B+1nSfd1PwSZVZotJBD6fz
         0R53dgtSkgaAZh4ubl9Hfp8L9pAW/EBRXifLej/a4+P99BMRbwhZdqqvwfcIHDunSoq8
         9WDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749613602; x=1750218402;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CArExhgG4tSc5pEJvn7VsqeZBJ/Kf/ScNPd3hlaxRoY=;
        b=TOIzbwgmj1bOm1n88h7vqXA0uJIF4d+2HN9weHnU8r36yg+MEqDtBoWG6uHk+jmg60
         XBepVonTpB9n9iS1yrK2Nsr3Gk+0P7OKCZGROe/zvsXWYoLDQgcUixRk/KVdPGcWsb4p
         4tAYhrpnFzTTmh4pEqZUPMd36wHK9c0ixrL5mpRySv2KVAWqbSshRvHPSnZViTmujsS3
         HZThwPyPkBAkRSSvMY+JVbsZtkrN5VIFJdhT7cDL7+9C70G4XhNqkipqhBh512Z4vP2L
         LC2QKSdwKe8pFuga++s9PNA2G9otFuuDOvqciVGa2YUgTnl3YyuVJ23I4O5H8wFT6+Ue
         A5VQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDWTF+HIqcq/1KeDCepUv7PDuA8V9bixxhaQLEM72Ze1RhYNlEajXjSBkk1j7V8r4jFNzKMSXMnzAkWYz5OTrc@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3Z1RewCE4k2YZxBzYbpBnPNwPOdyFJXxEXeZbA8Bb+obK939k
	khPOt0kLnOgBnA4SBPD6gfQVG4adkdh/Z867gPAWye0yty0ivhVxq4eNmdLjSe8YHbvmFWv6CnY
	4F3HzYx4Jzw==
X-Google-Smtp-Source: AGHT+IFpVKlbNH7GAWFI47IKyzuCwQ0PNTE+1sIzECsvNCmllZ25PK4HNoB/bSehj6l/l4+MwUMzRS8h9HJK
X-Received: from pfbil9.prod.google.com ([2002:a05:6a00:8d49:b0:746:2d8f:cac1])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3a17:b0:742:aecc:c47c
 with SMTP id d2e1a72fcca58-7486cb480damr2717688b3a.7.1749613601704; Tue, 10
 Jun 2025 20:46:41 -0700 (PDT)
Date: Tue, 10 Jun 2025 20:45:29 -0700
In-Reply-To: <20250611034529.508842-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250611034529.508842-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.rc0.642.g800a2b2222-goog
Message-ID: <20250611034529.508842-16-irogers@google.com>
Subject: [PATCH v1 15/15] perf ilist: Add new python ilist command
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

[1] https://textual.textualize.io/

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/python/ilist.py | 238 +++++++++++++++++++++++++++++++++++++
 1 file changed, 238 insertions(+)
 create mode 100644 tools/perf/python/ilist.py

diff --git a/tools/perf/python/ilist.py b/tools/perf/python/ilist.py
new file mode 100644
index 000000000000..30cc70435f7e
--- /dev/null
+++ b/tools/perf/python/ilist.py
@@ -0,0 +1,238 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
+"""Interactive perf list."""
+
+import argparse
+from typing import Dict
+import perf
+from textual import on
+from textual.app import App, ComposeResult
+from textual.binding import Binding
+from textual.containers import Horizontal, HorizontalGroup, Vertical, VerticalScroll
+from textual.screen import ModalScreen
+from textual.widgets import Button, Footer, Header, Label, Sparkline, Static, Tree
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
+        Binding(key="q", action="quit", description="Quit the app")
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
+    def __init__(self, interval: float) -> None:
+        self.interval = interval
+        self.evlist = None
+        super().__init__()
+
+
+    def update_counts(self) -> None:
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
+        def pmu_event_tree() -> Tree:
+            """Create tree of PMUs with events under."""
+            tree: Tree[str] = Tree("PMUs")
+            tree.root.expand()
+            for pmu in perf.pmus():
+                pmu_name = pmu.name()
+                pmu_node = tree.root.add(pmu_name, data=pmu_name)
+                for event in sorted(pmu.events(), key=lambda x: x["name"]):
+                    if "name" in event:
+                        e = event["name"]
+                        if "alias" in event:
+                            pmu_node.add_leaf(f'{e} ({event["alias"]})', data=e)
+                        else:
+                            pmu_node.add_leaf(e, data=e)
+            return tree
+
+        yield Header()
+        yield Horizontal(Vertical(pmu_event_tree(), id="events"),
+                         Vertical(Label("event name", id="event_name"),
+                                  Static("description", markup=False, id="event_description")
+                                  ))
+        yield VerticalScroll(id="lines")
+        yield Footer()
+
+
+    @on(Tree.NodeSelected)
+    def on_tree_node_selected(self, event: Tree.NodeSelected[None]) -> None:
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
2.50.0.rc0.642.g800a2b2222-goog

