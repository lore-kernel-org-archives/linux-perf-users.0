Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E90D418372
	for <linux-perf-users@vger.kernel.org>; Fri,  7 Aug 2026 14:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786114711; cv=none; b=NtxFqJSinW8U3+ACnVlqbHgdX7jEqDyXxM1F7A/eUsMbdD1aWD4zWftkiH2XhbO4cVDp0azJMI9bAO2zRZhuMqi65SraOtzeaKcxGHv5FtDxmiSKwwgsXl/DUv4dbJzZ2afpNHYalxiBwV8zwWvTP+Mt1gLxcEsAEpR9uVJrm8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786114711; c=relaxed/simple;
	bh=qtjeGQY0E/nX7FGgYT6z4SRgWey6Jit5byCmw8/V+us=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sxn3/SZK11NZCiQigeCAbitWiiXXm8RoJs1K1jp03Ottd7g6OmzuHoRWg7tKLtaPNF7rWwBx0snNFX0QodHrAH2zbGbx9noIG42K6jQnA+WSzEb2iEXbcH9Uf6WpTp25YjfADIhaBK1KWHX2cwzlSCgai2HWoQTe2MvSNPfU+T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l7zqOJj3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l7zqOJj3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4707D1F00A3A;
	Fri,  7 Aug 2026 14:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786114710;
	bh=QMe8grVYbRUd8pe6cvk17MRIY0TmfjNKFx0jzqPyoOM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=l7zqOJj3+2pqwOyeLbD6/Pzkjd81AvmY4P1CAzhTqFStS4l44dYkIrv8FFTeM21W4
	 /6XMsPbWJbNi5D+kq5tSAf+t3SOQDxe2uGZYemlgGA2lKx0fLZYX3IVBJDO23JtoOk
	 0z3DqjuGxS7NhNXtryOQu2pPIUBZegWADSsd9PuT4mG34+mxk/DhJAWJZwalKesnr0
	 usKXtE/wHm+C8q+1pWIOe0k7pGZRgG9R4o16miEnGtJ8GR/EIbyCRYzFDnbJ6gpvyi
	 cTeOzcsLbLZ+tHjYBcwiDyTuNJiFIZ59l65pHOlaijay/XgJeuUzflOMSAtt4aa7Cy
	 s06SyI/uW5yqg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V5 1/6] powerpc/perf: Add HTM PMU driver to expose
 Hardware Trace Macro data
Reply-To: sashiko-reviews@lists.linux.dev
To: "Athira Rajeev" <atrajeev@linux.ibm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260807143734.1224-2-atrajeev@linux.ibm.com>
References: <20260807143734.1224-1-atrajeev@linux.ibm.com>
 <20260807143734.1224-2-atrajeev@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 14:58:29 +0000
Message-Id: <20260807145830.4707D1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Missing state reset in htm_event_del() causes spurious STOP and DE=
CONFIGURE hcalls on subsequent htm_event_add() failures.
--

--- Patch [1]: [PATCH V5 1/6] powerpc/perf: Add HTM PMU driver to expose Ha=
rdware Trace Macro data ---
commit 482e76cb25a86207519e7500e8ca689e3b600e86
Author: Athira Rajeev <atrajeev@linux.ibm.com>

powerpc/perf: Add HTM PMU driver to expose Hardware Trace Macro data

This commit adds a new PMU driver for the Hardware Trace Macro (HTM) on
POWER systems. It maps the PMU lifecycle to HTM hypervisor calls and=20
implements state tracking to handle hcall retries and error conditions.

> diff --git a/arch/powerpc/perf/htm-perf.c b/arch/powerpc/perf/htm-perf.c
> new file mode 100644
> index 0000000000000..cbe4f62813ee0
> --- /dev/null
> +++ b/arch/powerpc/perf/htm-perf.c
[ ... ]
> +static void htm_event_del(struct perf_event *event, int flags)
> +{
> +	int rc, ret, retries =3D 0;
> +	struct htm_target_id *target =3D event->pmu_private;
> +	struct htm_config cfg =3D target->cfg;
[ ... ]
> +	htm_event_stop(event, 0);
> +
> +	/*
> +	 * Only issue H_HTM_OP_DECONFIGURE if this driver successfully issued
> +	 * the paired H_HTM_OP_CONFIGURE.  If htm_event_add() failed before or
> +	 * during CONFIGURE (configured =3D=3D 0), there is nothing to tear dow=
n.
> +	 * Issuing DECONFIGURE without a prior CONFIGURE would silently destroy
> +	 * a concurrent trace session that owns the same hardware target and
> +	 * produce spurious pr_err() noise for an expected H_STATE / H_NOT_AVAI=
LABLE
> +	 * response.
> +	 */
> +	if (!target->configured)
> +		return;
> +
> +	/*
> +	 * Deconfigure the hardware resource.  Only H_BUSY is retried.
> +	 * If H_LONG_BUSY_* or any other error is returned, the resource
> +	 * cannot be reclaimed in this atomic context; log the failure so it
> +	 * is visible in the kernel log.
> +	 */
> +	do {
> +		rc =3D htm_hcall_wrapper(htmflags, cfg.nodeindex, cfg.nodalchipindex,
> +				       cfg.coreindexonchip, cfg.htmtype,
> +				       H_HTM_OP_DECONFIGURE, 0, 0, 0);
> +		ret =3D htm_return_check(rc);
> +	} while (ret =3D=3D -EBUSY && ++retries < MAX_RETRIES);
> +	if (ret <=3D 0) {
> +		pr_err("DECONFIGURE failed in htm event del (ret=3D%d) node:%u chip:%u=
 core:%u type:%u;\n",
> +				ret, cfg.nodeindex, cfg.nodalchipindex, cfg.coreindexonchip, cfg.htm=
type);
> +	}
> +	/* pmu_private freed by event->destroy =3D reset_htm_active */
> +}

[Severity: High]
Does this code need to reset target->configured to 0 after issuing the
H_HTM_OP_DECONFIGURE hcall?

If Process A disables an event via ioctl(PERF_EVENT_IOC_DISABLE),
htm_event_del() correctly deconfigures the hardware but leaves
target->configured as 1.

If Process B then opens and enables the same HTM target, it takes ownership.
If Process A subsequently re-enables its event, the H_HTM_OP_CONFIGURE in
htm_event_add() will fail. When Process A's htm_event_del() runs on the
error path, it will see the stale configured =3D=3D 1 state and spuriously =
issue
H_HTM_OP_DECONFIGURE.=20

Can this silently destroy Process B's active trace?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807143734.1224=
-1-atrajeev@linux.ibm.com?part=3D1
