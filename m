Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67C5170826;
	Sat, 26 Jul 2025 06:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753511979; cv=none; b=lPM+zKao2Yvh+mhQnNwwCI+JKBbRbvaN7C5zGimJ1ZR7BjoHy4y2zKDC0POrbed7tlKvIXYug1x/BOGfX/yAR9qtUQJL6ylM/UdbuSh2wpI7VCWHlkrn6sRPUJEM5F43xPfBGERNMgiUQ8UJfLJUNVOtGKZV/E7etrey7wj4lWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753511979; c=relaxed/simple;
	bh=+Fm0LLoN34vFcBElRkyqT1ywLuu0TPIjCMpkHEuOSYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hxyLioCSBBMWxOVa4PUNrIkeQvKtr2OwSWf0ghPEPM6VeH/3jp/wFvd9DkBLPG1J2NHIkphDELT6lgv988K+TLdo6puKB5hXsePubv2JG6URe5oNrHc3UmEKNn/RMq7gEqMeALC3xPOHaR662P/9nXdC/4FIOxPjpI9zTgBNiFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=odzzanzi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="odzzanzi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5E6EC4CEED;
	Sat, 26 Jul 2025 06:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753511979;
	bh=+Fm0LLoN34vFcBElRkyqT1ywLuu0TPIjCMpkHEuOSYA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=odzzanzianmxr6T8Fm48xRf/uqxfxr146FrJqgn1187xaMwjt8tlAy84EiKNhoDkc
	 9po+PVAzNvtCyXMOd1DnFDx2DUQK2tWFty7/iPhDCnwwSsGq54xI9weSXOifeQ99cD
	 fn2NG4t95c0ICxSFu+gFibFy4ALWU/KXotDSRS95Pc7JqYzAc6tahDyO0E5jFmxghS
	 1CxPn0rHRBOdg/v7HCWw+IjzKp/fc2dwrCOIzC/YSLq+vnkcXKoLs7hX5QhBmH7FQf
	 jLE2HWmvVB0+PCxQUQwr5Kzz03UZWyx/PBUKQsH8HPYHytwtwIh+NSBvQJ6PrU/31H
	 aaaQI5+3gilLg==
Date: Fri, 25 Jul 2025 23:39:37 -0700
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
Subject: Re: [PATCH v1 1/2] perf script: New treport script
Message-ID: <aIR4KdxVcMzpPemP@google.com>
References: <20250725082425.20999-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250725082425.20999-1-irogers@google.com>

On Fri, Jul 25, 2025 at 01:24:04AM -0700, Ian Rogers wrote:
> From: Alice Rogers <alice.mei.rogers@gmail.com>

Hello Alice, thanks for your contribution!

> 
> A textual app that displays the results of processing samples similar
> to perf report. The app displays a tree of first processed and then
> functions which drop down to show more detail on the functions they
> call. The functions with the largest number of samples are sorted
> first, after each function the percentage of time spent within it is
> highlighted.

Can you please tell us how to run this script and what's needed to run
it?  Note that some people might not have textual in the system.  How
will it work in that case?

Also please add some example output in the commit message.  It'd be
great if you can compare it with perf report output.

Thanks,
Namhyung

> 
> Signed-off-by: Alice Rogers <alice.mei.rogers@gmail.com>
> Co-developed-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/scripts/python/treport.py | 177 +++++++++++++++++++++++++++
>  1 file changed, 177 insertions(+)
>  create mode 100644 tools/perf/scripts/python/treport.py
> 
> diff --git a/tools/perf/scripts/python/treport.py b/tools/perf/scripts/python/treport.py
> new file mode 100644
> index 000000000000..fd1ca79efdad
> --- /dev/null
> +++ b/tools/perf/scripts/python/treport.py
> @@ -0,0 +1,177 @@
> +# treport.py - perf report like tool written using textual
> +# SPDX-License-Identifier: MIT
> +from textual.app import App, ComposeResult
> +from textual.binding import Binding
> +from textual.widgets import Footer, Header, TabbedContent, TabPane, Tree
> +from textual.widgets.tree import TreeNode
> +from typing import Dict
> +
> +class ProfileNode:
> +    """Represents a single node in a call stack tree.
> +
> +    Generally a ProfileNode corresponds to a symbol in a call stack.
> +    The root is special, its children are events and the events
> +    children are process names. After the process name come the
> +    samples.
> +
> +    Attributes:
> +        name (str): The name of the function, process or event.
> +        value (int): The sample count for this node including counts from its
> +                     children.
> +        parent (ProfileNode): The parent of this node, this node belongs to its
> +                              children.
> +        children (Dict[str, ProfileNode]): A dictionary of child nodes, keyed by
> +                                           their names.
> +    """
> +    def __init__(self, name: str, parent: "ProfileNode"):
> +        """Initializes a ProfileNode."""
> +        self.name = name
> +        self.value: int = 0
> +        self.parent = parent if parent else self
> +        self.children: Dict[str, ProfileNode] = {}
> +
> +    def find_or_create_node(self, name: str) -> "ProfileNode":
> +        """Finds a child node by name or creates it if it doesn't exist."""
> +        if name in self.children:
> +            return self.children[name]
> +        child = ProfileNode(name, self)
> +        self.children[name] = child
> +        return child
> +
> +    def depth(self) -> int:
> +        """The maximum depth of the call stack tree from this node down."""
> +        if not self.children:
> +            return 1
> +        return max([child.depth() for child in self.children.values()]) + 1
> +
> +    def process_event(self, event: Dict) -> None:
> +        """Processes a single profiling event to update the call stack tree.
> +
> +        Args:
> +            event (Dict): A dictionary representing a single profiling sample,
> +                          expected to contain keys like 'comm', 'pid', 'period',
> +                          and 'callchain'.
> +        """
> +        pid = 0
> +        if "sample" in event and "pid" in event["sample"]:
> +            pid = event["sample"]["pid"]
> +
> +        if pid == 0:
> +            comm = event.get("comm", "kernel")
> +        else:
> +            comm = f"{event.get('comm', 'unknown')} ({pid})"
> +
> +        period = int(event["period"]) if 'period' in event else 1
> +        self.value += period
> +
> +        node = self.find_or_create_node(comm)
> +        node.value += period
> +
> +        if "callchain" in event:
> +            for entry in reversed(event["callchain"]):
> +                sym = entry.get("sym")
> +                name = None
> +                if sym:
> +                    name = sym.get("name")
> +                if not name:
> +                    name = entry.get("dso", "unknown")
> +                    if "ip" in entry:
> +                        name += f" 0x{entry['ip']:x}"
> +                node = node.find_or_create_node(name)
> +                node.value += period
> +        else:
> +            name = event.get("symbol")
> +            if not name:
> +                name = event.get("dso", "unknown")
> +                if "ip" in event:
> +                    name += f" 0x{event['ip']:x}"
> +            node = node.find_or_create_node(name)
> +            node.value += period
> +
> +    def add_to_tree(self, node: TreeNode, root_value: int) -> None:
> +        """Recursively adds this node and its children to a textual TreeNode.
> +
> +        Args:
> +            node (TreeNode): The textual `TreeNode` object to which this
> +                             ProfileNode should be added.
> +            root_value (int): Value at the root of the tree.
> +        """
> +        if root_value == 0:
> +            root_value = self.value
> +
> +        # Calculate the percentage for the node, highlighting the
> +        # percentage with reversed colors.
> +        if root_value != 0:
> +            percent = self.value / root_value * 100
> +            label = f"{self.name} [r]{percent:.3g}%[/]"
> +        else:
> +            label = self.name
> +
> +        # Add a standalone leaf.
> +        if not self.children:
> +            node.add_leaf(label)
> +            return
> +
> +        # Recursively add children.
> +        new_node = node.add(label)
> +        for pnode in sorted(self.children.values(),
> +                            key=lambda pnode: pnode.value, reverse=True):
> +            pnode.add_to_tree(new_node, root_value)
> +
> +
> +class ReportApp(App):
> +    """A Textual application to display profiling data."""
> +
> +    # The ^q binding is implied but having it here adds it in the Footer.
> +    BINDINGS = [
> +        Binding(key="^q", action="quit", description="Quit",
> +                tooltip="Quit the app"),
> +    ]
> +
> +    def __init__(self, root: ProfileNode):
> +        """Initialize the application."""
> +        super().__init__()
> +        self.root = root
> +
> +    def make_report_tree(self) -> Tree:
> +        """Make a Tree widget from the profile data."""
> +        tree: Tree[None] = Tree("Profile")
> +        # Add events to tree skipping the root.
> +        for pnode in sorted(self.root.children.values(),
> +                            key=lambda node: node.value, reverse=True):
> +            pnode.add_to_tree(tree.root, root_value=0)
> +        # Expand the first 2 levels of the tree.
> +        tree.root.expand()
> +        for tnode in tree.root.children:
> +            tnode.expand()
> +        return tree
> +
> +    def compose(self) -> ComposeResult:
> +        """Composes the user interface of the application."""
> +        yield Header()
> +        with TabbedContent(initial="report"):
> +            with TabPane("Report", id="report"):
> +                yield self.make_report_tree()
> +        yield Footer()
> +
> +
> +class ProfileBuilder:
> +    """Constructs a profile tree from a stream of events."""
> +    def __init__(self):
> +        self.root = ProfileNode("root", parent=None)
> +
> +    def process_event(self, event) -> None:
> +        """Called by `perf script` to update the profile tree."""
> +        ev_name = event.get("ev_name", "default")
> +        ev_root = self.root.find_or_create_node(ev_name)
> +        ev_root.process_event(event)
> +
> +if __name__ == "__main__":
> +    # process_event is called for each perf event to build the profile.
> +    profile = ProfileBuilder()
> +    process_event = profile.process_event
> +    # trace_end will run the application, this can't be done
> +    # concurrently as perf expects to be the main thread as does
> +    # Textual.
> +    app = ReportApp(profile.root)
> +    trace_end = app.run
> -- 
> 2.50.1.552.g942d659e1b-goog
> 
