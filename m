Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC77472795
	for <linux-perf-users@vger.kernel.org>; Mon, 31 Aug 2026 13:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788184240; cv=none; b=J6g45tODTu4QYiWYOzzRrNipzoC9kTFHyZOKQ75wjhfQMvZpl5lVV+afn5zBrrS8NiLAb5Wk0/Y/gJ8nqDUkPqEWuabgXY+Wsdk6wVUr4fRUp0H0+Ia6physccDk5ZGCXO/5RoqImr7LKgUb//kGBRIPDxIB4iRZtqSVmK6+oKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788184240; c=relaxed/simple;
	bh=2HRtKRqOG/xihCTwHP8rk+wmAcBphWh55Q5dF5flpL0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=L9JUMvUX1oOkgtbdNoz3V1GNo4vv+A3UK/aLSYIt6y8Jl9Dhm+liDax6kKrpAsMRfqwPVv+YNI/pVICFHZjfYHaGjUZR8hJx0uthQOuNXmYr6Bm8apTFxeh6iZcLv6C0Z7bxvWgPvdKl8lmlY6YKS/Fj+Mc0bgxfoPeuFUCQ9TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J+lCTQDL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J+lCTQDL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEDC61F00A3E;
	Mon, 31 Aug 2026 13:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788184238;
	bh=rUqCDzuTNP7WhxVHDcvgyaGjQN12X44GUS9YqdzmIiA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=J+lCTQDLd17wt7NluxaKDv/vNY+pMezq1zVjxPi9dxEqFcWczSNyftw6uLZceriyN
	 iGYOuVMYTPiIpPNvFkg+gAEVLRfTH9TtUyYmP280i9nWDcw1O4xNmuHtj5GAqauBov
	 uay/PfXfHErl8W38B0xvmoKXDXYgYXCiLbyj6XkX4zVuKLAn4rmventfJ3gskVrLsA
	 8TK2+ILh3g7slYyz9zdB1YRf1Pck/nrlkaswT0nwAyCU6YQv9MBnbTpHXKHSo+W/BR
	 E3i1YiPof72daaRiQmv1GmoJ+6ShVL3ShsM2G2MaUkSKu/xJiOedY/gYmxwxZv7n3g
	 hrWIFIpLK/EUA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] perf: Fix use-after-free when perf mmap() revival
 races with the last munmap()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yilin Zhang" <yilinzhang@moonshot.ai>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260831133152.1231045-1-yilinzhang@moonshot.ai>
References: <20260831133152.1231045-1-yilinzhang@moonshot.ai>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 13:50:38 +0000
Message-Id: <20260831135038.AEDC61F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Permanent leak of locked_vm accounting when mmapping the same perf=
 event ring buffer or AUX buffer multiple times.
--

commit bd560c15b9fb2009d96bf58b9046c04989905b44
Author: Yilin Zhang <yilinzhang@moonshot.ai>

perf: Fix use-after-free when perf mmap() revival races with the last munma=
p()

This commit fixes a use-after-free vulnerability in the perf events subsyst=
em
by swapping the order of counter decrements in perf_mmap_close(). The change
ensures that event->mmap_count is decremented first under the mmap_mutex,
closing a race window where a newly attached ring buffer could be mistakenly
freed.

Link: https://lore.kernel.org/linux-perf-users/20260804060931.711308-1-davi=
d.lee@trailofbits.com/

> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index a6c8e38a31104..f56f9d9e4f01b 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -7060,17 +7059,14 @@ static void perf_mmap_close(struct vm_area_struct=
 *vma)
>  		mutex_unlock(&rb->aux_mutex);
>  	}
> =20
> -	if (refcount_dec_and_test(&rb->mmap_count))
> -		detach_rest =3D true;
> -
> -	if (!refcount_dec_and_mutex_lock(&event->mmap_count, &event->mmap_mutex=
))
> -		goto out_put;
> -
> -	ring_buffer_attach(event, NULL);
> -	mutex_unlock(&event->mmap_mutex);
> +	if (refcount_dec_and_mutex_lock(&event->mmap_count,
> +					&event->mmap_mutex)) {
> +		ring_buffer_attach(event, NULL);
> +		mutex_unlock(&event->mmap_mutex);
> +	}
> =20
>  	/* If there's still other mmap()s of this buffer, we're done. */
> -	if (!detach_rest)
> +	if (!refcount_dec_and_test(&rb->mmap_count))
>  		goto out_put;

[Severity: High]
This is a pre-existing issue, but does the early return here leak the
locked_vm accounting when the same perf event ring buffer or AUX buffer is
mmapped multiple times?

Looking at the mmap side in perf_mmap_rb() and perf_mmap_aux(), secondary=20
mmaps repeatedly charge the user's locked_vm:

kernel/events/core.c:perf_mmap_rb() {
	...
	perf_mmap_account(vma, user_extra, extra);
	refcount_inc(&event->mmap_count);
	...
}

kernel/events/core.c:perf_mmap_aux() {
	...
	perf_mmap_account(vma, user_extra, extra);
	refcount_inc(&event->mmap_count);
	...
}

However, the unaccounting in perf_mmap_close() only happens exactly once wh=
en
the last mmap is closed and rb->mmap_count reaches zero:

kernel/events/core.c:perf_mmap_close() {
	...
	if (!refcount_dec_and_test(&rb->mmap_count))
		goto out_put;
	...
	perf_mmap_unaccount(vma, rb);
out_put:
	ring_buffer_put(rb);
}

Because locked_vm is used system-wide to enforce RLIMIT_MEMLOCK (e.g., by
io_uring, BPF, XDP, and secretmem), an attacker could trivially loop calling
mmap() on the same file descriptor to artificially inflate this counter unt=
il
the limit is exhausted.

Does this create a persistent Denial of Service for all processes running
under that UID, making the system fully unusable for the affected user's
services until all processes of that user exit?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831133152.1231=
045-1-yilinzhang@moonshot.ai?part=3D1
