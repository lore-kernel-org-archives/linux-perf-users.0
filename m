Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969FA39B4AE
	for <linux-perf-users@vger.kernel.org>; Wed, 24 Jun 2026 07:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782286223; cv=none; b=RplVDBw94BAe8czipJ+8lr+ABZSASIzETAQTdaAP8v/bxG8DBIfafz9csuzLNb/DbQh7TOqZ9nrzt8bPCXA6ud7rdThnOdVZtraaKD/aWvQH+RUk0yVLM4arysbWFq7ml/pzYQlvHv3T41Lq9/iRh/wr55zSfXu0c08ujl3gtS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782286223; c=relaxed/simple;
	bh=FJKAS8tMx9tRVH/SSTzE8UTqlAmkB5vLMJ+Xy7em+2A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=P5hGaT0//FZFNjdBAqJ6ylVQOu5MmvU3kFYU6JKztbL5kIbWNBLyWAbx7ZixFs+Da2Z3vK1/ubc+EOYcDEwS/GuvLHSSwh9Fzm0kRENfovP0pPaCMIHu7x6iT6EoC60SrWJGZcWajxepPyUjbK4NdDkHpGNQs6FHbXMWygwPL5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CJTvpos5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CJTvpos5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD8D81F000E9;
	Wed, 24 Jun 2026 07:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782286221;
	bh=DOmsOncKB19qd/OQbqqFGPtwLyjP+dcx/WJty6reCms=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CJTvpos5U7ac6YdvNQ09TDmRdLljHF/TIy7FA2MvKBlB1xfQ6cATNNoXzEKnqa/EY
	 JpHVf81wkUVcnlmf4Qe2gdNODkCMN9KTGDwYBiORA/5o1+7gQvmEZEbsa7qScPzEN+
	 SF7tu8CGLBUkSBx8wELue4abmoocmW4NgPKavocdgqQrW/Cvv3SkuiH6TO0rkriz+L
	 SpMu0MjI1WnRMVeiLHRPbwdB7//FRqk/V3MpT5QUOZgZri43zn7fX7LozIUDrp/xjP
	 dEWdz/qo8EDxX/WIDY/n0OKfQPsvXT5Ijsa6n//aBz5Wbytmu9r+RQm6VfodBXdHrE
	 zlVUA5Dva25Cg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 08/16] perf python: Check counts_values size in
 set_values
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260624051535.3584977-10-irogers@google.com>
References: <20260623053515.2677888-1-irogers@google.com>
 <20260624051535.3584977-1-irogers@google.com>
 <20260624051535.3584977-10-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Jun 2026 07:30:20 +0000
Message-Id: <20260624073020.CD8D81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Deleting the `values` attribute from a `perf.counts_values` object=
 in Python causes a segmentation fault.
- [Medium] The function `tracepoint_field` truncates 64-bit tracepoint fiel=
ds on 32-bit platforms by casting them to `unsigned long` or `long`.
--

commit d69dc2f4b8c6d442757f85756430758b037c2521
Author: Ian Rogers <irogers@google.com>

    perf python: Check counts_values size in set_values
   =20
    The set_values function incorrectly assumed the list contained exactly
    5 elements. Add a check to prevent out-of-bounds access.

> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index 550f1e7d14499..c6c729808a0f2 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
[ ... ]
> @@ -1913,13 +1920,23 @@ static int pyrf_counts_values_set_values(struct p=
yrf_counts_values *self, PyObje
>  	}
> =20
>  	size =3D PyList_Size(list);

[Severity: High]
This isn't a bug introduced by this patch, but does=20
pyrf_counts_values_set_values() crash if the list parameter is NULL?

If a user deletes the attribute in Python (e.g., `del counts_values.values`=
),
the list parameter will be passed as NULL. The PyList_Check(list) macro cal=
led
just before this line unconditionally dereferences the pointer, which would
trigger a segmentation fault.

> +	if (size !=3D 5) {
> +		PyErr_SetString(PyExc_ValueError, "List must have exactly 5 entries");
> +		return -1;
> +	}
> +
>  	for (Py_ssize_t i =3D 0; i < size; i++) {

[ ... ]

[Severity: Medium]
This is also a pre-existing issue, but could tracepoint_field() truncate 64=
-bit
values on 32-bit platforms?

In tools/perf/util/python.c:tracepoint_field():

		val =3D tep_read_number(pevent, data + field->offset,
				      field->size);
		if (field->flags & TEP_FIELD_IS_POINTER)
			ret =3D PyLong_FromUnsignedLong((unsigned long) val);
		else if (field->flags & TEP_FIELD_IS_SIGNED)
			ret =3D PyLong_FromLong((long) val);
		else
			ret =3D PyLong_FromUnsignedLong((unsigned long) val);

Since val is returned by tep_read_number(), which provides a 64-bit value,
casting it to unsigned long or long drops the top 32 bits on 32-bit
architectures. Does this lead to silent data corruption for 64-bit tracepoi=
nt
fields like timestamps or counters?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260624051535.3584=
977-1-irogers@google.com?part=3D8
