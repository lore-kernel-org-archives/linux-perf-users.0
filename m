Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F308364925
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 18:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777141098; cv=none; b=LJNYXhjP/DwjYxROWS5drE95XsUaQptAIPUMZ3vyQhr2qCZp5lr+K7rVAa7cIzHVFK6hYAdCnSVcmpYX/xpQrgtqV7OJngMgASoeGkBmzkchC7Pccx/BZpbybb07uT3jYiE1mHoIzmh0+WvzgNK9VdQcYagXpRVrG/+83bHXM/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777141098; c=relaxed/simple;
	bh=N64KtZY3IC5w9LWlrRTPesYD7p+yN5vh/0eJg8T8G9Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MlPvWncB7HrL5YY0eGim/2OmeE/ImmF+UqsMj67z+rEJk/eeA//c7wqM1LYbO01wY096SIGzGYZPVqRn5KowBMuTgftIksnyotmjTnn8En02ZaMois9fKtYWNaBBngnvsWR5guLKCUPwlFRXKiu1j2TNXj/QdmViIxBWaZV2oj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YKQWB3eA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YKQWB3eA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F09EC2BCB0;
	Sat, 25 Apr 2026 18:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777141098;
	bh=N64KtZY3IC5w9LWlrRTPesYD7p+yN5vh/0eJg8T8G9Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=YKQWB3eAU9Oiut3SvF7CCCgMvGe55ip/48GkwAydLqgaQHED+CqODWW3QuPadCU0e
	 3TBhbSww5fuVuy6ZfScGWIVK3k94gUQasYkGtYv879hti9TWYUpHeOMUX9Y0dohSiL
	 KOk6nUfh4uAESr6uLEWfERPvaWHRZeX2sbGX9z/nVnqWdw5tzjXKfF/JW/q0SRQJsL
	 zCMkFS6rvG+/nkJQO2q3Q/e3wsACgrVq/YrYnwd65CaeC4F+Ba+ZzWeu2xLDJM6CPb
	 otL3kxjdg+K/Sfobd3iaJlKqPVyITP3n3dCQS7cadvxoJ15Z0UdGrTaJZjlC8WImL7
	 fklZo74w73jyw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 46/59] perf task-analyzer: Port task-analyzer to use
 python module
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260425174858.3922152-47-irogers@google.com>
References: <20260425174858.3922152-47-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Apr 2026 18:18:17 +0000
Message-Id: <20260425181818.0F09EC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 7 potential issue(s):
- [High] The `print_summary` method is implemented as a placeholder stub, r=
emoving actual summary processing.
- [High] Script crashes with an `AttributeError` when a task's thread is no=
t found in the perf session.
- [High] Live mode processes events out of chronological order, corrupting =
inter-task time tracking.
- [Medium] Trace lists are unconditionally truncated to 1000 items, causing=
 inaccurate summaries.
- [Low] Missing CLI argument validation causes unhandled `ValueError` and `=
KeyError` crashes.
- [Low] The CSV separator character was silently changed from a semicolon (=
`;`) to a comma (`,`).
- [Low] The `--stdio-color always` argument is ignored when standard output=
 is piped.
--

commit 5196cbf2ad4b6c11d39c0a5d7c84c508146141e7
Author: Ian Rogers <irogers@google.com>

perf task-analyzer: Port task-analyzer to use python module

This commit ports task-analyzer.py to tools/perf/python and refactors it
to a class-based architecture. It also adds support for file mode using
perf.session and live mode using evlist.read_on_cpu.

> diff --git a/tools/perf/python/task-analyzer.py b/tools/perf/python/task-=
analyzer.py
> new file mode 100755
> index 000000000000..08e44946fe6a
> --- /dev/null
> +++ b/tools/perf/python/task-analyzer.py

[ ... ]

> +    def _check_color(self) -> None:
> +        """Check if color should be enabled."""
> +        if self.args.csv or self.args.csv_summary:
> +            TaskAnalyzer._COLORS =3D {k: "" for k in TaskAnalyzer._COLOR=
S}
> +            return
> +        if sys.stdout.isatty() and self.args.stdio_color !=3D "never":
> +            return
> +        TaskAnalyzer._COLORS =3D {k: "" for k in TaskAnalyzer._COLORS}

If standard output is piped, sys.stdout.isatty() is false, which causes the
color mappings to be cleared. Does this unintentionally ignore the=20
--stdio-color always argument?

[ ... ]

> +    def _prepare_fmt_sep(self) -> tuple[str, int]:
> +        if self.args.csv or self.args.csv_summary:
> +            return ",", 0
> +        return " ", 1

This isn't a bug, but the CSV separator was changed from a semicolon to a
comma. Was this change intentional?

[ ... ]

> +    def _record_cleanup(self, _list: list[Any]) -> list[Any]:
> +        need_summary =3D (self.args.summary or self.args.summary_extende=
d or
> +                        self.args.summary_only)
> +        if not need_summary and len(_list) > 1:
> +            return _list[len(_list) - 1:]
> +        if len(_list) > 1000:
> +            return _list[len(_list) - 1000:]
> +        return _list

Does truncating the list to 1000 items silently discard task occurrences=20
during file-based processing?=20

It seems this might cause the subsequent summary calculations to only analy=
ze
a small fraction of large traces, leading to inaccurate statistics.

[ ... ]

> +    def _is_within_timelimit(self, time_ns: int) -> bool:
> +        if not self.args.time_limit:
> +            return True
> +        time_s =3D decimal.Decimal(time_ns) / decimal.Decimal(1e9)
> +        lower_bound, upper_bound =3D self.args.time_limit.split(":")

Does this split operation raise an unhandled ValueError if the user provide=
s=20
malformed input without a colon, such as --time-limit 123?

[ ... ]

> +    def process_event(self, sample: perf.sample_event) -> None:
> +        """Process sched:sched_switch events."""
> +        if "sched:sched_switch" not in str(sample.evsel):
> +            return
> +
> +        time_ns =3D sample.sample_time
> +        if not self._is_within_timelimit(time_ns):
> +            return

[ ... ]

> +        # Task finish for previous task
> +        if self.session:
> +            prev_tgid =3D self.session.find_thread(prev_pid).pid  # type=
: ignore
> +        else:
> +            prev_tgid =3D prev_pid # Fallback

If a thread is missing due to lost events or tracing starting after process=
=20
initialization, find_thread() can return None. Will accessing .pid here=20
raise an unhandled AttributeError and crash the analysis?

> +        self._handle_task_finish(prev_pid, common_cpu, time_ns, prev_tgi=
d)
> +        # Task start for next task
> +        self._handle_task_start(next_pid, common_cpu, next_comm, time_ns)
> +
> +    def print_summary(self) -> None:
> +        """Calculate and print summary."""
> +        need_summary =3D (self.args.summary or self.args.summary_extende=
d or
> +                        self.args.summary_only or self.args.csv_summary)
> +        if not need_summary:
> +            return
> +
> +        # Simplified summary logic for brevity, full logic can be ported=
 if needed
> +        print("\nSummary (Simplified)", file=3Dself.fd_sum)
> +        if self.args.summary_extended:
> +            print("Inter Task Times", file=3Dself.fd_sum)
> +        # ... port full Summary class logic here ...

The summary processing appears to be replaced with a stub that only prints
placeholders. Does this cause the --summary and --summary-extended arguments
to lose their expected functionality?

[ ... ]

> +    def _run_live(self) -> None:
> +        if not self.args.summary_only:
> +            self._print_header()
> +
> +        cpus =3D perf.cpu_map()
> +        threads =3D perf.thread_map(-1)
> +        evlist =3D perf.parse_events("sched:sched_switch", cpus, threads)
> +        evlist.config()
> +
> +        evlist.open()
> +        evlist.mmap()
> +        evlist.enable()
> +
> +        print("Live mode started. Press Ctrl+C to stop.", file=3Dsys.std=
err)
> +        try:
> +            while True:
> +                evlist.poll(timeout=3D-1)
> +                for cpu in cpus:
> +                    while True:
> +                        event =3D evlist.read_on_cpu(cpu)
> +                        if not event:
> +                            break
> +                        if not isinstance(event, perf.sample_event):
> +                            continue
> +                        self.process_event(event)

By draining each CPU's ring buffer entirely before moving to the next, are=
=20
the events processed out of chronological order?=20

The Timespans class expects chronological occurrences, so processing them=20
sequentially by CPU might corrupt the time tracking and result in negative
inter-task times.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260425174858.3922=
152-1-irogers@google.com?part=3D46
