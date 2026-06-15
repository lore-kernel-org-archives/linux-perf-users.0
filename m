Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93DD38D3EC
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 22:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781564126; cv=none; b=J3Uh2eXmL32FrLtUVHpq+TskXywHihSUlZCgSWCuV85r9gxpdpfDbRsQrFANNNs97jphMNjT4sxPvr2LsgnDZNL6xvUieCE7Reaprq0Y5i+C+x9E6Yr1MnE76Haux2GD+cTQf42OE7xMZq8rIwaCuVarcWK3E4CbxDCLug/+w3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781564126; c=relaxed/simple;
	bh=vXQVHIXWTFF/0DFKJiUlfRiNEX3RKwOGWMmCcZMwv48=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mmQ2nWPOBwz9vT7ocGHZ3Qj6IbkYyzlwKeuH9Sp80mHZZNiUZ/ustMU/drz3Hnr5Ng3Dr6kvME6kvnQF++zT1DwgmUbb7qRprT8GxmtcpXZCiqO6SGysLfB9iA/7MpN/SqnK0+n4bCejWCMF/DS2fNtP9T6aMIpL7BJSlyM+Y9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=auua33ji; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="auua33ji"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26CE21F000E9;
	Mon, 15 Jun 2026 22:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781564125;
	bh=0QTlAwh3JS8Wk8+KgvbnMXNAw1WcVr19Juc1+Eq/qNM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=auua33jiIisko88NIIQOoWYJuCcfkFRYsEDflCMYh9EBPUicyh7wDLrYHbO6ANo5w
	 Ydr4z0MDDxr1A/lhGf1fd7+SfyTkMFzzVKGX5HXXkthaVR062eMpplbEkyHi39tyI+
	 mkINClRtn7swuwBZw7Gk/uyl7nvkaku/j4SO1gqSOLTYNI9tgGqfGpR6Z8LNvUEffj
	 LnqXLFQAjVDTN1Z4hBK0p/wA1fvQhdvs9Bd2YjZDFKc/hOCusOlMC9GvGYGGkCg0D0
	 LeVteMIddTXd0a+dFFb4fzSHJO8Iw9wb+yslZSIVXkRLPwyIv7pBHUmddm05SRA1Q7
	 GHrUsbCDCyMEQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v20 20/21] perf python: Add perf.pyi stubs file
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260615223011.3873955-21-irogers@google.com>
References: <20260615223011.3873955-21-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 22:55:24 +0000
Message-Id: <20260615225525.26CE21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Incorrect type definitions in newly added Python type stubs (per=
f.pyi)
--

commit 291ae14f89c5a2b4229164393082ddfb015deb9e
Author: Ian Rogers <irogers@google.com>

perf python: Add perf.pyi stubs file

This commit adds Python type stubs for the perf module to improve IDE suppo=
rt
and static analysis. It includes docstrings for classes, methods, and
constants derived from C source and JSON definitions.

> diff --git a/tools/perf/python/perf.pyi b/tools/perf/python/perf.pyi
> new file mode 100644
> index 0000000000000..f266c9baffd01
> --- /dev/null
> +++ b/tools/perf/python/perf.pyi

[ ... ]

> +class sample_event(_sample_members):
> +    """Represents a sample event from perf."""

[ ... ]

> +    raw_buf: bytes
> +    dso: str
> +    dso_long_name: str
> +    dso_bid: Optional[bytes]
                 ^^^^^^^^^^^^^^^

[Severity: Medium]
Does the C implementation return bytes for dso_bid? Looking at the C code in
tools/perf/util/python.c, it appears to return an Optional[str] via
PyUnicode_FromString after formatting the build ID.

> +    map_start: int

[ ... ]

> +    sym_end: int
> +    brstack: Optional['branch_stack']
> +    callchain: Optional['callchain']
> +    def srccode(self) -> str: ...
                 ^^^^^^^^^^^^^^^^^^^^^

[Severity: Medium]
Does this correctly match the C implementation of srccode()? The extension
appears to accept an optional addr integer and returns a tuple of
(srcfile, line, srccode) rather than a str.

> +    def insn(self) -> str: ...
                 ^^^^^^^^^^^^^^^^

[Severity: Medium]
Does insn() return a str? The underlying C code seems to return an
Optional[bytes] object using PyBytes_FromStringAndSize.

> +    def __getattr__(self, name: str) -> Any: ...

[ ... ]

> +class evlist:

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
> +    def read_on_cpu(self, cpu: int) -> Optional[Any]:
                            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

[Severity: Medium]
Is read_on_cpu() missing its optional sample_id_all parameter? The C method
signature ("i|i") suggests it accepts a second integer argument.

> +        """Read a sample event from a specific CPU.
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615223011.3873=
955-1-irogers@google.com?part=3D20
