Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6984447D93C;
	Wed,  5 Aug 2026 16:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785946911; cv=none; b=aUSwT7EDZU3mZYG0HgjK1kwAzIfpyZubTvlGLUzTtRiZ6O+Zf4ygZh4gsMc7HAKX6tP6ryiHM8W3AONxt1NVGz82dOIPsMfbdJ9lGYtJeqwq+/fSBbS4kW2MVugoV9nI6+XyxVoIZ+V3akjuizDpRErEoAp34Lizt4+ketRGI98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785946911; c=relaxed/simple;
	bh=2DxAhv7GnhnDW96j5W2CZ/Zkx1PaVNp8q/Bv1w6Wj4Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TMtN54Rzl3Kvi/KLjHA99yLOFvZZFggdm4yIUCtQxkBP2A+MQ8/NOWVhqqS2JrCzY9Q81fPxCd+HOJhWZ1E4RcpoUYb9gUeqqfdjpt3Oe2fNHD18rmevcPEYW00f3bp0sF8CyiREV5I0OdmVbl/AjlzLD+aXyNzQuUoP+Cbfz4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KH/+8tUE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KH/+8tUE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2EDC1F000E9;
	Wed,  5 Aug 2026 16:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785946910;
	bh=W+rKcyVE23H3qysASqtwbU9J19wW/dNA0ASPvAUChvg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KH/+8tUEmKCBoCRKxvFc6+drZrCOJh++9rEn2lxj/t58GFBfKCYo57+Bq42IoUcYj
	 cnP31nmgIYalZl/OdSt+zub8qK4BJIhqykuYUb/N56GhESvpTi/lw1mEksFQbk3zGy
	 vTiVqw/bLKCbsRgKH/2lXBizv6m3RnohR8lclGIMlqxbroPLcnynremJn26im46kEo
	 NZpG/GEms9SFZlSyqvT9j7hZjZ7CaZnCHQZGZvVCGiwxCw5YaijO4w6+mdvkkfy77u
	 SezsNpCmHaHUH99o8kMtTopVWlI5MXMBKJPMDIhA/3F3ldGo7A43c5eNSXQEfRJ4GJ
	 NHURQJ+PwMl1Q==
From: sashiko-bot@kernel.org
Subject: Re: [RESEND PATCH v4 11/11] perf/cxl: Clear stale overflow status
 before using a counter
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dave Jiang" <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20260805155911.1304807-12-dave.jiang@intel.com>
References: <20260805155911.1304807-1-dave.jiang@intel.com>
 <20260805155911.1304807-12-dave.jiang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 16:21:48 +0000
Message-Id: <20260805162149.D2EDC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Flawed overflow handling adds phantom counts to events when `cxl_p=
mu_read()` races with the overflow interrupt.
--

--- Patch [11]: [RESEND PATCH v4 11/11] perf/cxl: Clear stale overflow stat=
us before using a counter ---
commit 7eae9f25fd541ecbfdfed643b25d0495c2ec7444
Author: Dave Jiang <dave.jiang@intel.com>
perf/cxl: Clear stale overflow status before using a counter

This commit clears the overflow status register in cxl_pmu_event_start() and
cxl_pmu_probe(). This ensures that a counter handed from one event to the
next does not start with a previous owner's pending overflow, preventing
phantom counts from being added on handover.

Closes: https://lore.kernel.org/linux-cxl/anAVpO--i5heVfz9@MWDK4CY14F/

> diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
> --- a/drivers/perf/cxl_pmu.c
> +++ b/drivers/perf/cxl_pmu.c
> @@ -683,6 +683,15 @@ static void cxl_pmu_event_start(struct perf_event *e=
vent, int flags)
>  	 */
>  	cfg |=3D FIELD_PREP(CXL_PMU_COUNTER_CFG_THRESHOLD_MSK,
>  			  cxl_pmu_config1_get_threshold(event));
> +
> +	/*
> +	 * Drop any overflow the previous owner of this counter left pending;
> +	 * cxl_pmu_event_stop() does not. Otherwise an interrupt latched over
> +	 * the handover gets charged to this event. Do it before arming Interru=
pt
> +	 * on Overflow below, and note RW1C leaves the other counters alone.
> +	 */
> +	writeq(BIT_ULL(hwc->idx), base + CXL_PMU_OVERFLOW_REG);

[Severity: High]
This is a pre-existing issue, but while we are addressing phantom counts fr=
om
stale overflows here, is there still a race condition between cxl_pmu_read()
and the overflow interrupt that can also result in phantom periods?

If the hardware counter wraps, it sets the overflow bit and raises an MSI.
Before the ISR can run, cxl_pmu_read() might be called (for instance, via a
system call or a periodic timer) while local IRQs are disabled:

cxl_pmu_read()
  __cxl_pmu_read(event, false)

This calculates the correct delta, adds it to the event count, and updates
prev_count to match new_cnt.

Once IRQs are re-enabled, the pending MSI fires. cxl_pmu_irq() runs and cal=
ls:

cxl_pmu_irq()
  __cxl_pmu_read(event, true)

Because prev_count was just updated, prev_count and new_cnt are now equal or
nearly equal. In __cxl_pmu_read(), we have:

	if (overflow && new_cnt >=3D prev_cnt)
		delta +=3D mask + 1;

Since new_cnt is greater than or equal to prev_cnt and the overflow flag is
passed as true by the ISR, does this logic erroneously add a full mask + 1
phantom period to the performance counter?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805155911.1304=
807-1-dave.jiang@intel.com?part=3D11
