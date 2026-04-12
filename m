Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32BE8C1F
	for <linux-perf-users@vger.kernel.org>; Sun, 12 Apr 2026 02:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775961261; cv=none; b=GUa5HsOtvFu0whYFN/aju1vX37HtqbgijMTNrI2EOhMnQvzTNFWapEvY38sEI7IXVz75JpkReFETWbcC00KS/FUwh4Q7dB4fmaENCGKDQmbnDNyCtRgY8NHYyPHoUWE9/7vhh4d0ZVYe4cjt61in+X0Q+KnVrDGUOUdZGu9C2MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775961261; c=relaxed/simple;
	bh=6q06B41/ch8BIA15OgxspakSpAqHMwwZyW7lZTaGoR0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Y+Ym8ASLGJmaHMCcPK7d9hWsrJ14yOwJ8REFdXvs/28slyjbxTs4SSncGbSUTGMeRKm/VQSE4gIVRu1PmPtHiOz5VlYjMct0m2CQKqOCNr8ZKjuxfy3P2qxDaFdr7OpB1Y1DdkwCQ1zyhGYSNV0lmqggK4s3jfOrGozmZYQnugg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=em9CJURU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="em9CJURU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF86FC116C6;
	Sun, 12 Apr 2026 02:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775961261;
	bh=6q06B41/ch8BIA15OgxspakSpAqHMwwZyW7lZTaGoR0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=em9CJURU5ECOvJOeuQyheR8jk71EHvPqQYE7PFfQbC0J0BhLLCxUkJ5D7wyvxlFON
	 vBeZYEnK1e/Q3PqgmOoLyQ277ja3tNOGlRWKAzU0uCsr3zoj5D8Yz2UgFuq6Ht/ZhX
	 lun3EPbeYGKz2OYW55LnPfgYZyrhxZZ9tsclHbb4/vkTp41fxVXolT8ikY1vaF57ne
	 8uaQnTLBwZQDptcB1/LHy5yEclcjIqg8SN5OyMHLl6KvQpY988U5HsbeiEkNIm6PEj
	 Qe+VqUXm6gmqrFsNezV+7O2vAkobyRHPpT5CBjlQB7EOrTsBAsb7AnIh2mRUWVNvfl
	 bH9LD6rXq9XCw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 27/29] perf evsel: Add bounds checking to trace
 point raw data accessors
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260412020833.641177-28-irogers@google.com>
References: <20260412020833.641177-28-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 12 Apr 2026 02:34:20 +0000
Message-Id: <20260412023420.EF86FC116C6@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 4 potential issue(s):
- [High] Missing bounds check for the computed offset of dynamic fields in =
`perf_sample__rawptr`.
- [High] Integer underflow/overflow in the newly added bounds checks allows=
 bypass and out-of-bounds reads.
- [High] Unconditional 4-byte memory read for dynamic fields can read out-o=
f-bounds.
- [Medium] Using `pr_warning` in a per-sample hot path can cause console fl=
ooding.
--

commit 11a75fed7f9248c6ed72e8226ebd4727a83530da
Author: Ian Rogers <irogers@google.com>

perf evsel: Add bounds checking to trace point raw data accessors

This commit adds bounds checking to tracepoint field accesses to prevent
out-of-bounds reads when retrieving raw data from samples. It verifies
that the field's offset and size fit within the sample's raw size.

> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index bb48568b8101a..c3a20f13d669e 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -3709,6 +3709,11 @@ void *perf_sample__rawptr(struct perf_sample *samp=
le, const char *name)
>  		return NULL;
> =20
>  	offset =3D field->offset;
> +	if ((u32)(offset + field->size) > sample->raw_size) {

Are field->offset and field->size signed integers? If an attacker crafts a
format with a negative offset, could the sum evaluate to a small positive
number and bypass this check?=20

This could lead to an out-of-bounds read when accessing
sample->raw_data + offset.

> +		pr_warning("Invalid trace point field offset %d for field of length %d=
 in sample raw data of size %u\n",
> +			   offset, field->size, sample->raw_size);

Since this function is called for every sample, could using pr_warning() he=
re
spam the console and degrade performance if the format is mismatched? Should
this use a ratelimited warning like pr_warning_once() instead?

> +		return NULL;
> +	}
> =20
>  	if (field->flags & TEP_FIELD_IS_DYNAMIC) {
>  		offset =3D *(int *)(sample->raw_data + field->offset);

Does this unconditional 4-byte read risk an out-of-bounds access?

If the dynamic field's size is less than 4 and it is located at the very end
of the sample buffer, the earlier size check will pass, but this cast and
dereference could read past the end of the raw_data buffer.

>  		offset &=3D 0xffff;
>  		if (tep_field_is_relative(field->flags))
>  			offset +=3D field->offset + field->size;
>  	}
> =20
>  	return sample->raw_data + offset;

Does the newly computed offset for dynamic fields also need a bounds check
against sample->raw_size?=20

The code returns sample->raw_data + offset without validating if this new
dynamic offset fits within the allocated buffer, which could allow arbitrary
memory reads.

[ ... ]

> @@ -3726,6 +3731,12 @@ u64 format_field__intval(struct tep_format_field *=
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

Similar to perf_sample__rawptr(), does this bounds check allow a bypass if
field->offset is negative?=20

Also, could pr_warning() flood the console in this hot path if malformed
data is processed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260412020833.6411=
77-1-irogers@google.com?part=3D27
