Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D72B409128
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 17:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781545468; cv=none; b=GEK54Lo7t4mSuUY2Phe+hJSuSB9hKJebTN67DgpGZbklNXHLZWOfwth2ae9bTGpuDJ7X2jreP4R/kjDALRBJoHXuJc8X3Nf0pNzv0FaPm8YeQm3wY0F2O/akdC6RmXeMgTBp2OaD7oZV/dXvxii33qEomQvEI7xloyTmJYCPQAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781545468; c=relaxed/simple;
	bh=GiPPFl51gpR0ccGc4RQ+8s5AnxNempzxazsq5z9uVL8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TuLRQp+07Rgi6dMrg1N8BmokpoBkp1vyp+DNt+1qVvaBFZsFzQ2prBzK7hii5myKaaT+WIqIgjz0vGI227cRgnYBxKN0QSxGTIWriAJi9u631kTEUwBjAjR0ohZ7RYoDQq7frMBLzZ33Ze58N5Owx5mG7wVUoFVOjXY+drVjWzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GN80skpj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GN80skpj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CCA31F000E9;
	Mon, 15 Jun 2026 17:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781545467;
	bh=RdqQaYz5r3hke4iCi0tnDKrbM0CpTe/RK8Xcl26vnhk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GN80skpjNhw5hfAFF2LANgkkQa8n7Sda9hAW1ZD/IUWQdYEJasM+V8gfFhziXqBqy
	 rsm6oMWk+tGiNChonrO4Pt9UEn1dCkMCx2fId0Mt4kphg0iODJan/zKSh6WvseQN7y
	 /xbKvFWBxuP4XbQdcrh8CPm0OQjVKcSJOrJDAbLva53v8enBElC8ajT/unOnWrYz5l
	 PsCcWU3wXAF091OaIe7296PP7Sr4Ypp7D48Y1PppO9N70LODTD4YYKP4xACT+0mdAy
	 92CIf1KqWxVfCo0UFI0nNc5Li/+2HwE649f+eplQN2Js0vdP70/lisQU5goSqrf0Fx
	 Trb/aliivCMPQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 19/20] perf python: Add perf.pyi stubs file
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260615165010.2724690-20-irogers@google.com>
References: <20260615165010.2724690-20-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 17:44:26 +0000
Message-Id: <20260615174427.1CCA31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The `threads` parameter in `parse_events` and `parse_metrics` is=
 incorrectly typed as `Optional[Any]` instead of `Optional[thread_map]` in =
the Python stub.
--

commit f0a6059a4cf5c1057a3059c16b0bf6396ea4935a
Author: Ian Rogers <irogers@google.com>

perf python: Add perf.pyi stubs file

This commit adds Python type stubs for the perf module to improve IDE
support and static analysis. It includes docstrings for classes, methods,
and constants derived from C source and JSON definitions.

> diff --git a/tools/perf/python/perf.pyi b/tools/perf/python/perf.pyi
> new file mode 100644
> index 0000000000000..976ff965263b2
> --- /dev/null
> +++ b/tools/perf/python/perf.pyi

[ ... ]

> +def parse_events(
> +    event_string: str,
> +    cpus: Optional[cpu_map] =3D None,
> +    threads: Optional[Any] =3D None
> +) -> 'evlist':

[Severity: Medium]
Should the threads parameter be typed as Optional['thread_map'] instead of
Optional[Any]?

The underlying C implementation of parse_events directly casts the threads
argument to a struct pyrf_thread_map pointer without runtime type
validation. By leaving this loosely typed as Any in the stub, static type
checkers might silently allow passing arbitrary Python objects into this
function. Could this lead to memory corruption or a segmentation fault at
runtime in the Python interpreter?

[ ... ]

> +def parse_metrics(
> +    metrics_string: str,
> +    pmu: Optional[str] =3D None,
> +    cpus: Optional[cpu_map] =3D None,
> +    threads: Optional[Any] =3D None
> +) -> 'evlist':

[Severity: Medium]
Similarly here, does this also need to be restricted to Optional['thread_ma=
p']
to ensure static analysis catches invalid types before they are passed to
the C extension?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615165010.2724=
690-1-irogers@google.com?part=3D19
