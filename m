Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4EE13B18A
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 00:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781485007; cv=none; b=C1xspnNGgdZvQP9wmW/2q07gKPV27STq7mGRCPm7MKphHLBdcH14ok50dEgeV70TLedtCOzSSV5CVVSjaaCe6sQJxzF7GylLtubtCl2Nx8S9cM9wX7+fUPxCagVzbZzoRM2Hq/ItRhHtwHqalLWQfpyJHkJJVDnowyI0/Uy7JNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781485007; c=relaxed/simple;
	bh=Qy4iVDMuOsladjA8LZqQpEpsURSDVdxcX7RFY4CNECc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FXe6oljkvaW+rbY5qOwLvgZES5DinK96cb+yJ84pp6KSfMtmnpPLxnqchgnmV8MazLxRpNSKb6DYEsW+GohPLFRViLKMtWAE7dWdrVPL1AnMt+cIIVcwVzmQAYJ9Cp7D80Y/2KaqyHpFdVQXbXtz+5ozOmWthn9AbeVnTCyXfac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JvdmtDga; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JvdmtDga"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D1021F000E9;
	Mon, 15 Jun 2026 00:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781485006;
	bh=MvqtrIZc6T4GYi+wj/k0Q0bGstdwF2rMpZwtSG5rIVs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JvdmtDgamUTvXu2opmpx7f70jKwNA68nErqUhgRpm84o7hoA9TYSkmp5mkPK/hYLN
	 26AKiYrspGZsCgwxn3szrb/0Ikbbc0Y9WDTpRNRTQ1Kjjw8DDa++iDtjBBuA/bP5Hh
	 zdHuebWOuXXSvZS0sHchHVIj+gQxhKfMk916W7KZHuqZd7HkT7vipdJExXJ4AdBm6W
	 A2BSpFOgUmn1c1BexwHoMMaDGTs1Cl4GFchJh8T2z3qrax8oXYjaSUKTmH9+KY2TC7
	 OwhE/W14KmxKkW2AOxtA1ZHujcivToFjulesdkVDa2jsg7ukYdfoM4mStayUvEbJnt
	 TK85BnrUQ4NdA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v18 18/20] perf python: Handle Py_None for thread and
 cpu maps
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260615002812.2234795-19-irogers@google.com>
References: <20260615002812.2234795-19-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 00:56:45 +0000
Message-Id: <20260615005646.5D1021F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Lack of Python object type validation before casting PyObject poin=
ters leads to type confusion and arbitrary memory reads/crashes.
- [High] Missing bounds check in `pyrf_counts_values_set_values` leads to a=
 heap buffer overflow.
--

commit b18f84f122fea57b8e464425cd3fe35dff581429
Author: Ian Rogers <irogers@google.com>

perf python: Handle Py_None for thread and cpu maps

The python stubs allow passing None for threads and cpus to the
perf.parse_events() and perf.parse_metrics() bindings. This commit fixes
a crash caused by dereferencing Py_None by explicitly checking for it
alongside NULL.

> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
> @@ -2091,10 +2091,10 @@ static PyObject *pyrf_evsel__open(struct pyrf_evs=
el *pevsel,
>  					 &pcpus, &pthreads, &group, &inherit))
>  		return NULL;
> =20
> -	if (pthreads !=3D NULL)
> +	if (pthreads !=3D NULL && pthreads !=3D Py_None)
>  		threads =3D ((struct pyrf_thread_map *)pthreads)->threads;
> =20
> -	if (pcpus !=3D NULL)
> +	if (pcpus !=3D NULL && pcpus !=3D Py_None)
>  		cpus =3D ((struct pyrf_cpu_map *)pcpus)->cpus;

[Severity: High]
This isn't a bug introduced by this patch, but since we are handling Python
types here, should we also verify the object type before casting?

PyArg_ParseTuple uses the generic O format specifier, which accepts any Pyt=
hon
object. If a script passes an integer or string instead of a thread or cpu
map, could this blind cast lead to type confusion and arbitrary memory read=
s?

[ ... ]

> @@ -3340,8 +3340,8 @@ static PyObject *pyrf__parse_events(PyObject *self,=
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

[Severity: High]
This is a pre-existing issue, but it shares the same type confusion risk.
Is it possible for an invalid Python object type to cause a crash when
dereferencing threads or cpus here?

[ ... ]

> @@ -3374,8 +3374,8 @@ static PyObject *pyrf__parse_metrics(PyObject *self=
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

[Severity: High]
This is a pre-existing issue, but again, could casting an unverified Python
object type lead to unexpected behavior in this function as well?

While reviewing this file, I also noticed another pre-existing issue in
pyrf_counts_values_set_values():

tools/perf/util/python.c:pyrf_counts_values_set_values() {
    ...
    size =3D PyList_Size(list);
    for (Py_ssize_t i =3D 0; i < size; i++) {
        item =3D PyList_GetItem(list, i);
        if (!PyLong_Check(item)) {
            PyErr_SetString(PyExc_TypeError, "List members should be number=
s");
            return -1;
        }
        self->values.values[i] =3D PyLong_AsLong(item);
    }
    ...
}

[Severity: High]
This isn't a bug introduced by this patch, but does this code overflow the
values array?

The target C array values inside struct perf_counts_values has a fixed
length of 5 elements, but the loop iterates up to PyList_Size(list). If a
Python script passes a list with more than 5 elements, could this overwrite
adjacent heap memory?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615002812.2234=
795-1-irogers@google.com?part=3D18
