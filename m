Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4145B36654C
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Jun 2026 22:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781304067; cv=none; b=GYKh+id9Ooa2nKmsQqNNI5TfQQxlSjVlOQap2Ic1CvXHjaPviu4/ZQuVKOHeOHbE+oP5Zsdo22CIsCdyvwuG14fpAUpDCiG3HsGfMaV2oNWqjKgzp2pmbVx3k/Qsh22pKyCs/8QbnkYlElDpNW4oc70Jw275yIghO2FLE9+gyhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781304067; c=relaxed/simple;
	bh=46W95IgemO7Y5zIe5mVEMrQKgbwvlEj29Gh/B1szmBo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZIM3wxOYSy9u/v5WwYZ37fYLi6tGMrrNocTyi4saVx1mqFTsP5pXfz4fu5LGxxSkH7XyTWC2abOLoOVrk2l4d30GtDv1dYyRkxX3IzU/qju6LdHqP3V3hdnN+M+gelRrh+g4Rsg7Q8U3wOqjUbo2SMAuJjj+2fX3iQojIi94y28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bStZccAl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bStZccAl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A57461F000E9;
	Fri, 12 Jun 2026 22:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781304065;
	bh=HSjokzk3Ib799Kq8ghix45WXz9/BSMbQrzLx92Zk9cA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bStZccAlAkYrIBGnbiHLInn7/Z7AYUZBUKWPvXgxokWnlDS0HO895HD5VGMRvXb1m
	 6S5oxzguYrLAGm0E+z+asxJZPIyujZ0KjxGeiWSKqp1udJOBLX0ToLArUG7UTrrBHq
	 wslO9E4rLPrEQLTlE2pS82OoJaXbi1Ri50xDntT1zA6oLyU5hEH1SbI5EvyoZkun2+
	 BHENf3VeMMMWq5FB7vCs5i5QDuTBXtnLga1ajda6X05p+tSSG/3Wt11hvUXwgupkMh
	 YfHNpFDDkD75vdRP8bGlxwfd54BStYAUZlNYy5t3zpIyxBNpb/g5fqxHgXCcriiJkj
	 FcotI+nI+AO7A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 18/19] perf python: Add perf.pyi stubs file
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260612221211.1221305-19-irogers@google.com>
References: <20260612221211.1221305-19-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 22:41:04 +0000
Message-Id: <20260612224105.A57461F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Type stubs incorrectly document `None` as a valid argument, lead=
ing to memory corruption and segfaults in the C extension.
--

commit 9f279812734ffe49e65776760974bed198e67c6d
Author: Ian Rogers <irogers@google.com>

perf python: Add perf.pyi stubs file

This commit adds Python type stubs for the perf module to improve IDE suppo=
rt
and static analysis. It includes docstrings for classes, methods, and
constants derived from C source and JSON definitions.

> diff --git a/tools/perf/python/perf.pyi b/tools/perf/python/perf.pyi
> new file mode 100644
> index 0000000000000..f789cbfa1e410
> --- /dev/null
> +++ b/tools/perf/python/perf.pyi

[ ... ]

> +def parse_events(
> +    event_string: str,
> +    cpus: Optional[cpu_map] =3D None,
> +    threads: Optional[Any] =3D None
> +) -> 'evlist':

[Severity: Medium]
Is it safe to document cpus and threads as Optional with a default of None?

If a user follows this stub and explicitly passes None to the C extension,
pyrf__parse_events() parses it into PyObject pointers via PyArg_ParseTuple(=
).
Because Py_None is not a NULL pointer, the C code will treat it as a valid
struct pyrf_thread_map and try to dereference it, reading garbage memory:

tools/perf/util/python.c:pyrf__parse_events() {
    ...
    if (!PyArg_ParseTupleAndKeywords(args, kwargs, "s|OO", kwlist,
                                     &events, &pcpus, &pthreads))
    ...
    threads =3D pthreads ? ((struct pyrf_thread_map *)pthreads)->threads : =
NULL;
    ...
}

Should the C extension be updated to handle Py_None, or should the stubs
avoid suggesting None is a valid argument?

[ ... ]

> +def parse_metrics(
> +    metrics_string: str,
> +    pmu: Optional[str] =3D None,
> +    cpus: Optional[cpu_map] =3D None,
> +    threads: Optional[Any] =3D None
> +) -> 'evlist':

[Severity: Medium]
Does this also have the same issue where passing None for cpus or threads
will cause pyrf__parse_metrics() to dereference Py_None as a struct pointer?

Additionally, passing None for pmu might cause a TypeError if the C code
expects a string format.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612221211.1221=
305-1-irogers@google.com?part=3D18
