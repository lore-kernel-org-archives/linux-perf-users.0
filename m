Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992D93911C6
	for <linux-perf-users@vger.kernel.org>; Fri, 22 May 2026 22:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779489449; cv=none; b=RvfWuFyG6cil+Svi0dZJd4SgvxaAQ903zrt26oiYcJlPzq6T84Z9cB5Xgt0V7JgPqo4L+CRnmV1TeyjcRoQs6lN3O9MDrOWZ6oObbE4OKZi5aeCQwdTNt5zdFk1qH30EYJfLg2OkrYa9Kae7OypyDs/Db8IDzfOnDOaUP+qUwr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779489449; c=relaxed/simple;
	bh=hzsjq9Dd4fWJT9hdw8+Be/nZoD/x/po7APau96k4Xvg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=b6xcsUgjw05ewQiq7WQ6cOdvO3WbXfQpRq5gR7X8RR+ibbxt4YwfP/78BJ1PNUvTF/2lCeM9EUsLYQXJhTuj/ajEVNZrviPUpZWmp8o9bNELWL8ebLj7ibMmT+dyIyGtimTpfC1PKKwppFe84UnzglxzhH1xRhiZ8/rvw3nbVzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZA7MEjug; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZA7MEjug"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 916441F000E9;
	Fri, 22 May 2026 22:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779489445;
	bh=xppgzfjCL2L+Y41U5+a86xncl9ppqhyBoLZ5Vp5aLVg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZA7MEjugFSBxrKnglUaj+zsk1xXHJ8xZalhohHqoKRsIJhG0Bh7db8V0eJXCYUXDZ
	 ycGXPN3+X1Rw06geR+Ftzh4n9tfAGUXSrd2NTBYTipzp2KcbSLh8rjqw5/JTyW5rgA
	 JE91/EhKAxO611xo9BhPA0xmdop/1ECDk/7gSgeLbVkmVYhKFt7b5cpOx7l5+pfUYd
	 2R+SDcRlCip14OglXvEn2nJQhMq2r6CsdcBpcw4DUy6ZMgBkxXyltcZiW8hDR6lEMe
	 I1t6qfPlvBOhpqg3W+AQwPDRLXvxOxZNvLFJn7D670xGOWamdenD5COsCeDQIrgTsg
	 KuEApdDMr8rmw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 13/23] perf python: Add wrapper for perf_data file
 abstraction
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260522220435.2378363-14-irogers@google.com>
References: <20260522220435.2378363-14-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 22 May 2026 22:37:24 +0000
Message-Id: <20260522223725.916441F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] User-provided file descriptor is silently ignored, overwritten, an=
d leaked unless `path` is explicitly set to `"-"`.
- [High] Python wrapper inadvertently closes standard streams or user-manag=
ed file descriptors upon garbage collection.
--

commit 0c13b6fbaf09ddda5964c9a789eb34aaeae8f382
Author: Ian Rogers <irogers@google.com>

perf python: Add wrapper for perf_data file abstraction

This commit adds a python wrapper for the perf_data file abstraction
required to support session handling.

> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index e14e857cf90b0..82adc59ecd940 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c

[ ... ]

> @@ -2320,6 +2321,102 @@ static PyObject *pyrf__metrics(PyObject *self, Py=
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
> +
> +	if (!path)
> +		path =3D "perf.data";
> +
> +	pdata->data.path =3D strdup(path);
> +	if (!pdata->data.path) {
> +		PyErr_NoMemory();
> +		return -1;
> +	}
> +
> +	if (fd !=3D -1) {
> +		struct stat st;
> +
> +		if (fstat(fd, &st) < 0 || !S_ISFIFO(st.st_mode)) {
> +			PyErr_SetString(PyExc_ValueError,
> +					"fd argument is only supported for pipes");
> +			free((char *)pdata->data.path);
> +			pdata->data.path =3D NULL;
> +			return -1;
> +		}
> +	}
> +
> +	pdata->data.mode =3D PERF_DATA_MODE_READ;
> +	pdata->data.file.fd =3D fd;
> +	if (perf_data__open(&pdata->data) < 0) {

[Severity: High]
Does this code silently ignore the user-provided fd unless the path is
explicitly set to "-"?

If fd is provided but path is not, path defaults to "perf.data".  When
perf_data__open() is called, it checks if it's a pipe using check_pipe(),
which only recognizes a pipe if data->path is "-".

Because it does not recognize the pipe, it will open the local "perf.data"
file instead and unconditionally overwrite data->file.fd, dropping the
provided fd.

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

[Severity: High]
Does this inadvertently close standard streams or user-managed file
descriptors when the Python object is garbage collected?

Since perf_data__close() unconditionally closes data->file.fd, if the user
initialized the object to read from standard input (e.g. path=3D"-"), this
will call close(0), abruptly closing standard input for the entire Python
host process.  There doesn't appear to be a way to prevent this behavior.

> +	free((char *)pdata->data.path);
> +	Py_TYPE(pdata)->tp_free((PyObject *)pdata);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260522220435.2378=
363-1-irogers@google.com?part=3D13
