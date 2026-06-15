Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3BA270575
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 06:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781506067; cv=none; b=mDWivP4z3WDVwcxe6tXlpHx/HaVm7EV8fGpDvQXhr+nqrzsAVrrIGSyJEJEte4uB0QkJwWpTcTq9NN6oF+qi6ASb+82UpKvD9TDX9b+3V8hQ3vV+SPHcaIhjawkEQrAIfJ4P786cIcesG2BvffNsav+W68l72cCxO47i1z5mXoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781506067; c=relaxed/simple;
	bh=TLMZUoheUltm3md6xY/bLJibH7LclpsMAazwXxnjRIo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=chTtTGZVxDE4smJ2g0ApwpJkVEV64qX8kU8zlB+pyWgPCnJ7elyTZFyjRfFseDL6ggrdhQM1N+t2PVm71TaprkdIaHV1wDJTsED0Uc6cbkR2nueeqFeHBxmrNu8axXjAiHAfkZ/wTnFPIH+A+15R0k5CFgzc/mbbIT007XP244A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BU2hBoPG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BU2hBoPG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF7E21F000E9;
	Mon, 15 Jun 2026 06:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781506063;
	bh=DF7BrweVNTE4j6MF6FThdjgkdQZeZKR9Y5gVM3whQSk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BU2hBoPG0s6pDrmFQxXP7OY5AV+GRkn1Ovz0uRH0Ffy/tNOrBxs3uROT+BpLARofG
	 vtVRMqOa4Lp5KRXwgSZ5TCaEvuJEfvSmsFT0kIICzNL1VswfueTdcUYCkA3dR4s96s
	 TtKtZlhH16XqgtzfT5hJHQJyX27CS0f8/GQnoxmYO2AsnKzYEMXJlPbTOhW+RLeT0c
	 Z/+N2YIILjnZmMTJI12turjsWHXbZ/tTosehNZIiI3gzSBBtENRMR6mKBO4N/xVcvy
	 s0nmYDqKy1TMJMdFvR+1gXVjiCFOxm4znC2+8yNq+i2iwHFYVBidwQHFs0s1yDiFUt
	 /1e7UI02uxR4g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 07/20] perf evlist: Add reference count checking
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260615061631.2382079-8-irogers@google.com>
References: <20260615061631.2382079-8-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 06:47:42 +0000
Message-Id: <20260615064742.EF7E21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Use-After-Free and Double Free race condition in `evlist__put` cyc=
le collection logic.
- [High] Asymmetric cycle collection logic causes a permanent memory leak d=
epending on the order of object deletion.

Pre-existing issues:
- [High] Use-after-free of `rec->sb_evlist` on the error path when the BPF =
side-band thread fails to start in `perf record`.
--

commit 55ab8400c083f327ca6388cf200713b68d5ff7b4
Author: Ian Rogers <irogers@google.com>

perf evlist: Add reference count checking

Now the evlist is reference counted, add reference count checking so
that gets and puts are paired and easy to debug.

> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index 1721a2470fb67..eb7c0d7be064e 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c

[ ... ]

> @@ -215,11 +222,34 @@ static void evlist__exit(struct evlist *evlist)
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

[Severity: High]
Does this sequence create a use-after-free race condition?=20

Looking at the new cycle collection logic in evlist__put(), if
refcount_dec_and_test() returns false, it indicates that the current thread
has dropped its reference, but the object's refcount has not reached zero.
However, the thread then proceeds to access the evlist in the retry loop.

If another thread drops the final external reference concurrently, it will
evaluate count =3D=3D 0 and proceed to out_delete, freeing the evlist. The =
first
thread, which is still executing the retry loop, would then access the freed
evlist. Could this also lead to a double free if the first thread independe=
ntly
concludes count =3D=3D 0?

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

[Severity: High]
Can this asymmetric cycle collection logic cause a permanent memory leak?

The patch series creates a reference cycle between evlist and evsel by
replacing the entry->evlist back-pointer assignment with a reference-counted
evlist__get(evlist). To break this cycle, evlist__put() includes the check
above to destroy the evlist if the only remaining references come from its =
own
evsels.

However, this cycle-breaking check only runs during evlist__put(). If an
external caller (like the Python bindings) holds references to both objects
and drops the evlist first, evlist__put() will see the evsel's refcount > 1
and correctly return without freeing.

When the caller subsequently drops the evsel, evsel__put() merely decrements
the refcount without checking for the isolated cycle. Since neither object's
refcount will ever reach 0, won't this leak both objects?

[ ... ]

> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index e4fa77a40dacb..ebd3ed0c9b3e8 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c

[ ... ]

> @@ -4283,14 +4284,14 @@ int cmd_record(int argc, const char **argv)
>  out_delete_session:
>  #ifdef HAVE_EVENTFD_SUPPORT
>  	if (done_fd >=3D 0) {
>  		fd =3D done_fd;
>  		done_fd =3D -1;
> =20
>  		close(fd);
>  	}
>  #endif
>  	zstd_fini(&session->zstd_data);
>  	if (!opts->no_bpf_event)
>  		evlist__stop_sb_thread(rec->sb_evlist);

[Severity: High]
This isn't a bug introduced by this patch, but does this error path cause a
use-after-free if the BPF side-band thread fails to start?

In __cmd_record(), if record__setup_sb_evlist(rec) fails (e.g., due to fail=
ing
to create the side-band thread in evlist__start_sb_thread()), the underlying
evlist__start_sb_thread() function frees the sb_evlist via evlist__put()
before returning an error:

tools/perf/util/sideband_evlist.c:evlist__start_sb_thread() {
    ...
out_put_evlist:
    evlist__put(evlist);
    return -1;
}

The error path in __cmd_record() goes to out_free_threads, which falls thro=
ugh
to out_delete_session. Because opts->no_bpf_event is not set to true upon t=
his
failure (unlike the analogous handling in builtin-top.c), the cleanup code
calls evlist__stop_sb_thread(rec->sb_evlist) with the already-freed pointer.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615061631.2382=
079-1-irogers@google.com?part=3D7
