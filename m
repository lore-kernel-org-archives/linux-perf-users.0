Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A6437B3F2
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Jun 2026 22:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781303133; cv=none; b=VnshZ8NpTMzBlHK8gULWumFZF33bME2+ARW53BWtYToFAzUgWTshrNqSLGGljEVFNYXk8WgIbdEDKw30gh8Pswbt8EVQg6n/dphEsDpGzNhDNMFT3+Nh80rAna8BDtsetMjP87Q12+IUrqdAmoaZ21Bg4/au8lOMnFnGcfkoFj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781303133; c=relaxed/simple;
	bh=G/h2mAfCNqwvgRpTjZMLfLKcVKDJSeWZ8QoowSCrr0w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FlkrvKbs7l3z4mfBpWwz9dnNK3lDH8hq/RW58PB0BE7IjVqfsamgpxYUUyapS4QUvXUpxmEi+CuVsb6/HNQu19A34Zff1Omu1IO76pKO6chmWsIlrVNett35lykjrfcrnuPVs3mY6Y/ULfueDAQJZbdu5BwSoYB3Y/IQy2IYaI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WEaB01JT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WEaB01JT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C32731F000E9;
	Fri, 12 Jun 2026 22:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781303132;
	bh=q4g3tiIk0TggFrdiGyBemCjKmFJzj3CA1Bb/bRzjsjU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WEaB01JTg4kcLq9Vc4iLBcqMWVLKBksib/cJL18TUJZJ0Cs2FsoqGIQFaDC/FHQrn
	 iHwVAQU91/lS2MQmtgnDox/VHGl9GmGcs8913OMUSQs+jSaJBkkdxTAp+yq7Ijbcux
	 uq9jyQTRd6WWV1gQi/f43oOKkNWWrNIDT+BFt2qJf6Vjofm5gs/bWfVRlGPhq04Unh
	 KE4tvc4HI5xYHScbBVci4CG2bYupxpln/Zb2nU5C9DocE4g4Zim3g+TyEx93s5GJps
	 BOgm0mhjgsXWDjc9karmWggsDbE7ajPY9nFMRJ7904RI0y865aKISzFQdOY7E2EFgX
	 A90kaolcZGbAQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 02/19] perf python: Add missed explicit dependencies
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260612221211.1221305-3-irogers@google.com>
References: <20260612221211.1221305-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 22:25:31 +0000
Message-Id: <20260612222531.C32731F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] The `pyrf_counts_values_set_values` function does not validate=
 the size of the Python list before writing into the fixed-size `values` ar=
ray, leading to a heap buffer overflow.
- [High] Functions accepting `perf.cpu_map` and `perf.thread_map` Python ob=
jects use the generic `O` format specifier without type validation, leading=
 to Type Confusion and potential memory corruption.
--

commit aae79d4d4c46ff069bf5908d4883c3da0d206df7
Author: Ian Rogers <irogers@google.com>

perf python: Add missed explicit dependencies

Fix missing #include of pmus.h found while cleaning the evsel/evlist header
files. Define PY_SSIZE_T_CLEAN before including Python.h to comply with
modern Python 3 C-API requirements, and introduce CHECK_INITIALIZED and
CHECK_INITIALIZED_INT safety macros.

> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index cc1019d29a5d0..98a8dd9b673de 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c

[ ... ]

> @@ -38,6 +45,22 @@ PyMODINIT_FUNC PyInit_perf(void);
>  	  offsetof(struct pyrf_event, sample) + offsetof(struct perf_sample, me=
mber), \
>  	  0, help }
> =20
> +#define CHECK_INITIALIZED(ptr, msg) \
> +	do { \
> +		if (!(ptr)) { \
> +			PyErr_SetString(PyExc_ValueError, msg " not initialized"); \
> +			return NULL; \
> +		} \
> +	} while (0)
> +
> +#define CHECK_INITIALIZED_INT(ptr, msg) \
> +	do { \
> +		if (!(ptr)) { \
> +			PyErr_SetString(PyExc_ValueError, msg " not initialized"); \
> +			return -1; \
> +		} \
> +	} while (0)
> +

[Severity: Critical]
This is a pre-existing issue, but I noticed a potential buffer overflow in
pyrf_counts_values_set_values():

tools/perf/util/python.c:pyrf_counts_values_set_values() {
	size =3D PyList_Size(list);
	for (Py_ssize_t i =3D 0; i < size; i++) {
		item =3D PyList_GetItem(list, i);
		// ...
		self->values.values[i] =3D PyLong_AsLong(item);
	}
}

The values array embedded in struct pyrf_counts_values has exactly 5 elemen=
ts.

Could a user provide a Python list with more than 5 elements and write past=
 the
end of the allocation, corrupting the heap?

[Severity: High]
This isn't a bug introduced by this patch, but the PyArg_ParseTuple type
handling seems unsafe in several functions like pyrf_evsel__open():

tools/perf/util/python.c:pyrf_evsel__open() {
	if (!PyArg_ParseTupleAndKeywords(args, kwargs, "|OOii", kwlist,
					 &pcpus, &pthreads, &group, &inherit))
		return NULL;

	if (pthreads !=3D NULL)
		threads =3D ((struct pyrf_thread_map *)pthreads)->threads;
}

Similar casts occur in pyrf__parse_events() and pyrf__parse_metrics() where
the 'O' format is used without type validation.

Since 'O' accepts any Python object, what happens if an invalid object type
like an integer or string is passed here?

Can this cause the C extension to interpret arbitrary Python objects as
struct pyrf_thread_map pointers and dereference them? Could we use the 'O!'
format specifier instead to enforce the type constraint?

>  struct pyrf_event {
>  	PyObject_HEAD
>  	struct evsel *evsel;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612221211.1221=
305-1-irogers@google.com?part=3D2
