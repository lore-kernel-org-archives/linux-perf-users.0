Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABAE35AC16
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Jun 2026 15:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781020318; cv=none; b=izWlTPoq5O5jCGlbBnn9x9q0wRajexphIl6YKB6R9B2rYkaXDVh+QMRq5GIovJ0GH4ntteHv6jXItGaJgA6xL49Gy/YJMgLym+Hin9QL2pInydV+RUr0nPNGoN3wmoS5LXhutU4GLVg3J0V4Q065B0lfkpwTPXiLebjlpF29KGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781020318; c=relaxed/simple;
	bh=JckHGyLayfU/KnkJAJbvclZvJ0he/whxgKEXNyTojb4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GBv9oRNLc1NJl1TgqBPZWaXDw5nlM/MhCT7xEXFPMgOI5jeGGVHapJwZ6ex7yxMJcXia0GyJuCbI3y4QU6viqwksaRQHoO/nEwmEPcsG6hjCk48j3Qzt00Z3UPhyW1JNlUwtEbHjG4PbGifNqQA8xq5bhXy6VkSxEPUuTnX7AK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L4Uwwn7e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L4Uwwn7e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F5131F00893;
	Tue,  9 Jun 2026 15:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781020316;
	bh=SDpUP+HIMoX8itPSJ8PWlj4DhAH452+IHE6GkOMTHNU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=L4Uwwn7ebfsQG4nDMgZXlYGaG47DuBR0rE9hWj6SvRxkeGKs1qXPniNLbxq6av2SS
	 07XkqEXBxwxe3QziR10gJ7XRq5jYgQanUt3p6ibb7AMQv0XqBexjhWXHhv3++QaHW0
	 qgGcmrLpkhWxM7SzKMp8PkZkUi2Wlf3uoGZevLvHCchDMxqUXWiqKaOZcy6d1VufRw
	 1/zJSonV/x2uFF7CE+BYwKSckrMqaq+P3kiZD9Op1SBBrIG1NA7eH1zWR9vZxvYxYX
	 q5qxZWzE8mRfyH1DCNSsUcCNgsy/tVWCNQ6ndcPrPWmCGfpd/Lxr71AgNglhfzqTnZ
	 DjzLarH5M+eMg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] perf: avoid lockdep warning in self-monitoring
 perf_event_open
Reply-To: sashiko-reviews@lists.linux.dev
To: l1za0.sec@gmail.com
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260609153724.7878-1-l1za0.sec@gmail.com>
References: <20260609153724.7878-1-l1za0.sec@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 15:51:55 +0000
Message-Id: <20260609155156.0F5131F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Incomplete fix for a core lock inversion (potential deadlock) betw=
een the scheduler runqueue lock and perf context lock.
--

commit 008930a2883145d064fbb634b2b2120e78395849
Author: Haocheng Yu <3230100410@zju.edu.cn>

perf: avoid lockdep warning in self-monitoring perf_event_open

This commit adds a fast path for self-monitoring events in
perf_install_in_context() to bypass task_function_call(). It is intended as=
 a
targeted mitigation to avoid a lockdep warning about a potential deadlock
between the scheduler runqueue lock and the perf context lock.

> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 7935d5663944e..97837242db328 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c

[ ... ]

> @@ -3199,6 +3199,15 @@ perf_install_in_context(struct perf_event_context =
*ctx,
>  	 */
>  	smp_mb();
>  again:
> +	if (task =3D=3D current) {
> +		unsigned long flags;
> +		preempt_disable();
> +		local_irq_save(flags);
> +		__perf_install_in_context(event);
> +		local_irq_restore(flags);
> +		preempt_enable();
> +		return;
> +	}

[Severity: High]
This isn't a bug introduced by this patch, but does this actually resolve t=
he
underlying lock inversion?

The commit message documents an ABBA deadlock cycle involving rq->__lock and
ctx->lock. While this fast path avoids the specific lockdep warning trigger=
ed
during self-monitoring, cross-task monitoring (task !=3D current) will skip=
 this
block and fall through to task_function_call().

Does this mean the exact same lock inversion and potential deadlock remain
fully reachable by userspace when monitoring a different task?

>  	if (!task_function_call(task, __perf_install_in_context, event))
>  		return;
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609153724.7878=
-1-l1za0.sec@gmail.com?part=3D1
