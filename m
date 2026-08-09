Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C08B3A5421
	for <linux-perf-users@vger.kernel.org>; Sun,  9 Aug 2026 04:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786249012; cv=none; b=BsK9SM6gYAukauggu3YLUxjHq7TcPvoRznYe18mXNOVijaZ20IF6XJc+mf+4VH9OeezREgbSZKC3hwS+TlXmoPqzzd2/20qcmjPdbVNVLOvBC0NhnewvDfbykXTvPjEUjFGHK9fvq4jjwcXLzGOfwnHSg3p7MadkkWuvIKQlw/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786249012; c=relaxed/simple;
	bh=fNTrAs4+/oo8Kp7OYudlynLf+IYmVqR79aK873HDRQY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DP+e6DSt6xNC9UEZ3Ww331bbLuMBFjVXzVO7CZ9SwZhjTjGjYg0+aoR9doa6W/LbLjT/lM39s6IdtChig2sRjoJPUqMAuiYIrHn+xLP3TyCsPVJp+aSQHsh50tDVZP2FS9a0I640NFhW8yjnQrOQM95CyCZrRbRwmUupU69NQxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=he9IxrP4; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="he9IxrP4"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38e7b87ce77so2459429a91.0
        for <linux-perf-users@vger.kernel.org>; Sat, 08 Aug 2026 21:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786249008; x=1786853808; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bFzlV6LSM12WHSmY/3yZakBMLS5lk8VEiNydzLCcax4=;
        b=he9IxrP4u7BCI3IqanAMx5r02DFi6k1FzG6mVj2p2f++PzbzcKIoJGw0VY2FAMzPsS
         IpwrRCynq5d5MT6kKjbzPbI6qAmVpGBUS3oWDqKW7hCZNSdrqtSWBu8h/2hCaOdy5Tpg
         TuGGVkNvIH8uX1j3J3/mEiGfhTC+GZChJmJvFCyMp0bE9ra+7gN6YczO8Y8OHPVCzlU+
         +vFpkL8Mi3eptr7AEfGFElhQrwvArNlrkz2CoGNM9yTqRS+XrPUPS8mt38DDZ6nrcstt
         JMoi/kavqk12WSgFakqDkfLPFDDuGQrmwv3DOMKXs8VSrANH5fxtN1ITjcn3yZ0dlWo8
         i9SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786249008; x=1786853808;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bFzlV6LSM12WHSmY/3yZakBMLS5lk8VEiNydzLCcax4=;
        b=Js600NN2ZKFIEgvfO8Pg4BxJzsO4B081U5tB2U2RseJJpr0R3ER1+uYQla1uqV153r
         j1PV1yZ05SRC9pAVAbstHG/SrblSNjDRu6dgPPPWTz5spcwt+KwHrVechjFX24Dd+hcb
         2tBDmFlKoRQSYi1+3fwjTvudZ/GfjWz8dSZEbjNl3Zr52ROUlPevXcdXOc+C6BeG0bnX
         yGH65T/oXA9avxDC469OqAv4nuNibJH/PWHyCFSFH71eMCQjIqR/r4NQP/SB2m9ihCmt
         xrvrMPr81WErRvaiWAE6aObss/wXHJZCBxNzxhL8ZMcI0XHOJi1+ZiGbYn904BN3SHWu
         aphA==
X-Forwarded-Encrypted: i=1; AHgh+Ro7ktWLMBDd89P2S+1vOKD2S3HAt/N4USi/LmyGw+9BSLe4nneYZUjNqjXyjA8qvVhwmNFghh5k40aRCJa1x1um@vger.kernel.org
X-Gm-Message-State: AOJu0YxjDgw7EKSkRW7VOOBrZGQzpTYplT7+xXRA7QOFcrOkPbqXSJwI
	sKslLxM8E2PrwgwavP/eyGR9wPeuahbyYaOyzGcZa2Gkpn8mJN4jA36ZeBlC8rx4yuDwaAgfQSr
	Ao7WEO6bFTg==
X-Received: from dleb11-n1.prod.google.com ([2002:a05:701b:424b:10b0:13d:6291:7191])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3b45:b0:38e:4f41:83df
 with SMTP id 98e67ed59e1d1-392621444f0mr14532294a91.15.1786249007264; Sat, 08
 Aug 2026 21:16:47 -0700 (PDT)
Date: Sat,  8 Aug 2026 21:16:34 -0700
In-Reply-To: <20260809041638.2402705-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260808065743.2328212-1-irogers@google.com> <20260809041638.2402705-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.654.g21b8a5bc05-goog
Message-ID: <20260809041638.2402705-4-irogers@google.com>
Subject: [PATCH v3 2/2] perf python: treport add flamegraph support
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, alice.mei.rogers@gmail.com, 
	namhyung@kernel.org
Cc: adrian.hunter@intel.com, jolsa@kernel.org, laixintaoo@gmail.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

From: Alice Rogers <alice.mei.rogers@gmail.com>

Implement a flamegraph widget that recursively walks down a tree
splitting line segments based on their value (summed up periods across
call chains). A visitor pattern is used so that the same logic can
both draw the line segments and locate which segment had a mouse
click.

Add a tab for the flame graph widget.

Co-developed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Ian Rogers <irogers@google.com>
Signed-off-by: Alice Rogers <alice.mei.rogers@gmail.com>
---
 tools/perf/python/treport.py | 353 +++++++++++++++++++++++++++++++++++
 1 file changed, 353 insertions(+)

diff --git a/tools/perf/python/treport.py b/tools/perf/python/treport.py
index 528a640e4d35..ec3263a6b625 100755
--- a/tools/perf/python/treport.py
+++ b/tools/perf/python/treport.py
@@ -1,19 +1,49 @@
 #!/usr/bin/env python3
 # SPDX-License-Identifier: MIT
 """treport.py - perf report like tool written using textual."""
+from abc import ABC, abstractmethod
 from typing import Dict, Optional
 import argparse
 import os
 import sys
 import perf
+from rich.segment import Segment
+from rich.style import Style
+from textual import events
 from textual.app import App, ComposeResult
 from textual.binding import Binding
+from textual.color import Color
+from textual.scroll_view import ScrollView
+from textual.strip import Strip
 from textual.widgets import Footer, Header, TabbedContent, TabPane, Tree
 from textual.widgets.tree import TreeNode
=20
 # Global session.
 session :Optional[perf.session] =3D None
=20
+def make_fixed_length_string(s: str, length: int, pad_char=3D' '):
+    """Make the string s a fixed length.
+
+    Increases or decreases the length of s to be length. If the length is
+    increased then pad_char is inserted on the right.
+    """
+    return s[:length] if len(s) > length else s.ljust(length, pad_char)
+
+
+class FlameVisitor(ABC):
+    """Parent for visitor used by ProfileNode.flame_walk"""
+    @abstractmethod
+    def visit(self, node: Optional["ProfileNode"], width: int) -> None:
+        """Visit a profile node width the specified flame graph width.
+
+        Args:
+            node: The `ProfileNode` for the current segment. This may be `=
None`
+                to represent a gap or an unknown portion of the stack.
+            width: The calculated width of the flame graph rectangle for t=
his
+                node, which is proportional to its sample count.
+        """
+
+
 class ProfileNode:
     """Represents a single node in a call stack tree.
=20
@@ -120,6 +150,327 @@ class ProfileNode:
                             key=3Dlambda pnode: pnode.value, reverse=3DTru=
e):
             pnode.add_to_tree(new_node, root_value)
=20
+    def largest_child(self) -> "ProfileNode":
+        """Finds the child with the highest value (sample count)."""
+        if self.children:
+            return max(self.children.values(), key=3Dlambda node: node.val=
ue)
+        return self
+
+    def child_after(self, sought: "ProfileNode") -> "ProfileNode":
+        """Finds the next sibling after the given node, sorted by value.""=
"
+        found =3D False
+        for child in sorted(self.children.values(), key=3Dlambda node: nod=
e.value,
+                            reverse=3DTrue):
+            if child =3D=3D sought:
+                found =3D True
+            elif found:
+                return child
+        return sought
+
+    def child_before(self, sought: "ProfileNode") -> "ProfileNode":
+        """Finds the previous sibling before the given node, sorted by val=
ue."""
+        last =3D None
+        for child in sorted(self.children.values(), key=3Dlambda node: nod=
e.value,
+                            reverse=3DTrue):
+            if child =3D=3D sought:
+                return last if last else sought
+            last =3D child
+        return sought
+
+    def has_parent(self, parent: "ProfileNode") -> bool:
+        """Checks if the parent node is an ancestor of this node."""
+        p =3D self.parent
+        while True:
+            if p =3D=3D parent:
+                return True
+            new_p =3D p.parent
+            if new_p =3D=3D p:
+                break
+            p =3D new_p
+        return False
+
+    def has_child(self, sought: "ProfileNode") -> bool:
+        """Checks if the sought node is a descendant of this node."""
+        return sought.has_parent(self)
+
+    def flame_walk(self, wanted_strip: int, cur_strip: int, parent_width: =
int,
+                   selected: "ProfileNode", visitor: FlameVisitor) -> None=
:
+        """Recursively walks the tree to visit a single flame graph row.
+
+        This method calculates the proportional width for each child
+        based on its value (sample count) relative to its parent. It
+        then invokes a `visitor` to process each segment of the flame
+        graph row.
+
+        Args:
+            wanted_strip (int): The target depth (Y-axis) of the flame gra=
ph row
+                                to generate.
+            cur_strip (int): The current depth of the traversal.
+            parent_width (int): The width of the parent of this node.
+            selected (ProfileNode): The currently selected node in the UI,=
 used
+                                    to adjust rendering to highlight the
+                                    selected path.
+            visitor (FlameVisitor): A visitor object whose `visit` method =
is
+                                    called for each segment of the flame g=
raph
+                                    row.
+        """
+        if parent_width =3D=3D 0:
+            return
+
+        parent_selected =3D selected =3D=3D self or self.has_parent(select=
ed)
+        child_selected =3D not parent_selected and self.has_child(selected=
)
+        if not parent_selected and not child_selected:
+            # Branches of the tree with no node selected aren't drawn.
+            return
+
+        # left_over is used to check for a gap after the children due
+        # to samples being in the parent.
+        left_over =3D parent_width
+        for child in sorted(self.children.values(), key=3Dlambda node: nod=
e.value,
+                            reverse=3DTrue):
+            if parent_selected:
+                if self.value:
+                    desired_width =3D int((parent_width * child.value) / s=
elf.value)
+                else:
+                    desired_width =3D parent_width // len(self.children)
+                if desired_width =3D=3D 0:
+                    # Nothing can be drawn for this node or later smaller =
children.
+                    break
+            elif child =3D=3D selected or child.has_child(selected):
+                desired_width =3D parent_width
+            else:
+                # A sibling or its child are selected, but not this branch=
.
+                continue
+
+            # Either visit the wanted_strip or recurse to the next level.
+            if wanted_strip =3D=3D cur_strip:
+                visitor.visit(child, desired_width)
+            else:
+                child.flame_walk(wanted_strip, cur_strip + 1, desired_widt=
h,
+                                 selected, visitor)
+            left_over -=3D desired_width
+            if left_over =3D=3D 0:
+                # No space left to draw in.
+                break
+
+        # Always visit the left_over regardless of the wanted_strip as the=
re
+        # may be additional gap added to a line by a parent.
+        if left_over:
+            visitor.visit(None, left_over)
+
+    def make_flame_strip(self, wanted_strip: int, parent_width: int,
+                         cursor: "ProfileNode", selected: "ProfileNode",
+                         theme_variables: Dict[str, str]) -> Strip:
+        """Creates a renderable 'Strip' for a single row of a flame graph.
+
+        This method orchestrates the `flame_walk` traversal with a special=
ized
+        visitor to generate a list of segments. The segments are used by a=
`Strip`
+        object for rendering in the terminal.
+
+        Args:
+            wanted_strip (int): The target depth (Y-axis) of the flame gra=
ph row.
+            parent_width (int): The total width (in characters) of the dis=
play
+                                area.
+            cursor (ProfileNode): The node currently under the cursor, for
+                                  highlighting.
+            selected (ProfileNode): The node that is actively selected.
+            theme_variables(Dict): Values of colors for the textual theme.
+
+        Returns:
+            Strip: A renderable strip of segments for the specified row.
+        """
+        primary =3D Color.parse(theme_variables["primary"])
+        secondary =3D Color.parse(theme_variables["secondary"])
+        surface =3D Color.parse(theme_variables["surface"])
+        def luminance(color: Color) -> float:
+            """Computes the luminance of a color from the rgb"""
+            return color.r * 0.299 + color.g * 0.587 + color.b * 0.114
+
+        # Set of styles for different flamegraph segments, the styles are
+        # cycled through to provide contrast.
+        normal_styles =3D []
+        for x in range(0, 125, 25):
+            fgcolor =3D secondary.blend(primary, x/100)
+            if luminance(fgcolor) > luminance(surface):
+                bgcolor =3D surface.lighten(0.05+x/500)
+            else:
+                bgcolor =3D surface.darken(0.05+x/500)
+            normal_styles.append(Style(color=3Dfgcolor.rich_color,
+                                       bgcolor=3Dbgcolor.rich_color))
+
+        # Style for the selected flame graph node.
+        accent =3D Color.parse(theme_variables["accent"])
+        accent_muted =3D Color.parse(theme_variables["accent-muted"])
+        cursor_style =3D Style(color=3Daccent.rich_color, bgcolor=3Daccent=
_muted.rich_color)
+
+        class StripVisitor(FlameVisitor):
+            """Visitor creating textual flame graph segments.
+
+            Attributes:
+                segments (list): The textual segments that will be placed =
in a
+                                 `Strip`.
+                gap_width (int): The width of any outstanding gap between =
the
+                                 last and next node.
+                ctr (int): Used to adjust the flame graph segment's color.
+            """
+            def __init__(self):
+                self.segments =3D []
+                self.gap_width =3D 0
+                self.ctr =3D wanted_strip
+
+            def visit(self, node: Optional[ProfileNode], width: int) -> No=
ne:
+                if node:
+                    if self.gap_width > 0:
+                        self.segments.append(Segment(
+                            make_fixed_length_string(" ", self.gap_width))=
)
+                        self.gap_width =3D 0
+                    style =3D cursor_style
+                    if node !=3D cursor:
+                        style =3D normal_styles[self.ctr % len(normal_styl=
es)]
+                    self.segments.append(Segment(
+                        make_fixed_length_string(node.name, width), style)=
)
+                else:
+                    self.gap_width +=3D width
+                self.ctr +=3D 1
+
+        visitor =3D StripVisitor()
+        self.flame_walk(wanted_strip, 0, parent_width, selected, visitor)
+        return Strip(visitor.segments) if visitor.segments else Strip.blan=
k(parent_width)
+
+    def find_node(self, sought_x: int, sought_y: int, parent_width: int,
+                  selected: "ProfileNode") -> "ProfileNode":
+        """Finds the ProfileNode corresponding to specific X, Y coordinate=
s.
+
+        This translates a mouse click on a flame graph back to the
+        `ProfileNode` that it represents.
+
+        Args:
+            sought_x (int): The X coordinate (character column).
+            sought_y (int): The Y coordinate (row or depth).
+            parent_width (int): The total width of the display area.
+            selected (ProfileNode): The currently selected node, which aff=
ects
+                                    layout.
+
+        Returns:
+            Optional[ProfileNode]: The node found at the coordinates, or N=
one.
+
+        """
+        class FindVisitor(FlameVisitor):
+            """Visitor locating a `ProfileNode`.
+
+            Attributes:
+                x (int): offset within line.
+                found (Optional[ProfileNode]): located node
+                gap_width (int): The width of any outstanding gap between =
the
+                                 last and next node.
+                ctr (int): Used to adjust the flame graph segment's color.
+            """
+            def __init__(self):
+                self.x =3D 0
+                self.found =3D None
+
+            def visit(self, node: Optional[ProfileNode], width: int) -> No=
ne:
+                if self.x <=3D sought_x < self.x + width:
+                    self.found =3D node
+                self.x +=3D width
+
+        visitor =3D FindVisitor()
+        self.flame_walk(sought_y, 0, parent_width, selected, visitor)
+        return visitor.found
+
+
+class FlameGraph(ScrollView):
+    """A scrollable widget to display a flame graph from a profile.
+
+    Attributes:
+        root (ProfileNode): Root of the profile tree.
+        cursor (ProfileNode): Currently highlighted cursor node.
+        selected (ProfileNode): The currently selected node for zooming.
+    """
+
+    # Define key bindings for navigating the flame graph.
+    # Allows movement with vim-style keys (h,j,k,l) and arrow keys.
+    BINDINGS =3D [
+        Binding("j,down", "move_down", "Down", key_display=3D"=E2=86=93",
+                tooltip=3D"Move cursor down to largest child"),
+        Binding("k,up", "move_up", "Up", key_display=3D"=E2=86=91",
+                tooltip=3D"Move cursor up to parent"),
+        Binding("l,right", "move_right", "Right", key_display=3D"=E2=86=92=
",
+                tooltip=3D"Move cursor to the right sibling"),
+        Binding("h,left", "move_left", "Left", key_display=3D"=E2=86=90",
+                tooltip=3D"Move cursor to the left sibling"),
+        Binding("enter", "zoom_in", "Zoom In",
+                tooltip=3D"Expand the cursor's node to be screen width"),
+        Binding("escape", "zoom_out", "Zoom Out",
+                tooltip=3D"Zoom out to initial view."),
+     ]
+
+    # Default CSS for the widget to ensure it fills its container's width.
+    DEFAULT_CSS =3D """
+    FlameGraph {
+        width: 100%;
+    }
+    """
+
+    def __init__(self, root: ProfileNode, *args, **kwargs):
+        """Initialize the FlameGraph widget."""
+        super().__init__(*args, **kwargs)
+        self.root =3D root
+        self.cursor =3D root
+        self.selected =3D root
+
+    def action_move_down(self) -> None:
+        """Handle key press down."""
+        self.cursor =3D self.cursor.largest_child()
+        self.refresh()
+
+    def action_move_up(self) -> None:
+        """Handle key press up."""
+        if self.cursor.parent !=3D self.cursor.parent.parent:
+            self.cursor =3D self.cursor.parent
+            self.refresh()
+
+    def action_move_right(self) -> None:
+        """Handle key press right."""
+        self.cursor =3D self.cursor.parent.child_after(self.cursor)
+        self.refresh()
+
+    def action_move_left(self) -> None:
+        """Handle key press left."""
+        self.cursor =3D self.cursor.parent.child_before(self.cursor)
+        self.refresh()
+
+    def action_zoom_in(self) -> None:
+        """Handle key press zoom in."""
+        self.selected =3D self.cursor
+        self.refresh()
+
+    def action_zoom_out(self) -> None:
+        """Handle key press zoom out."""
+        self.selected =3D self.root
+        self.refresh()
+
+    def render_line(self, y: int) -> Strip:
+        """Render a single line (row) of the flame graph."""
+        _, scroll_y =3D self.scroll_offset
+        y +=3D scroll_y
+        return self.root.make_flame_strip(y, self.size.width, self.cursor,
+                                          self.selected, self.app.theme_va=
riables)
+
+    def on_mount(self) -> None:
+        """Set the height of the widget when it is displayed."""
+        self.styles.height =3D self.root.depth()
+
+    def on_click(self, click: events.Click) -> None:
+        """Handles a mouse click and update the cursor position."""
+        _, scroll_y =3D self.scroll_offset
+        y =3D scroll_y + click.y
+        clicked_node =3D self.root.find_node(click.x, y, self.size.width,
+                                           self.selected)
+        if clicked_node:
+            self.cursor =3D clicked_node
+            self.refresh()
+
=20
 class ReportApp(App):
     """A Textual application to display profiling data."""
@@ -168,6 +519,8 @@ class ReportApp(App):
         with TabbedContent(initial=3D"report"):
             with TabPane("Report", id=3D"report"):
                 yield self.make_report_tree()
+            with TabPane("Flame Graph", id=3D"flame"):
+                yield FlameGraph(self.root)
         yield Footer()
=20
=20
--=20
2.55.0.654.g21b8a5bc05-goog

