Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C6AEACD
	for <linux-perf-users@vger.kernel.org>; Thu, 30 Apr 2026 02:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777514643; cv=none; b=Dj7kVvs4No1rbyOZRXHwtiWlPWu4s4wt6Fy9vDYLlStsN0WRr4AyZzx3f+EIhoR1+1tJ1TZ7yoHAGXoeg+IVGDha8pslFzyG7A9OFDS988IFmET6AeDXD2wtozfpW/rUIXtiZRZAlQ3W9+N/KRtM1wX0Yost3aA1t8AFBxR7AbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777514643; c=relaxed/simple;
	bh=jWtOdivSqHnHOpPve/AZPpRvji4bw+P24hzIBMQsaIM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PxtooYPDuPIFXstRnjqZ0AaQuDdbJ2utY4h1fcjraY070wpBh/DHDAzcdD4Tz3KvDX6wFBn597sY/nzaQJvSKuN7WTyE0pCNQJxKjAJkqF5dqbEoQZLQxbs5WsfmUHQ+J8xEIa+ND7ngsjYd03SXwAjFLlihDLtpVHs6Es4xKxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CChm73An; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CChm73An"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60C32C19425;
	Thu, 30 Apr 2026 02:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777514642;
	bh=jWtOdivSqHnHOpPve/AZPpRvji4bw+P24hzIBMQsaIM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=CChm73An5VSJqfUTODQOLPZKibskXdr+nZCaF/HZ+4igXljqQ7uRK+0/NX7I06Rs/
	 B2eb3Wfo8dBnyAftp6aVUw+pe4wrbJWPboDTNXbVSneT18SnBn7HE13NemrFccZiBu
	 KzdIyen38YhqaRNW9CNovuogxi/agp3V/PTyNd6HprKkZSYoaxD34hUGewNW4rWewy
	 FvbE+NeLylvA4lwPiWkkU9AqkbcGeT+5I7NUFp1fgeWC0N67etnTckNrEuHno6jikE
	 Qb26LDdaq5/aptnBDXlOQR/RlMSKXpCEpmtmyRp/FpMzHdeC55WZnW/if/d7sEYmEm
	 KzcNBvGfXH62g==
From: sashiko-bot@kernel.org
Subject: Re: [Patch v4 2/5] perf/x86/intel: Always reprogram ACR events to
 prevent stale masks
Reply-To: sashiko@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260430002558.712334-3-dapeng1.mi@linux.intel.com>
References: <20260430002558.712334-3-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Apr 2026 02:04:00 +0000
Message-Id: <20260430020402.60C32C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Unconditional hardware MSR reprogramming for ACR events introduc=
es performance regression and increases measurement blind spots.
--

commit a8f30026401c4d7de00c3f1a7543204056d7235c
Author: Dapeng Mi <dapeng1.mi@linux.intel.com>
perf/x86/intel: Always reprogram ACR events to prevent stale masks

This commit modifies PMU event scheduling to force reprogramming of all ACR
events during rescheduling. It does this by making match_prev_assignment()
always return false for ACR events.

> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index 810ab21ffd99..4b9e105309c6 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -1294,13 +1294,16 @@ int x86_perf_rdpmc_index(struct perf_event *event)
>  	return event->hw.event_base_rdpmc;
>  }
> =20
> -static inline int match_prev_assignment(struct hw_perf_event *hwc,
> +static inline int match_prev_assignment(struct perf_event *event,
>  					struct cpu_hw_events *cpuc,
>  					int i)
>  {
> +	struct hw_perf_event *hwc =3D &event->hw;
> +
>  	return hwc->idx =3D=3D cpuc->assign[i] &&
> -		hwc->last_cpu =3D=3D smp_processor_id() &&
> -		hwc->last_tag =3D=3D cpuc->tags[i];
> +	       hwc->last_cpu =3D=3D smp_processor_id() &&
> +	       hwc->last_tag =3D=3D cpuc->tags[i] &&
> +	       !is_acr_event_group(event);
>  }

Does this unconditional hardware MSR reprogramming for ACR events introduce=
 a
performance regression and increase measurement blind spots?

By unconditionally returning false for all ACR events, every active ACR eve=
nt
will undergo a full x86_pmu_stop() and x86_pmu_start() cycle during PMU
re-enablement (e.g., in x86_pmu_enable() when cpuc->n_added > 0).

These full stop/start cycles invoke multiple wrmsr and rdpmc instructions,
adding significant cycle overhead to the hot scheduling path. Since this
occurs while the PMU is globally disabled, the added latency extends the
global PMU off-time, unnecessarily increasing the measurement blind spot
where events are not counted across the CPU.

Could this overhead be avoided by checking if the mask actually changed?

x86_pmu_late_setup() calculates the new physical mask and stores it in
event->hw.config1 before match_prev_assignment() is evaluated. Would it be
better to compare event->hw.config1 against the previously programmed mask
stored in cpuc->acr_cfg_b[hwc->idx] and only force a reprogram when they
differ?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260430002558.7123=
34-1-dapeng1.mi@linux.intel.com?part=3D2
