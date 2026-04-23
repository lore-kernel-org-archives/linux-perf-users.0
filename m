Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A8135F61E
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 04:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776918311; cv=none; b=Z+Wf19FTyrmY8929Ko49zk3IWZMQCcbfUn+mdbUGCUsmsjVCkBXpB8ezy1WV24qwSALHp0BmNxnyTKarIjGKmUyTidIBNibXIMyLto34105LixrmxXcGzLY5S8Fm03qruwfCJT9K3nsAfxVaV2c5j5l3UqGqDyMB32H51M+fDXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776918311; c=relaxed/simple;
	bh=5eM9aDZfBiaDmcL1toSVfNI2cbNbsTm1yx0Sbvy6+rU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VanBhmJ8UHgBA6pmMGKC/2SEDCcWiVidoMbejUHYjcT07RApbGOEZ5rYDY6xzEVckokeQIpdQGxNh7akVJ1ONJfoK6LMzWCIAU8o35euxS0lvLjqXdVmgk0mMZyQ9tQLLDL/fhSmWQcI5x1Gs+xPh7nDA3QXNE47SIBd0vVzQpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MDcxCqPG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MDcxCqPG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51FC8C2BCB2;
	Thu, 23 Apr 2026 04:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776918311;
	bh=5eM9aDZfBiaDmcL1toSVfNI2cbNbsTm1yx0Sbvy6+rU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=MDcxCqPG93ZIcdTrFMxNELg3kGWpEFucIHPrglq9zjKl1j48PZiL2GaI265dYrccP
	 nAkJDT4Llu+5OKxjb30wJuEM327Pw3yh5cfyT02Kpa84YgsGOsyUQez2nlw2crIDzO
	 09EonDdUW/td/zQAFud48pDwIHsxKM5kXhtYFEuo0UQudmsgO0onmW+bzK3ZcDSrvN
	 nhN9WYQvB1w0vZNHA9AEnLSNH/0zytcoXwxCTd2gaGNEiWcnaiGU2u7GNZJxcqTj1+
	 f7XVCCTmfGOrkuk1PkptPn6wm/rLTV/9ivAW4xaewywwLsrlPMT0zf06YFEpRyrSwc
	 94IQGUcfiw+7w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 14/58] perf python: Add wrapper for perf_data file
 abstraction
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260423035526.1537178-15-irogers@google.com>
References: <20260423035526.1537178-15-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Apr 2026 04:25:10 +0000
Message-Id: <20260423042511.51FC8C2BCB2@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 3 potential issue(s):
- [High] The `fd` argument is ignored and overwritten, leading to file desc=
riptor leaks and unintended file operations.
- [High] The `perf.data` object inadvertently closes standard input when `p=
ath=3D'-'` is used, corrupting the Python process's file descriptor table.
- [Medium] The wrapper's file opening logic executes blocking `open()` syst=
em calls without releasing the Python Global Interpreter Lock (GIL).
--

commit 55f9762e67ceebe9ab438d4e7a27fffc79b9eea7
Author: Ian Rogers <irogers@google.com>

perf python: Add wrapper for perf_data file abstraction

This commit introduces a Python wrapper for the perf_data file abstraction,
which is needed to provide session support.

> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index 0424290f8b77f..a2cdd92e05482 100644
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
> +	if (!path)
> +		path =3D "perf.data";
> +
> +	pdata->data.path =3D strdup(path);

[ ... ]

> +	pdata->data.mode =3D PERF_DATA_MODE_READ;
> +	pdata->data.file.fd =3D fd;
> +	if (perf_data__open(&pdata->data) < 0) {

Could this introduce a regression where the provided fd is leaked?=20

If fd is provided but path is not, path defaults to "perf.data" earlier in
this function. When perf_data__open() is called, it relies on check_pipe()
which only recognizes a pipe if the path is exactly "-".

Will this cause perf_data__open() to assume it is a regular file, open
"perf.data" from disk, and overwrite pdata->data.file.fd instead of using t=
he
one provided?

Additionally, is there a potential regression here regarding the Python GIL?
Since perf_data__open() can perform a blocking open() on the provided path,
could this block indefinitely without releasing the Python Global Interpret=
er
Lock if the path points to a FIFO or special device?

> +		PyErr_Format(PyExc_IOError, "Failed to open perf data: %s",
> +			     pdata->data.path ? pdata->data.path : "perf.data");
> +		return -1;
> +	}
> +	return 0;
> +}
> +
> +static void pyrf_data__delete(struct pyrf_data *pdata)
> +{
> +	perf_data__close(&pdata->data);

Does this cleanup path introduce a regression when handling standard input?

If path was set to "-", perf_data__open() sets the fd to STDIN_FILENO. When
the python object is garbage collected, does perf_data__close()
unconditionally close STDIN_FILENO and disrupt the Python process's file
descriptor table?

> +	free((char *)pdata->data.path);
> +	Py_TYPE(pdata)->tp_free((PyObject *)pdata);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260423035526.1537=
178-1-irogers@google.com?part=3D14
