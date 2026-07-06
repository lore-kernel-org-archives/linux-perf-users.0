Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF5E171CD
	for <linux-perf-users@vger.kernel.org>; Mon,  6 Jul 2026 05:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783314254; cv=none; b=spBRdXZnc9MuUxjVhi5Od66U/NKlrvMTOfL4MofFwC9l7xv1KK7OutJL2gcq+8SuVNLlpf/M3g24cJhLiCTwHbHMGTrQ//6RWy3lXO9DWog53jMu4siZ+8bJasBNxnHmCBUpN93Kg3/0+yJmm6ekMVMb3etidIcJkdNFGXYIOFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783314254; c=relaxed/simple;
	bh=vuCShk2pqdOJqZ+MoR9bCJpciUQFNUBBQ5SbyDksqS8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bs0ZXolLV282t6H5zJzN8QAuDyCx5fm3/G//AKkLAoGm2DOkdlMv1nxTvt5ycXjl3+KnPtVaK8t/vGne3UzJwpvfNQa/vb/b75Uwjln0MxxWMUPwwB9YyK109KIseaqdnxMp37t6V+vlOaRMxpHWsx2H8I+JwqrvnamSI5amiBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nLxNl4bB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nLxNl4bB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 999B31F000E9;
	Mon,  6 Jul 2026 05:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783314252;
	bh=KrOH5wQ2LeXArCSvcjBwJPzsvqvt2LDyd7R67BLKn78=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nLxNl4bBSiH9ozBZH94EQESqINM3yPB6cAODKihJSbql19YpMOPvk78ibmUnhHJhd
	 Ov2u3ptTQ6jzJnBX3enatPRAfOP5l629XWi5LzcAtKI2/qvSMg33utqJO/rJXl7gRR
	 NdvuYeQrvl8GHnHausj4zg8PlcpVZB9ps1hLRhW5Jo0EWZvtz3rhrOftRjp2PdnGVP
	 /829easAhFpu+VqfphmW7mVBL+04ouk8R2Byhw0ueE22bZTXCdcQp3w2HMIzqY/su5
	 8aTERmgBEkjtqY5dB5vy+REQIoaZUrtxf7nyXBExdbXbQU4g8S8hJxyCGDEaqDqhaC
	 9MF1WavZPSqKQ==
From: sashiko-bot@kernel.org
Subject: Re: [Patch v9 24/24] perf/x86/intel: Add sanity check for PEBS
 fragment size
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260706015439.3040804-25-dapeng1.mi@linux.intel.com>
References: <20260706015439.3040804-1-dapeng1.mi@linux.intel.com>
 <20260706015439.3040804-25-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 05:04:12 +0000
Message-Id: <20260706050412.999B31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Events without preceding valid records in a corrupted PEBS buffer =
are permanently stalled.
--

commit e2dd3df4b73a7bfac8a1332ea38906750253ef38
Author: Dapeng Mi <dapeng1.mi@linux.intel.com>

perf/x86/intel: Add sanity check for PEBS fragment size

This patch adds a sanity check for corrupted PEBS fragment sizes to prevent
potential infinite loops. If a corrupted fragment is detected, the entire
PEBS record and all subsequent records are dropped to ensure data integrity.

> diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
> index b38aed4f62b4c..7a8e619055393 100644
> --- a/arch/x86/events/intel/ds.c
> +++ b/arch/x86/events/intel/ds.c

[ ... ]

> @@ -3244,7 +3261,8 @@ static __always_inline void
>  __intel_pmu_handle_last_pebs_record(struct pt_regs *iregs,
>  				    struct pt_regs *regs,
>  				    struct perf_sample_data *data,
> -				    u64 mask, short *counts, void **last,
> +				    u64 mask, short *counts,
> +				    void **last, bool corrupted,
>  				    setup_fn setup_sample)
>  {
>  	struct cpu_hw_events *cpuc =3D this_cpu_ptr(&cpu_hw_events);
> @@ -3258,7 +3276,7 @@ __intel_pmu_handle_last_pebs_record(struct pt_regs =
*iregs,
>  		event =3D cpuc->events[bit];
> =20
>  		__intel_pmu_pebs_last_event(event, iregs, regs, data, last[bit],
> -					    counts[bit], setup_sample);
> +					    counts[bit], corrupted, setup_sample);
>  	}
> =20
>  }

[Severity: High]
This is a pre-existing issue, but does this logic permanently stall PMU
profiling for events without preceding valid records in a corrupted buffer?

In arch/x86/events/intel/ds.c:__intel_pmu_handle_last_pebs_record(), we skip
processing if the count is zero:

	for_each_set_bit(bit, (unsigned long *)&mask, X86_PMC_IDX_MAX) {
		if (!counts[bit])
			continue;
		...

If a corrupted PEBS record is detected (e.g., via the newly added at >=3D t=
op
bounds checks) and the code exits the drain loop early, events that had no
valid records parsed prior to the corruption will have a count of zero.

Because these events are skipped here, __intel_pmu_pebs_last_event() is nev=
er
called, preventing intel_pmu_save_and_restart() from re-arming their hardwa=
re
counters. Furthermore, since handle_pmi_common() explicitly masks PEBS even=
ts
out of the global status, the generic NMI handler will also ignore them.

Could this lead to the hardware counters remaining disabled, stopping
profiling until the session is recreated?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706015439.3040=
804-1-dapeng1.mi@linux.intel.com?part=3D24
