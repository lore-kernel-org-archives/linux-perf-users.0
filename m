Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B9E38839D
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Jun 2026 22:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781303426; cv=none; b=PgYHrIvsZqN19DTf1lZIiHSI+wDOPe2cmyv0jVwV6wvxwXBBh+KoVVYNB9PAAkJMbZfpmHSUobrIFQ4vATcIMyfAr1ZFXGO116TO437vyEwLW1GqZ0avB5Bb3nfbMBdEs8qUu5O9uvt8rIrYIxB+IEEdyltgKH2qgMeFCOkfcNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781303426; c=relaxed/simple;
	bh=HouFDqmuNq1ECQbOq5YFdbDt/GwWQRFr89TQppYJsBw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WmWKU/qVkzO/ml0UeqogLT2iCs+hQuyIQTWtGXDq9EZ/9mwxN530epo2XfISK302LJtRfP//4genKi0hZiRnooDt/44y77KgHqdR6jyg4cEiGX5QLP9gDV1IvzUQtoYOgLyvCN+xhttiH9jZu0s+yHJRcFPd2PWW03mhFk0YjSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JzbPaGsB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JzbPaGsB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9226F1F00A3A;
	Fri, 12 Jun 2026 22:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781303422;
	bh=oYj3CDCnAVSvwRLwW/xTeBvwohCEC/2rm4muf6j/eUk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JzbPaGsB1UAsI7HhEGXsnNnzSS8On8e3nYuuCaez0W86R3K+xCwpILe+KS8eoW+f+
	 1LggW1Q7vqo5OXXNIRHdlJq52z9BIlYpvSzMBVhOVVab0opdwbDnoLZN9vFhnyaQlt
	 bqfvrABGHoTemuRJtzruTbsw+CJvj5OewpkwEymreOIG82baYADB38UgUzUdxDB7IJ
	 kTO9JGtModBnI1cLrnSaf+ThUqDtWIBEf5oFXlK8HTd7xv8r8as7rASSrftGOusFvg
	 zR8jV58BpcnJcXMCz+sdyqifliLMOlhhqZ2/k/KIGhO67Hxt19n9CIED/IFycYuVGR
	 9syw64CGPzCFw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 07/19] perf evlist: Add reference count checking
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260612221211.1221305-8-irogers@google.com>
References: <20260612221211.1221305-8-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 22:30:22 +0000
Message-Id: <20260612223022.9226F1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Memory leak due to flawed reference cycle collection in `evlist__p=
ut()` when an `evsel` outlives its parent `evlist`.
- [High] Concurrent `evlist__put` calls can cause a double free of the `evl=
ist` due to a lockless TOCTOU race in cycle collection.
--

commit 9f9c729b9d53b88f9a8695a329f14caec324824b
Author: Ian Rogers <irogers@google.com>

perf evlist: Add reference count checking

This patch adds reference count checking for the evlist structure so that
gets and puts are paired properly and easier to debug. It adds accessors for
evlist functions and switches existing code to use them.

> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c

[ ... ]

> @@ -203,18 +229,40 @@ static void evlist__exit(struct evlist *evlist)
> =20
>  void evlist__put(struct evlist *evlist)
>  {
> +	struct evsel *evsel;
> +	unsigned int count, ref_cnt;
> +
>  	if (evlist =3D=3D NULL)
>  		return;
> =20
> -	if (!refcount_dec_and_test(&evlist->refcnt))
> -		return;
> +	if (refcount_dec_and_test(evlist__refcnt(evlist)))
> +		goto out_delete;
> +
> +retry:
> +	count =3D refcount_read(evlist__refcnt(evlist));
> +	ref_cnt =3D count;
> +	evlist__for_each_entry(evlist, evsel) {
> +		if (RC_CHK_EQUAL(evsel->evlist, evlist) && count &&
> +		    refcount_read(&evsel->refcnt) =3D=3D 1)
> +			count--;
> +	}
> +	if (refcount_read(evlist__refcnt(evlist)) !=3D ref_cnt)
> +		goto retry;
> +
> +	if (count !=3D 0) {
> +		/*
> +		 * Not the last reference except for back references from
> +		 * evsels.
> +		 */
> +		RC_CHK_PUT(evlist);
> +		return;
> +	}
> +out_delete:

[Severity: High]
Does this reference cycle collection logic also need a symmetrical check in
evsel__put() to prevent memory leaks?

This patch introduces a strong reference cycle between evlist and evsel via
entry->evlist =3D evlist__get(evlist) in evlist__add(). While evlist__put()
handles cycle detection to free the evlist if the only remaining references
are from its evsels, evsel__put() lacks the inverse logic.

If an external reference to evlist is dropped while an external reference to
an evsel is held, evlist__put() correctly leaves the objects alive. However,
when the last external reference to the evsel is subsequently dropped,
evsel__put() decrements the evsel refcount to 1 and returns. Since there is
no logic to break the cycle from the evsel side, both the evlist and the
evsel could permanently leak.

[Severity: High]
Can this lockless cycle collection lead to a double free due to a TOCTOU
race condition?

If two threads drop the last two external references to an evlist
concurrently, couldn't they both read the same stable refcount where count
equals the number of cyclic references?

Both threads would iterate over the evsels, decrement their local count to =
0,
verify the global refcount matches their snapshot, and both fall through to
the out_delete block. This would result in both threads concurrently execut=
ing
evlist__purge() and freeing the object.

>  	evlist__free_stats(evlist);
> -	evlist__munmap(evlist);
> +	evlist__do_munmap(evlist);
>  	evlist__close(evlist);
>  	evlist__purge(evlist);
>  	evlist__exit(evlist);
> -	free(evlist);
> +	RC_CHK_FREE(evlist);
>  }

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612221211.1221=
305-1-irogers@google.com?part=3D7
