Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69FCA23BF9F
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 18:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777140507; cv=none; b=ZCzCG2hdrS8tIjTbqgkobjqm+3tYwhbM7JMLsEztbfQ8cAdSqUXVk7UzbsryHXjHv+Z7/IM3753iAw3EC2ukKh82/CMnFSkVOjTNcdac9WBQqQBtighOBg4AFBXHiP0IWiKUh5HvwR1OX6xqjm3JkNbVT4k2yViXa07GekDtuj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777140507; c=relaxed/simple;
	bh=O2RxhVDEPktM0MHVnUr73GH0eRowKdW/rmqum1+3ghc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JFBAgTdyCnA7mJTZ+KBypS1pFKpy0nzpvvKh4KN8ob7lnTAqIRNSGnjeIlvrazLfT1CgW4T/AnPC+/RXI0l0/vopJ5YSXneEsApsKRpDW0VjstSVpNrXKM4NvCbeMDRmXd9JfomkhyUrva51D9479VwZSsV3DOKWf9Zlf2N1e8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sTzKcCdu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sTzKcCdu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5F18C2BCB0;
	Sat, 25 Apr 2026 18:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777140507;
	bh=O2RxhVDEPktM0MHVnUr73GH0eRowKdW/rmqum1+3ghc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=sTzKcCdu7gb54Pm3XH6xiRRyuSyIDpIFqXXYf3EBGkoJHaX54NWkuymUu5W5A3i3v
	 0IKFf3U/yYt7DVE1Byod4oC/Y3lfsWoARWk5+m9LJPps0o1hbNfs8uQhlrPb6aeEr+
	 g927SrgR6FuBA0soDAmgQG/t8Ky/JVW8EMjfr/GntKFQegh8pvMw+hrhV2/IAFgNa/
	 s612LYTwSOninKFmW7I3FQGAi2WVf1XLCv8fJ5QHS5/o0Lc7YiyqSRAdAPT8ct1lFB
	 j4wiRyc0m5APkXdiQeTvxxC6F2J1iUvI7ynGDDyeVhk8XEyp+A7qtt/d9sLybbtwb2
	 U8Bc/nbI/4C2Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 50/59] perf rwtop: Port rwtop to use python module
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260425174858.3922152-51-irogers@google.com>
References: <20260425174858.3922152-51-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Apr 2026 18:08:26 +0000
Message-Id: <20260425180826.E5F18C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 4 potential issue(s):
- [High] The fallback mechanism uses non-existent tracepoints (`raw_syscall=
s:sys_enter_read`, etc.), which will cause an unhandled exception and crash.
- [Medium] The script incorrectly classifies a return value of 0 from read =
and write syscalls as an error.
- [Medium] The commit message claims to use ANSI escape codes to clear the =
terminal, but they are absent from the implementation.
- [Low] The unhandled events summary is not printed when exiting live mode.
--

commit c17a4dd376748fb95f0369d1ddc3004826b6a608
Author: Ian Rogers <irogers@google.com>

perf rwtop: Port rwtop to use python module

This commit ports the legacy Perl script rwtop.pl to a Python script using
the perf module in tools/perf/python. It uses a class-based architecture
and leverages the perf.session API to periodically display system-wide read
and write call activity.

> - Used ANSI escape codes (\x1b[H\x1b[2J) to clear the terminal.

The commit message states that ANSI escape codes are used to clear the
terminal, but they appear to be absent from the implementation in
print_totals() or elsewhere. Is this intentional, or were the escape
codes accidentally dropped during development?

> diff --git a/tools/perf/python/rwtop.py b/tools/perf/python/rwtop.py
> new file mode 100755
> index 000000000000..895ebab9af10
> --- /dev/null
> +++ b/tools/perf/python/rwtop.py
> @@ -0,0 +1,219 @@

[ ... ]

> +        elif event_name in ("evsel(syscalls:sys_exit_read)", "evsel(raw_=
syscalls:sys_exit_read)"):
> +            try:
> +                ret =3D sample.ret
> +                if ret > 0:
> +                    self.reads[pid]["bytes_read"] +=3D ret
> +                else:
> +                    self.reads[pid]["errors"][ret] +=3D 1

Does this incorrectly classify a return value of 0 as an error?

A return value of 0 from read or write typically indicates End-Of-File (EOF)
or a 0-byte transfer, which are standard, non-error conditions. True syscall
errors are usually indicated by negative return values.

This might unnecessarily pollute the error statistics with false positives.

[ ... ]

> +        elif event_name in ("evsel(syscalls:sys_exit_write)", "evsel(raw=
_syscalls:sys_exit_write)"):
> +            try:
> +                ret =3D sample.ret
> +                if ret > 0:
> +                    self.writes[pid]["bytes_written"] +=3D ret
> +                else:
> +                    self.writes[pid]["errors"][ret] +=3D 1

Similarly, does this incorrectly classify a return value of 0 from a write
syscall as an error?

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
> +                live_session =3D LiveSession(events, sample_callback=3Da=
nalyzer.process_event)

Can this fallback mechanism cause an unhandled exception and crash?

The raw_syscalls subsystem exposes generic sys_enter and sys_exit tracepoin=
ts,
but there are no syscall-specific variants like raw_syscalls:sys_enter_read.

Because of this, the second LiveSession constructor will likely raise anoth=
er
OSError that is not caught, crashing the script instead of providing a
graceful fallback.

[ ... ]

> +    except KeyboardInterrupt:
> +        print("\nStopping live mode...", file=3Dsys.stderr)
> +        if analyzer.reads or analyzer.writes:
> +            analyzer.print_totals()

Should this also print the unhandled events summary?

When exiting live mode via KeyboardInterrupt, only print_totals() is called.
The script fails to print the unhandled events dictionary, which is normally
printed when processing a perf.data file offline in run().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260425174858.3922=
152-1-irogers@google.com?part=3D50
