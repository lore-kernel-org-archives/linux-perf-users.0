Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F47179A3
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 18:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777140538; cv=none; b=B4Kr/PdiERndUEM5kgRXGddxBOQ98xMQKWLLToXqDfUJGwaKAMyAaa93pUUUWuc2TZ/pTDZ48GpffBsfyUCL0D4zDC277RONH8/35U5uJiaA/VJNDPTDu+DvBDZBUf/K3RvG4XT7lFuZ4WIt86TyisxJky3ntfET8kLx3c/quXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777140538; c=relaxed/simple;
	bh=B0MEkNRV9NRb6Rt4vwpM5UoregJach7BjvEnDACC0jg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pj1pcdxij03gDfXNCrLyo3Cwu7ZumCvbZux9A2O8mASwyDhZDyuwc1SII5nMi8Hn5f2ssFom8mf5MDaNUUWb5YqKsgnv9ESs32XWiJ6oSpdYlHP0gjsIfC2574DcVYP7j4xbcqVcl5n7cgSiusfjwqElrwvQTvPRMPC76AGm4Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sB9YFUcX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sB9YFUcX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73C6FC2BCB0;
	Sat, 25 Apr 2026 18:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777140538;
	bh=B0MEkNRV9NRb6Rt4vwpM5UoregJach7BjvEnDACC0jg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=sB9YFUcX9tz3HM+vbWRRjTidZPz7Sy0xZWewRUDt68c6ADQQqhNT5pew+JibvgIIz
	 0GrqiIDlWL55LhesUGDVdq+qt/1p9mXbRgL2LU15kyYrfLB/gKUPHHByADYsx1mzBV
	 9fx/2DTPaL96mIh+M1YwIKNhmi8voO4yKkS12T5gEgsB+7I3c8u49c/lEYcPt34HXh
	 ZwQXqRKruD5RyBcXvvZawbjJ1EUs01HRpN3UNo3pKsTYzSx/YaP/ufLGE/EJNeM8+q
	 z+1crgWezyUu+5U6VyaxdBHgjPllOMminjedZjDE2FYMlW0xYHGi86fsKsDq9BiiQc
	 TWBGw+RhjeYzw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 44/59] perf sctop: Port sctop to use python module
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260425174858.3922152-45-irogers@google.com>
References: <20260425174858.3922152-45-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Apr 2026 18:08:57 +0000
Message-Id: <20260425180858.73C6FC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 5 potential issue(s):
- [High] Filtering by command name (`for_comm`) silently drops all events i=
n live mode.
- [Medium] Terminal is cleared during fast offline processing, hiding all b=
ut the final interval.
- [Medium] Error messages printed in the main exception block are immediate=
ly erased from the terminal.
- [Medium] The `interval` argument lacks validation against zero or negativ=
e values, leading to infinite loops or terminal spam.
- [Low] Misleading usage message instructing execution via `perf script`.
--

commit 1d0230890ca491ddc08c37ac65574ba53c7bac25
Author: Ian Rogers <irogers@google.com>

perf sctop: Port sctop to use python module

This commit ports sctop.py from tools/perf/scripts/python/ to
tools/perf/python/ using a class-based structure. It also adds live mode
support using the LiveSession helper with a fallback strategy for
tracepoint names.

> diff --git a/tools/perf/python/sctop.py b/tools/perf/python/sctop.py
> new file mode 100755
> index 000000000000..b94f66a8307d
> --- /dev/null
> +++ b/tools/perf/python/sctop.py
> @@ -0,0 +1,186 @@
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

In live mode, analyzer.session is None, so this falls back to
getattr(sample, "comm", "Unknown"). Since LiveSession reads raw RECORD_SAMP=
LE
events without maintaining a thread map, will sample.comm always evaluate to
"Unknown"?

> +
> +        if name in ("evsel(raw_syscalls:sys_enter)", "evsel(syscalls:sys=
_enter)"):
> +            if self.for_comm is not None and comm !=3D self.for_comm:
> +                return

If sample.comm is always "Unknown" in live mode, will filtering by command
name silently drop all events and present an empty screen?

[ ... ]
> +            if self.last_print_time is None:
> +                self.last_print_time =3D sample.time
> +            elif sample.time - self.last_print_time >=3D interval_ns:
> +                self.print_current_totals()
> +                self.last_print_time =3D sample.time
> +
> +    def print_current_totals(self):
> +        """Print current syscall totals."""
> +        # Clear terminal
> +        print("\x1b[2J\x1b[H", end=3D"")

In offline mode, events are processed as fast as they can be read. Does
clearing the terminal here cause the screen to flash and hide all but the
final interval's data from the user?

[ ... ]
> +    for_comm =3D None
> +    default_interval =3D 3
> +    interval =3D default_interval
> +
> +    if len(args.args) > 2:
> +        print("Usage: perf script -s sctop.py [comm] [interval]")

This isn't a bug, but since this has been ported to a standalone Python
script, is this usage message misleading?

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

Is it possible for the interval to be zero or negative here?

If 0 or a negative number is provided, in live mode
self.stop_event.wait(self.interval) will return immediately. Will this cause
the background thread to spin in a tight loop and max out a CPU core?

> +        except ValueError:
> +            for_comm =3D args.args[0]
> +            interval =3D default_interval

[ ... ]

> +            live_session.run()
> +    except KeyboardInterrupt:
> +        pass
> +    except IOError as e:
> +        print(f"Error: {e}")
> +    finally:
> +        if args.input:
> +            analyzer.print_current_totals()
> +        else:
> +            analyzer.stop()

If an IOError occurs, the error message is printed. However, the finally bl=
ock
either calls analyzer.print_current_totals() (in offline mode) or unblocks =
the
background thread which calls it (in live mode).

Since print_current_totals() unconditionally clears the screen with
"\x1b[2J\x1b[H", will this immediately erase the error message and hide the
failure reason from the user?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260425174858.3922=
152-1-irogers@google.com?part=3D44
