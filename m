Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C658199D8
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Apr 2026 00:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776645358; cv=none; b=maB8+OOPBXGuUUEmkXpubMwGqblSAQFNklYqtE4/htumIMBSDgc1yCInqIOR7fNu1mZWYYtHmMeTW5Zi/KyN4NpF6bibH7IPuG9q11Sepe7p/oF4FKNeT9BQQe/Jk15eqs3AX+u0ANPpO4gj4uexTWSEohQ4Hd1BgaJ2pKQxRok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776645358; c=relaxed/simple;
	bh=oJyzmIEY6OmToDLOY1iKwm4TqK/96OEemLnROMH5o7Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=e/hW7GgaJeuSuTo5amjC5wuaTdOpaubruID/NwmJf/sSJekUxgzqg8EUAbKZZiBN3WrpTb4r1KUIoUTgaEsPWevaQiUAym7LTNrfjjEmgNLQqtKwKQAAS01tCg1odq3iguQVD2V+mecomwt/aibdegIwW/rwW4bg4MK4/sAr4Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ieSEV3/o; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ieSEV3/o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00349C2BCAF;
	Mon, 20 Apr 2026 00:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776645358;
	bh=oJyzmIEY6OmToDLOY1iKwm4TqK/96OEemLnROMH5o7Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=ieSEV3/oT7Xwqyv2d5EbmpvVSetSTfTSge6OPNv4cwY7e/uxxHwG1tWiCx6sWspAg
	 rCsEUtak3ZWPvFPzi0Y2YEc4Oiklj72FHy12SCRMUY4Hvf26dt1+AhkunfX0M4JXYi
	 SX/tEyIaVS3+aBH4uN9N9jEHhbv0jpkeXb3Qd7hpYkgSioG6Ot0sdOLYRcenGsX6eE
	 bglvEuCRNTlbhEJqrqfV0ZA+wO3C0h7ITePUKJcatgkpF4/pytJyQZlL/ep7uU9nbJ
	 DzyKybMxAJ7EECA6/kKT8Y48QTlPQ/bcM2an/5Xt5xzyhmtD+MmIL/f3PtOlceS/Io
	 cBOniyIeUeE8Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 16/58] perf python: Add syscall name/id to convert
 syscall number and name
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260419235911.2186050-17-irogers@google.com>
References: <20260419235911.2186050-17-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Apr 2026 00:35:57 +0000
Message-Id: <20260420003558.00349C2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 3 potential issue(s):
- [Low] Unconditional use of `syscalltbl__name` and `syscalltbl__id` breaks=
 the perf Python extension build when `CONFIG_TRACE` is disabled.
- [Low] `pyrf__syscall_id` incorrectly raises a `TypeError` instead of a `V=
alueError` when a syscall is not found.
- [Low] The docstring for the `syscall_id` Python method contains a confusi=
ng typo.
--

commit f77ddb9c28a51b9141d754da9ad72b6b311d8a2a
Author: Ian Rogers <irogers@google.com>

perf python: Add syscall name/id to convert syscall number and name
   =20
This commit adds syscall name and id conversions to the perf Python
extension using the syscalltbl support. This avoids the need for python
libaudit support in scripts.

> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index b68668c267d83..84a186532353e 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c

[ ... ]

> +static PyObject *pyrf__syscall_name(PyObject *self, PyObject *args)
> +{
> +	const char *name;
> +	int id;
> +
> +	if (!PyArg_ParseTuple(args, "i", &id))
> +		return NULL;
> +
> +	name =3D syscalltbl__name(EM_HOST, id);

If CONFIG_TRACE is disabled, syscalltbl.o is not compiled. Will this
cause a linker error since there are no HAVE_LIBTRACEEVENT guards or
fallback stubs in syscalltbl.h?

> +	if (!name)
> +		Py_RETURN_NONE;
> +	return PyUnicode_FromString(name);
> +}
> +
> +static PyObject *pyrf__syscall_id(PyObject *self, PyObject *args)
> +{
> +	const char *name;
> +	int id;
> +
> +	if (!PyArg_ParseTuple(args, "s", &name))
> +		return NULL;
> +
> +	id =3D syscalltbl__id(EM_HOST, name);
> +	if (id < 0) {
> +		PyErr_Format(PyExc_TypeError, "Failed to find syscall %s", name);

This isn't a bug, but should this raise a ValueError instead of a
TypeError since the argument type is correct but the value itself
is unrecognized?

> +		return NULL;
> +	}
> +	return PyLong_FromLong(id);
> +}

[ ... ]

> @@ -2614,6 +2646,18 @@ static PyMethodDef perf__methods[] =3D {
>  		.ml_flags =3D METH_NOARGS,
>  		.ml_doc	  =3D PyDoc_STR("Returns a sequence of pmus.")
>  	},
> +	{
> +		.ml_name  =3D "syscall_name",
> +		.ml_meth  =3D (PyCFunction) pyrf__syscall_name,
> +		.ml_flags =3D METH_VARARGS,
> +		.ml_doc	  =3D PyDoc_STR("Turns a syscall number to a string.")
> +	},
> +	{
> +		.ml_name  =3D "syscall_id",
> +		.ml_meth  =3D (PyCFunction) pyrf__syscall_id,
> +		.ml_flags =3D METH_VARARGS,
> +		.ml_doc	  =3D PyDoc_STR("Turns a syscall name number to a number.")

This isn't a bug, but there is a typo in the docstring ("name number").

> +	},
>  	{ .ml_name =3D NULL, }
>  };
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260419235911.2186=
050-1-irogers@google.com?part=3D16
