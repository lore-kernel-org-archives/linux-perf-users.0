Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070C83D6CB6
	for <linux-perf-users@vger.kernel.org>; Fri, 24 Apr 2026 17:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777051605; cv=none; b=aRH9M995W2vNk4u/gHVwPFipNGp1HsyRONshvVkv7rQ4bWaazVoKk+zbm9yWeeyLRSRl8el09UyjrOTrwQtBF5JJzwIvysIBo6lXE9A5sJevtAyh3UMT02/A/7hJsy6BeIVoejQQ415LSp0V+3ptJmBFVjeUMn6zK3Gb4jXVplo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777051605; c=relaxed/simple;
	bh=Ob8RzFKxz2HP3+SA8B8tqrhAaCPEDgFzYz3vGxrP44w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=M8z87Bo7ThBvITqNz3dE0K7TzkZbSNDaGXF7ohNawFKBSCoQ9ulz+v8v7VQfZ8afQUmT7nRGQSbNuOEjuovqGCWo37x8U3h7Zq7WczFEaBnBMtlDAcsnMGe4T/0G+2j8CfMYmPEI+Jck4IYeZbIjpXi7IwtumatFhGCEY9XOhQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s1StMsY9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s1StMsY9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BC91C19425;
	Fri, 24 Apr 2026 17:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777051604;
	bh=Ob8RzFKxz2HP3+SA8B8tqrhAaCPEDgFzYz3vGxrP44w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=s1StMsY9cVyXhPkPmWEbT/DarpRL/nDIl04fJaMg6N4zavr460gAr8MxbMWbuAx2J
	 X4fMygvzwzAHj7ZNMOc2WlZqYvjvwgBgXYCPJ+13LPck1rPv8zJKl/LtO2mzCt+P0R
	 gaGp8l52RVHM6Z9sSaI3dRz7UEqADypYqcOBQglvYpugynAb9FgB8VGua9fy0lXIR3
	 jfjriSpAt7i1jLDgYQJhV1ZZY5cu7ra9OyA4uDqgwDdoHepMabTxeTf+VadRPOiukY
	 T9fwcedbfd/ywFdzRKFrGLWGI0W8nKQPWKs8qYGJ/CcO8AVxKfGewmVGDt3ZKky8bc
	 PNj4T9nwOnz8g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 44/58] perf sctop: Port sctop to use python module
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260424164721.2229025-45-irogers@google.com>
References: <20260424164721.2229025-45-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Apr 2026 17:26:43 +0000
Message-Id: <20260424172644.8BC91C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 4 potential issue(s):
- [High] The fallback logic for `syscalls:sys_enter` checks the wrong trace=
 field, causing all fallback events to be discarded.
- [High] Offline interval tracking is non-functional because it accesses a =
non-existent `time` attribute instead of `sample_time`.
- [High] Command name (`comm`) filtering in live mode silently discards all=
 events.
- [High] Offline thread resolution crashes the script with an unhandled `Ty=
peError` when a PID is missing from the thread map.
--

commit ef53d21c08cbcaad6543cee9b7d81aa70d4ca99f
Author: Ian Rogers <irogers@google.com>

perf sctop: Port sctop to use python module

This commit ports sctop.py from tools/perf/scripts/python/ to
tools/perf/python/ using a class-based structure. It also adds live mode
support using the LiveSession helper with a fallback strategy for
tracepoint names.

> diff --git a/tools/perf/python/sctop.py b/tools/perf/python/sctop.py
> new file mode 100755
> index 00000000000000..d7ac922da510cd
> --- /dev/null
> +++ b/tools/perf/python/sctop.py

[ ... ]

> +    def process_event(self, sample: perf.sample_event) -> None:
> +        """Collect syscall events."""
> +        name =3D str(sample.evsel)
> +        syscall_id =3D getattr(sample, "id", -1)

Is the id field available for syscalls:sys_enter tracepoints? The fallback
tracepoint defines its field as __syscall_nr (or nr on older kernels),
whereas raw_syscalls:sys_enter provides id. Will this cause getattr to
return -1 and silently drop all fallback events?

> +
> +        if syscall_id =3D=3D -1:
> +            return
> +
> +        if hasattr(self, 'session') and self.session:
> +            comm =3D self.session.process(sample.sample_pid).comm()

Can this raise an unhandled type error exception? If the PID is not present
in the thread map, the C extension function pyrf_session__process raises an
exception. Could this exception propagate back to the C callback loop and
prematurely abort processing?

> +        else:
> +            comm =3D getattr(sample, "comm", "Unknown")

Does the sample have a comm attribute in live mode? Native sample_event
objects do not have a comm attribute, and sys_enter tracepoints do not
expose it. Will this always default to Unknown and cause the live mode
command filter to discard all events?

> +
> +        if name in ("evsel(raw_syscalls:sys_enter)", "evsel(syscalls:sys=
_enter)"):
> +            if self.for_comm is not None and comm !=3D self.for_comm:
> +                return
> +            with self.lock:
> +                self.syscalls[syscall_id] +=3D 1
> +
> +        if self.offline and hasattr(sample, "time"):

Does the Python sample_event API expose the timestamp as time or
sample_time? Since sys_enter tracepoints do not contain a time trace field,
it looks like this will evaluate to False and bypass the periodic printing
logic entirely.

> +            interval_ns =3D self.interval * (10 ** 9)
> +            if self.last_print_time is None:
> +                self.last_print_time =3D sample.time
> +            elif sample.time - self.last_print_time >=3D interval_ns:
> +                self.print_current_totals()
> +                self.last_print_time =3D sample.time

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260424164721.2229=
025-1-irogers@google.com?part=3D44
