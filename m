Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195C5247DE1
	for <linux-perf-users@vger.kernel.org>; Sat, 13 Jun 2026 05:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781329449; cv=none; b=NHql2nnsTp1WoNl5NMgfU8veMXgfVKka4TNBh97mOmJK9zc0o8Si+WTYY9N/s7M98ubbNqFHyAl3a9umREe6Ke8lOQ8tA0k4cHFPtf+ySyGJum3/g7MxLAyM2DFobAuGOSYE4CHZRqAdwJg1YfsohF7/gvL1uUV1pTnie91EDrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781329449; c=relaxed/simple;
	bh=Y1tVgWSNRzO3AyPS5+a3ZzGjr9R3rSiEBY1WValQPy0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=axAoOyQ1AIa1iADrowz1tpAp944viTf5S6grDX8bb07eMJvx6udAIC41RJem1wN7dt9tkHsMpe7qsr6Q2to1pCzm1vdSCx2NuQXXDhIzi0dXyZMsBJhqjIlsEkzqKGQ8vJoEHZTSpchu0cUXN5OBQb7vk7Qa8+TN8hN+Tp8U3GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fVXVkfCV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fVXVkfCV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 846491F000E9;
	Sat, 13 Jun 2026 05:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781329447;
	bh=yFOjK+02YEUttkqR7PLtqPSEJZPgfrm7/RT/jbiZoKE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fVXVkfCVL293f6sehOcatVPq37a1gMbFb1SKH5aAzRi6KBQxWgDDfQhHLOSj8UDBq
	 kbxgLYWR+VUlVEwFm7dkmDmWjQHD5hN25L5ZINaa2FQGvvoCete1ahgot/WewAOvWQ
	 ncazpGd+iGcB933Ngydc1wqNFgdA56bfdkKqb2bKs9dBUy4EPxZsmQac83AWsAFCqv
	 svKC3I8SCGbNeEYXX9VmxP+M8Q49ubTKNeKcEKHjehyrSYWtRWymuIfNi/s3knX52I
	 eUIRTWp09wBRKzr7yy7xTZMbn+NLIjijoeA2noHNVkhXH7bhTuUkKOzAlfGEWQqeXr
	 ze8JGsLFtA6vg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v16 07/20] perf evlist: Add reference count checking
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260613052722.1424093-8-irogers@google.com>
References: <20260613052722.1424093-8-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 13 Jun 2026 05:44:07 +0000
Message-Id: <20260613054407.846491F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] Lockless cycle collection in evlist__put is vulnerable to a ra=
ce condition when multiple threads call evlist__put concurrently, leading t=
o a double free of the evlist.
- [High] Asymmetric reference cycle breaking between evlist and evsel leads=
 to a memory leak if evsel references are dropped after evlist references.
--

commit 301ffb021ba3ed06f7a940029d4cb64cc8c1b5df
Author: Ian Rogers <irogers@google.com>
Subject: perf evlist: Add reference count checking

Now the evlist is reference counted, add reference count checking so
that gets and puts are paired and easy to debug. This patch adds
accessors to evlist functions and switches to their use.

> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
[ ... ]
> @@ -215,20 +220,41 @@ void evlist__put(struct evlist *evlist)
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

[Severity: Critical]
Is this lockless cycle detection vulnerable to a race condition that causes
a double free?

If two threads concurrently drop the last two external references to an
evlist, they will both decrement the refcount via refcount_dec_and_test()
and both will get false.

Both threads then perform the cycle detection check. Because this check is
not serialized and does not atomically claim the right to perform the
deletion, both threads can simultaneously evaluate count =3D=3D 0 as true.

This allows both threads to enter the out_delete block and concurrently
execute evlist__purge(), leading to double frees and memory corruption.

Should this cycle detection be protected by a lock or an atomic state
transition?

[Severity: High]
Does this asymmetric cycle-breaking logic lead to a memory leak?

If an external caller drops their reference to the evlist while holding a
reference to an evsel, evlist__put() observes that the evsel has a
refcount > 1, fails to break the cycle, and returns.

When the caller subsequently drops the evsel reference, evsel__put()
merely decrements the refcount to 1 and returns, because it lacks
symmetric cycle-breaking logic.

Can we add symmetric cycle-breaking logic to evsel__put() to prevent
this regression?

[ ... ]
> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
[ ... ]
> @@ -1830,12 +1830,16 @@ static PyObject *pyrf_evlist__add(struct pyrf_evl=
ist *pevlist,
>  	evsel =3D ((struct pyrf_evsel *)pevsel)->evsel;
> -	evsel->core.idx =3D evlist->core.nr_entries;
> +	CHECK_INITIALIZED(evsel, "evsel");
> +
> +	evsel->core.idx =3D evlist__nr_entries(evlist);
>  	evlist__add(evlist, evsel__get(evsel));

[Severity: High]
Does the way we handle references here trigger the memory leak regression
mentioned above?

The Python bindings explicitly increment the evsel reference count via
evsel__get() before adding it to the evlist. If the Python garbage
collector drops the evlist before the evsel, the cycle won't be broken and
both objects will leak.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260613052722.1424=
093-1-irogers@google.com?part=3D7
