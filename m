Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7506B3D3CF8
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Apr 2026 13:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776692213; cv=none; b=EYtjeo9c7q9mDZ51CDvLZRz379syvw7T3/faAuU/UENkeRf4GI2kacE4lBfgEF7w4rZKiq3PvHw8IqrzEtyqq0VqLi7mXX/lp7gejYScAQuNQlaRaHrGjWN64Y3YMtki8RSQaWHU0Cqo1/U5Akrw/2287LdpwMvH2Y3YENCpUwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776692213; c=relaxed/simple;
	bh=hr4nIKsCrYsnTSZjlYHxBkKHAl6M27PQwXO2iXmxZgs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TIsvXX7GHDbkZwA6oVKmmtQo4Kf+p35Je8+VvMKlyF3F3vKhi1rPoB2zHwnazXC6U886BN1E/2aRbefa3+64Tc9AVxhAYSc4bi4WxPBmM6AnBjnpvZd4YQGyD2L4IsiZziVft1b14LymxD/sLH7uBBadPlCc1qnsmDi49l3MFrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NIZViw1V; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NIZViw1V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06A21C19425;
	Mon, 20 Apr 2026 13:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776692213;
	bh=hr4nIKsCrYsnTSZjlYHxBkKHAl6M27PQwXO2iXmxZgs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=NIZViw1VsGeuod44vgzbVN9Fu5kg2ecG1H9QdfDS8ByOn1laas7me9ZYr6oRIchaH
	 WAt/+w/vwy6Ffx8yc4SE2qKDoKsh56zedH6qZZTEsLn3I0RMQWOvlVe1xYNbHEjWzb
	 Z21BNtZFY5nztarBBQpM21X4dY4iE5dF66YSPfvpWej3Dq460okPyDLHKfiTmn85J+
	 EjC8CTZetEByj5jpByItg1btQp8JnHdOOXCFwe5/olKxolUAdsM6FDIx/vC5GQ7gUO
	 zjHC7fEl005VMGcteEs1VyINPikdbQWs4uUodFL/OkdW5txYt918adbezseXiTpd4m
	 U6QoZCDjWZjIg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 5/6] x86/events: Switch core parts to use new MSR
 access functions
Reply-To: sashiko@lists.linux.dev
To: "Juergen Gross" <jgross@suse.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260420091634.128787-6-jgross@suse.com>
References: <20260420091634.128787-6-jgross@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Apr 2026 13:36:52 +0000
Message-Id: <20260420133653.06A21C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [High] Inconsistent application of `msr_write_noser()` and `msr_write_ser=
()` APIs, violating the commit's design rules and risking hardware-level ra=
ce conditions.
--

commit 3fc3352a68324488e42156725645cf2d490b75c7
Author: Juergen Gross <jgross@suse.com>

x86/events: Switch core parts to use new MSR access functions

This commit switches the core x86 events subsystem to use the new msr_*()=20
access functions. The commit message establishes a rule to use=20
msr_write_noser() when another MSR write follows in the same function, and=
=20
msr_write_ser() for the final MSR write.

> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index 810ab21ffd991..c15e0d1a66584 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
[ ... ]
> @@ -713,13 +713,13 @@ void x86_pmu_disable_all(void)
> =20
>  		if (!test_bit(idx, cpuc->active_mask))
>  			continue;
> -		rdmsrq(x86_pmu_config_addr(idx), val);
> +		val =3D msr_read(x86_pmu_config_addr(idx));
>  		if (!(val & ARCH_PERFMON_EVENTSEL_ENABLE))
>  			continue;
>  		val &=3D ~ARCH_PERFMON_EVENTSEL_ENABLE;
> -		wrmsrq(x86_pmu_config_addr(idx), val);
> +		msr_write_noser(x86_pmu_config_addr(idx), val);
>  		if (is_counter_pair(hwc))
> -			wrmsrq(x86_pmu_config_addr(idx + 1), 0);
> +			msr_write_noser(x86_pmu_config_addr(idx + 1), 0);
>  	}
>  }

The commit message mentions using msr_write_ser() for the last MSR write in=
 a
function. Since msr_write_noser() relies on a non-serializing instruction,
could leaving the final write non-serialized here allow the CPU to proceed=
=20
into critical sections before the hardware PMU disable actually completes?=
=20

If the hardware is still actively counting, this might risk triggering=20
unexpected PMIs.

[ ... ]
> @@ -1446,14 +1446,14 @@ int x86_perf_event_set_period(struct perf_event *=
event)
>  	 */
>  	local64_set(&hwc->prev_count, (u64)-left);
> =20
> -	wrmsrq(hwc->event_base, (u64)(-left) & x86_pmu.cntval_mask);
> +	msr_write_noser(hwc->event_base, (u64)(-left) & x86_pmu.cntval_mask);
> =20
>  	/*
>  	 * Sign extend the Merge event counter's upper 16 bits since
>  	 * we currently declare a 48-bit counter width
>  	 */
>  	if (is_counter_pair(hwc))
> -		wrmsrq(x86_pmu_event_addr(idx + 1), 0xffff);
> +		msr_write_noser(x86_pmu_event_addr(idx + 1), 0xffff);
> =20
>  	perf_event_update_userpage(event);
> =20
>  	return ret;
>  }

Similar to the above, this function finishes without a serializing MSR write
or a barrier. Should this final write use msr_write_ser() to match the desi=
gn
rules outlined in the commit description?

[ ... ]
> @@ -2560,9 +2560,9 @@ void perf_clear_dirty_counters(void)
>  			if (!test_bit(i - INTEL_PMC_IDX_FIXED, hybrid(cpuc->pmu, fixed_cntr_m=
ask)))
>  				continue;
> =20
> -			wrmsrq(x86_pmu_fixed_ctr_addr(i - INTEL_PMC_IDX_FIXED), 0);
> +			msr_write_noser(x86_pmu_fixed_ctr_addr(i - INTEL_PMC_IDX_FIXED), 0);
>  		} else {
> -			wrmsrq(x86_pmu_event_addr(i), 0);
> +			msr_write_noser(x86_pmu_event_addr(i), 0);
>  		}
>  	}
> =20

The final MSR write in this loop also exclusively uses msr_write_noser().
Is it intended to leave the PMU clearing un-serialized upon returning from=
=20
this function?

> diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
> index fad87d3c8b2ca..cce2e7b67c01f 100644
> --- a/arch/x86/events/perf_event.h
> +++ b/arch/x86/events/perf_event.h
[ ... ]
> @@ -1296,10 +1296,10 @@ static inline void x86_pmu_disable_event(struct p=
erf_event *event)
>  	u64 disable_mask =3D __this_cpu_read(cpu_hw_events.perf_ctr_virt_mask);
>  	struct hw_perf_event *hwc =3D &event->hw;
> =20
> -	wrmsrq(hwc->config_base, hwc->config & ~disable_mask);
> +	msr_write_ser(hwc->config_base, hwc->config & ~disable_mask);
> =20
>  	if (is_counter_pair(hwc))
> -		wrmsrq(x86_pmu_config_addr(hwc->idx + 1), 0);
> +		msr_write_ser(x86_pmu_config_addr(hwc->idx + 1), 0);
>  }

Here the first write uses msr_write_ser() even when a second write might fo=
llow=20
(when is_counter_pair(hwc) is true).=20

Should the first write use msr_write_noser() instead to take advantage of t=
he=20
optimization mentioned in the commit message?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260420091634.1287=
87-1-jgross@suse.com?part=3D5
