Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9ED336EF8
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 08:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781512730; cv=none; b=Bwf187BGG85JYdO1klBVCombugTsMcd+nBH0bHBgI/DMrYIKRRLLlvVAHw5LDyhyR8dIjQpcm+N97TfG7Q1UlsgpLVVQcjC4VCgCU4fgioDT7x0b3+THREjQgDKX9Xk0j00c2/kg5Y2fHeH59dvn8DSuy098PKFx8aGBWv9sHTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781512730; c=relaxed/simple;
	bh=eaqTn1ySiELXDWP8i2z6U6Pr+zmLw/ofvFbb9iPrPwM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kk7s4zo0AtKDDVewy2hJsTALI5+75Ho6rAVH+sqsc9KZmbK46wDKbja8bZmZ4wVkCj5FYP/wp0s6MlShE4XRJYlw+uwbpBBz98cvJXWGi9683r0sP6AXsDAoP4TcfXWaMBud2zN20DOWcfj/YSQ5YyRS/YtYD4GQhTC3rG/xvs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jPfAafaq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jPfAafaq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 221301F000E9;
	Mon, 15 Jun 2026 08:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781512729;
	bh=zsQ8eTtt/iXNNpxKn4RE916+5dtGo2lY6OlKm7fhW80=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jPfAafaqkXpKvO7JtFm3yS09FFdhM8GXZzyW3TRQ7F16UpiVCjMTr5RtbSfWfIOHl
	 ShGvooT4+ctMbGdNMXie6OhhZ4gTFMRH86AylORTcynxKQg6F5y3naQx2IXCX4oEpU
	 YMjUcr461xFJVOpzKxE/afuAgNCyni3sSIWOi7VEyaguTygXCwpxMfQ9xDFrbtyjUb
	 K6k0Tjm529BIFR83gBsnOX93pvMrhELYkZApzuMWnDab9q4AcIzN+Xypa5W/qewVUI
	 GNSVO36MG5vXDKzah3pgmQGqktcjh4ABEbalppprigF27kwP7WVn4cEsYI0nI9tco3
	 YlXkA84NaT7CQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 06/20] perf evsel: Add reference count
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260615061631.2382079-7-irogers@google.com>
References: <20260615061631.2382079-7-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 08:38:48 +0000
Message-Id: <20260615083849.221301F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Python property setters for evsel attributes permanently corrupt t=
he internal struct on invalid input and crash or raise SystemError on attri=
bute deletion.
- [Medium] Python setter methods for 32-bit evsel attributes silently trunc=
ate out-of-bounds integers on 64-bit systems.
--

commit ad5ce8c891f5b3b4168d57e6970426e1f5a8635e
Author: Ian Rogers <irogers@google.com>
Subject: perf evsel: Add reference count

As with evlist this a no-op for most of the perf tool. The reference
count is set to 1 at allocation, the put will see the 1, decrement it
and perform the delete. The purpose for adding the reference count is
for the python code. Prior to this change the python code would clone
evsels, but this has issues if events are opened, etc. leading to
assertion failures. With a reference count the same evsel can be used
and the reference count incremented for the python usage.  To not
change the python evsel API getset functions are added for the evsel
members, no set function is provided for size as it doesn't make sense
to alter this.

> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index 7483741c024a5..5482b68b8c0b3 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
[ ... ]
> +static int pyrf_evsel__set_tracking(PyObject *self, PyObject *val, void =
*closure __maybe_unused)
> +{
> +	struct pyrf_evsel *pevsel =3D (void *)self;
> +	int is_true;
> +
> +	CHECK_INITIALIZED_INT(pevsel->evsel, "evsel");
> +
> +	is_true =3D PyObject_IsTrue(val);

[Severity: High]
Does this code handle the case where a user deletes the attribute? If a user
calls del evsel.tracking, Python passes a NULL val to the setter. Passing
a NULL val directly to PyObject_IsTrue will crash the interpreter. Could
we add a NULL check for val here and in the other setters?

> +	if (is_true < 0)
> +		return -1;
> +
> +	pevsel->evsel->tracking =3D is_true;
> +	return 0;
> +}
> +
> +static int pyrf_evsel__set_attr_config(PyObject *self, PyObject *val, vo=
id *closure __maybe_unused)
> +{
> +	struct pyrf_evsel *pevsel =3D (void *)self;
> +
> +	CHECK_INITIALIZED_INT(pevsel->evsel, "evsel");
> +
> +	pevsel->evsel->core.attr.config =3D PyLong_AsUnsignedLongLong(val);

[Severity: High]
Can this corrupt the underlying struct if val has an invalid type? The
result of PyLong_AsUnsignedLongLong(val) is assigned directly to the struct
before checking PyErr_Occurred(). If val is invalid, the API returns -1,
which permanently overwrites config with all 1s even though an exception is
raised. Should we store the result in a temporary variable and only assign =
it
on success?

> +	return PyErr_Occurred() ? -1 : 0;
> +}
[ ... ]
> +static int pyrf_evsel__set_attr_type(PyObject *self, PyObject *val, void=
 *closure __maybe_unused)
> +{
> +	struct pyrf_evsel *pevsel =3D (void *)self;
> +
> +	CHECK_INITIALIZED_INT(pevsel->evsel, "evsel");
> +
> +	pevsel->evsel->core.attr.type =3D PyLong_AsUnsignedLong(val);

[Severity: Medium]
Will this silently truncate out-of-bounds integers on 64-bit systems?
PyLong_AsUnsignedLong() returns a 64-bit unsigned integer on 64-bit platfor=
ms,
but attr.type and attr.wakeup_events are 32-bit (__u32) fields. Values
exceeding 32 bits might be silently truncated without raising an OverflowEr=
ror,
unlike the previous T_UINT member definitions.

> +	return PyErr_Occurred() ? -1 : 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615061631.2382=
079-1-irogers@google.com?part=3D6
