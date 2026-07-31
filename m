Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20003331ECF;
	Fri, 31 Jul 2026 23:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785541566; cv=none; b=PzxZo9CJA/ukeqiDWpbFZQdYCOsyYWSSAZvTaT6uG0xIFeNaj+Ics8mYyckEf2xjVGnqx47rj06y0BZbUcjlbq4udZ4dCaFkItHCn5BrMq+kxlzj1sbehjXljUiIJzwRUdaoIzSCFuHSY+A00bsn2ViS4DuLLWwYaKcJ/A4sKjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785541566; c=relaxed/simple;
	bh=6nJLX8BAI/87cnmZ3mefIGcvmiUX6ndZ24u9x5xHcQw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sUDxHonGROpp55C4+fqTmnzLpMfNwguaYpBT2MudFTVjWsQIEGWPLPPOMrilCUrnRkz8lZzwPJXNphvnpwkvEnV0h+KRdcdXwQFuOF8WKNW6qw69j6MgJMeNrq5/0/RTDDiIpr7dn/LXDzCCcLpWUO1x4xxbiaHR0KsxWSqXm4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EHEfU5Sr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EHEfU5Sr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83AA81F00AC4;
	Fri, 31 Jul 2026 23:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785541564;
	bh=sSBfnHzY+e2FXXzsfbcsC9IMUyIvK1kyMM4SYDlqqvQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EHEfU5SrGA9mQKNWwjaMHJwLEOXPbDBllBbrB1sBvCKQ+7dNgqe5Jqq4EAnMrDjkH
	 dOBm3zfUstWU9P4z/DzYG+OxBMHc+HpXaDM/1b+pULjWA6zw3e7o97ylVL0++KaFeL
	 +EiBKJ7EzEP4dJ5t3DZiSVh5i+/LB8hyC5ROGuOJ1UCmGgbYnHf0YJALFzCF4Q6d+9
	 FgBWr/oFzlxnC2JsBRYVguPlIPgE6URsXrzzjYB2kvcgAFlJEa/+BXwPPJIb/033Yf
	 Iqs3iWbFmcJOuCrook46ci45HKpkZkwtXkZYdTVJzihRhtsafrP1m3B65M2pPgC+aM
	 HJK4F9WGjC0pg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 9/9] perf/cxl: Don't log through pmu.dev in the
 overflow interrupt handler
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dave Jiang" <dave.jiang@intel.com>
Cc: linux-perf-users@vger.kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20260731232827.401447-10-dave.jiang@intel.com>
References: <20260731232827.401447-1-dave.jiang@intel.com>
 <20260731232827.401447-10-dave.jiang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 23:46:04 +0000
Message-Id: <20260731234604.83AA81F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Double counting and cross-event corruption of performance events d=
ue to uncleared pending overflows.
--

--- Patch [9]: [PATCH v3 9/9] perf/cxl: Don't log through pmu.dev in the ov=
erflow interrupt handler ---
commit d6b58846ef576f998be916a54f3a5a31363d2d44
Author: Dave Jiang <dave.jiang@intel.com>

perf/cxl: Don't log through pmu.dev in the overflow interrupt handler

This commit fixes a use-after-free in the CXL PMU overflow interrupt handler
by changing the logging device to the parent and clears any stale overflow
status before requesting the IRQ.

Closes: https://sashiko.dev/#/patchset/20260715191454.459673-1-dave@stgolab=
s.net?part=3D1

[ ... ]

> --- a/drivers/perf/cxl_pmu.c
> +++ b/drivers/perf/cxl_pmu.c

[ ... ]

> @@ -903,6 +903,15 @@ static int cxl_pmu_probe(struct device *dev)
>  	if (!irq_name)
>  		return -ENOMEM;
> =20
> +	/*
> +	 * Clear any overflow status left set by firmware or a previous kernel
> +	 * before the handler goes live, so it cannot mistake a stale bit for an
> +	 * overflow on a counter no event owns yet. The register is RW1C, and
> +	 * bits above the implemented counters are RsvdZ, so only write those.
> +	 */
> +	writeq(GENMASK_ULL(info->num_counters - 1, 0),
> +	       info->base + CXL_PMU_OVERFLOW_REG);
> +

[Severity: High]
This isn't a bug introduced by this patch, but since we are clearing stale=
=20
overflow bits here, does cxl_pmu_event_stop() also need to clear the overfl=
ow=20
bit when stopping an event?

Currently, cxl_pmu_event_stop() in drivers/perf/cxl_pmu.c disables the coun=
ter=20
but doesn't clear any pending overflow bit in CXL_PMU_OVERFLOW_REG. If an=20
event overflows just before being stopped (e.g., during PMU multiplexing),=
=20
and a new event is started on the same counter or reset via=20
PERF_EVENT_IOC_RESET, the hardware overflow bit remains set.

When IRQs are re-enabled, cxl_pmu_irq() handles the pending IRQ and calls
__cxl_pmu_read() with overflow=3Dtrue. Because the counter was just reset
by cxl_pmu_event_start(), both new_cnt and prev_cnt will be 0.=20

Since new_cnt (0) >=3D prev_cnt (0), would __cxl_pmu_read() falsely apply t=
he=20
wraparound fixup:

	delta =3D (new_cnt - prev_cnt) & mask;
	if (overflow && new_cnt >=3D prev_cnt)
		delta +=3D mask + 1;

Could this erroneously add a full period (e.g., 2^64 ticks) to the newly
started or reset event and corrupt the counter statistics?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731232827.4014=
47-1-dave.jiang@intel.com?part=3D9
