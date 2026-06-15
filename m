Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE82A3B9D9A
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 22:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781563912; cv=none; b=ZpHncYkCwTbgDdFVJabG4To9gNQb4YYtHCZeJcObJ6JUymRUHcXzK78T+qB3GFG1xfTnlJp7UxDyWdzB8roGds9jiNXW3DUPtQLpJZud6YwvTdPINn0veSRBDG/im39Ryciaz1ozPcGt5dVyxdk2WwkmRRnzKZYqRAZMR+bBzj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781563912; c=relaxed/simple;
	bh=cy8jI4I5RW2REWU8Dl0tCyDiahN+zwvWtswfONq3uiA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nQ8YGxcts/OIRKquJJvDlTyu1RiNfDkLvFgj7PmfNrr0lkMwwrJEXPYO4o1DGkWut4rFDTOaZYpXLhO3cPgj8F13b5s05NTyNN7uyyzxmFYpQJ3vDc77K016lNsZpSkz8JWty/Vv86ZoDiAS5xYOAlrRR8nh42pQ+YCdGtMSuLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F2Ae/f/+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F2Ae/f/+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADA491F000E9;
	Mon, 15 Jun 2026 22:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781563910;
	bh=Cf/BeqBBc0S5S7yvlj2GDrMFRE60Vr9vDomw+Xo5vjA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=F2Ae/f/+y1r4ewiNssKMtlxMsUxFR0W7UAU1Sbu5hUOvK19wggS+fsV/Y6Bwq128T
	 jc/imM59BuXlZzBnlJk4GBfQ5lBMgfJD9+Yf0LyvjNvVRhIXvr5rQ6sUmuP0ar/aDt
	 z4r5dIeNtP+Uv0dfDL7fYrQuHcaTkY1n7WwzvE+NYyw15ErqhXj6woq99Q/1YQQTiO
	 4V4OnMvrsnubi40rUqDyWGMuEMv5kALIeDecvgFPGFYm2/tNCAe/dH9+rpq7qLSVF1
	 PD2qVFOSJBLMT4r/uYEQ397RMFY8Fui+SppRTuaRKVY3T3MzfCHZmQ0LQQQRS8yK0y
	 L5zrvOklV0YOQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v20 18/21] perf python: Handle Py_None for thread and
 cpu maps
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260615223011.3873955-19-irogers@google.com>
References: <20260615223011.3873955-19-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 22:51:50 +0000
Message-Id: <20260615225150.ADA491F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing `PyObject_TypeCheck` validation in `pyrf_evsel__open` allo=
ws arbitrary Python objects to be unsafely cast to internal C structs, lead=
ing to type confusion and memory corruption.
--

commit d7732c71209049d1fdcc532224b91ad794512101
Author: Ian Rogers <irogers@google.com>

perf python: Handle Py_None for thread and cpu maps

This commit fixes memory corruption crashes by explicitly checking for Py_N=
one
before casting python objects to internal thread and cpu map structures.
Previously, parsing None into Py_None bypassed NULL checks and resulted in
invalid pointer dereferences.

> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
> @@ -2091,10 +2091,10 @@ static PyObject *pyrf_evsel__open(struct pyrf_evs=
el *pevsel,
>  					 &pcpus, &pthreads, &group, &inherit))
>  		return NULL;
> =20
> -	if (pthreads !=3D NULL)
> +	if (pthreads !=3D NULL && pthreads !=3D Py_None)
>  		threads =3D ((struct pyrf_thread_map *)pthreads)->threads;
> =20
> -	if (pcpus !=3D NULL)
> +	if (pcpus !=3D NULL && pcpus !=3D Py_None)
>  		cpus =3D ((struct pyrf_cpu_map *)pcpus)->cpus;

[Severity: High]
This is a pre-existing issue, but missing PyObject_TypeCheck validation here
allows arbitrary Python objects to be unsafely cast to internal C structs.

Since pcpus and pthreads are parsed as generic objects in pyrf_evsel__open(=
),
what happens if a user passes an incompatible type like an integer or a str=
ing
instead of Py_None?

It looks like the extension will blindly cast the generic PyObject to a
struct pyrf_cpu_map or struct pyrf_thread_map and dereference it to read
the cpus or threads field.=20

Could this lead to type confusion and memory corruption if we try to access
arbitrary memory offsets on the wrong python object type?

I noticed that pyrf__parse_events() and pyrf__parse_metrics() both use
PyObject_TypeCheck() to validate the types before casting. Would it make
sense to add those same type checks here in pyrf_evsel__open()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615223011.3873=
955-1-irogers@google.com?part=3D18
