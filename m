Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EFD4175A62
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 01:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781574286; cv=none; b=Q2NUpX3BLO22bhYPf3GUN47ELv/LB1MisGwkZmSDU3qa14RBF4zgqNHUAb1kaQjgIHAwFMi7PelROy9UOASY9CyfBmLlfurPwZKT6pdkWyWa1+jGtWWZoD+klIw/Pff32fYVYyg5wL15qrNyWyjcuh289IQOtN2R9yjrvcy8FfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781574286; c=relaxed/simple;
	bh=c3Iu2Ye38vl9f72RGUIxayVO+PkcwXsi1aIUzISTsCY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=G76hVI8Z6+KyTQNlzKoMVvSOCfRwY+VzV274UzhfdNV9XwByO3BYxerHhjsRiwN7QtcZAcpG6WmrnbpSdNHy7GtegCPh8muq72lyj7lmIZTC/Al/w6Cl85oZprrdUNaXf1J33oUpSBB8uoFGoo/ipw/CwtoEYBcbCqznZLicU+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cWskSsjJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cWskSsjJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B3D71F000E9;
	Tue, 16 Jun 2026 01:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781574285;
	bh=t3ii4+/XXPId+xgs1z8GMpzLNg3JAtO8rCBoQxeNqJc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cWskSsjJtzf1bhPJx3CP8axw7BSRYcigbpuMHxJXZkXwUX4OZJvq2+2QWFVWfsmzG
	 v6SLFqN4o3jIYItvjuZttMylYvz0wUme1drvccDB1sNowiyTkhD8dML17EOyM42wKS
	 hXH6gaJcLa7BggbraAb0mKIFM6QVLUzsJsw+vc/D/JQvkJabQ92KwxkUlCfCLEQCm7
	 B3Ib20o+9eiPq+qBU0QEbKD5sumc0SBFwGGXnnZMnboiyPQzbJ8+uNqkLxu777OnXW
	 IB4sZwIOtvbH3CB/EyWd2fdcs0rPQnmv0uvQod2GjHkhMMDvMBvywl6eXbkM332DHw
	 f68xXG3ZoP6Iw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v21 07/21] perf evlist: Add reference count checking
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260616011543.4037138-8-irogers@google.com>
References: <20260616011543.4037138-8-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 01:44:44 +0000
Message-Id: <20260616014445.4B3D71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] Race condition in `evlist__put` lockless cycle-detection leadi=
ng to double-free.
- [High] Order-dependent memory leak of `evlist` and `evsel` objects due to=
 asymmetric cycle-breaking logic.
- [Low] Missing accessor replacement causes build failure on s390 when `REF=
CNT_CHECKING` is enabled.
--

commit 90f010720902ca448ae8e2550b479cb3776be988
Author: Ian Rogers <irogers@google.com>
Subject: perf evlist: Add reference count checking

Now the evlist is reference counted, add reference count checking so
that gets and puts are paired and easy to debug. Reference count
checking is documented here:
https://perfwiki.github.io/main/reference-count-checking/

> --- a/tools/perf/util/evlist.h
> +++ b/tools/perf/util/evlist.h
[ ... ]
> @@ -59,7 +60,7 @@ enum bkw_mmap_state {
> =20
>  struct event_enable_timer;
> =20
> -struct evlist {
> +DECLARE_RC_STRUCT(evlist) {
>  	struct perf_evlist core;
>  	refcount_t	 refcnt;
>  	bool		 enabled;

[Severity: Low]
Is a direct access to evlist->core.nr_entries missing an accessor replaceme=
nt?

With REFCNT_CHECKING enabled, struct evlist is replaced with this opaque
DECLARE_RC_STRUCT(evlist) wrapper. This requires all direct member accesses
to be migrated to accessor macros like evlist__nr_entries(). However,
auxtrace_record__init() in tools/perf/arch/s390/util/auxtrace.c still
accesses it directly:

        if (evlist->core.nr_entries =3D=3D 0)
                return NULL;

Will this cause a build failure on s390 when REFCNT_CHECKING is enabled?

> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
[ ... ]
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
> =20
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
Can this race when executed concurrently, leading to a double-free?

Looking at evlist__put() in tools/perf/util/evlist.c, if multiple threads
concurrently drop external references to the same evlist, they can both=20
decrement the atomic refcount without reaching zero. They would then=20
concurrently execute this fallback verification loop, read the exact same=20
evlist refcount, and independently subtract the internal cyclic references.=
=20

Could both threads calculate that the list should be destroyed and
simultaneously enter out_delete, freeing the evlist and all its evsel
structures twice?

> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
[ ... ]
> @@ -1811,28 +1830,33 @@ static PyObject *pyrf_evlist__add(struct pyrf_evl=
ist *pevlist,
[ ... ]
>  	evsel =3D ((struct pyrf_evsel *)pevsel)->evsel;
> -	evsel->core.idx =3D evlist->core.nr_entries;
> +	CHECK_INITIALIZED(evsel, "evsel");
> +
> +	evsel->core.idx =3D evlist__nr_entries(evlist);
>  	evlist__add(evlist, evsel__get(evsel));
> =20
> -	return Py_BuildValue("i", evlist->core.nr_entries);
> +	return Py_BuildValue("i", evlist__nr_entries(evlist));
>  }

[Severity: High]
Does this code create an order-dependent memory leak of the evlist and evse=
l=20
objects?

In Python bindings (pyrf_evlist__add), an explicit external reference is ad=
ded
to the evsel via evsel__get(evsel), making its refcnt =3D=3D 2. Because the=
 Python
garbage collector reclaims objects non-deterministically, the evlist might =
be
finalized before the evsel.

If evlist__put() runs first, it sees evsel->refcnt =3D=3D 2, determines the=
re are
external references, and skips teardown. Later, when the evsel is finalized,
evsel__put() simply drops the refcount to 1 and returns, as it lacks any
cycle-breaking logic. Does this permanently leak the evlist and all its
evsel structures since neither reaches 0?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616011543.4037=
138-1-irogers@google.com?part=3D7
