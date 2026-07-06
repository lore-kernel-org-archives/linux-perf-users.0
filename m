Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B00338939;
	Mon,  6 Jul 2026 17:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783359764; cv=none; b=su1jPm4g3iHXSqQ2VNRnpTAuls5lKK6Y2McZGTwZVqcxf1L34mDLSz+/zoL/dB+PqvXBGifQViEQZj6q2fm2xtdKi5l0TwkOFfTWCyG2g+AWEL0VSB9XdGpcsc2S/+JGGyFdcYZQybAM+fVbapM2tw1OeBgZ0yD1+engnq+/3wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783359764; c=relaxed/simple;
	bh=fSRodVM2+qzfFq0roDFYnDJJRDH7phHpqBbBl+97z2o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pCj2vz8lYzOm4D/8lO8kgJf2CzXEAeX99LGtDVYJMuNRlFH/UCGT8BIN2dJarI9lQpLiovpSH5furZvmCaSYJK0irDhfS0xyOPSBIkKpEX2ygDdkKKfR0Tsb7hzRyL0zJNsxx8KwGWZJ0rayMMbNtrqVVE8zrwsg3LzilxtA3FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lD2+PGnl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lD2+PGnl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25B791F000E9;
	Mon,  6 Jul 2026 17:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783359762;
	bh=oE4QMZ5+i1acv2iRvN/5qBcTrSG0q5J+yogBP70Htek=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lD2+PGnlwrcVMUYFSkuTUa5E51c8PfPlr9VHsZd6b1CMFtRMjA9OvgGoAfv5s4wYh
	 BT0iSv2uBA8hGqiFAAP1jMLPEiFVtPmN1SzqtlyviGyM9XpRKFY5TibGIIxy1+P96C
	 7LavkoKCvPAxMRazYZQxGLZNEnU/r3T1Um0BpOgS3w9pAuDHcKRj6h1K5ZzL8tuNtl
	 L6UMU4haDTmnKWKMxxl68NDVkd2f0+0tPeYsxGGzGHjgvon1xMtTICAkujcmjVRLfg
	 mAjfXzYbryKpNtNGp4m9+Qi4Vz2wtJMi2zA5HC+NJqRV4/qlLWC2rJpM/uZZh9oWAi
	 tDnitGKA6iduA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 2/2] uprobes: Switch uretprobes_srcu to
 SRCU-fast-updown
Reply-To: sashiko-reviews@lists.linux.dev
To: "Puranjay Mohan" <puranjay@kernel.org>
Cc: linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20260706172744.3920417-3-puranjay@kernel.org>
References: <20260706172744.3920417-1-puranjay@kernel.org>
 <20260706172744.3920417-3-puranjay@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 17:42:41 +0000
Message-Id: <20260706174242.25B791F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Concurrent hprobe_expire() and hprobe_consume() can cause a use-af=
ter-free on uprobe due to misunderstood SRCU semantics.
--

commit 86c857f0a70ec453b9e38c36e230b36b91bef460
Author: Puranjay Mohan <puranjay@kernel.org>

    uprobes: Switch uretprobes_srcu to SRCU-fast-updown
   =20
    uretprobes_srcu currently uses normal SRCU, which issues
    two smp_mb() per read lock/unlock pair. This overhead is
    paid on every uretprobe hit.
   =20
    Switch to SRCU-fast-updown, which eliminates the per-reader
    memory barriers by moving the ordering cost to the
    grace-period side.

> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index 4084e926e2844..afa491b0bd3f9 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
[ ... ]
> @@ -2045,7 +2046,7 @@ static void ri_timer(struct timer_list *timer)
>  	struct return_instance *ri;
> =20
>  	/* SRCU protects uprobe from reuse for the cmpxchg() inside hprobe_expi=
re(). */
> -	guard(srcu)(&uretprobes_srcu);
> +	guard(srcu_fast_updown)(&uretprobes_srcu);

[Severity: High]
This isn't a bug introduced by this patch, but does the new SRCU read lock
acquired here actually protect the uprobe from being freed?

If a uprobe is being unregistered, uprobe_free_deferred() calls
call_srcu(&uretprobes_srcu, ...) to free the uprobe. This starts an SRCU
grace period that waits only for pre-existing SRCU readers to finish.

Concurrently, if ri_timer() or dup_utask() takes this new SRCU read lock,
the grace period will not wait for it because the new lock started after the
grace period began.

If the traced task concurrently executes uprobe_handle_trampoline(), calls
hprobe_consume() and hprobe_finalize(), and releases the original SRCU read
lock, the grace period can complete and free the uprobe (via
call_rcu_tasks_trace()).

When ri_timer() then proceeds to call hprobe_expire(), which does:

kernel/events/uprobes.c:hprobe_expire() {
    ...
    case HPROBE_LEASED: {
        struct uprobe *uprobe =3D try_get_uprobe(hprobe->uprobe);
    ...
}

Could this lead to a use-after-free on the uprobe? The comment in
hprobe_expire() seems to assume the new lock prevents the free:

        /*
         * Even if hprobe_consume() or another hprobe_expire() wins
         * the state update race and unlocks SRCU from under us, we
         * still have a guarantee that underyling uprobe won't be
         * freed due to ongoing caller's SRCU lock region, so we can
         * return it regardless.
         */

Is this analysis accurate?

>  	/* RCU protects return_instance from freeing. */
>  	guard(rcu)();
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706172744.3920=
417-1-puranjay@kernel.org?part=3D2
