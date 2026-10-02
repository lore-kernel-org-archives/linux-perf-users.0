Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E9751596A
	for <linux-perf-users@vger.kernel.org>; Fri,  2 Oct 2026 18:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790965626; cv=none; b=MjU+OUFWuICkQ2h5z+fz5X/AwOvV4fI3kwfPCv+7ETibFYf48STkKLStFEC0lePgOKDXqKssoJawOGoVWN0ybWtPbZyRDJ5T+9lc3FCMHSI+HaujrSIL0CAhAAJuxeR6zVcs2SY+a5MR8l2k5tdr0awYvnpxRp/vLzmpepO52Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790965626; c=relaxed/simple;
	bh=iuDDYpDBSEPVIb4dFeh5uhOuxRwHsGwdsT/ifU9bILQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=oC6QwQaxTuh9tyzjm0ylJ4tDHUoulEJAIgtz1M0GDK51y5rJDSNgPQ9t4/9dUOJN04epqhYxvlbFipuA0tnMjJ0NreupndfUiRcmbjD7M48cn9+tCptx1PyLcfYTe9Wa5gHqhdPBE+sNG+6xlmhBjFYYnLxoscR+9la4i6yfaPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p8exbL8a; arc=none smtp.client-ip=74.125.82.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p8exbL8a"
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-30c0d568830so15277110eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 02 Oct 2026 11:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790965621; x=1791570421; darn=vger.kernel.org;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I782X3YfSO2xDpm8QNEd+eDsT+SR5pieWlBzHGlk3Ho=;
        b=p8exbL8aQGZA1/mi5dJa4OAPbJR4cbT22ShcO1HEVwBqGyo8UEpa0HIcxJkt03mIRM
         Uha7rr99TLoAclD6sI4U4gul81lJ0I/w/yodC9WtEgln7UuU2pFnE58W+vMYEN57d353
         MHzrmwntbcyHL5PXMIJP6p4DeK3rB2IdJTVs6iCcuR0DcfLSr0kGI+oWtFsaVZ9FmsDj
         vaoSY2tqz8kHryEgsLIx2bI7sYZieFyYfp5qU4Vz8L+bakErFF/MctDQwQWAZ2Zo2vFP
         poaaOKZ17+GaaG5lrSILvOIq6u/oflXt6Om4OS55NVRwfEfZNfoeM7t8GdBoRMFuCJI/
         QKmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790965621; x=1791570421;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=I782X3YfSO2xDpm8QNEd+eDsT+SR5pieWlBzHGlk3Ho=;
        b=r7urghNCexmQjW1rZIxeiuo56y0JBlhhOB1zDcl5mj4CWNHLC23ypVEawi+cP32RL/
         3IcxmlSL40N1Uf/DKOIiJir1BmqGVkZTkoeLkeg2phLstP6Bh7GtVpHQkrUIJMERPtBh
         pndrpxyEjFGgHQTDhYq1HVRtIDlsaU9pufGX6ukmZPB2svrexatfJtZZZAWsLcLnudXB
         ScFsr0hmK9Hb9rTvAGYnceLO/mx/B2GCz27V/KFs2/SrioHdf0r6LyP2M2ivNmXGca2x
         O2jAq2lQY4kDeJuPybJMt77+jcZmTsfjZj1HoV+McMQ5l07sq5BFt8434oH4pccPJ1b0
         65ag==
X-Forwarded-Encrypted: i=1; AKwUvBzyulXWmMudIg5PgE49SsHqWS9OimYvxxm4MHRu+E0yYu0wJDcd4R8RCIKNoKsUL0Z9DOh8+nCusEGXu+KDfFP0@vger.kernel.org
X-Gm-Message-State: AFuF++kPXBulyJE7YFaZQB5/15XSplBLjovEKdv7WUo3QblkSSMODTIN
	xx8CQ4voVdyngHuVmQL2rxYsUdTlnlZAglcGwJb27fLzO0NsiFyK7gcpZIF5EWmhOIusFklo/A3
	GTaZeJ5RKmQ==
X-Received: from dlbox14.prod.google.com ([2002:a05:7022:120e:b0:14e:d2ac:d8e4])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:3717:b0:144:c128:4c4d
 with SMTP id a92af1059eb24-14f5cbd42e7mr3759146c88.38.1790965618551; Fri, 02
 Oct 2026 11:26:58 -0700 (PDT)
Date: Fri,  2 Oct 2026 11:26:17 -0700
In-Reply-To: <20261002182624.3259797-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261002182624.3259797-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261002182624.3259797-9-irogers@google.com>
Subject: [PATCH v1 08/13] perf treport: Show the profile while it loads
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Thomas Falcon <thomas.falcon@intel.com>, 
	Alice Rogers <alice.mei.rogers@gmail.com>, Changbin Du <changbin.du@huawei.com>, 
	Tengda Wu <wutengda@huaweicloud.com>, tanze <tanze@kylinos.cn>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Alice Rogers <alice.mei.rogers@gmail.com>

Reading a large perf.data file caused a long stall before the treport
app started. Start the app immediately and build the profile in a
background thread, showing the report tree and flame graph as they are
built with the progress in the header. The time between updates grows
with the load time as updating the views costs more as the profile
grows. A lock guards the profile shared between the threads. Quitting
while loading cancels the load.

Tree nodes are now created lazily as they are expanded, expanded nodes
and the cursor are kept across updates, and events are kept in the order
they are first seen as their values aren't comparable. Node names are
escaped so they aren't interpreted as markup.

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Alice Rogers <alice.mei.rogers@gmail.com>
Co-developed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/python/treport.py | 458 ++++++++++++++++++++++++++---------
 1 file changed, 350 insertions(+), 108 deletions(-)

diff --git a/tools/perf/python/treport.py b/tools/perf/python/treport.py
index 0921b428b1aa..e02121475370 100755
--- a/tools/perf/python/treport.py
+++ b/tools/perf/python/treport.py
@@ -2,14 +2,17 @@
 # SPDX-License-Identifier: MIT
 """treport.py - perf report like tool written using textual."""
 from abc import ABC, abstractmethod
-from typing import Dict, Optional
+from typing import Callable, Dict, List, Optional, Set
 import argparse
 import os
 import sys
+import threading
+import time
 import perf
+from rich.markup import escape
 from rich.segment import Segment
 from rich.style import Style
-from textual import events
+from textual import events, work
 from textual.app import App, ComposeResult
 from textual.binding import Binding
 from textual.color import Color
@@ -18,9 +21,6 @@ from textual.strip import Strip
 from textual.widgets import Footer, Header, TabbedContent, TabPane, Tree
 from textual.widgets.tree import TreeNode
 
-# Global session.
-session :Optional[perf.session] = None
-
 def make_fixed_length_string(s: str, length: int, pad_char=' '):
     """Make the string s a fixed length.
 
@@ -61,7 +61,7 @@ class ProfileNode:
         children (Dict[str, ProfileNode]): A dictionary of child nodes, keyed by
                                            their names.
     """
-    def __init__(self, name: str, parent: "ProfileNode"):
+    def __init__(self, name: str, parent: Optional["ProfileNode"]):
         """Initializes a ProfileNode."""
         self.name = name
         self.value: int = 0
@@ -82,20 +82,13 @@ class ProfileNode:
             return 1
         return max(child.depth() for child in self.children.values()) + 1
 
-    def process_event(self, sample) -> None:
+    def process_event(self, sample, comm: str) -> None:
         """Processes a single profiling event to update the call stack tree.
 
         Args:
             sample: a single profiling sample.
+            comm: the command name of the sampled thread.
         """
-        pid = sample.sample_pid
-        try:
-            assert session
-            thread = session.find_thread(pid, sample.sample_tid)
-            comm = (thread.comm() if thread else None) or f"unknown ({pid})"
-        except (OSError, ValueError, KeyError, RuntimeError, TypeError, AttributeError):
-            comm = f"unknown ({pid})"
-
         period = sample.sample_period
         self.value += period
 
@@ -120,47 +113,36 @@ class ProfileNode:
             node = node.find_or_create_node(name)
             node.value += period
 
-    def add_to_tree(self, node: TreeNode, root_value: int) -> None:
-        """Recursively adds this node and its children to a textual TreeNode.
+    def sorted_children(self) -> List["ProfileNode"]:
+        """The children, largest value first.
 
-        Args:
-            node (TreeNode): The textual `TreeNode` object to which this
-                             ProfileNode should be added.
-            root_value (int): Value at the root of the tree.
+        The root's children are events whose values aren't comparable, each is
+        100% of itself, so they are kept in the order they were first seen
+        rather than reordering as they load.
         """
-        if root_value == 0:
-            root_value = self.value
+        if self.parent is self:
+            return list(self.children.values())
+        return sorted(self.children.values(), key=lambda pnode: pnode.value, reverse=True)
 
-        # Calculate the percentage for the node, highlighting the
-        # percentage with reversed colors.
-        if root_value != 0:
-            percent = self.value / root_value * 100
-            label = f"{self.name} [r]{percent:.3g}%[/]"
-        else:
-            label = self.name
-
-        # Add a standalone leaf.
-        if not self.children:
-            node.add_leaf(label)
-            return
+    def tree_label(self, root_value: int) -> str:
+        """Label for the node in a Tree, with a percentage of root_value.
 
-        # Recursively add children.
-        new_node = node.add(label)
-        for pnode in sorted(self.children.values(),
-                            key=lambda pnode: pnode.value, reverse=True):
-            pnode.add_to_tree(new_node, root_value)
+        The percentage is highlighted with reversed colors.
+        """
+        if root_value == 0:
+            return escape(self.name)
+        return f"{escape(self.name)} [r]{self.value / root_value * 100:.3g}%[/]"
 
     def largest_child(self) -> "ProfileNode":
         """Finds the child with the highest value (sample count)."""
         if self.children:
-            return max(self.children.values(), key=lambda node: node.value)
+            return self.sorted_children()[0]
         return self
 
     def child_after(self, sought: "ProfileNode") -> "ProfileNode":
         """Finds the next sibling after the given node, sorted by value."""
         found = False
-        for child in sorted(self.children.values(), key=lambda node: node.value,
-                            reverse=True):
+        for child in self.sorted_children():
             if child == sought:
                 found = True
             elif found:
@@ -170,8 +152,7 @@ class ProfileNode:
     def child_before(self, sought: "ProfileNode") -> "ProfileNode":
         """Finds the previous sibling before the given node, sorted by value."""
         last = None
-        for child in sorted(self.children.values(), key=lambda node: node.value,
-                            reverse=True):
+        for child in self.sorted_children():
             if child == sought:
                 return last if last else sought
             last = child
@@ -226,8 +207,7 @@ class ProfileNode:
         # left_over is used to check for a gap after the children due
         # to samples being in the parent.
         left_over = parent_width
-        for child in sorted(self.children.values(), key=lambda node: node.value,
-                            reverse=True):
+        for child in self.sorted_children():
             if parent_selected:
                 if self.value:
                     desired_width = int((parent_width * child.value) / self.value)
@@ -412,16 +392,22 @@ class FlameGraph(ScrollView):
     }
     """
 
-    def __init__(self, root: ProfileNode, *pos_args, **kwargs):
-        """Initialize the FlameGraph widget."""
+    def __init__(self, root: ProfileNode, lock: threading.Lock, *pos_args, **kwargs):
+        """Initialize the FlameGraph widget.
+
+        The lock must be held when reading the profile as it may be being built
+        in another thread.
+        """
         super().__init__(*pos_args, **kwargs)
         self.root = root
+        self.profile_lock = lock
         self.cursor = root
         self.selected = root
 
     def action_move_down(self) -> None:
         """Handle key press down."""
-        self.cursor = self.cursor.largest_child()
+        with self.profile_lock:
+            self.cursor = self.cursor.largest_child()
         self.refresh()
 
     def action_move_up(self) -> None:
@@ -432,12 +418,14 @@ class FlameGraph(ScrollView):
 
     def action_move_right(self) -> None:
         """Handle key press right."""
-        self.cursor = self.cursor.parent.child_after(self.cursor)
+        with self.profile_lock:
+            self.cursor = self.cursor.parent.child_after(self.cursor)
         self.refresh()
 
     def action_move_left(self) -> None:
         """Handle key press left."""
-        self.cursor = self.cursor.parent.child_before(self.cursor)
+        with self.profile_lock:
+            self.cursor = self.cursor.parent.child_before(self.cursor)
         self.refresh()
 
     def action_zoom_in(self) -> None:
@@ -454,24 +442,148 @@ class FlameGraph(ScrollView):
         """Render a single line (row) of the flame graph."""
         _, scroll_y = self.scroll_offset
         y += scroll_y
-        return self.root.make_flame_strip(y, self.size.width, self.cursor,
-                                          self.selected, self.app.theme_variables)
+        with self.profile_lock:
+            return self.root.make_flame_strip(y, self.size.width, self.cursor,
+                                              self.selected, self.app.theme_variables)
+
+    def profile_changed(self) -> None:
+        """Resize and redraw after the profile changed."""
+        with self.profile_lock:
+            self.styles.height = self.root.depth()
+        self.refresh()
 
     def on_mount(self) -> None:
         """Set the height of the widget when it is displayed."""
-        self.styles.height = self.root.depth()
+        self.profile_changed()
 
     def on_click(self, click: events.Click) -> None:
         """Handles a mouse click and update the cursor position."""
         _, scroll_y = self.scroll_offset
         y = scroll_y + click.y
-        clicked_node = self.root.find_node(click.x, y, self.size.width,
-                                           self.selected)
+        with self.profile_lock:
+            clicked_node = self.root.find_node(click.x, y, self.size.width,
+                                               self.selected)
         if clicked_node:
             self.cursor = clicked_node
             self.refresh()
 
 
+class ProfileTree(Tree):
+    """A tree view of the profile that can be updated while it is built.
+
+    Tree nodes are created lazily when expanded, the data of each tree node is
+    its ProfileNode. The lock must be held when reading the profile.
+    """
+
+    def __init__(self, root: ProfileNode, lock: threading.Lock, *pos_args, **kwargs):
+        super().__init__("Profile", *pos_args, **kwargs)
+        self.profile = root
+        self.profile_lock = lock
+        # Events whose initial expansion has been done.
+        self.seen_events: Set[str] = set()
+
+    def pnode_of(self, tnode: TreeNode) -> ProfileNode:
+        """The ProfileNode shown by tnode, the tree's root shows the profile's root."""
+        return tnode.data if tnode.data is not None else self.profile
+
+    def event_value(self, pnode: ProfileNode) -> int:
+        """Value of the event containing pnode, percentages are relative to it."""
+        while pnode.parent is not self.profile and pnode.parent is not pnode:
+            pnode = pnode.parent
+        return pnode.value
+
+    @staticmethod
+    def expanded_descendants(tnode: TreeNode, expanded: Set[ProfileNode]) -> None:
+        """Add the profile nodes of the expanded descendants of tnode to expanded."""
+        for tchild in tnode.children:
+            if tchild.is_expanded and tchild.data is not None:
+                expanded.add(tchild.data)
+            if tchild.children:
+                ProfileTree.expanded_descendants(tchild, expanded)
+
+    def sync_node(self, tnode: TreeNode, expanded: Optional[Set[ProfileNode]] = None) -> None:
+        """Update the children of tnode, and expanded descendants, from the profile.
+
+        expanded holds the profile nodes of descendants that were expanded
+        before an ancestor's children were recreated. The lock must be held.
+        """
+        children = self.pnode_of(tnode).sorted_children()
+        if expanded is not None or [tchild.data for tchild in tnode.children] != children:
+            # Recreate the children in the new order keeping the expanded
+            # ones, and their expanded descendants.
+            if expanded is None:
+                expanded = set()
+            self.expanded_descendants(tnode, expanded)
+            tnode.remove_children()
+            ancestors: Set[ProfileNode] = set()
+            for pnode in expanded:
+                parent = pnode.parent
+                while parent is not None and parent not in ancestors:
+                    ancestors.add(parent)
+                    parent = parent.parent
+            for child in children:
+                label = child.tree_label(self.event_value(child))
+                new = tnode.add(label, child, allow_expand=bool(child.children))
+                if child in expanded:
+                    new.expand()
+                if child in expanded or child in ancestors:
+                    self.sync_node(new, expanded)
+            return
+        for tchild in tnode.children:
+            child = self.pnode_of(tchild)
+            tchild.set_label(child.tree_label(self.event_value(child)))
+            tchild.allow_expand = bool(child.children)
+            if tchild.is_expanded or tchild.children:
+                self.sync_node(tchild)
+
+    def expand_largest(self, tnode: TreeNode) -> None:
+        """Expand the chain of largest children below tnode.
+
+        The lock must be held.
+        """
+        while self.pnode_of(tnode).children:
+            self.sync_node(tnode)
+            tnode = tnode.children[0]
+            tnode.expand()
+
+    def find(self, tnode: TreeNode, pnode: ProfileNode) -> Optional[TreeNode]:
+        """Find the visible tree node for pnode."""
+        for tchild in tnode.children:
+            if tchild.data is pnode:
+                return tchild
+            if tchild.is_expanded:
+                found = self.find(tchild, pnode)
+                if found:
+                    return found
+        return None
+
+    def sync(self) -> None:
+        """Update the tree from the profile keeping the expanded nodes and cursor."""
+        cursor = self.cursor_node.data if self.cursor_node else None
+        with self.profile_lock:
+            self.root.expand()
+            self.sync_node(self.root)
+            for tnode in self.root.children:
+                name = self.pnode_of(tnode).name
+                if name in self.seen_events:
+                    continue
+                self.seen_events.add(name)
+                self.expand_largest(tnode)
+                # If there is only one event, expand it also.
+                if len(self.root.children) == 1:
+                    tnode.expand()
+        if cursor is not None:
+            found = self.find(self.root, cursor)
+            if found:
+                self.move_cursor(found)
+
+    def on_tree_node_expanded(self, event: Tree.NodeExpanded) -> None:
+        """Create the children of a node when it is expanded."""
+        if event.node is not self.root:
+            with self.profile_lock:
+                self.sync_node(event.node)
+
+
 class ReportApp(App):
     """A Textual application to display profiling data."""
 
@@ -481,84 +593,214 @@ class ReportApp(App):
                 tooltip="Quit the app"),
     ]
 
-    def __init__(self, root: ProfileNode):
-        """Initialize the application."""
-        super().__init__()
-        self.root = root
+    def __init__(self, input_file: str, root: Optional[ProfileNode] = None):
+        """Initialize the application.
 
-    def make_report_tree(self) -> Tree:
-        """Make a Tree widget from the profile data."""
-        tree: Tree[None] = Tree("Profile")
-        # Add events to tree skipping the root.
-        for pnode in sorted(self.root.children.values(),
-                            key=lambda node: node.value, reverse=True):
-            pnode.add_to_tree(tree.root, root_value=0)
-
-        # Expand the root tree (shows all events) and the largest of the children
-        # for each event.
-        def expand_first_child(tnode: TreeNode) -> None:
-            """Recursively expand the first child node"""
-            if not tnode.children:
-                return
-            first = tnode.children[0]
-            first.expand()
-            expand_first_child(first)
-        tree.root.expand()
-        for tnode in tree.root.children:
-            expand_first_child(tnode)
-
-        # If there is only one event, expand it also.
-        if len(tree.root.children) == 1:
-            tree.root.children[0].expand()
-
-        return tree
+        If root isn't given the profile is loaded from input_file in the
+        background after the application starts, the views show the profile
+        as it is built.
+        """
+        super().__init__()
+        self.input_file = input_file
+        self.root = root if root else ProfileNode("root", parent=None)
+        self.loaded = root is not None
+        # Held when reading or changing the profile, which is built in a
+        # background thread.
+        self.profile_lock = threading.Lock()
+        # The profile being built in a background thread.
+        self.loading: Optional[ProfileBuilder] = None
 
     def compose(self) -> ComposeResult:
         """Composes the user interface of the application."""
         yield Header()
         with TabbedContent(initial="report"):
             with TabPane("Report", id="report"):
-                yield self.make_report_tree()
+                yield ProfileTree(self.root, self.profile_lock)
             with TabPane("Flame Graph", id="flame"):
-                yield FlameGraph(self.root)
+                yield FlameGraph(self.root, self.profile_lock)
         yield Footer()
 
+    def on_mount(self) -> None:
+        """Start loading the profile unless it was given."""
+        self.sub_title = self.input_file
+        if self.loaded:
+            self.update_views()
+        else:
+            self.sub_title = f"Loading {self.input_file}"
+            self.loading = ProfileBuilder(self.root, self.profile_lock)
+            self.load_profile()
+
+    def update_views(self) -> None:
+        """Show the latest state of the profile."""
+        self.query_one(ProfileTree).sync()
+        self.query_one(FlameGraph).profile_changed()
+
+    @work(thread=True, exclusive=True)
+    def load_profile(self) -> None:
+        """Build the profile in a thread so the UI stays responsive."""
+        profile = self.loading
+        assert profile is not None
+
+        def progress() -> None:
+            try:
+                self.call_from_thread(self.update_progress, profile)
+            except RuntimeError:
+                # The app is no longer running.
+                profile.cancelled = True
+
+        profile.progress = progress
+        try:
+            profile.read(self.input_file)
+        except LoadCancelled:
+            return
+        except (OSError, ValueError, RuntimeError) as e:
+            self.call_from_thread(self.exit, None, 1,
+                                  f"Error processing {self.input_file}: {e}")
+            return
+        finally:
+            profile.progress = None
+            self.loading = None
+        if not profile.cancelled:
+            self.call_from_thread(self.profile_loaded, profile)
+
+    def update_progress(self, profile: "ProfileBuilder") -> None:
+        """Show how much of the file has been processed and the profile so far."""
+        self.sub_title = (f"Loading {self.input_file}: {profile.nr_samples:,} samples"
+                          f"{profile.duration_str()}")
+        self.update_views()
+
+    def profile_loaded(self, profile: "ProfileBuilder") -> None:
+        """Called on the UI thread when loading completes."""
+        self.loaded = True
+        self.sub_title = (f"{self.input_file}: {profile.nr_samples:,} samples"
+                          f"{profile.duration_str()}")
+        self.update_views()
+
+    def cancel_loading(self) -> None:
+        """Stop a background load, noticed at the next progress interval."""
+        loading = self.loading
+        if loading is not None:
+            loading.cancelled = True
+
+    async def action_quit(self) -> None:
+        """Quit, stopping any background load."""
+        self.cancel_loading()
+        await super().action_quit()
+
+    def on_unmount(self) -> None:
+        """Stop any background load when the app exits."""
+        self.cancel_loading()
+
+
+class LoadCancelled(Exception):
+    """Raised from the sample callback to stop processing events early."""
+
 
 class ProfileBuilder:
     """Constructs a profile tree from a stream of events."""
-    def __init__(self):
-        self.root = ProfileNode("root", parent=None)
+    # Number of samples between checks for cancellation and progress.
+    PROGRESS_INTERVAL = 1000
+    # Minimum and maximum time between calls to the progress callback.
+    PROGRESS_SECONDS = 1.0
+    PROGRESS_MAX_SECONDS = 10.0
+    # Updating the views costs more as the profile grows, so the time between
+    # progress calls grows as this fraction of the time spent loading. This
+    # bounds the fraction of the load time spent updating the views.
+    PROGRESS_FRACTION = 0.25
+
+    def __init__(self, root: Optional[ProfileNode] = None,
+                 lock: Optional[threading.Lock] = None) -> None:
+        """Build into root, holding lock when changing it."""
+        self.root = root if root else ProfileNode("root", parent=None)
+        self.profile_lock = lock if lock else threading.Lock()
+        self.session: Optional[perf.session] = None
+        self.nr_samples = 0
+        self.first_time = 0
+        self.last_time = 0
+        # Set, possibly from another thread, to stop processing events.
+        self.cancelled = False
+        # Called periodically, see PROGRESS_FRACTION, while processing events.
+        self.progress: Optional[Callable[[], None]] = None
+        self.start_progress = time.monotonic()
+        self.last_progress = self.start_progress
+
+    def duration_str(self) -> str:
+        """Description of the time covered by the processed samples."""
+        if not self.last_time:
+            return ""
+        return f", {(self.last_time - self.first_time) / 1e9:.3f}s of trace"
+
+    def comm(self, sample) -> str:
+        """The command name of the thread of the sample."""
+        pid = sample.sample_pid
+        try:
+            assert self.session
+            thread = self.session.find_thread(pid, sample.sample_tid)
+            return (thread.comm() if thread else None) or f"unknown ({pid})"
+        except (OSError, ValueError, KeyError, RuntimeError, TypeError, AttributeError,
+                AssertionError):
+            return f"unknown ({pid})"
 
     def process_event(self, sample) -> None:
         """Called by session.process_events to update the profile tree."""
+        self.nr_samples += 1
+        if self.nr_samples % self.PROGRESS_INTERVAL == 0:
+            if self.cancelled:
+                raise LoadCancelled()
+            now = time.monotonic()
+            interval = min(max(self.PROGRESS_SECONDS,
+                               (now - self.start_progress) * self.PROGRESS_FRACTION),
+                           self.PROGRESS_MAX_SECONDS)
+            if self.progress and now - self.last_progress >= interval:
+                # Must not hold the lock as the callback may read the profile.
+                self.progress()
+                # Time from when the callback, that may block, returns.
+                self.last_progress = time.monotonic()
+        sample_time = sample.sample_time
+        if sample_time:
+            if not self.first_time or sample_time < self.first_time:
+                self.first_time = sample_time
+            self.last_time = max(self.last_time, sample_time)
         ev_name = str(sample.evsel)[6:-1]
-        ev_root = self.root.find_or_create_node(ev_name)
-        ev_root.process_event(sample)
+        comm = self.comm(sample)
+        with self.profile_lock:
+            ev_root = self.root.find_or_create_node(ev_name)
+            ev_root.process_event(sample, comm)
+
+    def read(self, input_file: str) -> None:
+        """Process the events in input_file, raising on errors."""
+        if self.cancelled:
+            raise LoadCancelled()
+        self.start_progress = self.last_progress = time.monotonic()
+        try:
+            self.session = perf.session(perf.data(input_file), sample=self.process_event)
+            self.session.process_events()
+        finally:
+            # Break the reference cycle between the session and the callback.
+            self.session = None
 
-if __name__ == "__main__":
+
+def main() -> None:
+    """Parse arguments and run the app."""
     parser = argparse.ArgumentParser(
         description="TUI report and flame graph using perf python module.")
     parser.add_argument("-i", "--input", help="input perf.data file")
     args = parser.parse_args()
 
     input_file = args.input or "perf.data"
+    if input_file == "-":
+        # The interactive UI reads the keyboard from stdin.
+        print("Error: reading perf.data from stdin isn't supported.", file=sys.stderr)
+        sys.exit(1)
     if not os.path.exists(input_file):
         print(f"Error: {input_file} not found. (try 'perf record' first)", file=sys.stderr)
         sys.exit(1)
 
-    profile = ProfileBuilder()
-    try:
-        session = perf.session(perf.data(input_file), sample=profile.process_event)
-    except (OSError, ValueError, RuntimeError) as e:
-        print(f"Error opening session: {e}", file=sys.stderr)
-        sys.exit(1)
+    # The app starts immediately and builds the profile in the background.
+    app = ReportApp(input_file)
+    app.run()
+    sys.exit(app.return_code or 0)
 
-    # profile.process_event is called for each perf event to build the profile.
-    try:
-        session.process_events()
-    finally:
-        session = None
 
-    # Visualize data.
-    app = ReportApp(profile.root)
-    app.run()
+if __name__ == "__main__":
+    main()
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

