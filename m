Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762E6413607
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 17:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781543447; cv=none; b=CpdMtn6sLm1IgwSZV+wZxcuCPWpFpSUqONJjTDoYMCXXBsrhs96vuNxu6jaYckej2y26iFiKcs1ZBxV1LaAOc56KS4E4AQfTlQ3Tr7x22G2sCzPI5KllBebxm17CSGCslKZrQPu7T6kXrMKqK2fEisGjJOlCBlA58//99mRCcNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781543447; c=relaxed/simple;
	bh=w0//57EVew2W1kQr0fi9rtMgmPZNMnunWKGWNA+xHEs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qvHRRunKYZa8FTB/3sCXBfoTD1G7rGKzWQgIUij2i4EJ0+YHHvQE9ya+4mglID07srXoW8Vfna1mXA6sQbynYyza4w7E+M3oPAUeZzbnu4I53jOJikrIqXSoCXoi2ydwPzntJSJB8fv1/eflThhRhQQGR+60C02JrdBPPbJESng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ctUZsN8S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ctUZsN8S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E72811F00A3A;
	Mon, 15 Jun 2026 17:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781543446;
	bh=pOJ5mNHEC+JNQo7bQNVDVfPEAV4EpQGMQ6JMa5M27dY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ctUZsN8Sd9vymIvY4z9b1V6U6n6k2j9StjNOcfxpzP3pM4n6ztqwfFKcxwINdGxNV
	 C6bBBoiXLOAoBAVNbMFcy/k3E8ySWby8QnH1Ev2pGJP+yQDRvNubI3Cir19IRvM4iZ
	 JohZNTl47jSpcWVKTFSLXDE1G42DIUFAWGdqN/4ualhP8WTiIcZ4hnVfjpzz/xocyh
	 7sviPkX7Q4AN4Xa5iKfQNfsPD0FgWgz3me8J9/nULbkODFt7SCiQtdSlBu98x9FsPD
	 eetkKhfLVAszkHFEiqJDJUdFdOwwL9pu6hBpy7d603f4N6YdLsrtWk5Idi4XBxu1Ht
	 T6ZEMs2lppttQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 07/20] perf evlist: Add reference count checking
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260615165010.2724690-8-irogers@google.com>
References: <20260615165010.2724690-8-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 17:10:45 +0000
Message-Id: <20260615171045.E72811F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Concurrent calls to evlist__put can result in a Use-After-Free and=
 Double-Free due to a Time-of-Check to Time-of-Use (TOCTOU) race condition =
in the lockless cycle detection algorithm.
- [High] The reference counting cycle between evlist and evsel permanently =
leaks memory if the last external reference to an evsel is dropped after it=
s parent evlist.
- [High] The entire `evlist` and its associated events are permanently leak=
ed when an event with an empty CPU map is added.
--

commit 756cc8f8292d82ab9ae38d1c37176f23a076f8e9
Author: Ian Rogers <irogers@google.com>

perf evlist: Add reference count checking

This commit adds reference count checking to evlist so that gets and puts
are paired and easy to debug. It adds accessors to evlist functions and
switches to their use.

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
Can concurrent calls to evlist__put trigger a double-free here? If two
threads drop the last two external references to evlist concurrently,
refcount_dec_and_test returns false for both. Both threads then read the
same ref_cnt, decrement their local count, and simultaneously enter the
out_delete block, freeing the evlist twice.

> +
> +	if (count !=3D 0) {
> +		/*
> +		 * Not the last reference except for back references from
> +		 * evsels.
> +		 */
> +		RC_CHK_PUT(evlist);
> +		return;
> +	}

[Severity: High]
Does this cycle detection only happen in evlist__put? If the last external
reference to an evsel is dropped after its parent evlist is released,
evsel__put does not have symmetric cycle detection. The evsel refcount
would drop to 1, leaving the unbroken cycle intact and leaking both objects.

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

[Severity: High]
If perf_evlist__add removes the event from evlist entries (for example, if
the event has an empty CPU map), does evlist__get here orphan the event?
Because it would be removed from the list, evlist__purge will never call
evsel__put on it, permanently leaking the evsel and leaving an unbroken
cycle that leaks the entire evlist.

>  	entry->tracking =3D !entry->core.idx;
> =20
> -	if (evlist->core.nr_entries =3D=3D 1)
> +	if (evlist__nr_entries(evlist) =3D=3D 1)
>  		evlist__set_id_pos(evlist);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615165010.2724=
690-1-irogers@google.com?part=3D7
