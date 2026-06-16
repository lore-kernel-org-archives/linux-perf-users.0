Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320DC30C632
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 01:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781575185; cv=none; b=JdGdGGk+XhoOyONMh6VaKSJUXdN09ow6OLyZS52oxgIBPO+3FavweiRdgASqk+KsoxtvmNa0nymSKAXsbwhWL+QGPXO0FCS51trSCJcOF4d57K1va7iqjUayMNZ1rkEfcTgRqqJVWQMxSJHTMGwKAfLVVWvjdgtgPhS4h1CVnLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781575185; c=relaxed/simple;
	bh=oP3FPCK8wl0XLFOs55QXgUrAiDThwAIHMAb2u7QRqj0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MUHWtsAuaEhWn6X+pBaNN6MfAUtYANtguW7aEOGGNJib6uBBytPGLPHlPwM238tHhHjvt4OXcajeZ+TC4Cdzw2ua2WpEwZWz1QuPGtcHSyf4geyCn71pbCpZvXU1kbtLsM4PkDDkDBrVJcsi1/0o3zuIiRyfAq560tFlgrchvEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=npzL5V5d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="npzL5V5d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B43441F000E9;
	Tue, 16 Jun 2026 01:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781575183;
	bh=ZcGdw6WbaYuY6Fy2rp3GJ0mSO381I7vp2YXvEvuJ/L0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=npzL5V5d34mmCzwiEJbXAwl92gjNtU9pfZYBqNYWGFotPcqjcRqMTScW7YmOXA65j
	 ePPJHYYUEUJLjnCayqZSAK1m8U01URBWrH6mw0sazhCkAE2+9XyFtqY7FEToe5vxdt
	 PWrF9BG+z/mciJF/JFjg8+dDwaCri7kX8WNiQorgTmWVdoFUjmnKZC10U9fO4ggZ9g
	 WF4kOJUcwYIg1IjC3PT3TeBPo7cnYKAfBjW64syo0VWIxB8V6KG9ZSk7GJUnUjSyy+
	 7RxvpbxJuQ6OjIC8c36hJMHWv6mGbLtVPrYvNqqWppFTC/IUf10p8VQgzJ5+pc6Sp1
	 DzifLrOKSP5TA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v21 20/21] perf python: Add perf.pyi stubs file
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260616011543.4037138-21-irogers@google.com>
References: <20260616011543.4037138-21-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 01:59:43 +0000
Message-Id: <20260616015943.B43441F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The `metrics()` function type stub incorrectly specifies the ret=
urn type as `List[Dict[str, str]]`.
--

commit 15488fc0400fa58c2b16fb87ba64c62006a2314e
Author: Ian Rogers <irogers@google.com>

perf python: Add perf.pyi stubs file

This commit adds Python type stubs for the perf module to improve IDE
support and static analysis. The stubs include docstrings for classes,
methods, and constants derived from C sources and JSON definitions.

> diff --git a/tools/perf/python/perf.pyi b/tools/perf/python/perf.pyi
> new file mode 100644
> index 0000000000000..f266c9baffd01
> --- /dev/null
> +++ b/tools/perf/python/perf.pyi
> @@ -0,0 +1,672 @@
> +"""Type stubs for the perf Python module."""
> +from typing import Callable, Dict, List, Optional, Any, Iterator

[ ... ]

> +def metrics() -> List[Dict[str, str]]:

[Severity: Medium]
In the C implementation, specifically pyrf__metrics_cb() and
pyrf__metrics_groups() in tools/perf/util/python.c, the returned dictionary
contains a MetricGroup key which is populated with a Python list of strings,
not a single string.

Does this type stub incorrectly restrict the dictionary values to strings
only? Static analysis tools might flag valid list operations on MetricGroup
values as type errors if they expect every value to strictly be a string.

> +    """Get a list of available metrics.
> +
> +    Returns:
> +        A list of dictionaries, each describing a metric.
> +    """
> +    ...

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616011543.4037=
138-1-irogers@google.com?part=3D20
