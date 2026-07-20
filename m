Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934183E0224
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Jul 2026 11:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784545247; cv=none; b=SHBZLL0kytPI61NjIFS1BaZmsGeJQf8BelvkkHSDlPJiEx+eF23z3UWZnNsGOcS43APBPtl5qOz2m2+/fFT0+OYKZzoJGqR4OVblU+9eLIUMkBxPmqUut5I6C/nc8YiwoY4euzVJGeCpRPDtvjhX3LBm1M948ep7kqRdGY4cZp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784545247; c=relaxed/simple;
	bh=OtR/2hUBZbXomJUMxHI98+r7a83d9k9Wux/swi6yDQg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=B2ngNQQIAEhUnQ/F5BHPhvksXmi3Rbg5R3+yc2bMFBeSsOuvsMftA0hgFg5eR13uDtO0XcCTG/h4+fU3kMGjIXUNzbSam2yVg0IFmFiAMxNCv4Sgt4OL+bA9+34G2hmwrwqsCGUZjtxLeNGdqWQk/wdcpNsc+GiKr/BtGIftIMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jt+MPp4h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jt+MPp4h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 137431F00A3A;
	Mon, 20 Jul 2026 11:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784545246;
	bh=B6ueg4PzMcFj7pD9ihKEiUcr3heAjIeTLwPoqnX1/Fc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jt+MPp4hBLsa3vgd0wZa+8CZHV9siVTPXCtHZgSB/sUceKHZZMTeQCYafSFpUC3I7
	 LziUhA7wMVKqis6Xd5UuD4FN8Hv+ND2Acp2yLFftzr1vUd+fjbaPbl9oGmuK+SrH4l
	 HVIFsD2kgL2wGS/9MZzetcbffsVu2cyFeTZJOsFMNbRbgQjgjjU5jbxey150ngTKnj
	 tLnfB33nKDMfxkyxqKeYN3UEjWC/P7GA+Yz1RucgMD4UYMA1XEEsUZGGFg2PR1fQ+2
	 e8ISAy2sDIQ3PvS9A7YOkivI5vcpk6rYMeOBlkyy0hQhjRUKW4+A4jSkGU4tD6eh4P
	 2jD0yHfkQv9Kw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V2 1/6] powerpc/perf: Add HTM PMU driver to expose
 Hardware Trace Macro data
Reply-To: sashiko-reviews@lists.linux.dev
To: "Athira Rajeev" <atrajeev@linux.ibm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260720104447.11843-2-atrajeev@linux.ibm.com>
References: <20260720104447.11843-1-atrajeev@linux.ibm.com>
 <20260720104447.11843-2-atrajeev@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 11:00:45 +0000
Message-Id: <20260720110046.137431F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Hardware Resource Leak on H_LONG_BUSY_* in Teardown Paths
- [High] Missing Global Target Collision Detection
- [High] Hypervisor HCALL Flooding via Misunderstood pmu->add Semantics
--

--- Patch [1]: [PATCH V2 1/6] powerpc/perf: Add HTM PMU driver to expose Ha=
rdware Trace Macro data ---
commit 5f73062ed0507987b187b59e32b4100e6330618a
Author: Athira Rajeev <atrajeev@linux.ibm.com>

powerpc/perf: Add HTM PMU driver to expose Hardware Trace Macro data

The H_HTM hypervisor call (hcall) provides an interface to the Hardware
Trace Macro (HTM) function on POWER systems.  HTM captures hardware-level
trace data for a specific node/chip/core target within a logical partition.

> diff --git a/arch/powerpc/perf/htm-perf.c b/arch/powerpc/perf/htm-perf.c
> new file mode 100644
> index 0000000000000..5d3aa9c7fd8d1
> --- /dev/null
> +++ b/arch/powerpc/perf/htm-perf.c

[ ... ]

> +static ssize_t htm_return_check(int rc)
> +{
> +	switch (rc) {
> +	case H_SUCCESS:
> +	case H_PARTIAL:
> +		return 1;
> +	case H_NOT_AVAILABLE:
> +		return 0;
> +	case H_BUSY:
> +		/* Transient busy: retry loop will spin up to MAX_RETRIES */
> +		return -EBUSY;
> +	case H_LONG_BUSY_ORDER_1_MSEC:
> +	case H_LONG_BUSY_ORDER_10_MSEC:
> +	case H_LONG_BUSY_ORDER_100_MSEC:
> +	case H_LONG_BUSY_ORDER_1_SEC:
> +	case H_LONG_BUSY_ORDER_10_SEC:
> +	case H_LONG_BUSY_ORDER_100_SEC:
> +		/*
> +		 * Hypervisor requests a long delay before retry (1ms-100s).
> +		 * Spinning in a kernel retry loop for this duration risks
> +		 * deadlocks in atomic contexts.  Return -EAGAIN so callers
> +		 * exit immediately; the operation will fail and userspace
> +		 * can retry the perf_event_open() call.
> +		 * Note: all retry loops check ret =3D=3D -EBUSY only, so
> +		 * -EAGAIN exits without retrying, this is intentional.
> +		 */
> +		return -EAGAIN;

[Severity: High]
The comment mentions that returning -EAGAIN will cause the perf_event_open()
call to fail so userspace can retry. Is this accurate for paths called
during event scheduling?

When htm_return_check() is called from htm_event_add(), -EAGAIN is returned
to the perf core's pmu->add() caller (event_sched_in). The perf core treats
-EAGAIN from pmu->add as a transient scheduling failure and will repeatedly
attempt to schedule the event on subsequent timer ticks or context switches.

Will this flood the hypervisor with H_HTM_OP_CONFIGURE hcalls exactly when
it is requesting a long backoff delay?

[ ... ]

> +static int htm_event_init(struct perf_event *event)
> +{
> +	u64 config =3D event->attr.config;
> +	struct htm_config cfg;
> +
> +	if (event->attr.inherit)
> +		return -EOPNOTSUPP;

[ ... ]

> +	parse_htm_config(config, &cfg);
> +	switch (cfg.htmtype) {
> +	case HTM_CORE:
> +	case HTM_NEST:
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	/* Allocate per-event private state; freed via event->destroy */
> +	event->pmu_private =3D kzalloc(sizeof(struct htm_target_id), GFP_KERNEL=
);
> +	if (!event->pmu_private)
> +		return -ENOMEM;

[Severity: High]
Does this missing global target collision detection allow hardware state
corruption?

The driver sets PERF_PMU_CAP_EXCLUSIVE, but the perf core only enforces this
within the same per-CPU context. If two users concurrently create events for
the exact same HTM hardware resource (identical node/chip/core) on different
CPUs, they would bypass that check.

Without a global registry of active targets here in htm_event_init(), could
conflicting hcalls be issued to the identical hardware resource, clobbering
the hypervisor configuration?

[ ... ]

> +static void htm_event_stop(struct perf_event *event, int flags)
> +{
> +	int rc, ret, retries =3D 0;
> +	struct htm_config cfg;
> +	struct htm_target_id *target =3D event->pmu_private;
> +
> +	/*
> +	 * Ignore context-switch-out stops. The perf core passes
> +	 * PERF_EF_UPDATE on context-switch-out. Do not stop the hcall.
> +	 */
> +	if (flags & PERF_EF_UPDATE)
> +		return;
> +
> +	/* Not tracing, nothing to stop */
> +	if (target->tracing_active =3D=3D HTM_TRACING_INACTIVE)
> +		return;
> +
> +	cfg =3D target->cfg;
> +
> +	/* Only retry on transient H_BUSY; H_LONG_BUSY_* (-EAGAIN) exits immedi=
ately */
> +	do {
> +		rc =3D htm_hcall_wrapper(htmflags, cfg.nodeindex, cfg.nodalchipindex,
> +				       cfg.coreindexonchip, cfg.htmtype,
> +				       H_HTM_OP_STOP, 0, 0, 0);
> +		ret =3D htm_return_check(rc);
> +	} while (ret =3D=3D -EBUSY && ++retries < MAX_RETRIES);

[Severity: High]
If the hypervisor returns H_LONG_BUSY_* (which maps to -EAGAIN), the loop
exits immediately. Since htm_event_stop() returns void, it cannot defer
the cleanup or notify the perf core. Does this permanently leave the trace
started in the hypervisor?

[ ... ]

> +static int htm_event_add(struct perf_event *event, int flags)
> +{

[ ... ]

> +	/*
> +	 * Start tracing via the .start callback so the standard
> +	 * PERF_EF_START / ioctl(ENABLE) path is honoured.
> +	 */
> +	if (flags & PERF_EF_START) {
> +		htm_event_start(event, 0);	/* flags=3D0: not a context switch */
> +		if (target->tracing_active =3D=3D HTM_TRACING_INACTIVE) {
> +			/* Start failed, deconfigure to avoid resource leak */
> +			retries =3D 0;
> +			do {
> +				rc =3D htm_hcall_wrapper(htmflags, cfg.nodeindex,
> +						       cfg.nodalchipindex, cfg.coreindexonchip,
> +						       cfg.htmtype, H_HTM_OP_DECONFIGURE, 0, 0, 0);
> +				ret =3D htm_return_check(rc);
> +			} while (ret =3D=3D -EBUSY && ++retries < MAX_RETRIES);
> +			return -EIO;
> +		}
> +	}
> +
> +	return 0;
> +}

[Severity: High]
Similar to htm_event_stop(), if H_HTM_OP_DECONFIGURE returns a long busy
status here in the error rollback path, the retry loop exits immediately
and returns -EIO. Does this leak the configured hypervisor resource?

> +
> +static void htm_event_del(struct perf_event *event, int flags)
> +{
> +	int rc, ret, retries =3D 0;
> +	struct htm_target_id *target =3D event->pmu_private;
> +	struct htm_config cfg =3D target->cfg;
> +
> +	/* Stop tracing, flags=3D0 so htm_event_stop issues the hcall */
> +	htm_event_stop(event, 0);
> +
> +	/* Deconfigure */
> +	do {
> +		rc =3D htm_hcall_wrapper(htmflags, cfg.nodeindex, cfg.nodalchipindex,
> +				       cfg.coreindexonchip, cfg.htmtype,
> +				       H_HTM_OP_DECONFIGURE, 0, 0, 0);
> +		ret =3D htm_return_check(rc);
> +	} while (ret =3D=3D -EBUSY && ++retries < MAX_RETRIES);

[Severity: High]
If this loop exits on -EAGAIN, the resource is silently abandoned without
deferring cleanup. The kernel will then free event->pmu_private during
event->destroy. Could this result in a permanent leak of shared hypervisor
HTM resources, potentially leading to a denial of service for hardware
tracing?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720104447.1184=
3-1-atrajeev@linux.ibm.com?part=3D1
