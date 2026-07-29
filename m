Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5BD3D3CE6;
	Wed, 29 Jul 2026 15:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785338000; cv=none; b=ndMI6pwVEHFevw7PRtSMx34/oHTAcsNbtWttClt7/DDlhQKM4Tmhl/SWYZuMxPKSBbE0CqBHOtjUtvd1BaWiT/xJUidisAdxCGAgEV0YnHAl+xPYOg4qvjzV34xgPhq7aiLb8zin/P/Iw2NUbIqd58gSNpPWhTT8sKRE/Bpk0hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785338000; c=relaxed/simple;
	bh=JLhdwxpT/8ghAF1J/iOcYQkn2uskl9tJmI/Up3DqS6M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Gr2siGVvw4bSrkUaU7dGdlwbrIX36/Ilk/DGyUkmgi9pv/yln0ys/4LNKXwN3p3Dikljj9BT+XXprg2OAKk6kXiTGWn9DJLa/bgK2SB+q66Rb+0X6/MfFLQlBWhio/ZU6R98ypYMt8UB6PGogw/uiB9Zdx8UnzIG8l+S0qEazUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c4Zt0sQx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c4Zt0sQx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98EA81F000E9;
	Wed, 29 Jul 2026 15:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785337995;
	bh=OPMlx+hLuGReqLdh4a9FsLhO9ZppPqaa4ZmEqu7bTZo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=c4Zt0sQx4fKTegjirDa/08FJORTBtUMrAWDKe5m7do1w5atZ1a2N8EpZB06Zx2Esm
	 CqqHrlHER5VQPjaoud6dtY2gWqvOSXQPJIyNUF+R5BWkSqkMwcmvqmj864alzoLLD1
	 4NPYvQ8opd/t9B/3w57VOM/bmoE6T1axqM+xhkuev649UfY+m6/RMKGE4fI91uTRma
	 QcoJzDygv8QBGMiQuhaDVAEsC6IXtwKUC0Ib8HtiFS7b9MDn/SnP7iA0ad0ufm3+X3
	 G392twCu/xi9VpastwIwD436/C2jJ2IZ773Z5u0m1ja3mB22Hv0IWcCof/sNGWKmUQ
	 vQXOoUqe8t+7g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/9] perf/cxl: Fix the counter overflow delta fixup
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dave Jiang" <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20260729145555.3919550-4-dave.jiang@intel.com>
References: <20260729145555.3919550-1-dave.jiang@intel.com>
 <20260729145555.3919550-4-dave.jiang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 15:13:14 +0000
Message-Id: <20260729151315.98EA81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] A race condition between a lockless PMU read and the PMU overflow =
IRQ handler causes a full counter period to be erroneously added, massively=
 double-counting the event.
--

--- Patch [3]: [PATCH v2 3/9] perf/cxl: Fix the counter overflow delta fixu=
p ---
commit 72c8c960c955004fc0b667e90e3698f58a0d0ea6
Author: Dave Jiang <dave.jiang@intel.com>

perf/cxl: Fix the counter overflow delta fixup

This commit updates the CXL PMU counter overflow handling since the counters
freeze on overflow and are not reloaded. It modifies the delta fixup logic
to trigger when new_cnt is greater than or equal to prev_cnt, adding the
full period back to account for the wrap.

Closes: https://sashiko.dev/#/patchset/20260715191454.459673-1-dave@stgolab=
s.net?part=3D1

> diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
> index 3138514157cde..956da82025513 100644
> --- a/drivers/perf/cxl_pmu.c
> +++ b/drivers/perf/cxl_pmu.c

[ ... ]

> @@ -698,12 +698,18 @@ static void __cxl_pmu_read(struct perf_event *event=
, bool overflow)
>  	} while (local64_cmpxchg(&hwc->prev_count, prev_cnt, new_cnt) !=3D prev=
_cnt);
> =20
>  	/*
> -	 * If we know an overflow occur then take that into account.
> -	 * Note counter is not reset as that would lose events
> +	 * The counter wraps to 0 and is never reloaded, so the masked unsigned
> +	 * subtraction only recovers a wrap when new_cnt < prev_cnt. On the
> +	 * overflow path new_cnt >=3D prev_cnt means the full period elapsed
> +	 * (prev_cnt is 0 from event_start(), or the residual left by an earlier
> +	 * overflow), so add the period back. mask + 1 is 2^counter_width, which
> +	 * evaluates to 0 for a 64-bit counter - the correct sum mod 2^64, and
> +	 * avoids the undefined 1 << 64.
>  	 */
> -	delta =3D (new_cnt - prev_cnt) & GENMASK_ULL(info->counter_width - 1, 0=
);
> -	if (overflow && delta < GENMASK_ULL(info->counter_width - 1, 0))
> -		delta +=3D (1UL << info->counter_width);
> +	mask =3D GENMASK_ULL(info->counter_width - 1, 0);
> +	delta =3D (new_cnt - prev_cnt) & mask;
> +	if (overflow && new_cnt >=3D prev_cnt)
> +		delta +=3D mask + 1;

[Severity: High]
This is a pre-existing issue, but can this lead to massive double-counting
if a concurrent lockless read races with the overflow handler?

If a userspace lockless PMU read, such as perf stat -I, happens after the
counter wraps and freezes, but before the delayed overflow IRQ handler
executes, the lockless reader will correctly compute the wrapped delta and
update hwc->prev_count to the frozen residual.

When the IRQ handler in __cxl_pmu_read() subsequently runs, both prev_cnt
and new_cnt will read the same frozen residual. The condition
new_cnt >=3D prev_cnt will evaluate to true since they are equal, causing t=
he
handler to blindly add a full period (mask + 1) on top of the already
accounted wrap.

Could this be addressed by distinguishing between a full period elapsing and
a frozen residual being consumed by a concurrent lockless read?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729145555.3919=
550-1-dave.jiang@intel.com?part=3D3
