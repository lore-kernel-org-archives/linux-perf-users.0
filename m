Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7101F38F62A
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 23:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777158693; cv=none; b=n91QbBPZBraSN5BLlxsVoz9ilAV20mlb+bLsRNOegCmZqrHGgkzPrSq3raUEOxkC/Va5kBFnD3PJ2T8UNCh2PydXWNi3Yez6Fs+kmaI/rVmNMBIoXUkONh+ff3pXctASgIiiSxP/vu5QDd2TBfv7LmkgYXyZhq/51TepM7aS3/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777158693; c=relaxed/simple;
	bh=rpeeLYsRxaU1RKa8SNy2RiY9dVujNM2DA1WZLs+0WO0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IPx/bzNpgFUE8wrtAfBAtq5K0rMEpK6RZB6YfmsTqwEBCZNXqVKFDOGqCv1UprhCZWcT3r33k4z0+7PPVM2oZ+KXKkLtYDAeAHXMS6Hl98Wy5KkcgJZzs6ddp7Ao3U9MiVOlDoPD3/RUEVqnb+PZjUOBDaq5eME1FzGqgZl2a3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=THk3VxLM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="THk3VxLM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDC44C2BCB0;
	Sat, 25 Apr 2026 23:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777158692;
	bh=rpeeLYsRxaU1RKa8SNy2RiY9dVujNM2DA1WZLs+0WO0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=THk3VxLM1Lax2WUI+9aMjwMR/FJZIFTUucYqFQ1yXPAEqidIlq6vGJOUabUzcDLjr
	 P5M2xqMZ5fHCZs4ThHUFMgAPB8Hxt4ULUC6hXnUUQ4kXeiduFwyqHAHcbVUQmKEvJG
	 5ua1L8lvcp+pVy2Dun9z5Aoq5dHjQlomWDhyuqhyiyX5SsKb1yvcgkxWegDpgEnWT5
	 curUJ7NE2xS2An7ga1TaEd8XBgiWyakOfRvMniN/SviHc0NENzwJfyE7rMXn2p7hG6
	 HwnryECaSyrNeShjqSMVaS1jCW9T9KBElmE9kM+p5sZIyHyEUht90woLVginjU1KX/
	 djt3HzKzO5LMw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 46/59] perf task-analyzer: Port task-analyzer to use
 python module
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260425224951.174663-47-irogers@google.com>
References: <20260425224951.174663-47-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Apr 2026 23:11:32 +0000
Message-Id: <20260425231132.BDC44C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 8 potential issue(s):
- [High] Silent failure masking all functionality: 'sample_cpu' raises Attr=
ibuteError, dropping all events.
- [High] Crash on '.pid' attribute access on 'perf.thread' object.
- [High] Uncaught TypeError when thread is not found.
- [Medium] Argument parsing crash on '--time-limit' without a colon.
- [Medium] Using '--csv-summary' incorrectly alters standard trace output f=
ormatting.
- [Medium] Incomplete implementation of '--summary' feature.
- [Medium] Memory leak in live mode for long-running sessions.
- [Low] CSV output format breakage.
--

commit d15ac90af17406fb7c1e541648eac0f9cca7e087
Author: Ian Rogers <irogers@google.com>

perf task-analyzer: Port task-analyzer to use python module

This commit ports task-analyzer.py to tools/perf/python, transitioning
it to a class-based architecture. It adds support for both file mode
and live mode.

> diff --git a/tools/perf/python/task-analyzer.py b/tools/perf/python/task-=
analyzer.py
> new file mode 100755
> index 000000000000..08e44946fe6a
> --- /dev/null
> +++ b/tools/perf/python/task-analyzer.py

[ ... ]

> +    def _prepare_fmt_sep(self) -> tuple[str, int]:
> +        if self.args.csv or self.args.csv_summary:
> +            return ",", 0
> +        return " ", 1

If a user requests a CSV summary via --csv-summary but wants standard trace
output on stdout, will this cause the primary trace output to unintentional=
ly
use a comma separator as well?

[ ... ]

> +    def _record_by_tid(self, task: Task) -> None:
> +        tid =3D task.tid
> +        if tid not in self.db["tid"]:
> +            self.db["tid"][tid] =3D []
> +        self.db["tid"][tid].append(task)
> +        self.db["tid"][tid] =3D self._record_cleanup(self.db["tid"][tid])

While _record_cleanup() bounds the list length per TID, it doesn't appear
to evict old TIDs from self.db["tid"] when threads terminate. In a continuo=
us
live trace, could this dictionary grow linearly over time and cause unbound=
ed
memory usage?

[ ... ]

> +    def _is_within_timelimit(self, time_ns: int) -> bool:
> +        if not self.args.time_limit:
> +            return True
> +        time_s =3D decimal.Decimal(time_ns) / decimal.Decimal(1e9)
> +        lower_bound, upper_bound =3D self.args.time_limit.split(":")

If a user provides a single-value string without a colon (e.g.,
--time-limit 12345), won't split(":") return a single-element list and
trigger a ValueError?

[ ... ]

> +    def process_event(self, sample: perf.sample_event) -> None:
> +        """Process sched:sched_switch events."""
> +        if "sched:sched_switch" not in str(sample.evsel):
> +            return
> +
> +        time_ns =3D sample.sample_time
> +        if not self._is_within_timelimit(time_ns):
> +            return
> +
> +        # Access tracepoint fields directly from sample object
> +        try:
> +            prev_pid =3D sample.prev_pid
> +            next_pid =3D sample.next_pid
> +            next_comm =3D sample.next_comm
> +            common_cpu =3D sample.sample_cpu
> +        except AttributeError:
> +            # Fallback or ignore if fields are not available
> +            return

Since the C extension defines this field as sample.cpu rather than
sample.sample_cpu, won't accessing sample.sample_cpu unconditionally
raise an AttributeError?

If so, the generic except AttributeError block will silently ignore the
error and return, causing the script to drop all events.

> +
> +        next_comm =3D self._filter_non_printable(next_comm)
> +
> +        # Task finish for previous task
> +        if self.session:
> +            prev_tgid =3D self.session.find_thread(prev_pid).pid  # type=
: ignore

Does the perf.thread C extension object expose a .pid attribute? Looking at
pyrf_thread__type in python.c, it seems to only define a .comm() method,
which would cause an AttributeError here.

Additionally, if self.session.find_thread() cannot find the thread, it
raises a TypeError. Because there is no try/except TypeError block here,
could tracing untracked PIDs crash the script?

> +        else:
> +            prev_tgid =3D prev_pid # Fallback
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

It looks like the original comprehensive statistics logic was replaced
with a stub. Are there plans to port the full summary logic, as the
comment suggests?

[ ... ]

> diff --git a/tools/perf/tests/shell/test_task_analyzer.sh b/tools/perf/te=
sts/shell/test_task_analyzer.sh
> index 0314412e63b4..7465298d0384 100755
> --- a/tools/perf/tests/shell/test_task_analyzer.sh
> +++ b/tools/perf/tests/shell/test_task_analyzer.sh

[ ... ]

>  test_csv() {
> -	perf script report task-analyzer --csv "${csv}" > /dev/null
> -	check_exec_0 "perf script report task-analyzer --csv ${csv}"
> -	find_str_or_fail "Comm;" "${csv}" "${FUNCNAME[0]}"
> +	$PYTHON $perfdir/python/task-analyzer.py -i "${perfdata}" --csv "${csv}=
" > /dev/null
> +	check_exec_0 "$PYTHON $perfdir/python/task-analyzer.py -i ${perfdata} -=
-csv ${csv}"
> +	find_str_or_fail "Comm," "${csv}" "${FUNCNAME[0]}"
>  }

This isn't a bug, but the CSV delimiter was changed from a semicolon to a
comma. Could this break external parsers that rely on the previous
separator format?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260425224951.1746=
63-1-irogers@google.com?part=3D46
