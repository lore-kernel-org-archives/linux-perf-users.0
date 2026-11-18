Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794974736;
	b=2GYV0gS6uGyANpmsHPGa1rSicbvtEWBZitss+4Hj+m5D4OZNiqwFu2W6VQH4sfMzgsNG
	 SHiwA/u+EyhgbDJPGxFqz1vkOUlsIU++xS08Wnzr1HQOZ/jK4CuebykUDjsE4HayAjYYV
	 Kgc3ZX5eR0/zud1iPaVF+57GynGsa/c/YqoouKl8aCO8DFiAxf+wGCEPlm8oWR+/3NbwH
	 Ae4X67MoKyB5xILKwg/q069riPY7oANoNF6HegX04NxI2+4b6v7VmHEBiC7/TcWiVaQGb
	 Phcxaw36hEjRryPKH+wIAkIS70i5vxR33XnOMNn1ro7KzOaxCE7+HyN847AOhIKpkQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794974736;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=DVRtJABYvpyRtlRBJjH4aHa7BbfBalY3ZivQ3PNvknE=;
	b=S5ODH77t4kW6Nu8mU5Fp7zbeZ5WiWDxtdi70xxiamlA9cUoKI8x8YpRxkh7KqPAcfMvx
	 c0OwquHxfDtKo5rkzgiXx7/07BSyXbnQZKAvKp0NUZtby8EN9ucg0DpwGQw008MwbTagN
	 pRhXYNiTq7bw6BMNJynSUKGy2fiikudO4pr9nkagYoREJnSslhe0xym/jbmnfd2ynkp7L
	 UmW+SA7h3QH+IVwJiB/L2Jqirm03hRQaZQQyO8qMQ/ftYg2jsMd3mNsw/21Ja57oPxNrR
	 9nW+gkcD7kPjyGHlpHftbT85YiUn/1OM1X1pTG8Y+zQOJpacrtb9mHtdK+eq2tF/x8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NJenF8xl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A086606A31C;
	Wed, 18 Nov 2026 04:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NJenF8xl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DD211F000C4;
	Wed, 18 Nov 2026 04:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794974735;
	bh=DVRtJABYvpyRtlRBJjH4aHa7BbfBalY3ZivQ3PNvknE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NJenF8xlgOZL5EIeXwVyWi6N0pyA0Jua7tn75VwChVMgUbL3NdQNqNrStNqi24Wkh
	 2HbrucKJKSDUynX3V6aYP9+Vgp5JC7D/W6HCqGsokR+xI05owMBU0c/zR5OzUV53Jo
	 OBfQAvLffTqKgvU7zrtN0o1XfJao97+WOExHTOqJtEmbGlISeX+SE5GGb27ti2Y55K
	 ZZrJpjfRC6d7aPVgIyuXbKeDISQAO8wBEAD7Vsb3scLZ4kV5GTqPOyDNsWbDdSS35E
	 3sNBxjNzElVl1EdJZJy7ngCU1Exca2/LEyW4S3oWM0Bncwh3FTMe72eBixIEXL7YVs
	 I2bh3AzyNPDww==
Message-ID: <sashiko-outbox-220065@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [Patch v7 15/24] perf/x86/intel: Set PERF_EV_CAP_SIBLING for
 pure branch counter events
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20261118031453.1353625-16-dapeng1.mi@linux.intel.com>
References: <20261118031453.1353625-1-dapeng1.mi@linux.intel.com>
 <20261118031453.1353625-16-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 04:05:34 +0000
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
- [Medium] perf/x86/intel: incomplete group detach handling in
  intel_pmu_hw_config()
--

commit 2f6a2a62d0ff0bf2794f702072c776c06e629ff3
Author: Dapeng Mi <dapeng1.mi@linux.intel.com>

perf/x86/intel: Set PERF_EV_CAP_SIBLING for pure branch counter events

This commit sets PERF_EV_CAP_SIBLING on pure branch counter events in
intel_pmu_hw_config() so that the perf core schedules them out if the
group leader is detached.

> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index 84b134bb91eea..fd4de141ef281 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -5130,10 +5130,17 @@ static int intel_pmu_hw_config(struct perf_event =
*event)
>  		 * require any branch stack setup.
>  		 * Clear the bit to avoid unnecessary branch stack setup.
>  		 */
> -		if (0 =3D=3D (event->attr.branch_sample_type &
> -			  ~(PERF_SAMPLE_BRANCH_PLM_ALL |
> -			    PERF_SAMPLE_BRANCH_COUNTERS)))
> -			event->hw.flags  &=3D ~PERF_X86_EVENT_NEEDS_BRANCH_STACK;
> +		if (!(event->attr.branch_sample_type &
> +		      ~(PERF_SAMPLE_BRANCH_PLM_ALL | PERF_SAMPLE_BRANCH_COUNTERS))) {
> +			event->hw.flags &=3D ~PERF_X86_EVENT_NEEDS_BRANCH_STACK;
> +			/*
> +			 * A pure branch counter event doesn't set up the LBR
> +			 * itself. It must stay grouped with a normal branch
> +			 * event which configures the LBR for it. Otherwise,
> +			 * the LBR cannot be configured correctly.
> +			 */
> +			event->event_caps |=3D PERF_EV_CAP_SIBLING;
> +		}
> =20
>  		/*
>  		 * Force the leader to be a LBR event. So LBRs can be reset

[Severity: Medium]
What happens on group detach when a branch counter sibling has other
branch_sample_type filter bits set alongside PERF_SAMPLE_BRANCH_COUNTERS?

First, a counting sibling in PERF_SAMPLE_READ mode with a branch filter
(such as PERF_SAMPLE_BRANCH_ANY | PERF_SAMPLE_BRANCH_COUNTERS, which
"perf record -e '{e1,e2}:S' -j any,counter" configures) skips setting
PERF_X86_EVENT_NEEDS_BRANCH_STACK earlier in intel_pmu_hw_config():

arch/x86/events/intel/core.c:intel_pmu_hw_config() {
	if (needs_branch_stack(event)) {
		/* Avoid branch stack setup for counting events in SAMPLE READ */
		if (is_sampling_event(event) ||
		    !(event->attr.sample_type & PERF_SAMPLE_READ))
			event->hw.flags |=3D PERF_X86_EVENT_NEEDS_BRANCH_STACK;
	}
}

Because branch_sample_type contains PERF_SAMPLE_BRANCH_ANY, the condition
here is false and PERF_EV_CAP_SIBLING is not set either.  If the group
leader is closed, perf_group_detach() promotes this sibling to a
standalone leader that stays scheduled with ARCH_PERFMON_EVENTSEL_BR_CNTR
enabled in hardware without LBR configured.

Second, for a sampling sibling that retains
PERF_X86_EVENT_NEEDS_BRANCH_STACK and has PERF_SAMPLE_BRANCH_COUNTERS set,
intel_pmu_hw_config() only sets PERF_X86_EVENT_BRANCH_COUNTERS on
leader->hw.flags and not on event->hw.flags.  When the original leader is
closed and perf_promote_sibling_to_leader() sets sibling->group_leader =3D
sibling, is_branch_counters_group(sibling) becomes false, so
intel_pmu_lbr_save_brstack() skips intel_pmu_lbr_counters_reorder() and
intel_pmu_lbr_del() skips intel_pmu_lbr_reset().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118031453.1353=
625-1-dapeng1.mi@linux.intel.com?part=3D15
