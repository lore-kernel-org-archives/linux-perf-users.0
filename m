Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF2136C0CB
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 18:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777140905; cv=none; b=r6/A2YTDN24hu6T71GH0VM58KtKOfgM/esBo9DBVTLprC/mtUQpLt8Nucs0ido3zoOgnrrUmvEvqg97HSaDakd0StP15h93aitZwpd7Nn1FBsJxTgaMMDbRQOTCnuUSmVI6rhJGb2WO1dJgv96056RvUCO8pPWowWQs/azASKVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777140905; c=relaxed/simple;
	bh=rRJt8rWiknA9qc4okw6vXtoKlrvONUe96CJajWhdFHY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BFECHfSJhjaM5Vx1wp9GrHA0QAHw82coYBnh60HVS92IyGQ1WjV7L0RGwlH03cuw5xKpHExdSQSaflimfEuO6IzhP90UMF/85cPKHwpsrcReFlXXpGEI//vucItkGL8CzxyWyL+RWKdVGYqkAxo5ks5/qU+/YbMPLa+yIXwB9ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VLoILf8Q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VLoILf8Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 939FCC2BCB0;
	Sat, 25 Apr 2026 18:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777140904;
	bh=rRJt8rWiknA9qc4okw6vXtoKlrvONUe96CJajWhdFHY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=VLoILf8QFTk0dTCC9VOeoriFhwHwe1qv9+oTicEyimkhbFpZx7wmOS+yteAWyPp/H
	 8HgUedgsB/9O94Z/vlKxHqM3fVfPl+ZuED85xQdf8EAU6Jo6A2b0h8nK33g+ZAowR2
	 zXhwnX4RpLTo+pveHZUgaaUkzbNvlmkw7a8S3bCx3KD9pJ5rTVdWVxqHM4EPz9Jx0D
	 dfJLFG9hTsMRDntNZHnn4je/zv/aGcfnaTYJlUrHwVKkAGFBjBekRJMTFXUGg7EDra
	 Lu6Hoy0Bgfqz45yvjRQbV1Rm8o6AFZlOu1ANdGuIeu5B51VGD09AU8d71LMnap8MFt
	 BYJoqciBLR6rg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 16/59] perf python: Add syscall name/id to convert
 syscall number and name
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260425174858.3922152-17-irogers@google.com>
References: <20260425174858.3922152-17-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Apr 2026 18:15:04 +0000
Message-Id: <20260425181504.939FCC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [High] Missing libtraceevent guard around syscalltbl logic causes build f=
ailure when NO_LIBTRACEEVENT=3D1.
- [High] Declaring `kwlist` as `static char * const kwlist[]` triggers a co=
mpiler warning that breaks the build under `-Werror` on standard Python ver=
sions.
--

commit 05b34dee99e34de49f07ffff286551ecc3713de8
Author: Ian Rogers <irogers@google.com>

perf python: Add syscall name/id to convert syscall number and name

This commit introduces functionality to use perf's syscalltbl support
to convert syscall numbers to names and vice versa within the python
extension. This helps avoid the need for python libaudit support in
certain scripts.

> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index d10359abd1ea..a10c4a292756 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c

[ ... ]

> @@ -2635,6 +2637,40 @@ static int pyrf_session__setup_types(void)
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

Can this trigger a compiler warning that breaks the build under -Werror
on systems with Python 3.12 or older?

Prior to Python 3.13, PyArg_ParseTupleAndKeywords() expects a char ** for
its keywords argument. Passing a char * const * discards the const
qualifier, which might generate a -Wincompatible-pointer-types warning.

> +
> +	if (!PyArg_ParseTupleAndKeywords(args, kwargs, "i|$i", kwlist, &id, &el=
f_machine))
> +		return NULL;
> +
> +	name =3D syscalltbl__name(elf_machine, id);

Does this cause a build failure when perf is built with NO_LIBTRACEEVENT=3D=
1?

The syscalltbl.o object is only compiled if CONFIG_TRACE is set, which is
enabled only if NO_LIBTRACEEVENT is not set.=20

Because python.c calls syscalltbl__name() and syscalltbl__id() unconditiona=
lly
without checking if libtraceevent is available, linking the python extension
might fail with an undefined reference when libtraceevent is omitted.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260425174858.3922=
152-1-irogers@google.com?part=3D16
