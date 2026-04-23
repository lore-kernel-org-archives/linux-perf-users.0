Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC158F49
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 04:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776918016; cv=none; b=mW6x3dMe7dpWZwGckna3AueTUJ649aJz3+im6s2qk0JpiwueYsdhEfY9Svwj9RbcsIZujRWnQVwonelcn2bEb4lJn9cfUtmVmvVuaJDCsCElxSEmGQtMrRBgmI2IgS6gLpe3PnWDLFK+wGkKGdQwobgsasSZ36ht76gnIrCzciE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776918016; c=relaxed/simple;
	bh=GXKDmcJ/SftSVex1hdDBYusFyBL1uyMhJpJsF0z1ngY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HIiLt8/bNw2aKQiZSbaTh+hEuAvhdI7Odm5pKKn9VouSrcNXE6bOuDNbufOzat1KZKEeKGOMg4vyXu5Iot0ve/p4mOu/h+W2hiuar8LPGSK7ZvuHLjX/DUnXRCKLAKsVxzTz7ebj8dgHrZQeEpaB40eH0+ViFyIxQY926Q+IbEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uyvK3fPy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uyvK3fPy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5EC5C2BCB2;
	Thu, 23 Apr 2026 04:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776918015;
	bh=GXKDmcJ/SftSVex1hdDBYusFyBL1uyMhJpJsF0z1ngY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=uyvK3fPynu5OAEofk6/eRCHMk9W/QsAnU2XRtGCV+x5s73VIFRGqROpPNWWcRV6hH
	 LrP7Vg6hItHDiJfjIv0A/P2IAbBR/sG3PYZhmMH9SiM2p7aGLuRB6DEna7MU2yAKxP
	 Ie7CSV6/oShYewPy4wOw1OMm2WvuOXAzgNRAADnHpKb1iyWvrCNVG6MjOLv4WrEpUe
	 JBZCwNg965h1oFn9+qWJelAi2MTWOvV5a7LzV2sZ0XMVdgLLZJv0ZeVHia5M8HBo0j
	 FFvAOaZVr0rPEZQiQ8a/TeceBpzgw3FMSMUDIklBoDi1SOw2bqUEF7zwPDvme3+9oZ
	 5GEi8rwAYYEHA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 22/58] perf python: Add perf.pyi stubs file
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260423035526.1537178-23-irogers@google.com>
References: <20260423035526.1537178-23-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Apr 2026 04:20:15 +0000
Message-Id: <20260423042015.A5EC5C2BCB2@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 3 potential issue(s):
- [Medium] Missing build system integration for `perf.pyi`
- [Medium] Inaccurate and incomplete API method signatures in `perf.pyi`
- [Medium] Hallucinated and missing attributes in event class stubs
--

commit 91be6bb21ba4a262cbe51c81656804886324284d
Author: Ian Rogers <irogers@google.com>

perf python: Add perf.pyi stubs file

This commit adds Python type stubs (perf.pyi) for the perf module to improve
IDE support and static analysis. It includes docstrings for classes, method=
s,
and constants based on C source and JSON definitions.

> diff --git a/tools/perf/python/perf.pyi b/tools/perf/python/perf.pyi
> new file mode 100644
> index 0000000000000..7ab0dfc44d1cb
> --- /dev/null
> +++ b/tools/perf/python/perf.pyi

Since perf.pyi isn't added to tools/perf/util/setup.py or
tools/perf/Makefile.perf, will this file actually get installed? Python type
stubs typically need to be distributed and installed in the site-packages
directory to be discovered by IDEs and static analysis tools like mypy.

> @@ -0,0 +1,579 @@
> +"""Type stubs for the perf Python module."""
> +from typing import Callable, Dict, List, Optional, Any, Iterator

Are there missing functions in this module? The module-level function
perf.tracepoint() is explicitly exported by the C extension but is complete=
ly
missing from these stubs.

[ ... ]

> +class counts_values:
> +    """Raw counter values."""
> +    val: int
> +    ena: int
> +    run: int

Are these attributes complete? The C extension also includes id, lost, and
values attributes for this class.

[ ... ]

> +class evsel:
> +    """Event selector, represents a single event being monitored."""
> +    def __init__(
> +        self,
> +        type: int =3D ...,
> +        config: int =3D ...,
> +        sample_freq: int =3D ...,
> +        sample_period: int =3D ...,
> +        sample_type: int =3D ...,
> +        read_format: int =3D ...,
> +        disabled: bool =3D ...,
> +        inherit: bool =3D ...,
> +        pinned: bool =3D ...,
> +        exclusive: bool =3D ...,
> +        exclude_user: bool =3D ...,
> +        exclude_kernel: bool =3D ...,
> +        exclude_hv: bool =3D ...,
> +        exclude_idle: bool =3D ...,
> +        mmap: bool =3D ...,
> +        context_switch: bool =3D ...,
> +        comm: bool =3D ...,
> +        freq: bool =3D ...,
> +        idx: int =3D ...,
> +    ) -> None: ...

Do these arguments match the C API? The C extension accepts over 20 keyword
arguments (including inherit_stat, enable_on_exec, watermark, etc.), which
are omitted here. Additionally, the idx argument doesn't appear to be
supported by the C code.

> +    def __str__(self) -> str:
> +        """Return string representation of the event."""
> +        ...
> +    def open(self) -> None:

Does this match the C implementation? In the C code, open() accepts
cpus, threads, group, and inherit arguments, but this stub restricts
it to zero arguments.

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

Is this missing some properties and methods exported by the C extension?
Attributes like sym_end and methods like srccode() and insn() are missing
from this stub.

> +    def __getattr__(self, name: str) -> Any: ...
> +
> +class mmap_event:
> +    """Represents a mmap event from perf."""
> +    type: int
> +    pid: int
> +    tid: int
> +    addr: int

Does the C extension export addr here? It appears to export a start
attribute instead of addr, and also includes a misc field that is missing
from this stub.

Additionally, event classes exported by the C extension (except sample_even=
t)
include fields generated by the sample_members macro (like sample_pid,
sample_tid, sample_time). Should those be included in these event stubs?

> +    len: int
> +    pgoff: int
> +    filename: str
> +
> +class lost_event:
> +    """Represents a lost events record."""
> +    type: int

Does the PyMemberDef array in C actually export a type attribute for
lost_event? Referencing it in Python might result in an AttributeError.

[ ... ]

> +class read_event:
> +    """Represents a READ record."""
> +    type: int
> +    pid: int
> +    tid: int
> +    value: int

Do type and value exist on read_event at runtime? The C implementation
doesn't seem to export these, which could lead to AttributeError at runtime.

> +
> +class switch_event:

Is this class named correctly? The C extension registers this type as
perf.context_switch_event rather than switch_event.

[ ... ]

> +class evlist:
> +    def __init__(self, cpus: cpu_map, threads: thread_map) -> None: ...
> +    def open(self) -> None:
> +        """Open the events in the list."""
> +        ...
> +    def close(self) -> None:
> +        """Close the events in the list."""
> +        ...
> +    def mmap(self) -> None:

Does this match the C API? The C implementation of evlist.mmap() accepts
optional pages and overwrite arguments, but this stub restricts it to
zero arguments.

> +        """Memory map the event buffers."""
> +        ...
> +    def poll(self, timeout: int) -> int:

Should timeout be optional here? The C implementation defaults to -1 and
can be called without arguments.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260423035526.1537=
178-1-irogers@google.com?part=3D22
