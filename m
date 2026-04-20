Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6636192590
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Apr 2026 00:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776645218; cv=none; b=laFCjHeo6ii+Ee4VWB3EQhKF8PNNwSZJ+Sd2eMPjcm/uv43tQQeXoi6ywSrpFIoqxplxjY9ltFwRq7A66VDfCeq2uElw36NyHhSsaFK9KVhRoOaxm1MStEX42TFY6clp0HIXO1dSsmeutLVzk4niqRQyptweid+trKQFAOBfW00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776645218; c=relaxed/simple;
	bh=dCJ/hb/chwW1CtfilcuaUuR/gW2EdWBmwv54YLVo35w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JwIUnddUb14ue5Mv0gFcWJooFh6uMnkpuRc7wYfrI9eYg5whD6vt3MG9YsMIbZoTyoK0RL6+z3cNQDtJx4kGPlIIwzqwvc4mtUha/VXoXwAT9IyIZp4Crt0llSXCSihXSRZwfaXe/vcXnik/PpaHwBjfw0lwkp1pU2s4L8Rrfww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pN8ceicJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pN8ceicJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62A80C2BCAF;
	Mon, 20 Apr 2026 00:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776645218;
	bh=dCJ/hb/chwW1CtfilcuaUuR/gW2EdWBmwv54YLVo35w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=pN8ceicJb1QBpInIgupPbKR5J8ja8Knm83iF1Q9NIBc7iSeSjZInQr938UVLmNWsE
	 SlDbcaw32iOSHhfUpe2TDrD5BulwPdZXMgnWzVvArYXTxzJcjse6OLB2Y3hoySMCFf
	 +2DU2Y2eJTW44eJkPAzpPT5VFGQUYg1CP+HGdJ58BQ/7oZ8pw3o/xx0rC8h3y699kl
	 EaO0KQ5w7pQtHrsyacCkET+Ram5EBMbIMSoyi2skJZtlLn9E2EK3cUipd6oTu5m0Ig
	 /mmRzjkGDALdKpwoK5h8PfFayixmJIDkaL0IqOyh25S9JY6R5KvC4EqeX1/LmzEI47
	 3mULZh91fCRxw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 14/58] perf python: Add wrapper for perf_data file
 abstraction
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260419235911.2186050-15-irogers@google.com>
References: <20260419235911.2186050-15-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Apr 2026 00:33:37 +0000
Message-Id: <20260420003338.62A80C2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 4 potential issue(s):
- [Medium] Instantiating `perf.data()` without a `path` argument causes the=
 object destructor to attempt to `free()` a static string literal, leading =
to an immediate crash.
- [Medium] `pyrf_data__str` passes a potentially NULL pointer to `PyUnicode=
_FromString`, causing a segmentation fault.
- [Medium] The user-provided `fd` argument is silently ignored for regular =
files, violating the API contract.
- [Medium] Calling `__init__` multiple times on a `perf.data` object causes=
 a memory leak and file descriptor leak.
--

commit 65326314096a5ff6264926bf6b420f76e3c6432e
Author: Ian Rogers <irogers@google.com>

perf python: Add wrapper for perf_data file abstraction

The perf_data struct is needed for session supported.

> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index 46fe173c6b5cb..f0dff69f67df2 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c

[ ... ]

> @@ -2279,6 +2280,73 @@ static PyObject *pyrf__metrics(PyObject *self, PyO=
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
> +	pdata->data.path =3D NULL;
> +	if (path) {
> +		pdata->data.path =3D strdup(path);

What happens if the python script calls __init__ multiple times on the same
object?

If pyrf_data__init() is called a second time, it unconditionally assigns
pdata->data.path =3D strdup(path) without freeing the previously allocated
string. It also overwrites the previously stored file descriptor.

Since data->open might already be true, perf_data__open() will return early,
and perf_data__close() will only close the newly overwritten file descriptor
when the object is destroyed.

Will this leak both the previously allocated string memory and the original
file descriptor?

> +		if (!pdata->data.path) {
> +			PyErr_NoMemory();
> +			return -1;
> +		}
> +	}
> +	pdata->data.mode =3D PERF_DATA_MODE_READ;
> +	pdata->data.file.fd =3D fd;
> +	if (perf_data__open(&pdata->data) < 0) {

Is the user-provided fd argument ignored for regular files?

Looking at the underlying C API, perf_data__open() delegates to open_file(),
which invokes open() on the file path and unconditionally overwrites
data->file.fd with the newly generated file descriptor.

Could this cause unexpected behavior and potential file descriptor leaks if=
 a
user passes an open file descriptor from Python?

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
> +	free((char *)pdata->data.path);

If path is omitted during initialization, pdata->data.path remains NULL.
Inside perf_data__open(), it checks if (!data->path) and assigns it the
static string literal "perf.data".

When the Python object is later garbage collected, this destructor is calle=
d:

pyrf_data__delete()
   ...
   free((char *)pdata->data.path);

Can this crash the interpreter by attempting to free a static string literal
from the .rodata section?

> +	Py_TYPE(pdata)->tp_free((PyObject *)pdata);
> +}
> +
> +static PyObject *pyrf_data__str(PyObject *self)
> +{
> +	const struct pyrf_data *pdata =3D (const struct pyrf_data *)self;
> +
> +	return PyUnicode_FromString(pdata->data.path);

Is it possible for pdata->data.path to be NULL here?

PyUnicode_FromString() expects a valid null-terminated string and will
segfault if passed a NULL pointer.

This pointer could remain NULL if the Python script instantiates the class
using perf.data.__new__(perf.data) without calling __init__(), or if
__init__() is called without a path but STDIN_FILENO is a pipe (causing
perf_data__open() to return early via check_pipe() before assigning the
default string).

Will calling str() or repr() on such an object cause a segmentation fault?

> +}
> +
> +static const char pyrf_data__doc[] =3D PyDoc_STR("perf data file object.=
");

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260419235911.2186=
050-1-irogers@google.com?part=3D14
