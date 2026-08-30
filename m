Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34013BBFA2
	for <linux-perf-users@vger.kernel.org>; Sun, 30 Aug 2026 15:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788102790; cv=none; b=J5ZOIRRvVXVYwmu8rxN7J4KL+Cdq+1MXn+kmIYJm0iP+uaoER4A8/aPEnpM6pXOoREXXKK20QjZSKmHCK+/AK3QRLhiydJR+3AhEYegZ20MT5LIJmt/L40QUNdAhoLX7eV1muLSp6Id6RA9hn28FImj4b5Fjkej70XSqvx4z4Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788102790; c=relaxed/simple;
	bh=zUlKjmZ2x2JF3ZehhWQR6ZE9QXKc3weoEEl5z/R0lTk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PRH72GZjIYr4HdxHUVngyyxyoJJIzYsf15ReOsnBsTs9wNBoK4xpIU+7mkJK4kMyTT3wtTnOJzeUpKgEwA784ib7WbJbgnYP9X7slmZF0sTZ/JIzsuCr2ID8fIbKPcCysyLYd3UKJEdkpxTnbOQCK5F5CX1R7xFhRvNtdWb1c5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RUqRV//z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RUqRV//z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D60201F00A3D;
	Sun, 30 Aug 2026 15:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788102788;
	bh=gTWkosTGZOokTI+R+HLZS8Z5fDlh7oIh7vvcBYDIrOw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RUqRV//z/cjhdbdWjkCrqnwDFeGGnJqVgOm69Yt6Gke5D6m70WJ+dLwHaY+DJQg0f
	 buldAO6WotvT8voThY/uQy1/6nAeR0LsUM9Hrw9qg42fSo4SgfENhdmOA5lGNa/J6L
	 50/Urrr3L+iNd4LneqbzJM4k7iD2EVA9ZPkOZE0o47EULuXy81BIHC4jdmPUbfqpfQ
	 78ReJj7kAxJRs71U+e1LznJqOF7VMw3e82WUWI5kKiBmSJKilsQjKcc8jm8Jif1Xj7
	 R+U0xUewTv+phKlPQ0CbUMs3ffFMpXgPbsaVdmuRyVLq9pjyo16/WNcGPE+qzpCcCG
	 xlds+1nhYoBpg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf: Fix mmap_count accounting on the
 perf_mmap_close() race path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aohan Mei" <ljp1205831794@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260830145512.2583689-1-ljp1205831794@gmail.com>
References: <20260830145512.2583689-1-ljp1205831794@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 30 Aug 2026 15:13:07 +0000
Message-Id: <20260830151307.D60201F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Critical] Incrementing event->mmap_count on the raced path causes the co=
ncurrent perf_mmap_close() to skip cleanup and unaccounting of the old ring=
 buffer, permanently leaking memory charges and the old ring buffer itself,=
 leading to a Use-After-Free.

Pre-existing issues:
- [High] perf_mmap_aux() lacks protection against mmaping redirected events=
, causing a refcount saturation WARN on event->mmap_count.
- [High] Mmapping the same perf event multiple times permanently leaks lock=
ed_vm and pinned_vm accounting charges.
--

commit 74767b5c0f42ab023d9f220cb4e3a861a837fda1
Author: Aohan Mei <henrymei@tencent.com>

perf: Fix mmap_count accounting on the perf_mmap_close() race path

This patch aims to fix an issue on the perf_mmap_rb() raced path where
a concurrent perf_mmap_close() has dropped the ring buffer's mmap_count to
zero. It restores the previous behavior of incrementing event->mmap_count
instead of setting it to 1, to prevent the concurrent closer from observing
a 1->0 transition and prematurely freeing the new buffer.

> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index a6c8e38a31104..7b55156bbc023 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -7281,6 +7281,7 @@ static int perf_mmap_rb(struct vm_area_struct *vma,=
 struct perf_event *event,
>  	long extra =3D 0, user_extra =3D nr_pages;
>  	struct perf_buffer *rb;
>  	int rb_flags =3D 0;
> +	bool raced =3D false;
> =20
>  	nr_pages -=3D 1;

[Severity: High]
This is a pre-existing issue, but could mmapping the same perf event multip=
le
times permanently leak locked_vm and pinned_vm accounting charges?

When perf_mmap_rb() handles overlapping alias mappings (just before the rac=
ed
path check), it calls perf_mmap_account() for each mapping.

However, during teardown in perf_mmap_close(), perf_mmap_unaccount() is only
called once when the final mapping is unmapped and detach_rest is true. For
all prior munmap() calls, the unaccounting seems to be completely skipped
because detach_rest is false.

Could a user exhaust their RLIMIT_MEMLOCK quota by repeatedly mmapping and
munmapping the same perf event?

[ ... ]

> @@ -7346,7 +7348,21 @@ static int perf_mmap_rb(struct vm_area_struct *vma=
, struct perf_event *event,
>  	perf_event_update_userpage(event);
> =20
>  	perf_mmap_account(vma, user_extra, extra);
> -	refcount_set(&event->mmap_count, 1);
> +
> +	/*
> +	 * On the raced path above, a concurrent perf_mmap_close() can
> +	 * still have a pending decrement of event->mmap_count: it sits
> +	 * blocked inside refcount_dec_and_mutex_lock() on event->mmap_mutex
> +	 * (which we hold) with the count still at 1. Using
> +	 * refcount_set(..., 1) here would make that closer observe a 1->0
> +	 * transition once we drop the mutex, causing it to detach and free
> +	 * the buffer we just installed, while this mmap() still maps it.
> +	 * The count is guaranteed non-zero on the raced path, so increment.
> +	 */
> +	if (raced)
> +		refcount_inc(&event->mmap_count);

[Severity: Critical]
Might incrementing event->mmap_count on the raced path inadvertently break =
the
teardown logic in the racing closer?

By inflating the count from 1 to 2, the concurrent perf_mmap_close() for the
old ring buffer might see refcount_dec_and_mutex_lock() return false. This
would cause it to jump directly to the out_put label, completely skipping t=
he
detachment of other events from old_rb->event_list and skipping
perf_mmap_unaccount().

Would this cause the old_rb to be freed while other events are still attach=
ed,
leading to a use-after-free if those events attempt to write to the freed
buffer? Does this also permanently leak memory charges since the unaccounti=
ng
is skipped?

[Severity: High]
This isn't a bug introduced by this patch, but it appears perf_mmap_aux()
lacks protection against mmapping redirected events. Could this lead to a
refcount saturation WARN?

In perf_mmap_aux(), the code validates that an rb exists but seems to fail =
to
verify if the event actually owns the mmap count via a check like
!refcount_read(&event->mmap_count). It unconditionally calls
refcount_inc(&event->mmap_count).

If a user redirects event B's output to event A via
ioctl(PERF_EVENT_IOC_SET_OUTPUT), setting B->mmap_count to 0, and then calls
mmap() on event B with a non-zero offset, will this cause a refcount
saturation WARN?

> +	else
> +		refcount_set(&event->mmap_count, 1);
> =20
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260830145512.2583=
689-1-ljp1205831794@gmail.com?part=3D1
