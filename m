Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D56EAC7
	for <linux-perf-users@vger.kernel.org>; Sat, 11 Apr 2026 19:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775936816; cv=none; b=dIjZ5c8FFs76dCOMoL2F5K60/KATrQsMdtHdcBKT8U22fMvSTWzGGwWtgstCYfWDLQBG+2gvR0h06TEk01nSfR5ivZ5BwPclKVH9+nV+NEW7N+XWEM8fvOklwYXXpSGFM6W6+heWlQkBhmpiv4/oQVqTVfeZtrLmrJ7hzLpx+mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775936816; c=relaxed/simple;
	bh=+KUEJzEATMn9tFM4+JQC+NDikXwrnbBzwb/qyi2qTUk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=L5vfAxLUwg48M5vzZaEXy44Qs/YPr9pak0/po7zHXwKQFB6qySnWOZQz6RhW1tmkBlL7+w3c1EkAG/P7GGsm3O3HGT5ANTEA/tDm2him/MEYponTrQwclL2tqEbyAcfTnrilt0wjcOesoblL3f5Kjj3tmx1qHOYMFHoLn4e6Fac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eWv9+8Eg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eWv9+8Eg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8456C2BCAF;
	Sat, 11 Apr 2026 19:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775936815;
	bh=+KUEJzEATMn9tFM4+JQC+NDikXwrnbBzwb/qyi2qTUk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=eWv9+8Eg4HdEkC63ZPpMinFIHpdzhbdrOsulU9s7jPvJ3U+PCvr0cPX6+ZWDO+Ava
	 /SQHUONssH9kCl+9V6aI4XJz3Za0AwLkX4QN9LTCzgM+N/48UHz6nFQLdViqzcbTFH
	 3gkdkNCD38tMACtagSUfV8F030JDD/Q7L6nkIe+kOuKII85/XfqW+gvIC0sSpsajPm
	 broFAFtP8qW2uZkmn1iAWE8JFC5EZ2lRI5YT5nzaJ25/SztpY4Sa5J9EC7W3eCMaZ8
	 Ck88+QST55vSRTUu3FL+6XVz3CxtFI8h4wsriwLg4z/+wHdVyqb6GlX5ds4ZdNJ/ip
	 RcNUrWEcriiXQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 27/29] perf evsel: Add bounds checking to trace point
 raw data accessors
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260411191710.524998-28-irogers@google.com>
References: <20260411191710.524998-28-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 11 Apr 2026 19:46:55 +0000
Message-Id: <20260411194655.B8456C2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 3 potential issue(s):
- [High] Signed integer overflow and negative values in bounds checks allow=
 bypassing the validation.
- [High] Missing bounds check for dynamically calculated tracepoint field o=
ffsets.
- [Medium] Out-of-bounds read when reading 4-byte dynamic locator for field=
s with small size.
--

commit 8563f2e510681f1e4e478ac7a9580f239b46c49b
Author: Ian Rogers <irogers@google.com>

perf evsel: Add bounds checking to trace point raw data accessors

This commit adds bounds checking for tracepoint field access in perf's evsel
logic to avoid out-of-bounds reads. It checks that the field's offset and s=
ize
do not exceed the raw data size of the sample.

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

Could this overflow or wrap around? Both offset and field->size are signed
integers. If offset is negative and field->size is positive, their sum might
be a small positive number that passes the sample->raw_size check, but would
result in an out-of-bounds pointer calculation.

Similarly, could very large positive values overflow the 32-bit addition and
bypass the check?

> +		pr_warning("Invalid trace point field offset %d for field of length %d=
 in sample raw data of size %u\n",
> +			   offset, field->size, sample->raw_size);
> +		return NULL;
> +	}
> =20
>  	if (field->flags & TEP_FIELD_IS_DYNAMIC) {
>  		offset =3D *(int *)(sample->raw_data + field->offset);

Can this lead to an out-of-bounds read if field->size is less than 4?
The initial bounds check validates field->size, but if the field is dynamic
and field->size is less than sizeof(int), this dereference will read past
the validated bounds.

>  		offset &=3D 0xffff;
>  		if (tep_field_is_relative(field->flags))
>  			offset +=3D field->offset + field->size;
>  	}
> =20
>  	return sample->raw_data + offset;

Does this dynamically calculated offset need its own bounds check?
If the field is dynamic, offset is reassigned but never validated against
sample->raw_size before returning the pointer, which could allow a crafted
sample to return an out-of-bounds pointer.

[ ... ]

> @@ -3744,6 +3749,12 @@ u64 format_field__intval(struct tep_format_field *=
field, struct perf_sample *sam
>  	u64 value;
>  	void *ptr =3D sample->raw_data + field->offset;
> =20
> +	if ((u32)(field->offset + field->size) > sample->raw_size) {

As above, can field->offset and field->size contain negative values or
overflow the 32-bit addition, potentially bypassing this bounds check?

> +		pr_warning("Invalid trace point field offset %d for field of length %d=
 in sample raw data of size %u\n",
> +			   field->offset, field->size, sample->raw_size);
> +		return 0;
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260411191710.5249=
98-1-irogers@google.com?part=3D27
