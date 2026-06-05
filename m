Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0834C426ECD
	for <linux-perf-users@vger.kernel.org>; Fri,  5 Jun 2026 07:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780645998; cv=none; b=mupTYxcGcG2wKK8JJnq3eQfUWjo+63ruf535zyc61p0Dzr4S2Zv81aNzNXcOk9ugLGiitPM6lV+MhGcH7FzACzBcvnzOv5/WNuePV58R4z8x5CgjA7XQl01GUvLNINZPfAZbZTVnPflYXDOrR29iOG/SwCY0SN8HUVt3i5XBwvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780645998; c=relaxed/simple;
	bh=6GadkvQLYDcSSpPODs4qj9/P+kYLJwEZoJGqEs7J080=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MaJVjFjykuNu1qx4X9FPQeJ9qNi9unGj1EiljLIjTeA3AN6oDeY0rkC+mjrEJxwbSqcmVA/GmLqc0vZsYQPoWo5TL/Zx/RTcjhwK7AzgeEctOaH+i6KsHpZcVUOZC7/ctoVfpZom3dY5eUzRHb1WGcd64kmeyDPHhod9A6IRLnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YbZmnOA/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YbZmnOA/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 857121F00893;
	Fri,  5 Jun 2026 07:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780645996;
	bh=o8ICzvU/mAreukPurcvZmcfDqySm1x58EW+t3CC8oFM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YbZmnOA/6bQJccrXGBZxYK+45AS5+SDPRfg7+wRk2m95bhDenUBytAM+XskMkVj7N
	 ZDbKfG1ilQ9uW8Tosu0zu5xkSwahnxMURjTdcG1FGh7FuVoNsYaIrXnSzmNQYeKlZc
	 zazAzR2Mqwat/oO8RtLbxQ6UU4NtzP2siNQ7r36FI6z4lZzmhwCjCLyeoRYAQKynjZ
	 t3kOePcpMd30hyyNu4LtL2qXgFZpkZbQvrD0R64aEDPoGs8tzVgqCaGTOnvwiY1Gst
	 ZQxNZndCqv+FyhDXxTPqZW17Ba5MZOCvBvsKissL70OeLhjOL/Jn03twmnjOr2ZbGB
	 Iul2WfO1M/jMg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 09/19] perf python: Add wrapper for perf_data file
 abstraction
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260605074003.1730715-10-irogers@google.com>
References: <20260605074003.1730715-10-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 07:53:16 +0000
Message-Id: <20260605075316.857121F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Missing pointer nullification after freeing `pdata->data.path` i=
n `pyrf_data__init` causes a Use-After-Free and Double Free vulnerability i=
f re-initialization fails.
--

commit 3bd4b2111f650c3ffdc0443e905e19b99cc0ce92
Author: Ian Rogers <irogers@google.com>

perf python: Add wrapper for perf_data file abstraction

This commit introduces a perf_data wrapper for the perf python extension,=20
providing session support to interact with perf.data files.

> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c

[ ... ]

> +static int pyrf_data__init(struct pyrf_data *pdata, PyObject *args, PyOb=
ject *kwargs)
> +{
> +	static char *kwlist[] =3D { "path", "fd", NULL };
> +	char *path =3D NULL;
> +	int fd =3D -1;
> +
> +	if (!PyArg_ParseTupleAndKeywords(args, kwargs, "|si", kwlist, &path, &f=
d))
> +		return -1;
> +
> +	if (pdata->data.open)
> +		perf_data__close(&pdata->data);
> +	free((char *)pdata->data.path);
> +
> +	if (fd !=3D -1) {
> +		struct stat st;
> +
> +		if (fstat(fd, &st) < 0 || !S_ISFIFO(st.st_mode)) {
> +			PyErr_SetString(PyExc_ValueError,
> +					"fd argument is only supported for pipes");
> +			return -1;

[Severity: Medium]
If this object is re-initialized by calling __init__ again, pdata->data.path
is freed above. If we hit this error path (or others below it) and return -=
1,
pdata->data.path is left as a dangling pointer.

Since the Python object remains alive even if __init__ fails on
re-initialization, could a later call to pyrf_data__str() dereference this
freed pointer?

Additionally, would the eventual garbage collection in pyrf_data__delete()
cause a double-free?

Setting pdata->data.path =3D NULL immediately after the free() might prevent
these issues.

[ ... ]

> +static void pyrf_data__delete(struct pyrf_data *pdata)
> +{
> +	perf_data__close(&pdata->data);
> +	free((char *)pdata->data.path);

[Severity: Medium]
This is where the dangling pointer from the failed re-initialization would =
be
freed a second time.

[ ... ]

> +static PyObject *pyrf_data__str(PyObject *self)
> +{
> +	const struct pyrf_data *pdata =3D (const struct pyrf_data *)self;
> +
> +	if (!pdata->data.path)
> +		return PyUnicode_FromString("[uninitialized]");
> +	return PyUnicode_FromString(pdata->data.path);

[Severity: Medium]
And this is where the use-after-free would occur during string conversion if
pdata->data.path wasn't cleared after being freed.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605074003.1730=
715-1-irogers@google.com?part=3D9
