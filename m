Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEEA036C9E4
	for <linux-perf-users@vger.kernel.org>; Fri, 22 May 2026 22:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779489999; cv=none; b=ZBkHou0b6rUCebbAQzyPtsypkgl44Tzllt6CQILHQTRhdzyica6xOlBIcUsDZpAVROmNagSh63N1xB8rN8aQE4RGmBtdZjAr+PYRg1XHJct01qoZBwDN7Sl1DoC5rHbEfIdJofMkDCZ/5R9vgIp/Ed4ugWYFP9ck8v2eGMI8vkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779489999; c=relaxed/simple;
	bh=nXCvgFp7Jf9vSbp1gD24uxjbEJtSyNIr3HfrPLVj3eM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aJWFlIFnvsRfNU2vbDj/3f3/CyE1sr5jb5z5p1XJTyaLqlQMvHXgfNYB7fjVgl60SP/StJTOXtcDs4RUC1Pt8hQ8oHB/jZaThNYGR80UwUXk1CDObJ/BrWvl7c3/GTdFcxFF6ha81ZO/3+6MPu8bNfv0vONULE8IMJm922JSirE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GnxCIy/Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GnxCIy/Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55CB91F000E9;
	Fri, 22 May 2026 22:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779489998;
	bh=HDv0PI+M2aArSU9xxQfGq/L8q89teupAxqP94G303/Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GnxCIy/YueIJRrQDbBZ/a4ibrFh36xismXAnYebjbe1qYEZeNICqDZl/D+PV2CeL2
	 3ZEsym/F74DgwyQGd8y1PcU3CCm7YC5hhDnkyWou+fknztbcSXHnWE4TBKWRbK0/fU
	 iEXL7dX/UjM6HdRfm4lUk8kLi1iKpjmUAzhu0PZ6PKoV1SRDTSbSMafR17lCeg7xgp
	 doBSZcrtUP6QpIIIbhA+muGJ2aoCyQyufCFtTT97Pynv2j3Mw1mpRM6ujTzR+7HuEu
	 5qYFKsmU92peLai+xQDWMPOHdks6j9nRHOSKI8vge29p8bgDNTnXLXKhD5FBImoAF9
	 XvLbyo+V6NN4A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 20/23] perf python: Add syscall name/id to convert
 syscall number and name
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260522220435.2378363-21-irogers@google.com>
References: <20260522220435.2378363-21-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 22 May 2026 22:46:38 +0000
Message-Id: <20260522224638.55CB91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Incomplete implementation: Python scripts are not updated to use=
 the new syscall API.
- [Low] Incompatible pointer type warning causing build failure under -Werr=
or.
--

commit e9d75f77bbf3346ce89ce6e85ac1c93ce060af99
Author: Ian Rogers <irogers@google.com>

perf python: Add syscall name/id to convert syscall number and name

This commit adds Python bindings for syscall name and ID conversion using
perf's syscalltbl support. It aims to avoid the need for python libaudit
support in syscall-counts.py.

> perf python: Add syscall name/id to convert syscall number and name
>=20
> Use perf's syscalltbl support to convert syscall number to name
> assuming the number is for the host machine. This avoids python
> libaudit support as tools/perf/scripts/python/syscall-counts.py
> requires.

[Severity: Medium]
The commit message states this patch avoids python libaudit support for
syscall-counts.py, but the diff doesn't appear to update syscall-counts.py
or its helper scripts to use this new API.

Are the script updates missing from this patch?

> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index 218d772346e2b..23eb65adb3928 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c

[ ... ]

> @@ -3792,6 +3794,40 @@ static int pyrf_session__setup_types(void)
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

[Severity: Low]
Will this cause an incompatible pointer type warning?

PyArg_ParseTupleAndKeywords() expects either a char ** or a const char *
const * depending on the python version.

Passing a char * const * discards the const qualifier and might trigger a
build failure since perf builds with -Werror.

> +
> +	if (!PyArg_ParseTupleAndKeywords(args, kwargs, "i|$i", kwlist, &id, &el=
f_machine))
> +		return NULL;

[ ... ]

> +static PyObject *pyrf__syscall_id(PyObject *self, PyObject *args, PyObje=
ct *kwargs)
> +{
> +	const char *name;
> +	int id;
> +	int elf_machine =3D EM_HOST;
> +	static char * const kwlist[] =3D { "name", "elf_machine", NULL };

[Severity: Low]
Does this have the same discarded qualifier issue with the kwlist type as
seen in pyrf__syscall_name() above?

> +
> +	if (!PyArg_ParseTupleAndKeywords(args, kwargs, "s|$i", kwlist, &name, &=
elf_machine))
> +		return NULL;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260522220435.2378=
363-1-irogers@google.com?part=3D20
