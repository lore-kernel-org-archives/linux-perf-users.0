Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6E14A6CE4
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 18:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791916870; cv=none; b=cM7fwA9AChRIi7HSpuZSUFHnzqG4ICr4EXBUuuunCCdeq1ie/QRgSnqYzUaS+19u4PxmUPFwO3jkhb4/NMa0hSN5PRLQbSNZCulOVzdKQ/mlJERD8cWBOMsah+LhsG3vYrddPhlmYk+hGMVd7zSXHJy6Ske/g/f/iYj69b0/nYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791916870; c=relaxed/simple;
	bh=zDpc1Owxit19bPDHanhgcEFGk2NI4FyBYqQLlSOO68k=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=QamkLL1N1pwbf52KapLr2OeZHU90RBL9xSSk7rAvM0M7NGocfXPTqMuwGEQDWBPqxNluMOsPWb9GB7YorMYrIzCNlESL4yS2EMNIq5bxd95Yz/td/Vr8XCyqdQDY0g+496wsnUShtKhzP0iLD28mbCnjGpVl9EQrtrlWCrU6bRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KxNQVqFp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KxNQVqFp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA53A1F000FF;
	Tue, 13 Oct 2026 18:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791916868;
	bh=Dz0vZIAvDDmHEonbrhyG7KyzRG0fHjauwwKzbaezJGY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KxNQVqFpWFYti7Xqub+N5MCb6kla9ToSX/rOfuWVim8abofJ9ueaDLVItURioi7zU
	 LzEzUrI9VF7wVD82KJRbZXVxvv2usC4f9kbFXG0q6kzNri0MAuQxZvtVBt2SMj9FL/
	 xfazYoBnS8r7plvtiteRk2LMimxW/YyjiLXlSa1HZdCkxbaDXZU0+sx1iM5u9u5D2e
	 W3L2cxSIa/42DnIQEDq+i/0AJtzdYL2kDblZMeeK2jbkxYCA/IGzTwuwe9mFyQuKGV
	 mpRLqQAX7npOuF2xD6E81WXwO2a5IAHiGT8XGtET2nhDKNNHlqQ4tfUnT21vt2u9+l
	 dr1TPTncFeG6w==
Message-ID: <sashiko-outbox-170345@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 07/10] perf dso: Fix unlocked __dsos__add() in vdso
 and expand lock annotations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261013182458.1234616-8-irogers@google.com>
References: <20261013182458.1234616-1-irogers@google.com>
 <20261013182458.1234616-8-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 18:41:08 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] perf dso: AB-BA lock inversion deadlock between dso__data_open_loc=
k and dso->lock during fd eviction
- [High] perf dso: Out-of-bounds list access and crash due to dropped lock =
desyncing open count
- [Medium] perf vdso: TOCTOU race in machine__findnew_vdso allows duplicate=
 VDSO dso insertion
--

commit 8889b552b9a0b44cdbc90055b9073e8918dcfc00
Author: Ian Rogers <irogers@google.com>

perf dso: Fix unlocked __dsos__add() in vdso and expand lock annotations

This commit expands lock annotations for the struct dsos lock and struct
dso data structures, updating locking primitives to ensure proper=20
concurrency tracking. It also switches VDSO addition to use the=20
locked dsos__add function.

> diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
> index ff5b30a3d4240..87a92238d25ba 100644
> --- a/tools/perf/util/dso.c
> +++ b/tools/perf/util/dso.c
[ ... ]
> @@ -552,13 +539,13 @@ static void dso__list_add(struct dso *dso) __must_h=
old(&_dso__data_open_lock)
>  	dso__data_open_cnt++;
>  }
> =20
> -static void dso__list_del(struct dso *dso) __must_hold(&_dso__data_open_=
lock)
> +static void dso__list_del(struct dso *dso) __must_hold(&dso__data_open_l=
ock)
>  {
>  	list_del_init(&dso__data(dso)->open_entry);
>  #ifdef REFCNT_CHECKING
> -	mutex_unlock(dso__data_open_lock());
> +	mutex_unlock(&dso__data_open_lock);
>  	dso__put(dso__data(dso)->dso);
> -	mutex_lock(dso__data_open_lock());
> +	mutex_lock(&dso__data_open_lock);
>  #endif

[Severity: High]
Does dropping the lock before decrementing the count open a window for an
out-of-bounds access?

In dso__list_del(), the entry is removed from the list via list_del_init()
before dso__data_open_lock is dropped under REFCNT_CHECKING. However,
dso__data_open_cnt is not decremented until after the lock is reacquired.

If the list had exactly one element, it is now empty, but the count remains
positive during the unlocked window.

If another thread calls do_open() and hits EMFILE during this window, it
checks dso__data_open_cnt. Seeing a positive count, it will call
close_first_dso(), which blindly executes list_first_entry() on the empty
dso__data_open list. This results in an invalid pointer and subsequent memo=
ry
corruption.

>  	WARN_ONCE(dso__data_open_cnt <=3D 0,
>  		  "DSO data fd counter out of bounds.");
> @@ -567,7 +554,7 @@ static void dso__list_del(struct dso *dso) __must_hol=
d(&_dso__data_open_lock)
> =20
>  static void close_first_dso(void);
> =20
> -static int do_open(char *name) __must_hold(&_dso__data_open_lock)
> +static int do_open(char *name) __must_hold(&dso__data_open_lock)
>  {
>  	do {
>  		int fd =3D open(name, O_RDONLY|O_CLOEXEC);
[ ... ]
> @@ -670,7 +657,7 @@ void dso__put_filename(struct dso *dso __maybe_unused=
, char *filename, bool deco
>  }
> =20
>  static int __open_dso(struct dso *dso, struct machine *machine)
> -	__must_hold(&_dso__data_open_lock)
> +	__must_hold(&dso__data_open_lock)
>  {
>  	int fd =3D -EINVAL;
>  	char *name;
> @@ -703,7 +690,7 @@ static void check_data_close(void);
>   * list/count of open DSO objects.
>   */
>  static int open_dso(struct dso *dso, struct machine *machine)
> -	__must_hold(&_dso__data_open_lock)
> +	__must_hold(&dso__data_open_lock)

[Severity: High]
Could this sequence lead to an AB-BA lock inversion deadlock between
dso__data_open_lock and dso->lock?

When a thread opens a DSO via __open_dso(), it first acquires dso->lock.
If it calls do_open() and hits the open file limit (EMFILE), do_open() calls
close_first_dso() to evict an older DSO.

This leads to dso__list_del() being called for the evicted DSO. As seen
above, under REFCNT_CHECKING, dso__list_del() temporarily drops the global
dso__data_open_lock and calls dso__put(). At this moment, the current
thread still holds dso->lock for the DSO it was trying to open.

A concurrent thread can now acquire the uncontended dso__data_open_lock,
attempt to open the same DSO the first thread is processing, and block
waiting for dso->lock. When the first thread finishes dso__put(), it will
attempt to reacquire dso__data_open_lock, creating a classic AB-BA deadlock.

[ ... ]
> diff --git a/tools/perf/util/vdso.c b/tools/perf/util/vdso.c
> index c12f5d8c4bf69..862ca172ab59a 100644
> --- a/tools/perf/util/vdso.c
> +++ b/tools/perf/util/vdso.c
> @@ -131,7 +131,7 @@ static struct dso *__machine__addnew_vdso(struct mach=
ine *machine, const char *s
> =20
>  	dso =3D dso__new(short_name);
>  	if (dso !=3D NULL) {
> -		__dsos__add(&machine->dsos, dso);
> +		dsos__add(&machine->dsos, dso);
>  		dso__set_long_name(dso, long_name, false);
>  	}
> =20

[Severity: Medium]
Does this missing double-check create a TOCTOU race that allows duplicate
VDSO entries to be inserted?

In machine__findnew_vdso(), there is an initial read-locked lookup via
dsos__find(). If the DSO is not found, it calls __machine__addnew_vdso()
which allocates a new DSO and delegates to dsos__add().

Because dsos__add() acquires the write lock and blindly appends the DSO
without verifying if another thread already inserted it, concurrent
threads calling map__new() can race. They can both miss the initial
read-locked lookup, both allocate new DSO objects, and both insert them.

This violates the unique DSO invariant and leaks the memory allocated
for the duplicate VDSO dso.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013182458.1234=
616-1-irogers@google.com?part=3D7
