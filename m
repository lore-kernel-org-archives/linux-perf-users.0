Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB8B3002DD
	for <linux-perf-users@vger.kernel.org>; Wed, 24 Jun 2026 05:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782279597; cv=none; b=LILz2Eq8fzAW4A5dr+Kx66MiYPDdrDZ0r+gzp0mJCPhT7BAizik5JGPZWjUZC7Ri2Q3rXl5/jb+uSYC/fOHthhHmDhXeRwk7Rmh3TdmEBsR6CygzfCfXQdRwUaYHLTqRUvlKWDHKXjawPpwJWFSwCQh3D6sCCG0IfKhwDLbI9i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782279597; c=relaxed/simple;
	bh=/H7GpIrlQXMKAk0tjBjmF03L8jebEQYznD0OSfHEE2I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Gp1smx15xBNCfWQ1ohvtJmJU2SdiG/DDrPd+HdDqWbtnEesgy9KnCz1l4wLBjlcXbNuQQz3t0vjdW5shSu+w7ocSF+iLUdMsLTBxUjGw+cGP7LYNRRQFXZMR/2gbGObSDZ2x3/BCL0qqDNSHJ4/8LPHaAH00Sx139kiRXZv3Vck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XNJF8xPY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XNJF8xPY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21BB51F000E9;
	Wed, 24 Jun 2026 05:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782279596;
	bh=TnpqGeZYeKy0ZdBiFw/XsQXuY2+hvaoVhn6q3wTosHg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XNJF8xPYcmrxq8AMgdXJbxKNJh71PoZyC+xcr0PtsUrtPaf/POzJk8CC5flUB6PsJ
	 WDM6j+fKYxQPqvusWUu0r5Mx3SpiQZlCqo0E59SgUi8xe6tFdKZs6cw55vVygXZZlq
	 cGrY9NTMzPgUIexZfGH57o5DJeVRxLqSe7BOLiWjkWzRqdIH2eZXcZUr9Wsl6tFgB7
	 UJlqmGa8VfcWmXiFmtofTbpiJBa3puvXRyH6EODfrap4TVQeYiUK4wAcfT17BLn68H
	 mJ7CV3R+LSf6vl0OuR9WS8UEKHzFmb/i3LXE4yWICMrddLZdAWERLpOSXXnM9rJ3t0
	 M3Wk+D8DxzVZw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 14/16] perf python: Fix count_values memory leak in
 pyrf_evsel__read
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260624051535.3584977-16-irogers@google.com>
References: <20260623053515.2677888-1-irogers@google.com>
 <20260624051535.3584977-1-irogers@google.com>
 <20260624051535.3584977-16-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Jun 2026 05:39:55 +0000
Message-Id: <20260624053956.21BB51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] A partially failed allocation in `evsel__ensure_counts()` results =
in a NULL pointer dereference when retrying `pyrf_evsel__read()`.
- [High] The `evsel->prev_raw_counts` array allocated for Python `perf.evse=
l` objects is unconditionally leaked when the object is destroyed.
- [Medium] String duplication leak in `prepare_metric` on error paths.
--

commit 0bdfb7eb04b252f781d1daa5947d46bec1d9df82
Author: Ian Rogers <irogers@google.com>

perf python: Fix count_values memory leak in pyrf_evsel__read

In pyrf_evsel__read, if PyArg_ParseTuple fails, the allocated count_values
is leaked. Move the allocation of count_values after the PyArg_ParseTuple
call to prevent the memory leak.

> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index b17b191b16255..e76a407cb2bb9 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
> @@ -2204,11 +2204,6 @@ static PyObject *pyrf_evsel__read(struct pyrf_evse=
l *pevsel,
> =20
>  	CHECK_INITIALIZED(evsel, "evsel");
> =20
> -	count_values =3D PyObject_New(struct pyrf_counts_values,
> -							       &pyrf_counts_values__type);
> -	if (!count_values)
> -		return NULL;
> -
>  	if (!PyArg_ParseTuple(args, "ii", &cpu, &thread))
>  		return NULL;
> =20
> @@ -2227,6 +2222,10 @@ static PyObject *pyrf_evsel__read(struct pyrf_evse=
l *pevsel,
>  	if (evsel__ensure_counts(evsel))
>  		return PyErr_NoMemory();
> =20
> +	count_values =3D PyObject_New(struct pyrf_counts_values, &pyrf_counts_v=
alues__type);
> +	if (!count_values)
> +		return NULL;
> +
>  	/* Set up pointers to the old and newly read counter values. */
>  	old_count =3D perf_counts(evsel->prev_raw_counts, cpu_idx, thread_idx);

[Severity: High]
This isn't a bug introduced by this patch, but I noticed a potential NULL
pointer dereference here.

If evsel__ensure_counts() successfully allocates evsel->counts but fails to
allocate evsel->prev_raw_counts, it returns -ENOMEM. If a user script
handles the resulting Python MemoryError and retries the read operation,
evsel__ensure_counts() will see that evsel->counts is no longer NULL and
return success immediately, without allocating evsel->prev_raw_counts.

Will this cause perf_counts() to dereference a NULL prev_raw_counts pointer
on the retry?

[Severity: High]
This is also a pre-existing issue, but does evsel->prev_raw_counts leak
when the object is destroyed?

When a standalone Python evsel object is destroyed, its destruction path
goes through pyrf_evsel__delete() -> evsel__put() -> evsel__exit(). While
evsel__exit() properly calls evsel__free_counts() to free evsel->counts,
it seems to miss freeing evsel->prev_raw_counts.

Could this unconditionally drain memory if Python evsel objects are used in
a loop?

>  	new_count =3D perf_counts(evsel->counts, cpu_idx, thread_idx);

[ ... ]

[Severity: Medium]
This is another pre-existing issue not caused by this patch, but looking at
prepare_metric() in the same file, does this error path leak the duplicated
string n?

tools/perf/util/python.c:prepare_metric() {
    ...
    char *n =3D strdup(evsel__metric_id(cur));

    if (!n)
        return -ENOMEM;
    ...
    ret =3D evsel__ensure_counts(cur);
    if (ret)
        return ret;
    ...
    ret =3D expr__add_id_val_source_count(pctx, n, val, source_count);
    if (ret)
        return ret;
    ...
}

If evsel__ensure_counts() or expr__add_id_val_source_count() returns an
error, the function returns early without freeing n. Should we ensure n is
freed on these error paths?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260624051535.3584=
977-1-irogers@google.com?part=3D14
