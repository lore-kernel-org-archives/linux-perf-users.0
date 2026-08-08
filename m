Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B83F3B7B68
	for <linux-perf-users@vger.kernel.org>; Sat,  8 Aug 2026 06:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786172298; cv=none; b=YqAFiTzJBLEkLc1kcozmNQoHg+n5HWnG6Kat/8apJRx/XOSYD5Rc8G6Iw/kpWwlQ4+k1njdcZVOAYhA+2ZOc+osu6NzhMWTdUndOLsV87WarPx6Hc5yo79J3NhOrlXTa7fQuOaSsnxnx2jTwN8vMSKid/lTZqdoHp/daKCC5dPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786172298; c=relaxed/simple;
	bh=Idt8NmIuUIy7tPFYKkQFAkEzHFw9b8eb4M5a5N2Rj1I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YSnDc8t6ExXkhY5HfGBYwomsfet+LAkXEnJpoCxr3ntg4k+xvZk/vOe6jKw9j/KW2lO2xhhqf3TRtov6o+gFgNWpTr9kI5u5R+WC9Gg5JH9WovJVOjqlLiNIH0aeTxVEaEmcdZl0/5f4F2s4MlqH5TcLcqUSbCyuTUFP90QiGLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R6LzI8BA; arc=none smtp.client-ip=209.85.215.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R6LzI8BA"
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cb6dd278512so175327a12.3
        for <linux-perf-users@vger.kernel.org>; Fri, 07 Aug 2026 23:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786172296; x=1786777096; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HYJfMhFNXaChNBwsEcgVTZFTRQI29cwW+i9eZ/5mbLM=;
        b=R6LzI8BAaFN5pMHEPk0MUQQezIfzXpDVup1dS26rGbCSxMgRT+hra+2p2nWoucmmjK
         1WmbE49g9/vAkUp6B7VE2nWiAKznA3ILXSzrUFdiRZeH5EtR/tqczYGOBvYiEvv3XOaX
         qTx8lxV20AcGaUtC03AnLpkuzRKRvtS4v1Wal1Jg1SAq3LiJm6SUDaoABo5hISN+z3zz
         3dTQjbRkL1vtN0GqrHtFDcDbzTtAftpMbhaOox3ckUzPTiAiBx5AYvyygUI7xIIydLyh
         kcVnbAZSo9JLZhEXMPHVlN3Sap1iWwGCnjxbbI72qzXxU1kjwX84QJmejzt9GOFT5CX6
         qutA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786172296; x=1786777096;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HYJfMhFNXaChNBwsEcgVTZFTRQI29cwW+i9eZ/5mbLM=;
        b=czgDV42dagO067DfLjcC0kzHn0zy0g68WMNppEX9zI6ai9XTahJ4kMDjCc6oeyIVRu
         Lyt15B4bIcLd5Jip3pAtPkCmN3yRwj617cCKWBkP195BD3Kn+X9Eb5gJFgMx+gt9Q8pY
         tNL4bqu+5Y9AxEAQFaR53mFL6ehTgKSE4SCfLNVTl3YY0+MEwS+rUDyzdXdgKKA42r6b
         WVhXQo8dIkyNeJjQssT6/JTeI3d+5wwA0XVVXFDng04Sq/0zBBLtXZDG0zBPxS1rZpf0
         yV9wy42yXGLCmqF73y3wm60rSsV6X+Q1anO3IdtXdOsEoF4EIywIO4o6ge+nqmMGStPT
         lyTw==
X-Forwarded-Encrypted: i=1; AHgh+RpIEYMbQw/baAXeYGg/YvfeFbSPZt6jcfG5flZP+Q5kJ7aaP0X+HdiB1LLmtkugffExB5Tw+rsJAwDGJU4/2TQh@vger.kernel.org
X-Gm-Message-State: AOJu0YzRfMIwJdur8p/2HzopbssaeSUstl9AE5+iDhQikyFWtA0w26aR
	0sT1oai/6PXyHVZDblzp5dnRZTOIRLuktCh56kqCFplcYx8aqauGiXiwm3skka5J3Tx7KMcmwHI
	ktj03NEzL8w==
X-Received: from dyke19.prod.google.com ([2002:a05:7300:4713:b0:30f:1e22:c0ee])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:3ca5:b0:3c3:a31b:3949
 with SMTP id adf61e73a8af0-3cbadaf4a67mr17941069637.11.1786172295562; Fri, 07
 Aug 2026 23:58:15 -0700 (PDT)
Date: Fri,  7 Aug 2026 23:57:41 -0700
In-Reply-To: <20260808065743.2328212-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAP-5=fU=z8kcY4zjezoxSwYf9vczYzHztiMSBvJxdwwBPVWv2Q@mail.gmail.com>
 <20260808065743.2328212-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.654.g21b8a5bc05-goog
Message-ID: <20260808065743.2328212-2-irogers@google.com>
Subject: [PATCH v2 1/2] perf python: New treport script
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

With perf script treport:
```
$ perf record -e cycles:u -g perf test -w brstack
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.008 MB perf.data (57 samples) ]
$ perf script tools/perf/scripts/python/treport.py
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
index 000000000000..528a640e4d35
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
+    parser =3D argparse.ArgumentParser(description=3D"Create flame graphs =
using perf python module.")
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
+    # profle.process_event is called for each perf event to build the prof=
ile.
+    session.process_events()
+
+    # Visualize data.
+    app =3D ReportApp(profile.root)
+    app.run()
--=20
2.55.0.654.g21b8a5bc05-goog

