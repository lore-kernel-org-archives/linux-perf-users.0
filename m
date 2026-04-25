Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1B639185E
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 23:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777159714; cv=none; b=l6teZJqDIcm6gQIl74qTgPUVt/+IX0R84ktrGv49l4YIN/4CDZ2iflNXNhQ3lgRSISip/Awu+H9asuY8QhShRB2D+p+XfcjPnuKKcbtJQKZy0MevYxr20kXgjdWoRSOuC383An2KQliZlxqKaAeg//6J27usnbMCS+0/p+MjE1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777159714; c=relaxed/simple;
	bh=jPEqzct1fmblYQxSianthjMu3SijLAGw6L7E6RTGHCo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=B2rFmM0JDiXDvsWFTizt1X6piIZc/nn1bvLDI4GLbx/HzRrS/4MbS8GdenrAVMOjwM8xbAzvg6rb1FrXcp+LNqEEWMVC3A3jvhminHeyjEq4nlMwTSuMNRD7zX7TwCM9EdP7k9aP16YPf1AsqajtZnT5mu9vgEERf/Y6uwSbMYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cdHZxvsl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cdHZxvsl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 505D3C2BCB0;
	Sat, 25 Apr 2026 23:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777159714;
	bh=jPEqzct1fmblYQxSianthjMu3SijLAGw6L7E6RTGHCo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=cdHZxvslObu6SZLF2k96DOZE+IxSQD0SvVJ9i++p53CaQrjQ+KfUWk2daMwOYx1ne
	 EPDovBjKenQx6YF9rPK94OZlVa6tSyoxP9zXtD5d84xlzIpim2hicdTU4KAeC4GQYh
	 /T9sCyWCxuqUvcGW7X4xvMFsxe7oGEywTTjTK9LZELx33wEZw0+NvcJj5u7F2JvgpB
	 OL8P95XV+K5zNojSjVjJPwpPZg7mlrVFOeZHS6SxSXsozQyw7P/LAJ10U6s0CbUIe5
	 SHrJbCvHpqS6BOrSvF2J1XCD7ryNEX4CzQPEEsMghQzDRDsG9ieKG8278kMvUTx7Gp
	 rFHAPvvBugX3Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 12/59] perf evlist: Add reference count checking
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260425224951.174663-13-irogers@google.com>
References: <20260425224951.174663-13-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Apr 2026 23:28:33 +0000
Message-Id: <20260425232834.505D3C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 3 potential issue(s):
- [High] TOCTOU race in `evlist__put()` cyclic reference detection causes a=
 double free.
- [High] Missing `evsel__put()` on `sample->evsel` causes massive memory le=
aks for synthesized and deferred events.
- [Low] Missing NULL pointer check after `evsel__new()` allocation in sampl=
e parsing test.
--

commit 9e6c20d0f9fcd0a7529fc6e3ee8e9feb3216bce3
Author: Ian Rogers <irogers@google.com>

perf evlist: Add reference count checking

Now the evlist is reference counted, add reference count checking so
that gets and puts are paired and easy to debug.

> diff --git a/tools/perf/tests/sample-parsing.c b/tools/perf/tests/sample-=
parsing.c
> index 55f0b73ca20e..6db717e562d5 100644
> --- a/tools/perf/tests/sample-parsing.c
> +++ b/tools/perf/tests/sample-parsing.c
[ ... ]
> @@ -287,16 +283,17 @@ static int do_test(u64 sample_type, u64 sample_regs=
, u64 read_format)
>  	size_t i, sz, bufsz;
>  	int err, ret =3D -1;
> =20
> +	evsel =3D evsel__new(&attr);
>  	perf_sample__init(&sample_out, /*all=3D*/false);
>  	perf_sample__init(&sample_out_endian, /*all=3D*/false);
>  	if (sample_type & PERF_SAMPLE_REGS_USER)
> -		evsel.core.attr.sample_regs_user =3D sample_regs;
> +		evsel->core.attr.sample_regs_user =3D sample_regs;

Could this dereference a NULL pointer if evsel__new() fails?

> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index a362f338f104..29588af735e5 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
[ ... ]
> @@ -220,13 +227,33 @@ static void evlist__exit(struct evlist *evlist)
> =20
>  void evlist__put(struct evlist *evlist)
>  {
> +	struct evsel *evsel;
> +	unsigned int count;
> +
>  	if (evlist =3D=3D NULL)
>  		return;
> =20
> -	if (!refcount_dec_and_test(&evlist->refcnt))
> -		return;
> +	if (refcount_dec_and_test(evlist__refcnt(evlist)))
> +		goto out_delete;
> =20
> +	count =3D refcount_read(evlist__refcnt(evlist));
> +	evlist__for_each_entry(evlist, evsel) {
> +		if (RC_CHK_EQUAL(evsel->evlist, evlist) && count)
> +			count--;
> +	}
> +	if (count !=3D 0) {
> +		/*
> +		 * Not the last reference except for back references from
> +		 * evsels.
> +		 */
> +		RC_CHK_PUT(evlist);
> +		return;
> +	}
> +out_delete:

Is there a race condition here if two threads concurrently call evlist__put=
()
and drop the final two external references?

If they both execute refcount_dec_and_test() and it evaluates to false, both
threads could read the updated refcount that matches the back-references, a=
nd
both would jump to out_delete, causing a double free.

> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index deb5b9dfe44c..f9fafbb80a9d 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
[ ... ]
> @@ -1464,22 +1470,24 @@ static int machines__deliver_event(struct machine=
s *machines,
> =20
>  	dump_event(evlist, event, file_offset, sample, file_path);
> =20
> -	if (!sample->evsel)
> +	if (!sample->evsel) {
>  		sample->evsel =3D evlist__id2evsel(evlist, sample->id);
> -	else
> +		if (sample->evsel)
> +			sample->evsel =3D evsel__get(sample->evsel);
> +	} else {
>  		assert(sample->evsel =3D=3D evlist__id2evsel(evlist, sample->id));

Will this leak the evsel reference?

We acquire a strong reference to the evsel here using evsel__get(), but it
doesn't appear that perf_sample__exit() or other paths in the lifecycle of
the sample object are updated to release it via evsel__put().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260425224951.1746=
63-1-irogers@google.com?part=3D12
