Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482F339185E
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 23:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777159364; cv=none; b=T2IIwyGLvhHYbE1gA55LJuuoZqEi/Tdb2sT+QK8/cIzwFGlHp/kW+ubdzQTOZ1ZdGZug6wR+Ik+gk55kR1duyfAEwcSnRFNjpznv5MOaKuEpP5jmb+tt/3dXw0P7n9nNbFF7UyxMHm7QenoX79Ip/ULUcGp2E4SZGCvir7JKvw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777159364; c=relaxed/simple;
	bh=82Lq3GBt6VAh823+0J0inqkExiNjnS6roQBe5hQJMko=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gVPfKJY3676ySuLUok8v7+XtpzjaZFUonxYr+7l20V9n9xL8tj1obBOWWjGnUexbcdH0KtqQ0n0iIWLzSu1ioeaKW7j4gVo0+1pG+oL64+EGesY+WmmDs0KNRXML6TnhtfZR0SAVbmUw3uNnwI6XiN9q1ntlbYXo+WlJCEjbltQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a3mIhg24; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a3mIhg24"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF59CC2BCB0;
	Sat, 25 Apr 2026 23:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777159363;
	bh=82Lq3GBt6VAh823+0J0inqkExiNjnS6roQBe5hQJMko=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=a3mIhg24dnnMrD+IXzGr+D8VkL9vwQzAQxzx8ZfF4fAMLrBaSrlsgOtKl4puEc8ci
	 K8Y7a9O/uCZzQD5DBZCWMJfxihEQSuY+9WAR3nI4q8VJt2hKmJdRbbnutE0cby93Lf
	 8oE7lgfTomBJF7/+3gmnOPDTYY+lzMUPJkLc75WTVbu2bAr0cTL639btb0IsCbxpc3
	 onibsGWPRrKw6ryBzht/sMSp85JN6ncUoQmsIkeVAjmjzpFXK0dUJfgyZBGZyj4piF
	 QzplL1AobukVgYtB/ky/tfhKiTgoUdhSao0M6OAr7I5FTxq6w9MvADx06Pl7pNnWix
	 UngBuV94ce2Rw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 14/59] perf python: Add wrapper for perf_data file
 abstraction
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260425224951.174663-15-irogers@google.com>
References: <20260425224951.174663-15-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Apr 2026 23:22:43 +0000
Message-Id: <20260425232243.BF59CC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [High] The `fd` argument in `perf.data()` is silently ignored and overwri=
tten, breaking pipe functionality and causing the wrapper to read from the =
wrong source.
--

commit ae4873a7e62ee38caf1c5c6d10e64f1a258b1d62
Author: Ian Rogers <irogers@google.com>

perf python: Add wrapper for perf_data file abstraction
   =20
The perf_data struct is needed for session supported.

> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index 2ba3556c4f16..aa63c7ffe822 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
[ ... ]
> @@ -2316,6 +2317,102 @@ static PyObject *pyrf__metrics(PyObject *self, Py=
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

Does this silently ignore the passed fd and leak it?

Looking at perf_data__open(), it delegates to check_pipe(). If path is
not explicitly provided, it defaults to "perf.data" instead of being NULL
or "-". check_pipe() requires path to be "-" to handle pipes:

tools/perf/util/data.c:check_pipe() {
    ...
	if (!data->path) {
		if (!fstat(fd, &st) && S_ISFIFO(st.st_mode))
			is_pipe =3D true;
	} else {
		if (!strcmp(data->path, "-"))
			is_pipe =3D true;
	}
    ...
}

Since path defaults to "perf.data", check_pipe() returns false.

perf_data__open() will then call open_file(), which does a regular
filesystem open() of "perf.data", and overwrites data->file.fd:

tools/perf/util/data.c:open_file() {
    ...
	fd =3D perf_data__is_read(data) ?
	     open_file_read(data) : open_file_write(data);
    ...
	data->file.fd =3D fd;
    ...
}

Should the wrapper set path to "-" or NULL if a custom pipe fd is
provided so perf_data__open() correctly uses it?

> +		PyErr_Format(PyExc_IOError, "Failed to open perf data: %s",
> +			     pdata->data.path ? pdata->data.path : "perf.data");
> +		return -1;
> +	}
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260425224951.1746=
63-1-irogers@google.com?part=3D14
