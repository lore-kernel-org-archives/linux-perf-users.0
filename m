Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B551A3B47C9
	for <linux-perf-users@vger.kernel.org>; Mon, 27 Apr 2026 10:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777284817; cv=none; b=O5/BCCa/2RjggIAnbBjXxmVgBbSApWmxxFut222w23bTzo3ehFhtuDmSQPW5+u3G6bogIHm1TDXvqGKekkc3MT2gBgJMjhb46rO1OeBUVsBP13atCd/q/8EhQjEoZE92mpSLMBNIAWQpJ4Gz6zsj6+5mQdMGkVHyAK+7KKyB8rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777284817; c=relaxed/simple;
	bh=IfMyHYbOHRZeYkGpwc+sJzsn21cG7krj2Kg6WnKLl0A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tR8PCGrulzxgIETXxacoY6geKCX2cx7Y/vFQcZ0o8pr1kzGds2SL20Fp5btNs0XiaFqRy8kYqxJQ4jY8JYtS+LMCkAYW71knqsaGxqETidfBkNo3IL7FhIutfM1Eo9QZ0645kvU08pv3XQJpP8pUBkGWso7BFdhH7g+YKnOel3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LhekPnRf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LhekPnRf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FB32C19425;
	Mon, 27 Apr 2026 10:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777284817;
	bh=IfMyHYbOHRZeYkGpwc+sJzsn21cG7krj2Kg6WnKLl0A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=LhekPnRfgbxZG7MnLuJiYw0fJF/FoW9aI05+CnCzNX7OXhGrxkuTi4VUUEezncojQ
	 3tMo25u2VpMqWQh8ktNhyMAyjSNTY93XD97JrzufnxrFf5g3FVvpII+qSrAKOhiT7y
	 WrUeYGXeWID62AkHjW3SIPSbg7aQgYZZ5dyrsKJ/wJ0Kmv1qb7CoZXDv3YpzneB47K
	 +tVBs9tGk5JYZ/4pLXZVlBlf1t909Z8JvfNAMbHgc2XB79i4gdCA68TbnZ/ies5WNL
	 UyUsfgMV6g4z7m089bbkzT7RfgkP5iXk/NcaEvh6GSAG1/OwhoR2L7j6l9AKL9UK/Z
	 +8dX5Vn/S9QZg==
From: sashiko-bot@kernel.org
Subject: Re: [Patch v3 1/4] perf/x86/intel: Improve validation and
 configuration of ACR masks
Reply-To: sashiko@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260427085513.3728672-2-dapeng1.mi@linux.intel.com>
References: <20260427085513.3728672-2-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Apr 2026 10:13:36 +0000
Message-Id: <20260427101337.5FB32C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 3 potential issue(s):
- [High] The ACR feature incorrectly maps logical sibling indices from user=
 space to physical array indices in `event_list`, which silently corrupts t=
he configuration if any sibling is disabled.
- [High] The updated ACR hardware configuration (`hw.config1`) is not synch=
ronized to the PMU hardware register if the event itself does not change co=
unters, leaving the hardware state stale.
- [Low] The patch uses a complex and brittle hardware counter bitmask to ve=
rify group membership instead of simply checking array bounds.
--

commit 0bc290b3247e55dbfb3b7cee24f6926da6f5adfb
Author: Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: perf/x86/intel: Improve validation and configuration of ACR masks

This commit addresses several issues with user space ACR mask validation and
configuration. It calculates an index bitmap for each ACR group to drop inv=
alid
user-space mask bits, avoids early returns on invalid bits, and explicitly
clears stale hardware ACR masks.

> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index d9488ade0f8e..dafa233dd757 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
[ ... ]
> @@ -3332,23 +3332,41 @@ static void intel_pmu_enable_event(struct perf_ev=
ent *event)
>  static void intel_pmu_acr_late_setup(struct cpu_hw_events *cpuc)
>  {
>  	struct perf_event *event, *leader;
> -	int i, j, idx;
> +	int i, j, k, bit, idx;
> +	u64 group_mask;
> =20
>  	for (i =3D 0; i < cpuc->n_events; i++) {
>  		leader =3D cpuc->event_list[i];
>  		if (!is_acr_event_group(leader))
>  			continue;
> =20
> -		/* The ACR events must be contiguous. */
> +		/* Find the last event of the ACR group. */
>  		for (j =3D i; j < cpuc->n_events; j++) {
>  			event =3D cpuc->event_list[j];
>  			if (event->group_leader !=3D leader->group_leader)
>  				break;
> -			for_each_set_bit(idx, (unsigned long *)&event->attr.config2, X86_PMC_=
IDX_MAX) {
> -				if (i + idx >=3D cpuc->n_events ||
> -				    !is_acr_event_group(cpuc->event_list[i + idx]))
> -					return;
> -				__set_bit(cpuc->assign[i + idx], (unsigned long *)&event->hw.config1=
);
> +		}
> +
> +		/* Figure out the group indices bitmap. */
> +		group_mask =3D 0;
> +		for (k =3D i; k < j; k++)
> +			group_mask |=3D BIT_ULL(cpuc->assign[k]);

Since x86_schedule_events() guarantees strictly unique hardware counters for
all concurrently active core PMU events, a counter is present in group_mask=
 if
and only if its index falls within [i, j).

Given that idx =3D i + bit guarantees idx >=3D i, is it possible to simplif=
y this
by just checking if idx >=3D j instead of constructing and checking the
group_mask?

> +
> +		/*
> +		 * Translate the user-space ACR mask (attr.config2) into the physical
> +		 * counter bitmask (hw.config1) for each ACR event in the group.
> +		 * NOTE: ACR event contiguity is guaranteed by intel_pmu_hw_config().
> +		 */
> +		for (k =3D i; k < j; k++) {
> +			event =3D cpuc->event_list[k];
> +			event->hw.config1 =3D 0;

If Event A moves to a new counter but Event B itself does not move,
match_prev_assignment() would evaluate to true for Event B, and
x86_pmu_start() would be skipped.

Does this mean the updated hw.config1 for Event B is never written to the
physical hardware MSR, breaking the Auto Counter Reload functionality?

> +			for_each_set_bit(bit, (unsigned long *)&event->attr.config2, X86_PMC_=
IDX_MAX) {
> +				idx =3D i + bit;

User space provides the ACR mask (attr.config2) using absolute logical bit
indices (e.g., bit 0 =3D leader, bit 1 =3D first sibling). However,
collect_events() skips events that are in PERF_EVENT_STATE_OFF.

If an earlier sibling is disabled, it is not added to event_list, causing a=
ll
subsequent active siblings to shift down in the array.

Does idx point to the wrong event in the active array if any sibling is
disabled? Should the mask resolve against the logical sibling_list rather
than the compressed active array?

> +				if (idx >=3D cpuc->n_events ||
> +				    !(BIT_ULL(cpuc->assign[idx]) & group_mask) ||
> +				    !is_acr_event_group(cpuc->event_list[idx]))
> +					continue;
> +				__set_bit(cpuc->assign[idx], (unsigned long *)&event->hw.config1);
>  			}
>  		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260427085513.3728=
672-1-dapeng1.mi@linux.intel.com?part=3D1
