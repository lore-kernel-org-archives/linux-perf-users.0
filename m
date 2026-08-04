Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788A782866
	for <linux-perf-users@vger.kernel.org>; Tue,  4 Aug 2026 06:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785825266; cv=none; b=vFOpkv8ljDTXBtwyZzPC6gocix8A7KTnqeseRvM80g5vA1+ciZZEF7SJT9OSx+dD2gxiS/u9O7REgRxzb+GL6XHW8x1uvx0zEBtbypIkcnYMkwdq0bUvHHq7zDV7pEYm4xS55VmMeHWVVmQ7WaSmF0WBDWh/PoiOYWcSW1IcFns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785825266; c=relaxed/simple;
	bh=c6slXAg6vFfBXJMDigjs/862iig90J4883VMXuFItNk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IS5aDiISF6KGWBXI84xVtQYM+ZwgrFIji+RUe/ctW9e5vZgE1NJy8YnOhQJtqQy0j3non6pt9MvGeTIlhkOkacjBnFM7H+bSn6Z8zSORUCo9aN16EnVNtqFQWie0Y5kIvpe++XRmlLO482ZPJvJBlcW5fbT7iLjinZ8FKCrXUPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A0hI6rdq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A0hI6rdq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECA871F000E9;
	Tue,  4 Aug 2026 06:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785825265;
	bh=avGaDLEh2ZGUnu6mQmtaWtbsEoTqoDt0J6hTkWdfNGo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=A0hI6rdqvLFzhcowFlmqkJXlFp17ybTFYVVHAilU9PlBgDsRy74xoYzOBDiSUawRJ
	 NYZNpytvFWUKW+lD4mCONwWOrnxL/5ObPAG5nKfJx59vkaMupD+8N0k+/sTyHonBMX
	 zd5d9OI8/0TEZxDWfEjC3iqzjyXGq1eePtGO8/GcL/O9he+1FNdYc91qd2Ao3w/ErN
	 /0vWYsqM1D7ZjARqvekZulMZvxKttVWwD3Kur+D0ustPjegV3WguDYTvLESRzTx62Q
	 gup42QMhh/BkJlQLILmIo4VFdZCIeHYD1BMDKqFioQtgCoZX0ri2Kr/j0AfX5BFdV+
	 Vvnguzenoq3DQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] perf: Fix mmap replacement ring lifetime race
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Lee" <david.lee@trailofbits.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260804060931.711308-1-david.lee@trailofbits.com>
References: <20260804060931.711308-1-david.lee@trailofbits.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 06:34:23 +0000
Message-Id: <20260804063424.ECA871F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Cross-mm pinned_vm and locked_vm accounting mismatch when main buf=
fer and AUX buffer are mapped by different processes.
- [High] Error path in perf_mmap leaks ring buffer mmap counts and unaccoun=
ts wrong memory size for AUX mmaps on redirected events.
--

--- Patch [1]: [PATCH v2] perf: Fix mmap replacement ring lifetime race ---
commit 454633461f89e2fe1c245d071d92eff5dc95e16e
Author: Kyle Zeng <kylebot@openai.com>
Subject: perf: Fix mmap replacement ring lifetime race

perf_mmap_close() drops the ring-local mmap_count before serializing
with perf_mmap() through event->mmap_mutex. This patch takes
event->mmap_mutex before updating either count, ensuring the transitions
are atomic with respect to perf_mmap().

Link: https://lore.kernel.org/all/20260731120401.558858-1-david.lee@trailof=
bits.com/

> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 51c1200ea3fdd..cce24be2d1f28 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -7053,11 +7053,19 @@ static void perf_mmap_close(struct vm_area_struct=
 *vma)
>  		mutex_unlock(&rb->aux_mutex);
>  	}
> =20
> +	/*
> +	 * Serialize both count updates with perf_mmap() so they cannot
> +	 * refer to different ring buffer generations.
> +	 */
> +	mutex_lock(&event->mmap_mutex);
> +
>  	if (refcount_dec_and_test(&rb->mmap_count))
>  		detach_rest =3D true;
> =20
> -	if (!refcount_dec_and_mutex_lock(&event->mmap_count, &event->mmap_mutex=
))
> +	if (!refcount_dec_and_test(&event->mmap_count)) {
> +		mutex_unlock(&event->mmap_mutex);
>  		goto out_put;

[Severity: High]
This is a pre-existing issue, but does this mmap_count logic lead to a
cross-mm pinned_vm and locked_vm accounting mismatch when the main buffer
and AUX buffer are mapped by different processes?

If Process A maps the main ring buffer of an event, charging its VMA's
pinned_vm, and the event fd is shared with Process B which maps the AUX
buffer, rb->mmap_count tracks both mappings globally.

If Process A unmaps the main buffer first, the following evaluates to false:

	if (refcount_dec_and_test(&rb->mmap_count))
		detach_rest =3D true;

The mmap_count decrements but does not reach zero, skipping the later call
to perf_mmap_unaccount().

When Process B later unmaps the AUX buffer, rb->mmap_count reaches zero
and perf_mmap_unaccount() is called with Process B's VMA near the end of
perf_mmap_close():

	/*
	 * Aside from that, this buffer is 'fully' detached and unmapped,
	 * undo the VM accounting.
	 */
	perf_mmap_unaccount(vma, rb);

Does this unaccount the main buffer's size from Process B's limits,
underflowing Process B's pinned_vm while permanently leaking the limits for
Process A?

> +	}
> =20
>  	ring_buffer_attach(event, NULL);
>  	mutex_unlock(&event->mmap_mutex);

[Severity: High]
This is also a pre-existing issue, but looking at the related error path in
perf_mmap(), could it leak ring buffer mmap counts and unaccount the wrong
memory size for AUX mmaps on redirected events?

When mmap() is called for the AUX buffer of a redirected event,
perf_mmap_aux() increments rb->mmap_count, rb->aux_mmap_count, and sets
event->mmap_count to 1.

If map_range() fails due to an error, the cleanup path in perf_mmap()
evaluates this:

		if (refcount_read(&event->mmap_count) =3D=3D 1) {
			/*
			 * Minimal perf_mmap_close(); there can't be AUX or
			 * other events on account of this being the first.
			 */
			mapped =3D get_mapped(event, event_unmapped);
			if (mapped)
				mapped(event, vma->vm_mm);
			perf_mmap_unaccount(vma, event->rb);
			ring_buffer_attach(event, NULL);
			refcount_set(&event->mmap_count, 0);
			return ret;
		}

Because event->mmap_count is 1, it assumes this is an exclusive main buffer
mmap. It then calls perf_mmap_unaccount(), which unaccounts the main
buffer's size instead of the AUX buffer's size, potentially underflowing the
caller's pinned_vm.

Additionally, it skips decrementing rb->mmap_count and rb->aux_mmap_count
while detaching the event from the ring buffer. Could this cause a
persistent memory leak of ring buffer pages and break event redirection?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804060931.7113=
08-1-david.lee@trailofbits.com?part=3D1
