Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A296192D97
	for <linux-perf-users@vger.kernel.org>; Fri, 25 Jul 2025 08:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753431991; cv=none; b=Fk5TFG3m8HVI9ht5iffF3xDSGRs3orikE0sQn/9IrgfREpJH3iyxJ3wX2zho7XEgZsfsyLEZqEmwLRLke+ocjftekKsuZVpKLCSikrh3oFRtKfelkdnirkiEgfSsXm/+I8BiY6QvwZ6vq5YFYnmMPYIgBuTrkRgXz+SqohXYlFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753431991; c=relaxed/simple;
	bh=odhf3rRUfOX5d37KNt5tf95pxR8MiXnCPf2TmRsMBH4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=rP2c1SK5c7KmDpJncgCSRIxFh9oclFwPjS26/AK7jubNejZFPoWc4+7A0ZvvxQEMV6wU+E9/b4MsqiIBgRaMJF3RyjagIh6v4bB78j1R6U/WG42kolMwDHFnK9/AbvWJq7Uy3CtuBci965nNrG596MxfvvP3LeNOdfmlnf+ejWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tpw0aDjG; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tpw0aDjG"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-31e3fdf1906so1851353a91.0
        for <linux-perf-users@vger.kernel.org>; Fri, 25 Jul 2025 01:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753431990; x=1754036790; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IADMlPbUfX5wO6hQ3MTh3Wg0t7hXEhtuY45C12JN0BE=;
        b=tpw0aDjGWIaL2ylcRPUxNnfEW+yAePultzbmTyVgOjtvOyLs/llYklDRKSM2aK7pDE
         bEB7GBGiTlK6e0On0NpKhW7HKNKuUNQe51Acxs1I1n19NCGxfYcNzv1t/A4LTpvRG8mV
         K9bX0C1hqRf/x2QVm/ehyN4HwOlC2xE+SZQs1Ve37P7okBRyi+ydzUmHYQ8zFSIQXlVb
         tbxOpQTL7AZUYiigwnE6AsPkchWMX9bKuE7dSxEXUbVI1xgeUXclIFmlWLGLwyKsdIuU
         O6+YrV8VjewLmS2Cjh52KwkI5OnuFqrOLFHuxHZkrUfo8xb5LS/3vmh0E/tUixEZYFLd
         n4XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753431990; x=1754036790;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IADMlPbUfX5wO6hQ3MTh3Wg0t7hXEhtuY45C12JN0BE=;
        b=gYJyaIdGirVkzHxdOdTOcSXoAjI/BStOI0z1OyPiw0Aa/SdAEqVVz94JZEo47iqcHQ
         wejRVS1QUY9NbiNstkXBJa/2YvgMtD07y/S8fB2wE1mUrXDIw7X+2dE4HbNE4cjbzwDa
         DpFvQQ5lRGo63S8/QdNpG59f4K2MAz3CMIWW+gjpygTkih2YiwkbfyfYJt+MbDT6BDb7
         b3Wa//LNeJhi40G7vl+bvi5lVB+2sgScBQnMRPUpddojDUoYo0OkdEiC4qh5pwsTBLdk
         5MvYnQX995dFX/kfBjgG2zrAjmRtSVixasATQ7btAWO1VsRKXdGVuzu/cMbyVyMsu8ai
         NTyw==
X-Forwarded-Encrypted: i=1; AJvYcCWM6B5H46+f+b9QraC5Pq9hGoisdC1nQD3x5dsOOmn4l/72FkuYjBJFZawsYRsXiHq0bKLygD0AHK6nf0m4PCJ+@vger.kernel.org
X-Gm-Message-State: AOJu0YzohvyYAe+bNxGHmrc6kJe3vuW6tNelUImmwoWSlf7sA8LEJD0E
	d3lEW9sxymQVWEZFKTXVQyz9AVbyVVOECr0UTGnYQWHF2FrjwazL4vLRyhnSzh/ypsjtlS8DZ91
	Tc98BkDCWxg==
X-Google-Smtp-Source: AGHT+IGw1FJe/GrSKtt+0lg7LI1vDU9eduSaKdi/GRDoWHq35E0s1qO9SP9rvw8QX3pqffEC3yprU55Vr8Wh
X-Received: from pjbhl4.prod.google.com ([2002:a17:90b:1344:b0:313:d6cf:4fa0])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:da8f:b0:313:f9fc:7213
 with SMTP id 98e67ed59e1d1-31e778f7864mr1580271a91.21.1753431989595; Fri, 25
 Jul 2025 01:26:29 -0700 (PDT)
Date: Fri, 25 Jul 2025 01:24:04 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
Message-ID: <20250725082425.20999-1-irogers@google.com>
Subject: [PATCH v1 1/2] perf script: New treport script
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Alice Rogers <alice.mei.rogers@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Alice Rogers <alice.mei.rogers@gmail.com>

A textual app that displays the results of processing samples similar
to perf report. The app displays a tree of first processed and then
functions which drop down to show more detail on the functions they
call. The functions with the largest number of samples are sorted
first, after each function the percentage of time spent within it is
highlighted.

Signed-off-by: Alice Rogers <alice.mei.rogers@gmail.com>
Co-developed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/scripts/python/treport.py | 177 +++++++++++++++++++++++++++
 1 file changed, 177 insertions(+)
 create mode 100644 tools/perf/scripts/python/treport.py

diff --git a/tools/perf/scripts/python/treport.py b/tools/perf/scripts/python/treport.py
new file mode 100644
index 000000000000..fd1ca79efdad
--- /dev/null
+++ b/tools/perf/scripts/python/treport.py
@@ -0,0 +1,177 @@
+# treport.py - perf report like tool written using textual
+# SPDX-License-Identifier: MIT
+from textual.app import App, ComposeResult
+from textual.binding import Binding
+from textual.widgets import Footer, Header, TabbedContent, TabPane, Tree
+from textual.widgets.tree import TreeNode
+from typing import Dict
+
+class ProfileNode:
+    """Represents a single node in a call stack tree.
+
+    Generally a ProfileNode corresponds to a symbol in a call stack.
+    The root is special, its children are events and the events
+    children are process names. After the process name come the
+    samples.
+
+    Attributes:
+        name (str): The name of the function, process or event.
+        value (int): The sample count for this node including counts from its
+                     children.
+        parent (ProfileNode): The parent of this node, this node belongs to its
+                              children.
+        children (Dict[str, ProfileNode]): A dictionary of child nodes, keyed by
+                                           their names.
+    """
+    def __init__(self, name: str, parent: "ProfileNode"):
+        """Initializes a ProfileNode."""
+        self.name = name
+        self.value: int = 0
+        self.parent = parent if parent else self
+        self.children: Dict[str, ProfileNode] = {}
+
+    def find_or_create_node(self, name: str) -> "ProfileNode":
+        """Finds a child node by name or creates it if it doesn't exist."""
+        if name in self.children:
+            return self.children[name]
+        child = ProfileNode(name, self)
+        self.children[name] = child
+        return child
+
+    def depth(self) -> int:
+        """The maximum depth of the call stack tree from this node down."""
+        if not self.children:
+            return 1
+        return max([child.depth() for child in self.children.values()]) + 1
+
+    def process_event(self, event: Dict) -> None:
+        """Processes a single profiling event to update the call stack tree.
+
+        Args:
+            event (Dict): A dictionary representing a single profiling sample,
+                          expected to contain keys like 'comm', 'pid', 'period',
+                          and 'callchain'.
+        """
+        pid = 0
+        if "sample" in event and "pid" in event["sample"]:
+            pid = event["sample"]["pid"]
+
+        if pid == 0:
+            comm = event.get("comm", "kernel")
+        else:
+            comm = f"{event.get('comm', 'unknown')} ({pid})"
+
+        period = int(event["period"]) if 'period' in event else 1
+        self.value += period
+
+        node = self.find_or_create_node(comm)
+        node.value += period
+
+        if "callchain" in event:
+            for entry in reversed(event["callchain"]):
+                sym = entry.get("sym")
+                name = None
+                if sym:
+                    name = sym.get("name")
+                if not name:
+                    name = entry.get("dso", "unknown")
+                    if "ip" in entry:
+                        name += f" 0x{entry['ip']:x}"
+                node = node.find_or_create_node(name)
+                node.value += period
+        else:
+            name = event.get("symbol")
+            if not name:
+                name = event.get("dso", "unknown")
+                if "ip" in event:
+                    name += f" 0x{event['ip']:x}"
+            node = node.find_or_create_node(name)
+            node.value += period
+
+    def add_to_tree(self, node: TreeNode, root_value: int) -> None:
+        """Recursively adds this node and its children to a textual TreeNode.
+
+        Args:
+            node (TreeNode): The textual `TreeNode` object to which this
+                             ProfileNode should be added.
+            root_value (int): Value at the root of the tree.
+        """
+        if root_value == 0:
+            root_value = self.value
+
+        # Calculate the percentage for the node, highlighting the
+        # percentage with reversed colors.
+        if root_value != 0:
+            percent = self.value / root_value * 100
+            label = f"{self.name} [r]{percent:.3g}%[/]"
+        else:
+            label = self.name
+
+        # Add a standalone leaf.
+        if not self.children:
+            node.add_leaf(label)
+            return
+
+        # Recursively add children.
+        new_node = node.add(label)
+        for pnode in sorted(self.children.values(),
+                            key=lambda pnode: pnode.value, reverse=True):
+            pnode.add_to_tree(new_node, root_value)
+
+
+class ReportApp(App):
+    """A Textual application to display profiling data."""
+
+    # The ^q binding is implied but having it here adds it in the Footer.
+    BINDINGS = [
+        Binding(key="^q", action="quit", description="Quit",
+                tooltip="Quit the app"),
+    ]
+
+    def __init__(self, root: ProfileNode):
+        """Initialize the application."""
+        super().__init__()
+        self.root = root
+
+    def make_report_tree(self) -> Tree:
+        """Make a Tree widget from the profile data."""
+        tree: Tree[None] = Tree("Profile")
+        # Add events to tree skipping the root.
+        for pnode in sorted(self.root.children.values(),
+                            key=lambda node: node.value, reverse=True):
+            pnode.add_to_tree(tree.root, root_value=0)
+        # Expand the first 2 levels of the tree.
+        tree.root.expand()
+        for tnode in tree.root.children:
+            tnode.expand()
+        return tree
+
+    def compose(self) -> ComposeResult:
+        """Composes the user interface of the application."""
+        yield Header()
+        with TabbedContent(initial="report"):
+            with TabPane("Report", id="report"):
+                yield self.make_report_tree()
+        yield Footer()
+
+
+class ProfileBuilder:
+    """Constructs a profile tree from a stream of events."""
+    def __init__(self):
+        self.root = ProfileNode("root", parent=None)
+
+    def process_event(self, event) -> None:
+        """Called by `perf script` to update the profile tree."""
+        ev_name = event.get("ev_name", "default")
+        ev_root = self.root.find_or_create_node(ev_name)
+        ev_root.process_event(event)
+
+if __name__ == "__main__":
+    # process_event is called for each perf event to build the profile.
+    profile = ProfileBuilder()
+    process_event = profile.process_event
+    # trace_end will run the application, this can't be done
+    # concurrently as perf expects to be the main thread as does
+    # Textual.
+    app = ReportApp(profile.root)
+    trace_end = app.run
-- 
2.50.1.552.g942d659e1b-goog

