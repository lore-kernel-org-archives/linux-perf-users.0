Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B963976BA
	for <linux-perf-users@vger.kernel.org>; Sat, 26 Sep 2026 19:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790450029; cv=none; b=jawFl2p06DqneqWPYoTElUTtTX6gkOvwacX5X1tp708aBJT9M4hPZ2J9Le2ejK4JpgaGoknr6DnK0+PuFb+HFSpkBMoM/QV2L6FCVuDgjInbci4UgZOXcNsOTy/mkKJcSZgHSyOxu3pQtb0D4ZwgXjm52sjI6zgEQMmlCrQJv4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790450029; c=relaxed/simple;
	bh=4Rp3nANsx4SukN9Ztd5zCIWdTQg3n/xuVVgRxQQ97gk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZMyopgMOZySR8DOYac20p9+VTV4nyvFm/BU4Jlo2HFnDP9NgU0wlfpsgKFrXSqd3X2aGY8it4EQl3IU4akvFMSVb994mty0/SAwTL09qCxWZDriYQiXNmvRS9B3q0RvO8ZRt6yvK2Kg08HT5gx1TUbPmQVeB2g7l+JLyiyQ3vzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fWAImC4V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fWAImC4V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E59281F000FF;
	Sat, 26 Sep 2026 19:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790450028;
	bh=Iaa7e0BVJflfx/3t7RXsrdET6C/fCOdiLbNwRk4n8y4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fWAImC4VbvxdManMnQVfk7KULoV+sM8xlm/KRuYSynF4OortCBWP9rqp2hCwkl/X2
	 JiyzHbwJlPUZ5HGwz+vPKa24IBylMJeOivWexBpWXlmEirztgQV+nE22fpvENecB+B
	 pICH5Bf8RcbprjguDfRJANrP5z1eeO8R5nxAGZCHm7ELYIl1zsNpA3d35+mflJWSuK
	 OXo/Ml1t2HgFF7agGigCDIMBe7VW0sqQAEt1vAUZG8xL+7wQQTAmT0kkHm59Ilm24/
	 WhQOge/wmPLuTk/GuHaX8K1xC4it/C9CiKpXcZy2WxEsWI3kJEsbMLhmIFkzn1SsMi
	 xjxU56Yx3lJsg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/8] perf bench futex: Retry futex_wait() when
 interrupted by a signal
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michal Pluta" <michalpl2003@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260926190407.1106421-2-michalpl2003@gmail.com>
References: <20260926190407.1106421-1-michalpl2003@gmail.com>
 <20260926190407.1106421-2-michalpl2003@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 19:13:47 +0000
Message-Id: <20260926191347.E59281F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf: deadlock in futex wake-parallel due to missed one-shot fut=
ex_wake()
--

commit 4425d175409b64dbe77117f655f0ffa4eca2b864
Author: Michal Pluta <michalpl2003@gmail.com>

perf bench futex: Retry futex_wait() when interrupted by a signal

The worker threads in 'futex wake' and 'futex wake-parallel' are meant
to go back to sleep when a signal interrupts futex_wait(), but the check
never works. futex_wait() returns -1 and sets errno, so comparing its
return value with EINTR is always true and the loop ends at the first
interruption.

> diff --git a/tools/perf/bench/futex-wake-parallel.c b/tools/perf/bench/fu=
tex-wake-parallel.c
> index 6aede7c46b337..a089d8ee4b023 100644
> --- a/tools/perf/bench/futex-wake-parallel.c
> +++ b/tools/perf/bench/futex-wake-parallel.c
> @@ -139,10 +139,9 @@ static void *blocked_workerfn(void *arg __maybe_unus=
ed)
>  	cond_wait(&thread_worker, &thread_lock);
>  	mutex_unlock(&thread_lock);
> =20
> -	while (1) { /* handle spurious wakeups */
> -		if (futex_wait(&futex, 0, NULL, futex_flag) !=3D EINTR)
> -			break;
> -	}
> +	/* Retry if the wait was interrupted by a signal. */
> +	while (futex_wait(&futex, 0, NULL, futex_flag) =3D=3D -1 && errno =3D=
=3D EINTR)
> +		;

[Severity: Medium]
Can this retry loop cause a deadlock if a signal interrupts the wait?

If blocked_workerfn() receives a signal, futex_wait() returns -1 and
errno =3D=3D EINTR. The thread then temporarily leaves the futex wait queue=
 before
looping back to call futex_wait() again.

If waking_workerfn() in tools/perf/bench/futex-wake-parallel.c happens to
execute its single futex_wake() call during this unqueued window:

tools/perf/bench/futex-wake-parallel.c:waking_workerfn() {
    ...
    waker->nwoken =3D futex_wake(&futex, nwakes, futex_flag);
    if (waker->nwoken !=3D nwakes)
        warnx("couldn't wakeup all tasks (%d/%d)",
    ...
}

Will the waker thread miss the unqueued worker and exit, leaving the worker=
 to
block forever on its next futex_wait() and causing the main thread to hang =
in
pthread_join()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926190407.1106=
421-1-michalpl2003@gmail.com?part=3D1
