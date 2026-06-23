Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7342BC8EB
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Jun 2026 22:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782254993; cv=none; b=NSpHPJ0PRz2SW1MXHouVkTznMM1aF5Eb23EO7TyOxNufE2eJpopHeK4+/FLvxgmra8KTkkRtg590K0SoDNLnllG3yS0vtMWIX9/h363oB4meHOUfxc6Y4qkD3AYzY7LZROj9JO2vxkbfoq2Ji210O8w3ZuSiudeSObfL2K0V/tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782254993; c=relaxed/simple;
	bh=V+5yyt80Xcy7C5kjBc4trD6MlvRH0Jd6s7JVvAv1770=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=n8PVLXX8q8cMZNw3iu5qNm1tVeMpwTLk1ksajFryJLPDZODbNfO7q3zO85kl+3ko52LA4sC/9OrqP0WXHsoU6C/jNhMX2mVVOxvVKqL+Kch0NA9o7oVASa0FU37EpFf/r1AGH0o3clav3YaQKaGNIKr4U3ycfPEEMpd4zykn/u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fjEU4ZVH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fjEU4ZVH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2F331F000E9;
	Tue, 23 Jun 2026 22:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782254992;
	bh=re53XfIhLthyDrpqVAPByH3Pkf2AvJ+arRGyUoabnPw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fjEU4ZVHVxeZqVjgCVqysQSg3wI/UleyOY6niNAF9QivuPOlQqYOi7z0jqq6ojZhK
	 cok9vCKDFgB+HaboQ3W2WNaNgGbkPb8mxjuC9Rm001u7UXYmeg2nh0h6l2dG3YKL0B
	 wJMBuUVHPNIEkMLNh+9ZujPyENfl5r/02+O0N+bR4mGl7QZHxtlsH0bJIl1VlowLA2
	 NIVEQx0Fh6gB4Zjp/1Xdi020brCQ4qkr/n+sEgH0B8HerFKSLPEYKYq73PWD50VD4F
	 EOLfEvb4DrH2KWuS7GrkYUcfcTC6moGX+LwsOmhT6Z+bKDxF5KLIxiFJ2fuUsGWxsH
	 WpvXvqFwHXrfA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 12/13] perf python: Add thread uninitialized checks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260623053515.2677888-13-irogers@google.com>
References: <20260623053515.2677888-1-irogers@google.com>
 <20260623053515.2677888-13-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 22:49:51 +0000
Message-Id: <20260623224951.E2F331F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch incompletely fixes the missing initialization checks by =
omitting `pyrf_thread__get_cpu`, leaving a NULL pointer dereference vulnera=
bility.
- [High] The `perf.pmu` type methods lack initialization guards, allowing u=
ninitialized objects to cause NULL pointer dereferences.
- [Medium] The Python object `count_values` is leaked in multiple error pat=
hs within `pyrf_evsel__read`.
--

commit 95a2c7473298664fd72c7086443470ff19559438
Author: Ian Rogers <irogers@google.com>

perf python: Add thread uninitialized checks

The patch adds CHECK_INITIALIZED checks to the thread attribute getters
(get_pid, get_tid, get_ppid) in the perf python module to prevent crashes
when accessing uninitialized thread objects.

> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index 03b4e88091074..70f985ad3dd20 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
> @@ -3743,16 +3743,19 @@ static PyMethodDef pyrf_thread__methods[] =3D {
> =20
>  static PyObject *pyrf_thread__get_pid(struct pyrf_thread *pthread, void =
*closure __maybe_unused)
>  {
> +	CHECK_INITIALIZED(pthread->thread, "thread");
>  	return PyLong_FromLong(thread__pid(pthread->thread));
>  }
> =20
>  static PyObject *pyrf_thread__get_tid(struct pyrf_thread *pthread, void =
*closure __maybe_unused)
>  {
> +	CHECK_INITIALIZED(pthread->thread, "thread");
>  	return PyLong_FromLong(thread__tid(pthread->thread));
>  }
> =20
>  static PyObject *pyrf_thread__get_ppid(struct pyrf_thread *pthread, void=
 *closure __maybe_unused)
>  {
> +	CHECK_INITIALIZED(pthread->thread, "thread");
>  	return PyLong_FromLong(thread__ppid(pthread->thread));
>  }
> =20

[Severity: High]
This isn't a bug introduced by this patch, but pyrf_thread__get_cpu() is
missing a similar check:

tools/perf/util/python.c:pyrf_thread__get_cpu() {
    return PyLong_FromLong(thread__cpu(pthread->thread));
}

Could accessing the .cpu property on an uninitialized thread object cause a
NULL pointer dereference? Does it make sense to add a CHECK_INITIALIZED
guard here as well?

[Severity: High]
This isn't a bug introduced by this patch, but looking at the perf.pmu
methods, they also appear to lack initialization checks:

tools/perf/util/python.c:pyrf_pmu__name() {
    return PyUnicode_FromString(ppmu->pmu->name);
}

tools/perf/util/python.c:pyrf_pmu__events() {
    ...
    ret =3D perf_pmu__for_each_event(ppmu->pmu,
                                   false,
                                   py_list,
                                   pyrf_pmu__events_cb);
    ...
}

Since perf.pmu uses PyType_GenericNew, could a script instantiate an
uninitialized PMU and trigger a NULL pointer dereference when calling .name=
()
or .events()?

[Severity: Medium]
This isn't a bug introduced by this patch, but I noticed a leak in
pyrf_evsel__read() on its error paths:

tools/perf/util/python.c:pyrf_evsel__read() {
    count_values =3D PyObject_New(struct pyrf_counts_values,
                                &pyrf_counts_values__type);
    if (!count_values)
        return NULL;

    if (!PyArg_ParseTuple(args, "ii", &cpu, &thread))
        return NULL;

    cpu_idx =3D perf_cpu_map__idx(evsel->core.cpus, (struct perf_cpu){.cpu =
=3D cpu});
    if (cpu_idx < 0) {
        PyErr_Format(PyExc_TypeError, "CPU %d is not part of evsel's CPUs",=
 cpu);
        return NULL;
    }
    ...
}

Does returning NULL directly on argument parsing or bounds checking failures
leak the newly allocated count_values object? Should we call
Py_DECREF(count_values) before returning?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623053515.2677=
888-1-irogers@google.com?part=3D12
