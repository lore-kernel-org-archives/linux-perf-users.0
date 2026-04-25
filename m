Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D3B2309B2
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 18:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777141736; cv=none; b=O+jlO7VmJmITgB70E8sEFVWVFqCrqjbztKjrfvNRJCjX8QFfIbD4nTt54SzCiXqk8bMPjiKDKKV+6b5KZEa+V8+Cqczd7n4l+WwyrfMeKO+ANkravIDbWYogoR48Zup56ObXZYdi3xTa68ZtnE1Vw72YbdZQQoeOMviqzv5KhvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777141736; c=relaxed/simple;
	bh=XQXFaZTbAwm+V1aSf+34nfiQY4SRlgU5WZzc45fPdZs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ll7HVoM/RVAgvfBHs9Cy+yQC8zsk9vNEh9iUF+lb4k6Ffc3TdnLnD5RVxwILKqOknP+s3yBuhHVRHwcHsWPO582eSh8tPwt36aJFmAKkR93gTfQbGk0W8/McJ2ZkROEDt3HyZJKZeUHDoWwUR/sLCDMriiAKNfMWMAkhQRUKKaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rJAckS4U; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rJAckS4U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27B62C2BCB0;
	Sat, 25 Apr 2026 18:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777141736;
	bh=XQXFaZTbAwm+V1aSf+34nfiQY4SRlgU5WZzc45fPdZs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=rJAckS4UpjOtG/YWxu/JuSb+UrB7WWh4bLgac0aooMuk9wzMx7znpmsRbxJzBitZj
	 qd1of2ynpqZhdNVXFChQjThfF5DV3joUcag20fNrvEFeh+rmLWyqpgijF1smQ0aAVc
	 DchmVyROxz5cj66DfnnITYtkrQBstPswS6GN0pNfClH5K9yGSLUrSugjQgjVglBKWG
	 J0imuDBa6y5HzkQJ3/UuBotry6QbA3GSLQoDcqwKeWVkySFULO5kEqZYbl+G/8Hv1s
	 tFChoICiEauu/CJVt2NFI6to9jhkkWEHm7B6T5Pr4wp5QQQoBwGcn7HamRJ3YwPZuD
	 1OxMg0OxxuncA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 12/59] perf evlist: Add reference count checking
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260425174858.3922152-13-irogers@google.com>
References: <20260425174858.3922152-13-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Apr 2026 18:28:55 +0000
Message-Id: <20260425182856.27B62C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 3 potential issue(s):
- [Critical] Double-free due to racy cycle-breaking garbage collection in `=
evlist__put()`.
- [High] Memory leak of `evlist` structures when splicing `evsel` entries.
- [High] Reference leak of `evsel` objects during event delivery.
--

commit 7675a76ec470f3ac5b584c42e3168949ccf7a93e
Author: Ian Rogers <irogers@google.com>

perf evlist: Add reference count checking

This patch adds reference counting and checking for evlist to ensure gets a=
nd
puts are paired correctly. It also renames evlist__mmap to evlist__do_mmap
and introduces accessors for evlist variables.

> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index a362f338f104..29588af735e5 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c

[ ... ]

> @@ -193,52 +200,76 @@ static void evlist__purge(struct evlist *evlist)
> =20
>  	evlist__for_each_entry_safe(evlist, n, pos) {
>  		list_del_init(&pos->core.node);
> +		if (pos->evlist) {
> +			/* Minimal evlist__put. */
> +			refcount_dec_and_test(evlist__refcnt(pos->evlist));
> +			RC_CHK_PUT(pos->evlist);
> +		}
>  		pos->evlist =3D NULL;
>  		evsel__put(pos);
>  	}

Does this code leak the source evlist when splicing entries?

When evsel entries are moved from one evlist to another via
evlist__splice_list_tail(), their pos->evlist back-pointers are not updated.

When evlist__purge() later cleans up the destination evlist, it does a
minimal put on the old pos->evlist. However, if refcount_dec_and_test()
returns true, the result is ignored, so the cleanup logic and actual freeing
of the old evlist are bypassed.

Additionally, since the old evlist is now empty, a normal evlist__put() on
it would fail to break the reference cycle because it loops over an empty
list, failing to find the outstanding references.

[ ... ]

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
>  	evlist__free_stats(evlist);
> -	evlist__munmap(evlist);
> +	evlist__do_munmap(evlist);

Can this sequence lead to a double-free memory corruption?

If two threads concurrently release their external references to an evlist,
both might see refcount_dec_and_test() return false.

If they both proceed to read the refcount, iterate over the list, and
decrement count to 0, wouldn't both threads independently jump to out_delete
and free the evlist twice?

> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index deb5b9dfe44c..f9fafbb80a9d 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c

[ ... ]

> @@ -1426,7 +1430,7 @@ static int session__flush_deferred_samples(struct p=
erf_session *session,
>  	struct deferred_event *de, *tmp;
>  	int ret =3D 0;
> =20
> -	list_for_each_entry_safe(de, tmp, &evlist->deferred_samples, list) {
> +	list_for_each_entry_safe(de, tmp, evlist__deferred_samples(evlist), lis=
t) {
>  		struct perf_sample sample;
> =20
>  		perf_sample__init(&sample, /*all=3D*/false);
> @@ -1438,6 +1442,8 @@ static int session__flush_deferred_samples(struct p=
erf_session *session,
>  		}
> =20
>  		sample.evsel =3D evlist__id2evsel(evlist, sample.id);
> +		if (sample.evsel)
> +			sample.evsel =3D evsel__get(sample.evsel);
>  		ret =3D evlist__deliver_sample(evlist, tool, de->event,
>  					     &sample, sample.evsel, machine);

Does this leak the evsel reference?

We acquire an evsel reference using evsel__get() here, but unlike
evlist__deliver_deferred_callchain() which correctly drops it via
evsel__put() after delivery, the reference doesn't seem to be released
after calling evlist__deliver_sample().

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
> -
> +	}
>  	evsel =3D sample->evsel;

Could this also leak the evsel reference?

Similar to the regression in session__flush_deferred_samples(), we get
a reference via evsel__get() when populating a missing sample->evsel,
but there appears to be no corresponding evsel__put() after the tool
callbacks are invoked.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260425174858.3922=
152-1-irogers@google.com?part=3D12
