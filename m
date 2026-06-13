Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291AE1E505
	for <linux-perf-users@vger.kernel.org>; Sat, 13 Jun 2026 07:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781335794; cv=none; b=K0IGtdaTBjmYOtQrcs0Cbm/ZxJFXaersUuraxMSl9MQjW77qvCTDgbPTRzQvRaqCHTt7moqGJzI/gEV5yG3OMk2uKkiaUSqRQnDCgynz5x7JxPkAR2Li8jxwQ2f+A/FhW5mqSwTPEnKpy66++Vd/46KwMCJT3MX1JShLaJlXSno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781335794; c=relaxed/simple;
	bh=pTfQpO2VwM8gYk0tX1KUMSYCaIk+rppFiIhopZCa3YU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WRm2hlCrQKA3oYprW5YJkRGTfeo31r4EuF2C6ZQiqwskHa2YU386vdAynsq7E98w8rcmZMjvIzB8RwbEznTtBK4+mVTWmiKrJK/AriAMkjTs1CxvmV6/mq4zba8RFVfTqkM7KYSJmiSWRZZEGTthfKe+cr3H1GzR1qXpQQP8G4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M1VAFdHR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M1VAFdHR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4A831F000E9;
	Sat, 13 Jun 2026 07:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781335793;
	bh=uPmhWW6/HAGWF1pYUeaF2p2GUtKRtRl0UIqiFixBmAs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=M1VAFdHRQGw0iZL3L/JT7iQLizuM62DOF2Sn60zXPxJn85k46XPGoeBYVK2p4D6Zn
	 2XHY9n056SZxw89HMQZbU+jC6qoz6vxYA3KNSv8FslncNqMhntrstsHhJr3Tdnm4JN
	 2G+n9KGDFMS8pS9mR2n4Xznjwreb6qkCivx3n//9wQS6Xmi62JfFmZBVdA/5MZtCE9
	 TbafVZRBYYmPCMmnhv14jtVbk+J+XP19MPClD559G++J/waKZF4AfOEK3hCdRXbf4e
	 026AuxbR7tNu/NUoJq2++PaTB4rT+44bRF/pWhrMvSsv0sZ23gDGE0CaplJlIq8EyZ
	 UU8f97pb9oR/w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v17 07/20] perf evlist: Add reference count checking
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260613071100.1508192-8-irogers@google.com>
References: <20260613071100.1508192-8-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 13 Jun 2026 07:29:52 +0000
Message-Id: <20260613072952.E4A831F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] A Time-Of-Check to Time-Of-Use (TOCTOU) race condition in the `evl=
ist__put` cycle collection logic can lead to a double free of the `evlist`.
- [Medium] Asymmetric cycle collection in `evlist__put` causes permanent me=
mory leaks if an `evsel`'s external reference is dropped after its parent `=
evlist` is dropped.
--

commit 6816a1b1ec7caa8f9d0921878cf9f9ff972f1a6e
Author: Ian Rogers <irogers@google.com>

perf evlist: Add reference count checking

This commit adds reference count checking to the evlist to ensure that gets
and puts are paired and easy to debug. It adds accessors to evlist functions
and switches to their use.

> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index 1721a2470fb67..eb7c0d7be064e 100644
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

[Severity: High]
Can this TOCTOU race condition lead to a double free of the evlist?

If two threads concurrently drop their external references, and the total
refcount drops to 1, both threads might enter this retry loop concurrently.
If both read count =3D 1 and ref_cnt =3D 1, and both verify that the 1 rema=
ining
reference belongs to the evsel (decrementing their local count to 0), they
will both check refcount_read() !=3D ref_cnt (which evaluates to false).

Both threads would then proceed to the out_delete block, concurrently
executing the teardown sequence (evlist__purge, etc.) and freeing the
evlist.

> +	if (count !=3D 0) {
> +		/*
> +		 * Not the last reference except for back references from
> +		 * evsels.
> +		 */
> +		RC_CHK_PUT(evlist);
> +		return;
> +	}

[Severity: Medium]
Does this asymmetric cycle collection cause a permanent memory leak if an
external reference to an evsel is dropped after its parent evlist is droppe=
d?

The logic here handles cycle breaking if evsels have refcnt =3D=3D 1. Howev=
er,
if an external component (like Python bindings via pyrf_evlist__add) holds
a reference to an evsel, its refcnt is elevated (e.g., 2). If the external
reference to the evlist is dropped first, evlist__put sees the elevated
evsel->refcnt, aborts cycle collection, and returns without freeing the
evlist.

Later, when the external reference to the evsel is dropped, evsel__put
merely decrements evsel->refcnt to 1. Because evsel__put lacks symmetric
cycle-breaking logic, neither structure ever reaches a refcount of 0.

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

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260613071100.1508=
192-1-irogers@google.com?part=3D7
