Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399DC79CD
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 22:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781563721; cv=none; b=rxGNRg39vZkICTw2QsCw2Vttp7ViY0m5cJbHSxZ8JtbRSe41wLGbfT1BmY8GOIn1xllYtV0VSUGLwDX2mXBiZyYNU84YEd7yTlC0SzRe/DRm//D60pvzHBk8GpAwWVsOKIs7po6ATXCdkDAN97YRxLVfLio4FYcZixhtlseo6V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781563721; c=relaxed/simple;
	bh=vMARWTcgdfg2GoMVk9ZJqFfauzpg6JAXngCI5DiCp9M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jrVRCmwnnoYOni25CsvSxnzQilczK3MyP0VpMmYQJk81Y5NJPaFW5ZUftxGpu0gDCdjIHHJuQAn4L+JVx44UpLsEKbpscHz/hX9Dzvi5NZvFXqzMZJHmBE1e+Ucznzs0KsjX1tyOQxK6UNIiLMpL0nT9dY7mTSVprZJvGW3eZng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dryZ+GZ5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dryZ+GZ5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE9151F000E9;
	Mon, 15 Jun 2026 22:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781563720;
	bh=7AwhU+fI5dlrwywDZXNUN70F26Cy/ggNyJe0tRpK8AE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dryZ+GZ5wLddQZjaZRx8RwDKUnX428Um0CVraVc3PWlTpnsj8GpFJwUtUgci+0EJz
	 3wX+vM8LFHFY0kb2weaTCZqSfHvPx36t6pbsYfpdWdzvApm3vmJHZm+4S2T05iZH2Y
	 mgrKQ1LNeoE/RVxt7U1kXGpHOxf0Ru5Q+HPVXURfLq/qVRf4PUtnrGdiMtGxAnTOk6
	 jzzroZF0AKKJotZf255qtZMgf/Zo8Ls38pdD6fg9n2kkzbr0ZR9Ystl5z4sFm38HqH
	 bBragsk8ztpuZZR1IzqhL8aULAhSHo7PYMXlVLcjNYEOPQyW+PXRltJnAsDp+YQwMe
	 bWJaRAdf+2i+A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v20 07/21] perf evlist: Add reference count checking
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260615223011.3873955-8-irogers@google.com>
References: <20260615223011.3873955-8-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 22:48:39 +0000
Message-Id: <20260615224839.EE9151F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] Lockless cycle-breaker algorithm in `evlist__put` is vulnerabl=
e to a race condition that can result in a double free of the `evlist`.
- [High] Circular reference between `evlist` and `evsel` causes a permanent=
 memory leak if an `evsel` outlives its parent `evlist`.
--

commit bf56f6ea798f2473fd24a71487153a7749cf533e
Author: Ian Rogers <irogers@google.com>

perf evlist: Add reference count checking

Now the evlist is reference counted, add reference count checking so
that gets and puts are paired and easy to debug. This large patch is
adding accessors to evlist functions and switching to their use.

> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index 1721a2470fb67..eb7c0d7be064e 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -211,26 +222,46 @@ static void evlist__exit(struct evlist *evlist)
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

[Severity: Critical]
Can the lockless cycle-breaker algorithm in evlist__put() lead to a double
free here?=20

If two threads call evlist__put() at the same time and neither hits 0 in
refcount_dec_and_test(), they could both reach the retry loop. They could
both read the same ref_cnt from refcount_read(), evaluate count to 0,
pass the validation check, and simultaneously proceed to out_delete.

> =20
> +	if (count !=3D 0) {
> +		/*
> +		 * Not the last reference except for back references from
> +		 * evsels.
> +		 */
> +		RC_CHK_PUT(evlist);
> +		return;
> +	}

[Severity: High]
Does this early return prevent the cycle from ever being broken if an
external user holds a reference to an evsel?

Since evlist__add() takes a reference on the evlist below, this introduces
a circular reference.

If an external user holds an extra reference to an evsel (so its refcnt
is >=3D 2), the loop above won't decrement count for it, and we return
early here.=20

Later, when the external user drops the evsel reference via evsel__put(),
the evsel's refcnt drops to 1. But evsel__put() doesn't have a reciprocal
cycle-breaking mechanism like this one. Will this leave both the evlist
and the evsel leaked permanently?

> +out_delete:
>  	evlist__free_stats(evlist);
> -	evlist__munmap(evlist);
> +	evlist__do_munmap(evlist);
>  	evlist__close(evlist);
>  	evlist__purge(evlist);
>  	evlist__exit(evlist);
> -	free(evlist);
> +	RC_CHK_FREE(evlist);
>  }
> =20
>  void evlist__add(struct evlist *evlist, struct evsel *entry)
>  {
> -	perf_evlist__add(&evlist->core, &entry->core);
> -	entry->evlist =3D evlist;
> +	perf_evlist__add(evlist__core(evlist), &entry->core);
> +	evlist__put(entry->evlist);
> +	entry->evlist =3D evlist__get(evlist);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615223011.3873=
955-1-irogers@google.com?part=3D7
