Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F11389118
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 23:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777158389; cv=none; b=CePlf/1IZRm6UFUc3PHxVMKbl82+6vPvv6a+2lDA81rMvC8a/qwb6mDjWS2K40POgua4mW21kEX0fRqap0hKLY3LbGq9hI0r2/kD27Aw39W/IEJsJ6/9JOnejLIH3dEAKuQvvB+gFvCnbxXqOOCZCdRQzN803gFA3fNFvASPXZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777158389; c=relaxed/simple;
	bh=+POUj5BkO5sfC4rf976/dbcR3NzXmyvq27dCG4t6ziM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YS00B86eQ8dt/EQgIgxdR06J/ps05P6zBZlhT7ecThN3T0W8Z/Fyl2DJxrcnEvw8ku9JGidVA0i93c2CIywc73vPK/azJvoKqlfAz3P87xmf+PqWZ49QCWh+lziwgy//AHpq2bh1LE1eIq+SDPOIeTZuItnP3UN6VprrK4sA6m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JUre3ovH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JUre3ovH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3508C2BCB0;
	Sat, 25 Apr 2026 23:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777158388;
	bh=+POUj5BkO5sfC4rf976/dbcR3NzXmyvq27dCG4t6ziM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=JUre3ovH7O8i5CdszIiNZUD0U0heOD/HESWkM71YxqLdSXmf52sZwW4dj+YUxVi49
	 0RVpRuTbN+BQgtlZPege67G29YOLXsk28WsuLPUs/bQ/b00Lnh3atyb5VOc4I+1nVS
	 +meh7uPKF/xXjUY82R9Qkxs2NE+eQWd/qs0LRtTCO8jgF0W1HY6+D2p1rkTR3U3dQe
	 JEXh3yzVfkpc1FuJN9aMxhEaHxtRV9+eaHWz8KKjTAh2W/m1m6isdGFDPfxQSbTYZ5
	 iWq/Wfn+eD+AilAgqEDGGsApuqdDXMeggraeUoXsoWTxul0MQWe/4tme35wPMS2fSa
	 xfoN1PEUBt3Qw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 22/59] perf python: Add perf.pyi stubs file
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260425224951.174663-23-irogers@google.com>
References: <20260425224951.174663-23-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Apr 2026 23:06:28 +0000
Message-Id: <20260425230628.B3508C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Low] Inaccurate and incomplete Python type stubs in `perf.pyi`
--

commit 123e8822bf0adadf53e06cddf8aa0079bfd967d6
Author: Ian Rogers <irogers@google.com>

perf python: Add perf.pyi stubs file

This commit adds Python type stubs for the perf module to improve IDE
support and static analysis.

> diff --git a/tools/perf/python/perf.pyi b/tools/perf/python/perf.pyi
> new file mode 100644
> index 000000000000..91e19704e595
> --- /dev/null
> +++ b/tools/perf/python/perf.pyi
> @@ -0,0 +1,581 @@
> +"""Type stubs for the perf Python module."""
> +from typing import Callable, Dict, List, Optional, Any, Iterator

Are there a few module-level items missing from this file? The perf.pmu
class and the tracepoint module method appear to be omitted.

[ ... ]

> +def metrics() -> List[Dict[str, str]]:
> +    """Get a list of available metrics.
> +
> +    Returns:
> +        A list of dictionaries, each describing a metric.
> +    """
> +    ...

Is this return type fully accurate? The MetricGroup key can contain a list
of strings rather than just a string, which might cause static analysis to
flag valid iterations over metric groups as errors.

> +
> +def syscall_name(sc_id: int, *, elf_machine: Optional[int] =3D None) -> =
str:

Can syscall_name() return None if the syscall is not found? If so, should
the return type be Optional[str]?

[ ... ]

> +def parse_events(
> +    event_string: str,
> +    cpus: Optional[cpu_map] =3D None,
> +    threads: Optional[Any] =3D None
> +) -> 'evlist':

Should the threads argument be typed as Optional[thread_map] rather than
Optional[Any]?

> +    """Parse an event string and return an evlist.
> +
> +    Args:
> +        event_string: The event string (e.g., 'cycles,instructions').
> +        cpus: Optional CPU map to bind events to.
> +        threads: Optional thread map to bind events to.
> +
> +    Returns:
> +        An evlist containing the parsed events.
> +    """
> +    ...
> +
> +def parse_metrics(metrics_string: str) -> 'evlist':
> +    """Parse a string of metrics or metric groups and return an evlist."=
""
> +    ...

Does the C implementation of parse_metrics also accept pmu, cpus, and threa=
ds
arguments that might be missing from this stub?

[ ... ]

> +class counts_values:
> +    """Raw counter values."""
> +    val: int
> +    ena: int
> +    run: int

Are the id and lost attributes missing from this class?

[ ... ]

> +class evsel:
> +    """Event selector, represents a single event being monitored."""
[ ... ]
> +    def open(self) -> None:
> +        """Open the event selector file descriptor table."""
> +        ...

Can evsel.open() take optional arguments like cpus and threads in the C
extension?

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
> +    def __getattr__(self, name: str) -> Any: ...

Should srccode and insn be explicitly defined as methods or attributes on
sample_event?

> +
> +class mmap_event:
> +    """Represents a mmap event from perf."""
> +    type: int
> +    pid: int
> +    tid: int
> +    addr: int

Does the C extension use start rather than addr for mmap events?=20

Also, are the misc field and inherited sample_members expected to be present
here?

[ ... ]

> +class evlist:

Are the sequence methods __len__ and __getitem__ missing from the evlist
stub?

> +    def __init__(self, cpus: cpu_map, threads: thread_map) -> None: ...
> +    def open(self) -> None:
> +        """Open the events in the list."""
> +        ...
> +    def close(self) -> None:
> +        """Close the events in the list."""
> +        ...
> +    def mmap(self) -> None:
> +        """Memory map the event buffers."""
> +        ...

Does evlist.mmap() accept optional pages and overwrite arguments?

> +    def poll(self, timeout: int) -> int:

Is timeout an optional argument for evlist.poll()?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260425224951.1746=
63-1-irogers@google.com?part=3D22
