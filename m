Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A193A3F5BE4
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 07:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789542616; cv=none; b=s5jrkQ2lh9Aa1vjiSJr6xjvCBPk9gNDc1CUnETn5YbCBEO46lCnjyH8NK/C/1mqsKrKoTzg7GTnfCfK3CPWeuveVvnHR98f/bwB/Ig2U+PF84Ny1n0XXWljgJ4ZJ/or/JnPS4owueXIrGo1VSzjwakKOs7rzB+9RRTMcAysb6mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789542616; c=relaxed/simple;
	bh=Hx/r57tpJWIhp0eYoCZdmmstEIhsTJqXtQCKYYPTcfo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TWJeqpswE0XbwlUzUq/i12duHQY+JlPGSWUygH6QKxgNq9tCR4cYe4irI6TqdCnaI8Ul4rrYqJHWIKxcWi9DMPDU/GZ4MMDYg1785pPu0qK9xiWDVI3qJQ36CEfOIkcCm0DsZ4I3hlgPaQ/UsDrLNIZsmu0WVgQVQ8TgxyarZxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WCBbaMCT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WCBbaMCT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DC891F0089B;
	Wed, 16 Sep 2026 07:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789542606;
	bh=6w/TIabZfrpoyaFshBgyLGKyTw9WM8gjMdJhsSooEgc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WCBbaMCTQp1P+oLE44ZDO/KsvvqysZiPosPq/oRFu4M+DJc0Z33XRPGvHJxouD0E/
	 tPSgMMa01oravd9zZg0RKsqMvpSsIwlpZRzQaQ+wBC4D8VqJMr/y70IoGpRlW/oCAf
	 BaApqJA3A9/YhH28DCpvhao2vPV4YW7/kcPmIALxxy1169aaMeK1ylGp4WsHGFIkei
	 /BCxIvmxbSPNvg2vvd5V6VzGnkFjpDrid6xEqtFUA4NFoS3BacmS66ORIKrATxcbB7
	 z8Pug79wQXOCdVbcFt0lIWt4JsBI4g9UhkRV5zlpQzRbVljG2LgtJT3o69qXhKoBh9
	 BtK7H8LbW8V7Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf/x86/amd: Move NMI latency window to last-resort
 suppression
Reply-To: sashiko-reviews@lists.linux.dev
To: "Guanghui Feng" <guanghuifeng@linux.alibaba.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260916065723.1976131-1-guanghuifeng@linux.alibaba.com>
References: <20260916065723.1976131-1-guanghuifeng@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 07:10:06 +0000
Message-Id: <20260916071006.9DC891F0089B@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] x86/nmi: silent unknown NMI suppression on non-AMD 32-bit CPUs
--

commit 6ca0dec4b1ba3bd7646b0d6ea1bfb276ba5b9732
Author: Guanghui Feng <guanghuifeng@linux.alibaba.com>
Subject: perf/x86/amd: Move NMI latency window to last-resort suppression

This patch defers the NMI latency window check to the very end of the NMI
dispatch path in unknown_nmi_error(). It stops claiming NMIs from within
the perf handler when no counter overflowed, and instead introduces a new
perf_nmi_window_active() check.

> diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
> index a787409f5a625..e9fca9a038c2e 100644
> --- a/arch/x86/events/amd/core.c
> +++ b/arch/x86/events/amd/core.c

[ ... ]

> +/**
> + * perf_nmi_window_active - Check if the PMC NMI latency window is still=
 open
> + *
> + * Returns true if the current time is within the NMI latency mitigation=
 window
> + * that was opened by the last PMC counter overflow handled on this CPU.=
 An
> + * open window means that a recently processed overflow may have generat=
ed an
> + * NMI which arrived too late to be paired with that overflow, and which
> + * therefore cannot be identified by any NMI handler.
> + *
> + * This is the last resort of the x86 NMI dispatch path: it is only call=
ed
> + * after all NMI_LOCAL handlers, the NMI reason port and all NMI_UNKNOWN
> + * handlers failed to claim the NMI. It must never be used to claim an N=
MI on
> + * behalf of perf, otherwise unrelated NMI sources would be dropped.
> + *
> + * Context: NMI context. Must not sleep and must not take locks.
> + */
> +bool perf_nmi_window_active(void)
> +{
> +	return !time_after(jiffies, this_cpu_read(perf_nmi_tstamp));
>  }

[Severity: High]
Does this strong symbol unconditionally override the weak fallback in nmi.c
for all x86 vendors when CONFIG_CPU_SUP_AMD=3Dy is set?

On non-AMD CPUs (like Intel), the AMD PMU driver never initializes,
leaving the per-CPU perf_nmi_tstamp permanently at 0.

On 32-bit x86 systems, jiffies starts at INITIAL_JIFFIES (5 minutes before
32-bit wrap). Does the check !time_after(jiffies, 0) incorrectly evaluate
to true for the first 5 minutes of uptime, and for 50% of the entire
32-bit wrap cycle (24.8 days out of every 49.7 days)?

> +EXPORT_SYMBOL_GPL(perf_nmi_window_active);
> =20
>  static int amd_pmu_handle_irq(struct pt_regs *regs)
>  {

[ ... ]

> diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
> index 3c9f60d6ca5a7..1aa161b56be0f 100644
> --- a/arch/x86/kernel/nmi.c
> +++ b/arch/x86/kernel/nmi.c

[ ... ]

> @@ -340,6 +350,19 @@ unknown_nmi_error(unsigned char reason, struct pt_re=
gs *regs)
> =20
>  	__this_cpu_add(nmi_stats.unknown, 1);
> =20
> +	/*
> +	 * No handler was able to identify this NMI, so its source is unknown.
> +	 * The one exception is a latent PMC overflow NMI: the overflow NMI can
> +	 * arrive long after the counter was already processed by an earlier
> +	 * NMI, which leaves nothing here that could identify it. If the perf
> +	 * NMI latency window is still open, this NMI is very likely that late
> +	 * arrival, so keep quiet about it instead of reporting a bogus unknown
> +	 * NMI (and instead of panicking on unknown_nmi_panic). It is still
> +	 * accounted in nmi_stats.unknown and thus stays visible in debugfs.
> +	 */
> +	if (perf_nmi_window_active())
> +		return;
> +

[Severity: High]
Because of the jiffies initialization on 32-bit systems mentioned above,
could this incorrectly drop unknown NMIs on non-AMD platforms, or on AMD
platforms before the first PMC counter overflow initializes the timestamp?

If the latency window is falsely considered active, could this cause
hardware faults causing unknown NMIs (e.g., SERR/IOCHK) to be silently
suppressed without warning?

>  	pr_emerg_ratelimited("Uhhuh. NMI received for unknown reason %02x on CP=
U %d.\n",
>  			     reason, smp_processor_id());
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916065723.1976=
131-1-guanghuifeng@linux.alibaba.com?part=3D1
