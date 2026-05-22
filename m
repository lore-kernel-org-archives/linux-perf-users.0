Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068D337D13C
	for <linux-perf-users@vger.kernel.org>; Fri, 22 May 2026 22:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779489984; cv=none; b=IODRND8I8snRLrLIjBA9CyNnyGthNuONFdYeh0Nx3bF68Plh8E/AU5SgBijq+l4OfhbN68Cqr/gn4XIQLNB2S2FCWB+6jvdMnTX+rZPJxVspKZBYPaOksF97xmyCN/x1U9DQ9zPDjWcpBBh0ASpHQN//s/qGQEKP2DnNwIEqduk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779489984; c=relaxed/simple;
	bh=jM3Rg13Ld0b8G6jOliqRBbj+gKIX2X9ucQ9ULeJkQVw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uaUc9yjLDZ9vRU5iT4u/czuRrLWJ/t5mEZPT116C/Q418G8Fs4Pcxsv98gl8ha5wK6E0lyRFYFdDMupWhZzvMInHJqmOWdXveO5rHVXvSes5vFMtAHZcmEpEWa7lOzPexPOdGay1zajNuG4PdBjieEWnELYCFBCMsnt5KDNESVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pl7lVm3b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pl7lVm3b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79B251F000E9;
	Fri, 22 May 2026 22:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779489982;
	bh=m3/alqWFLeAoeEUsaf/VrrBNL+TOi3MS79R8RmzmKcc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Pl7lVm3bmX1upGbJPLSL/G6zm47oHbXooZ41BL+lqwSi/D74BlW0aCErjOkvrHW6r
	 SIijjk3oqFcAcB+uxFmunCJxi+B5tYdbiZTemKSZmSZTYH0MgP1WKE/xlt/9eD/RCP
	 OX/5zEUVgwR5R74ONBLJ8zVw4EETwt4V30dqhj1G44opfQaSHiUkzmvcWocK447xd/
	 nF2jvnGU7KJXfu9KwP5uNT4tmp6UEDRMBtMiZ7y0TsVXiH+x4hoobBc2KQ7fD9rVAv
	 9lx/czXU4Fnc3rCzmJqADmxCY6mD4FPWRgV2bKroo9K2ACYQrOJakCzOvvB2atImtW
	 1lNPJ6c0zXMKQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 22/23] perf python: Add perf.pyi stubs file
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260522220435.2378363-23-irogers@google.com>
References: <20260522220435.2378363-23-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 22 May 2026 22:46:21 +0000
Message-Id: <20260522224622.79B251F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Several type stubs omit optional arguments, include incorrect argu=
ments, or provide incorrect callback signatures compared to the underlying =
C implementation.
- [High] Event classes in `perf.pyi` omit numerous attributes exposed by th=
e C extension and declare attributes that do not exist.
- [Medium] The `perf.pyi` type stub file is not included in the Python exte=
nsion distribution.
- [Medium] The module-level `tracepoint` method is missing from the type st=
ubs.
--

commit 55dca7ad7944e4ffd824e2f8978f664aa6e28e2b
Author: Ian Rogers <irogers@google.com>

perf python: Add perf.pyi stubs file

This commit adds Python type stubs for the perf module to improve IDE
support and static analysis. It provides classes, methods, and constants
derived from the C source definitions.

> diff --git a/tools/perf/python/perf.pyi b/tools/perf/python/perf.pyi
> new file mode 100644
> index 0000000000000..1d1d2a833f10c
> --- /dev/null
> +++ b/tools/perf/python/perf.pyi
> @@ -0,0 +1,605 @@
> +"""Type stubs for the perf Python module."""
> +from typing import Callable, Dict, List, Optional, Any, Iterator

[Severity: Medium]
Will this stub file actually be installed into the user site-packages
directory?

Looking at tools/perf/util/setup.py and tools/perf/Makefile.perf, there
doesn't appear to be any logic to copy perf.pyi into the build output
directory alongside the compiled perf extension.=20

Without deployment, this regression might prevent IDEs and static analysis
tools from accessing these stubs.

> [ ... ]
> +def parse_metrics(metrics_string: str) -> 'evlist':
> +    """Parse a string of metrics or metric groups and return an evlist."=
""
> +    ...

[Severity: High]
Does this match the C implementation of parse_metrics?

The C extension appears to accept additional parameters like pmu, cpus, and
threads. Missing these arguments in the stub is a regression that might cau=
se
type checkers to incorrectly flag valid calls.

> +def pmus() -> Iterator[Any]:
> +    """Returns a sequence of pmus."""
> +    ...

[Severity: Medium]
Is the module-level tracepoint method missing from these stubs?

In tools/perf/util/python.c, the perf__methods array exports a tracepoint
method mapped to pyrf__tracepoint. Omitting it here is a regression that
might cause IDEs to report calls to perf.tracepoint as unresolved reference=
s.

> [ ... ]
> +class counts_values:
> +    """Raw counter values."""
> +    val: int
> +    ena: int
> +    run: int

[Severity: High]
Do these attributes exist on the counts_values class at runtime?

The C code exposes a single values attribute returning a list of the three
integers using pyrf_counts_values_getset. Developers relying on val,
ena, and run in the stubs might encounter AttributeError regressions.

> [ ... ]
> +class evsel:
> +    """Event selector, represents a single event being monitored."""
> +    def __init__(
> +        self,
> +        type: int =3D ...,
> +        config: int =3D ...,
> [ ... ]
> +        freq: bool =3D ...,
> +        idx: int =3D ...,
> +    ) -> None: ...

[Severity: High]
Does this constructor signature match what the C extension expects?

The C constructor only has 29 strings in kwlist and parses 29 format
characters. It appears to miss over 10 configuration parameters like
inherit_stat or enable_on_exec, and incorrectly includes an idx parameter.

Passing idx based on this stub will raise a runtime TypeError regression.

> [ ... ]
> +class mmap_event:
> +    """Represents a mmap event from perf."""
> +    type: int
> +    pid: int
> +    tid: int
> +    addr: int

[Severity: High]
Should addr be named start instead?

In the C code, pyrf_mmap_event__members exports this field as start.

There are also attributes injected by the sample_members macro like
sample_pid, sample_tid, and sample_time that appear to be missing from
the event classes here.

> [ ... ]
> +class read_event:
> +    """Represents a READ record."""
> +    type: int
> +    pid: int
> +    tid: int
> +    value: int

[Severity: High]
Do the type and value fields exist in the C members array for read_event?

It looks like pyrf_read_event__members and pyrf_lost_event__members do not
contain these fields.

> [ ... ]
> +class switch_event:
> +    """Represents a SWITCH or SWITCH_CPU_WIDE record."""
> +    type: int

[Severity: High]
Are next_prev_pid and next_prev_tid missing from this class?

These fields are present in the C structure but omitted here.

> [ ... ]
> +class evlist:
> [ ... ]
> +    def mmap(self) -> None:
> +        """Memory map the event buffers."""
> +        ...

[Severity: High]
Are the pages and overwrite arguments missing from this stub?

> +    def poll(self, timeout: int) -> int:
> +        """Poll for events.
> [ ... ]
> +        """
> +        ...

[Severity: High]
Is timeout an optional parameter in the C implementation?

If it doesn't have a default value in the stub, type checkers will require
it, even if the C extension allows calling poll without arguments.

> +    def read_on_cpu(self, cpu: int) -> Optional[sample_event]:
> +        """Read a sample event from a specific CPU.
> [ ... ]
> +        """
> +        ...

[Severity: High]
Is the sample_id_all parameter missing from this method signature?

> [ ... ]
> +class session:
> +    def __init__(
> +        self,
> +        data: data,
> +        sample: Optional[Callable[[sample_event], None]] =3D None,
> +        stat: Optional[Callable[[Any, Optional[str]], None]] =3D None
> +    ) -> None:

[Severity: High]
Does the stat callback signature match how the C runtime invokes it?

The C code in pyrf_session_tool__stat_round calls it with exactly
one argument for RECORD_STAT_ROUND events. If users follow this stub and
expect two arguments, it might result in a TypeError regression.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260522220435.2378=
363-1-irogers@google.com?part=3D22
