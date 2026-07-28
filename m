Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47D836F911;
	Tue, 28 Jul 2026 21:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785273253; cv=none; b=XQkt+Qv+/PeyhopKzookclKtfaukFEKtHQfaJKlQOdBErC14mRpDiZngDuhzDLV2HnoDenTiG+EETKI9EqLRKjWnWRUnW/Pe7IHrwXZbJSLRv9+dT0f3E4wsfsRjLYgECpFcyafFmU3vWOWVLDr8dEa0/0yPWd8BzEeF3oQ3ClA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785273253; c=relaxed/simple;
	bh=GhWO2RwY0NnNtEpgULPeB0J7crm0o/zVdkPla48nG0U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GXidoQ2qHJB/kl6MxDtbmXRCm8KBacWBrd5pSE3Tgh6Aw+jaAKvVnuopG2im266oSxXGGKG2jVOEBFmJiuT7HxHVpO2m1c+Lf06y+t1z++FWfsNnNjEd3gv7yTZifccPL9SVdE6JDJP/95TOkeE/xMM2hdLeQJTWA0VjU6smyR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nEO9C93l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nEO9C93l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47B2D1F000E9;
	Tue, 28 Jul 2026 21:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785273251;
	bh=bERl4FgK4QuJNE/Jjx85DIDS9YPiBKu+Gsj+1W3nSZg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nEO9C93lJ6nKXf9o6GvlcllvFx3WhowqO9NoNh4aXnoGV31AksP/8+eX7aB5UEjBx
	 n/6f9KEvqr7zDk1caaf6Zg3uIGLvkwhR2EbUMVPffWLmMh0kOY4i5f+qPRgBPzQuul
	 owAbS3xMrkK8Re/Q5kLCfC6CCMoyCgNNJFEvas8bqUCY2w7BQAp9QMUYwrJMHZFDn1
	 EoGHoY/0WH8XiuOqs1k28wYsvT1p3m4ZzYYdpxQx3nWtcuTUj0shyNvkVbE673Br+U
	 J6CYUR6oIHHKQtBTy+CyaqDh0g1xWgLDit71xN+/Hn5yIcENB5jKpV2xgUvNjp+HNB
	 L4zKhVOkeNazA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/9] perf/cxl: Drop bogus counter overflow fixup
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dave Jiang" <dave.jiang@intel.com>
Cc: linux-perf-users@vger.kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20260728210551.2449093-4-dave.jiang@intel.com>
References: <20260728210551.2449093-1-dave.jiang@intel.com>
 <20260728210551.2449093-4-dave.jiang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 21:14:10 +0000
Message-Id: <20260728211411.47B2D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Removing the overflow fixup entirely causes the CXL PMU driver t=
o silently drop a full period of events on overflow when the new counter sk=
id is greater than or equal to the previous skid.
--

--- Patch [3]: [PATCH 3/9] perf/cxl: Drop bogus counter overflow fixup ---
commit 9b5168bc2e13d25590b1bb314d5cd8b527ba4f3e
Author: Dave Jiang <dave.jiang@intel.com>

perf/cxl: Drop bogus counter overflow fixup

This commit removes the overflow fixup in __cxl_pmu_read() and folds it into
cxl_pmu_read(). The stated rationale is that masked unsigned subtraction
already produces the correct delta across a wrap, and that the previous
fixup caused overcounting.

Closes: https://sashiko.dev/#/patchset/20260715191454.459673-1-dave@stgolab=
s.net?part=3D1

> diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
> index 3138514157cde..410c9162c8246 100644
> --- a/drivers/perf/cxl_pmu.c
> +++ b/drivers/perf/cxl_pmu.c
[ ... ]
> @@ -698,21 +698,15 @@ static void __cxl_pmu_read(struct perf_event *event=
, bool overflow)
>  	} while (local64_cmpxchg(&hwc->prev_count, prev_cnt, new_cnt) !=3D prev=
_cnt);
> =20
>  	/*
> -	 * If we know an overflow occur then take that into account.
> -	 * Note counter is not reset as that would lose events
> +	 * The counter is not reset on overflow, and the unsigned subtraction
> +	 * masked to the counter width already yields the correct delta across a
> +	 * single wrap, so no overflow fixup is needed.
>  	 */
>  	delta =3D (new_cnt - prev_cnt) & GENMASK_ULL(info->counter_width - 1, 0=
);
> -	if (overflow && delta < GENMASK_ULL(info->counter_width - 1, 0))
> -		delta +=3D (1UL << info->counter_width);

[Severity: Medium]
Does removing the overflow fixup entirely cause the driver to drop a full
period of events when new_cnt >=3D prev_cnt?

While standard modulo math handles wraps when the counter is reprogrammed to
a high value (ensuring new_cnt < prev_cnt), the CXL PMU does not reprogram
counters on overflow. They start at 0, wrap, and freeze at a small skid
value.

If a counter overflows, prev_cnt becomes skid1. On the next overflow,
new_cnt becomes skid2. If skid2 >=3D skid1 (which has a roughly 50% chance),
the masked subtraction only yields the tiny difference (skid2 - skid1),
completely missing the wrapped period.

Would it be more correct to keep an overflow fixup specifically for the
new_cnt >=3D prev_cnt case when an overflow occurs?

> =20
>  	local64_add(delta, &event->count);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728210551.2449=
093-1-dave.jiang@intel.com?part=3D3
