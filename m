Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00F5194C96
	for <linux-perf-users@vger.kernel.org>; Fri, 24 Apr 2026 17:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777052103; cv=none; b=S7QzAqJTGA/WNBHF7/UxG6z2XZHHPslqL+iohmMRHB5UbmjxOXLLrUjDfjhtaaP/GArRzNMnhcGglwq4qFdTKlJNEHe655nFXinPzVVFqvdeyr0Le6L56pEQxUCIxl1yyyxbp8G/AkkGYR3/HgtUf/b/tcHHrwtTFTqf2swLmNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777052103; c=relaxed/simple;
	bh=MdQx4IZA/+21LaUGkmTGE5X/PGaiIx9cN7JsvTYlJ7E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=X8Q+6QATuyahWJJDPWYL0xg5oHZgcd/zxIeMKF4177tzDl1L2yzlVueADY9NRHs3fq1JX4NjE39hdRRVMM3nFcuGJs88prepCelql/xh6NkZzFS3CQAJy+kFW1p3yZT+9BZMJ98PH2ET/r9c/vfKkd/oGc6cJ886yRYBs+QoVX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VsiO+fey; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VsiO+fey"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F16CCC19425;
	Fri, 24 Apr 2026 17:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777052102;
	bh=MdQx4IZA/+21LaUGkmTGE5X/PGaiIx9cN7JsvTYlJ7E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=VsiO+feyJTGMb52YToVb8vTnp3oUJ2puGbyYJLfWQivWulel+4MFP6FBF3McrCwh/
	 rAnOttRkd1Ao+AFJvPsM3leYAsWe2NQwC3WOLfQ5e4p7XzLqz78fIzhMs3sDY8QSnn
	 8oyDo8i555av1ulpjMEHhhgoSUiwDCvAGwwZp96ZTx5nAxy0MyDegUKxjTQtYyCENb
	 4iIbA1k4VWvtTqSsBb7k1rY5RhDwQycXkPp8hp37B+JNbkcHCQoFSafuQN6Pqvbcuo
	 IhS5G+jNmYfenNU6kyUiSiFtiFomHIfXu/L8MOvpexUsBy97sQHoJuNFMk1emgIrVb
	 vEvr1NdUxCHMA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 14/58] perf python: Add wrapper for perf_data file
 abstraction
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260424164721.2229025-15-irogers@google.com>
References: <20260424164721.2229025-15-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Apr 2026 17:35:01 +0000
Message-Id: <20260424173501.F16CCC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Medium] The Python `perf.data` API silently ignores the user-provided `f=
d` argument and opens a local `perf.data` file instead.
--

commit 193dbfbd4a74d55472e2933cb533b9e73dc6d276
Author: Ian Rogers <irogers@google.com>

perf python: Add wrapper for perf_data file abstraction

This commit adds a Python wrapper for the perf_data file abstraction.
It allows users to open perf data files by path or file descriptor
to support sessions.

> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index 0424290f8b77f8..a2cdd92e05482b 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
[ ... ]
> @@ -2296,6 +2297,92 @@ static PyObject *pyrf__metrics(PyObject *self, PyO=
bject *args)
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

If an fd is provided but path is omitted, path defaults to "perf.data".
Does this cause perf_data__open() to ignore the provided fd?

Looking at perf_data__open(), it calls check_pipe() which evaluates
!strcmp(data->path, "-"). Since the path is "perf.data", check_pipe() retur=
ns
false, and perf_data__open() opens the local "perf.data" file instead,
overwriting the validated pipe fd unless the caller explicitly passed path=
=3D"-".

> +		PyErr_Format(PyExc_IOError, "Failed to open perf data: %s",
> +			     pdata->data.path ? pdata->data.path : "perf.data");
> +		return -1;
> +	}
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260424164721.2229=
025-1-irogers@google.com?part=3D14
