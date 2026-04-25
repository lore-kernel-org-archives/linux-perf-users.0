Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8EC630BF6F
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 23:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777158732; cv=none; b=Hm+8gY7JGWw+MIymbW/e/puRsNmhBY3Qgm7qKFCJPOzbM9ZvA1wn0GZPj1HBGWwq7T8fE9o7djPIWQ4GjzEHnWsGo80EingwJRXHuB9ajxOTT1HPE1CEKgBAuz+1kWpPpjjU9q2VBI/zVvfS5FJkCXSVWAmkjbWKvXyUWHk09BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777158732; c=relaxed/simple;
	bh=3AHRauqkFXqo7byMBSt6gmXc68kGFCga1oZVA3QpAn8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KKtP4wF44C5wCIS17k+wowgiZAuNAcmYSBuTUg336rsCN6WHUSspUWU7HWD7DKc3AW/cMPkpfFuldI8exjpZ1pDPpcIju2JQSY4AAPgakmQfBnw+H7Oc+j+WPPUU77xepXrM2EbnN9YjRqXj01EcaVS+KCACBOBS7DSSll/E3C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lQcKdVTC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lQcKdVTC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81E43C2BCB0;
	Sat, 25 Apr 2026 23:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777158731;
	bh=3AHRauqkFXqo7byMBSt6gmXc68kGFCga1oZVA3QpAn8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=lQcKdVTCO1iFtVftdWH7RtO44a72mNTZE+3UjEXzRuQxb4gd6s6NgnL+2M/vusqxV
	 WZSTUNrHeSeImD6CIWV6T3CSSImH96gx7TPuCG2SbVeiLxC2jcAounIDUX8hRhbX2v
	 zsBKAxfvIY6ZViA/Ag9SHH1JNA8OkRqYA1uJhTJB1n/bCAdBhpoJ9dn/z6/eOgFFkY
	 PiUhFHzs3fPMQm+Rl+hKDRqlKiObMrSWAxzCpXMXqlQ41k0z5/s86yaeSoljUH+2SQ
	 jeDe9ExmSTDUAexTHQxmNUZdWWwIWkBXGRCgw936+9vwt+NE96REGczgcTfSHd9tSj
	 U97HPIXqOnVnA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 44/59] perf sctop: Port sctop to use python module
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260425224951.174663-45-irogers@google.com>
References: <20260425224951.174663-45-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Apr 2026 23:12:10 +0000
Message-Id: <20260425231211.81E43C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 3 potential issue(s):
- [High] Offline mode interval reporting uses the non-existent `sample.time=
` attribute, silently breaking periodic output.
- [High] Live mode process filtering is fundamentally broken because it rel=
ies on a non-existent `comm` attribute.
- [Medium] Zero or negative intervals cause a CPU spin loop and terminal fl=
ooding.
--

commit 8bb70cab42e678b0bb4cd3857774a7a8da1f616c
Author: Ian Rogers <irogers@google.com>

perf sctop: Port sctop to use python module

This commit ports sctop.py from tools/perf/scripts/python/ to
tools/perf/python/ using a class-based structure. It also adds live mode
support using the LiveSession helper with a fallback strategy.

> diff --git a/tools/perf/python/sctop.py b/tools/perf/python/sctop.py
> new file mode 100755
> index 000000000000..b94f66a8307d
> --- /dev/null
> +++ b/tools/perf/python/sctop.py

[ ... ]

> +        comm =3D "Unknown"
> +        if hasattr(self, 'session') and self.session:
> +            try:
> +                proc =3D self.session.find_thread(sample.sample_pid)
> +                if proc:
> +                    comm =3D proc.comm()
> +            except (TypeError, AttributeError):
> +                pass
> +        else:
> +            comm =3D getattr(sample, "comm", "Unknown")

Does live mode process filtering work as intended here? The perf.sample_eve=
nt
object does not natively contain a comm attribute.

Because getattr falls back to "Unknown", the condition comm !=3D self.for_c=
omm
will evaluate to True for any user-specified command name.=20

Consequently, if a user specifies a target process in live mode, all events
will be silently filtered out and dropped.

> +
> +        if name in ("evsel(raw_syscalls:sys_enter)", "evsel(syscalls:sys=
_enter)"):
> +            if self.for_comm is not None and comm !=3D self.for_comm:
> +                return
> +            with self.lock:
> +                self.syscalls[syscall_id] +=3D 1
> +
> +        if self.offline and hasattr(sample, "time"):

Does this properly evaluate the event timestamp? The python extension expos=
es
the event timestamp as sample_time, not time.

Because hasattr(sample, "time") always evaluates to False, the script skips
the periodic interval checking block in offline mode and only dumps a single
accumulated output at the end of processing.

> +            interval_ns =3D self.interval * (10 ** 9)
> +            if self.last_print_time is None:
> +                self.last_print_time =3D sample.time
> +            elif sample.time - self.last_print_time >=3D interval_ns:
> +                self.print_current_totals()
> +                self.last_print_time =3D sample.time

[ ... ]

> +def main():
> +    """Main function."""
> +    ap =3D argparse.ArgumentParser(description=3D"System call top")
> +    ap.add_argument("args", nargs=3D"*", help=3D"[comm] [interval] or [i=
nterval]")
> +    ap.add_argument("-i", "--input", help=3D"Input file name")
> +    args =3D ap.parse_args()
> +
> +    for_comm =3D None
> +    default_interval =3D 3
> +    interval =3D default_interval
> +
> +    if len(args.args) > 2:
> +        print("Usage: perf script -s sctop.py [comm] [interval]")
> +        sys.exit(1)
> +
> +    if len(args.args) > 1:
> +        for_comm =3D args.args[0]
> +        try:
> +            interval =3D int(args.args[1])
> +        except ValueError:
> +            print(f"Invalid interval: {args.args[1]}")
> +            sys.exit(1)
> +    elif len(args.args) > 0:
> +        try:
> +            interval =3D int(args.args[0])
> +        except ValueError:
> +            for_comm =3D args.args[0]
> +            interval =3D default_interval

What happens if a user provides zero or a negative number for the interval?
The argument parsing does not validate that the interval is strictly positi=
ve.

If a zero or negative value is used, self.stop_event.wait(self.interval) in
the background thread returns immediately without sleeping. This causes the
background thread to infinitely spin in a tight loop, constantly clearing
the terminal and maximizing a CPU core.

In offline mode, a negative or zero interval causes the script to print
statistics on every single event, heavily degrading performance.

> +
> +    analyzer =3D SCTopAnalyzer(for_comm, interval, offline=3Dbool(args.i=
nput))

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260425224951.1746=
63-1-irogers@google.com?part=3D44
