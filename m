Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08ACADDCD;
	Fri, 31 Jul 2026 23:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785541047; cv=none; b=RtyVTNpFfkCMNrDxf/qv2icZuEnq4MgKmAsw1dvqtjX4Hu38DjOV23K7KJB2N9NiXj4w21ayHD0963hQgLFj+0rRK3jZMpak6ABXfnnPt2YKSfm9XOcQV1ceqlWaJQ6uuNb6VhatB1ksLUH9b7glK5dCssbbZ0zTOJWxGpugNrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785541047; c=relaxed/simple;
	bh=WqQfjkWetI2gSUGpr0bE6MJPNxeXn/ZfqwmK9TD6PYQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gb8FqL5Qb57MOzn/UlNs7o4KQFn3DohQNohcNANkIb7dazA4V1WDlLoiMcFVa2827UQwjGtvfucEnunYEAIiSMVsXTmgkGJGHC8Ji+h7Yy9ir94BdL6dVNgvm6tFwY15AY20jsai8DYt6jnPskp/iqh2dkQ2I9ofw6BIQzEZw84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AGOIJDB5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AGOIJDB5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 724FE1F00AC4;
	Fri, 31 Jul 2026 23:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785541045;
	bh=Lh1/0FfraVLa7SimcsHUMfALGyAerQY5MToPlCDM8v8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AGOIJDB5yLK+d/KCkq1OXc0O2b9UogpQW6YqusAo+goN4stGR9sFsiIRYTanEoI/H
	 1VEa/hZCeWPxzw5nNcNZiZFHrVAaE5ORSI5SF8sC0i4AIgg4dfp38JMopjb5O7beMe
	 XRqV+TVLVnoXerot/4PkgJ7eJUhpbBm+jz3vO/N+vp+hKD4f+0RctQHN6sJfAKDQ6C
	 m51aOFpbrZqOcs6mOdIVntBsyBLLlqQJiMoBd4PljnKbzgEhvjrtgYmIXMBYtQW7Fy
	 GfVPzKy0te8JI35qNbZQZI6GaL8LtnR5+5Ml3P5MQHn1PZZeUbNRJSujGH+XeLmFdQ
	 H4Ki5xvNbU2mw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/9] perf/cxl: Fix the counter overflow delta fixup
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dave Jiang" <dave.jiang@intel.com>
Cc: linux-perf-users@vger.kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20260731232827.401447-4-dave.jiang@intel.com>
References: <20260731232827.401447-1-dave.jiang@intel.com>
 <20260731232827.401447-4-dave.jiang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 23:37:24 +0000
Message-Id: <20260731233725.724FE1F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Medium] A race condition between a polled read and the overflow IRQ hand=
ler causes a double-counting of a full period if the polled read executes a=
fter the counter wraps but before the IRQ handler.
- [Medium] Missing validation for `info->counter_width` allows a non-compli=
ant or buggy CXL device to trigger Undefined Behavior when `GENMASK_ULL` is=
 evaluated.
--

--- Patch [3]: [PATCH v3 3/9] perf/cxl: Fix the counter overflow delta fixu=
p ---
commit 333d6be6b59d292e876b5c4888ab33d0abc8cc03
Author: Dave Jiang <dave.jiang@intel.com>

perf/cxl: Fix the counter overflow delta fixup

This commit alters the CXL PMU counter overflow logic to condition the fixup
on new_cnt >=3D prev_cnt, aiming to correctly handle cases where the subtra=
ction
cannot express the span over a period boundary, while accommodating events
that increment by more than 1 per cycle. It also modifies the period additi=
on
to use mask + 1 to avoid undefined behavior on 64-bit counters.

Link: https://sashiko.dev/#/patchset/20260715191454.459673-1-dave@stgolabs.=
net?part=3D1

> diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
> index b16e2e4090a39..3511d049aea40 100644
> --- a/drivers/perf/cxl_pmu.c
> +++ b/drivers/perf/cxl_pmu.c
> @@ -689,7 +689,7 @@ static void __cxl_pmu_read(struct perf_event *event, =
bool overflow)
>  {
>  	struct cxl_pmu_info *info =3D pmu_to_cxl_pmu_info(event->pmu);
>  	struct hw_perf_event *hwc =3D &event->hw;
> -	u64 new_cnt, prev_cnt, delta;
> +	u64 new_cnt, prev_cnt, delta, mask;
> =20
>  	do {
>  		prev_cnt =3D local64_read(&hwc->prev_count);

[ ... ]

>  	/*
> -	 * If we know an overflow occur then take that into account.
> -	 * Note counter is not reset as that would lose events
> +	 * The mask discards exactly the bit that says the counter wrapped, so a
> +	 * delta of one whole period reads back as 0, the same as no events at
> +	 * all. Only the overflow status distinguishes them, and new_cnt >=3D
> +	 * prev_cnt is that case, so add the period back. mask + 1 is
> +	 * 2^counter_width, which is 0 for a 64-bit counter - the right value to
> +	 * add once the top bit is gone, and no undefined 1 << 64.
>  	 */
> -	delta =3D (new_cnt - prev_cnt) & GENMASK_ULL(info->counter_width - 1, 0=
);
> -	if (overflow && delta < GENMASK_ULL(info->counter_width - 1, 0))
> -		delta +=3D (1UL << info->counter_width);
> +	mask =3D GENMASK_ULL(info->counter_width - 1, 0);

[Severity: Medium]
This is a pre-existing issue, but could a buggy or malicious CXL device
reporting a counter width of 0 (or > 64) trigger Undefined Behavior here?

If the device reports 0 for the counter width in the capability registers,
the driver reads this into info->counter_width without bounds validation.

When GENMASK_ULL(info->counter_width - 1, 0) is evaluated, it results in a
negative shift amount which leads to Undefined Behavior and corrupted PMU
masks.

> +	delta =3D (new_cnt - prev_cnt) & mask;
> +	if (overflow && new_cnt >=3D prev_cnt)
> +		delta +=3D mask + 1;

[Severity: Medium]
This isn't a bug introduced by this patch, but does this sequence allow a=20
race condition between a polled read and the overflow IRQ handler to
double-count a full period?

If the hardware counter wraps, setting the overflow bit, a polled read
(such as via perf stat -I) might read the counter before the hardware IRQ
is delivered.

The polled read would compute the delta, correctly including the period
because new_cnt is wrapped and smaller than prev_cnt, and then update
prev_count to the small post-wrap value.

When the delayed overflow IRQ handler subsequently runs, it reads the
overflow bit and calls __cxl_pmu_read(event, true). Because prev_cnt is
now the small post-wrap value, new_cnt >=3D prev_cnt evaluates to true.

The handler would then execute delta +=3D mask + 1, incorrectly adding a
second full period because it assumes the wrap wasn't already consumed.

> =20
>  	local64_add(delta, &event->count);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731232827.4014=
47-1-dave.jiang@intel.com?part=3D3
