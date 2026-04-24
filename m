Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF29343D75
	for <linux-perf-users@vger.kernel.org>; Fri, 24 Apr 2026 17:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777051889; cv=none; b=kuTfdJXseLz38V+6/2s1rpr06V4GORAoziGxnAM4AYbdEhTIuyi3nXmCTKCmCtJjxPtNk7bIUFUuUWrplnm+H2LTprcDDVN7ZNtbsiCtORHAaZZwvh7Ij/RrGYCmL1JpZKImCWUinAwHGVVbCjLiVllRai1kbliV8TeBAvXgiaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777051889; c=relaxed/simple;
	bh=1gpo1WCCVSQMb4FWojvAx/9S4SHGolw92JCwVs5nV4U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=C4tvfqqx/+wPAVQXOzB47cMJASo0u9tXt4qSkmkJAhgSy2NgrnDW1N3++ptcNw7XQ6IqQoUxHJz8cHnAA6XWMBKXoTorJV20iWyrdA61DtCZEQcWLpXKZqrHx4nuJn2Xmf07JK/Qn0Jvr6ZPAbroCTPR3AaL7y+inXUr1CB7fNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JK0yXhxp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JK0yXhxp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78276C2BCB2;
	Fri, 24 Apr 2026 17:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777051888;
	bh=1gpo1WCCVSQMb4FWojvAx/9S4SHGolw92JCwVs5nV4U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=JK0yXhxpztsXs9FM7jxh7dCpogkp+ups3+7gir5oA2umPJmitBzORy3B9/+mkjUbA
	 oYIc+oRUeCAa9jg6cif6956ph5okRKmi3JufJIE7DStpf3SDzn9LcKwHemT/UMe8yH
	 UU6M5g8UGGFucZcbP+1DbLho1naCURWa8G62SP1G2YGPkmVmBfgEEF5MHwz2Si3ST5
	 GWonFslbkLLDw+9Gn3EoiztCaJ9gDzvzVbiOTUezz2cfOKvwRAUw8CnMx2jvQ8QiQx
	 gM2Uj08gctZXYczg7vPi8QPzY1TmUdZQ+C1SmmiDlbx7OgtAQGsngZxm6gNEwT9DaJ
	 huk0RvhFPJ7OA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 11/58] perf evsel: Add reference count
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260424164721.2229025-12-irogers@google.com>
References: <20260424164721.2229025-12-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Apr 2026 17:31:27 +0000
Message-Id: <20260424173128.78276C2BCB2@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 4 potential issue(s):
- [High] Missing `tp_setattro` handler for the `perf.evsel` Python object c=
auses interpreter crashes on uninitialized attribute assignments.
- [High] Type confusion and arbitrary memory write in `pyrf_evlist__add` du=
e to `evsel` pointer dereference.
- [High] Calling `str()` or `repr()` on an uninitialized `perf.evsel` Pytho=
n object crashes due to a NULL pointer dereference.
- [Medium] The `pyrf_evlist__add` function unconditionally leaks the `pevse=
l` Python wrapper object every time an event is added.
--

commit df48f1c2356d36f06e78d49a06cfbee6ba9eaa0f
Author: Ian Rogers <irogers@google.com>

perf evsel: Add reference count

This commit introduces a reference count to struct evsel to better handle=20
its lifecycle, particularly in the Python bindings, where events were
previously cloned and caused assertion failures. Get and set functions are
added for Python evsel members to maintain the API.

> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index 3f0758d5bd9041..8585ae992e6b03 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
[ ... ]
> @@ -1192,7 +1200,7 @@ static PyObject *pyrf_evsel__read(struct pyrf_evsel=
 *pevsel,
>  static PyObject *pyrf_evsel__str(PyObject *self)
>  {
>  	struct pyrf_evsel *pevsel =3D (void *)self;
> -	struct evsel *evsel =3D &pevsel->evsel;
> +	struct evsel *evsel =3D pevsel->evsel;
> =20
>  	return PyUnicode_FromFormat("evsel(%s/%s/)", evsel__pmu_name(evsel), ev=
sel__name(evsel));
>  }

Since pevsel->evsel is now a dynamically allocated pointer, it can be NULL
if the Python object is instantiated without a successful initialization.

Could this lead to a NULL pointer dereference when str() or repr() is
called on an uninitialized perf.evsel object, since evsel__pmu_name(evsel)
will attempt to access the NULL pointer?

[ ... ]
> @@ -1225,30 +1233,183 @@ static PyMethodDef pyrf_evsel__methods[] =3D {
>  	{ .ml_name =3D NULL, }
>  };

[ ... ]

> +static PyObject *pyrf_evsel__getattro(struct pyrf_evsel *pevsel, PyObjec=
t *attr_name)
> +{
> +	if (!pevsel->evsel) {
> +		PyErr_SetString(PyExc_ValueError, "evsel not initialized");
> +		return NULL;
> +	}
> +	return PyObject_GenericGetAttr((PyObject *) pevsel, attr_name);
> +}
> +
>  static PyTypeObject pyrf_evsel__type =3D {
>  	PyVarObject_HEAD_INIT(NULL, 0)
>  	.tp_name	=3D "perf.evsel",
> @@ -1256,11 +1417,12 @@ static PyTypeObject pyrf_evsel__type =3D {
>  	.tp_dealloc	=3D (destructor)pyrf_evsel__delete,
>  	.tp_flags	=3D Py_TPFLAGS_DEFAULT|Py_TPFLAGS_BASETYPE,
>  	.tp_doc		=3D pyrf_evsel__doc,
> -	.tp_members	=3D pyrf_evsel__members,
> +	.tp_getset	=3D pyrf_evsel__getset,
>  	.tp_methods	=3D pyrf_evsel__methods,
>  	.tp_init	=3D (initproc)pyrf_evsel__init,
>  	.tp_str         =3D pyrf_evsel__str,
>  	.tp_repr        =3D pyrf_evsel__str,
> +	.tp_getattro	=3D (getattrofunc) pyrf_evsel__getattro,
>  };

While tp_getattro is provided to protect property reads on uninitialized
objects, tp_setattro is not defined.

Does this mean Python falls back to PyObject_GenericSetAttr, which will
execute C setters like pyrf_evsel__set_tracking directly?

If so, could this cause a segmentation fault in the Python interpreter if
properties are written to an uninitialized perf.evsel object, since the
setters unconditionally dereference pevsel->evsel?

[ ... ]
> @@ -1566,9 +1728,9 @@ static PyObject *pyrf_evlist__add(struct pyrf_evlis=
t *pevlist,
>  		return NULL;
> =20
>  	Py_INCREF(pevsel);
> -	evsel =3D &((struct pyrf_evsel *)pevsel)->evsel;
> +	evsel =3D ((struct pyrf_evsel *)pevsel)->evsel;
>  	evsel->core.idx =3D evlist->core.nr_entries;
> -	evlist__add(evlist, evsel);
> +	evlist__add(evlist, evsel__get(evsel));
> =20
>  	return Py_BuildValue("i", evlist->core.nr_entries);
>  }

Because pevsel->evsel is now a pointer instead of an embedded struct, does
the assignment to evsel->core.idx introduce a potential arbitrary memory
write if pevsel is passed as a different object type, given that
PyArg_ParseTuple uses the "O" format without type validation?=20

Additionally, if an uninitialized perf.evsel object is passed, evsel will
be NULL. Could this lead to an immediate NULL pointer dereference when
writing to evsel->core.idx?

Finally, since evlist now manages the evsel lifecycle via evsel__get(evsel)
and the evsel struct is separated from the Python wrapper, is the
Py_INCREF(pevsel) call still necessary?

Because the Python wrapper object is no longer stored in the C structures,
will leaving Py_INCREF(pevsel) cause a memory leak of the Python object each
time an event is added?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260424164721.2229=
025-1-irogers@google.com?part=3D11
