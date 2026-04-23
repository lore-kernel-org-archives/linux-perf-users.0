Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3EB2269D18
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 04:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776918882; cv=none; b=Bw0/Xvmdg3MmRaWdjUbnaXmF0GLQd0E1AojKgtgFyNDyv/JBKoGN7FoGhSphk4mK9NKVn+g4BVqM3fLn+4iYynT9WpTRXEVQ6JV62B/rhJFvqvJ+hYYC9H9vSkEPnwk3JU4IJAlJoREMnLeHDR/rsOTFrTI3rDUXwd+72oeH8PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776918882; c=relaxed/simple;
	bh=51rezRCmkTtYjr4gHY1XIAluVXQOy40k0sYI/sukCTo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SYLnsB0PF6kjsr/mQDNzVOQpuaZDuVkKltnGrWI2glCGwG5/kZq5LIrHPTgtC/1ccEG+bRiERrjW2QWR56BKvwJiudlkrUNRjB6EwzI+cA8TyUaaWEFIHY+Qwq7te17NzHDEaIeKCrStWc6Fc1skoFcr0gJcqTW9cnhPc1yk2kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=anDcWUJc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="anDcWUJc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BF98C2BCB2;
	Thu, 23 Apr 2026 04:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776918881;
	bh=51rezRCmkTtYjr4gHY1XIAluVXQOy40k0sYI/sukCTo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=anDcWUJc8X/M5QZz3DFb+hneOP+g0RCb4JgPNQdU8E1rZE4z7UE8doqdR0fBQws20
	 9/RQE36/sLEbFHibzu8XkH1xSNHbTbx25knqEKDTEsFS99VxHuD3w2mknYEh0QpsT/
	 t6gTc2lMjonUuh//TxvxztWY7YZ07Dj9NsR/tlyGz87PdOpsu2uwkWEKN2nq1jp6AX
	 DOWddxtmeRgJVR7G1B+wuUP9wlpx+sIoFa1AUtLV0LDEjlpyPwEfv/DaV6e1Uuux6w
	 6VJ0Q0vOvR1DkjG/ocdSffuWvhjNISYW754DWCsgKfISCEB5j7bYQiI55YvgU76qI/
	 s1m6yw2l3Hgpw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 12/58] perf evlist: Add reference count checking
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260423035526.1537178-13-irogers@google.com>
References: <20260423035526.1537178-13-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Apr 2026 04:34:40 +0000
Message-Id: <20260423043441.6BF98C2BCB2@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 4 potential issue(s):
- [High] Deterministic Use-After-Free in `evlist__remove` due to incorrect =
order of operations
- [High] Thread-safety violation in `evlist__put` cyclic reference detectio=
n leading to double-free race conditions
- [Medium] Refcount leak of `evsel` objects during sample delivery
- [Low] Missing NULL check on `from_list_start()` result in `perf_evlist__m=
map_cb_idx()`
--

commit 3bea95f5803afd016cc89a08d42f43d3d2c999dd
Author: Ian Rogers <irogers@google.com>

    perf evlist: Add reference count checking

    Now the evlist is reference counted, add reference count checking so
    that gets and puts are paired and easy to debug. Reference count
    checking is documented here:
    https://perfwiki.github.io/main/reference-count-checking/

> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
[ ... ]
> @@ -211,25 +225,44 @@ static void evlist__exit(struct evlist *evlist)
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

Is this new cyclic reference detection thread-safe?

It appears to perform a non-atomic two-step check. If refcount_dec_and_test=
()
returns false, it proceeds to read the decremented refcount and iterate over
the entries without holding any locks.

If two threads drop their external references concurrently, could both thre=
ads
compute count =3D=3D 0 and concurrently fall through to the out_delete path=
? This
would lead to list corruption and a double free.

[ ... ]
> @@ -238,15 +271,16 @@ void evlist__add(struct evlist *evlist, struct evse=
l *entry)
> =20
>  void evlist__remove(struct evlist *evlist, struct evsel *evsel)
>  {
> +	evlist__put(evsel->evlist);
>  	evsel->evlist =3D NULL;
> -	perf_evlist__remove(&evlist->core, &evsel->core);
> +	perf_evlist__remove(evlist__core(evlist), &evsel->core);
>  }

Can this order of operations trigger a use-after-free?

Because evlist__put() is called before perf_evlist__remove(), the evsel
is still linked in the list. When evlist__put() iterates over the list to
detect cyclic references, it might count this evsel as an internal referenc=
e.

This could artificially reduce the external reference count to 0 and
prematurely free the evlist. Immediately after evlist__put() returns,
perf_evlist__remove() is called, which would dereference the freshly freed
evlist pointer.

[ ... ]
> @@ -881,14 +910,24 @@ static void
>  perf_evlist__mmap_cb_idx(struct perf_evlist *_evlist,
>  			 struct perf_evsel *_evsel,
>  			 struct perf_mmap_param *_mp,
>  			 int idx)
>  {
> -	struct evlist *evlist =3D container_of(_evlist, struct evlist, core);
> +	struct evlist *evlist =3D from_list_start(_evlist);
>  	struct mmap_params *mp =3D container_of(_mp, struct mmap_params, core);
>  	struct evsel *evsel =3D container_of(_evsel, struct evsel, core);
> =20
>  	auxtrace_mmap_params__set_idx(&mp->auxtrace_mp, evlist, evsel, idx);
> +
> +	from_list_end(evlist);
>  }

Should we verify if evlist is NULL before using it?

When REFCNT_CHECKING is enabled, from_list_start() allocates memory for a
new wrapper and can return NULL on failure. In this case, passing evlist to
auxtrace_mmap_params__set_idx() will dereference it, which might cause a
segmentation fault.

> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
[ ... ]
> @@ -1371,13 +1371,15 @@ static int evlist__deliver_deferred_callchain(str=
uct evlist *evlist,
>  		struct evsel *saved_evsel =3D sample->evsel;
> =20
>  		sample->evsel =3D evlist__id2evsel(evlist, sample->id);
> +		if (sample->evsel)
> +			sample->evsel =3D evsel__get(sample->evsel);
>  		ret =3D tool->callchain_deferred(tool, event, sample,
>  					       sample->evsel, machine);
>  		sample->evsel =3D saved_evsel;
>  		return ret;
>  	}

Is it possible that we are leaking an evsel reference here?

The code acquires a reference with evsel__get(), but then sample->evsel is
overwritten with saved_evsel without a corresponding call to evsel__put().

Since Perf processes millions of events, could this leak a reference for ev=
ery
processed sample?

There are similar additions of evsel__get() without evsel__put() in
session__flush_deferred_samples() and machines__deliver_event() in this fil=
e.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260423035526.1537=
178-1-irogers@google.com?part=3D12
