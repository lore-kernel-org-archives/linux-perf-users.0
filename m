Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57F93101A2
	for <linux-perf-users@vger.kernel.org>; Mon, 31 Aug 2026 19:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788203409; cv=none; b=e4LoYx3qxok/Q2dTCj0wO4RyvAL5U1mpNswRhZVFGPaeVCq3o1Z3y9o1WHIrKcveDtSlH/VB3q9yoEm2xdOp5HsKCuk1aabH+rnb9ZqT7Wx05J74JXOK1uvmeuamqC+r6L6cHbiG5FsxMc5VqVZ0Km8PlM1qEzntOfjsgGliPVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788203409; c=relaxed/simple;
	bh=6y7Y8TW15KAV0wXV4DN44ZjfAy7cfkOUj2q5BfDaBGQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tE2zhSmrxwlmvYWh5Mm04FolHwchr6h62YAkrVk5KIxcw3BM3Dw3AT10s1a+CyMnRLhkAnrV44XeMm4Ulq+JbhQmV2u7xw8j24uWInaAGoPi0tdqLthfK8wzboFmDlYcgvYGOTuvl+QqnTq8kT9rr0+8uLBnFN4MK/dFNvgOA+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VJsjvLiO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VJsjvLiO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59A6E1F000E9;
	Mon, 31 Aug 2026 19:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788203407;
	bh=cs+liV99V07nURt/WakBVLbIEP0w1PZwkBqAI4OaNfo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VJsjvLiO34s71HbsVXMNVh1MbN4PwEOVBnYeUTplb4JRnCvoGg3luTs9rjTz4H0WX
	 4KW+e9HXMDmKzjWukGBvok3K6TXOorvO8lTo924NizZFMZ4vs4RhMfsylZECBGKD7t
	 ZLK5G5D8kU433p0UqpOURG9BpQfjPC6262PT+3ZE6DFBVQfaAR589Ocw6kN2kTJ9Rg
	 SMzU6tg3gy1oR0tIO38wN1fzUzBLXVLKjxp55YzxflRxNhXspJP4gVtW2bxHG7pWwp
	 DpAOHKWmCEcC8EItIKcEeksOHU0lf6fAMyC0rUKOV+MiTaFJNMXosWjvPjfgaQb401
	 bCaKE2XrwDcWQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] perf: Fix use-after-free when perf mmap() revival
 races with the last munmap()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yilin Zhang" <yilinzhang@moonshot.ai>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260831162155.1437652-1-yilinzhang@moonshot.ai>
References: <20260831162155.1437652-1-yilinzhang@moonshot.ai>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 19:10:06 +0000
Message-Id: <20260831191007.59A6E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Preexisting memory accounting leak for locked_vm when mmap() is ca=
lled multiple times on the same perf event (alias mmaps).
--

commit a96fa5a03867a00fbbf2c3b6dd3bf82931c0fdde
Author: Yilin Zhang <yilinzhang@moonshot.ai>

perf: Fix use-after-free when perf mmap() revival races with the last munma=
p()

This commit swaps the order of counter updates in perf_mmap_close() to fix
a page-level use-after-free. It drops event->mmap_count first, serializing
its 1 -> 0 transition and ring_buffer_attach() with perf_mmap(), preventing
buffer revival after rb->mmap_count reaches zero.

Link: https://lore.kernel.org/linux-perf-users/20260804060931.711308-1-davi=
d.lee@trailofbits.com/

> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index a6c8e38a31104..f02780529b439 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
[ ... ]
> @@ -7060,17 +7059,18 @@ static void perf_mmap_close(struct vm_area_struct=
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
> +	/*
> +	 * Drop references in reverse order of perf_mmap() to prevent
> +	 * rb revival after rb->mmap_count reaches zero.
> +	 */
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
This is a pre-existing issue, but does this goto bypass the unaccounting for
all but the final close?

If an application calls mmap() on the same perf event file descriptor multi=
ple
times, perf_mmap_rb() accounts user_extra to current_user()->locked_vm on
every alias mmap:

kernel/events/core.c:perf_mmap_rb() {
    ...
			perf_mmap_account(vma, user_extra, extra);
			refcount_inc(&event->mmap_count);
			return 0;
    ...
}

When munmap() is called for all of them, perf_mmap_close() only calls
perf_mmap_unaccount() when rb->mmap_count drops to zero, which happens only
once.

Could this permanently leak locked_vm charges on every alias munmap,
potentially exhausting the user's RLIMIT_MEMLOCK quota and causing a Denial
of Service for other subsystems (like BPF or io_uring) relying on it?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831162155.1437=
652-1-yilinzhang@moonshot.ai?part=3D1
