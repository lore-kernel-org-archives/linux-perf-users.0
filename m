Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15098946C;
	Sat, 26 Jul 2025 06:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753512234; cv=none; b=dxTarEBK5v7douV6S2+H2jqomV6DsuywJzHblYYBtVvxH7s36QDChYlycUnFKnw925jujgWsz1JizrhkSIkRavKM2U+i8YvO0uX+/Plp7czLzZL4mXb8cAo0OvwEbxYZcbbi7STQZYSnR8RapP+4fKCj8L/60kbv9p42aGVt65M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753512234; c=relaxed/simple;
	bh=LKxrnSJMdpwJ3WhzFl/GHz53fcRFdBQSNYQ28HcqqBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o/1Jsd5GD7lu6UYu4bKCNKYC7stYFMUPG353igfpA2w+jUg4Jj+CKx320quLSXqDx0Pdzt2bxoPqvgdxpKTMUF1Ct/A0H8vAeG/fHsE2IB4p6r/2ggp8UoDZj81Qxlfo7NOPvjCi3ZIHWBw17FcaesfH9gnmkKNK2D8nDbcQvhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q6jc7Djl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q6jc7Djl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E22AC4CEED;
	Sat, 26 Jul 2025 06:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753512233;
	bh=LKxrnSJMdpwJ3WhzFl/GHz53fcRFdBQSNYQ28HcqqBg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q6jc7Djltxfnhhibg51b1NmUvDKVrVatvzrfwf9BHgycwpELSvGsa3FSJ7uOSxWN5
	 4jWT4cw5f0tt0OE9iBDt2baTLScvfmtBlEWYBgaMdqZCaFtMvYbMPerU2oTv49Z9rn
	 YzCh5P4fZwrS3lux/k9YYXvnONcz8ydtgV+SXNAjtkX9/oY8thMtV4bhzDctNA+YYG
	 zzKeD7/0pnCYFjExPxTnRx3ARU8S3BDHuwZVjTRzAZP06NmeHSIucDJBHxAg6Fpyvl
	 cpbAvGlGra7HF8ZCAxqLKC83mblwIYgPKAHip8jucRqrpt61Gn1HMhVuKJENmb0uWO
	 WRU/f8vmngDHA==
Date: Fri, 25 Jul 2025 23:43:51 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Alice Rogers <alice.mei.rogers@gmail.com>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v1 2/2] perf script: treport add flamegraph support
Message-ID: <aIR5J5B1X5gOM9JO@google.com>
References: <20250725082425.20999-1-irogers@google.com>
 <20250725082425.20999-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250725082425.20999-2-irogers@google.com>

On Fri, Jul 25, 2025 at 01:24:05AM -0700, Ian Rogers wrote:
> From: Alice Rogers <alice.mei.rogers@gmail.com>
> 
> Implement a flamegraph widget that recursively walks down a tree
> splitting line segments based on their value (summed up periods across
> call chains). A visitor pattern is used so that the same logic can
> both draw the line segments and locate which segment had a mouse
> click.
> 
> Add a tab for the flame graph widget.

Great!  Having flame-graphs in a terminal would be convenient.
I'm curious if it supports zoom in/out for a selected entry.

Thanks,
Namhyung

> 
> Signed-off-by: Alice Rogers <alice.mei.rogers@gmail.com>
> Co-developed-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/scripts/python/treport.py | 342 ++++++++++++++++++++++++++-
>  1 file changed, 341 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/scripts/python/treport.py b/tools/perf/scripts/python/treport.py
> index fd1ca79efdad..fd43a3dbe1c2 100644
> --- a/tools/perf/scripts/python/treport.py
> +++ b/tools/perf/scripts/python/treport.py
> @@ -1,10 +1,40 @@
>  # treport.py - perf report like tool written using textual
>  # SPDX-License-Identifier: MIT
> +from abc import ABC, abstractmethod
> +from rich.segment import Segment
> +from rich.style import Style
> +from textual import events
>  from textual.app import App, ComposeResult
>  from textual.binding import Binding
> +from textual.color import Color
> +from textual.strip import Strip
>  from textual.widgets import Footer, Header, TabbedContent, TabPane, Tree
>  from textual.widgets.tree import TreeNode
> -from typing import Dict
> +from textual.scroll_view import ScrollView
> +from typing import Dict, Optional
> +
> +def make_fixed_length_string(s: str, length: int, pad_char=' '):
> +    """Make the string s a fixed length.
> +
> +    Increases or decreases the length of s to be length. If the length is
> +    increased then pad_char is inserted on the right.
> +    """
> +    return s[:length] if len(s) > length else s.ljust(length, pad_char)
> +
> +
> +class FlameVisitor(ABC):
> +    """Parent for visitor used by ProfileNode.flame_walk"""
> +    @abstractmethod
> +    def visit(self, node: Optional["ProfileNode"], width: int) -> None:
> +        """Visit a profile node width the specified flame graph width.
> +
> +        Args:
> +            node: The `ProfileNode` for the current segment. This may be `None`
> +                to represent a gap or an unknown portion of the stack.
> +            width: The calculated width of the flame graph rectangle for this
> +                node, which is proportional to its sample count.
> +        """
> +
>  
>  class ProfileNode:
>      """Represents a single node in a call stack tree.
> @@ -118,6 +148,314 @@ class ProfileNode:
>                              key=lambda pnode: pnode.value, reverse=True):
>              pnode.add_to_tree(new_node, root_value)
>  
> +    def largest_child(self) -> "ProfileNode":
> +        """Finds the child with the highest value (sample count)."""
> +        if self.children:
> +            return max(self.children.values(), key=lambda node: node.value)
> +        return self
> +
> +    def child_after(self, sought: "ProfileNode") -> "ProfileNode":
> +        """Finds the next sibling after the given node, sorted by value."""
> +        found = False
> +        for child in sorted(self.children.values(), key=lambda node: node.value,
> +                            reverse=True):
> +            if child == sought:
> +                found = True
> +            elif found:
> +                return child
> +        return sought
> +
> +    def child_before(self, sought: "ProfileNode") -> "ProfileNode":
> +        """Finds the previous sibling before the given node, sorted by value."""
> +        last = None
> +        for child in sorted(self.children.values(), key=lambda node: node.value,
> +                            reverse=True):
> +            if child == sought:
> +                return last if last else sought
> +            last = child
> +        return sought
> +
> +    def has_child(self, sought: "ProfileNode") -> bool:
> +        """Checks if the sought node is a descendant of this node."""
> +        for child in self.children.values():
> +            if child == sought or child.has_child(sought):
> +                return True
> +        return False
> +
> +    def has_parent(self, parent: "ProfileNode") -> bool:
> +        """Checks if the parent node is an ancestor of this node."""
> +        p = self.parent
> +        while True:
> +            if p == parent:
> +                return True
> +            new_p = p.parent
> +            if new_p == p:
> +                break
> +            p = new_p
> +        return False
> +
> +    def flame_walk(self, wanted_strip: int, cur_strip: int, parent_width: int,
> +                   selected: "ProfileNode", visitor: FlameVisitor) -> None:
> +        """Recursively walks the tree to visit a single flame graph row.
> +
> +        This method calculates the proportional width for each child
> +        based on its value (sample count) relative to its parent. It
> +        then invokes a `visitor` to process each segment of the flame
> +        graph row.
> +
> +        Args:
> +            wanted_strip (int): The target depth (Y-axis) of the flame graph row
> +                                to generate.
> +            cur_strip (int): The current depth of the traversal.
> +            parent_width (int): The width of the parent of this node.
> +            selected (ProfileNode): The currently selected node in the UI, used
> +                                    to adjust rendering to highlight the
> +                                    selected path.
> +            visitor (FlameVisitor): A visitor object whose `visit` method is
> +                                    called for each segment of the flame graph
> +                                    row.
> +        """
> +        if parent_width == 0:
> +            return
> +
> +        parent_selected = selected == self or self.has_parent(selected)
> +        child_selected = not parent_selected and self.has_child(selected)
> +        if not parent_selected and not child_selected:
> +            # Branches of the tree with no node selected aren't drawn.
> +            return
> +
> +        # left_over is used to check for a gap after the children due
> +        # to samples being in the parent.
> +        left_over = parent_width
> +        for child in sorted(self.children.values(), key=lambda node: node.value,
> +                            reverse=True):
> +            if parent_selected:
> +                if self.value:
> +                    desired_width = int((parent_width * child.value) / self.value)
> +                else:
> +                    desired_width = parent_width // len(self.children)
> +                if desired_width == 0:
> +                    # Nothing can be drawn for this node or later smaller children.
> +                    break
> +            elif child == selected or child.has_child(selected):
> +                desired_width = parent_width
> +            else:
> +                # A sibling or its child are selected, but not this branch.
> +                continue
> +
> +            # Either visit the wanted_strip or recurse to the next level.
> +            if wanted_strip == cur_strip:
> +                visitor.visit(child, desired_width)
> +            else:
> +                child.flame_walk(wanted_strip, cur_strip + 1, desired_width,
> +                                 selected, visitor)
> +            left_over -= desired_width
> +            if left_over == 0:
> +                # No space left to draw in.
> +                break
> +
> +        # Always visit the left_over regardless of the wanted_strip as there
> +        # may be additional gap added to a line by a parent.
> +        if left_over:
> +            visitor.visit(None, left_over)
> +
> +    def make_flame_strip(self, wanted_strip: int, parent_width: int,
> +                         cursor: "ProfileNode", selected: "ProfileNode") -> Strip:
> +        """Creates a renderable 'Strip' for a single row of a flame graph.
> +
> +        This method orchestrates the `flame_walk` traversal with a specialized
> +        visitor to generate a list of segments. The segments are used by a`Strip`
> +        object for rendering in the terminal.
> +
> +        Args:
> +            wanted_strip (int): The target depth (Y-axis) of the flame graph row.
> +            parent_width (int): The total width (in characters) of the display
> +                                area.
> +            cursor (ProfileNode): The node currently under the cursor, for
> +                                  highlighting.
> +            selected (ProfileNode): The node that is actively selected.
> +
> +        Returns:
> +            Strip: A renderable strip of segments for the specified row.
> +        """
> +        black = Color.parse("#000000")
> +        # Non-cursor values range from red up to white.
> +        normal_styles = [
> +            Style(color=black.rich_color, bgcolor=Color(255, x, x).rich_color
> +                  ) for x in range(0, 220, 25)
> +        ]
> +        # Cursor is red text with a black background.
> +        cursor_style = Style(color=Color.parse("#ff0000").rich_color,
> +                             bgcolor=black.rich_color)
> +
> +        class StripVisitor(FlameVisitor):
> +            """Visitor creating textual flame graph segments.
> +
> +            Attributes:
> +                segments (list): The textual segments that will be placed in a
> +                                 `Strip`.
> +                gap_width (int): The width of any outstanding gap between the
> +                                 last and next node.
> +                ctr (int): Used to adjust the flame graph segment's color.
> +            """
> +            def __init__(self):
> +                self.segments = []
> +                self.gap_width = 0
> +                self.ctr = wanted_strip
> +
> +            def visit(self, node: Optional[ProfileNode], width: int) -> None:
> +                if node:
> +                    if self.gap_width > 0:
> +                        self.segments.append(Segment(
> +                            make_fixed_length_string(" ", self.gap_width)))
> +                        self.gap_width = 0
> +                    style = cursor_style
> +                    if node != cursor:
> +                        style = normal_styles[self.ctr % len(normal_styles)]
> +                    self.segments.append(Segment(
> +                        make_fixed_length_string(node.name, width), style))
> +                else:
> +                    self.gap_width += width
> +                self.ctr += 1
> +
> +        visitor = StripVisitor()
> +        self.flame_walk(wanted_strip, 0, parent_width, selected, visitor)
> +        return Strip(visitor.segments) if visitor.segments else Strip.blank(parent_width)
> +
> +    def find_node(self, sought_x: int, sought_y: int, parent_width: int,
> +                  selected: "ProfileNode") -> "ProfileNode":
> +        """Finds the ProfileNode corresponding to specific X, Y coordinates.
> +
> +        This translates a mouse click on a flame graph back to the
> +        `ProfileNode` that it represents.
> +
> +        Args:
> +            sought_x (int): The X coordinate (character column).
> +            sought_y (int): The Y coordinate (row or depth).
> +            parent_width (int): The total width of the display area.
> +            selected (ProfileNode): The currently selected node, which affects
> +                                    layout.
> +
> +        Returns:
> +            Optional[ProfileNode]: The node found at the coordinates, or None.
> +
> +        """
> +        class FindVisitor(FlameVisitor):
> +            """Visitor locating a `ProfileNode`.
> +
> +            Attributes:
> +                x (int): offset within line.
> +                found (Optional[ProfileNode]): located node
> +                gap_width (int): The width of any outstanding gap between the
> +                                 last and next node.
> +                ctr (int): Used to adjust the flame graph segment's color.
> +            """
> +            def __init__(self):
> +                self.x = 0
> +                self.found = None
> +
> +            def visit(self, node: Optional[ProfileNode], width: int) -> None:
> +                if self.x <= sought_x and sought_x < self.x + width:
> +                    self.found = node
> +                self.x += width
> +
> +        visitor = FindVisitor()
> +        self.flame_walk(sought_y, 0, parent_width, selected, visitor)
> +        return visitor.found
> +
> +
> +class FlameGraph(ScrollView):
> +    """A scrollable widget to display a flame graph from a profile.
> +
> +    Attributes:
> +        root (ProfileNode): Root of the profile tree.
> +        cursor (ProfileNode): Currently highlighted cursor node.
> +        selected (ProfileNode): The currently selected node for zooming.
> +    """
> +
> +    # Define key bindings for navigating the flame graph.
> +    # Allows movement with vim-style keys (h,j,k,l) and arrow keys.
> +    BINDINGS = [
> +        Binding("j,down", "move_down", "Down", key_display="↓",
> +                tooltip="Move cursor down to largest child"),
> +        Binding("k,up", "move_up", "Up", key_display="↑",
> +                tooltip="Move cursor up to parent"),
> +        Binding("l,right", "move_right", "Right", key_display="→",
> +                tooltip="Move cursor to the right sibling"),
> +        Binding("h,left", "move_left", "Left", key_display="←",
> +                tooltip="Move cursor to the left sibling"),
> +        Binding("enter", "zoom_in", "Zoom In",
> +                tooltip="Expand the cursor's node to be screen width"),
> +        Binding("escape", "zoom_out", "Zoom Out",
> +                tooltip="Zoom out to initial view."),
> +     ]
> +
> +    # Default CSS for the widget to ensure it fills its container's width.
> +    DEFAULT_CSS = """
> +    FlameGraph {
> +        width: 100%;
> +    }
> +    """
> +
> +    def __init__(self, root: ProfileNode, *args, **kwargs):
> +        """Initialize the FlameGraph widget."""
> +        super().__init__(*args, **kwargs)
> +        self.root = root
> +        self.cursor = root
> +        self.selected = root
> +
> +    def action_move_down(self) -> None:
> +        """Handle key press down."""
> +        self.cursor = self.cursor.largest_child()
> +        self.refresh()
> +
> +    def action_move_up(self) -> None:
> +        """Handle key press up."""
> +        if self.cursor.parent != self.cursor.parent.parent:
> +            self.cursor = self.cursor.parent
> +            self.refresh()
> +
> +    def action_move_right(self) -> None:
> +        """Handle key press right."""
> +        self.cursor = self.cursor.parent.child_after(self.cursor)
> +        self.refresh()
> +
> +    def action_move_left(self) -> None:
> +        """Handle key press left."""
> +        self.cursor = self.cursor.parent.child_before(self.cursor)
> +        self.refresh()
> +
> +    def action_zoom_in(self) -> None:
> +        """Handle key press zoom in."""
> +        self.selected = self.cursor
> +        self.refresh()
> +
> +    def action_zoom_out(self) -> None:
> +        """Handle key press zoom out."""
> +        self.selected = self.root
> +        self.refresh()
> +
> +    def render_line(self, y: int) -> Strip:
> +        """Render a single line (row) of the flame graph."""
> +        _, scroll_y = self.scroll_offset
> +        y += scroll_y
> +        return self.root.make_flame_strip(y, self.size.width, self.cursor,
> +                                          self.selected)
> +
> +    def on_mount(self) -> None:
> +        """Set the height of the widget when it is displayed."""
> +        self.styles.height = self.root.depth()
> +
> +    def on_click(self, click: events.Click) -> None:
> +        """Handles a mouse click and update the cursor position."""
> +        _, scroll_y = self.scroll_offset
> +        y = scroll_y + click.y
> +        clicked_node = self.root.find_node(click.x, y, self.size.width,
> +                                           self.selected)
> +        if clicked_node:
> +            self.cursor = clicked_node
> +            self.refresh()
> +
>  
>  class ReportApp(App):
>      """A Textual application to display profiling data."""
> @@ -152,6 +490,8 @@ class ReportApp(App):
>          with TabbedContent(initial="report"):
>              with TabPane("Report", id="report"):
>                  yield self.make_report_tree()
> +            with TabPane("Flame Graph", id="flame"):
> +                yield FlameGraph(self.root)
>          yield Footer()
>  
>  
> -- 
> 2.50.1.552.g942d659e1b-goog
> 
