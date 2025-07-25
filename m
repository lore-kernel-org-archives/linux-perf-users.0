Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F4723C8A4
	for <linux-perf-users@vger.kernel.org>; Fri, 25 Jul 2025 18:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753467869; cv=none; b=AkCdcMY7LeKd+wBzli3laOgL8sU6/wYmQBqxOptSl1ci+3h3Gx5qiom7BHDJPtDXQUY6KczCvzmDuWz+DFWO62LajkD1ApzbNJSXsdpQb8b/qjNtv+z3xLjDcfxMfALLPCvbHkDHoafxf+KVik1ViTi4nvgjtfnLwTqyIerxT88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753467869; c=relaxed/simple;
	bh=S/Qm/x7xGIne4UBx7olHUeOYt0k5dA4vR/1jFmfAzb4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WaxF/eYMrx4hA+ZVJibaFoU9hlOlgdENIjeaH18IfI1/cBmYeiPya3EcOBUUIQdZc1uA/MPXX0FhFY0wo9/B4bo8NRdo6MCvnymr9n4cRu74jwGfp+fxtnuWStB4swZburG/zb6YeAoO2/KYa+Qxay1OVdeKL/hrxu5oFZcnN58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VX3EZVjY; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VX3EZVjY"
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3e2429bd4b3so16815ab.1
        for <linux-perf-users@vger.kernel.org>; Fri, 25 Jul 2025 11:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753467866; x=1754072666; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8EUe3sj9UTKJEWOeBpDqD3kZ8JWbDPKaoaCnMHljn3s=;
        b=VX3EZVjYbNa6B7IUeS+lIIwcQOW0WWFrqHiuIAaT2s49JGoayDDWe1HLrtN4G30cK7
         hV/HrsaCGWIhGZoKj691nldMD5TE+94JYs3++HuTFST/5oAp6KZfL8jjUA421Gm7fSwJ
         +GlrEWbsdlVqZgnafGPOPzR6W7vGoGRJqhip0LaGnmO58uAFGeBIkskEM9p5LUxnAv4P
         d3khmYX6kIzd294412BjLnJhUxgYmnmM/cDIzz1Ci5BoMLFnvXOv7Faa6JlTjUqJhE/P
         wByAbMC+Q2rlGTdgSXRV5qNw3HZns+XQRqfeGQUz/xkC3/FuqAMBFTrzptZNcMWV8vzm
         AWrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753467866; x=1754072666;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8EUe3sj9UTKJEWOeBpDqD3kZ8JWbDPKaoaCnMHljn3s=;
        b=WMRN32D6Z6PQqs8S+Mxxf7siWPoXeUwC82wcIO5yZSC1kGd0jxg9c4MVV1S0tXQej6
         v3JGZyVhKIm+WwKLVmhxhlRmRvpzIHegQMW4eYUl4zl9raBzxwxleBfQ2fDuiKdqpAVt
         DsRR7P8na+MQlXq+GN95cCdh632dJcXZGudBooaINLvH5LlQ0FcWcilt4xis+VUF3T2n
         IiRhV8OLYl/AKf8zIsFJ2Xzc2VE2EAK16CWOwXxRmpfBXgpZ3wxmvd+zg1V7EvkClrTu
         FhlF1SNZQzbCjtAq66ZAWP6ZnYpo2VnV8Mnyn2sBUvIRII0dFbg505ifIhbsJpkvFaY+
         Wz1w==
X-Forwarded-Encrypted: i=1; AJvYcCVWRAFxEr+bc1bltrRFV7SwUuC5Vz342WWXGY3eak4TYDdKWlCN61oGstwKLtFU3Pm1D8Y4O/+GhYaenFWqJ9Fw@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo4RPd7y8N60eP98KYPmGFNQxlFOgOC1vuGcs1RRFH1CMc3sdk
	0orQuRL4SmDmVhSHvfDz3DFJKA9cgELbJdRfbvheLnMn0L/MWWHSPODiNhvXckGE7vM1ZqjcJc2
	afbyxaimu80hrd3b4BeR/bBHtlcvGlDSJg7KeLRfP
X-Gm-Gg: ASbGncsw1AAPN1zNvxRTMaMRdJg7CYORjFh0TVrQy+pVpy9M2f1DpcCORxA8Dy47uGT
	HSnkV+UGfkzBH/3xkc9orDTpiaj6rpZxiJR37Co11CaTr+JwPva38oIBn3Ft2LRH6zhaf8qAFIK
	z3AL+aiJVFKu/ADAAnrfEXin5anBbes/IJ21RZGQW+t52oGitrd1t0oq9s+Dt0CDfMZl1xIAIjl
	g1i8Gkqx38U8ARDDpFj+EitgmipxyUeYGpj
X-Google-Smtp-Source: AGHT+IEPUAz+pI4iGdF50K82QfyHo5qUUwjXAAe4KtMSUwgIEhF3QT3oZ6jka0tXiyafLGDhpY+HqQO9Mb3QXwIHnhs=
X-Received: by 2002:a05:6e02:348d:b0:3dd:be3e:7b0 with SMTP id
 e9e14a558f8ab-3e3cc0e32b4mr168985ab.13.1753467865609; Fri, 25 Jul 2025
 11:24:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250723232217.516179-1-irogers@google.com> <20250723232217.516179-12-irogers@google.com>
 <k56ukpfv77qhoblfagz6naux5mo65hgj4m3ubivq4uz3mar7f4@r4fp25smfbme>
In-Reply-To: <k56ukpfv77qhoblfagz6naux5mo65hgj4m3ubivq4uz3mar7f4@r4fp25smfbme>
From: Ian Rogers <irogers@google.com>
Date: Fri, 25 Jul 2025 11:24:14 -0700
X-Gm-Features: Ac12FXzjEA9MplD8yAzhDZaxI9-AAc1vxtRXBOa-rWrJp77v1jeeoWmGgPkEZGw
Message-ID: <CAP-5=fWeC-xtGd6Ht_fgtZR5tpRFP26tCMTYB=Co0FxD5a8o-A@mail.gmail.com>
Subject: Re: [PATCH v8 11/16] perf ilist: Add new python ilist command
To: Xu Yang <xu.yang_2@nxp.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@linaro.org>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
	Collin Funk <collin.funk1@gmail.com>, Howard Chu <howardchu95@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Andi Kleen <ak@linux.intel.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Thomas Richter <tmricht@linux.ibm.com>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, Gautam Menghani <gautam@linux.ibm.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Chun-Tse Shao <ctshao@google.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 24, 2025 at 10:37=E2=80=AFPM Xu Yang <xu.yang_2@nxp.com> wrote:
>
> Hi Ian,
>
> On Wed, Jul 23, 2025 at 04:22:12PM -0700, Ian Rogers wrote:
> > The perf ilist command is a textual app [1] similar to perf list. In
> > the top-left pane a tree of PMUs is displayed. Selecting a PMU expands
> > the events within it. Selecting an event displays the `perf list`
> > style event information in the top-right pane.
> >
> > When an event is selected it is opened and the counters on each CPU
> > the event is for are periodically read. The bottom of the screen
> > contains a scrollable set of sparklines showing the events in total
> > and on each CPU. Scrolling below the sparklines shows the same data as
> > raw counts. The sparklines are small graphs where the height of the
> > bar is in relation to maximum of the other counts in the graph.
> >
> > By default the counts are read with an interval of 0.1 seconds (10
> > times per second). A -I/--interval command line option allows the
> > interval to be changed. The oldest read counts are dropped when the
> > counts fill the line causing the sparkline to move from right to left.
> >
> > A search box can be pulled up with the 's' key. 'n' and 'p' iterate
> > through the search results. As some PMUs have hundreds of events a 'c'
> > key will collapse the events in the current PMU to make navigating the
> > PMUs easier.
> >
> > [1] https://textual.textualize.io/
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > ---
> >  tools/perf/python/ilist.py | 392 +++++++++++++++++++++++++++++++++++++
> >  1 file changed, 392 insertions(+)
> >  create mode 100755 tools/perf/python/ilist.py
> >
> > diff --git a/tools/perf/python/ilist.py b/tools/perf/python/ilist.py
> > new file mode 100755
> > index 000000000000..b21f4c93247e
> > --- /dev/null
> > +++ b/tools/perf/python/ilist.py
> > @@ -0,0 +1,392 @@
> > +#!/usr/bin/env python3
> > +# SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
> > +"""Interactive perf list."""
> > +
> > +import argparse
> > +from typing import Any, Dict, Tuple
> > +import perf
> > +from textual import on
> > +from textual.app import App, ComposeResult
> > +from textual.binding import Binding
> > +from textual.containers import Horizontal, HorizontalGroup, Vertical, =
VerticalScroll
> > +from textual.command import SearchIcon
> > +from textual.screen import ModalScreen
> > +from textual.widgets import Button, Footer, Header, Input, Label, Spar=
kline, Static, Tree
> > +from textual.widgets.tree import TreeNode
> > +
> > +class ErrorScreen(ModalScreen[bool]):
> > +    """Pop up dialog for errors."""
> > +
> > +    CSS=3D"""
> > +    ErrorScreen {
> > +        align: center middle;
> > +    }
> > +    """
> > +    def __init__(self, error: str):
> > +        self.error =3D error
> > +        super().__init__()
> > +
> > +    def compose(self) -> ComposeResult:
> > +        yield Button(f"Error: {self.error}", variant=3D"primary", id=
=3D"error")
> > +
> > +    def on_button_pressed(self, event: Button.Pressed) -> None:
> > +        self.dismiss(True)
> > +
> > +
> > +class SearchScreen(ModalScreen[str]):
> > +    """Pop up dialog for search."""
> > +
> > +    CSS=3D"""
> > +    SearchScreen Horizontal {
> > +        align: center middle;
> > +        margin-top: 1;
> > +    }
> > +    SearchScreen Input {
> > +        width: 1fr;
> > +    }
> > +    """
> > +    def compose(self) -> ComposeResult:
> > +        yield Horizontal(SearchIcon(), Input(placeholder=3D"Event name=
"))
> > +
> > +    def on_input_submitted(self, event: Input.Submitted) -> None:
> > +        """Handle the user pressing Enter in the input field."""
> > +        self.dismiss(event.value)
> > +
> > +
> > +class Counter(HorizontalGroup):
> > +    """Two labels for a CPU and its counter value."""
> > +
> > +    CSS=3D"""
> > +    Label {
> > +        gutter: 1;
> > +    }
> > +    """
> > +
> > +    def __init__(self, cpu: int) -> None:
> > +        self.cpu =3D cpu
> > +        super().__init__()
> > +
> > +    def compose(self) -> ComposeResult:
> > +        label =3D f"cpu{self.cpu}" if self.cpu >=3D 0 else "total"
> > +        yield Label(label + " ")
> > +        yield Label("0", id=3Df"counter_{label}")
> > +
> > +
> > +class CounterSparkline(HorizontalGroup):
> > +    """A Sparkline for a performance counter."""
> > +
> > +    def __init__(self, cpu: int) -> None:
> > +        self.cpu =3D cpu
> > +        super().__init__()
> > +
> > +    def compose(self) -> ComposeResult:
> > +        label =3D f"cpu{self.cpu}" if self.cpu >=3D 0 else "total"
> > +        yield Label(label)
> > +        yield Sparkline([], summary_function=3Dmax, id=3Df"sparkline_{=
label}")
> > +
> > +
> > +class IListApp(App):
> > +    TITLE =3D "Interactive Perf List"
> > +
> > +    BINDINGS =3D [
> > +        Binding(key=3D"s", action=3D"search", description=3D"Search",
> > +                tooltip=3D"Search events and PMUs"),
> > +        Binding(key=3D"n", action=3D"next", description=3D"Next",
> > +                tooltip=3D"Next search result or item"),
> > +        Binding(key=3D"p", action=3D"prev", description=3D"Previous",
> > +                tooltip=3D"Previous search result or item"),
> > +        Binding(key=3D"c", action=3D"collapse", description=3D"Collaps=
e",
> > +                tooltip=3D"Collapse the current PMU"),
> > +        Binding(key=3D"^q", action=3D"quit", description=3D"Quit",
> > +                tooltip=3D"Quit the app"),
> > +    ]
> > +
> > +    CSS =3D """
> > +        /* Make the 'total' sparkline a different color. */
> > +        #sparkline_total > .sparkline--min-color {
> > +            color: $accent;
> > +        }
> > +        #sparkline_total > .sparkline--max-color {
> > +            color: $accent 30%;
> > +        }
> > +        /*
> > +         * Make the active_search initially not displayed with the tex=
t in
> > +         * the middle of the line.
> > +         */
> > +        #active_search {
> > +            display: none;
> > +            width: 100%;
> > +            text-align: center;
> > +        }
> > +    """
> > +
> > +    def __init__(self, interval: float) -> None:
> > +        self.interval =3D interval
> > +        self.evlist =3D None
> > +        self.search_results: list[TreeNode[str]] =3D []
> > +        self.cur_search_result: TreeNode[str] | None =3D None
> > +        super().__init__()
> > +
> > +
> > +
>
> Nit: could you keep consistent blank line code style? Because I see 3
> blank line here and 2 or 1 blank line elsewhere.
>
> Refer to:
> https://peps.python.org/pep-0008/#blank-lines

Thanks Xu, strange pylint/mypy missed this. I can fix in a v9 as per
pep8. It is a shame we have non pep8 python formatted code in the
tree. I'm responsible for the 2-char indent in jevents.py as that's
Google's house style :-(

Ian


Ian

> Thanks,
> Xu Yang
>
> > +    def expand_and_select(self, node: TreeNode[Any]) -> None:
> > +        """Expand select a node in the tree."""
> > +        if node.parent:
> > +            node.parent.expand()
> > +            if node.parent.parent:
> > +                node.parent.parent.expand()
> > +        node.expand()
> > +        node.tree.select_node(node)
> > +        node.tree.scroll_to_node(node)
> > +
> > +
> > +    def set_searched_tree_node(self, previous: bool) -> None:
> > +        """Set the cur_search_result node to either the next or previo=
us."""
> > +        l =3D len(self.search_results)
> > +
> > +        if l < 1:
> > +            tree: Tree[str] =3D self.query_one("#pmus", Tree)
> > +            if previous:
> > +                tree.action_cursor_up()
> > +            else:
> > +                tree.action_cursor_down()
> > +            return
> > +
> > +        if self.cur_search_result:
> > +            idx =3D self.search_results.index(self.cur_search_result)
> > +            if previous:
> > +                idx =3D idx - 1 if idx > 0 else l - 1
> > +            else:
> > +                idx =3D idx + 1 if idx < l - 1 else 0
> > +        else:
> > +            idx =3D l - 1 if previous else 0
> > +
> > +        node =3D self.search_results[idx]
> > +        if node =3D=3D self.cur_search_result:
> > +            return
> > +
> > +        self.cur_search_result =3D node
> > +        self.expand_and_select(node)
> > +
> > +    def action_search(self) -> None:
> > +        """Search was chosen."""
> > +        def set_initial_focus(event: str | None) -> None:
> > +            """Sets the focus after the SearchScreen is dismissed."""
> > +
> > +            search_label =3D self.query_one("#active_search", Label)
> > +            search_label.display =3D True if event else False
> > +            if not event:
> > +                return
> > +            event =3D event.lower()
> > +            search_label.update(f'Searching for events matching "{even=
t}"')
> > +
> > +            tree: Tree[str] =3D self.query_one("#pmus", Tree)
> > +            def find_search_results(event: str, node: TreeNode[str], \
> > +                                    cursor_seen: bool =3D False, \
> > +                                    match_after_cursor: TreeNode[str] =
| None =3D None) \
> > +                    -> Tuple[bool, TreeNode[str] | None]:
> > +                """Find nodes that match the search remembering the on=
e after the cursor."""
> > +                if not cursor_seen and node =3D=3D tree.cursor_node:
> > +                    cursor_seen =3D True
> > +                if node.data and event in node.data:
> > +                    if cursor_seen and not match_after_cursor:
> > +                        match_after_cursor =3D node
> > +                    self.search_results.append(node)
> > +
> > +                if node.children:
> > +                    for child in node.children:
> > +                        (cursor_seen, match_after_cursor) =3D \
> > +                            find_search_results(event, child, cursor_s=
een, match_after_cursor)
> > +                return (cursor_seen, match_after_cursor)
> > +
> > +            self.search_results.clear()
> > +            (_ , self.cur_search_result) =3D find_search_results(event=
, tree.root)
> > +            if len(self.search_results) < 1:
> > +                self.push_screen(ErrorScreen(f"Failed to find pmu/even=
t {event}"))
> > +                search_label.display =3D False
> > +            elif self.cur_search_result:
> > +                self.expand_and_select(self.cur_search_result)
> > +            else:
> > +                self.set_searched_tree_node(previous=3DFalse)
> > +
> > +        self.push_screen(SearchScreen(), set_initial_focus)
> > +
> > +
> > +    def action_next(self) -> None:
> > +        """Next was chosen."""
> > +        self.set_searched_tree_node(previous=3DFalse)
> > +
> > +
> > +    def action_prev(self) -> None:
> > +        """Previous was chosen."""
> > +        self.set_searched_tree_node(previous=3DTrue)
> > +
> > +
> > +    def action_collapse(self) -> None:
> > +        """Collapse the potentially large number of events under a PMU=
."""
> > +        tree: Tree[str] =3D self.query_one("#pmus", Tree)
> > +        node =3D tree.cursor_node
> > +        if node and node.parent and node.parent.parent:
> > +            node.parent.collapse_all()
> > +            node.tree.scroll_to_node(node.parent)
> > +
> > +
> > +    def update_counts(self) -> None:
> > +        """Called every interval to update counts."""
> > +        if not self.evlist:
> > +            return
> > +
> > +        def update_count(cpu: int, count: int):
> > +            # Update the raw count display.
> > +            counter: Label =3D self.query(f"#counter_cpu{cpu}" if cpu =
>=3D 0 else "#counter_total")
> > +            if not counter:
> > +                return
> > +            counter =3D counter.first(Label)
> > +            counter.update(str(count))
> > +
> > +            # Update the sparkline.
> > +            line: Sparkline =3D self.query(f"#sparkline_cpu{cpu}" if c=
pu >=3D 0 else "#sparkline_total")
> > +            if not line:
> > +                return
> > +            line =3D line.first(Sparkline)
> > +            # If there are more events than the width, remove the fron=
t event.
> > +            if len(line.data) > line.size.width:
> > +                line.data.pop(0)
> > +            line.data.append(count)
> > +            line.mutate_reactive(Sparkline.data)
> > +
> > +        # Update the total and each CPU counts, assume there's just 1 =
evsel.
> > +        total =3D 0
> > +        self.evlist.disable()
> > +        for evsel in self.evlist:
> > +            for cpu in evsel.cpus():
> > +                aggr =3D 0
> > +                for thread in evsel.threads():
> > +                    counts =3D evsel.read(cpu, thread)
> > +                    aggr +=3D counts.val
> > +                update_count(cpu, aggr)
> > +                total +=3D aggr
> > +        update_count(-1, total)
> > +        self.evlist.enable()
> > +
> > +
> > +    def on_mount(self) -> None:
> > +        """When App starts set up periodic event updating."""
> > +        self.update_counts()
> > +        self.set_interval(self.interval, self.update_counts)
> > +
> > +
> > +    def set_pmu_and_event(self, pmu: str, event: str) -> None:
> > +        """Updates the event/description and starts the counters."""
> > +        # Remove previous event information.
> > +        if self.evlist:
> > +            self.evlist.disable()
> > +            self.evlist.close()
> > +            lines =3D self.query(CounterSparkline)
> > +            for line in lines:
> > +                line.remove()
> > +            lines =3D self.query(Counter)
> > +            for line in lines:
> > +                line.remove()
> > +
> > +        def pmu_event_description(pmu: str, event: str) -> str:
> > +            """Find and format event description for {pmu}/{event}/.""=
"
> > +            def get_info(info: Dict[str, str], key: str):
> > +                return (info[key] + "\n") if key in info else ""
> > +
> > +            for p in perf.pmus():
> > +                if p.name() !=3D pmu:
> > +                    continue
> > +                for info in p.events():
> > +                    if "name" not in info or info["name"] !=3D event:
> > +                        continue
> > +
> > +                    desc =3D get_info(info, "topic")
> > +                    desc +=3D get_info(info, "event_type_desc")
> > +                    desc +=3D get_info(info, "desc")
> > +                    desc +=3D get_info(info, "long_desc")
> > +                    desc +=3D get_info(info, "encoding_desc")
> > +                    return desc
> > +            return "description"
> > +
> > +        # Parse event, update event text and description.
> > +        full_name =3D event if event.startswith(pmu) or ':' in event e=
lse f"{pmu}/{event}/"
> > +        self.query_one("#event_name", Label).update(full_name)
> > +        self.query_one("#event_description", Static).update(pmu_event_=
description(pmu, event))
> > +
> > +        # Open the event.
> > +        try:
> > +            self.evlist =3D perf.parse_events(full_name)
> > +            if self.evlist:
> > +                self.evlist.open()
> > +                self.evlist.enable()
> > +        except:
> > +            self.evlist =3D None
> > +
> > +        if not self.evlist:
> > +            self.push_screen(ErrorScreen(f"Failed to open {full_name}"=
))
> > +            return
> > +
> > +        # Add spark lines for all the CPUs. Note, must be done after
> > +        # open so that the evlist CPUs have been computed by propagate
> > +        # maps.
> > +        lines =3D self.query_one("#lines")
> > +        line =3D CounterSparkline(cpu=3D-1)
> > +        lines.mount(line)
> > +        for cpu in self.evlist.all_cpus():
> > +            line =3D CounterSparkline(cpu)
> > +            lines.mount(line)
> > +        line =3D Counter(cpu=3D-1)
> > +        lines.mount(line)
> > +        for cpu in self.evlist.all_cpus():
> > +            line =3D Counter(cpu)
> > +            lines.mount(line)
> > +
> > +
> > +    def compose(self) -> ComposeResult:
> > +        """Draws the app."""
> > +        def pmu_event_tree() -> Tree:
> > +            """Create tree of PMUs with events under."""
> > +            tree: Tree[str] =3D Tree("PMUs", id=3D"pmus")
> > +            tree.root.expand()
> > +            for pmu in perf.pmus():
> > +                pmu_name =3D pmu.name().lower()
> > +                pmu_node =3D tree.root.add(pmu_name, data=3Dpmu_name)
> > +                try:
> > +                    for event in sorted(pmu.events(), key=3Dlambda x: =
x["name"]):
> > +                        if "name" in event:
> > +                            e =3D event["name"].lower()
> > +                            if "alias" in event:
> > +                                pmu_node.add_leaf(f'{e} ({event["alias=
"]})', data=3De)
> > +                            else:
> > +                                pmu_node.add_leaf(e, data=3De)
> > +                except:
> > +                    # Reading events may fail with EPERM, ignore.
> > +                    pass
> > +            return tree
> > +
> > +        yield Header(id=3D"header")
> > +        yield Horizontal(Vertical(pmu_event_tree(), id=3D"events"),
> > +                         Vertical(Label("event name", id=3D"event_name=
"),
> > +                                  Static("description", markup=3DFalse=
, id=3D"event_description"),
> > +                                  ))
> > +        yield Label(id=3D"active_search")
> > +        yield VerticalScroll(id=3D"lines")
> > +        yield Footer(id=3D"footer")
> > +
> > +
> > +    @on(Tree.NodeSelected)
> > +    def on_tree_node_selected(self, event: Tree.NodeSelected[str]) -> =
None:
> > +        """Called when a tree node is selected, selecting the event.""=
"
> > +        if event.node.parent and event.node.parent.parent:
> > +            assert event.node.parent.data is not None
> > +            assert event.node.data is not None
> > +            self.set_pmu_and_event(event.node.parent.data, event.node.=
data)
> > +
> > +
> > +if __name__ =3D=3D "__main__":
> > +    ap =3D argparse.ArgumentParser()
> > +    ap.add_argument('-I', '--interval', help=3D"Counter update interva=
l in seconds", default=3D0.1)
> > +    args =3D ap.parse_args()
> > +    app =3D IListApp(float(args.interval))
> > +    app.run()
> > --
> > 2.50.0.727.gbf7dc18ff4-goog
> >
