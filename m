Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E20288AD
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 23:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777158944; cv=none; b=HXtDjsER6oYGhAd05zXgtITZlCXjwfVcEVMuzeFUwv91TjHWxUdYrg62n4ifhjwgyc8sfD6d7NlSFsMOP02Ex+DGjIra5Pt7M7cWg/id+OcGkrGIir+j7IN1g/pYGjtRTrOrN9pC3dycYgoxBq7G9hhDk2pwzOrpI//vSKcu+Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777158944; c=relaxed/simple;
	bh=XRG9vv2H0FSFBXfSOZQa8Lq8ovOBP24jJkqxdIAnXK8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gX3Dt889ODZpuT5UloIOSoB6fd8YK1kIqlbsZv740hTFc1RNAuy/REfjDM6Kk8f788966zpAAsLxfMgZVxU97fCLwJLOWVb0b9p8JmL2Nf7v0tjrDvye0K55G7meZQD4JEC0Sbn1Je/YALP38Zv8mpGia+ZdEnL9d5hzMuPLPGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mQtwR9rY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mQtwR9rY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B798C2BCB0;
	Sat, 25 Apr 2026 23:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777158944;
	bh=XRG9vv2H0FSFBXfSOZQa8Lq8ovOBP24jJkqxdIAnXK8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=mQtwR9rYZPBaWnhSFFr7ku81Q9VFxoB+Ni2nPmKMvnNExFpk9jrn7f9bn4HFhL7Mf
	 pY8SkOAoOYYDUaQgG9g+BJ1Jrv7XFE5EPA7/vXenj8Y8Y3DN9ixI0r61lDf3K5Izmw
	 w3j8+Y/tlrq4JGBrBe1lc5CznE4xIOIi9QhmuuiQO2BuC3wUtYplyPFMjbHmJcvUst
	 mqVOa9FMdlOW6ax6Vjx2tRC+XzgQeuAtMy4Z7Zq5JhDDn7cI3q8I0srdpGtm7fFPeK
	 Igc6mMvm0QC5s1aHd8LEtw98pcav+mn+ZWhVuRv5FaeV3m2a28OftlHTX2uFZElzYf
	 FOFMktJg2oyhQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 16/59] perf python: Add syscall name/id to convert
 syscall number and name
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260425224951.174663-17-irogers@google.com>
References: <20260425224951.174663-17-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Apr 2026 23:15:43 +0000
Message-Id: <20260425231544.7B798C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Low] The use of `static char * const kwlist[]` causes a fatal compiler w=
arning (treated as an error) on widely used Python versions.
--

commit 255ac1bdc670015e70083350909742474af1b56e
Author: Ian Rogers <irogers@google.com>

perf python: Add syscall name/id to convert syscall number and name

This commit adds syscalltbl support to the perf python module. It provides
functions to convert between syscall numbers and names using the host
machine's syscall table, removing the dependency on python libaudit.

> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index 1af53480661f..861973144106 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c

[ ... ]

> @@ -2669,6 +2671,40 @@ static int pyrf_session__setup_types(void)
>  	return PyType_Ready(&pyrf_session__type);
>  }
> =20
> +static PyObject *pyrf__syscall_name(PyObject *self, PyObject *args, PyOb=
ject *kwargs)
> +{
> +	const char *name;
> +	int id;
> +	int elf_machine =3D EM_HOST;
> +	static char * const kwlist[] =3D { "id", "elf_machine", NULL };

Does this declaration cause a build failure on older Python versions?

In Python versions up to 3.12, PyArg_ParseTupleAndKeywords() expects the
keywords argument to be char ** (or char *keywords[]). Passing char * const=
 *
drops the const qualifier, which triggers an incompatible-pointer-types war=
ning
in GCC. Since tools/perf builds with -Werror by default, this warning becom=
es
a fatal build error.

> +
> +	if (!PyArg_ParseTupleAndKeywords(args, kwargs, "i|$i", kwlist, &id, &el=
f_machine))
> +		return NULL;
> +
> +	name =3D syscalltbl__name(elf_machine, id);
> +	if (!name)
> +		Py_RETURN_NONE;
> +	return PyUnicode_FromString(name);
> +}
> +
> +static PyObject *pyrf__syscall_id(PyObject *self, PyObject *args, PyObje=
ct *kwargs)
> +{
> +	const char *name;
> +	int id;
> +	int elf_machine =3D EM_HOST;
> +	static char * const kwlist[] =3D { "name", "elf_machine", NULL };

Could this declaration also be updated to drop the const qualifier for the
same reason?

> +
> +	if (!PyArg_ParseTupleAndKeywords(args, kwargs, "s|$i", kwlist, &name, &=
elf_machine))
> +		return NULL;
> +
> +	id =3D syscalltbl__id(elf_machine, name);
> +	if (id < 0) {
> +		PyErr_Format(PyExc_ValueError, "Failed to find syscall %s", name);
> +		return NULL;
> +	}
> +	return PyLong_FromLong(id);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260425224951.1746=
63-1-irogers@google.com?part=3D16
