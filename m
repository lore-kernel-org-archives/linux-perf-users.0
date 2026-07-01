Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D715182D6
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Jul 2026 08:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782895848; cv=none; b=Jt2mN2qI36W1VR/VZhMXrHqQIDZbwpfzSjG3HEsLy9rH5X6Pi1UIaIGwZTCLEap+9OWDv4SFDdTUr1ZbsCCKKYHHN86eARp31VPICtgyHCCK+BCosc549AGgrzUSBFoBFUTO9HvJTriVpmMTInZxeeTHzlQkqvQKVH2B/1SSPlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782895848; c=relaxed/simple;
	bh=zQvrI2A5tev+CFy7jVopfuK9Hl1ko4KYnyQpWvih40k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZIfOAN98PgN7QpalI16WUxTKVjETgLeDnZH2ResEqgZqAVt80JDHpWt9zVAnpMJ2uUsN/bSqzt4kFkiMEy0y1pQfxAK5ukM46r+josCCgcAaOj1Tgjm7WzR8J9joiEQhnZQ2/VY1F7U1eaMjaKUocmRbuN1kyslpCxO7hQGg4g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iH8ZnvfS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iH8ZnvfS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C2CE1F000E9;
	Wed,  1 Jul 2026 08:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782895847;
	bh=LVsVI11pIx5GBFm8knq+2I/TjxlqrTkpYxNTWMmod+s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iH8ZnvfS9FykLKyHox5KszIbcF7qIUdXvxt18IwUJRFWcSPvsJRC5e/0OTZutKVEU
	 wpGfi6/UPJAqJzR/CSgugCgPlrMXb6+kED9e6F5yvJMw0OfhMqhBVq6aZVB1Z65wxY
	 XFZVKlPvD8ftXd+YpIOAEUSDpooPFjlvRf6Nu/u++fF/tXF2nEW7cVDNvxPvuX/jBN
	 6MBYlkJCwfiluD/+kR6aPP4bHwPP5OS7OqbmAmkgHnEs4XHVmWYZ389MRmZl0DtvQB
	 l3RtxphhjDLfSr/DGMwqYRpNNs8WFnglyV7VgbkodPFz/84tyhkg/VmYAIitGCCpMk
	 upvvP0KGhKKOQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/5] powerpc/htm: Add interface to expose HTM trace data
 via perf
Reply-To: sashiko-reviews@lists.linux.dev
To: "Athira Rajeev" <atrajeev@linux.ibm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260701083806.79358-2-atrajeev@linux.ibm.com>
References: <20260701083806.79358-1-atrajeev@linux.ibm.com>
 <20260701083806.79358-2-atrajeev@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 08:50:46 +0000
Message-Id: <20260701085047.1C2CE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:
- [High] Missing Firmware Feature Check allows PMU to register on bare-meta=
l systems.
- [High] Improper Error Handling treats unhandled hypervisor errors as succ=
ess.
- [High] Resource leak when `H_HTM_OP_START` fails.
- [High] Missing cpumask attribute leads to concurrent identical hypercalls.
- [Medium] Retry loops spin endlessly on deterministic errors.
- [Medium] PMU API violation for start/stop operations.
- [Medium] Improper handling of `sample_freq` corrupts the sampling logic.
--

commit 400fb092e994f5871c30e25b796b6ab855238ea4
Author: Athira Rajeev <atrajeev@linux.ibm.com>

powerpc/htm: Add interface to expose HTM trace data via perf

H_HTM (Hardware Trace Macro) hypervisor call is an HCALL to export data
from Hardware Trace Macro (HTM) function. Add support for setup,
configuration and control of HTM function via PMU.

> diff --git a/arch/powerpc/perf/htm-perf.c b/arch/powerpc/perf/htm-perf.c
> new file mode 100644
> --- /dev/null
> +++ b/arch/powerpc/perf/htm-perf.c

> [ ... ]

> +static ssize_t htm_return_check(int rc)
> +{
> +	switch (rc) {
> +	case H_SUCCESS:
> +		break;

> [ ... ]

> +	case H_AUTHORITY:
> +		return -EPERM;
> +	}
> +
> +	/*
> +	 * Return 1 for H_SUCCESS/H_PARTIAL
> +	 */
> +	return 1;
> +out:
> +	return -EINVAL;
> +}

[Severity: High]
Will unhandled hypercall return codes fall through the switch statement
and return 1 (success)? If the hypervisor returns an unhandled error code,
this code might silently interpret critical failures as successes.

> [ ... ]

> +static int htm_event_init(struct perf_event *event)
> +{
> +	struct hw_perf_event *hwc =3D &event->hw;
> +	u64 config =3D event->attr.config;
> +	u32 htmtype;

> [ ... ]

> +	if (event->attr.freq) {
> +		hwc->sample_period =3D event->attr.sample_period;
> +		local64_set(&hwc->period_left, hwc->sample_period);
> +		hwc->last_period =3D hwc->sample_period;
> +		event->attr.freq =3D 0;
> +	}
> +
> +	return 0;
> +}

[Severity: Medium]
Does copying the target frequency into the sample period break the sampling
logic? Since frequency-based sampling does not appear to be supported, shou=
ld
this return -EINVAL instead of disabling dynamic frequency adjustment?

> [ ... ]

> +static int htm_event_add(struct perf_event *event, int flags)
> +{
> +	int rc, ret;
> +	unsigned long param1 =3D -1, param2 =3D -1;
> +	int retries =3D 0;
> +	u64 config =3D event->attr.config;
> +	u32 htmtype, nodeindex, nodalchipindex, coreindexonchip;
> +
> +	/*
> +	 * Invoke H_HTM call with:
> +	 * operation as htm configure (H_HTM_OP_CONFIGURE)
> +	 * last three values are unused, hence set to zero
> +	 */
> +	htmtype =3D config & 0xf;
> +	nodeindex =3D (config >> 4) & 0xff;
> +	nodalchipindex =3D (config >> 12) & 0xff;
> +	coreindexonchip =3D (config >> 20) & 0xff;
> +	do {
> +		rc =3D htm_hcall_wrapper(htmflags, nodeindex, nodalchipindex, coreinde=
xonchip,
> +			htmtype, H_HTM_OP_CONFIGURE, param1, param2, 0);
> +		ret =3D htm_return_check(rc);
> +	} while (ret <=3D 0 && ++retries < 100);

[Severity: Medium]
Does this loop retry 100 times for deterministic errors like -EINVAL and
-EPERM? The condition ret <=3D 0 causes it to spin needlessly on errors that
will not succeed on retry.

> +	if (ret <=3D 0)
> +		return -1;
> +
> +	/* Reset retries */
> +	retries =3D 0;
> +
> +	/*
> +	 * Invoke H_HTM call with:
> +	 * operation as htm  start (H_HTM_OP_START)
> +	 * last three values are unused, hence set to zero
> +	 */
> +	do {
> +		rc =3D htm_hcall_wrapper(htmflags, nodeindex, nodalchipindex, coreinde=
xonchip,
> +				htmtype, H_HTM_OP_START, 0, 0, 0);
> +		ret =3D htm_return_check(rc);
> +	} while (ret =3D=3D -EBUSY && ++retries < 100);
> +
> +	if (htm_return_check(rc) <=3D 0)
> +		return -1;

[Severity: High]
If H_HTM_OP_START fails, does this return without cleaning up the
configuration? Because event_add fails, the perf core aborts event creation
and won't call event_del, potentially leaving the hypervisor state permanen=
tly
configured and leaking tracing resources.

[Severity: Medium]
Is it expected to execute the start operation unconditionally during event_=
add
instead of using the standard pmu->start callback? If the event is created =
in
a disabled state, it will immediately start tracing anyway.

> +	return 0;
> +}
> +
> +static void htm_event_del(struct perf_event *event, int flags)
> +{
> +	long rc;
> +	int ret;
> +	int retries =3D 0;
> +	u64 config =3D event->attr.config;
> +	u32 htmtype, nodeindex, nodalchipindex, coreindexonchip;

> [ ... ]

> +	/* Reset retries */
> +	retries =3D 0;
> +
> +	/*
> +	 * Invoke H_HTM call with:
> +	 * operation as htm configure (H_HTM_OP_DECONFIGURE)
> +	 * last three values are unused, hence set to zero
> +	 */
> +	do {
> +		rc =3D htm_hcall_wrapper(htmflags, nodeindex, nodalchipindex, coreinde=
xonchip,
> +			htmtype, H_HTM_OP_DECONFIGURE, 0, 0, 0);
> +		ret =3D htm_return_check(rc);
> +	} while (ret <=3D 0 && ++retries < 100);
> +}

[Severity: Medium]
Similar to the configure path, does this loop needlessly spin on determinis=
tic
errors like -EINVAL and -EPERM?

> [ ... ]

> +static void htm_event_stop(struct perf_event *event, int flags)
> +{
> +}

[Severity: Medium]
Does providing an empty stop callback prevent users from disabling tracing =
via
the standard perf API? ioctl(PERF_EVENT_IOC_DISABLE) relies on this callback
to pause the hardware.

> +static struct pmu htm_pmu =3D {
> +	.task_ctx_nr =3D perf_invalid_context,
> +
> +	.name =3D "htm",
> +	.attr_groups =3D attr_groups,
> +	.event_init  =3D htm_event_init,
> +	.add         =3D htm_event_add,
> +	.del         =3D htm_event_del,
> +	.read        =3D htm_event_read,
> +	.start	     =3D htm_event_start,
> +	.stop	     =3D htm_event_stop,
> +	.capabilities =3D PERF_PMU_CAP_NO_EXCLUDE | PERF_PMU_CAP_EXCLUSIVE,
> +};

[Severity: High]
Does this system-wide PMU require a cpumask attribute to prevent concurrent
access? Without a cpumask, running perf stat -a might attempt to open and
start the HTM event on every CPU simultaneously, leading to race conditions
on the hypervisor side for the same node/chip target.

> +static int htm_init(void)
> +{
> +	int r;
> +
> +	/* This driver is intended only for L1 host. */
> +	if (is_kvm_guest()) {
> +		pr_debug("Only supported for L1 host system\n");
> +		return -ENODEV;
> +	}
> +
> +	r =3D perf_pmu_register(&htm_pmu, htm_pmu.name, -1);

[Severity: High]
Can this PMU register on bare-metal systems (PowerNV/OPAL) where the PAPR
hypervisor isn't present? It might be necessary to verify the presence of t=
he
hypervisor using firmware_has_feature(FW_FEATURE_LPAR) to prevent system
traps or panics when executing H_HTM.

> +	if (r)
> +		return r;
> +
> +	return 0;
> +}
> +
> +device_initcall(htm_init);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701083806.7935=
8-1-atrajeev@linux.ibm.com?part=3D1
