Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF8534028D
	for <linux-perf-users@vger.kernel.org>; Fri, 22 May 2026 23:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779493485; cv=none; b=CQd+ccMJ6xv3XYXyplyxsULu8yCcT/m1FtrOVUBldJvkyDK4K1KsZmJQ0KRthD/yv+UH+2/Y4bQuFm7h13LCS81ak6WN8fdwZK0Xqo/E5PDzAVsoe2K+0UW0v5tJxm8eHvJYPmeo5BFkeMMiwrsz/+gPvq70q1znB3B7Qn7WPz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779493485; c=relaxed/simple;
	bh=2DYqfqDJ0xLqA4KkOcuo4LDOpC3t3JUPHReB7MNCdqw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jcNjXyJKnXHmsUTmv5Sj1bZ4gyeOmsXHX0eG93yOapv8rj89S+WKcaTXjBzMiBPSAzeOZnH8dvA/dcZ2RVHiDEdZN2ZJxom2dezAlQVYh++eLH8SsJs7mHcQpLslvaM/ZY2f/xCMNr1jbdN3hn+OwJvxIudmy6tvGsCe3TlNJAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FYBn1o1m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FYBn1o1m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1E3C1F000E9;
	Fri, 22 May 2026 23:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779493484;
	bh=DIlLneqw53tVPovNemSVWEdo8enAt+pieocOQ4zxJ1g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FYBn1o1mvf4mxiprx3Munyze2hwEll6XChAqC/I4kYoplooFZUTxniizHNI//YAsS
	 xI49KQRnoOIulxdb/cTevya72yTBr5DdMFlpNJoEWHFy62Ojbxi4i3pLSHqDAA+iC1
	 ASpe0fgg2ZLzLpW8A98RoulxBV8nkWKTA5P7+j1a9vLPJSEMcFWaZ+pkZQMMvai0PN
	 xBtSC66gdycTcIFNtftOVQbyWxU0K2VyOgL467rRPScZ0gUxHHvd1MES4l6EJ2M4aI
	 PDnYX2G1cp31gSEhGFK/sozA3zvt5vu68OPeOkEYIsOTP7+fBZhUSxUnHWpuQ05WRy
	 cd5hA6Qe1S21Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 23/23] perf python: Add LiveSession helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260522220435.2378363-24-irogers@google.com>
References: <20260522220435.2378363-24-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 22 May 2026 23:44:43 +0000
Message-Id: <20260522234443.E1E3C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] LiveSession.run() will enter an infinite busy-loop pegging the C=
PU to 100% and flooding stderr if a file descriptor encounters an unrecover=
able error.
- [Medium] Draining all events from one CPU before moving to the next cause=
s starvation and event loss for other CPUs during high event rates.
- [Low] Potential file descriptor leak if an asynchronous exception occurs =
between evlist.open() and the try block.
--

commit d20b9507bd8c4d01a239c0c3dc0e2b42402bcfe1
Author: Ian Rogers <irogers@google.com>

perf python: Add LiveSession helper

Add LiveSession class in tools/perf/python/perf_live.py to support
live event collection using perf.evlist and perf.parse_events,
avoiding the need to fork a separate perf record process.

> diff --git a/tools/perf/python/perf_live.py b/tools/perf/python/perf_live=
.py
> new file mode 100755
> index 0000000000000..2e53473497606
> --- /dev/null
> +++ b/tools/perf/python/perf_live.py
[ ... ]
> +    def run(self):
> +        """Run the live session."""
> +        self.evlist.open()
> +        try:

[Severity: Low]
Can this leak file descriptors if an asynchronous exception, like a
KeyboardInterrupt, is raised right after open() but before entering the try
block?

If the exception occurs here, the finally block will be bypassed and close()
won't be called. Should open() be moved inside the try block to guarantee
cleanup?

> +            self.evlist.mmap()
> +            self.evlist.enable()
> +
> +            while True:
> +                # Poll for events with 100ms timeout
> +                try:
> +                    self.evlist.poll(100)

[Severity: Medium]
What happens if a polled file descriptor encounters an unrecoverable error
like POLLHUP or POLLERR?

It seems poll() will return immediately without blocking, and the subsequent
read_on_cpu() will raise an exception. Since the offending file descriptor
is never removed from the evlist or disabled, poll() will be called again
and return immediately, leading to an infinite busy-loop that pegs the CPU
at 100% and floods stderr.

> +                except InterruptedError:
> +                    continue
> +                for cpu in self.cpus:
> +                    while True:
> +                        try:
> +                            event =3D self.evlist.read_on_cpu(cpu)
> +                            if event is None:
> +                                break
> +                            if event.type =3D=3D perf.RECORD_SAMPLE:
> +                                self.sample_callback(event)

[Severity: Medium]
Will this continuous inner loop cause starvation and event loss for other
CPUs?

If a particular CPU generates events at a rate comparable to or faster than
the script can process them, this inner loop might never exit. This would
stall the outer loop, preventing other CPUs from being processed. Their ring
buffers would fill up and the kernel would drop their events.

Should the processing be interleaved or bounded per CPU to ensure fairness?

> +                        except Exception as e:
> +                            import sys
> +                            print(f"Error processing event on CPU {cpu}:=
 {e}", file=3Dsys.stderr)
> +                            break

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260522220435.2378=
363-1-irogers@google.com?part=3D23
