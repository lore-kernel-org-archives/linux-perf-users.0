Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFB3330D23
	for <linux-perf-users@vger.kernel.org>; Sat, 11 Apr 2026 07:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775892341; cv=none; b=J+uB9i3aAyhoB/9lBJl5scsMCuxGLgzEFag/ZBMIlrQc6yF/UAIZ6D0VABOKdu+u94D55a0Iyb/8ca9lByY8W9UL7LAAHndo95YZ2vsdwkJg1NusVAUxe7PNmDmp6hufYFi5Ors4EaEMRss1GqxzaqxPB0TebAvpepVpunAVO2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775892341; c=relaxed/simple;
	bh=VCitdSjm0sC2vbJvtzxy915gRSMYgPrfzJ98XVuD90s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=d9eypxSfqcQIhEYLv+ogsbEYRFJvXVvXRMAFsfV2sc7yxViH1A+pgx/hZHBT0NQYS0Mv+PyKSSZxirsQGreXuFV0r7RxXK4kt+z/Y2ZfCK1/p4Bjvr/7XUt3qOVCNy/aFABPm81EfI639GTiMEfLm2cp67cs5A0AIjdaVxegrpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ll8Y0C+P; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ll8Y0C+P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C57CC4CEF7;
	Sat, 11 Apr 2026 07:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775892340;
	bh=VCitdSjm0sC2vbJvtzxy915gRSMYgPrfzJ98XVuD90s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=ll8Y0C+Prkf6V3xNyp47GT1XuwHLYtoDuInjFBkH5ApmhLBHtpRqGYLsR0kBR6+rB
	 i6Huq//hDOISNpGOraUrHTPl37PClNdbhsCa2PFh8upzCoDZVqd9Tq9TtrT6bTus5D
	 r3VQK0eNC5Qd9ZwGDdxnPxR3mtFR2DsjcEx48XZx90Zs/U9J4C3LTIvv8x5y6Lqj8L
	 8qxekkWm/wLaQrM1v2Rrg0DDCFUiOAxCtAFfWAmLaCSx5riiyxOU1pvZ6wbGkw/M2o
	 dhQElWd0b08sgqR290ROTAag868eSRaxUMTO11FKkzWzN8hq8N8wHbZSG/gDQ5YO4U
	 jG4i5RcnEj73Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 23/29] perf evsel: Don't pass evsel with sample
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260411065718.372240-24-irogers@google.com>
References: <20260411065718.372240-24-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 11 Apr 2026 07:25:40 +0000
Message-Id: <20260411072540.8C57CC4CEF7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Medium] Double-fetch of `event->header.size` from shared memory can lead=
 to an integer underflow and arbitrary out-of-bounds read.
--

commit feaf06e92fc012fceb6bf075c90c4ab1eff00681
Author: Ian Rogers <irogers@google.com>

perf evsel: Don't pass evsel with sample

Arrange for the sample to contain the evsel and so it is unnecessary
to pass the evsel as well. This is done for uniformity, although
parsing of the sample is arguably a special case. Add missing bound
check in perf_evsel__parse_id_sample.

> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
[ ... ]
> -static int perf_evsel__parse_id_sample(const struct evsel *evsel,
> -				       const union perf_event *event,
> +static int perf_evsel__parse_id_sample(const union perf_event *event,
>  				       struct perf_sample *sample)
>  {
> +	const struct evsel *evsel =3D sample->evsel;
>  	u64 type =3D evsel->core.attr.sample_type;
> -	const __u64 *array =3D event->sample.array;
> +	const __u64 *array, *array_begin =3D event->sample.array;
>  	bool swapped =3D evsel->needs_swap;
>  	union u64_swap u;
[ ... ]
> +	if (event->header.size < sizeof(event->header) + sizeof(u64))
> +		return -EFAULT;
> =20
> +	array =3D array_begin + ((event->header.size - sizeof(event->header)) /=
 sizeof(u64)) - 1;

Is there a risk of a double-fetch here? Since the event can point directly
into memory mapped from perf.data, could a concurrent modification to the
file alter event->header.size between the bounds check and this calculation?

If event->header.size is modified to 0 after the check passes, would the
expression (0 - sizeof(event->header)) undergo an unsigned underflow since
sizeof returns a size_t? This could result in a massive positive offset
being added to array_begin.

>  	if (type & PERF_SAMPLE_IDENTIFIER) {
> +		if (array < array_begin)
> +			return -EFAULT;

Could the compiler optimize this fallback check away? Because the offset
added to array_begin is evaluated as an unsigned size_t, compilers like
GCC (at -O2) often apply strict pointer overflow rules and assume the
resulting pointer is always greater than or equal to the base pointer.

If the check is evaluated as dead code, could this bypass the bounds
checking completely and lead to an out-of-bounds read on the array pointer?

> +
>  		sample->id =3D *array;
>  		array--;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260411065718.3722=
40-1-irogers@google.com?part=3D23
