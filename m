Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E004B1B36
	for <linux-perf-users@vger.kernel.org>; Thu,  3 Sep 2026 13:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788443525; cv=none; b=tORdS6X+W90ssxgrmoydfK1wlGGrwUaFAXVUMZhOO2A6XvjKeN/XBKBF5vX02hkBedJXqYo1D9P52va6cDp1VmIguW8Su4Jn2HXwNZCJzyDotvGiFIraCBW2lZBWArr76NtTL5Obn+3DN1qFrJ0rPA3naHXOI407QM+39DFvah8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788443525; c=relaxed/simple;
	bh=X/sgSr6KJYUenhyUbBZEgb4A+qtg98TwJI5DteWdWfM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AsaF96qY1rvdTALvgABgiV6JYlIkBLbENbkngimgk+kAa0BOeibAap2uchodr+91GjbZ+WdOUKU6tS7OCmORJlT5tNeAGDNfNXhDfiF1k4gz6x+Rf950DaeqFZtdsz4c7tsbhn8xITZuoG4bx9siM1clYv/TsgKbvlPJIlzuNu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ndjjPWMn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ndjjPWMn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B0A81F00ADE;
	Thu,  3 Sep 2026 13:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788443510;
	bh=hVZlJteyrdNM6zusS3Xc2wWzvlVEpPwxMJbEFCHaN/U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ndjjPWMniMztT95Mo9hd/JG801L24WhG4w+CDoVM0q2gMJhPfbCHj5gNKAmIRU1bB
	 enf7VKp6dd3m00IHRFvjQlzpPbuZRlz6+4DTGoxuSPhCDCxD7P3Ukkai9IVXUcMXgA
	 ddYMT2kAkafxkCZIXQAIdID9i/WTacEH9FPpPdTJ0++fyBhZ5a6jN5g5zFfMEsCQwQ
	 Uj+fOtCvcJgMS/qVCuKUdzHg7XB6zSL/wiaYm5GGTD9p3DI7y9Vx7XMULxCB3QulG7
	 7i5CFGUf+TY4qIYatLlYVB0J4xUwul9JZwMlY3hA3i1w7NqwACeoo5LJdolQVcsb4I
	 p86qx5S+Gq+LQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/5] perf dso: Defer dropping the open list reference
 until after the lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260903132251.237029-6-acme@kernel.org>
References: <20260903132251.237029-1-acme@kernel.org>
 <20260903132251.237029-6-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 13:51:49 +0000
Message-Id: <20260903135150.1B0A81F00ADE@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Failing to allocate a deferred put node leaks the reference hand=
le and causes a memory leak of the DSO object.
--

commit a29267f86fa45a10095cc91a7c0350e522de6c4a
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf dso: Defer dropping the open list reference until after the lock

This patch addresses a deadlock and resource imbalance issue by deferring
the dropping of the DSO open list reference. It transfers the reference to a
deferred node during dso__list_del(), which is later drained by
dso__put_deferred() outside of the dso__data_open_lock.

> diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
> index 42bfe30a3b518..a4b2361bc7420 100644
> --- a/tools/perf/util/dso.c
> +++ b/tools/perf/util/dso.c
[ ... ]
> @@ -531,18 +531,79 @@ static void dso__list_add(struct dso *dso) EXCLUSIV=
E_LOCKS_REQUIRED(_dso__data_o
>  	dso__data_open_cnt++;
>  }
> =20
> +#ifdef REFCNT_CHECKING
> +/*
> + * A deferred put: carries the reference taken by dso__list_add() for an
> + * entry removed from dso__data_open.  Dedicated nodes are used so that
> + * the dso_data's own open_entry node can be relinked by a concurrent
> + * dso__list_add() without corrupting this list or its reference.
> + */
> +struct dso_data_put {
> +	struct list_head entry;
> +	struct dso *dso;
> +};
> +static LIST_HEAD(dso__data_open_put);
> +#endif
> +
>  static void dso__list_del(struct dso *dso) EXCLUSIVE_LOCKS_REQUIRED(_dso=
__data_open_lock)
>  {
> -	list_del_init(&dso__data(dso)->open_entry);
>  #ifdef REFCNT_CHECKING
> -	mutex_unlock(dso__data_open_lock());
> -	dso__put(dso__data(dso)->dso);
> -	mutex_lock(dso__data_open_lock());
> +	struct dso_data_put *put;
>  #endif
> +
> +	list_del_init(&dso__data(dso)->open_entry);
>  	WARN_ONCE(dso__data_open_cnt <=3D 0,
>  		  "DSO data fd counter out of bounds.");
>  	dso__data_open_cnt--;
> +#ifdef REFCNT_CHECKING
> +	/*
> +	 * The reference taken in dso__list_add() cannot be dropped while
> +	 * holding the open lock: dso__put() may call dso__data_close(),
> +	 * which takes dso__data_open_lock itself, deadlocking and leaving
> +	 * the list/counter state inconsistent for concurrent threads.
> +	 * Transfer the reference to a deferred node drained by
> +	 * dso__put_deferred() once the lock is released.
> +	 */
> +	put =3D zalloc(sizeof(*put));
> +
> +	if (put =3D=3D NULL)
> +		return;

[Severity: Medium]
Does this early return cause a memory leak of the DSO object if zalloc fail=
s?

During dso__list_del(), returning early without placing the deferred put no=
de
onto dso__data_open_put abandons the reference in dso__data(dso)->dso. If t=
he
DSO is subsequently added to the open list again, dso__list_add() could
overwrite this pointer with a new reference, permanently leaking the prior =
one
and preventing the DSO reference count from ever reaching 0.

> +
> +	put->dso =3D dso__data(dso)->dso;
> +	dso__data(dso)->dso =3D NULL;
> +	list_add_tail(&put->entry, &dso__data_open_put);
> +#endif
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903132251.2370=
29-1-acme@kernel.org?part=3D5
