Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15FAA2E717B
	for <linux-perf-users@vger.kernel.org>; Wed, 24 Jun 2026 05:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782279063; cv=none; b=riR4LS9kv+CsBtj1tgf1ShwAyXGb4Fz0IMa60DuQ7RH4wAtm/hNNirqy65Ke/QXsdEGYTiSjiY5/cedjF2qDiSQhBO3OMUQfB0cjrgfY9J0neCn3nbRzA1i10jEdSNI1dBKwZBFy3JxVIKKgcrcXkDiFaKMzjHxt77IFV6alcWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782279063; c=relaxed/simple;
	bh=Kpa/TaV4WL8GKF/jj8xQCP4+fGS1q3VdZgFzIs77dnU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hbjxhixXqD+AoIOIkaUl+Riu/vwT3/v966CNM6SWxjWJrncfxM81DV4JT5OUTZxTRi724TR5PMvwunOrIl3dcVZwjGCROSHnnlP/ChFb8i5iKl6fv1MvlRPkS9KGIlX58hpgU3T72CDdL9pRrwAO0XXnoIvZsVL0V71MUBUER84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R/kp/In0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R/kp/In0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C13721F000E9;
	Wed, 24 Jun 2026 05:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782279061;
	bh=D3zFYRcxsDItbc0WBPYyrkQjsyEvWygIEEhig+0nOYI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=R/kp/In0SEZAri7WfuGi1Vhi3VyX2KGTscdycM3X0dFy5ze41bHjhoo4/VBQHjmwu
	 3vlnGzpACCz6mlQthHFkyfHfid9paaWjcyDP9n4+JggsTz8JkEo2ZC2dKg63NISH1q
	 ju2hJ/HqDhB4e0kDgEfSlvYJ1++g293Q3LKVdohLJDYbN9HeKIafxljubXQKK5nFFI
	 8KSx1P5uXypRJ5BFq2FPF7e6CNtvVeroxUaJ08huHxHwLE1vKXSSQulPip4NQaT5ME
	 03pQp7ZFg4+R4+zVQuqUuh1gcgD92cMPnI8FZs4WSC8H6jJI+i+gy9yrW3ygCWkmY0
	 M0nsXhrQcpQ7w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 10/16] perf python: Validate attribute setters in
 pyrf_evsel
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260624051535.3584977-12-irogers@google.com>
References: <20260623053515.2677888-1-irogers@google.com>
 <20260624051535.3584977-1-irogers@google.com>
 <20260624051535.3584977-12-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Jun 2026 05:31:01 +0000
Message-Id: <20260624053101.C13721F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Medium] Missing NULL check for attribute deletion in `pyrf_counts_values=
_set_values` causes a segmentation fault.
--

commit 921733bf92d5e6634715543526c3d25b8346f3c3
Author: Ian Rogers <irogers@google.com>

perf python: Validate attribute setters in pyrf_evsel

This commit adds NULL checks to attribute setters in pyrf_evsel to
ensure an error is correctly reported instead of setting a garbage
value when attempting to delete an attribute.

> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index 4bf37e2afb18d..657b054f5e515 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
[ ... ]
> @@ -2296,6 +2296,11 @@ static int pyrf_evsel__set_tracking(PyObject *self=
, PyObject *val, void *closure
> =20
>  	CHECK_INITIALIZED_INT(pevsel->evsel, "evsel");
> =20
> +	if (val =3D=3D NULL) {
> +		PyErr_SetString(PyExc_TypeError, "cannot delete attribute");
> +		return -1;
> +	}
> +
>  	is_true =3D PyObject_IsTrue(val);
>  	if (is_true < 0)
>  		return -1;

[Severity: Medium]
This is a pre-existing issue, but since you are fixing these attribute
deletion issues in pyrf_evsel, should we also fix
pyrf_counts_values_set_values in the same file?

Looking at pyrf_counts_values_set_values, the list parameter is passed
directly to PyList_Check without verifying if it is NULL:

static int pyrf_counts_values_set_values(struct pyrf_counts_values *self,
					 PyObject *list, void *closure)
{
	Py_ssize_t size;
	PyObject *item =3D NULL;

	if (!PyList_Check(list)) {
		PyErr_SetString(PyExc_TypeError, "Value assigned must be a list");
		return -1;
	}

Could deleting the counts_values.values attribute from a Python script
trigger a segmentation fault here?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260624051535.3584=
977-1-irogers@google.com?part=3D10
