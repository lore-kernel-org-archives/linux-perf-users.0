Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4003439E194
	for <linux-perf-users@vger.kernel.org>; Wed, 29 Apr 2026 20:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777495139; cv=none; b=rojdFPT5s8NYIOge9jrDId6o7ysWquPisl6Kafuy7WBDT9/vu1kOcPWPYTIagR3Lb13pIdnlnV0W7FAXZzSoQ1+EFEkZlCbARrGuPHY/84IoTX1OvPTlFzm0RUVV0GdXrgoePBumaLbDbQWC/3D5uHEog78Al2z/tIRwlg/oDfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777495139; c=relaxed/simple;
	bh=J+b5eLwRLP2N4kEg+fP1XVjfLEEe35IxpDfdqseLmNw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IH/xO7zIm4Qry5NmrSFeIT+C4tS+6ZTQRRJLfqV7eqRdPPTpt8dbA2+giFnFpfgbfGTdZMLzL+3O5HapUTmtmgjzslEYXJJwuJ7uRLDj/NdgIZ0eWBqJMrP12wnZMlgzcz8hox/zuHwobNGknl/vQbKCsIX3zpMFDnNz/v7ly6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=otGtQ6Uo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="otGtQ6Uo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA1ACC19425;
	Wed, 29 Apr 2026 20:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777495138;
	bh=J+b5eLwRLP2N4kEg+fP1XVjfLEEe35IxpDfdqseLmNw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=otGtQ6UoUXH/2ugcytT7C9qzPton+KeFeqA3r8FG0BWxBWZ1MU3V0osGhGWe0GIzh
	 v84xmRNSZ41hnmsTG1pFELVG9YMopf0SvOTCmuP47HEx/vmbXnRGOah4+ExaK5ffYU
	 2tVsK+jbfmvq/RsWignhEi8MyakGJoCyXfiRxzXBngRhiUppJHwvi07r7+GOgQ1tuJ
	 VeuArXZAjwm/VD02bpe62EcT2SEzQU2fvp0z9rlKUw6Yra7XreyEV7QoNOLhvx5rMg
	 P/+BZgIuMySaO3upKS/EgSX6mQHlqAeIQ677v2f4cE1ageYt11n2htgkhsC/TdXy19
	 3tp1earhTsTfg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] perf: Don't throttle based on NMI watchdog
 events
Reply-To: sashiko@lists.linux.dev
To: "Calvin Owens" <calvin@wbinvd.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <33d87384aa5f96af76949d1399476779dd4f4fce.1777483573.git.calvin@wbinvd.org>
References: <33d87384aa5f96af76949d1399476779dd4f4fce.1777483573.git.calvin@wbinvd.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Apr 2026 20:38:57 +0000
Message-Id: <20260429203858.CA1ACC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Non-atomic 64-bit cmpxchg in NMI context on 32-bit architectures c=
auses torn writes and breaks nesting protection.
- [High] Logic error in time gap calculation incorrectly includes the curre=
nt NMI's duration, contradicting the comment and incorrectly bypassing thro=
ttling.
- [High] Hardcoded 1-second bypass fundamentally defeats the `perf_cpu_time=
_max_percent` sysctl limit for low-frequency, long-running PMU events.
--

commit 657f1aa01c3c8a25116ffd10c6d50891dd498e3f
Author: Calvin Owens <calvin@wbinvd.org>

perf: Don't throttle based on NMI watchdog events

This commit modifies perf_sample_event_took() to skip throttling for
infrequent NMIs by checking if the previous NMI occurred more than one
second ago. It uses a per-CPU timestamp updated via cmpxchg to track
the last throttle time.

> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 5b5cb620499e..6f367da17ff5 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -596,6 +596,7 @@ core_initcall(init_events_core_sysctls);
>   */
>  #define NR_ACCUMULATED_SAMPLES 128
>  static DEFINE_PER_CPU(u64, running_sample_length);
> +static DEFINE_PER_CPU(u64, last_throttle_clock);

[ ... ]

> @@ -636,6 +639,19 @@ void perf_sample_event_took(u64 sample_len_ns)
>  	if (avg_len <=3D max_len)
>  		return;
> =20
> +	/*
> +	 * Very infrequent events like the perf counter hard watchdog
> +	 * can trigger spurious throttling: skip throttling if the prior
> +	 * NMI got here more than one second before this NMI began. But
> +	 * never skip throttling if NMIs are nesting, or if any NMI runs
> +	 * for longer than one second.
> +	 */
> +	now =3D local_clock();
> +	last =3D __this_cpu_read(last_throttle_clock);
> +	if (__this_cpu_cmpxchg(last_throttle_clock, last, now) =3D=3D last &&

On 32-bit architectures, is it safe to use __this_cpu_cmpxchg() on a 64-bit
value in NMI context?

For architectures like 32-bit x86, the generic fallback implementation
achieves atomicity by disabling interrupts, which does not mask NMIs. If a
nested NMI interrupts the sequence halfway through reading or writing the
32-bit halves of the u64, could this result in a torn read or write?

A corrupted timestamp could cause a massive wrap-around in the time gap
calculation, perpetually satisfying the > NSEC_PER_SEC bypass condition and
silently disabling PMU throttling for all events on that CPU.

> +	    now - last > NSEC_PER_SEC && sample_len_ns < NSEC_PER_SEC)

The comment indicates the intent is to skip throttling if the prior NMI
occurred more than one second before this NMI began.

However, local_clock() is sampled at the end of the current NMI, so now
includes the current NMI's duration.

If an NMI takes a very long time (e.g., 900ms) but started only 200ms after
the previous NMI ended, the true gap before it began is 200ms. Because now
includes the 900ms duration, now - last evaluates to 1100ms, which bypasses
the throttling.

Could this artificially inflate the time gap for long-running NMIs,
directly defeating the throttling mechanism?

Additionally, is it possible for user-defined PMU events with expensive
overhead (like heavy eBPF programs attached to slow tracepoints) to exploit
this hardcoded frequency bypass?

If an event triggers slower than 1Hz but takes a very long time to execute
(e.g., 999ms), both now - last > NSEC_PER_SEC and sample_len_ns <
NSEC_PER_SEC will be true.

Such an event would bypass the moving average calculation and never be
throttled, allowing it to consume nearly 100% of the CPU while it runs and
violating the default 25% CPU time limit set by
sysctl_perf_cpu_time_max_percent.

> +		return;
> +
>  	__report_avg =3D avg_len;
>  	__report_allowed =3D max_len;
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1777483573.gi=
t.calvin@wbinvd.org?part=3D2
