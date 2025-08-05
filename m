Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA872BD032;
	Tue,  5 Aug 2025 23:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754435141; cv=none; b=SVGDnMiA5C8/bYHWJDzLp5bIQbo8LbyLbKup88Kvn3/k0pYmXBpZyUnccKWpOR78QySgzWnVl46aklpa0eEf480IdWFH+lqN71tONhsvicAS5KJIJt95RUVDhU8glFB+xTcRYKQ+kGu9KWZyH8h5LfgnnMbmMjWnEBztcHLGnuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754435141; c=relaxed/simple;
	bh=V3UeZ5y7KFTf/hUfhfs3bRqOlSC4p4X0ku4a2/kGZhs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NE/74CWtfRpQ3YiYKJQ6B2ZyfyFVokz3zgEJlHT2ERDvTnCMMgtm5uJS3cfrMOCLrmkz0yGHynyFqWtVUjQgBgGKS0W4bDGZORqnM5YEKosFE8GBbFdn++f8lst696zL631FC5z2u7trl0b89m577+H0kt852cf5ambnuomAET4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MY/xvHQD; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MY/xvHQD"
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e8fce318224so3808280276.3;
        Tue, 05 Aug 2025 16:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754435138; x=1755039938; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qZeHI7dUcBMgRSvgOo0Or+p8NT3V57UcIzIZx5BWQeQ=;
        b=MY/xvHQDrA5vIiM3ej6uCEA8Qo1qoTT2NMl4drcH8VL8t6UkZobeSuIyFz/cpbvfBb
         MmDciC2AzH0pyljQ+kHHFPQXWdO/LlgxDycXeVLWYQx5IUPzuud7ohLGjBYxfdIClLgh
         iIFBEEwp/Z/LIRYk+ELY0TKGrKOaUS9EPzpF4zJqZ9wocPUzo6bCypmsxO4TsCDUtfs7
         kuQTr0M+lwF0eZpJI6wwFoT8dPVYvfTL9XR1nOlp3uKJp1JRv9v32Q+P+oOutOt+or0t
         18qr5o2B8RlJan0j116y1jiaPVEJ9SMwKPIgQsdpa4tJ6SgJWGXe7zH4aUKQEMgS0JmD
         pFqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754435138; x=1755039938;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qZeHI7dUcBMgRSvgOo0Or+p8NT3V57UcIzIZx5BWQeQ=;
        b=I321ELQFLBIQ9ivg/mv72EJoo7ZL71MSqgf6JipDc/H5pAWGrPxbg7jLEf3dfKAW6V
         bQNP+Rbwj4TTaZxwbZisWhMmpZo721b9o8w4AO/nvvuwQJaKDsnDo6hkzm9G+drnDNcI
         FrHEYWaFykOYHcwWaOUImVl+PBwREMeNsB1IZ2z9mMHsx5xa94O7/UQeqOTrmu1Vam7S
         VfegEF2nvUS0bcoqRYZTS1UULIean7t/h/oGDY6OZF9OJR3L2YaumRADuin1tMnqqGZS
         ssntTG8KNFu0Njh58oPZFYwUJ4BlNMILMly+9hbAcjRGDweFZyGe81F4l4V7UNYOmfWV
         WsUA==
X-Forwarded-Encrypted: i=1; AJvYcCU3G8tb4NcCRHN0kDx3/Ug6Hry09QHO2BOU8RIWYt+OxlInj/KdPeCNgGtY4PmzeoiXfCBmu4EKYHUbL2uM01xW5w==@vger.kernel.org, AJvYcCW8tIzHoVukMBBeOEU8/foc1VYg7Pn5qR78NEyGGu6zUfrbT4kOJ1GI53Q7YqZDK9CAGxNAkKuv12VrwDw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPL8lO5kNJmMzK45THToJjQiTTY/7Q0wLqh+3r3EpbA8XBOQI2
	tr632/8FAKhboqRUSo79XhPzpuYA5jbvSobFu+9bf2DDQpx0nmI//X/o/nZYpej4z8ginaP37H+
	a0+xTBV9yUb/voDBiKii1rFOoKRzmEKw=
X-Gm-Gg: ASbGncuuWSYYC/P2ig8YWZfpStFKL1tNkbDEZeKLKuVUr/8Qubjk5edoWswJw57OKDd
	+/tnyS491fUWmKHVbwRbE0eh8TdhG7TTuDlw2qVczNvV4OG5o//DY5LoyHiFyv7hKQD412n2o4D
	/7dSQL7g1TZO1UK0GwJBsGk9aKZp+pSnRXiAHhAEvLO8ViKVxRhSHJqznym8b9FBrh2i5ct1QI/
	OWlUPZB
X-Google-Smtp-Source: AGHT+IGaMy4E8+DgiApio45fTRoyKoU1btRSm4LQs6goTzoRVaHx3J0dCfYXoDtkVbDrXnivEhFcmnMscVGxbOG3CtM=
X-Received: by 2002:a05:690c:4c10:b0:71a:1a7f:d7c4 with SMTP id
 00721157ae682-71bcc8422c1mr3071057b3.27.1754435137189; Tue, 05 Aug 2025
 16:05:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250725185202.68671-1-irogers@google.com> <20250725185202.68671-12-irogers@google.com>
In-Reply-To: <20250725185202.68671-12-irogers@google.com>
From: Howard Chu <howardchu95@gmail.com>
Date: Tue, 5 Aug 2025 16:05:26 -0700
X-Gm-Features: Ac12FXz3G1mh20zasu9bJ2ZcS1eyPWbg6YfYcSCaLacPy8H8KcYcEY18wfOKF9c
Message-ID: <CAH0uvojXcxp-GCF6JAcAvATvKjySQ_Wo5ciUfQoPotqA7+7YOA@mail.gmail.com>
Subject: Re: [PATCH v9 11/16] perf ilist: Add new python ilist command
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@linaro.org>, Xu Yang <xu.yang_2@nxp.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Collin Funk <collin.funk1@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Andi Kleen <ak@linux.intel.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Thomas Richter <tmricht@linux.ibm.com>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, Gautam Menghani <gautam@linux.ibm.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Chun-Tse Shao <ctshao@google.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Ian,

On Fri, Jul 25, 2025 at 11:52=E2=80=AFAM Ian Rogers <irogers@google.com> wr=
ote:
>
> The perf ilist command is a textual app [1] similar to perf list. In
> the top-left pane a tree of PMUs is displayed. Selecting a PMU expands
> the events within it. Selecting an event displays the `perf list`
> style event information in the top-right pane.
>
> When an event is selected it is opened and the counters on each CPU
> the event is for are periodically read. The bottom of the screen
> contains a scrollable set of sparklines showing the events in total
> and on each CPU. Scrolling below the sparklines shows the same data as
> raw counts. The sparklines are small graphs where the height of the
> bar is in relation to maximum of the other counts in the graph.
>
> By default the counts are read with an interval of 0.1 seconds (10
> times per second). A -I/--interval command line option allows the
> interval to be changed. The oldest read counts are dropped when the
> counts fill the line causing the sparkline to move from right to left.
>
> A search box can be pulled up with the 's' key. 'n' and 'p' iterate
> through the search results. As some PMUs have hundreds of events a 'c'
> key will collapse the events in the current PMU to make navigating the
> PMUs easier.

Maybe display sparklines on-demand and when not displayed fill the
whole window to the left with event names, this should make
parent-child relation more obvious, and displays as many lines of
event as the classic 'perf list'.

>
> [1] https://textual.textualize.io/
>
> Signed-off-by: Ian Rogers <irogers@google.com>
> Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/python/ilist.py | 385 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 385 insertions(+)
>  create mode 100755 tools/perf/python/ilist.py
>
> diff --git a/tools/perf/python/ilist.py b/tools/perf/python/ilist.py
> new file mode 100755
> index 000000000000..22c70a8b31f3
> --- /dev/null
> +++ b/tools/perf/python/ilist.py
> @@ -0,0 +1,385 @@
> +#!/usr/bin/env python3
> +# SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
> +"""Interactive perf list."""
> +
> +import argparse
> +from typing import Any, Dict, Optional, Tuple
> +import perf
> +from textual import on
> +from textual.app import App, ComposeResult
> +from textual.binding import Binding
> +from textual.containers import Horizontal, HorizontalGroup, Vertical, Ve=
rticalScroll
> +from textual.command import SearchIcon
> +from textual.screen import ModalScreen
> +from textual.widgets import Button, Footer, Header, Input, Label, Sparkl=
ine, Static, Tree
> +from textual.widgets.tree import TreeNode
> +
> +
> +class ErrorScreen(ModalScreen[bool]):
> +    """Pop up dialog for errors."""
> +
> +    CSS =3D """
> +    ErrorScreen {
> +        align: center middle;
> +    }
> +    """
> +
> +    def __init__(self, error: str):
> +        self.error =3D error
> +        super().__init__()
> +
> +    def compose(self) -> ComposeResult:
> +        yield Button(f"Error: {self.error}", variant=3D"primary", id=3D"=
error")
> +
> +    def on_button_pressed(self, event: Button.Pressed) -> None:
> +        self.dismiss(True)
> +
> +
> +class SearchScreen(ModalScreen[str]):
> +    """Pop up dialog for search."""
> +
> +    CSS =3D """
> +    SearchScreen Horizontal {
> +        align: center middle;
> +        margin-top: 1;
> +    }
> +    SearchScreen Input {
> +        width: 1fr;
> +    }
> +    """
> +
> +    def compose(self) -> ComposeResult:
> +        yield Horizontal(SearchIcon(), Input(placeholder=3D"Event name")=
)
> +
> +    def on_input_submitted(self, event: Input.Submitted) -> None:
> +        """Handle the user pressing Enter in the input field."""
> +        self.dismiss(event.value)
> +
> +
> +class Counter(HorizontalGroup):
> +    """Two labels for a CPU and its counter value."""
> +
> +    CSS =3D """
> +    Label {
> +        gutter: 1;
> +    }
> +    """
> +
> +    def __init__(self, cpu: int) -> None:
> +        self.cpu =3D cpu
> +        super().__init__()
> +
> +    def compose(self) -> ComposeResult:
> +        label =3D f"cpu{self.cpu}" if self.cpu >=3D 0 else "total"
> +        yield Label(label + " ")
> +        yield Label("0", id=3Df"counter_{label}")
> +
> +
> +class CounterSparkline(HorizontalGroup):
> +    """A Sparkline for a performance counter."""
> +
> +    def __init__(self, cpu: int) -> None:
> +        self.cpu =3D cpu
> +        super().__init__()
> +
> +    def compose(self) -> ComposeResult:
> +        label =3D f"cpu{self.cpu}" if self.cpu >=3D 0 else "total"
> +        yield Label(label)
> +        yield Sparkline([], summary_function=3Dmax, id=3Df"sparkline_{la=
bel}")
> +
> +
> +class IListApp(App):
> +    TITLE =3D "Interactive Perf List"
> +
> +    BINDINGS =3D [
> +        Binding(key=3D"s", action=3D"search", description=3D"Search",
> +                tooltip=3D"Search events and PMUs"),
> +        Binding(key=3D"n", action=3D"next", description=3D"Next",
> +                tooltip=3D"Next search result or item"),
> +        Binding(key=3D"p", action=3D"prev", description=3D"Previous",
> +                tooltip=3D"Previous search result or item"),
> +        Binding(key=3D"c", action=3D"collapse", description=3D"Collapse"=
,
> +                tooltip=3D"Collapse the current PMU"),
> +        Binding(key=3D"^q", action=3D"quit", description=3D"Quit",
> +                tooltip=3D"Quit the app"),

Some people use the terminal in vscode, where ^q is occupied, I'd
imagine for emacs users ^q is entering raw characters, so it doesn't
work in eterm either, why not just q?

Thanks,
Howard
