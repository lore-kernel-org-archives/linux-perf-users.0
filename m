Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F9336682A
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 18:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777140674; cv=none; b=Q70a63KbrYWySKfednMekFZfEJCptOjsqNoNunPHkb36KpjSP/5bWwnQmmDWcN2owejsokvf79JW6eyAdEA5egDIuK0/3vniBBXK1m33JGY6iAaOIS/eJrhx8nVT+IvadPWVXuFWB9j5wlB1nS6PbPv1VPMmFRnypTfyNrS0Tx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777140674; c=relaxed/simple;
	bh=41lwSmqKDZ5ZftZ13wB1Q6xd4ZBzzDv47huG6eZk8tI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sc+T7AWB38tV7xPaeAl3ezmLG+i9gdFHxECMEsvzwbPMQJlMKkYlJ6rjcvchGiu081me0iva9TWmeATbyFJgAclgtEACLTDfAFYpXv+KIpcq2P0+BqUe1utDR584pDC5E1cRATwOhH4o68rWZ7H0Ifk4cxuE1A9VC/nFVZjp8dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yp6DCSpU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yp6DCSpU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44BF1C2BCB0;
	Sat, 25 Apr 2026 18:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777140674;
	bh=41lwSmqKDZ5ZftZ13wB1Q6xd4ZBzzDv47huG6eZk8tI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Yp6DCSpUrqSwMJQRBx6uufnhOSoiysA8WOfKu6sXjllRceAy0U0sPYyBfygODzCty
	 lGVvBZSb0lG+Sewff+5XtHuANgfdmHGpnk02P8G3FpaA0QkOIW0skS89iB711e6FFO
	 tsQaUoZPK5hM+/c6wf4x20eo29M5vGbZh680Z+zgIKGm3iFJ4QOWadYe9Uf+rH4Gub
	 YJOQlM1rhKWyIOzLPPKPqJHIkaZ9gsPYLhAoiOnaPoqkLGQt1EDqTxzdW4f5Hb9g8a
	 ud29zMEtb7KrDrDsFFnTSR5X2IOlFrQWIn45+CqZTurS51HiCZZI3WYWOc8W2+cAy5
	 p2pv3pSgn559Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 22/59] perf python: Add perf.pyi stubs file
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260425174858.3922152-23-irogers@google.com>
References: <20260425174858.3922152-23-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Apr 2026 18:11:13 +0000
Message-Id: <20260425181114.44BF1C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 4 potential issue(s):
- [Medium] Missing module-level functions and classes in perf.pyi
- [Medium] Incomplete and missing attributes in perf event classes
- [Medium] Missing properties and incorrect attribute names in auxiliary pe=
rf classes
- [Medium] Incorrect method signatures and missing sequence methods
--

commit f33c2c37edfd124bfa12f399b8b5cebd12f0c459
Author: Ian Rogers <irogers@google.com>

perf python: Add perf.pyi stubs file

Add Python type stubs for the perf module to improve IDE support and
static analysis. Includes docstrings for classes, methods, and
constants derived from C source and JSON definitions.

> diff --git a/tools/perf/python/perf.pyi b/tools/perf/python/perf.pyi
> new file mode 100644
> index 000000000000..91e19704e595
> --- /dev/null
> +++ b/tools/perf/python/perf.pyi
> @@ -0,0 +1,581 @@
> +"""Type stubs for the perf Python module."""
> +from typing import Callable, Dict, List, Optional, Any, Iterator
> +

[ ... ]

> +def parse_metrics(metrics_string: str) -> 'evlist':
> +    """Parse a string of metrics or metric groups and return an evlist."=
""
> +    ...
> +

Could the tracepoint() function exported by perf__methods in
tools/perf/util/python.c be missing from this stub?

> +def pmus() -> Iterator[Any]:
> +    """Returns a sequence of pmus."""
> +    ...
> +

Would pmus() be more accurately typed as returning an iterator over pmu
objects rather than Iterator[Any]?

Are the pmu class and its methods like events() and name() missing?

> +class data:

[ ... ]

> +class counts_values:
> +    """Raw counter values."""
> +    val: int
> +    ena: int
> +    run: int
> +

Are the id and lost fields, as well as the values property, missing from
this class?

[ ... ]

> +class evsel:
> +    """Event selector, represents a single event being monitored."""
> +    def __init__(
> +        self,

[ ... ]

> +        idx: int =3D ...,
> +    ) -> None: ...
> +    def __str__(self) -> str:
> +        """Return string representation of the event."""
> +        ...
> +    def open(self) -> None:

Could open() be missing optional arguments like cpus, threads, group, and
inherit?

Should properties like tracking, config, read_format, sample_period,
sample_type, size, type, and wakeup_events be included in the evsel class?

> +        """Open the event selector file descriptor table."""
> +        ...
> +    def read(self, cpu: int, thread: int) -> counts_values:

[ ... ]

> +class sample_event:
> +    """Represents a sample event from perf."""
> +    evsel: evsel
> +    sample_cpu: int
> +    sample_time: int
> +    sample_pid: int
> +    type: int
> +    brstack: Optional['branch_stack']
> +    callchain: Optional['callchain']

Is this class missing specialized methods like srccode() and insn()?

Also, shouldn't sample_members properties like sample_tid, sample_id,
sample_stream_id, and sample_period be present here and across other
event classes?

> +    def __getattr__(self, name: str) -> Any: ...
> +

[ ... ]

> +class switch_event:
> +    """Represents a SWITCH or SWITCH_CPU_WIDE record."""
> +    type: int
> +

Could the next_prev_pid and next_prev_tid properties be missing from this
class?

[ ... ]

> +class callchain_node:
> +    """Represents a frame in the callchain."""
> +    ip: int
> +    sym: Optional[Any]
> +    map: Optional[Any]

The C extension exposes these properties as symbol and dso via
pyrf_callchain_node__getset.

Will the use of sym and map cause code that passes static analysis to fail
with AttributeError at runtime?

> +
> +class callchain:

[ ... ]

> +class evlist:

Since the evlist class functions as a Python sequence in C, should __len__
and __getitem__ be defined here?

> +    def __init__(self, cpus: cpu_map, threads: thread_map) -> None: ...
> +    def open(self) -> None:
> +        """Open the events in the list."""
> +        ...
> +    def close(self) -> None:
> +        """Close the events in the list."""
> +        ...
> +    def mmap(self) -> None:

Are optional arguments like pages and overwrite missing from mmap()?

> +        """Memory map the event buffers."""
> +        ...
> +    def poll(self, timeout: int) -> int:

Is timeout incorrectly marked as required here? It appears to be optional
and defaults to -1 in the C implementation.

> +        """Poll for events.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260425174858.3922=
152-1-irogers@google.com?part=3D22
