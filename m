Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793899382;
	b=BkuuIMaJZpvZHDDgNinioVh0NbIizw4riYCIbA0CXG+ShABK/Xf5UQFdiSfg9DT9lgtt
	 wDGRnMmuQ/ZmTbNivb4IZ0czukBPLvIhKCDq6b/fjFZwt8Wzz36kipy4ACvVBfTmbXe7m
	 VeSqaBYYM+ss2HHuYVIcqvbButIpSSMt4z2l9N8ACQVjT6o3+vkwLvi9TWONidPyZLYQH
	 KCEvDSWWNFP7JzHh8iRoewimr3R8GEA7ExVEdixtQannfWvQvUNZFhhV/KqqUkFgwqSvH
	 HQUzc/Tvr/vCSz7mY19iatquEpS2LyN/oNqRq5A/7e+jj+TYlABw5YB86nfRj+rdvVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793899382;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+6CpF1xlpLGHP2CK2fwg8qYxmT1n/cuHIZFkncNOG5c=;
	b=ZQEswaeAGM53A7KgsF1gBOFlDWOem1oh57ZL3cmRR7PZwI+1hif9VrkqQjeaEY1So3uk
	 2gXxxWDkMvBjf6s2NulI6Qq2UP7WBwTWjiyyJQwH3seqH8/bV3tlf74p9uoP5KxXFuPYI
	 VCfau2rUErDFYDyz3DgMBu0tjiT2i+F1EXegt3sUAvRcheJyWX/hhrxk5ZNp7732fdZiT
	 3p5tHrGHkneSsH2LC472Bhot++KA2HHfayoc+pH9dnOfRdo4/YCdG0HxBGFbwvEKWxr8F
	 W8NV7J5CnA+Nlwqql7UuTVbmko6iH+V8ohzsbkHxjvsSTqvJFfmw99OyJhxmreNxDDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="E/GltXnH";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31564606EE9D
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Nov 2026 17:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E/GltXnH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2BD01F00A16;
	Thu,  5 Nov 2026 17:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793899382;
	bh=+6CpF1xlpLGHP2CK2fwg8qYxmT1n/cuHIZFkncNOG5c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=E/GltXnHfjfwP3tMi6kn5C140Nph2+yQxfBGV4qxZvUaO1UGmVtT2WTICFC+VuCGf
	 RDqPj9RzJqjrwJFw2cTgvClfb4oJL7ZxMgFe5Vwgve3z/b9KGHLLp3wI2tJcOvIBVb
	 FnKS37OPQR048tGCj5kjSaOYvqHIgrtEmgRCZd/h0GK/ULuvVm54ActpBnM0dFbltd
	 lb+qGheCb04X2vXTwbUZBVTTiNFdvyCL9G/gEgkpvnSS8UCwOtH2Y6G/g6v1ketoDW
	 apDFIg7b3NZMQoShNe/r2b+fZnY7ZkPN+VxOnae9GrpqO8YBsg6CPSPzkVEH39ozyB
	 7Tnn4RZEK9alw==
Message-ID: <sashiko-outbox-199604@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC] perf/x86/amd/lbr: Don't freeze the LBR on PMI for
 user-only filters
Reply-To: sashiko-reviews@lists.linux.dev
To: "Puranjay Mohan" <puranjay@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261105170340.165507-1-puranjay@kernel.org>
References: <b7456dbb-16fd-45b4-8742-e9ea3f896317@amd.com>
 <20261105170340.165507-1-puranjay@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 17:23:01 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] perf/x86/amd/lbr: freeze format exposed and accepted without fea=
ture check
- [Medium] perf/x86/amd/lbr: wrong freeze state in amd_pmu_lbr_enable_all()=
 for multi-event LBR
--

commit 4ee339b2b2fdce2f2f85b09e93b75d05b24049b1
Author: Puranjay Mohan <puranjay@kernel.org>

perf/x86/amd/lbr: Don't freeze the LBR on PMI for user-only filters

This commit skips setting DEBUGCTLMSR_FREEZE_LBRS_ON_PMI on PMI when kernel
branches are suppressed in LBR_SELECT, while adding a freeze format attribu=
te
(config2:0) to allow user space to explicitly request freezing the LBR.

> diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
> index 49b6b8fce5664..d63649c756a58 100644
> --- a/arch/x86/events/amd/core.c
> +++ b/arch/x86/events/amd/core.c
> @@ -1404,8 +1404,22 @@ static struct attribute_group group_events_amd_brs=
 =3D {
> =20
>  #endif	/* CONFIG_PERF_EVENTS_AMD_BRS */
> =20
> +PMU_FORMAT_ATTR(freeze, "config2:0");
> +
> +static struct attribute *amd_pmu_lbr_format_attrs[] =3D {
> +	&format_attr_freeze.attr,
> +	NULL,
> +};
> +
> +static struct attribute_group group_format_amd_lbr =3D {
> +	.name       =3D "format",
> +	.attrs      =3D amd_pmu_lbr_format_attrs,
> +	.is_visible =3D amd_branches_is_visible,
> +};
> +
>  static const struct attribute_group *amd_attr_update[] =3D {
>  	&group_caps_amd_branches,
> +	&group_format_amd_lbr,
>  #ifdef CONFIG_PERF_EVENTS_AMD_BRS
>  	&group_events_amd_brs,
>  #endif
> diff --git a/arch/x86/events/amd/lbr.c b/arch/x86/events/amd/lbr.c
> index a55646fcb8465..f45e2c53566af 100644
> --- a/arch/x86/events/amd/lbr.c
> +++ b/arch/x86/events/amd/lbr.c
> @@ -10,6 +10,12 @@
>  /* LBR Branch Select valid bits */
>  #define LBR_SELECT_MASK		0x1ff
> =20
> +/* attr.config2: freeze the LBR on PMI */
> +#define LBR_CFG2_FREEZE		BIT_ULL(0)
> +
> +/* Software only, masked out before writing LBR_SELECT */
> +#define LBR_FREEZE		BIT_ULL(63)
> +
>  /*
>   * LBR Branch Select filter bits which when set, ensures that the
>   * corresponding type of branches are not recorded
> @@ -307,6 +313,9 @@ static int amd_pmu_lbr_setup_filter(struct perf_event=
 *event)
>  	/* Filter bits operate in suppress mode */
>  	reg->config =3D mask ^ LBR_SELECT_MASK;
> =20
> +	if (event->attr.config2 & LBR_CFG2_FREEZE)
> +		reg->config |=3D LBR_FREEZE;
> +
>  	return 0;
>  }

[Severity: Medium]
Should group_format_amd_lbr and amd_pmu_lbr_setup_filter() check for
X86_FEATURE_AMD_LBR_PMC_FREEZE?

In arch/x86/events/amd/core.c, group_format_amd_lbr uses
amd_branches_is_visible():

static umode_t
amd_branches_is_visible(struct kobject *kobj, struct attribute *attr, int i)
{
	return x86_pmu.lbr_nr ? attr->mode : 0;
}

Because x86_pmu.lbr_nr is non-zero both on Zen 3 BRS systems (where
amd_brs_detect() sets x86_pmu.lbr_nr =3D 16) and on LBRv2 systems or VMs th=
at do
not advertise X86_FEATURE_AMD_LBR_PMC_FREEZE, the sysfs format attribute
/sys/bus/event_source/devices/cpu/format/freeze is exposed on systems that
cannot freeze the LBR on PMI.

In addition, when a user opens an event with LBR_CFG2_FREEZE set in
event->attr.config2 on those systems, amd_pmu_lbr_setup_filter() accepts it
and sets LBR_FREEZE in reg->config, while amd_pmu_lbr_enable_all() silently
ignores it because the MSR_IA32_DEBUGCTLMSR update is guarded by
cpu_feature_enabled(X86_FEATURE_AMD_LBR_PMC_FREEZE).

Should the visibility callback and amd_pmu_lbr_setup_filter() verify
cpu_feature_enabled(X86_FEATURE_AMD_LBR_PMC_FREEZE) and return -EOPNOTSUPP =
if
freeze is requested when unsupported?

> @@ -392,20 +401,26 @@ void amd_pmu_lbr_sched_task(struct perf_event_pmu_c=
ontext *pmu_ctx,
>  void amd_pmu_lbr_enable_all(void)
>  {
>  	struct cpu_hw_events *cpuc =3D this_cpu_ptr(&cpu_hw_events);
> -	u64 lbr_select, dbg_ctl, dbg_extn_cfg;
> +	u64 lbr_cfg =3D 0, lbr_select =3D 0, dbg_ctl, dbg_extn_cfg;
> =20
>  	if (!cpuc->lbr_users || !x86_pmu.lbr_nr)
>  		return;
> =20
>  	/* Set hardware branch filter */
>  	if (cpuc->lbr_select) {
> -		lbr_select =3D cpuc->lbr_sel->config & LBR_SELECT_MASK;
> +		lbr_cfg =3D cpuc->lbr_sel->config;
> +		lbr_select =3D lbr_cfg & LBR_SELECT_MASK;
>  		wrmsrq(MSR_AMD64_LBR_SELECT, lbr_select);
>  	}
> =20
>  	if (cpu_feature_enabled(X86_FEATURE_AMD_LBR_PMC_FREEZE)) {
>  		rdmsrq(MSR_IA32_DEBUGCTLMSR, dbg_ctl);
> -		wrmsrq(MSR_IA32_DEBUGCTLMSR, dbg_ctl | DEBUGCTLMSR_FREEZE_LBRS_ON_PMI);
> +		/* Skip the freeze if kernel branches are suppressed, unless asked */
> +		if ((lbr_select & LBR_KERNEL) && !(lbr_cfg & LBR_FREEZE))
> +			dbg_ctl &=3D ~DEBUGCTLMSR_FREEZE_LBRS_ON_PMI;
> +		else
> +			dbg_ctl |=3D DEBUGCTLMSR_FREEZE_LBRS_ON_PMI;
> +		wrmsrq(MSR_IA32_DEBUGCTLMSR, dbg_ctl);
>  	}

[Severity: Medium]
Can this re-enable DEBUGCTLMSR_FREEZE_LBRS_ON_PMI for an active user-only L=
BR
event when multiple branch-stack events are scheduled on the same CPU?

In arch/x86/events/amd/lbr.c, amd_pmu_lbr_add() sets cpuc->lbr_select =3D 1=
 and
increments cpuc->lbr_users, but amd_pmu_lbr_del() unconditionally clears
cpuc->lbr_select to 0 whenever any branch-stack event is removed:

void amd_pmu_lbr_del(struct perf_event *event)
{
	struct cpu_hw_events *cpuc =3D this_cpu_ptr(&cpu_hw_events);

	if (!x86_pmu.lbr_nr)
		return;

	if (has_branch_stack(event))
		cpuc->lbr_select =3D 0;

	cpuc->lbr_users--;
...
}

If two user-only branch-stack events are active on a CPU (cpuc->lbr_users =
=3D=3D 2)
and one of them is removed via amd_pmu_lbr_del(), cpuc->lbr_users remains 1
 while cpuc->lbr_select becomes 0.

When amd_pmu_v2_enable_all() then calls amd_pmu_lbr_enable_all(), the
if (cpuc->lbr_select) block is skipped, leaving lbr_cfg and lbr_select as 0.
As a result, (lbr_select & LBR_KERNEL) evaluates to false and
amd_pmu_lbr_enable_all() sets DEBUGCTLMSR_FREEZE_LBRS_ON_PMI in
MSR_IA32_DEBUGCTLMSR even though the remaining active event suppresses kern=
el
branches and did not request a freeze.

Additionally, if a user-only event with freeze=3D0 is added alongside an ev=
ent
that requires freezing (either recording kernel branches or with freeze=3D1=
),
amd_pmu_lbr_add() overwrites cpuc->lbr_sel->config with the new event's con=
fig,
causing amd_pmu_lbr_enable_all() to clear DEBUGCTLMSR_FREEZE_LBRS_ON_PMI for
both events.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105170340.1655=
07-1-puranjay@kernel.org?part=3D1
