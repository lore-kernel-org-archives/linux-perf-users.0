Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77795374E6C
	for <linux-perf-users@vger.kernel.org>; Thu, 11 Jun 2026 19:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781206782; cv=none; b=lA08P+5HdUtQIFgyAab6M6WaHLe3qqZ17/rHkSvUjqxsd5Isqd0K8ev4l8SmGWJxikdi22UkIkzLcMjCRW9mbF0XHChhcQZLt5cfc16gPX5vmAwkxKRVaRftC6QI74xbZAykH8BF2C5DxP0FF9e2i78UNv3YXislN0B6dVDleDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781206782; c=relaxed/simple;
	bh=YbITaw1i16YddEFsnuOiv9ywwTma310aGH98P5U6Zr8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=J555UXuHQ/lCSDzntnQQGuIBZYWPkqbloKUEbMZqDUsMkhVAGrssUAKo85t8rS+MOFDnGsW3my5dSnn836PMHruqURWBtOGmaW5Dqv4ITqVFLC/b7aaUwKhIyUKj/Ks8yxzaPSxWvrab6xINKGA4mdwhRZ5rXiu+2reZ00Wlsxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i556PHAQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i556PHAQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CD2C1F000E9;
	Thu, 11 Jun 2026 19:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781206779;
	bh=VEAcJ2IiPVXVLfoafw9j7qv02XjzdvRXLXYQumI/LeM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=i556PHAQ65rARVsawr00TgwRoiqJxFH8ZlaU9EyjMB9cHhFg5fYAEwL1Im7E0M2Lv
	 cI2kncyEkDaG1bmE7Neo/NzKa1FjoLhcRXsf2vKG7NlAtmMNZH34GHjJs+juU1rdrA
	 JrnZIKd18Yxo9FN5USIPS/FFY/MbMHMzZTvuTcCQ+NSivqXtwVDOOn8vc0emlbY3nS
	 ehixeVjqDAxKGCwZg9sPZbOQ6FfkiIynKplCQot6hsOtZ/pDu2K3cq7/cIAz+4+WQc
	 ieYt9cfHXo3/27a4EyLxJ43GEcepKNGuqTlSNPhdNT17S0wnWNJ7a7W28sNYt7GR7L
	 FhuJLDQ0uAklw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 06/19] perf evsel: Add reference count
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260611171756.4008769-7-irogers@google.com>
References: <20260611171756.4008769-7-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 19:39:38 +0000
Message-Id: <20260611193939.1CD2C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Missing NULL check before calling `evsel__get()` on the result o=
f `evlist__id2evsel()` leads to a segmentation fault.
- [Low] The 'idx' parameter is parsed but silently ignored in pyrf_evsel__i=
nit.
--

commit 08240b36c25f305e7e8473035f740785982c5019
Author: Ian Rogers <irogers@google.com>

perf evsel: Add reference count

As with evlist this a no-op for most of the perf tool. The reference
count is set to 1 at allocation, the put will see the 1, decrement it
and perform the delete. The purpose for adding the reference count is
for the python code.

[ ... ]

> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
> @@ -1027,11 +1031,11 @@ static int pyrf_evsel__init(struct pyrf_evsel *pe=
vsel,
>  	    watermark =3D 0,
>  	    precise_ip =3D 0,
>  	    mmap_data =3D 0,
> -	    sample_id_all =3D 1;
> -	int idx =3D 0;
> +	    sample_id_all =3D 1,
> +	    idx =3D 0;
> =20
>  	if (!PyArg_ParseTupleAndKeywords(args, kwargs,
> -					 "|iKiKKiiiiiiiiiiiiiiiiiiiiiiKK", kwlist,
> +					 "|iKiKKiiiiiiiiiiiiiiiiiiiiiiKKi", kwlist,
>  					 &attr.type, &attr.config, &attr.sample_freq,
>  					 &sample_period, &attr.sample_type,
>  					 &attr.read_format, &disabled, &inherit,
> @@ -1073,26 +1077,33 @@ static int pyrf_evsel__init(struct pyrf_evsel *pe=
vsel,
>  	attr.sample_id_all  =3D sample_id_all;
>  	attr.size	    =3D sizeof(attr);
> =20
> -	evsel__init(&pevsel->evsel, &attr, idx);
> +	evsel__put(pevsel->evsel);
> +	pevsel->evsel =3D evsel__new(&attr);

[Severity: Low]
Is it intentional that the idx parameter is parsed but silently ignored
here?

In the previous code, idx was passed to evsel__init(). In the new code,
idx is parsed from the keywords, but it is not passed to the allocation
function (like evsel__new_idx()). Does this drop user-provided input?

> +	if (!pevsel->evsel) {
> +		PyErr_NoMemory();
> +		return -1;
> +	}
>  	return 0;
>  }

[ ... ]

> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -1844,7 +1844,10 @@ static int evlist__deliver_deferred_callchain(stru=
ct evlist *evlist,
>  		struct evsel *saved_evsel =3D sample->evsel;
> =20
>  		sample->evsel =3D evlist__id2evsel(evlist, sample->id);
> +		if (sample->evsel)
> +			sample->evsel =3D evsel__get(sample->evsel);
>  		ret =3D tool->callchain_deferred(tool, event, sample, machine);
> +		evsel__put(sample->evsel);
>  		sample->evsel =3D saved_evsel;
>  		return ret;
>  	}

[Severity: Medium]
Could a missing NULL check lead to a segmentation fault in other parts of
the deferred callchain or flush paths when evlist__id2evsel() returns
NULL?

The evlist__id2evsel() function can return NULL if the ID is unknown or
the perf.data file is corrupted.

There appear to be other locations, such as in
evlist__deliver_deferred_callchain() and
session__flush_deferred_samples(), where the result of
evlist__id2evsel() is unconditionally dereferenced in evsel__get():

    new_evsel =3D evlist__id2evsel(evlist, orig_sample.id);
    if (new_evsel !=3D orig_sample.evsel) {
        evsel__put(orig_sample.evsel);
        orig_sample.evsel =3D evsel__get(new_evsel);
    }

Should we ensure a NULL check is added before calling evsel__get()
in these cases as well?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611171756.4008=
769-1-irogers@google.com?part=3D6
