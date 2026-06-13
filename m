Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FAC93090C6
	for <linux-perf-users@vger.kernel.org>; Sat, 13 Jun 2026 05:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781330073; cv=none; b=c6Kz+7IN5I/iMwcccMA8SQBQtN+gXtJGROPImYjeK3OKzy7X8Kc8M0la+aRe3sxDR8ELja8pSGJV1eL4mMEOGEHWOsmjN5sPq5p9qhIEz8dmNQVo/zGfYZuYiJN0sNT3lBeFNZU4HJkyVaNPvadt4Nk6uDTsi6S6xYjhiEVCBGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781330073; c=relaxed/simple;
	bh=7O3Fj+D0IKUX/TQ2uPb34Rob0AgVz2akZ9vjOtR0DWc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Yo8aPQmedOZm28P7THiJw91qHZ73Luf4SD+S98QtTjTkJY31xvHzB5IlhquspBSqBGFs+l/uq6bsIUkrhoBc+s5pJr1pyuxav6IKA5FOMGaqkCrjelcV9pJZkxu6Pvn68X+e8CvOPEnR30lv+NqcQkQ+ApBaVOo238RhnjbPY3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gl5E/neK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gl5E/neK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDA671F000E9;
	Sat, 13 Jun 2026 05:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781330072;
	bh=K9+UU9xPEkonUP1BiPpDmzGzGeuOo2+Ebn21dW3Mldw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Gl5E/neKBceW7dZ0SYx1LgBcf1LfO/R7Vlqb7zwERUFKUeLg6nu/L7oZjPqGFKLmR
	 91YgOG8pUSaK8VWTnBs2Mt5O91zPfySEeYsfpIZwt8AlUscaWMZf9yZgruAZxA5cdE
	 eOSAF4gyTNBoca1T4f+zChc8wiDi4JNWDKSP2HHKUOdEYHh8FgEdLOyt0/wwz/R+8F
	 S8QeRj33qXNqCRmD+EhdHWUMPuJwX/VkGfjgdTFGI+rs6l1mEk0J1I/FsqFgnSNt8u
	 92p/f78FXsYV7S/EYihdmcNbQsW2FCU8OYCMbCA2eMpiwVZufRN+s19EnF5Kz0aWQk
	 nM1S+BRdrU/hA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v16 19/20] perf python: Add perf.pyi stubs file
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260613052722.1424093-20-irogers@google.com>
References: <20260613052722.1424093-20-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 13 Jun 2026 05:54:31 +0000
Message-Id: <20260613055431.CDA671F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The generated Python type stub (perf.pyi) inaccurately represent=
s the C runtime API, missing several properties, misspecifying names, and u=
sing overly restrictive return types.
--

commit 7056c6beff82d5d13d0de91848cccdb94b9ac537
Author: Ian Rogers <irogers@google.com>

perf python: Add perf.pyi stubs file

Add Python type stubs for the perf module to improve IDE support and
static analysis.  Includes docstrings for classes, methods, and
constants derived from C source and JSON definitions.

> diff --git a/tools/perf/python/perf.pyi b/tools/perf/python/perf.pyi
> new file mode 100644
> index 0000000000000..f789cbfa1e410
> --- /dev/null
> +++ b/tools/perf/python/perf.pyi

[ ... ]

> +class evsel:
> +    """Event selector, represents a single event being monitored."""
> +    def __init__(
> +        self,
> +        type: int =3D ...,
[ ... ]
> +        wakeup_events: int =3D ...,
> +        bp_type: int =3D ...,
> +        bp_addr: int =3D ...,
> +        bp_len: int =3D ...,
> +    ) -> None: ...

[Severity: Medium]
Are we missing the idx keyword argument here? pyrf_evsel__init() in the
C extension parses an idx argument, but it seems to be omitted from the
type stub.

[ ... ]

> +class sample_event(_sample_members):
> +    """Represents a sample event from perf."""
> +    evsel: evsel
> +    sample_ip: int
[ ... ]
> +    raw_buf: bytes
> +    dso: str
> +    map_start: int
> +    brstack: Optional['branch_stack']

[Severity: Medium]
Are several properties missing from this class? pyrf_sample_event__getset
in the C code exports dso_long_name, dso_bid, map_end, map_pgoff, symbol,
sym_start, and sym_end, which do not appear in this stub.

> +    callchain: Optional['callchain']
> +    def srccode(self) -> str: ...
> +    def insn(self) -> str: ...
> +    def __getattr__(self, name: str) -> Any: ...
> +
> +class mmap_event(_sample_members):
> +    """Represents a mmap event from perf."""
> +    type: int
> +    misc: int
> +    pid: int

[Severity: Medium]
Should this class (and other event classes) include the evsel property?
The evsel property is exposed on all events via pyrf_event__getset in the
C code, but the stub currently only defines it for sample_event and
mmap2_event.

[ ... ]

> +class callchain_node:
> +    """Represents a frame in the callchain."""
> +    ip: int
> +    sym: Optional[Any]
> +    map: Optional[Any]

[Severity: Medium]
Should these properties be named symbol and dso instead of sym and map?
The C code in pyrf_callchain_node__getset exports them as symbol and dso.
This could cause static analysis tools to flag valid property accesses
as errors.

[ ... ]

> +class stat_round_event(_sample_members):
> +    """Represents a stat round event from perf."""
> +    type: int
> +    time: int

[Severity: Medium]
Is the stat_round_type property missing here? It is explicitly exported
by pyrf_stat_round_event__members in the C code.

[ ... ]

> +class evlist:
> +    def __init__(self, cpus: cpu_map, threads: thread_map) -> None: ...
> +    def open(self) -> None:
[ ... ]
> +    def poll(self, timeout: int) -> int:
> +        """Poll for events.
> +
> +        Args:
> +            timeout: Timeout in milliseconds.
> +
> +        Returns:
> +            Number of events ready.
> +        """
> +        ...
> +    def read_on_cpu(self, cpu: int) -> Optional[sample_event]:

[Severity: Medium]
Is the return type Optional[sample_event] overly restrictive? The C
function pyrf_evlist__read_on_cpu dynamically instantiates and returns
various event types (like mmap_event, comm_event, etc.) based on
event->header.type, rather than just returning sample_event.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260613052722.1424=
093-1-irogers@google.com?part=3D19
