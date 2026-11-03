Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793702854;
	b=wDF5gAIPiNwp8zFI7y7eBRgatgXl2aV/n0RX2z615OMkd9xhS8tAoq/W534AmmxOg4tK
	 r2LL34Vf/aII+CZrDjKuUX5QswvHPVm6uF4xw95CVIC5QcG968vDU8VRDy5ZPtJAKpO5f
	 uftFfsZcSSCsvHB7Tf1YEP0C3v89BcAMELtG98RlJWOoTNejta8EN4FG2EooKSl1am7U3
	 sJ7ujsjlaG5dMvqAQ3QY5ym1e/WnKPpaxgi9zsBoC4cyIMAt34KqRFPzai1MNAT3qvFTA
	 jPuvAP4iXHnNxS21es0H/DLiHSqCkF+ZZR2OBT5qGkv1EEdpPbzJlN3p5aRDFQx+CmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793702854;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=4VC0HLb8QlP7ub+0ZPtP1lO5JVqmLp7CerydBenrsdM=;
	b=5hvP53YQUTL7nmimJeYLJrIZwqWTlRnv2HbFzMHTcu/lHITxh+vhR3kl/9PYvOwERgmX
	 jCCrP7y0R+o6lqv/TXr60oX8ADqZPdd+gC6BWMudQ6hciZ8q7a1aceraGKoNInKt61rPZ
	 ejVq3s66+BuMPi3mVnvmgqTnHuvV9PNkpPNVi6ohMl6iK10LOOBnDpVFLiYhYW0LludfH
	 T2Lw4L8eU4fDaoyCuBLuaWwJ7c3sofk/ZxmymtLPDYlUm+pzpnLLwbOMfcMiw9RLrWla0
	 T8+xmczgzOthFwHA80NMoe2ftsdMjAL3xCgEA5PIUngDceOLIMAtkc9s4Y283qC0adQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WbNz5NF5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0EEF606F7F5;
	Tue,  3 Nov 2026 10:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WbNz5NF5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A7061F0093A;
	Tue,  3 Nov 2026 10:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793702854;
	bh=4VC0HLb8QlP7ub+0ZPtP1lO5JVqmLp7CerydBenrsdM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WbNz5NF5Gm9QiUKPSycHuzqEIpWlXaZsadYqgxCPdhtgNy/VxdX5vIJIEpRKOw93u
	 v7E1ItyxLgdevhxOJXjQvktTODYj9fFQhcbPBmGlQSYd0Vh2gb1wUQdSfEMRK7F2Eu
	 fUYOoU9fn2k+PhgTx+e3TNKZr0lFWA7TV/ISYwlZhaljIivgqRRVJR1qbxiZ7i0SYo
	 5+yOmHRjx66NwMuxyUU93s2lP9Q7KP27A7Pca7cju9tCL8wWkeTxs3C1CW3HYsQKUj
	 OC+DlvGxhmSz/AK1EUvDFA8nR9EIW6HvH+7c2vgyPiKJBOdNK76MqP2MExfLYCff5J
	 7gyENBT5oVgnA==
Message-ID: <sashiko-outbox-195068@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 08/13] drivers/perf: apple_m1: Add Apple A18 Support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Myria Sarvay" <myrialsarvay@gmail.com>
Cc: linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261103-m3-plus-pmu-events-v1-8-a8eb6c1139fe@gmail.com>
References: <20261103-m3-plus-pmu-events-v1-0-a8eb6c1139fe@gmail.com>
 <20261103-m3-plus-pmu-events-v1-8-a8eb6c1139fe@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 10:47:33 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] drivers/perf: apple_m1: redundant a18_pmu_* aliases and unused macro
--

commit 96c1a110d959d59196297459a3c8bd2316dfaece
Author: Myria Sarvay <myrialsarvay@gmail.com>

drivers/perf: apple_m1: Add Apple A18 Support

This commit adds CPU PMU support for the Apple A18 (Tahiti) cores by
reusing the M4 PMU event mappings and callbacks.

> diff --git a/drivers/perf/apple_m1_cpu_pmu.c b/drivers/perf/apple_m1_cpu_=
pmu.c
> index bdbd138cf1db8..775f3d5aba7ea 100644
> --- a/drivers/perf/apple_m1_cpu_pmu.c
> +++ b/drivers/perf/apple_m1_cpu_pmu.c
> @@ -1149,12 +1149,23 @@ static int gen ## _pmu_ ## family ## _init(struct=
 arm_pmu *cpu_pmu)				\
>  #define m4_pmu_set_event_filter		m3_pmu_set_event_filter
>  #define m4_pmu_format_attr_group	m3_pmu_format_attr_group
> =20
> +#define a18_pmu_enable_event		m4_pmu_enable_event
> +#define a18_pmu_map_event		m4_pmu_map_event
> +#define a18_pmu_get_event_idx		m4_pmu_get_event_idx
> +#define a18_pmu_set_event_filter	m4_pmu_set_event_filter
> +#define a18_pmu_map_pmuv3_event		m4_pmu_map_pmuv3_event
> +#define a18_pmu_init_pmceid		m4_pmu_init_pmceid
> +#define a18_pmu_events_attr_group	m4_pmu_events_attr_group
> +#define a18_pmu_format_attr_group	m4_pmu_format_attr_group
> +
>  APPLE_PMU_INIT(m1, icestorm)
>  APPLE_PMU_INIT(m1, firestorm)
>  APPLE_PMU_INIT(m2, avalanche)
>  APPLE_PMU_INIT(m2, blizzard)
>  APPLE_PMU_INIT(m3, sawtooth)
>  APPLE_PMU_INIT(m3, everest)
> +APPLE_PMU_INIT(a18, tahiti_e)
> +APPLE_PMU_INIT(a18, tahiti_p)

[Severity: Low]
This isn't a bug, but since APPLE_PMU_INIT(gen, family) only uses the gen
argument to select the gen_pmu_* callbacks and attribute groups (while
cpu_pmu->name is constructed solely from family), are the a18_pmu_* alias
macros needed here?

Unlike m2 and m4, which define generation-specific callbacks or attribute
groups and only alias the remaining symbols from an earlier generation, a18
aliases every symbol to m4_pmu_*. In addition, a18_pmu_init_pmceid is never
used by APPLE_PMU_INIT() and expands to m4_pmu_init_pmceid, which does not
exist.

Could this use APPLE_PMU_INIT(m4, tahiti_e) and APPLE_PMU_INIT(m4, tahiti_p)
directly (with m4_pmu_tahiti_e_init and m4_pmu_tahiti_p_init in
m1_pmu_of_device_ids) and drop the a18_pmu_* macro definitions?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-m3-plus-pm=
u-events-v1-0-a8eb6c1139fe@gmail.com?part=3D8
