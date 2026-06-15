Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635DA7080D
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 00:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781484830; cv=none; b=pHHC9TvtjUPaKyKp76m8/4GudJK/JPlqnWlxLfSiIUqYd1t+thjTZaSb2exJ1J1uABgWQvX6jMTbiEdnwQYEhMCu8TT0VmNZs1elopg8tEHy4BbxdexWSwHsdGInBIvJwiJGUBaqSbRBV/AtuliYdsJhz9yWq6Q15ER+pDNtDYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781484830; c=relaxed/simple;
	bh=Ml+q69hmNJaa2lt6mNgz4EJ8RzBvCbXDt9qrlBLOwG8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SdWwJhVycl/ru+y7pwaGE6G4zOqy05zOk4/hudCOGeMzFnMVIsGBCKQsR/qQbd1yvjPOeEdPJ0lV+MOnUrilOniGhvxXNS/i5Kd/omqs4/vyfFA3RLZVQ8VontV+jQtCY+UDPB3KWIOhZvna9neYZV2yX3JBZ5ZU+yE4Ks/F6OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SCVeBe7m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SCVeBe7m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E0C81F000E9;
	Mon, 15 Jun 2026 00:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781484829;
	bh=pwOWzOgLVTbsb/0H0PVId5rXghppfeyr3c1/NGGRDrQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SCVeBe7mlkPzVYH5IYAaG2kXziJ0zdOLsHC4dmnqW2axUE66vOJhknC+d6A7Q5twH
	 aZ6ZFmF/Dp33b16c1TZX3asRMssprhzbFJhbJYk9wfZnSSUcvUg8w9Za+gnmyuccmr
	 tvBHpXmqkMDll5Y5ltolZbMbx74fjJr5v4kr7ye6j2QaeK2w4l94TYMJkSJYMBwl3Q
	 U1gZbyAw08DbxudWxfoV7iQwnM8l8NPqCo6bFALtLPURxZRJWGKlFp5jN6mWOXxc9M
	 2b1ci6itYKj5ioF6lVzd7BgoZLlH+e2dO4ijl2WAXzACWvZBYGpzbvq7l31e1bJLSL
	 VWISwWhe21z4g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v18 06/20] perf evsel: Add reference count
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260615002812.2234795-7-irogers@google.com>
References: <20260615002812.2234795-7-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 00:53:48 +0000
Message-Id: <20260615005349.0E0C81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The `idx` parameter parsed in `pyrf_evsel__init` is silently dis=
carded, preventing setting the index from Python.
--

commit 73865cb149044df7a0939253660a5f456f8a05d1
Author: Ian Rogers <irogers@google.com>

perf evsel: Add reference count

This commit introduces a reference count to struct evsel to better handle
its lifecycle in Python code. It adds evsel__get() and evsel__put()
functions to manage the count and updates the Python API to use them instead
of directly cloning or deleting the evsel.

> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index 7483741c024a5..5482b68b8c0b3 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c

[ ... ]

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

[ ... ]

> @@ -1073,26 +1077,33 @@ static int pyrf_evsel__init(struct pyrf_evsel *pe=
vsel,
>  	attr.sample_id_all  =3D sample_id_all;
>  	attr.size	    =3D sizeof(attr);
> =20
> -	evsel__init(&pevsel->evsel, &attr, idx);
> +	evsel__put(pevsel->evsel);
> +	pevsel->evsel =3D evsel__new(&attr);

[Severity: Medium]
Does this code inadvertently discard the parsed idx variable?

The idx value is parsed from the Python arguments above, but evsel__new()
does not take an idx parameter. It appears to call evsel__new_idx() with
a hardcoded index of 0. This discards the parsed value and prevents setting
the index from Python. Should this perhaps use evsel__new_idx(&attr, idx)
instead?

> +	if (!pevsel->evsel) {
> +		PyErr_NoMemory();
> +		return -1;
> +	}
>  	return 0;
>  }

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615002812.2234=
795-1-irogers@google.com?part=3D6
