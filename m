Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F5713A3ED
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Apr 2026 00:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776645969; cv=none; b=FoqSaRNyK2fgVwd71xKyFv/+jFuLdtrbc6W2zJPMUNGy3Zdm/BsEBWso1Zq0yb1nSOUsX3zOgogPmhTbju7Nv8l+6UkAUYq8Lcb4t6N+mnhf2GM9TKafDH18barA8yf6AW9vjRWWMywOuWy8hocGPUpnDplnabUZY18CVR2c004=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776645969; c=relaxed/simple;
	bh=cd3VCUnsdu0pi/Wj8vv9T7DLCih+Kq8gBck9jNsX8RM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=c/AEUnmJ+JjY1+Qq+pqfbn+gZ3gCpu+JujVDBmS7DxnIJMh0e94jkZIFjvePLVFKCp2LJyAEuwAbkCYawJgQe9yX0kjpdNTnB/qLaRnmXknWvP6mtTH3Qs4Fv2QrqC5NTY3N1MijVKTxxu8Q9A4/MM/w7zgZjX+abDOGzsWwFco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dw6NWfOW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dw6NWfOW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCFD0C2BCAF;
	Mon, 20 Apr 2026 00:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776645969;
	bh=cd3VCUnsdu0pi/Wj8vv9T7DLCih+Kq8gBck9jNsX8RM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=dw6NWfOWubfigOGh4dvH0tbGGuWwbZNRbxW7Z9SXfSlr8NKt5WMiBYqigcGDvOxf0
	 9pYp0s20lePaC16/eUlRCSaeLuZKGy9jajAYb8r8r3heV80Bi/G0uhhJHGY7Au9rBh
	 5j1YZm7OQkPTAkkYO1cmxjY7ih5lxSGnDgfygVcpPjM3EVdo8IuC/lJ/EtfuBG1ib2
	 /wmCwCDU5I3nry3Iwv3983fpN3X+7lCNpbLnJqEKOYSlwNtxXCQBqA58tbK9ySCG30
	 AuGKaabm5KNgockwPuUxoFIZ5NJvy28SzCVfQ7PJcqaruqIrJ6DDlhB/Ij2zvQCnIZ
	 ZL/ZxDOBjNXIA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 46/58] perf task-analyzer: Port task-analyzer to use
 python module
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260419235911.2186050-47-irogers@google.com>
References: <20260419235911.2186050-47-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Apr 2026 00:46:08 +0000
Message-Id: <20260420004608.DCFD0C2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 7 potential issue(s):
- [High] Incomplete implementation of the summary feature
- [High] Unbounded memory growth in live mode with summary enabled
- [Medium] Process ID (TGID) is incorrectly tracked as Thread ID (TID)
- [Medium] ANSI color escape codes are injected into CSV output
- [Medium] Conflicting headers and delimiters corrupt the CSV output
- [Medium] Mutually exclusive filter arguments (limit-to-tasks is ignored)
- [Medium] Task history lists are erroneously truncated for extended/only s=
ummary options
--

commit 5635b811218ca3b0adbc654f9a41d8a9897ae75b
Author: Ian Rogers <irogers@google.com>

perf task-analyzer: Port task-analyzer to use python module

This commit ports task-analyzer.py to the perf.session python module
and refactors it into a class-based architecture. It adds support for live
mode and file mode while keeping previous command-line options.

> diff --git a/tools/perf/python/task-analyzer.py b/tools/perf/python/task-=
analyzer.py
> new file mode 100755
> index 0000000000000..beb1892c4aad9
> --- /dev/null
> +++ b/tools/perf/python/task-analyzer.py

[ ... ]

> +    def _check_color(self) -> None:
> +        """Check if color should be enabled."""
> +        if sys.stdout.isatty() and self.args.stdio_color !=3D "never":
> +            return
> +        TaskAnalyzer._COLORS =3D {k: "" for k in TaskAnalyzer._COLORS}

Does this inject ANSI color escape codes into the CSV output?

When using --csv, sys.stdout might still be attached to a terminal even
though the tabular data is written to a file. This would cause the check to
pass and corrupt the CSV fields with color codes.

[ ... ]

> +    def _record_cleanup(self, _list: list[Any]) -> list[Any]:
> +        if not self.args.summary and len(_list) > 1:
> +            return _list[len(_list) - 1:]
> +        return _list

Should this check include self.args.summary_extended and
self.args.summary_only?

If those flags are used without --summary, the arrays are prematurely
truncated, which might break calculations that rely on the full history.

Could this also cause unbounded memory growth in live mode?

If self.args.summary is set, _record_cleanup() doesn't truncate the lists.
Since _run_live() runs an infinite loop, it looks like the self.db arrays
will grow forever and eventually exhaust memory.

[ ... ]

> +    def _limit_filtered(self, tid: int, pid: int, comm: str) -> bool:
> +        """Filter tasks based on CLI arguments."""
> +        if self.args.filter_tasks:
> +            if (str(tid) in self.args.filter_tasks or
> +                str(pid) in self.args.filter_tasks or
> +                comm in self.args.filter_tasks):
> +                return True
> +            return False
> +        if self.args.limit_to_tasks:
> +            if (str(tid) in self.args.limit_to_tasks or
> +                str(pid) in self.args.limit_to_tasks or
> +                comm in self.args.limit_to_tasks):
> +                return False
> +            return True
> +        return False

Are --filter-tasks and --limit-to-tasks meant to be mutually exclusive?

If self.args.filter_tasks is specified but no match is found, the function
returns False early, meaning the limit_to_tasks check is unreachable.

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
> +
> +        next_comm =3D self._filter_non_printable(next_comm)
> +
> +        # Task finish for previous task
> +        self._handle_task_finish(prev_pid, common_cpu, time_ns, prev_pid)

Are we incorrectly tracking the Thread ID (TID) as the Process ID (TGID) he=
re?

sample.prev_pid corresponds to the kernel's thread ID, but it's passed as
both the tid and pid arguments to _handle_task_finish(). This loses the
actual Process ID information and breaks the PID column output.

[ ... ]

> +    def print_summary(self) -> None:
> +        """Calculate and print summary."""
> +        if not (self.args.summary or self.args.summary_extended or self.=
args.summary_only):
> +            return
> +
> +        # Simplified summary logic for brevity, full logic can be ported=
 if needed
> +        print("\nSummary (Simplified)", file=3Dself.fd_sum)
> +        if self.args.summary_extended:
> +            print("Inter Task Times", file=3Dself.fd_sum)
> +        # ... port full Summary class logic here ...

Does this intentionally omit the full summary logic?

The --summary flags seem to be broken compared to the legacy version because
the actual calculation and output are missing.

[ ... ]

> +    def run(self) -> None:
> +        """Run the session."""
> +        with self.open_output(self.args.csv, sys.stdout) as fd_task:
> +            with self.open_output(self.args.csv_summary, sys.stdout) as =
fd_sum:
> +                self.fd_task =3D fd_task
> +                self.fd_sum =3D fd_sum
> +                if self.args.csv:
> +                    fd_task.write("Comm;Out-Out;\n")
> +                if self.args.csv_summary:
> +                    fd_sum.write("Comm;Out-Out;\n")
> +
> +                if not os.path.exists(self.args.input) and self.args.inp=
ut =3D=3D "perf.data":
> +                    self._run_live()
> +                else:
> +                    self._run_file()

Does this corrupt the CSV file by writing two conflicting headers?

This writes a hardcoded header with a semicolon delimiter, but immediately
after, _run_file() calls _print_header() which writes comma-separated
headers. This leaves the file with multiple contradictory headers.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260419235911.2186=
050-1-irogers@google.com?part=3D46
