Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38DE8375ADF
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 12:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789563585; cv=none; b=uD3h13D9efKfp5Y9dC6H8mnQg9PHc3v3yJMVAchRSgBSnhmZrPGVtxu8OhtcS6ouJBe0Lj4S0loYoNAVk6C12iFtDn764QoQfcTYhaDI3SVeEXNSFOnR5LWRuDeOIhcTErGJGPlQKEOTiS4J7cOBQESDrarvKLq24k3kfw+0ZMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789563585; c=relaxed/simple;
	bh=mW0tlTDPDUgJegtqhHcj54C7j43fGQKbG9TO6fgTV1Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Gwmi/dDWJYJo1zu2JPPt6l+z/KIIRcSiaYuoCBqqTxf5b0a0p8OD+9AjJhGMVyidt8bdbos1oH2nBSd3ZZPXfRAew0W9W43xR4WmFBSwhXQtFJst7ece0pKaBMS8JYTRLdQ4VcCI7cj0r9V/ozjM7unQbsWe0iu1drRyFAe0JoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GWIuXZBo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GWIuXZBo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 017161F000FF;
	Wed, 16 Sep 2026 12:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789563584;
	bh=+WbyzW3ju8UPD88wyBTBNnFWOYw6Dh0zJ4P70vQr1QA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GWIuXZBo1sgEzQtz0lh314YT3BpsjTrlQTmB5SEhl1Ks0U1T+S/+IeCSabfJSM6K3
	 yXDcCFcZ62pgChfQRMMKRbccM2Rc0teSlPjQQS0sWqTwp2C5FihbioCgMzYC84/M0l
	 1ZYz9aldJZXZof9auKQU+OFMl0LRW9fXeH7skTcmEMEaAmjOaVHRCXgN9BJooQVzgn
	 Qavws3iiC1HwYmkYz3yrYmw0EHcvi1Ubrj6Z01S5iFysTI7NPmg8Tc1SpC54iwzi95
	 SzgLgfmeB/vbKzV+FOP2jqsRqmiTurFDLpFcKIvqQ+3LgvSF6Z8XzWDSEr+ek2B3Cn
	 k1nxSJHre4CiQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] perf/x86/amd: Move NMI latency window to last-resort
 suppression
Reply-To: sashiko-reviews@lists.linux.dev
To: "Guanghui Feng" <guanghuifeng@linux.alibaba.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260916125016.2266596-1-guanghuifeng@linux.alibaba.com>
References: <20260916093217.GH4121339@noisy.programming.kicks-ass.net>
 <20260916125016.2266596-1-guanghuifeng@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 12:59:43 +0000
Message-Id: <20260916125944.017161F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] x86/nmi: TOCTOU race in perf_nmi_window_active() causes spurious p=
anic
--

commit 48f851c34890a3a07c65994472936573ea009e9e
Author: Guanghui Feng <guanghuifeng@linux.alibaba.com>

perf/x86/amd: Move NMI latency window to last-resort suppression

This commit delays claiming NMIs in the perf handler when no counter
overflowed, allowing other NMI handlers to run first. It updates the NMI
dispatch path to consult the latency window twice: once to skip the
reason port read, and a second time as a last resort to suppress
bogus unknown NMI reports.

> diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
> index 3c9f60d6ca5a7..1226c18e37a61 100644
> --- a/arch/x86/kernel/nmi.c
> +++ b/arch/x86/kernel/nmi.c

[ ... ]

> @@ -407,38 +430,50 @@ static noinstr void default_do_nmi(struct pt_regs *=
regs)
>  	}
> =20
>  	/*
> -	 * Non-CPU-specific NMI: NMI sources can be processed on any CPU.
> +	 * If the perf NMI latency window is still open, a recently handled PMC
> +	 * overflow may have generated a latent NMI that arrives too late to be
> +	 * paired with that overflow. Skip the expensive reason port read
> +	 * (inb 0x61 + global nmi_reason_lock) which is a known scalability
> +	 * bottleneck when spurious PMIs arrive at high frequency on AMD.
>  	 *
> -	 * Another CPU may be processing panic routines while holding
> -	 * nmi_reason_lock. Check if the CPU issued the IPI for crash dumping,
> -	 * and if so, call its callback directly.  If there is no CPU preparing
> -	 * crash dump, we simply loop here.
> +	 * NMI_UNKNOWN handlers (hpwdt, etc.) are still invoked below via
> +	 * unknown_nmi_error(), so hardware watchdog NMIs are not lost.
>  	 */
> -	while (!raw_spin_trylock(&nmi_reason_lock)) {
> -		run_crash_ipi_callback(regs);
> -		cpu_relax();
> -	}
> +	if (!perf_nmi_window_active()) {

[Severity: High]
Could this introduce a race condition with jiffies updates on other CPUs?

Looking at perf_nmi_window_active(), it evaluates the window state against
the globally incrementing jiffies variable:

arch/x86/events/amd/core.c:perf_nmi_window_active() {
    ...
    return !time_after(jiffies, this_cpu_read(perf_nmi_tstamp));
}

If perf_nmi_window_active() returns true here in default_do_nmi(), the
NMI reason port read is skipped and execution proceeds down to
unknown_nmi_error().

If a timer interrupt on another CPU increments jiffies between this first
check and the second check inside unknown_nmi_error():

arch/x86/kernel/nmi.c:unknown_nmi_error() {
    ...
    if (perf_nmi_window_active())
        return;
    ...
}

Would this cause the second check to evaluate to false, resulting in a
fall-through that logs a bogus "unknown NMI" error and potentially triggers
a spurious kernel panic if unknown_nmi_panic is set?

> +		/*
> +		 * Non-CPU-specific NMI: NMI sources can be processed on any CPU.
> +		 *
> +		 * Another CPU may be processing panic routines while holding
> +		 * nmi_reason_lock. Check if the CPU issued the IPI for crash
> +		 * dumping, and if so, call its callback directly.  If there is no
> +		 * CPU preparing crash dump, we simply loop here.
> +		 */

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916125016.2266=
596-1-guanghuifeng@linux.alibaba.com?part=3D1
