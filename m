Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4DE3F0ABF
	for <linux-perf-users@vger.kernel.org>; Fri,  5 Jun 2026 10:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780654395; cv=none; b=LnsSGmRg1iFRg3eurfJOgS3b2FwpmSMFP+cSI7NHgcIUfA3Dv61K+CljgD8+5zV0/6vb57gEWF6sYmemEx3PEJLiA3LsN2pGcDMHfDZOkJm+8P8SGqIFq6YwgAIWHWpQYxQ4iXqJe18CRyhLCirlXmYH0Xpxr3eWE6RWM6ailyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780654395; c=relaxed/simple;
	bh=GuQaGEm9CYtnNwVeNpuq5lh3d7TrfNJSpkTqbYsoRCU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QjtpUpi4hgH+QH9rHp+SVduiwV6K0Ke6mabt/sc1jgYMr06bYILal/i5StHJQy9taKApgCeEtWmW9hzfmEzqGSvLU0e5qkpqoVytQKBhT0r31/nn+MuAhjMiGGhpaNZi5ejgrusS/ICqyK7qy3VX2OtAi5NQBxMs2LEHafAedCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U5osNRy4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U5osNRy4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E4D41F00893;
	Fri,  5 Jun 2026 10:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780654394;
	bh=sCM0wChkz7qKMrVK82xgz2yeSOvWp3F53REI2QRaYGA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=U5osNRy4W3Ad9VWas+fjcEHyj8GBjNF7MD3+EX0pZWubWZTnMZ88s4TOz8dgTthuf
	 x9rPU75Pq7e2rZlCgmJTRcXAtuIAnhQR6L0sa9yGJ0U3NRb9ZX/6xpRPZk58laRUbH
	 FgOxvjG7fb1Nlm8Ba1nxqtbXs4nQrkGEPIZxgwWuyY4dSzdYM44jEAG5rRFTU/5Eo5
	 rE65goE+ieISi8XdUy1fZQICXlTcSe+1edheO9Potb0Z2og8wSsrzWryOlS8z5E3Bh
	 x5VM1CZ1r1wqAMyx+KqPg/5fmusBXVLPH1bqOp1yH43Drl1da4h4JvSluhTUbOvvRd
	 9YkXIj6nRoDfQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 19/19] perf python: Add LiveSession helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260605074003.1730715-20-irogers@google.com>
References: <20260605074003.1730715-20-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 10:13:13 +0000
Message-Id: <20260605101314.3E4D41F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] LiveSession crashes unconditionally on empty ring buffers due to r=
e-raising -EAGAIN as OSError.
- [Medium] LiveSession busy-loops and spams stderr on unmapped CPUs.
- [Medium] Broad exception handler swallows user callback exceptions and mi=
sreports them as parsing errors.
--

commit 4b0aea1c86d61d02f883cb514ba6d1082d3b2a72
Author: Ian Rogers <irogers@google.com>

perf python: Add LiveSession helper

Add LiveSession class in tools/perf/python/perf_live.py to support
live event collection using perf.evlist and perf.parse_events,
avoiding the need to fork a separate perf record process.

> diff --git a/tools/perf/python/perf_live.py b/tools/perf/python/perf_live=
.py
> new file mode 100755
> index 0000000000000..46522964cb799
> --- /dev/null
> +++ b/tools/perf/python/perf_live.py

[ ... ]

> +    def run(self):
> +        """Run the live session."""
> +        try:
> +            self.evlist.open()
> +            self.evlist.mmap()
> +            self.evlist.enable()
> +
> +            while True:
> +                # Poll for events with 100ms timeout
> +                try:
> +                    self.evlist.poll(100)
> +                except InterruptedError:
> +                    continue
> +                for cpu in self.cpus:
> +                    for _ in range(1000): # Limit to 1000 events per CPU=
 per poll to prevent starvation
> +                        try:
> +                            event =3D self.evlist.read_on_cpu(cpu)
> +                            if event is None:
> +                                break
> +                            if event.type =3D=3D perf.RECORD_SAMPLE:
> +                                self.sample_callback(event)

[Severity: Medium]
Will this broad exception handler swallow exceptions raised by the user's
sample_callback?

If the user's callback raises a standard Python exception like ValueError or
KeyError, it looks like it gets caught below and misreported as an event
parsing error, obscuring bugs in the tracing logic.

> +                        except OSError as e:
> +                            # OS/mmap errors are unrecoverable and will =
cause busy-looping if ignored
> +                            raise e

[Severity: High]
Does this unconditionally crash the live session on an empty ring buffer?

When the CPU's ring buffer is empty, pyrf_evlist__read_on_cpu() calls
perf_mmap__read_init(), which returns -EAGAIN (-11). This causes the C
extension to throw an OSError.

Since it's normal for some CPUs to have no events when poll() returns,
re-raising the OSError here would terminate the session the first time it
checks an empty buffer.

> +                        except Exception as e:
> +                            # Parsing or type errors are recoverable as =
the event was consumed
> +                            import sys
> +                            print(f"Error parsing event on CPU {cpu}: {e=
}", file=3Dsys.stderr)

[Severity: Medium]
Can this lead to a busy-loop that spams stderr on unmapped CPUs?

If a CPU is not mapped by the event list (e.g., when tracing uncore PMU
events), pyrf_evlist__read_on_cpu() returns NULL internally and throws a
TypeError.

Since the exception handler here catches the TypeError but doesn't break out
of the 1000-iteration loop, it will repeatedly print this error 1000 times
for each unmapped CPU on every single poll cycle.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605074003.1730=
715-1-irogers@google.com?part=3D19
