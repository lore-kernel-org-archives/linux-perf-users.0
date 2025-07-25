Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61ADE1DE3A7
	for <linux-perf-users@vger.kernel.org>; Fri, 25 Jul 2025 08:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753432716; cv=none; b=kS1/FviWeqD0u3sBwCTO8HnFitXv9csLdMZi8SxHjUN2BkqAn8ONQdq9rNe/smLMv1OvCY3jbnQeBcdxTHKiEGs5KtlzHNnsja+3NDKqlrhGfmTuRztx2f0dykbJpQz4QVmAIsoq5mtL6POWTMBu9tLuasY7uBPQsO+d/g5V5AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753432716; c=relaxed/simple;
	bh=7kdC7ZQR1ZMJnUei5mqHTXtMv4a4bFKcFg3o44Hj/q4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lXiDgbi2ewqaCtmbv+x3E5u28xdFzcQORHt0mkct2LauIjrP8H1pdsgKS2Nrco+aS1s6orVRS7LUf0/GVrgvpHbLcc+i+dQgymWjt7Ac5A2XMMn0f4Xm+o3AQEaJmy7/3Mpqi02SBsY1zInmA3/Y88Rxa0i7HRtnFYnCPvqCIoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eCr84b/x; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eCr84b/x"
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3df371e1d29so97565ab.0
        for <linux-perf-users@vger.kernel.org>; Fri, 25 Jul 2025 01:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753432713; x=1754037513; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HCXlm0NCWAKPWCt5U3dBrxonIS6Fzv590MVys7ZPoeA=;
        b=eCr84b/x6rqBRTCNG3OuOO8a6amxrSykbSXo1oalEEWwymRzxlXPMI/IHXGtjQ8Zix
         PM9aOmnvQwAZGcSQSR7sGsJl1JEBQaDontrMWqqQOzcrS+VcjwmPc5qxBzrRKL4fDzZS
         lHS6XSMHRoejRyVfQnG+/GZXKzs4vxu3hk9jOMCWjzoyHdQQDsHjmEx4pR5Nfsn6Fnul
         k7lXo5C1L6TlelCzUSKfT/0S7a9pqgPZm/lksoSPGFbIBnv6tprO2lLtGAF4RYsuaKtx
         yiDw2+cio1ppQbfiXhwEZHy072o4k6cKvZNbrrdi5rVIKle2eMNziwbQ0rAn7tI+jDiv
         yQug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753432713; x=1754037513;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HCXlm0NCWAKPWCt5U3dBrxonIS6Fzv590MVys7ZPoeA=;
        b=TNAqptqtG/wAtJvw4mbhYZTwjnkqojNEVd+7mCdYNiOSFlZ6oQB/8GFnRiSE6zlrUc
         R1bNJDYiyOpGYKZYrLjdHT2zAuRXt135QlwbGs218zwLLghiOAGpdYK+aHuYr2lwAo8D
         w8I563UQnuDL6BrdRLO9RSHGqfjZEn8dHNu62jLJLnChdL5w/jvtJqpi3W1g595+TwXK
         /rRLOQDo6TAfTXJ80SfARRH7dfKkKemtoOGCpOFj0bzqrr6794aexGXtmZ0gNtgsqyPH
         QDAE25GX3CGyg0RdcqK02Cx4kK+MbRq/JG5sa3Zg+F7SvXn6k1x2sc2XY9D12FZEgtGx
         M++w==
X-Forwarded-Encrypted: i=1; AJvYcCWWg09JLWk/1K30OqdhcjKSRJIu68bWbi1KaNMDqFA8ZgFMaBgBlCbkbXnR2n2R+nF+O8o2X1WxX7Ei2869R/PE@vger.kernel.org
X-Gm-Message-State: AOJu0YyuZQw+bHCEqqhbDYdMfF42Pc93Qgr2Bhu3DZCeMg4BxIPa7LuW
	sk9AGIj5nvyf0oh4iEeUBh7CivnNyGLGkk3kPo5va+947sEKwEUWDhe31NDqHE8k873ukxivxka
	u8WSXQRqcjXmKvBo5fhbrut4D+tmfKhRS3knOWWtG
X-Gm-Gg: ASbGncs/U8wsxeIfXd/LlGofS7t62jiK9BQgI8n4117LqYYgey/DKgFWDLrR1KYyn3r
	zAOZCYsL7MRQ8Z+jrhpI0MPpNEcKhybCzozF8e7A1fLdC9GOA+eihE1MDp2Qaj2Q/bXTbFNa0hd
	EPQXZJ1hHJCs3AVvjqE/eTJFLHhYuMNy5mJVy3vSmmuxFBwMYvJqpxHKWaTfpMGuuilX4wkdOhI
	qQ35THAenTDtJjtDsE=
X-Google-Smtp-Source: AGHT+IHer3A7w9hqeISwso7eIk4GXwFcPYHYaogmX7/ZljJLjuSGNqA6GD/O+PczW9oCMZ/eJfXbKepfQHnO17Uvcj8=
X-Received: by 2002:a92:c24d:0:b0:3dc:7cc4:3cb0 with SMTP id
 e9e14a558f8ab-3e3c1bf4782mr3262195ab.18.1753432713114; Fri, 25 Jul 2025
 01:38:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250725082425.20999-1-irogers@google.com> <20250725082425.20999-2-irogers@google.com>
In-Reply-To: <20250725082425.20999-2-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 25 Jul 2025 01:38:21 -0700
X-Gm-Features: Ac12FXw6zesvjDORdYvczPUf4EFY_VCSpV0YhIkzRZgkYkU4eSJ_BMZ52FO-UOI
Message-ID: <CAP-5=fU=z8kcY4zjezoxSwYf9vczYzHztiMSBvJxdwwBPVWv2Q@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] perf script: treport add flamegraph support
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Alice Rogers <alice.mei.rogers@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc: xt lai <laixintaoo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 25, 2025 at 1:26=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
>
> From: Alice Rogers <alice.mei.rogers@gmail.com>
>
> Implement a flamegraph widget that recursively walks down a tree
> splitting line segments based on their value (summed up periods across
> call chains). A visitor pattern is used so that the same logic can
> both draw the line segments and locate which segment had a mouse
> click.
>
> Add a tab for the flame graph widget.
>
> Signed-off-by: Alice Rogers <alice.mei.rogers@gmail.com>
> Co-developed-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Ian Rogers <irogers@google.com>

A link to a picture:
https://fosstodon.org/@irogers/114912947565832897
The work was inspired by a similar flameshow tool by xt lai:
https://github.com/laixintao/flameshow
however, the implementation is completely different with the goal of
something simple/robust enough it could be incorporated directly as a
textual widget (hence the MIT license for compatibility with textual).

Thanks,
Ian


> ---
>  tools/perf/scripts/python/treport.py | 342 ++++++++++++++++++++++++++-
>  1 file changed, 341 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/scripts/python/treport.py b/tools/perf/scripts/py=
thon/treport.py
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
> +def make_fixed_length_string(s: str, length: int, pad_char=3D' '):
> +    """Make the string s a fixed length.
> +
> +    Increases or decreases the length of s to be length. If the length i=
s
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
> +            node: The `ProfileNode` for the current segment. This may be=
 `None`
> +                to represent a gap or an unknown portion of the stack.
> +            width: The calculated width of the flame graph rectangle for=
 this
> +                node, which is proportional to its sample count.
> +        """
> +
>
>  class ProfileNode:
>      """Represents a single node in a call stack tree.
> @@ -118,6 +148,314 @@ class ProfileNode:
>                              key=3Dlambda pnode: pnode.value, reverse=3DT=
rue):
>              pnode.add_to_tree(new_node, root_value)
>
> +    def largest_child(self) -> "ProfileNode":
> +        """Finds the child with the highest value (sample count)."""
> +        if self.children:
> +            return max(self.children.values(), key=3Dlambda node: node.v=
alue)
> +        return self
> +
> +    def child_after(self, sought: "ProfileNode") -> "ProfileNode":
> +        """Finds the next sibling after the given node, sorted by value.=
"""
> +        found =3D False
> +        for child in sorted(self.children.values(), key=3Dlambda node: n=
ode.value,
> +                            reverse=3DTrue):
> +            if child =3D=3D sought:
> +                found =3D True
> +            elif found:
> +                return child
> +        return sought
> +
> +    def child_before(self, sought: "ProfileNode") -> "ProfileNode":
> +        """Finds the previous sibling before the given node, sorted by v=
alue."""
> +        last =3D None
> +        for child in sorted(self.children.values(), key=3Dlambda node: n=
ode.value,
> +                            reverse=3DTrue):
> +            if child =3D=3D sought:
> +                return last if last else sought
> +            last =3D child
> +        return sought
> +
> +    def has_child(self, sought: "ProfileNode") -> bool:
> +        """Checks if the sought node is a descendant of this node."""
> +        for child in self.children.values():
> +            if child =3D=3D sought or child.has_child(sought):
> +                return True
> +        return False
> +
> +    def has_parent(self, parent: "ProfileNode") -> bool:
> +        """Checks if the parent node is an ancestor of this node."""
> +        p =3D self.parent
> +        while True:
> +            if p =3D=3D parent:
> +                return True
> +            new_p =3D p.parent
> +            if new_p =3D=3D p:
> +                break
> +            p =3D new_p
> +        return False
> +
> +    def flame_walk(self, wanted_strip: int, cur_strip: int, parent_width=
: int,
> +                   selected: "ProfileNode", visitor: FlameVisitor) -> No=
ne:
> +        """Recursively walks the tree to visit a single flame graph row.
> +
> +        This method calculates the proportional width for each child
> +        based on its value (sample count) relative to its parent. It
> +        then invokes a `visitor` to process each segment of the flame
> +        graph row.
> +
> +        Args:
> +            wanted_strip (int): The target depth (Y-axis) of the flame g=
raph row
> +                                to generate.
> +            cur_strip (int): The current depth of the traversal.
> +            parent_width (int): The width of the parent of this node.
> +            selected (ProfileNode): The currently selected node in the U=
I, used
> +                                    to adjust rendering to highlight the
> +                                    selected path.
> +            visitor (FlameVisitor): A visitor object whose `visit` metho=
d is
> +                                    called for each segment of the flame=
 graph
> +                                    row.
> +        """
> +        if parent_width =3D=3D 0:
> +            return
> +
> +        parent_selected =3D selected =3D=3D self or self.has_parent(sele=
cted)
> +        child_selected =3D not parent_selected and self.has_child(select=
ed)
> +        if not parent_selected and not child_selected:
> +            # Branches of the tree with no node selected aren't drawn.
> +            return
> +
> +        # left_over is used to check for a gap after the children due
> +        # to samples being in the parent.
> +        left_over =3D parent_width
> +        for child in sorted(self.children.values(), key=3Dlambda node: n=
ode.value,
> +                            reverse=3DTrue):
> +            if parent_selected:
> +                if self.value:
> +                    desired_width =3D int((parent_width * child.value) /=
 self.value)
> +                else:
> +                    desired_width =3D parent_width // len(self.children)
> +                if desired_width =3D=3D 0:
> +                    # Nothing can be drawn for this node or later smalle=
r children.
> +                    break
> +            elif child =3D=3D selected or child.has_child(selected):
> +                desired_width =3D parent_width
> +            else:
> +                # A sibling or its child are selected, but not this bran=
ch.
> +                continue
> +
> +            # Either visit the wanted_strip or recurse to the next level=
.
> +            if wanted_strip =3D=3D cur_strip:
> +                visitor.visit(child, desired_width)
> +            else:
> +                child.flame_walk(wanted_strip, cur_strip + 1, desired_wi=
dth,
> +                                 selected, visitor)
> +            left_over -=3D desired_width
> +            if left_over =3D=3D 0:
> +                # No space left to draw in.
> +                break
> +
> +        # Always visit the left_over regardless of the wanted_strip as t=
here
> +        # may be additional gap added to a line by a parent.
> +        if left_over:
> +            visitor.visit(None, left_over)
> +
> +    def make_flame_strip(self, wanted_strip: int, parent_width: int,
> +                         cursor: "ProfileNode", selected: "ProfileNode")=
 -> Strip:
> +        """Creates a renderable 'Strip' for a single row of a flame grap=
h.
> +
> +        This method orchestrates the `flame_walk` traversal with a speci=
alized
> +        visitor to generate a list of segments. The segments are used by=
 a`Strip`
> +        object for rendering in the terminal.
> +
> +        Args:
> +            wanted_strip (int): The target depth (Y-axis) of the flame g=
raph row.
> +            parent_width (int): The total width (in characters) of the d=
isplay
> +                                area.
> +            cursor (ProfileNode): The node currently under the cursor, f=
or
> +                                  highlighting.
> +            selected (ProfileNode): The node that is actively selected.
> +
> +        Returns:
> +            Strip: A renderable strip of segments for the specified row.
> +        """
> +        black =3D Color.parse("#000000")
> +        # Non-cursor values range from red up to white.
> +        normal_styles =3D [
> +            Style(color=3Dblack.rich_color, bgcolor=3DColor(255, x, x).r=
ich_color
> +                  ) for x in range(0, 220, 25)
> +        ]
> +        # Cursor is red text with a black background.
> +        cursor_style =3D Style(color=3DColor.parse("#ff0000").rich_color=
,
> +                             bgcolor=3Dblack.rich_color)
> +
> +        class StripVisitor(FlameVisitor):
> +            """Visitor creating textual flame graph segments.
> +
> +            Attributes:
> +                segments (list): The textual segments that will be place=
d in a
> +                                 `Strip`.
> +                gap_width (int): The width of any outstanding gap betwee=
n the
> +                                 last and next node.
> +                ctr (int): Used to adjust the flame graph segment's colo=
r.
> +            """
> +            def __init__(self):
> +                self.segments =3D []
> +                self.gap_width =3D 0
> +                self.ctr =3D wanted_strip
> +
> +            def visit(self, node: Optional[ProfileNode], width: int) -> =
None:
> +                if node:
> +                    if self.gap_width > 0:
> +                        self.segments.append(Segment(
> +                            make_fixed_length_string(" ", self.gap_width=
)))
> +                        self.gap_width =3D 0
> +                    style =3D cursor_style
> +                    if node !=3D cursor:
> +                        style =3D normal_styles[self.ctr % len(normal_st=
yles)]
> +                    self.segments.append(Segment(
> +                        make_fixed_length_string(node.name, width), styl=
e))
> +                else:
> +                    self.gap_width +=3D width
> +                self.ctr +=3D 1
> +
> +        visitor =3D StripVisitor()
> +        self.flame_walk(wanted_strip, 0, parent_width, selected, visitor=
)
> +        return Strip(visitor.segments) if visitor.segments else Strip.bl=
ank(parent_width)
> +
> +    def find_node(self, sought_x: int, sought_y: int, parent_width: int,
> +                  selected: "ProfileNode") -> "ProfileNode":
> +        """Finds the ProfileNode corresponding to specific X, Y coordina=
tes.
> +
> +        This translates a mouse click on a flame graph back to the
> +        `ProfileNode` that it represents.
> +
> +        Args:
> +            sought_x (int): The X coordinate (character column).
> +            sought_y (int): The Y coordinate (row or depth).
> +            parent_width (int): The total width of the display area.
> +            selected (ProfileNode): The currently selected node, which a=
ffects
> +                                    layout.
> +
> +        Returns:
> +            Optional[ProfileNode]: The node found at the coordinates, or=
 None.
> +
> +        """
> +        class FindVisitor(FlameVisitor):
> +            """Visitor locating a `ProfileNode`.
> +
> +            Attributes:
> +                x (int): offset within line.
> +                found (Optional[ProfileNode]): located node
> +                gap_width (int): The width of any outstanding gap betwee=
n the
> +                                 last and next node.
> +                ctr (int): Used to adjust the flame graph segment's colo=
r.
> +            """
> +            def __init__(self):
> +                self.x =3D 0
> +                self.found =3D None
> +
> +            def visit(self, node: Optional[ProfileNode], width: int) -> =
None:
> +                if self.x <=3D sought_x and sought_x < self.x + width:
> +                    self.found =3D node
> +                self.x +=3D width
> +
> +        visitor =3D FindVisitor()
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
> +    BINDINGS =3D [
> +        Binding("j,down", "move_down", "Down", key_display=3D"=E2=86=93"=
,
> +                tooltip=3D"Move cursor down to largest child"),
> +        Binding("k,up", "move_up", "Up", key_display=3D"=E2=86=91",
> +                tooltip=3D"Move cursor up to parent"),
> +        Binding("l,right", "move_right", "Right", key_display=3D"=E2=86=
=92",
> +                tooltip=3D"Move cursor to the right sibling"),
> +        Binding("h,left", "move_left", "Left", key_display=3D"=E2=86=90"=
,
> +                tooltip=3D"Move cursor to the left sibling"),
> +        Binding("enter", "zoom_in", "Zoom In",
> +                tooltip=3D"Expand the cursor's node to be screen width")=
,
> +        Binding("escape", "zoom_out", "Zoom Out",
> +                tooltip=3D"Zoom out to initial view."),
> +     ]
> +
> +    # Default CSS for the widget to ensure it fills its container's widt=
h.
> +    DEFAULT_CSS =3D """
> +    FlameGraph {
> +        width: 100%;
> +    }
> +    """
> +
> +    def __init__(self, root: ProfileNode, *args, **kwargs):
> +        """Initialize the FlameGraph widget."""
> +        super().__init__(*args, **kwargs)
> +        self.root =3D root
> +        self.cursor =3D root
> +        self.selected =3D root
> +
> +    def action_move_down(self) -> None:
> +        """Handle key press down."""
> +        self.cursor =3D self.cursor.largest_child()
> +        self.refresh()
> +
> +    def action_move_up(self) -> None:
> +        """Handle key press up."""
> +        if self.cursor.parent !=3D self.cursor.parent.parent:
> +            self.cursor =3D self.cursor.parent
> +            self.refresh()
> +
> +    def action_move_right(self) -> None:
> +        """Handle key press right."""
> +        self.cursor =3D self.cursor.parent.child_after(self.cursor)
> +        self.refresh()
> +
> +    def action_move_left(self) -> None:
> +        """Handle key press left."""
> +        self.cursor =3D self.cursor.parent.child_before(self.cursor)
> +        self.refresh()
> +
> +    def action_zoom_in(self) -> None:
> +        """Handle key press zoom in."""
> +        self.selected =3D self.cursor
> +        self.refresh()
> +
> +    def action_zoom_out(self) -> None:
> +        """Handle key press zoom out."""
> +        self.selected =3D self.root
> +        self.refresh()
> +
> +    def render_line(self, y: int) -> Strip:
> +        """Render a single line (row) of the flame graph."""
> +        _, scroll_y =3D self.scroll_offset
> +        y +=3D scroll_y
> +        return self.root.make_flame_strip(y, self.size.width, self.curso=
r,
> +                                          self.selected)
> +
> +    def on_mount(self) -> None:
> +        """Set the height of the widget when it is displayed."""
> +        self.styles.height =3D self.root.depth()
> +
> +    def on_click(self, click: events.Click) -> None:
> +        """Handles a mouse click and update the cursor position."""
> +        _, scroll_y =3D self.scroll_offset
> +        y =3D scroll_y + click.y
> +        clicked_node =3D self.root.find_node(click.x, y, self.size.width=
,
> +                                           self.selected)
> +        if clicked_node:
> +            self.cursor =3D clicked_node
> +            self.refresh()
> +
>
>  class ReportApp(App):
>      """A Textual application to display profiling data."""
> @@ -152,6 +490,8 @@ class ReportApp(App):
>          with TabbedContent(initial=3D"report"):
>              with TabPane("Report", id=3D"report"):
>                  yield self.make_report_tree()
> +            with TabPane("Flame Graph", id=3D"flame"):
> +                yield FlameGraph(self.root)
>          yield Footer()
>
>
> --
> 2.50.1.552.g942d659e1b-goog
>
