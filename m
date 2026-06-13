Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614C8334C3C
	for <linux-perf-users@vger.kernel.org>; Sat, 13 Jun 2026 09:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781343258; cv=none; b=YoEAG3NnCNzMKEMjAWfrSWYglHZJTE9LamKtvOQSE3yGbxhDEr+eNCtJHk581OTkaR2z9pqcTilanrLxI84FM78DlDKRd602CxEmK+Emrwl3asLG1oZAkaEVSWhH4ila2Gv3clY4wPCoqAxEb6qCV6Di+Xxuc5ixs7WbryaywnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781343258; c=relaxed/simple;
	bh=AE4iRq/VdjERxkdKYUymH85Nw/RnEyOWuDh/iEYqMpo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=crMvVLRvJQSYhFWSIN8jqBaSkqQm+5vodwffLyWNP69t0cQp3rXVfb653iraotKdLX88FzebykZ+dNQBl3nr2fAjQXHttjA3hV9+a1NWGoDP5q4r/pw0Xws/PQ4KTp8rkFUej3SL/SYRHK8IGQ99txGie4iKL3S4QsN2KcKX6i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WT1DhXo7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WT1DhXo7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6B5C1F000E9;
	Sat, 13 Jun 2026 09:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781343257;
	bh=1GK4bkT/g3EDmXcXeRoRLNduVo5bX4XanrBS3gp7lLQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WT1DhXo7IPxMGmiMwF85fVK/54PLFTsSq9LSPXp+5bxnZ2+Pe5udkxsPsFP9C7ufe
	 3HhIcFztDc1pjvasec0i6TAd6s1t8PzTcpiZ9ZBSid4xMtlByW2BDFBYd8RDZap6t7
	 DieoeNe/EilH6NqXx1V19fTzIoourhDl2fR8vpdRKOrsNKFUcxKbeQGtKhlMq5LQlG
	 ZnuyKAV9jTSz046t/tZVJdltRBv5fic+CR9uIet2x8Km8oL+eIgxPdmvaBio16kX4Z
	 kkONE8U0pd02uaOQ2GD42w454134tO2dzZ8aJJpN8L7yrsIyuRRRR6aj6OxBbp5S5F
	 3u4YK7OAgaKjA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v17 18/20] perf python: Handle Py_None for thread and
 cpu maps
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260613071100.1508192-19-irogers@google.com>
References: <20260613071100.1508192-19-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 13 Jun 2026 09:34:16 +0000
Message-Id: <20260613093416.D6B5C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Medium] Missing cleanup of `parse_events_error` object in `pyrf__parse_e=
vents`, causing a memory leak on both success and error paths.
- [Medium] Type confusion and memory corruption when invalid Python objects=
 are passed as thread or cpu maps.
--

commit a6be458ef9e6ffdb9109b5da1e5fa80ceebb3cba
Author: Ian Rogers <irogers@google.com>

perf python: Handle Py_None for thread and cpu maps

The python stubs allow passing None for threads and cpus to the
perf.parse_events() and perf.parse_metrics() bindings. Because the C
code lacked an explicit check for Py_None, it would cast Py_None to a
struct pointer and dereference it. This commit explicitly checks for
Py_None alongside NULL in pyrf__parse_events, pyrf__parse_metrics, and
pyrf_evsel__open.

> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index ee88b3af98e3f..8d4877148aa6e 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
> @@ -2086,10 +2086,10 @@ static PyObject *pyrf_evsel__open(struct pyrf_evs=
el *pevsel,
>  					 &pcpus, &pthreads, &group, &inherit))
>  		return NULL;
> =20
> -	if (pthreads !=3D NULL)
> +	if (pthreads !=3D NULL && pthreads !=3D Py_None)
>  		threads =3D ((struct pyrf_thread_map *)pthreads)->threads;

[Severity: Medium]
This is a pre-existing issue, but does this blind cast lack a type check?

If the Python caller passes an object that isn't a pyrf_thread_map or Py_No=
ne
(such as an integer or a string), PyArg_ParseTuple with the "O" format
specifier will accept it. When cast here, couldn't this cause memory
corruption by reading arbitrary memory as a C pointer?

> =20
> -	if (pcpus !=3D NULL)
> +	if (pcpus !=3D NULL && pcpus !=3D Py_None)
>  		cpus =3D ((struct pyrf_cpu_map *)pcpus)->cpus;
> =20
>  	evsel->core.attr.inherit =3D inherit;

[ ... ]

> @@ -3335,8 +3335,8 @@ static PyObject *pyrf__parse_events(PyObject *self,=
 PyObject *args)
>  		return NULL;
>  	}
> =20
> -	threads =3D pthreads ? ((struct pyrf_thread_map *)pthreads)->threads : =
NULL;
> -	cpus =3D pcpus ? ((struct pyrf_cpu_map *)pcpus)->cpus : NULL;
> +	threads =3D (pthreads && pthreads !=3D Py_None) ? ((struct pyrf_thread_=
map *)pthreads)->threads : NULL;
> +	cpus =3D (pcpus && pcpus !=3D Py_None) ? ((struct pyrf_cpu_map *)pcpus)=
->cpus : NULL;

[Severity: Medium]
This is a pre-existing issue, but is a type check also needed here in
pyrf__parse_events() before casting pthreads and pcpus to their respective C
structures?

> =20
>  	parse_events_error__init(&err);
>  	perf_evlist__set_maps(evlist__core(evlist), cpus, threads);

[Severity: Medium]
This isn't a bug introduced by this patch, but does the err object leak
its internal allocations?

In tools/perf/util/python.c:pyrf__parse_events():

    parse_events_error__init(&err);
    perf_evlist__set_maps(evlist__core(evlist), cpus, threads);
    if (parse_events(evlist, input, &err)) {
        ...
        return NULL;
    }
    result =3D pyrf_evlist__from_evlist(evlist);
    evlist__put(evlist);
    return result;

Since parse_events() can allocate error/warning strings inside err, should
parse_events_error__exit(&err) be called before returning?

[ ... ]

> @@ -3369,8 +3369,8 @@ static PyObject *pyrf__parse_metrics(PyObject *self=
, PyObject *args)
>  		return NULL;
>  	}
> =20
> -	threads =3D pthreads ? ((struct pyrf_thread_map *)pthreads)->threads : =
NULL;
> -	cpus =3D pcpus ? ((struct pyrf_cpu_map *)pcpus)->cpus : NULL;
> +	threads =3D (pthreads && pthreads !=3D Py_None) ? ((struct pyrf_thread_=
map *)pthreads)->threads : NULL;
> +	cpus =3D (pcpus && pcpus !=3D Py_None) ? ((struct pyrf_cpu_map *)pcpus)=
->cpus : NULL;

[Severity: Medium]
This is a pre-existing issue, but should pyrf__parse_metrics() also verify
the object types before casting pthreads and pcpus?

> =20
>  	perf_evlist__set_maps(evlist__core(evlist), cpus, threads);
>  	ret =3D metricgroup__parse_groups(evlist, pmu ?: "all", input,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260613071100.1508=
192-1-irogers@google.com?part=3D18
