Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5681ACED5
	for <linux-perf-users@vger.kernel.org>; Wed,  5 Aug 2026 15:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785943260; cv=none; b=RyZ66g+tTUJYS005oy/fFzOuz5ETI6pWuw0XOF85pIlR6tzagZSDRCRnb70tC04xXAmW+eEtWz4Anm+dCglZCqt/mEv7FFZJUo/R4lJPlsqcB2ga9QpKDjWFZkWRThy+UJ6Q6R//OzFTSvlJGfipuV+xVFrn7islaXhryiqznnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785943260; c=relaxed/simple;
	bh=eTXay/nhwqR9wCsqiE/bd8ZilVrOCCWAzQzOLwKY4aA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=msfVEVS97G9yCVus5smxBbZgGQgeZMSiZLaqghGPMCZd03eeR289hyfUHNCxmPB098MoXEhWHBJg+j82hpMDMplq6mSBqKeBx6vONsB/cTzcYSvVav/Bj+mRq/m9CHMUqtVugdxTobpF6SseZQQABi3LZESrFOTYxTyx9q5w094=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BJVPvFn4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BJVPvFn4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 575771F000E9;
	Wed,  5 Aug 2026 15:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785943258;
	bh=pzsoUoRIYlUEJ0uLiXe+kfJD68x0huq5zepxVh72SC8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BJVPvFn49sptYj5PVpd0TFuWF2rw+9HzN7DETccXim690v3PGFOEt/M7AkgbIkGQa
	 KHHhVSdq5fudbXCumkRydp1vCbao085fxJ3tiN9oM1R5sbvDJbQ+8+qWuv2dmIL7hj
	 1o7FSO/OWSAlqV84f0nyzHe0YIpOWcATdi1PX52Yr+a2J1HmiqtrRg1X+ovFUswSif
	 6AgGJm/FO6VubqAi0Uv6hFPyKoyiLGOuKlKFjqm58tSYPx5RyDmmaR6aDu0ZkhNAXO
	 Gkv+JavlXbfL89e5QfSDmz+w8EWSQzHKUQ8YYiEARAdXh+Fd+U4dlkYszg9VT4nRmH
	 DqOYrtzF9YYtw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] perf: arm_spe: Factor aux output and flags out of
 buffer fault handler
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260805-james-spe-software-discard-v1-1-0ff0e44c4c92@linaro.org>
References: <20260805-james-spe-software-discard-v1-0-0ff0e44c4c92@linaro.org>
 <20260805-james-spe-software-discard-v1-1-0ff0e44c4c92@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 15:20:57 +0000
Message-Id: <20260805152058.575771F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing immediate `isb()` after writing to control-plane system re=
gister `SYS_PMBLIMITR_EL1`.
- [High] Missing immediate `isb()` after writing to control-plane system re=
gister `SYS_PMSCR_EL1`.
--

--- Patch [1]: [PATCH 1/3] perf: arm_spe: Factor aux output and flags out o=
f buffer fault handler ---
commit 454b555e21bef7b51b93cb02a78486de3845b1b9
Author: James Clark <james.clark@linaro.org>
Subject: perf: arm_spe: Factor aux output and flags out of buffer fault han=
dler

This patch refactors the ARM SPE PMU buffer fault handling by separating the
auxiliary buffer output management and flags from the fault decoding logic.
This simplifies the stop handling routine as it no longer conditionally
calls the aux output end function. No functional changes are intended.

> diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
> index dbd0da1116390..10d28ad81256f 100644
> --- a/drivers/perf/arm_spe_pmu.c
> +++ b/drivers/perf/arm_spe_pmu.c
> @@ -677,11 +677,12 @@ static void arm_spe_pmu_disable_and_drain_local(voi=
d)
> =20
>  /* IRQ handling */
>  static enum arm_spe_pmu_buf_fault_action
> -arm_spe_pmu_buf_get_fault_act(struct perf_output_handle *handle)
> +arm_spe_pmu_buf_get_fault_act(u64 *aux_flags)
>  {

[ ... ]

> out_write_limit:
> 	write_sysreg_s(limit, SYS_PMBLIMITR_EL1);
> 	return (limit & PMBLIMITR_EL1_E) ? 0 : -EIO;

[Severity: High]
This is a pre-existing issue, but is an immediate isb() required here?

The ARM64 architecture guidelines state that writes to control-plane system
registers like SYS_PMBLIMITR_EL1 must be followed by an isb() as the very
next instruction. In arm_spe_perf_aux_output_begin() in=20
drivers/perf/arm_spe_pmu.c, the function returns immediately after the writ=
e,
which could leave the CPU pipeline in an architecturally undefined state for
subsequent instructions.

[ ... ]

> 	reg =3D arm_spe_event_to_pmscr(event);
> 	isb();
> 	write_sysreg_s(reg, SYS_PMSCR_EL1);
> }

[Severity: High]
This isn't a bug introduced by this patch, but shouldn't there be an isb()
after this system register write?

In arm_spe_pmu_start() in drivers/perf/arm_spe_pmu.c, an isb() is issued
before writing to SYS_PMSCR_EL1, but it appears missing immediately after
the write. Missing context synchronization after a system register write
might leave the pipeline exposed to a stale configuration state.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805-james-spe-=
software-discard-v1-0-0ff0e44c4c92@linaro.org?part=3D1
