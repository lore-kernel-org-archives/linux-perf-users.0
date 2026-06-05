Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E03A48BD56
	for <linux-perf-users@vger.kernel.org>; Fri,  5 Jun 2026 08:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780646605; cv=none; b=ZLrSzpRxippFSw7pC8LeLUwIwJVk/3gnyB94b3E3k89SlyFp1yA8H8ZQ5TUHGkvbgtaNjweWRCEaM/oQxQe7inm6Gc2U1ASpooKshnDsFfdXDxlwiKzkfeTREi1e5eWIsMuxaXANynO/yjgd0XNCCGnqdc4C+0/bLzodJpSy9vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780646605; c=relaxed/simple;
	bh=xFTlCV3QSEojfn3Cy2efFWK/Y7N0MM9AH7ytHqidEbk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=A4OFGE7DPTanPvCPblctojLruoJNxTGXGG72CSMuAExPjlWvKplXGJrO15ylHtlm85HS/AJA2zEVk/iGAaTQhXqdr/NuX7Q++ky+dbRnIfg9j/u1KVeyk5zM0DG0O9zHtYJnp6t9b3ytMA3TYbeQiY4pHhqTc7rJxPfApguXA64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I9cM8Uta; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I9cM8Uta"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6E531F00893;
	Fri,  5 Jun 2026 08:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780646602;
	bh=U73BBSrHGByeyNbnDgpoq2NtgEFRjcQpywLxgCvE1XI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=I9cM8UtaFUYKf5FeAyvkAYzkM3MOo9pIR4k6KQzq63nA3T4pBnUrqqeYcf9CPKPyN
	 3icVcWKMfGeN+H+Gfq3MLoenuPt+OPYwew4jw6JRV55rafBb5YunzuWgXiFjN02jIE
	 oGqVWw3SmmpCUNN6awLBKUS6rg10oraXhK/n+fQjgZ93L+lnhWHcpCukgaNHl5vM0q
	 lInFK8/Mrhm85329K/tnEXvpQDpHewtljvWi9VPTEqzhDBjCDU86/JGfK3KZ4oun/O
	 r+uhpEP9gIVMhyiDcIZohTKF4pSBHjlZYxjUouumIvrIstJGBONctMZVv1PAKpQv1A
	 Od25VS/mWfsJw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 08/19] perf python: Use evsel in sample in
 pyrf_event
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260605074003.1730715-9-irogers@google.com>
References: <20260605074003.1730715-9-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 08:03:21 +0000
Message-Id: <20260605080321.E6E531F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The patch introduces a memory leak of the `evsel` reference on erro=
r paths in the `perf-time-to-tsc` test executable.
--

commit 7d5a63d3f3c57b9056699588a949237eae0cad32
Author: Ian Rogers <irogers@google.com>

perf python: Use evsel in sample in pyrf_event
   =20
Avoid a duplicated evsel by using the one in sample. Add evsel__get/put to
the evsel in perf_sample.

> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index ba88c29ebe5ce..d01c78da51e2b 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -3365,7 +3365,7 @@ int evsel__parse_sample(struct evsel *evsel, union =
perf_event *event,
>  	union u64_swap u;
> =20
>  	perf_sample__init(data, /*all=3D*/true);
> -	data->evsel =3D evsel;
> +	data->evsel =3D evsel__get(evsel);

[Severity: Low]
If evsel__parse_sample() encounters an error later in the function (such as
returning -EFAULT) after acquiring this reference, does the caller properly
clean it up?

For example, looking at test__perf_time_to_tsc() in
tools/perf/tests/perf-time-to-tsc.c, the CHECK__ macro evaluates
evsel__parse_sample() and jumps to out_err on failure:

tools/perf/tests/perf-time-to-tsc.c:test__perf_time_to_tsc() {
    ...
    CHECK__(evsel__parse_sample(evsel, event, &sample));
    ...
}

Because CHECK__ handles failures by jumping to out_err, it bypasses the
perf_sample__exit() cleanup call.

Does this leak the evsel reference?

>  	data->cpu =3D data->pid =3D data->tid =3D -1;
>  	data->stream_id =3D data->id =3D data->time =3D -1ULL;
>  	data->period =3D evsel->core.attr.sample_period;

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605074003.1730=
715-1-irogers@google.com?part=3D8
