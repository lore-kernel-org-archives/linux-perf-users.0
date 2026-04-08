Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85EE139C004
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Apr 2026 08:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775636423; cv=none; b=ebPXs4IXMrMMLd8nrvpH+4U9kRS6m9zYLFTX9rLDJkfMBXZoakv/m7CX2/a4NqlHdaeYj9f0NCrk0Gm4FJKImIDBb/Drg0wFSeLMk8r8NWIhMmbR6EZ5LAKyt3ExuxY9FtaAMTN9MzLWaIxz4qnZkPggm1dqxynOGcGdZnkhmKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775636423; c=relaxed/simple;
	bh=2+ROGsVGY/I/OlY42iV7SK3ByRc7wgOy72lncx7B/VQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=T0GKPkTflH4dA59diFKZoZl1HZHo7eYJQCr6NQcj/69JMSPxjyq3pyyt7G0JGmE4Na+V5z7XBxlD4X4YdO86tpyU/GE82XIzPKgp4rqtF5JeWHS5FCm5Yo92B4hpYgH7xVO2+2B9qitPsam8FgOqSRogJEP152UmJeusWDGDyo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LQTBJqfJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LQTBJqfJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41F14C2BCB3;
	Wed,  8 Apr 2026 08:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775636423;
	bh=2+ROGsVGY/I/OlY42iV7SK3ByRc7wgOy72lncx7B/VQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=LQTBJqfJFnmmw40sG0scGEX7n33ekixfibkgnlwrZSZrwYynE0iuKHvd1yCdDiDh0
	 vIYTGj6RL/bD1oySXtJ7EJXkvkWmVT9Hoe3ayKMiLO7kaaUngz6AS6VOPRd+09lxF2
	 cWJKV9LyvK96tSK5FtQb05i1spvyxbGLPmIIuU/a4LD5Jx7T4e1oDYUsqwHVSPBvvX
	 9PsLOsk3k9KNKPdf03qkl2vc4Gwl4UOH39ADMFsIH89WXh1RmtK11fTLiIpoaJCkw3
	 nfGJvBxwaUKyhCMKChlKG3yfO+TOwvhxPyio+/3SmRkFV2fsvqVT4m1J1br6+bIT7T
	 AQwphcUWNDVxA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 03/23] perf evsel: Refactor evsel tracepoint sample
 accessors perf_sample
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260408072601.210837-4-irogers@google.com>
References: <20260408072601.210837-4-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Apr 2026 08:20:22 +0000
Message-Id: <20260408082023.41F14C2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Medium] Integer overflow and incomplete validation in the newly added tr=
acepoint bounds checks allow out-of-bounds memory accesses.
--

commit f7dda507e65d40381a27ba2e39e45e8a6050afff
Author: Ian Rogers <irogers@google.com>

perf evsel: Refactor evsel tracepoint sample accessors perf_sample

This commit refactors tracepoint sample accessors to remove the evsel
argument. It also adds bounds checks when reading values from tracepoint
fields based on review feedback.

> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 2ee87fd84d3ea..b653e683d7a12 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -3687,15 +3687,20 @@ struct tep_format_field *evsel__common_field(stru=
ct evsel *evsel, const char *na
>  	return tp_format ? tep_find_common_field(tp_format, name) : NULL;
>  }
> =20
> -void *evsel__rawptr(struct evsel *evsel, struct perf_sample *sample, con=
st char *name)
> +void *perf_sample__rawptr(struct perf_sample *sample, const char *name)
>  {
> -	struct tep_format_field *field =3D evsel__field(evsel, name);
> +	struct tep_format_field *field =3D evsel__field(sample->evsel, name);
>  	int offset;
> =20
>  	if (!field)
>  		return NULL;
> =20
>  	offset =3D field->offset;
> +	if ((u32)(offset + field->size) > sample->raw_size) {
> +		pr_warning("Invalid trace point field offset %d for field of length %d=
 in sample raw data of size %u\n",
> +			   offset, field->size, sample->raw_size);
> +		return NULL;
> +	}

Can this bounds check be bypassed due to integer overflow? If a malformed
perf.data file provides an exceptionally large offset (for example,
0xFFFFFFFC) and a size of 4, the sum could wrap around to 0. Would this
allow an out-of-bounds read when accessing the memory?

>  	if (field->flags & TEP_FIELD_IS_DYNAMIC) {
>  		offset =3D *(int *)(sample->raw_data + field->offset);
>  		offset &=3D 0xffff;
>  		if (tep_field_is_relative(field->flags))
>  			offset +=3D field->offset + field->size;
>  	}
>=20
>  	return sample->raw_data + offset;

Is the dynamically computed offset validated against sample->raw_size? It
appears the initial check covers the initial field offset, but the newly
computed offset for dynamic fields is added directly to sample->raw_data
without a subsequent bounds check, which might lead to out-of-bounds memory
accesses.

[ ... ]

> @@ -3713,6 +3718,12 @@ u64 format_field__intval(struct tep_format_field *=
field, struct perf_sample *sam
>  	u64 value;
>  	void *ptr =3D sample->raw_data + field->offset;
> =20
> +	if ((u32)(field->offset + field->size) > sample->raw_size) {
> +		pr_warning("Invalid trace point field offset %d for field of length %d=
 in sample raw data of size %u\n",
> +			   field->offset, field->size, sample->raw_size);
> +		return 0;
> +	}
> +

Can this suffer from the same integer overflow issue? If field->offset and
field->size wrap around when added together, it looks like an out-of-bounds
pointer could be dereferenced when evaluating the field.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260408072601.2108=
37-1-irogers@google.com?part=3D3
