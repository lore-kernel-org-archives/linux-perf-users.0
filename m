Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793944736;
	b=DMTxlndILiK4AfaisxX8k6zz/9yyxM9JxuKUHS8YNHtJQhf4e8KK9EvrWao6KFkKa8dM
	 cfD3x7o0HOL4c6Bb7JXZtq5i0DnFvulTIep0QXeOmS5ngBC1AAgbpmtKmj1VPlIGT+Toz
	 FkIbHZ6fnkj4cikslQ+EC7CD4ugl1+jONR9ryw1oqz2/7xb5G9zeC38wKY8USZKNLs2GW
	 AoHyMhm4nxPIdSc1BVuYUzxdrbM1LqoUJzAjq5e4nKGI7oDSYyubewd5H/IuEjxhOxSeN
	 v/+LRO/3Idbqf1B01WghrhAkHT0Ys+AWnFU++bSBWjhUIC/5v1lNL0/RdNLB9ghzvmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793944736;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=cipKFjt9RPtu3YfE6J+06NIAiV5UxpwFte+EsJYFS3U=;
	b=pTR7ejlZVJ5CtGBAOY4xkqG78cGaBErBTf6weKU0x/W8vRhYP1eMvpDiV+79iAOoJRat
	 FbPub5onH3AmhX6vcKZJSYO0SPEpu9QBTZ091dFUdMvt4GpX6De+wYmLKxFXrhRQrC7Y8
	 02BuY1qyhcnwW09gjXOgjQ0a5qnJ0u+Ox0ywxe8N+/p/gvyXX57bsXunz5u1o8RK0oDZO
	 rU6LouBmec7AN5QjOeGwkySs2geF/nvacFaE3tUkPqExIIIBEv2zznz515fQ0bXixkqnH
	 D4lLjYZEXUCQCR1dg4TS0IacYKdPQ7IQe0r1jMkoXmzuMyW1Qlpf+r9S1wQXtXzbCdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZOGgu+dK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADCB606A326;
	Fri,  6 Nov 2026 05:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZOGgu+dK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE7291F0089F;
	Fri,  6 Nov 2026 05:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793944736;
	bh=cipKFjt9RPtu3YfE6J+06NIAiV5UxpwFte+EsJYFS3U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZOGgu+dK0Pau3UJsjpB3ebqiuwb3xyz2GrPijAol9X3I5O1apxrD8J16doijjJkWX
	 Wlh0wQZn5O6L2ZSmd0yR1bjX4Q4aB7d3bFU4AAO5iHZQEL66+w6pgv3dtOWakaXrpD
	 xpS/DwILLqsjhdr3szzSQ9yz8aTEgdga3Qn+DzWIP0cKJDLp2ECBxaOaTBmgGJk0FA
	 A653tX9KUUTt9Ad2I6zDXVby33axckWTTIiMO/0PSAf8OTQFG/VrgdJDGS8a6W5Sw6
	 twHlhwS5vrFD96ki9oLZNEkIaGeWciE1fkgLaPWd6ubqtZKmg2Y10+RJ6wYZrCYT3v
	 HQzqQUPXdjmAg==
Message-ID: <sashiko-outbox-200872@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [Patch v6 15/20] perf/x86/intel: Refresh LBR stack for non-PEBS
 LBR events when needed
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20261106043257.842864-16-dapeng1.mi@linux.intel.com>
References: <20261106043257.842864-1-dapeng1.mi@linux.intel.com>
 <20261106043257.842864-16-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 05:58:55 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] perf/x86/intel: unrefreshed or clobbered LBR stack on
  indirect PEBS drain
--

commit f13e61130af8b47007c91f048b386359760f05ad
Author: Dapeng Mi <dapeng1.mi@linux.intel.com>

perf/x86/intel: Refresh LBR stack for non-PEBS LBR events when needed

This commit tracks whether the shared LBR stack has been refreshed during P=
MI
handling with a lbr_refreshed flag and removes the unconditional LBR read at
PMI entry so the live LBR state is read on demand for non-PEBS LBR events a=
nd
re-read if PEBS draining overwrites it.

> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index fbde874af6182..b267c68f94676 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c

[ ... ]

> @@ -4003,8 +4013,19 @@ static int handle_pmi_common(struct pt_regs *regs,=
 u64 status)
>  		 *
>  		 * The PEBS buffer has to be drained before handling the A-PMI
>  		 */
> -		if (is_pebs_counter_event_group(event))
> +		if (is_pebs_counter_event_group(event)) {
> +			/*
> +			 * PEBS counter sampling is only supported on adaptive PEBS
> +			 * and arch-PEBS, both of which snapshot the LBR stack.
> +			 * No explicit LBR refresh is needed here.
> +			 */
>  			static_call(x86_pmu_drain_pebs)(regs, &data);
> +			/*
> +			 * Draining the PEBS buffer can overwrite the shared
> +			 * LBR stack, so mark lbr_refreshed as false.
> +			 */
> +			lbr_refreshed =3D false;
> +		}
> =20
>  		last_period =3D event->hw.last_period;
> =20
> @@ -4013,8 +4034,14 @@ static int handle_pmi_common(struct pt_regs *regs,=
 u64 status)
> =20
>  		perf_sample_data_init(&data, 0, last_period);
> =20
> -		if (has_branch_stack(event))
> +		if (has_branch_stack(event)) {
> +			if (!lbr_refreshed) {
> +				intel_pmu_lbr_read(cpu_lbr_stack(cpuc),
> +						   cpuc->lbr_counters);
> +				lbr_refreshed =3D true;
> +			}
>  			intel_pmu_lbr_save_brstack(&data, cpuc, event);
> +		}
> =20
>  		x86_pmu_clear_perf_regs(regs);
>  		x86_pmu_update_perf_regs(event, &data, regs, false);

[Severity: Medium]
Can perf_event_overflow() still drain the PEBS buffer and clobber
cpu_lbr_stack(cpuc) when is_pebs_counter_event_group(event) is false?

When a non-PEBS event using PERF_SAMPLE_READ | PERF_FORMAT_GROUP is grouped
with a PERF_X86_EVENT_AUTO_RELOAD PEBS LBR sibling (without
PERF_X86_EVENT_PEBS_CNTR set on the leader), perf_event_overflow() ->
perf_output_sample() -> perf_output_read_group() -> intel_pmu_read_event()
calls intel_pmu_drain_pebs_buffer() before PERF_SAMPLE_BRANCH_STACK is
written.  Draining pending PEBS records calls intel_pmu_store_pebs_lbrs(),
which overwrites cpu_lbr_stack(cpuc) before the current non-PEBS sample
copies data.br_stack and leaves lbr_refreshed set to true for any subsequent
non-PEBS LBR events in the same PMI.

In addition, because the unconditional intel_pmu_lbr_read() at PMI entry is
removed, an indirect PEBS drain on pre-adaptive PEBS
(!x86_pmu.intel_cap.pebs_baseline) when GLOBAL_STATUS_BUFFER_OVF_BIT is cle=
ar
will run intel_pmu_pebs_fixup_ip() against an unrefreshed
cpu_lbr_stack(cpuc).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106043257.8428=
64-1-dapeng1.mi@linux.intel.com?part=3D15
