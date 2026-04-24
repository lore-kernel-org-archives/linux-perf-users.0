Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0056230BF4F
	for <linux-perf-users@vger.kernel.org>; Fri, 24 Apr 2026 17:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777050802; cv=none; b=empSueDcGFeM8QS/JsYcqaFDgheoHq9qk6Q+THdAcbDFd29gDR4lFkxRBQmNAyzMCHAVMEPhKh2pWJlqm/zKeP5LtoRX5LWthAMKGlTQFWyMA2xHrsF7nINELgLaq9VEIMpczTlYA7i5JXJSxp3L2M1U/jj6XssLxgCHnlR75As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777050802; c=relaxed/simple;
	bh=9xOlKe/Xv8F9fkyW4Y7N6BSPU82MlY59LLcy7gN8pvg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=m41tOzoEE1keTFMFBWpVnL9pKFI7R/GvSvGf+501LI2ve/pJTfHYcIgnBWmR8kALFnZzdJl4+hbWDACCulljbulAa+W8MGvcVbZYpkBytwvJBcsYsfEMPKIGA0YZTRRBGus56TDw/icfpRLPD0FXDK6W1N3cP5wQ/lY23N0rbrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YhoWW4lL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YhoWW4lL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A9A9C19425;
	Fri, 24 Apr 2026 17:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777050801;
	bh=9xOlKe/Xv8F9fkyW4Y7N6BSPU82MlY59LLcy7gN8pvg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=YhoWW4lLfe8VT+6/VqVScjtcGT9LjKlsVzc+uOjp+lLLEEAaFMO/YFxFb90Z+Uo8T
	 CSFX1SEWHrAIXj4jr1AFMp0B9f6ZfIXEW3r0Vj6/OJKxWR5nqUiQLqNKurCqdjX86Z
	 jI27coLZRTjgCX8nrDTzU9yZ4BUYIfpHKXafzW3pEBte/Go76ckNgrqxQogC1BC+3z
	 Zp5LfKUzoT//6mWI8bty+Dy+4VcX0IePq9Z0HHl4xJSZ0K3BtLSEaHgU/exfO0OWeu
	 YTdu6haR+/tbgD5n4Iv+5zL65vPgtqzoNN77pwCZBUspmrSEqw4jKoxCOYgVde6R+p
	 tTIfu3pINP73w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 22/58] perf python: Add perf.pyi stubs file
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260424164721.2229025-23-irogers@google.com>
References: <20260424164721.2229025-23-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Apr 2026 17:13:20 +0000
Message-Id: <20260424171321.9A9A9C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [Medium] Missing API definitions in the `.pyi` type stub file
- [Medium] Undefined constant `COUNT_HW_REF_CPU_CYCLES` in type stub
--

commit b859998ec9e4f050ffb4d7fd378f075e01490e9f
Author: Ian Rogers <irogers@google.com>

perf python: Add perf.pyi stubs file

This commit introduces Python type stubs for the perf module to improve IDE
support and static analysis. It adds docstrings and type definitions for
classes, methods, and constants derived from the C source.

> diff --git a/tools/perf/python/perf.pyi b/tools/perf/python/perf.pyi
> new file mode 100644
> index 00000000000000..7ab0dfc44d1cb9
> --- /dev/null
> +++ b/tools/perf/python/perf.pyi
> @@ -0,0 +1,579 @@

[ ... ]

> +def parse_metrics(metrics_string: str) -> 'evlist':
> +    """Parse a string of metrics or metric groups and return an evlist."=
""
> +    ...

Should this include the optional pmu, cpus, and threads arguments? It
looks like the C extension parses them using "s|sOO".

> +def pmus() -> Iterator[Any]:
> +    """Returns a sequence of pmus."""
> +    ...

Is the tracepoint() function missing from these module-level definitions?
It appears to be exported by the C module but omitted from this stub.

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

Does this constructor need the remaining keyword arguments defined in the
C extension?=20

The underlying kwlist defines 29 distinct arguments, but this stub only
lists 19. Missing arguments like inherit_stat, enable_on_exec, task,
watermark, and precise_ip might cause static analysis tools and IDEs to flag
valid code.

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

Should this class also define attributes like sample_tid, sample_ip,
sample_addr, and sample_period, along with methods like srccode() and
insn()?=20

The C extension exports these, so their omission might negatively affect
static analysis.

[ ... ]

> +COUNT_HW_STALLED_CYCLES_BACKEND: int
> +"""Stalled cycles during retirement [This event is an alias of idle-cycl=
es-backend]."""
> +
> +COUNT_HW_REF_CPU_CYCLES: int
> +"""Total cycles; not affected by CPU frequency scaling."""
> +
> +
> +# Cache Counters

Could this cause an AttributeError at runtime? It looks like
COUNT_HW_REF_CPU_CYCLES is not actually exported in the perf__constants arr=
ay
in tools/perf/util/python.c, which would cause issues for anyone relying on
the stub's declaration.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260424164721.2229=
025-1-irogers@google.com?part=3D22
