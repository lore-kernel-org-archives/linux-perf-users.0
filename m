Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4513264F5
	for <linux-perf-users@vger.kernel.org>; Sat, 11 Apr 2026 07:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775892230; cv=none; b=nIfA4xxGK9MZV+8XEZTspvVW/QxaGfolWYG4Q7HnQ6ZSvPGymE2Prn0UrUe2Qw2g/xrJNiIQUFbZe2dNJFeDA6sR+khVImWCiBeofQtaL4Y9dt3QOjr34nmk1mGEKFmsYznxqV+zloyN6TYrxyhu1mFOlXMuWGDnLXlKu9z4vxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775892230; c=relaxed/simple;
	bh=QoK4J9n3ZBCC3/gn0MwcRwBbhEdtWIhu6svmgXIkPWg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aJy6QVIo3WDJncx3237/45gJnUHvdBz1uTA69Jylgsqy4mHQ/IOv21+rAtEX42Bor8ccWkEe1KgUcEMtO5mn7+ftIGP6rCZ0W4dgJdy1nXMU6gAboLzNVhyG5FG8peMsnfd3qzl55r6dHQDD1EFYkF/jJiaMZaC/7rysCrVSNNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=diRqs18O; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="diRqs18O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4B56C4CEF7;
	Sat, 11 Apr 2026 07:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775892229;
	bh=QoK4J9n3ZBCC3/gn0MwcRwBbhEdtWIhu6svmgXIkPWg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=diRqs18ODp/zBGdamgM3eD+CTG3irev+jSfxwrlGQTzagNLb+9GU/V1sSX3+aNzKa
	 RHebk41LM3elJ3+pSMi+heWZOAOxPi/ywsj11h57XstfUmMUgLKL137Uw55t/OPlyu
	 xQxy5WtcVrU2tcPO0aRePLzDwZs5JK6rQyJO5cEj0/b/Xqk8UOPnh1rtzPSeGRnXp7
	 bZSF7MbboeMDaeFZdKtKupL1UzL93m2rqEDHD8rv8ncCui5VQvAeyTJ04Qw69GUDgs
	 ZIFuG4YADmKG8Pbp4H794A5TXnkXja0+6YHwlpuXYgyPr5UnVnFo4Ez8hPlBCKlIyu
	 ZIvUpt1oFIH1Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 27/29] perf evsel: Add bounds checking to trace point
 raw data accessors
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260411065718.372240-28-irogers@google.com>
References: <20260411065718.372240-28-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 11 Apr 2026 07:23:49 +0000
Message-Id: <20260411072349.B4B56C4CEF7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 3 potential issue(s):
- [High] The newly introduced bounds checks are vulnerable to integer under=
flow, allowing a bypass that leads to out-of-bounds memory reads.
- [High] The bounds checking for dynamic fields is incomplete; the dynamica=
lly extracted offset is never validated against the sample size.
- [High] Out-of-bounds read when extracting the dynamic field locator.
--

commit 1b7f3d71f64676dc31522be7af5f5e046cadffb3
Author: Ian Rogers <irogers@google.com>

perf evsel: Add bounds checking to trace point raw data accessors

Avoid a tracepoint field accidentally reading out of bounds by
checking the size of read fits.

> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 3c10b840778e0..1e0bb4cb995d4 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -3727,6 +3727,11 @@ void *perf_sample__rawptr(struct perf_sample *samp=
le, const char *name)
>  		return NULL;
> =20
>  	offset =3D field->offset;
> +	if ((u32)(offset + field->size) > sample->raw_size) {

Since offset is a signed integer, could a negative offset bypass this check?

If a negative offset and a positive size are provided (e.g., offset =3D -4,
size =3D 8), their sum could be a small positive number that passes the
> sample->raw_size check, leading to an out-of-bounds read before the
start of the buffer.

> +		pr_warning("Invalid trace point field offset %d for field of length %d=
 in sample raw data of size %u\n",
> +			   offset, field->size, sample->raw_size);
> +		return NULL;
> +	}
> =20
>  	if (field->flags & TEP_FIELD_IS_DYNAMIC) {
>  		offset =3D *(int *)(sample->raw_data + field->offset);

Does this 4-byte read have a bounds checking issue if field->size is less
than 4?

If the field is placed at the very end of sample->raw_data with a size of 2,
the earlier check would pass, but this would read 2 bytes out of bounds.

>  		offset &=3D 0xffff;
>  		if (tep_field_is_relative(field->flags))
>  			offset +=3D field->offset + field->size;
>  	}
> =20
>  	return sample->raw_data + offset;

Should this dynamically extracted offset be bounds checked against
sample->raw_size before returning the pointer?

Callers like perf_sample__strval() dereference the returned pointer,
which could result in an out-of-bounds read if the extracted offset is
beyond the sample size.

>  }
> =20
> @@ -3744,6 +3749,12 @@ u64 format_field__intval(struct tep_format_field *=
field, struct perf_sample *sam
>  	u64 value;
>  	void *ptr =3D sample->raw_data + field->offset;
> =20
> +	if ((u32)(field->offset + field->size) > sample->raw_size) {

Could this check also be bypassed by a negative field->offset, similar to
the check in perf_sample__rawptr() above?

> +		pr_warning("Invalid trace point field offset %d for field of length %d=
 in sample raw data of size %u\n",
> +			   field->offset, field->size, sample->raw_size);
> +		return 0;
> +	}
> +
>  	switch (field->size) {
>  	case 1:
>  		return *(u8 *)ptr;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260411065718.3722=
40-1-irogers@google.com?part=3D27
