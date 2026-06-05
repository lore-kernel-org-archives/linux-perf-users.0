Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3618B3D9DA9
	for <linux-perf-users@vger.kernel.org>; Fri,  5 Jun 2026 08:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780646639; cv=none; b=omF6bsRTJIhymXknUP8c9k5agVtHRTywOk2u71GlN48aGvDEttXbn3vFSvU2BfJhLl7cgpuh5oRxA+jHpBZv8EzhUCGAKXnJAco9LgEr6ApOnd1z8gsmKdvUEmFg3O7I3uMJycCZqMJSOh/T7NMxZvw+UKf7TBRL0RtP4tTRYeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780646639; c=relaxed/simple;
	bh=DLMsJm/c8diTn+lNk/uNWBz4hukWEjlUNQHRZs92in8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VgNm2sTxVY9sUPCeDJjsmG28+AsHkYDl3iwbP7agLPS+0rSgjGCFGU1nb7ws5Z0z1R4UwIOlH+a5OxjuooPp8yBt/HrXu9gpBb4F3p7aGfNMm6i1BNdbnRp5mq4fsV4Qlu4upjG1trktgM+gaYBpwcrPHGr6ziiU8gKjnJg67S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HU3aw5iO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HU3aw5iO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B18EF1F00893;
	Fri,  5 Jun 2026 08:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780646637;
	bh=9u6i3rcI9EXcSSG1reHGJXqZWA+0qsOq43fmIbTRghI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HU3aw5iOcn5QcWyHPRlv4LI4RVNwUOBrb9a0csye+P5mErJ3HVnOy+MTwqGoGkzrP
	 aMjvpmRgudquQFFbUnZgPbFJu1AyRTS/WH7Us6k3GCSApCz3Ok+ESpk3RpNk+cM6Oh
	 ehNSEq9f3QnsBp0NSdJpDW3Smb/uSP+HDmnUEtC3RT81LOUt90dVGCuBpiTfIl87Pl
	 zrwdwIm1zT5u93HEgxw2q6JJvg5tRU2a+jc0yBP6ukEaDI3mrs2B4jW/nLYzuV260x
	 Doxiy8PAYWJRBBthjXyhXQZbxsrBt/TXCI3ESuRbipV5m77Wmw/DLl6KBnaHyml6Cz
	 bcTPciEPz7PfA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 05/19] perf evlist: Add reference count
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260605074003.1730715-6-irogers@google.com>
References: <20260605074003.1730715-6-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 08:03:57 +0000
Message-Id: <20260605080357.B18EF1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing type checks when parsing arguments in `pyrf__parse_events`=
 and `pyrf__parse_metrics` lead to memory corruption if arbitrary objects a=
re passed.
--

commit cb6079407cc6561ad1c951d274d9edb326c3f418
Author: Ian Rogers <irogers@google.com>

perf evlist: Add reference count

This commit adds a reference count to the evlist structure. The reference c=
ount
is initialized to 1 at allocation and helps manage the lifecycle of evlists,
particularly avoiding asserts and issues when cloning evlists in Python cod=
e.

> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
[ ... ]
> @@ -2088,14 +2088,17 @@ static PyObject *pyrf__parse_events(PyObject *sel=
f, PyObject *args)
>  {
>  	const char *input;
> -	struct evlist evlist =3D {};
> +	struct evlist *evlist =3D evlist__new();
>  	struct parse_events_error err;
>  	PyObject *result;
>  	PyObject *pcpus =3D NULL, *pthreads =3D NULL;
>  	struct perf_cpu_map *cpus;
>  	struct perf_thread_map *threads;
> =20
> -	if (!PyArg_ParseTuple(args, "s|OO", &input, &pcpus, &pthreads))
> +	if (!evlist)
> +		return PyErr_NoMemory();
> +
> +	if (!PyArg_ParseTuple(args, "s|OO", &input, &pcpus, &pthreads)) {
> +		evlist__put(evlist);
>  		return NULL;
> +	}
> =20
>  	threads =3D pthreads ? ((struct pyrf_thread_map *)pthreads)->threads : =
NULL;
>  	cpus =3D pcpus ? ((struct pyrf_cpu_map *)pcpus)->cpus : NULL;

[Severity: High]
This is a pre-existing issue, but could this cause memory corruption if
arbitrary types are passed from Python? The untyped Python objects (parsed
with 'O') are blindly cast to pyrf_thread_map and pyrf_cpu_map structs with=
out
validation. Should this use 'O!' with the corresponding type objects to ens=
ure
the inputs are actually the expected map types?

[ ... ]
> @@ -2114,14 +2114,18 @@ static PyObject *pyrf__parse_metrics(PyObject *se=
lf, PyObject *args)
>  {
>  	const char *input, *pmu =3D NULL;
> -	struct evlist evlist =3D {};
> +	struct evlist *evlist =3D evlist__new();
>  	PyObject *result;
>  	PyObject *pcpus =3D NULL, *pthreads =3D NULL;
>  	struct perf_cpu_map *cpus;
>  	struct perf_thread_map *threads;
>  	int ret;
> =20
> -	if (!PyArg_ParseTuple(args, "s|sOO", &input, &pmu, &pcpus, &pthreads))
> +	if (!evlist)
> +		return PyErr_NoMemory();
> +
> +	if (!PyArg_ParseTuple(args, "s|sOO", &input, &pmu, &pcpus, &pthreads)) {
> +		evlist__put(evlist);
>  		return NULL;
> +	}
> =20
>  	threads =3D pthreads ? ((struct pyrf_thread_map *)pthreads)->threads : =
NULL;
>  	cpus =3D pcpus ? ((struct pyrf_cpu_map *)pcpus)->cpus : NULL;

[Severity: High]
This is a pre-existing issue, but similarly to pyrf__parse_events() above,
does this code blindly cast the untyped Python objects to pyrf_thread_map a=
nd
pyrf_cpu_map structs? Using 'O!' in PyArg_ParseTuple would allow the Python
C API to validate the type before casting, avoiding potential crashes.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605074003.1730=
715-1-irogers@google.com?part=3D5
