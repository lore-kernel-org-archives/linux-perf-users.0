Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF3538D6AD
	for <linux-perf-users@vger.kernel.org>; Fri, 17 Jul 2026 13:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784295017; cv=none; b=D0WsaGzFR5Oli7sRXdg/qzN3o0wGAi2th0KUpvWkQHHyO2nXNT4buZ1qViT/MbYDWhyw6yhWCq/hUT8CLeOBLl+94QuQ21cm4oe3dYFkXHRRa/9oro2stHs676FSvH5ppZw+CyG3LAR0P2ueronlKcyGce2exDtp/etfA9k0NjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784295017; c=relaxed/simple;
	bh=8myaVgi8X9mDVZPr34d7IZWvtwAwdKzQZ3diZtPUYGg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gcu0gnqP8MD/nJACl2tadmjZj6A+CRM99++MBflPDHaLxBO1Q7L8jez+sqQhYHqKphkibI+t2AeeQLOHIuElSl5XaG8uzsqJbjy+VjGR7fd5WiP7cXFEg6SKewpvkcM9c2l1soBPHob7VOKftxyslxWSSpH6yAwjznaR2rg3LIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=js3tTJga; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="js3tTJga"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 506F81F00A3A;
	Fri, 17 Jul 2026 13:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784295016;
	bh=eJas3laRZKDRFOAWryayhD8OBH3Z5urLejFD4MOnPVg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=js3tTJgaqwPmYWQeV08R3KqoEzsLr13+Mst3P3595RIyZr2A4DQ1btbZofU4KlrCU
	 z+rGMByb97tSWJcjPbq0X/uaBEljh58H/YIowEIkKhuESHoyBOebBaLU8J3m6fQrdG
	 nF+4dqZSpz6lM9J2hs5Pw8dEdmwrjW9C8RBgLX/2HCIB5KNDin8a+Ah4UbKSTdPyRp
	 tqMkTqNfsZNpCiQ1RggExJjlNfCgW34YR1EY0RBaT9qrYeo++k3L6fWhAvWXvQ0zLA
	 CM9HuYxjeydYlm4flBT6ueYz49AhW4lgPFBQAw8W00xf526dUy1wDEjfeHrQ9NZ40S
	 YzpuAMV7cyG9w==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 13/13] Documentation/dev-tools: document KWatch
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jinchao Wang" <wangjinchao600@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260717130726.1904101-1-wangjinchao600@gmail.com>
References: <20260717125023.1895892-1-wangjinchao600@gmail.com>
 <20260717130726.1904101-1-wangjinchao600@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 13:30:15 +0000
Message-Id: <20260717133016.506F81F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Race condition during CPU offline leads to spurious WARN_ONCE and =
potential Use-After-Free.
- [High] KWatch blindly filters out hits from the armed task's callees and =
local interrupts.
- [Medium] Missing Kconfig dependency on TRACING/TRACEPOINTS.
--

--- Patch [13]: [RFC PATCH v2 13/13] Documentation/dev-tools: document KWat=
ch ---
commit 2276ea12010818a130be33709ca8b2c8928c26a9
Author: Jinchao Wang <wangjinchao600@gmail.com>

Documentation/dev-tools: document KWatch

Describe what KWatch is for, how it compares with KASAN and KFENCE,
the debugfs configuration interface, the watch expression syntax,
how to read hits from the trace buffer (including after a crash),
and the current limitations.

> diff --git a/mm/kwatch/Kconfig b/mm/kwatch/Kconfig
> new file mode 100644
> index 0000000000000..6ec9aa448ecec
> --- /dev/null
> +++ b/mm/kwatch/Kconfig
> @@ -0,0 +1,28 @@
> +config KWATCH
> +	tristate "Kernel Watch Framework"
> +	depends on PERF_EVENTS && HAVE_HW_BREAKPOINT && DEBUG_FS
> +	depends on HAVE_REINSTALL_HW_BREAKPOINT
> +	depends on KPROBES && KRETPROBES
> +	depends on STACKTRACE

[Severity: Medium]
Should this configuration depend on or select TRACING or TRACEPOINTS?

Since KWatch outputs successful memory access hits exclusively through the
kwatch_hit tracepoint, building without tracepoint support results in KWatch
compiling and consuming hardware debug registers, but silently failing to
report any hits when memory corruption occurs.

> +	help
> +	  A generalized hardware-assisted memory monitor utility.

[ ... ]

> diff --git a/mm/kwatch/hwbp.c b/mm/kwatch/hwbp.c
> new file mode 100644
> index 0000000000000..d1e93754cce82
> --- /dev/null
> +++ b/mm/kwatch/hwbp.c

[ ... ]

> +static int kwatch_hwbp_cpu_offline(unsigned int cpu)
> +{
> +	struct kwatch_watchpoint *wp;
> +	struct perf_event *bp;
> +
> +	mutex_lock(&kwatch_all_wp_mutex);
> +	list_for_each_entry(wp, &kwatch_all_wp_list, list) {
> +		bp =3D per_cpu(*wp->event, cpu);
> +		if (bp) {
> +			unregister_hw_breakpoint(bp);
> +			per_cpu(*wp->event, cpu) =3D NULL;

[Severity: High]
Does this sequence open a race condition during CPU offline?

If an asynchronous IPI from kwatch_hwbp_arm() interrupts the offlining CPU
exactly between the unregistration and the pointer being cleared:

	unregister_hw_breakpoint(bp);
	/* IPI arrives here */
	per_cpu(*wp->event, cpu) =3D NULL;

The IPI handler in kwatch_hwbp_arm_local() will read the non-NULL,
unregistered breakpoint and pass it to modify_wide_hw_breakpoint_local().

Could this access unlinked and potentially freed memory (if the RCU grace
period elapses), corrupting debug registers or triggering a spurious
WARN_ONCE?

> +		}
> +	}
> +	mutex_unlock(&kwatch_all_wp_mutex);
> +	return 0;
> +}

[ ... ]

> diff --git a/mm/kwatch/probe.c b/mm/kwatch/probe.c
> new file mode 100644
> index 0000000000000..249aa50c9f782
> --- /dev/null
> +++ b/mm/kwatch/probe.c

[ ... ]

> +bool kwatch_probe_validate_hit(struct pt_regs *regs,
> +			       struct task_struct *arm_tsk)
> +{
> +	struct kwatch_tsk_ctx *ctx =3D kwatch_tsk_ctx_get(false);
> +	const struct kwatch_config *cfg =3D kwatch_probe_ctx.cfg;
> +
> +	if (unlikely(!ctx || !cfg))
> +		return true;
> +
> +	if (arm_tsk !=3D current || ctx->depth !=3D cfg->depth + 1)
> +		return true;
> +
> +	return false;

[Severity: High]
Does this logic inadvertently filter out genuine corruptions?

Returning false when arm_tsk =3D=3D current and ctx->depth =3D=3D cfg->dept=
h + 1
prevents hits from being logged for the current function. However, since
depth is only incremented when recursively entering the watched function,
does this also silently ignore memory corruptions caused by the watched
function's callees, or by any interrupt handler that preempts the watched
task on the same CPU?

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717125023.1895=
892-1-wangjinchao600@gmail.com?part=3D13
