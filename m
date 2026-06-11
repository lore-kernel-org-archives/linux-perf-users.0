Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2290E3BD63C
	for <linux-perf-users@vger.kernel.org>; Thu, 11 Jun 2026 17:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781199358; cv=none; b=S9x8naFcv1oTGToGRgdenQGmMEmSnOovBWZVkfwlMhQkccGwY4FJkMIG0Qxd80eUWqRIAadjIrnuoKTc62YyT2YBtJoQBloP0+vvl4fc7J35wQvrHci9NROWYvtfcPfSUaYs6kdeLbsms7xlX2b4vmD5kUCHOzFzvoGFYEhShSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781199358; c=relaxed/simple;
	bh=MVKssIs3vmnzmRuU9CHPL2F5WVWAST1B8WALadeLBZo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FrOKs9nQJ2fs2tc9/aVqWWPqXiHazuQq19UImq+cY7X9DEGelGvMhpB74/xaRouEQrvW5YYngWRVMPSyHd28G9CSx0OZ2h60mQv8eQAHSuDhOTBkNNZZvLeTndB1JEG8e8m0Gaqa0rMzE5H2WhFsGRqdkMQP+mOb3/hZR+qfBJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Um7lxfNB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Um7lxfNB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D76331F00893;
	Thu, 11 Jun 2026 17:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781199357;
	bh=OBlaPvGzKi92S4uoTV9Wiw4GpsGfi/jKRXZOWBdX9Fs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Um7lxfNBfAYYMowydnmAhQYSKlmOH0P1ZRxyBQP0U18iB2Z2MXaQJO7IAHgeP/uWy
	 AjpCEeGQ0XitXjs2L9B2YsiPSAg1yAPTMAj13f/tu+n/O2mXiP08fruBnaQUOK+n26
	 ICxvAiBMINdeqjGEisieZJc8YJeYPqnG1P/FIn6ciqt4+eT7GIWHus6dFpCWDv76vF
	 g85eO0+jOWTWilwt68kq7LA7Y1XG+GOIDKnELbXMXZazJLcOQHkrA7ZKvr0JsfhGsI
	 vjD+5ucU3e+3iI+x9aPMAA08Qw3O6PfPd0qxfi50iNW6mLKXqGVOy4sRUtompmqNru
	 ax8ng04gDhCeQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 09/19] perf python: Add wrapper for perf_data file
 abstraction
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260611171756.4008769-10-irogers@google.com>
References: <20260611171756.4008769-10-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 17:35:56 +0000
Message-Id: <20260611173556.D76331F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Re-initializing an existing `perf.data` object does not fully cl=
ear the underlying `struct perf_data`, leaving stale state that causes logi=
cal inconsistencies.
--

commit 8f869060a5b25832b79160df4d9d6a99f7be3b9c
Author: Ian Rogers <irogers@google.com>

perf python: Add wrapper for perf_data file abstraction
   =20
The perf_data struct is needed for session supported.

> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index 669b65ce3f3da..c86b9713c076f 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
[ ... ]
> @@ -2455,6 +2457,121 @@ static PyObject *pyrf__metrics(PyObject *self, Py=
Object *args)
>  	return list;
>  }
> =20
> +struct pyrf_data {
> +	PyObject_HEAD
> +
> +	struct perf_data data;
> +};
> +
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
> +	pdata->data.path =3D NULL;

[Severity: Medium]
When __init__ is called multiple times on the same object, is it possible
for this re-initialization to leave stale fields in the underlying
struct perf_data?

If the object was previously initialized as a directory, data.is_dir remains
true and data.dir.version remains set. If it is then re-initialized as a
pipe (fd !=3D -1), perf_data__open() returns early from check_pipe() without
updating is_dir.

This leaves the object in an inconsistent state where both is_dir and
is_pipe are true, causing failures later in perf_session__new(). Would it
be safer to completely clear pdata->data here?

> +
> +	if (fd !=3D -1) {
> +		struct stat st;
> +
> +		if (fstat(fd, &st) < 0 || !S_ISFIFO(st.st_mode)) {
> +			PyErr_SetString(PyExc_ValueError,
> +					"fd argument is only supported for pipes");
> +			return -1;
> +		}
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611171756.4008=
769-1-irogers@google.com?part=3D9
