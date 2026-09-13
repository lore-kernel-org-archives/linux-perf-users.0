Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF37D370D57;
	Sun, 13 Sep 2026 21:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789335620; cv=none; b=oU8cgY3Ty340ldDU6kQ3yXLIVsFxKNQfa/aQigeJnw3h/wMPjLmZu+gwAM/WH1uS4Cye2zZddYtuaKM8AHqu0MU9OB0ZmDRvkjrz+C2dewn/SyVvSCZiqpmnWMfcOduK6w3dAfwCh5bz9023x2XrjbKsjKnT0sK1OFIRMiDN4oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789335620; c=relaxed/simple;
	bh=PF+LVKskK+pamCNUypr+ieRRZaaqa2r/q3lqQavMfuk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lB1UYfaT3XoVYVBFrHw9tfB+7MZfdqN+GaZYhfWstTpmXXu0XP0OY/pBOpRZRVZCYIpg+PDDeHmB+gmRSniat46bTzvSQuMefvzGfahg7Rsq2gsj6GCVu87loeZA/GXV4CMlDuMTHk/3spHGZGkuFudA1RguWPu0FLs/Oh2S2lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oFTE8hfg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oFTE8hfg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98A011F000FF;
	Sun, 13 Sep 2026 21:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789335618;
	bh=RIVgQ+6LEjJa5Iu13ovL4TtskNFbnPXN6Qbq9MZXJHM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oFTE8hfgUU+jJ6YgPno/UkMlktWe5C40oSi+F9ZtxXdy+nHEgjjLWMBoVPk83QYKB
	 f1+KZNGWwqQqG7E0EnD+C8sAL/sZq2yKsGyfCB+N2FpCG8dTVh0Et6sX+3Dn9ZmaER
	 Q1kJcgogfrlej3Tyvwx2nWh+rmda8+KKhtqbdudsx0gT2iK+qeuFT5xOQ2fsxXZBR3
	 5uCoMsfo2FdW29EW9UAmFA7KjwnTpCxiNZP0N6E29hzA203JfbowtqnBoqfpj753uK
	 C4eUd7sOynJstwv/Ln2e5CmYTQYYuygeZlahsTKrXlIktAwXqLWGiXc6WAkZiit6wC
	 bg+a4ZXXbYF2A==
Date: Sun, 13 Sep 2026 18:40:14 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf python: Fix ilist TreeNode string type drift
Message-ID: <aqcYPoBOEKNk0WMc@x2>
References: <20260910174420.3002597-1-irogers@google.com>
 <20260910211539.3157204-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910211539.3157204-1-irogers@google.com>

On Thu, Sep 10, 2026 at 02:15:39PM -0700, Ian Rogers wrote:
> Updates Tree type hints to correctly use TreeNode[TreeValue]
> across all assignments preventing mypy strictness mismatches.
> 
> Address some other minor stylistic issues reported by mypy, pylint and
> Sashiko.

Thanks, applied to perf-tools-next, for v7.4.

- Arnaldo
 
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
> v2: Tweak the imports and type annotations for better 3.9
>     compatibility and to be more pythonic.
> ---
>  tools/perf/python/ilist.py | 78 ++++++++++++++++++++------------------
>  1 file changed, 42 insertions(+), 36 deletions(-)
> 
> diff --git a/tools/perf/python/ilist.py b/tools/perf/python/ilist.py
> index 0d757ddb4795..ebff0a843b7a 100755
> --- a/tools/perf/python/ilist.py
> +++ b/tools/perf/python/ilist.py
> @@ -2,11 +2,13 @@
>  # SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
>  """Interactive perf list."""
>  
> -from abc import ABC, abstractmethod
> +from __future__ import annotations
> +
>  import argparse
> +from abc import ABC, abstractmethod
>  from dataclasses import dataclass
>  import math
> -from typing import Any, Dict, Optional, Tuple
> +from typing import Any, Optional
>  import perf
>  from textual import on
>  from textual.app import App, ComposeResult
> @@ -19,7 +21,7 @@ from textual.widgets import Button, Footer, Header, Input, Label, Sparkline, Sta
>  from textual.widgets.tree import TreeNode
>  
>  
> -def get_info(info: Dict[str, str], key: str):
> +def get_info(info: dict[str, Any], key: str):
>      return (info[key] + "\n") if key in info else ""
>  
>  
> @@ -140,7 +142,7 @@ class ErrorScreen(ModalScreen[bool]):
>      def compose(self) -> ComposeResult:
>          yield Button(f"Error: {self.error}", variant="primary", id="error")
>  
> -    def on_button_pressed(self, event: Button.Pressed) -> None:
> +    def on_button_pressed(self) -> None:
>          self.dismiss(True)
>  
>  
> @@ -234,7 +236,7 @@ class IListApp(App):
>  
>      def __init__(self, interval: float) -> None:
>          self.interval = interval
> -        self.evlist = None
> +        self.evlist: Optional[perf.evlist] = None
>          self.selected: Optional[TreeValue] = None
>          self.search_results: list[TreeNode[TreeValue]] = []
>          self.cur_search_result: TreeNode[TreeValue] | None = None
> @@ -284,18 +286,18 @@ class IListApp(App):
>              """Sets the focus after the SearchScreen is dismissed."""
>  
>              search_label = self.query_one("#active_search", Label)
> -            search_label.display = True if event else False
> +            search_label.display = bool(event)
>              if not event:
>                  return
>              event = event.lower()
>              search_label.update(f'Searching for events matching "{event}"')
>  
> -            tree: Tree[str] = self.query_one("#root", Tree)
> +            tree: Tree[TreeValue] = self.query_one("#root", Tree)
>  
> -            def find_search_results(event: str, node: TreeNode[str],
> +            def find_search_results(event: str, node: TreeNode[TreeValue],
>                                      cursor_seen: bool = False,
> -                                    match_after_cursor: Optional[TreeNode[str]] = None
> -                                    ) -> Tuple[bool, Optional[TreeNode[str]]]:
> +                                    match_after_cursor: Optional[TreeNode[TreeValue]] = None
> +                                    ) -> tuple[bool, Optional[TreeNode[TreeValue]]]:
>                  """Find nodes that match the search remembering the one after the cursor."""
>                  if not cursor_seen and node == tree.cursor_node:
>                      cursor_seen = True
> @@ -332,7 +334,7 @@ class IListApp(App):
>  
>      def action_collapse(self) -> None:
>          """Collapse the part of the tree currently on."""
> -        tree: Tree[str] = self.query_one("#root", Tree)
> +        tree: Tree[TreeValue] = self.query_one("#root", Tree)
>          node = tree.cursor_node
>          if node and node.parent:
>              node.parent.collapse_all()
> @@ -343,31 +345,34 @@ class IListApp(App):
>          if not self.selected or not self.evlist:
>              return
>  
> -        def update_count(cpu: int, count: int):
> +        def update_count(cpu: int, count: int | float):
>              # Update the raw count display.
> -            counter: Label = self.query(f"#counter_cpu{cpu}" if cpu >= 0 else "#counter_total")
> -            if not counter:
> +            counter_query = self.query(f"#counter_cpu{cpu}" if cpu >= 0 else "#counter_total")
> +            if not counter_query:
>                  return
> -            counter = counter.first(Label)
> +            counter: Label = counter_query.first(Label)
>              counter.update(str(count))
>  
>              # Update the sparkline.
> -            line: Sparkline = self.query(f"#sparkline_cpu{cpu}" if cpu >= 0 else "#sparkline_total")
> -            if not line:
> +            line_query = self.query(f"#sparkline_cpu{cpu}" if cpu >= 0 else "#sparkline_total")
> +            if not line_query:
>                  return
> -            line = line.first(Sparkline)
> +            line: Sparkline = line_query.first(Sparkline)
>              # If there are more events than the width, remove the front event.
> -            if len(line.data) > line.size.width:
> -                line.data.pop(0)
> -            line.data.append(count)
> -            line.mutate_reactive(Sparkline.data)
> +            if line.data is not None:
> +                if len(line.data) > line.size.width:
> +                    line.data = line.data[1:]
> +                line.data = list(line.data) + [float(count)]
> +            else:
> +                line.data = [float(count)]
> +            line.refresh()
>  
>          # Update the total and each CPU counts, assume there's just 1 evsel.
> -        total = 0
> +        total: float = 0.0
>          self.evlist.disable()
>          for evsel in self.evlist:
>              for cpu in evsel.cpus():
> -                aggr = 0
> +                aggr: float = 0.0
>                  for thread in evsel.threads():
>                      aggr += self.selected.value(self.evlist, evsel, cpu, thread)
>                  update_count(cpu, aggr)
> @@ -424,16 +429,16 @@ class IListApp(App):
>          # Add spark lines for all the CPUs. Note, must be done after
>          # open so that the evlist CPUs have been computed by propagate
>          # maps.
> -        line = CounterSparkline(cpu=-1)
> -        lines.mount(line)
> +        line_sp = CounterSparkline(cpu=-1)
> +        lines.mount(line_sp)
>          for cpu in self.evlist.all_cpus():
> -            line = CounterSparkline(cpu)
> -            lines.mount(line)
> -        line = Counter(cpu=-1)
> -        lines.mount(line)
> +            c_sp = CounterSparkline(cpu)
> +            lines.mount(c_sp)
> +        c_val = Counter(cpu=-1)
> +        lines.mount(c_val)
>          for cpu in self.evlist.all_cpus():
> -            line = Counter(cpu)
> -            lines.mount(line)
> +            c_val2 = Counter(cpu)
> +            lines.mount(c_val2)
>  
>      def compose(self) -> ComposeResult:
>          """Draws the app."""
> @@ -459,17 +464,18 @@ class IListApp(App):
>                      # Reading events may fail with EPERM, ignore.
>                      pass
>              metrics = tree.root.add("Metrics")
> -            groups = set()
> +            groups: set[str] = set()
>              for metric in perf.metrics():
>                  groups.update(metric["MetricGroup"])
>  
> -            def add_metrics_to_tree(node: TreeNode[TreeValue], parent: str, pmu: str = None):
> +            def add_metrics_to_tree(node: TreeNode[TreeValue], parent: str, pmu: Optional[str] = None):
>                  for metric in sorted(perf.metrics(), key=lambda x: x["MetricName"]):
> -                    metric_pmu = metric.get('PMU')
> +                    metric_pmu_raw = metric.get('PMU')
> +                    metric_pmu = str(metric_pmu_raw) if metric_pmu_raw else ''
>                      if pmu and metric_pmu and metric_pmu != pmu:
>                          continue
>                      if parent in metric["MetricGroup"]:
> -                        name = metric["MetricName"]
> +                        name = str(metric["MetricName"])
>                          display_name = name
>                          if metric_pmu:
>                              display_name += f" ({metric_pmu})"
> -- 
> 2.55.0.1007.g17ff1f9808-goog
