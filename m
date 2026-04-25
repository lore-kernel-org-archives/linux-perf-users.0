Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541DD183CC3
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 23:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777158416; cv=none; b=WXMMmiLHiF12UzLwzukbEDTeTocldFrwiMm3gkUGDcX9dAShb+TFFMqNeCtDXvxbyrbrCh/QMcnPTqnmCuZN0iW5gz6Wx64QU/sbFpzsVj7o+zV1oQ/3eY+D5B1w+jkhQnIe6iLyfPUAWx/8nwxIkDq6Xg+6c6FPDk2coxkuq+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777158416; c=relaxed/simple;
	bh=a7p8WubM9jKjtUdNlWr6SOvrXmp1jus0dVSpmuHDHZY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QNW4LzgGO0z0hi+USSzB3BjvhNnmVo6iiIEX+xHaK/MS9q5KmTDET2jtTeA22ncsUxBepOI56Olx2oYeqwJ1Urrpit43ZSPn2XorOVzdPVFMf5n5fZVu3aIm5ikI4HXxo6LvzXNEQZe1sS+xga9ZjDt9j+vgGQSWQpEr+nMO0WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I+AXqAi6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I+AXqAi6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E78D6C2BCB0;
	Sat, 25 Apr 2026 23:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777158416;
	bh=a7p8WubM9jKjtUdNlWr6SOvrXmp1jus0dVSpmuHDHZY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=I+AXqAi6soLc2C/c1XZpxwT9FM/85+eIocy9roMDVomscz5fInRXGuR+0VVWveqJ3
	 8med8x6hSGsYCb/S5hu9t1GbaJQldSJZ7wpiO6mteP56xg05Z7usz8Rmx8gKGzKoxc
	 cKVpqmHg6wmwnfeiE7QqjHgI54h5bD4cJKZxMKP0Tc8tFflf2lXD8EbKiYt3sBEotT
	 LMmohpFMBrLFdxQ0O07jpY79fffHfs0qAGNAYrdebxxCn8NCpt4hNik/ZHZFkLqXvY
	 6swVCv+EBt1FPQibwC207fGlyYH0kZo4LppuBOdBFEMUHX7k323vkHX/AOCZ4O1j1o
	 /2wgMD//iWRHw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 50/59] perf rwtop: Port rwtop to use python module
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260425224951.174663-51-irogers@google.com>
References: <20260425224951.174663-51-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Apr 2026 23:06:55 +0000
Message-Id: <20260425230655.E78D6C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 5 potential issue(s):
- [High] Invalid fallback tracepoint names will cause an unconditional cras=
h.
- [Medium] Commit message discrepancy regarding ANSI escape codes.
- [Medium] Legitimate syscall returns of 0 are misclassified as errors.
- [Medium] Command names are lost for syscalls spanning across reporting in=
tervals.
- [Medium] Process name resolution is functionally disabled in live mode.
--

commit 1f7bc7b9eb5366eb20e61635d20b6d705ae91f68
Author: Ian Rogers <irogers@google.com>

perf rwtop: Port rwtop to use python module

Port the legacy Perl script rwtop.pl to a python script using the perf
module in tools/perf/python.

> - Used ANSI escape codes (\x1b[H\x1b[2J) to clear the terminal.

This isn't a bug, but the commit message states ANSI escape codes are used
to clear the terminal. Looking at print_totals(), these escape sequences
do not seem to be emitted anywhere in the script.

> diff --git a/tools/perf/python/rwtop.py b/tools/perf/python/rwtop.py
> new file mode 100755
> --- /dev/null
> +++ b/tools/perf/python/rwtop.py
[ ... ]
> +    def process_event(self, sample: perf.sample_event) -> None:  # pylin=
t: disable=3Dtoo-many-branches
> +        """Process events."""
> +        event_name =3D str(sample.evsel)
> +        pid =3D sample.sample_pid
> +        sample_time =3D sample.sample_time
[ ... ]
> +        try:
> +            comm =3D f"PID({pid})" if not self.session else self.session=
.find_thread(pid).comm()
> +        except Exception:  # pylint: disable=3Dbroad-except
> +            comm =3D f"PID({pid})"

Does this prevent process name resolution in live mode?

In main(), live_session is used and analyzer.session is never initialized
during live mode. Will this cause the script to always fall back to
f"PID({pid})" during live tracing?

[ ... ]
> +        elif event_name in ("evsel(syscalls:sys_exit_read)", "evsel(raw_=
syscalls:sys_exit_read)"):
> +            try:
> +                ret =3D sample.ret
> +                if ret > 0:
> +                    self.reads[pid]["bytes_read"] +=3D ret
> +                else:
> +                    self.reads[pid]["errors"][ret] +=3D 1

Does this misclassify legitimate syscalls as errors?

A return value of 0 indicates EOF for read() or 0 bytes transferred for
write(), but this logic will fall into the else block and increment the
error counter. Should this check for ret >=3D 0 instead, since syscall
errors are represented by negative integers?

[ ... ]
> +    def print_totals(self) -> None:
> +        """Print summary tables."""
[ ... ]
> +        # Reset counts
> +        self.reads.clear()
> +        self.writes.clear()

Does clearing these dictionaries cause us to lose the command name for
syscalls spanning across intervals?

If an interval elapses between a process's sys_enter and sys_exit events,
the dictionary entry is cleared. When the sys_exit handler recreates it
via the defaultdict factory, the comm string will be empty, which might
result in blank command names in the output table.

[ ... ]
> +def main() -> None:
> +    """Main function."""
[ ... ]
> +        if not os.path.exists(args.input) and args.input =3D=3D "perf.da=
ta":
> +            # Live mode
> +            events =3D (
> +                "syscalls:sys_enter_read,syscalls:sys_exit_read,"
> +                "syscalls:sys_enter_write,syscalls:sys_exit_write"
> +            )
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
> +                live_session =3D LiveSession(events, sample_callback=3Da=
nalyzer.process_event)

Will this fallback path crash?

The raw_syscalls subsystem exposes generic sys_enter and sys_exit
tracepoints, but it does not have per-syscall variants like
raw_syscalls:sys_enter_read. If the primary session fails, will this
fallback unconditionally raise another OSError?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260425224951.1746=
63-1-irogers@google.com?part=3D50
