Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73CF3E123E
	for <linux-perf-users@vger.kernel.org>; Fri, 24 Apr 2026 17:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777050887; cv=none; b=UNCr2gGk9Kbz0oU4xGA3pVcWLN9KqD4j7MSfvA8rTCKYJH5WnmwbF9ExAnh+SLn9Z8XX3gL6JSeWJlcP7NPb/sythkTVwSpZxeLBna7M7wVLWWZpGaJOOEV3QqXSHftNNXAST0eQ46q/UF1T2wzJOXAuiDjfhxiRTDBtslJ13cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777050887; c=relaxed/simple;
	bh=kCeMAu8SvIF/1IhrqSJ+rJZDxPvzq2otY5psLZE9hvQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pvGcXn3JIEl/wTOxoiqAq6LqfaGo61nIoYJtLHr+O0/EfOev9c0hnUJjjprYiHO5JOihwS+IBWC08THojOUvh+pj4rRzKQp1sUdALW37Byp6nDGVb/S9pp6hSwj86SBIQR71hA2Bx/EBI4MYGaw2IKxkgKgScrU5NzSscDM9SxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fLQpwmOu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fLQpwmOu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64C0DC19425;
	Fri, 24 Apr 2026 17:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777050887;
	bh=kCeMAu8SvIF/1IhrqSJ+rJZDxPvzq2otY5psLZE9hvQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=fLQpwmOuWPoKPnYTrkxwVyMpQ219wA0eN7zzOsNlZGibkESpDOAlLjBU/G3Yv6XRZ
	 UWylWMn/VG7+uPHe9SyhY+a4dIB1/EP0BJSfTt6ssKQw18IdpNNtZaFSz+NCV4GHDr
	 O4eyRA71Gdy4oclaixNasVrK/sdsLnRp2C6IY7VXfO0Y8KIxZ0HCQp6UE1ACbbx57+
	 X3smszMZ+2ZXGEQyFN6SSMsXqGiu1oUX3Mz8PujfHOHwj5rRi/dUKNjjw3WVr/ekme
	 qzqGF0vUsX2lOmk1uhgwKSUoEDBEgwdP+zKtLAeb+jD25vjQ2CaljSCGbr81bwhjJQ
	 dNCRBlLdIPsvw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 50/58] perf rwtop: Port rwtop to use python module
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260424164721.2229025-51-irogers@google.com>
References: <20260424164721.2229025-51-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Apr 2026 17:14:46 +0000
Message-Id: <20260424171447.64C0DC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 5 potential issue(s):
- [Medium] The commit message claims to use ANSI escape codes to clear the =
terminal, but the code does not implement this.
- [Medium] The fallback events for `raw_syscalls` use invalid tracepoint na=
mes.
- [Medium] Command name (comm) resolution is completely broken in live mode.
- [Medium] Read and write system calls returning 0 (such as EOF) are incorr=
ectly tracked as errors.
- [Medium] Process names (`comm`) will be missing from the output for cross=
-interval events.
--

commit 54cf450fd705476f413ab144cabc91c84a299a63
Author: Ian Rogers <irogers@google.com>

perf rwtop: Port rwtop to use python module

This commit ports the legacy rwtop.pl Perl script to a Python script
using the perf module. It leverages the perf.session API for event
processing to display system-wide read and write call activity periodically.

> - Used ANSI escape codes (\x1b[H\x1b[2J) to clear the terminal.

Is this description accurate?

Looking at print_totals() in the code, there do not appear to be any ANSI
escape sequences emitted. This results in the terminal scrolling continuous=
ly
instead of clearing.

> diff --git a/tools/perf/python/rwtop.py b/tools/perf/python/rwtop.py
> new file mode 100755
> index 00000000000000..952d178e99c5a1
> --- /dev/null
> +++ b/tools/perf/python/rwtop.py
[ ... ]
> +    def process_event(self, sample: perf.sample_event) -> None:  # pylin=
t: disable=3Dtoo-many-branches
> +        """Process events."""
> +        event_name =3D str(sample.evsel)
> +        pid =3D sample.sample_pid
> +        sample_time =3D sample.sample_time
> +
> +        if self.last_print_time =3D=3D 0:
> +            self.last_print_time =3D sample_time
> +
> +        # Check if interval has passed
> +        if sample_time - self.last_print_time >=3D self.interval_ns:
> +            self.print_totals()
> +            self.last_print_time =3D sample_time
> +
> +        try:
> +            comm =3D f"PID({pid})" if not self.session else self.session=
.process(pid).comm()
> +        except Exception:  # pylint: disable=3Dbroad-except
> +            comm =3D f"PID({pid})"

Will process names resolve correctly in live mode?

When running with the LiveSession path in main(), self.session is never
initialized. It appears this will always fall back to printing the PID inst=
ead
of the command name.

[ ... ]
> +        elif event_name in ("evsel(syscalls:sys_exit_read)", "evsel(raw_=
syscalls:sys_exit_read)"):
> +            try:
> +                ret =3D sample.ret
> +                if ret > 0:
> +                    self.reads[pid]["bytes_read"] +=3D ret
> +                else:
> +                    self.reads[pid]["errors"][ret] +=3D 1

Does this incorrectly classify EOF as an error?

A return value of 0 indicates End-Of-File for reads, which is a normal
operational state, whereas actual syscall errors return negative values.

[ ... ]
> +        elif event_name in ("evsel(syscalls:sys_exit_write)", "evsel(raw=
_syscalls:sys_exit_write)"):
> +            try:
> +                ret =3D sample.ret
> +                if ret > 0:
> +                    self.writes[pid]["bytes_written"] +=3D ret
> +                else:
> +                    self.writes[pid]["errors"][ret] +=3D 1

Similarly for writes, a return value of 0 indicates 0 bytes written.

Should this be checking for ret >=3D 0 instead, or strictly tracking negati=
ve
values as errors?

[ ... ]
> +    def print_totals(self) -> None:
[ ... ]
> +        # Reset counts
> +        self.reads.clear()
> +        self.writes.clear()

Will this result in missing process names for syscalls that span across
interval boundaries?

Because the dictionaries are cleared completely, if a sys_exit event arrives
in the new interval without a preceding sys_enter, the defaultdict will
recreate the entry with an empty string for comm. The summary table might
then display a blank command name for that pid.

[ ... ]
> +def main() -> None:
[ ... ]
> +            try:
> +                live_session =3D LiveSession(events, sample_callback=3Da=
nalyzer.process_event)
> +            except OSError:
> +                events =3D (
> +                    "raw_syscalls:sys_enter_read,raw_syscalls:sys_exit_r=
ead,"
> +                    "raw_syscalls:sys_enter_write,raw_syscalls:sys_exit_=
write"
> +                )

Are these fallback tracepoint names valid?

The raw_syscalls subsystem only exposes generic sys_enter and sys_exit
tracepoints. It does not append the syscall name, so attempting to attach
to raw_syscalls:sys_enter_read will fail.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260424164721.2229=
025-1-irogers@google.com?part=3D50
