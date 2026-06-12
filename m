Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00471306B08
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Jun 2026 18:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781289305; cv=none; b=ec1Q+AbOR+g9wiCmNE8yHHFFCJt2FbdilLC5eob2NM51OYFzgCBeWnRxJ10gxvYKr7uTASs+AllnoVGut9vea6gBat1k0LKvxh1sssHVkZsXKQixae8A210NHyLsnyjOJYQPWQRp380YP+L4cL2y5DWpgR1D7i5nxO1gT6QCwvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781289305; c=relaxed/simple;
	bh=ER1TUdqBJI/4B9Gap/77c9sKqScupBeOr+N75Ig1AQU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fnFVlUECEvvliPCXL7X40499nhG7U+M6WNiafAZvkVw0DXspVMmt45iO3DdrEHk9W5lGTR0N1efT2AFhB8vlcmKiSBAJYX0R2WlmuRZwWsxohAGZmpj2eGNyY0I5mVEaxsrYZCRya+BcqOq7xy8tVqqrz3EKICcp0XGjcVvDuJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RA+YlVM3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RA+YlVM3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72D2A1F000E9;
	Fri, 12 Jun 2026 18:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781289303;
	bh=FestUT3MWM388RLB0yiUVnlOOKCNU3cdxNKwieX7T0o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RA+YlVM3qLLuvaTgT6VHzXY4zR5YY8Pn2pUuP5OmarG9JP3DTJZTmoKD/q+GSze1a
	 QCzUhbHy66cmkAHXBykRguqtZ9Qab7nds/sAIJ99MUuszv+mI7BjBChUm9RHWZPrCy
	 njG8v1yprxOzPVWYjP+iuNiNRnAyg7jRHpdHv42SzUK21+duYd4sLTwmJ7RxfsymfZ
	 8lbLcCuDPM2QXZKdTQxCX44IY5OzrtGmm+kyS64nN+TcZe4UkFTRipBiICZ/+G5i5f
	 l6Lk0OhR+EDQVolWrgiLU8coLj/HDW+RxxrxqoHMLKlTB/Ev4kG23H+ZdhnZJxRt7s
	 mltt1MvRFpE5g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 18/19] perf python: Add perf.pyi stubs file
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260612180956.1105352-19-irogers@google.com>
References: <20260612180956.1105352-19-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 18:35:03 +0000
Message-Id: <20260612183503.72D2A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Incomplete and inaccurate Python type stubs misrepresent the C e=
xtension.
- [Low] Missing file tracking for `perf.pyi` in Makefile dependency list.
--

commit 0becfda4334bc6af9250ae05c834cef6f97aa5ca
Author: Ian Rogers <irogers@google.com>

perf python: Add perf.pyi stubs file

Add Python type stubs for the perf module to improve IDE support and
static analysis.  Includes docstrings for classes, methods, and
constants derived from C source and JSON definitions.

> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index 476b8dcaef58c..3f22937aaba6a 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf

[ ... ]

> @@ -522,7 +522,10 @@ $(OUTPUT)python/perf$(PYTHON_EXTENSION_SUFFIX): util=
/python.c util/setup.py $(PE

[Severity: Low]
Does python/perf.pyi need to be added to the prerequisite list for this tar=
get?

If a developer edits the perf.pyi stub file without modifying util/python.c=
 or
setup.py, it seems Make will consider the target up-to-date and won't copy =
the
updated stubs to the output directory.

>          CFLAGS=3D'$(CFLAGS)' LDFLAGS=3D'$(LDFLAGS) $(LIBS_PY)' \
>  	  $(PYTHON_WORD) util/setup.py \
>  	  $(python_setup_quiet) build_ext; \
> -	cp $(PYTHON_EXTBUILD_LIB)perf*.so $(OUTPUT)python/
> +	cp $(PYTHON_EXTBUILD_LIB)perf*.so $(OUTPUT)python/; \
> +	if [ "$(abspath python/perf.pyi)" !=3D "$(abspath $(OUTPUT)python/perf.=
pyi)" ]; then \
> +		cp python/perf.pyi $(OUTPUT)python/; \
> +	fi
> =20
>  python_perf_target:
>  	@echo "Target is: $(OUTPUT)python/perf$(PYTHON_EXTENSION_SUFFIX)"

[ ... ]

> diff --git a/tools/perf/python/perf.pyi b/tools/perf/python/perf.pyi
> new file mode 100644
> index 0000000000000..28b1cf4e89a1d
> --- /dev/null
> +++ b/tools/perf/python/perf.pyi

[ ... ]

> +class counts_values:
> +    """Raw counter values."""
> +    val: int
> +    ena: int
> +    run: int

[Severity: Medium]
Are there missing properties here? The C extension seems to define addition=
al
properties like id, lost, and values for counts_values. Missing them in the
stub might cause false positives in static analysis.

[ ... ]

> +class sample_event(_sample_members):
> +    """Represents a sample event from perf."""
> +    evsel: evsel

[Severity: Medium]
Are there missing properties and methods here? The C extension explicitly
defines raw_buf, dso, map_start, srccode(), and insn(). Omitting them
here could cause static analysis tools and IDEs to report errors on valid
code.

[ ... ]

> +class branch_stack:
> +    """Iterator over branch entries in the branch stack."""
> +    def __iter__(self) -> Iterator[branch_entry]: ...
> +    def __next__(self) -> branch_entry: ...
> +
> +class callchain_node:
> +    """Represents a frame in the callchain."""
> +    ip: int
> +    sym: Optional[Any]
> +    map: Optional[Any]
> +
> +class callchain:
> +    """Iterator over callchain frames."""
> +    def __iter__(self) -> Iterator[callchain_node]: ...
> +    def __next__(self) -> callchain_node: ...

[Severity: Medium]
Does the C extension actually implement __next__ for branch_stack and
callchain? It looks like the C code implements them as sequences
(__len__, __getitem__) rather than iterators. Declaring __next__ here
might mislead IDEs and type checkers.

[ ... ]

> +class stat_round_event:
> +    """Represents a stat round event from perf."""
> +    type: int
> +    time: int

[Severity: Medium]
Should stat_round_event inherit from _sample_members? The C extension
seems to include those properties, but the stub doesn't reflect that.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612180956.1105=
352-1-irogers@google.com?part=3D18
