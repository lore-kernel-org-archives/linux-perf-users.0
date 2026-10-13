Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD1155C1D1
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 22:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791931385; cv=none; b=do2r3WDVsHMycqDVjUREmkTJ9wGEpydcwIoC6UAfQa//YCRdZJ3C4/zlbrDZCulTUriwZSwI1dvgmiQz4byxQfFPzuTzbxa0vg1LIeOtMnezcInyylqfI2nA0FwbRyjVpicLly+xzR1jkyu2i5DBvhOH/XGE+KixuM0gpvevc18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791931385; c=relaxed/simple;
	bh=qsEofl9k83k4Og7GMzmYCIlEQ54kz/iBlfRqjG/ONY4=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=FIcNBK+zHzDqKyxFUs6HyjKz2tVfUdcOcbTPeI0J3U22RgbhHbujRwb2QwPUnr/WCEZ2mg0JzjiB6F1wfDioxKVk2oqydydMEQyGZYu6CSTKlM1CNZiVE0WGcKCWK6BPfFcw6fZooVriN2RNflDB/oUvzVuIPIlu614sn5LxDw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FahkFo8O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FahkFo8O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D7D11F00893;
	Tue, 13 Oct 2026 22:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791931381;
	bh=2AmswvNsumiV/LwLJPZgagXrZYh+hkNmxcxf6LpZ55w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FahkFo8OujrriPNv9wgg06QiVVj9rRzEIko5Yq4ll6sCweck5KXRAbiHqI5ePpPZI
	 z0SPNzaC57Mxb/MDnm3pnwnzIYVhjaQgK9zNN1YlEgjeYAT6y+TlkW9dfg+NoHgpZe
	 MRSq4Lic/vRxCbhQwnmOz5NTsIAFW984LeuithT1my6pM8Z9nyMjyyoVjJJTWuHfRS
	 vhwTenB6qMNajNq5vQRFs3glRWWd+ETgTVfpDnQtuqrFvBVyi/zlQ4UqWSWtFELhF3
	 ny4w4K6sXoDjhfKLK7XwZrDZuIP3EuoYMZ60K9Lb0lrG5JeXu4snCorfnomfFRQI3r
	 bYkcxAaXZbILw==
Message-ID: <sashiko-outbox-170593@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 07/10] perf dso: Fix unlocked __dsos__add() in vdso
 and expand lock annotations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261013222622.1822619-8-irogers@google.com>
References: <20261013182458.1234616-1-irogers@google.com>
 <20261013222622.1822619-1-irogers@google.com>
 <20261013222622.1822619-8-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 22:43:01 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] perf dso: Use-after-free of dso handle in dso__list_del
- [Medium] perf dso: TOCTOU race in dso__put crashes process via BUG_ON
- [Medium] perf: TOCTOU race in dsos__findnew_id() returns DSO with conflic=
ting ID
--

commit ec25e6950c1517fbc1aa1d6b77689a77a68b1b3d
Author: Ian Rogers <irogers@google.com>

perf dso: Fix unlocked __dsos__add() in vdso and expand lock annotations

This patch addresses a missing lock acquisition in __machine__addnew_vdso()
and introduces a read/write lock upgrade pattern for DSO ID improvement. It
also tightens locking for dso__list_del() to avoid lock inversions during
EMFILE eviction and expands lock annotations.

> diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
> index ff5b30a3d4240..21491625ec821 100644
> --- a/tools/perf/util/dso.c
> +++ b/tools/perf/util/dso.c
> @@ -539,13 +539,13 @@ static void dso__list_add(struct dso *dso) __must_h=
old(&_dso__data_open_lock)
>  static void dso__list_del(struct dso *dso) __must_hold(&dso__data_open_l=
ock)
>  {
>  	list_del_init(&dso__data(dso)->open_entry);
>  #ifdef REFCNT_CHECKING
> -	mutex_unlock(dso__data_open_lock());
> -	dso__put(dso__data(dso)->dso);
> -	mutex_lock(dso__data_open_lock());
> +	BUG_ON(refcount_dec_and_test(&RC_CHK_ACCESS(dso)->refcnt));

[Severity: Medium]
If two threads concurrently call dso__put() on a DSO with 3 references, won=
't
both threads read the refcount as 3 and bypass the refcount_read() =3D=3D 2
check?=20

If both drop the refcount to 1 without calling dso__data_close(), could a
later EMFILE eviction calling dso__list_del() hit this BUG_ON when the
refcount unexpectedly drops to 0?

> +	RC_CHK_PUT(dso__data(dso)->dso);
> +	dso__data(dso)->dso =3D NULL;

[Severity: High]
Does RC_CHK_PUT() free the handle that is immediately dereferenced on the
next line when evaluating the dso__data(dso) macro, resulting in a heap
use-after-free during EMFILE eviction?

>  #endif
>  	WARN_ONCE(dso__data_open_cnt <=3D 0,
>  		  "DSO data fd counter out of bounds.");

[ ... ]

> @@ -1804,7 +1804,7 @@ struct dso *dso__get(struct dso *dso)
>  void dso__put(struct dso *dso)
>  {
>  #ifdef REFCNT_CHECKING
> -	if (dso && dso__data(dso) && refcount_read(&RC_CHK_ACCESS(dso)->refcnt)=
 =3D=3D 2)
> +	if (dso && dso__data(dso)->dso && refcount_read(&RC_CHK_ACCESS(dso)->re=
fcnt) =3D=3D 2)
>  		dso__data_close(dso);
>  #endif
>  	if (dso && refcount_dec_and_test(&RC_CHK_ACCESS(dso)->refcnt))

[ ... ]

> diff --git a/tools/perf/util/dsos.c b/tools/perf/util/dsos.c
> index a2cd37bd16602..0e4307e357689 100644
> --- a/tools/perf/util/dsos.c
> +++ b/tools/perf/util/dsos.c
[ ... ]
> @@ -343,8 +354,20 @@ static struct dso *__dsos__findnew_id(struct dsos *d=
sos, const char *name, const
>  struct dso *dsos__findnew_id(struct dsos *dsos, const char *name, const =
struct dso_id *id)
>  {
>  	struct dso *dso;
> +
> +	down_read(&dsos->lock);
> +	dso =3D __dsos__find_id(dsos, name, id, false, /*write_locked=3D*/false=
);
> +	if (dso && !dso__needs_improve_id(dso, id)) {
> +		up_read(&dsos->lock);
> +		return dso;
> +	}
> +	up_read(&dsos->lock);
> +
>  	down_write(&dsos->lock);
> -	dso =3D __dsos__findnew_id(dsos, name, id);
> +	if (dso)
> +		__dso__improve_id(dso, id);

[Severity: Medium]
If two threads concurrently call dsos__findnew_id() for the same DSO name b=
ut
with different valid IDs, couldn't both find the same empty DSO under the
read lock?

When they subsequently acquire the write lock, since the cached dso pointer
is used unconditionally without re-validation, could one thread incorrectly
receive a DSO that was just updated with the other thread's ID, leading to
incorrect symbol resolution and corrupted tracking structures?

> +	else
> +		dso =3D __dsos__findnew_id(dsos, name, id);
>  	up_write(&dsos->lock);
>  	return dso;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013222622.1822=
619-1-irogers@google.com?part=3D7
