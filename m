Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E7731282F
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 04:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776918382; cv=none; b=BrDrI/vnAYAGu5hD5B2EV6XOfJMst7y42kYnDhbWx2yFiLd4abFEKXSDop3cHKxT8g/a9PVFDXmPepBwiw3ZRP77L7sZGlilC/sr1e1VOZwabnM7VrNgppu6hJ75pLNn/yLyWpSKooVwhd0Twg3arY2bnKod3eg/ZiUzWZWVNZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776918382; c=relaxed/simple;
	bh=AV1Yw65SI/j30zB5w6uSpP2huRtgAlv3zoUqXXXAdy4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eZktG7/OpVEpdaHQR0uvA0GpIXSTQhtu/WoObYLaekc3RWVf60wxKEKHpslFNXTS8hSK0mKHNkMrCC4Y1etUaLlDTlTUVEnvIEpr3dWVYWdjccNE7Tk+Q9I0uA3qZv4CMmf51tXJ/XvJRw4LdelDlIAf06rTkeIni8my18/zy+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WZUYt5e3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WZUYt5e3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 531F0C2BCB2;
	Thu, 23 Apr 2026 04:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776918382;
	bh=AV1Yw65SI/j30zB5w6uSpP2huRtgAlv3zoUqXXXAdy4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=WZUYt5e3dufT/kqOnmXhEwiIZZsuct8qKZL2rA3p9mTLi+psJEORCHy4bMpr/n0rF
	 7ZbD+jSb+JXcJFiqr6UAMc1zLwjDMDdm2JyUvJx4zzJJNCM56OvdU4UUh3lsUJTDNc
	 Td0pbpHG7rWhPfUVCVtZZwn8VyKk8Uusao/iiVJhbOPhmdc/hmJI11py6h1+777I3j
	 X/uWRlrxMXSgGEYkoT61XbbNO1dHL/kaaJHQzqzgJhJg6GX+uYNqXqpnDFZv0jAJyQ
	 STlmMOW2rJJIkdYFAxjx5fS0UlosXsviEyhaMTjMVskUhR5mgdxxExvij4UH74ewnz
	 YKy1h9v9m2fUA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 50/58] perf rwtop: Port rwtop to use python module
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260423035526.1537178-51-irogers@google.com>
References: <20260423035526.1537178-51-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Apr 2026 04:26:21 +0000
Message-Id: <20260423042622.531F0C2BCB2@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 5 potential issue(s):
- [Medium] Meaningful code and commit message mismatch regarding terminal c=
learing.
- [Medium] The fallback logic for LiveSession uses invalid kernel tracepoin=
ts.
- [Medium] 0-byte completions (EOF) for read() and write() are incorrectly =
classified as errors.
- [Medium] Reference cycle with C extension type causes a memory and file d=
escriptor leak.
- [Low] Unhandled events tally is omitted when terminating Live Mode.
--

commit bcee736641b044aae62f7cca526d939e320836b7
Author: Ian Rogers <irogers@google.com>

perf rwtop: Port rwtop to use python module

This commit ports the legacy Perl script rwtop.pl to a python script using
the perf module. It uses a class-based architecture to periodically display
system-wide r/w call activity broken down by PID.

> - Used ANSI escape codes (\x1b[H\x1b[2J) to clear the terminal.

The commit message mentions using ANSI escape codes to clear the terminal,
but looking at the print_totals() function in the diff, these escape
sequences don't appear to be used. This means the script will continuously
scroll its output instead of refreshing in place.

> diff --git a/tools/perf/python/rwtop.py b/tools/perf/python/rwtop.py
> new file mode 100755
> index 0000000000000..952d178e99c5a
> --- /dev/null
> +++ b/tools/perf/python/rwtop.py

[ ... ]

> +        elif event_name in ("evsel(syscalls:sys_exit_read)", "evsel(raw_=
syscalls:sys_exit_read)"):
> +            try:
> +                ret =3D sample.ret
> +                if ret > 0:
> +                    self.reads[pid]["bytes_read"] +=3D ret
> +                else:
> +                    self.reads[pid]["errors"][ret] +=3D 1

Are 0-byte completions (EOF) for read() incorrectly classified as errors he=
re?

If a system call returns 0, the code falls into the else block and incremen=
ts
errors[0]. A return value of 0 for read() signifies End-Of-File (EOF), which
is a normal successful condition, not a system call failure.

[ ... ]

> +        elif event_name in ("evsel(syscalls:sys_exit_write)", "evsel(raw=
_syscalls:sys_exit_write)"):
> +            try:
> +                ret =3D sample.ret
> +                if ret > 0:
> +                    self.writes[pid]["bytes_written"] +=3D ret
> +                else:
> +                    self.writes[pid]["errors"][ret] +=3D 1

Does this have the same issue with classifying 0-byte completions for
write() as errors instead of a successful EOF condition?

[ ... ]

> +    def run(self, input_file: str) -> None:
> +        """Run the session."""
> +        self.session =3D perf.session(perf.data(input_file), sample=3Dse=
lf.process_event)

Does this create a reference cycle that leaks the session and file
descriptor?

By passing self.process_event to perf.session and storing the session in
self.session, a cycle is formed. The perf.session C extension type lacks
garbage collection support, so Python's cyclic GC cannot break it. This
could lead to a resource leak if the class is used programmatically to
process multiple files in the same process.

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

Are these fallback tracepoints valid?

The raw_syscalls subsystem only exports generic sys_enter and sys_exit
tracepoints. Per-syscall tracepoints like raw_syscalls:sys_enter_read do
not exist, meaning this fallback will invariably raise an OSError and
terminate the script.

[ ... ]

> +    except KeyboardInterrupt:
> +        print("\nStopping live mode...", file=3Dsys.stderr)
> +        if analyzer.reads or analyzer.writes:
> +            analyzer.print_totals()

Should the unhandled events tally be printed here as well?

When processing an offline file, the run() method prints the contents of the
unhandled dictionary. Omitting this in the KeyboardInterrupt handler creates
an inconsistency where dropped or malformed events aren't shown when
terminating live mode.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260423035526.1537=
178-1-irogers@google.com?part=3D50
