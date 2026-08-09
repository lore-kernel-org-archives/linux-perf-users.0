Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEEB538DC66
	for <linux-perf-users@vger.kernel.org>; Sun,  9 Aug 2026 05:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786252708; cv=none; b=hblrznrCD5kmIwrpK4hhByb2yUGyCER6jvEW+JRseOYoJtWU/Hl9LznTGl6jiVFIbjWcSqG9tNQ6eefWc5BXCZ2FwRm0wUyucdfjH/0rCl29xLYBmHztR/xmQD7aft8B1IiVd4bjbacyquq6t5KxgcJPwYmtaUYWcPmlOfy/5ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786252708; c=relaxed/simple;
	bh=cB/Ee2CPJOLT8BzqucrjIUxTPNHq7zvXTAln082REis=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pC0ExMNpM107d75N/lyzWexpUo9Ozmj7HTjAfdsUM05tXP5eBtVSdQqqza+lsz4IWlye60j/eqwFnX2eV6iQ5ECwZc9BWl3/hccMFW6LdXCNAiaOZXPzMGPWCmyW0B86QZYHP2FTlwejZ6mKjwiA4aNf4WP0ggmEik2r1ujHWhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NF52ONwh; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NF52ONwh"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2cc640dfde3so11503435ad.1
        for <linux-perf-users@vger.kernel.org>; Sat, 08 Aug 2026 22:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786252706; x=1786857506; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wDdrpzVPlZPTXmEKpVgqlFgbaNYSa80YG48sAkfYj4c=;
        b=NF52ONwhO0ZSUv96VRLIhIMosCFJXzjKHO4ZtDx//HJUqdBxXFVaT27tekb4UiDXSm
         kDymURLhW2QPZHYN758HVL9EoknIp0FsuIaODWQpco9HkEDsad7aHCc/TvAVO5w/mH9+
         eTwpl7PaS4JVy+CI+8T6B3MN/ilBl5sfkyrFuRgGeNRFIs0HdVH77kd90YizDFsgfEHR
         CA4j3PxxncTrjwgETrjzU9ncg/DWw0iDhC7t2WxQHqayCWH5YZA/zSUYRnLZB6JuDR7v
         LGTJAa6ChS+nCHq3IS9UcBMKlmyiHVJ2NZIf0GF76OyfXI/ipdDAt80wBmTm1BrKJWX9
         nKig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786252706; x=1786857506;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wDdrpzVPlZPTXmEKpVgqlFgbaNYSa80YG48sAkfYj4c=;
        b=QCNisUyAtru3Q068g/vl9BZ8hb9bgtV/GWJSBkSkSQqVLBfx9XcspA3nWdXWapaxDP
         5MyGAyGpST+ZwCPR8hmb1JJ9QqeoLYB0koWow/FZfPo31P6R7FhIEjM3pxp5CXzF0iDF
         C0kZoTxOBhvv2QcenrMkHeSPLKsu/PbV9CEHsOkqUYwJD2z3qwq/ZMABZ+RPM/xz7htl
         UC4P3PqxucOP3dcl7TI9/ITTaVQKE4drhnKGdIr3TKUdzT4mo/8QKoRejPG29uUNhFGG
         unfF1+bKo54xc1tHBvEVFvUNZxrzQQ8nlMmAglSg2AXrQCMj2yTcAXWVDje+wBe9MvwU
         Ktsg==
X-Forwarded-Encrypted: i=1; AHgh+RovzkyVEICfiCanJf6BVVB7qP89DZXxAy9Ldz+qXVpkmBBzpllIQY6mBuWdns2hW53/vAxVyKrfeIiz+2dL4MK6@vger.kernel.org
X-Gm-Message-State: AOJu0YyU5uasbtmnyHCrzxjN3VeQJa1paQ9c6C5C9X1+A63+6zbdekqW
	rnMxSMJHl5pvXEiTlGI5x0MHN1OPaZgj26FvRMcsau+8i6CS+y7umik8E1YVf+DHaTXauNoHVz1
	8ugr9EHLvGg==
X-Received: from dlbts18-n2.prod.google.com ([2002:a05:7022:b052:20b0:140:f2bb:6f2b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6f17:b0:3c3:a20f:f720
 with SMTP id adf61e73a8af0-3cbcea2fed2mr14640535637.36.1786252705852; Sat, 08
 Aug 2026 22:18:25 -0700 (PDT)
Date: Sat,  8 Aug 2026 22:18:18 -0700
In-Reply-To: <20260809051820.2436530-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260809041638.2402705-1-irogers@google.com> <20260809051820.2436530-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.654.g21b8a5bc05-goog
Message-ID: <20260809051820.2436530-2-irogers@google.com>
Subject: [PATCH v4 1/2] perf python: New treport script
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, alice.mei.rogers@gmail.com, 
	namhyung@kernel.org
Cc: adrian.hunter@intel.com, jolsa@kernel.org, laixintaoo@gmail.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

From: Alice Rogers <alice.mei.rogers@gmail.com>

A textual app that displays the results of processing samples similar
to perf report. The app displays a tree of first processes and then
functions which drop down to show more detail on the functions they
call. The functions with the largest number of samples are sorted
first, after each function the percentage of time spent within it is
highlighted. If more than one event is recorded then each event
appears first, with the processes and functions sorted for that event
beneath it.

The app is written in python and requires the textual framework. Using
the textual framework means that in most modern terminals the mouse is
supported, the color scheme can be configured, and screenshots made.

With perf report:
```
$ perf record -e cycles:u -g perf test -w brstack
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.008 MB perf.data (57 samples) ]
$ perf report
...
Samples: 57  of event 'cycles:u', Event count (approx.): 15907831
  Children      Self  Command  Shared Object         Symbol
-   88.86%     0.00%  perf     libc.so.6             [.] 0x000079b17df69ca8
     0x79b17df69ca8
     main
     handle_internal_command
     cmd_test
   - brstack
      - 84.27% brstack_bench
         - 40.69% brstack_foo
              brstack_bar
           3.32% brstack_bar
        3.31% brstack_bar
        1.27% brstack_foo
+   88.86%     0.00%  perf     perf                  [.] main
+   88.86%     0.00%  perf     perf                  [.] handle_internal_co=
mmand
+   88.86%     0.00%  perf     perf                  [.] cmd_test
+   88.86%     0.00%  perf     perf                  [.] brstack
+   84.27%    40.26%  perf     perf                  [.] brstack_bench
+   41.96%    30.71%  perf     perf                  [.] brstack_foo
+   17.89%    17.89%  perf     perf                  [.] brstack_bar
```

With the treport script:
```
$ perf record -e cycles:u -g perf test -w brstack
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.008 MB perf.data (57 samples) ]
$ tools/perf/python/treport.py
 O                       ReportApp
 Report
=E2=95=B8=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=95=BA=E2=
=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=
=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=
=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=
=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=
=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=
=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=
=94=81=E2=94=81=E2=94=81=E2=94=81
=E2=96=BC Profile
=E2=94=94=E2=94=80=E2=94=80 =E2=96=BC cycles:u 100%
    =E2=94=94=E2=94=80=E2=94=80 =E2=96=BC perf (32963) 100%
        =E2=94=9C=E2=94=80=E2=94=80 =E2=96=BC /usr/lib/x86_64-linux-gnu/lib=
c.so.6 0x79b17df6
        =E2=94=82   =E2=94=94=E2=94=80=E2=94=80 =E2=96=BC main 56.1%
        =E2=94=82       =E2=94=94=E2=94=80=E2=94=80 =E2=96=BC handle_intern=
al_command 56.1%
        =E2=94=82           =E2=94=94=E2=94=80=E2=94=80 =E2=96=BC cmd_test =
56.1%
        =E2=94=82               =E2=94=94=E2=94=80=E2=94=80 =E2=96=BC brsta=
ck 56.1%                 =E2=96=81=E2=96=81
        =E2=94=82                   =E2=94=9C=E2=94=80=E2=94=80 =E2=96=BC b=
rstack_bench 52.6%
        =E2=94=82                   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80=
 =E2=96=B6 brstack_foo 24.6%
        =E2=94=82                   =E2=94=82   =E2=94=94=E2=94=80=E2=94=80=
 brstack_bar 1.75%
        =E2=94=82                   =E2=94=9C=E2=94=80=E2=94=80 brstack_foo=
 1.75%
        =E2=94=82                   =E2=94=94=E2=94=80=E2=94=80 brstack_bar=
 1.75%
        =E2=94=9C=E2=94=80=E2=94=80 =E2=96=B6 /usr/lib/x86_64-linux-gnu/ld-=
linux-x86-64.so.2
                                            =E2=96=8C
^q Quit                                          =E2=96=8F^p palette
```

Co-developed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Ian Rogers <irogers@google.com>
Signed-off-by: Alice Rogers <alice.mei.rogers@gmail.com>
---
 tools/perf/python/treport.py | 207 +++++++++++++++++++++++++++++++++++
 1 file changed, 207 insertions(+)
 create mode 100755 tools/perf/python/treport.py

diff --git a/tools/perf/python/treport.py b/tools/perf/python/treport.py
new file mode 100755
index 000000000000..71a91775bd6a
--- /dev/null
+++ b/tools/perf/python/treport.py
@@ -0,0 +1,207 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: MIT
+"""treport.py - perf report like tool written using textual."""
+from typing import Dict, Optional
+import argparse
+import os
+import sys
+import perf
+from textual.app import App, ComposeResult
+from textual.binding import Binding
+from textual.widgets import Footer, Header, TabbedContent, TabPane, Tree
+from textual.widgets.tree import TreeNode
+
+# Global session.
+session :Optional[perf.session] =3D None
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
+        value (int): The sample count for this node including counts from =
its
+                     children.
+        parent (ProfileNode): The parent of this node, this node belongs t=
o its
+                              children.
+        children (Dict[str, ProfileNode]): A dictionary of child nodes, ke=
yed by
+                                           their names.
+    """
+    def __init__(self, name: str, parent: "ProfileNode"):
+        """Initializes a ProfileNode."""
+        self.name =3D name
+        self.value: int =3D 0
+        self.parent =3D parent if parent else self
+        self.children: Dict[str, ProfileNode] =3D {}
+
+    def find_or_create_node(self, name: str) -> "ProfileNode":
+        """Finds a child node by name or creates it if it doesn't exist.""=
"
+        if name in self.children:
+            return self.children[name]
+        child =3D ProfileNode(name, self)
+        self.children[name] =3D child
+        return child
+
+    def depth(self) -> int:
+        """The maximum depth of the call stack tree from this node down.""=
"
+        if not self.children:
+            return 1
+        return max(child.depth() for child in self.children.values()) + 1
+
+    def process_event(self, sample) -> None:
+        """Processes a single profiling event to update the call stack tre=
e.
+
+        Args:
+            sample: a single profiling sample.
+        """
+        pid =3D sample.sample_pid
+        try:
+            assert session
+            thread =3D session.find_thread(sample.sample_tid)
+            comm =3D thread.comm()
+        except Exception:
+            comm =3D f"unknown ({pid})"
+
+        period =3D sample.sample_period
+        self.value +=3D period
+
+        node =3D self.find_or_create_node(comm)
+        node.value +=3D period
+
+        if sample.callchain:
+            for entry in reversed(sample.callchain):
+                name =3D entry.symbol
+                if not name or name =3D=3D "[unknown]":
+                    name =3D entry.dso or "unknown"
+                    if entry.ip:
+                        name +=3D f" 0x{entry.ip:x}"
+                node =3D node.find_or_create_node(name)
+                node.value +=3D period
+        else:
+            name =3D sample.symbol
+            if not name or name =3D=3D "[unknown]":
+                name =3D sample.dso or "unknown"
+                if sample.sample_ip:
+                    name +=3D f" 0x{sample.sample_ip:x}"
+            node =3D node.find_or_create_node(name)
+            node.value +=3D period
+
+    def add_to_tree(self, node: TreeNode, root_value: int) -> None:
+        """Recursively adds this node and its children to a textual TreeNo=
de.
+
+        Args:
+            node (TreeNode): The textual `TreeNode` object to which this
+                             ProfileNode should be added.
+            root_value (int): Value at the root of the tree.
+        """
+        if root_value =3D=3D 0:
+            root_value =3D self.value
+
+        # Calculate the percentage for the node, highlighting the
+        # percentage with reversed colors.
+        if root_value !=3D 0:
+            percent =3D self.value / root_value * 100
+            label =3D f"{self.name} [r]{percent:.3g}%[/]"
+        else:
+            label =3D self.name
+
+        # Add a standalone leaf.
+        if not self.children:
+            node.add_leaf(label)
+            return
+
+        # Recursively add children.
+        new_node =3D node.add(label)
+        for pnode in sorted(self.children.values(),
+                            key=3Dlambda pnode: pnode.value, reverse=3DTru=
e):
+            pnode.add_to_tree(new_node, root_value)
+
+
+class ReportApp(App):
+    """A Textual application to display profiling data."""
+
+    # The ^q binding is implied but having it here adds it in the Footer.
+    BINDINGS =3D [
+        Binding(key=3D"^q", action=3D"quit", description=3D"Quit",
+                tooltip=3D"Quit the app"),
+    ]
+
+    def __init__(self, root: ProfileNode):
+        """Initialize the application."""
+        super().__init__()
+        self.root =3D root
+
+    def make_report_tree(self) -> Tree:
+        """Make a Tree widget from the profile data."""
+        tree: Tree[None] =3D Tree("Profile")
+        # Add events to tree skipping the root.
+        for pnode in sorted(self.root.children.values(),
+                            key=3Dlambda node: node.value, reverse=3DTrue)=
:
+            pnode.add_to_tree(tree.root, root_value=3D0)
+
+        # Expand the root tree (shows all events) and the largest of the c=
hildren
+        # for each event.
+        def expand_first_child(tnode: TreeNode) -> None:
+            """Recursively expand the first child node"""
+            if not tnode.children:
+                return
+            first =3D tnode.children[0]
+            first.expand()
+            expand_first_child(first)
+        tree.root.expand()
+        for tnode in tree.root.children:
+            expand_first_child(tnode)
+
+        # If there is only one event, expand it also.
+        if len(tree.root.children) =3D=3D 1:
+            tree.root.children[0].expand()
+
+        return tree
+
+    def compose(self) -> ComposeResult:
+        """Composes the user interface of the application."""
+        yield Header()
+        with TabbedContent(initial=3D"report"):
+            with TabPane("Report", id=3D"report"):
+                yield self.make_report_tree()
+        yield Footer()
+
+
+class ProfileBuilder:
+    """Constructs a profile tree from a stream of events."""
+    def __init__(self):
+        self.root =3D ProfileNode("root", parent=3DNone)
+
+    def process_event(self, sample) -> None:
+        """Called by session.process_events to update the profile tree."""
+        ev_name =3D str(sample.evsel)[6:-1]
+        ev_root =3D self.root.find_or_create_node(ev_name)
+        ev_root.process_event(sample)
+
+if __name__ =3D=3D "__main__":
+    parser =3D argparse.ArgumentParser(description=3D"TUI report using per=
f python module.")
+    parser.add_argument("-i", "--input", help=3D"input perf.data file")
+    args =3D parser.parse_args()
+
+    input_file =3D args.input or "perf.data"
+    if not os.path.exists(input_file):
+        print(f"Error: {input_file} not found. (try 'perf record' first)",=
 file=3Dsys.stderr)
+        sys.exit(1)
+
+    profile =3D ProfileBuilder()
+    try:
+        session =3D perf.session(perf.data(input_file), sample=3Dprofile.p=
rocess_event)
+    except Exception as e:
+        print(f"Error opening session: {e}", file=3Dsys.stderr)
+        sys.exit(1)
+
+    # profile.process_event is called for each perf event to build the pro=
file.
+    session.process_events()
+
+    # Visualize data.
+    app =3D ReportApp(profile.root)
+    app.run()
--=20
2.55.0.654.g21b8a5bc05-goog

