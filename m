Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFACEAC7
	for <linux-perf-users@vger.kernel.org>; Sat, 11 Apr 2026 19:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775937103; cv=none; b=o7swGxHScHUVw8ds5Yc1P/9D1El6T+VJaAo5pw0tmxlxcOFXwiBMeew7zPuTlp2oTjkGe/HhSIpY/xuLQOTb8lefoK/x/RBKWbNRVUTKoGq8WIiRePZ4GZM3lSvmpe5gbhof/+iashqtyCQChWaVe8NIYXv9+NtHCm7cXbTGqrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775937103; c=relaxed/simple;
	bh=XYHrsiRR3IPSJC5pkEKcwCy61Bumf4GqvZbU51ztCV0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=anYrEjHYkZIzO0ki+tqHZ5X9o1ZW975cOU5b8GI7io94Hdg+ajaI7p8n6UKOaScRABcCiTSBZrnIYVZz66vp7fnGtx8jPzN9vXo1Od3C351XA8xRanQB1RT+FH/EqCi/iORjrLmJ5RiSkWpsdY/88NwLlAqaC8mCmBvE0or49fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k8l2NM65; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k8l2NM65"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B877C2BCAF;
	Sat, 11 Apr 2026 19:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775937102;
	bh=XYHrsiRR3IPSJC5pkEKcwCy61Bumf4GqvZbU51ztCV0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=k8l2NM65yM84zPcGd91crq/sO2rBAAo78ihDAW6VJGp9PPX+F1XpqpRmx3lknylRo
	 hMxjPuW5NPVkyk1XzsEpn3mf1r5dVizYLDroTJvyL8Rp/1cEWtWtdn13lGJ3qzHPoy
	 oo8/4j/XMFw77znbBIL2XF8vxOVGJBI1uu1gqO9M8cP0rv/bOkB637EDItiAtcVKUQ
	 e9k0QUpGbs9Zz1QguFZILNrHlNc2xSLpHdhq4y4ucfZyiXxqBBPCdiZHvC4f9Ag4XO
	 gLSIOUdPz3TX1hkSZaTlwr5BRJn5cr7an4ckd1DmHHNjcUOt+WJLw97iwA5RDT8oYr
	 xnPqFGL5MevbQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 23/29] perf evsel: Don't pass evsel with sample
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260411191710.524998-24-irogers@google.com>
References: <20260411191710.524998-24-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 11 Apr 2026 19:51:41 +0000
Message-Id: <20260411195142.6B877C2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [High] Undefined Behavior in bounds check allows bypass and Out-of-Bounds=
 Read
--

commit ff15872035e54097547806aeac88548255b7e6b5
Author: Ian Rogers <irogers@google.com>

perf evsel: Don't pass evsel with sample

This commit arranges for the sample to contain the evsel, making it
unnecessary to pass the evsel separately. It also adds missing bounds checks
in perf_evsel__parse_id_sample.

> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index ee30e15af054c..3c10b840778e0 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
[ ... ]
>  static int perf_evsel__parse_id_sample(const union perf_event *event,
>  				       struct perf_sample *sample)
>  {
> +	const struct evsel *evsel =3D sample->evsel;
>  	u64 type =3D evsel->core.attr.sample_type;
> +	const __u64 *array, *array_begin =3D event->sample.array;
[ ... ]
> +	array =3D array_begin + ((event->header.size - sizeof(event->header)) /=
 sizeof(u64)) - 1;
>  	if (type & PERF_SAMPLE_IDENTIFIER) {
> +		if (array < array_begin)
> +			return -EFAULT;
> +
>  		sample->id =3D *array;
>  		array--;
>  	}
> =20
>  	if (type & PERF_SAMPLE_CPU) {
> +		if (array < array_begin)
> +			return -EFAULT;
> +

Is there a risk that the compiler optimizes away this bounds check due to
undefined behavior?

The array pointer is decremented at the end of the previous block via
array--. If the pointer underflows the object boundaries, decrementing it
before the beginning of the object is undefined behavior in C.

Since modern compilers track this, could the optimizer treat the
underflowed pointer as a poison value and silently remove the
array < array_begin check entirely?

If a malformed perf.data file with an event size smaller than the requested
fields is processed, could this bypass the check and lead to an
out-of-bounds read?

Would it be safer to use an integer counter to track the available size
instead of pointer comparisons?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260411191710.5249=
98-1-irogers@google.com?part=3D23
