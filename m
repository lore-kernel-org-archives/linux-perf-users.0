Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8621548BD57
	for <linux-perf-users@vger.kernel.org>; Thu, 11 Jun 2026 18:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781200826; cv=none; b=euH13w9mXrZ6OHJi1U442ipL3jP9sxvuxkgO0nrtjumzs9SO+WXGdnSZY+27Rot+ngqN7rgBbkIvAmmDy0D0ZUWsnWZDmJ0mdqnnwETq0r4enqqXZvNO+tbQXYOeUk4Wms3/wGZJNLba2ESCWAekso9pc4WRBCw/zgdfHNUiqkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781200826; c=relaxed/simple;
	bh=h7ZcBSfP4dntZhWs9M3aWDleRYZA8gaRiCLJEAQF47M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fNA1P6KZz4SeE0U6dR4PGQd/PeankFAySypfbkojjUs/OgBSbXHWksqELcfMyXkLRHvOo88/q7+RUvCXfwaFqB92Pqji99Z06m8yd2GRathohPcIJu3Qm7IXY7DI3/UTkEqzS+N5lhdbIdsPqZXCMf0Py34kFh6iBBaUOLP5suk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rdn5wQjJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rdn5wQjJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBAC71F00893;
	Thu, 11 Jun 2026 18:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781200824;
	bh=/H4RPQYezPzAY0hil1b9eMrSSdyLkUMhgKtck8zcaY4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Rdn5wQjJ3N3QiQd6cvYpXo6nSgLNL4ca3uW6YtBVgWBlvQ0nKuv6c6fhsQDvOTCuW
	 k6QEXdKLPLiR+rr+Y01493EeXVXAT1tSpQdIVJ+OJ8SwV1TIVK0U7Zkz6NX7+tP0OE
	 1ckvtm0FSyZ+yOvHBmbmiw0GrqMbTOJSPvD0PRDaRWDvgQjKDFcJWeOS2vjR3/yEv3
	 aPc8eNG/u4oq2p9s2PCPkVEh6F/PKu6xfzYcpBbhbF9Ve4woX9xKbLJawuyUWKmTgS
	 yiQcnMQxXbRIM5bp4cEpw0SpBneSfJo/LRrGCZLSnDxeAMBMw50HrzCGObPy3zgi62
	 352n5CBP8xnfw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 18/19] perf python: Add perf.pyi stubs file
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260611171756.4008769-19-irogers@google.com>
References: <20260611171756.4008769-19-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 18:00:22 +0000
Message-Id: <20260611180023.CBAC71F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The `perf.pyi` type stub file contains multiple inaccurate or in=
complete class definitions that do not match the C implementation.
- [Low] The Makefile rule for building the python extension misses `python/=
perf.pyi` as a dependency.
--

commit f3d52b87d773a5fc9945194f762ef3353b9c5678
Author: Ian Rogers <irogers@google.com>

perf python: Add perf.pyi stubs file

Add Python type stubs for the perf module to improve IDE support and
static analysis. Includes docstrings for classes, methods, and
constants derived from C source and JSON definitions.

> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -522,7 +522,10 @@ $(OUTPUT)python/perf$(PYTHON_EXTENSION_SUFFIX): util=
/python.c util/setup.py $(PE
>          CFLAGS=3D'$(CFLAGS)' LDFLAGS=3D'$(LDFLAGS) $(LIBS_PY)' \
>  	  $(PYTHON_WORD) util/setup.py \
>  	  $(python_setup_quiet) build_ext; \
> -	cp $(PYTHON_EXTBUILD_LIB)perf*.so $(OUTPUT)python/
> +	cp $(PYTHON_EXTBUILD_LIB)perf*.so $(OUTPUT)python/; \
> +	if [ "$(abspath python/perf.pyi)" !=3D "$(abspath $(OUTPUT)python/perf.=
pyi)" ]; then \
> +		cp python/perf.pyi $(OUTPUT)python/; \
> +	fi

[Severity: Low]
Since python/perf.pyi is being copied to the output directory here, should
it also be added to the dependency list for the target? Without it, if a
developer modifies python/perf.pyi, the build system might not detect the
change and copy the updated stub file.

> diff --git a/tools/perf/python/perf.pyi b/tools/perf/python/perf.pyi
> new file mode 100644
> --- /dev/null
> +++ b/tools/perf/python/perf.pyi

[ ... ]

> +class counts_values:
> +    """Raw counter values."""
> +    val: int
> +    ena: int
> +    run: int

[Severity: Medium]
Are there missing fields in this class definition? Compared to the C
implementation, it looks like the 'id' and 'lost' attributes might be missi=
ng
from counts_values.

[ ... ]

> +class lost_event(_sample_members):
> +    """Represents a lost events record."""
> +    type: int
> +    id: int
> +    lost: int

[Severity: Medium]
Does this class actually export a 'type' attribute? Checking the C
implementation's PyMemberDef array, it doesn't appear to be exported,
which might cause false positives in type checkers.

[ ... ]

> +class read_event(_sample_members):
> +    """Represents a READ record."""
> +    type: int
> +    pid: int
> +    tid: int

[Severity: Medium]
Similar to lost_event, is 'type' actually exported for read_event by the
C extension?

[ ... ]

> +class stat_event:
> +    """Represents a stat event from perf."""
> +    type: int
> +    id: int
> +    cpu: int
> +    thread: int
> +    val: int
> +    ena: int
> +    run: int

[Severity: Medium]
Should this class inherit from _sample_members? The C implementation
for stat_event includes sample_members.

[ ... ]

> +class stat_round_event:
> +    """Represents a stat round event from perf."""
> +    type: int
> +    time: int

[Severity: Medium]
Does stat_round_event also need to inherit from _sample_members?
Additionally, it looks like the 'stat_round_type' attribute might be
missing from this stub.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611171756.4008=
769-1-irogers@google.com?part=3D18
