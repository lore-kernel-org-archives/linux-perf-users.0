Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793701918;
	b=Yy7Pivv0yM3vFT6YBaLvQCAhlwshC78QYYMMWBpPJg1FCPVLNNgXF2/rN0xg8JKFAFNi
	 FuIBYb0jUdmuy+EGBsqrZZy7ebnfXdSemwgN98Q0gpRmQFmD00N0inVE918tYi2fHgSfw
	 004Hssn6VOm9TkCBkJ6xPUVWxQ2Q9iWM1cJqZqauOLdOke1PZSLo6NSFRoyV7calSnDeN
	 NB/VDT1oJ5g5zapGutGLA/MY2E3u3O2zsrqLQ0hA5LsI6VQCloxSb1bQpoyO80toppwLp
	 hoVUigTtbnW4mGwzoEBgHfU6oVvbocV9hV7Xw7DLzaRfbV4IfRV4/i6JS62/LasJtyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793701918;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+YUUo+ozWrhoL04CCUSKDN6tzUMAOiODdsNzEJG8KPY=;
	b=RKu7hKTSshtb9a9q3M3SgoYHw3CC2h9Hkr3YFZKQvffIvH7eQQWJJqDCxOJvsjdDAYas
	 SrOZKi12JGKJbvOs6Xopngv5wd4FgMR/GPF8f7CMWnuZOKfEQHfRjBW5i2QPhGMB3fogB
	 F0hUhjibtMZLADkrgVvK5sNryFZdBrdIGZZeU5gOiK1QgKrri485fCldv2zjV9OVx8QV9
	 y0Stk5hz6TsQY89eACCajTavuxF/irEJsE3C6AqVOUGmWafirBAAUtp1a7xVWTe1gUMQ3
	 Ld6wdERfOXh0u0cY5XS948iGa58PdzEDsOWutycSx6GrYzaqfmvUKX6zWtw+SsDRPLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jDnv98DE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11B7606B13A;
	Tue,  3 Nov 2026 10:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jDnv98DE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ADF51F000C1;
	Tue,  3 Nov 2026 10:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793701917;
	bh=+YUUo+ozWrhoL04CCUSKDN6tzUMAOiODdsNzEJG8KPY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jDnv98DEg9N5BzAPFCobcUYchY2ifS/BVq5Hme2oDmg+K0UUpZ+KBzasvET/IxFwL
	 oV6EeUaeOi4ZIznBk9KtVGPkfSMdhDzr1SBf7TwTgbzeav1F8FLI+Yi+6v4dVNxjI6
	 xnwvdTRIrnhJPgxsk/8eV+nuSaF5gvG12yFX7MoK2JhYLUfuunOfg68KsoevgTvP7x
	 kzw8RDFdV/+T0dJyv4pXhcIS2OUzVTNF9y4Yh5gyJT7V0+AvtND2go0bcDCc+F2ooC
	 xEVUJb/ofaaa6Dlv7fCv3iO9h83Wws3sMzUa4rYAlNE16RvDmGSCJImD+/pIVt6W6e
	 osVpLkn1mb0bw==
Message-ID: <sashiko-outbox-195055@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 05/13] drivers/perf: apple_m1: Use macros for
 per-implementation init functions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Myria Sarvay" <myrialsarvay@gmail.com>
Cc: linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261103-m3-plus-pmu-events-v1-5-a8eb6c1139fe@gmail.com>
References: <20261103-m3-plus-pmu-events-v1-0-a8eb6c1139fe@gmail.com>
 <20261103-m3-plus-pmu-events-v1-5-a8eb6c1139fe@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 10:31:56 +0000
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
- [Low] drivers/perf: apple_m1: unused macro m2_pmu_init_pmceid aliases rem=
oved symbol
- [Low] perf: apple_m1: redundant macro aliasing and duplication in APPLE_P=
MU_INIT()
--

commit b798f559facbfb19db0eef028f7f7e42ebc0042c
Author: Myria Sarvay <myrialsarvay@gmail.com>

drivers/perf: apple_m1: Use macros for per-implementation init functions

This commit replaces the per-core-family PMU initialization functions in
drivers/perf/apple_m1_cpu_pmu.c with an APPLE_PMU_INIT() macro and adds
compatibility macro aliases for M2 callbacks and attribute groups.

> diff --git a/drivers/perf/apple_m1_cpu_pmu.c b/drivers/perf/apple_m1_cpu_=
pmu.c
> index a14864263bf1f..e7e9b51ffadcc 100644
> --- a/drivers/perf/apple_m1_cpu_pmu.c
> +++ b/drivers/perf/apple_m1_cpu_pmu.c
> @@ -653,71 +653,40 @@ static int apple_pmu_init(struct arm_pmu *cpu_pmu)
>  }
> =20
>  /* Device driver gunk */
> -static int m1_pmu_ice_init(struct arm_pmu *cpu_pmu)
> -{
> -	cpu_pmu->name =3D "apple_icestorm_pmu";
> -	cpu_pmu->enable		  =3D m1_pmu_enable_event;
> -	cpu_pmu->get_event_idx	  =3D m1_pmu_get_event_idx;
> -	cpu_pmu->map_event	  =3D m1_pmu_map_event;
> -	cpu_pmu->set_event_filter =3D m1_pmu_set_event_filter;
> -
> -	cpu_pmu->map_pmuv3_event  =3D m1_pmu_map_pmuv3_event;
> -
> -	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_EVENTS] =3D &m1_pmu_events_attr_=
group;
> -	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_FORMATS] =3D &m1_pmu_format_attr=
_group;
> -	return apple_pmu_init(cpu_pmu);
> -}

[ ... ]

> +#define APPLE_PMU_INIT(gen, family)								\
> +static int gen ## _pmu_ ## family ## _init(struct arm_pmu *cpu_pmu)				\
> +{												\
> +	cpu_pmu->name			=3D "apple_" #family "_pmu";				\
> +	cpu_pmu->enable			=3D gen ## _pmu_enable_event;				\
> +	cpu_pmu->get_event_idx		=3D gen ## _pmu_get_event_idx;				\
> +	cpu_pmu->map_event		=3D gen ## _pmu_map_event;				\
> +	cpu_pmu->set_event_filter	=3D gen ## _pmu_set_event_filter;				\
> +												\
> +	cpu_pmu->map_pmuv3_event	=3D gen ## _pmu_map_pmuv3_event;				\
> +												\
> +	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_EVENTS] =3D &gen ## _pmu_events_=
attr_group;	\
> +	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_FORMATS] =3D &gen ## _pmu_format=
_attr_group;	\
> +	return apple_pmu_init(cpu_pmu);								\
> +}

[Severity: Low]
This isn't a bug, but APPLE_PMU_INIT(gen, family) expands all seven callback
and attr_groups assignments into every per-family init function (such as
m1_pmu_icestorm_init() and m1_pmu_firestorm_init()), even though core
families within the same generation only differ in cpu_pmu->name.

Because APPLE_PMU_INIT() unconditionally token-pastes gen ## _pmu_* for
every field, any generation that shares callbacks or attribute groups with
an earlier generation also requires a block of #define aliases to satisfy
token pasting (including in subsequent patches for m4 and a18).

Would it be cleaner to follow the pattern in drivers/perf/arm_pmuv3.c
(PMUV3_INIT_SIMPLE calling armv8_pmu_init), or have per-generation init
helpers called by a small per-family wrapper that only sets cpu_pmu->name,
to avoid both the #define alias blocks and the repeated per-family
assignments?

> +
> +#define m2_pmu_enable_event		m1_pmu_enable_event
> +#define m2_pmu_get_event_idx		m1_pmu_get_event_idx
> +#define m2_pmu_set_event_filter		m1_pmu_set_event_filter
> +#define m2_pmu_map_pmuv3_event		m1_pmu_map_pmuv3_event
> +#define m2_pmu_init_pmceid		m1_pmu_init_pmceid

[Severity: Low]
Is m2_pmu_init_pmceid needed here?

Earlier in the series ("drivers/perf: apple_m1: Support per-implementation
event tables"), m1_pmu_init_pmceid() was replaced by apple_pmu_init_pmceid(=
),
which is called directly from apple_pmu_init():

static int apple_pmu_init(struct arm_pmu *cpu_pmu)
{
	...
	apple_pmu_init_pmceid(cpu_pmu);

	bitmap_set(cpu_pmu->cntr_mask, 0, M1_PMU_NR_COUNTERS);
	return 0;
}

APPLE_PMU_INIT() does not reference gen ## _pmu_init_pmceid, so
m2_pmu_init_pmceid (and a18_pmu_init_pmceid in "drivers/perf: apple_m1: Add
Apple A18 Support") is unused and aliases a non-existent symbol. Can this
macro definition be dropped?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-m3-plus-pm=
u-events-v1-0-a8eb6c1139fe@gmail.com?part=3D5
