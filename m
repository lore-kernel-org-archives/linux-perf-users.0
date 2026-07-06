Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1E72E6CB3
	for <linux-perf-users@vger.kernel.org>; Mon,  6 Jul 2026 02:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783304334; cv=none; b=oxIMVpOC40Se+OjoxRuteY/1B2Ffd+5kZJMaQ4f1W0z0XJJmIHFBM4W8fqAHe6QIKGz1MB+GERBElymnvHL5H4n/Vv86h1W3fy2w5mZHEdzAz9OuLdxcew+s94/SqfzcWa2tUYSwvyK4oYHyjHPly37JEI4wmP2MXHMGHosLgq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783304334; c=relaxed/simple;
	bh=VoVqOkJqFjIQ5bcBLO84rCG/a5HOBBXItfbaJY4UU78=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ko2oPAYB+tfdOef8lUALk1HsDW/AiS6xnjJSvD/dQk45wB2F2G6DoTGCFs9T/FOCcGwBb0HUP2o98KAtVNQMpOpkBCOWD/j42jDCNiwvzVx9lz8v6rKNnwBiNokb6ASfAT40XpJkEtQ5dFVEcoxSa2y+9ZrKOyoNgzZxbo9Fr/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bwZ2eUF3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bwZ2eUF3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE2ED1F000E9;
	Mon,  6 Jul 2026 02:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783304333;
	bh=u8JwoplwtKchUwbx/BKPhbtP3HdXsd67U1p5BSUHOds=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bwZ2eUF3Qpdar2p4gNpKv9EmD9304u05z+3jadNk3jKexnCEXLA1trdiUXlRQm9r0
	 EwfhZvTM0KQ2cPAPlzuBuqfLAgFDM7ZmRTrLPmFrS5C8ALqyH0PHxEW0zspOy9Wr6d
	 mkHDydR1PuyW8G1/lefZqUhalRIcG03XCff2sgELKsB0w+eWgnjIdoq5dgtoW2u0qM
	 f6OcW0XeC2Nx804wy1aOM4Wr9zLp9/+8+pphCr0OvOStKo7EAg6d32UmiG+toshLv+
	 4cGzff/Kgeyf1X7ecCEog08dJq0YpXmhXSy2cUZFUOM0UM/6NPjndIhJSY1GRmOKL1
	 jMZJmc8eMVqyw==
From: sashiko-bot@kernel.org
Subject: Re: [Patch v9 02/24] perf/x86: Move hybrid PMU initialization
 before x86_pmu_starting_cpu()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260706015439.3040804-3-dapeng1.mi@linux.intel.com>
References: <20260706015439.3040804-1-dapeng1.mi@linux.intel.com>
 <20260706015439.3040804-3-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 02:18:52 +0000
Message-Id: <20260706021852.DE2ED1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Preexisting out-of-bounds read in `check_hw_exists()` on hybrid pl=
atforms due to an invalid `container_of()` cast on the global static `pmu` =
struct via the `hybrid()` macro.
--

commit 8216e613cee4854e16daaa11279146d17bc7f313
Author: Dapeng Mi <dapeng1.mi@linux.intel.com>

perf/x86: Move hybrid PMU initialization before x86_pmu_starting_cpu()

The current approach initializes hybrid PMU structures immediately before
registering them. This is risky as it can lead to key fields being
inadvertently overwritten. This patch mitigates this by moving the
default hybrid structure initialization before calling
x86_pmu_starting_cpu().

> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index 872d07a5fa80d..0888d3b0923e1 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -2195,8 +2195,20 @@ static int __init init_hw_perf_events(void)
> =20
>  	pmu.attr_update =3D x86_pmu.attr_update;
> =20
> -	if (!is_hybrid())
> +	if (!is_hybrid()) {
>  		x86_pmu_show_pmu_cap(NULL);
> +	} else {
> +		int i;
> +
> +		/*
> +		 * Init default ops.
> +		 * Must be called before registering x86_pmu_starting_cpu(),
> +		 * otherwise some key PMU fields, e.g., capabilities
> +		 * initialized in x86_pmu_starting_cpu(), would be overwritten.
> +		 */
> +		for (i =3D 0; i < x86_pmu.num_hybrid_pmus; i++)
> +			x86_pmu.hybrid_pmu[i].pmu =3D pmu;
> +	}

[Severity: High]
This is a pre-existing issue, but does passing the global pmu struct to
check_hw_exists() earlier in this function cause an out-of-bounds read on
hybrid platforms?

In init_hw_perf_events(), check_hw_exists(&pmu, ...) is called after
perf_is_hybrid is enabled. Inside check_hw_exists(), it iterates over
fixed counters and calls fixed_counter_disabled():

arch/x86/events/perf_event.h:fixed_counter_disabled() {
    ...
    u64 intel_ctrl =3D hybrid(pmu, intel_ctrl);
    ...
}

The hybrid() macro expands to a container_of() cast:

    container_of(_pmu, struct x86_hybrid_pmu, pmu)->_field

Because the pmu passed in is the standalone global struct pmu (not embedded
within a struct x86_hybrid_pmu), this cast yields an invalid pointer.

Could this read garbage data past the end of the global pmu struct when
accessing intel_ctrl, potentially causing the BIOS hardware check to act on
garbage data or trigger a kernel panic if it crosses an unmapped page
boundary?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706015439.3040=
804-1-dapeng1.mi@linux.intel.com?part=3D2
