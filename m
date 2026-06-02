Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B193D5648
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Jun 2026 15:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780413730; cv=none; b=nLvJID7oFAZ5HbE397AORDIFAai2PjbBjN4aLvd3B+TsXH5b5jkIlR+RNUW7HImqBlljtzvo9INYPZNRgtAVrBZ0fDl+gsH7+lp+TZ8NCkwZbmQCjM95q1rH849El8OLmeIcsJKJino+OPMhcFv9dgepdMTpulxMyYuGP7Rn6/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780413730; c=relaxed/simple;
	bh=G2R2RmT35/fscGbTOG/xia8X0Z7ETkULUDlcoKinXOU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kiKKTyVdhFxjNdVDhgIr8Aq0El+foSSu9M3FnM1nBuzQAf6VKAb6Wl7aj5LmanSQ3tcIp+9R1a2TXe9jqBHTDDWRA1CoAYFbk8eExjgkk0NDJAwTD4OYDjgkBieRBRd/S0QuWRC6kj+VPWPtiH6nfszYNjGs5JZbLUWik2+7DHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dWaWug8f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dWaWug8f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 967361F00893;
	Tue,  2 Jun 2026 15:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780413728;
	bh=uZQMorfirS1FVgpi3Ku7gadmA+jPENSt9UrSqgIN6w4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dWaWug8fexSty0MEbNO+Byn2aZ1IvAZ+2QDThbQUecZm4RKm0OAweWfGNNhoQ687k
	 QaK4XkGdeVSjx9h5KgeEz1e0wJNhfjWOvqfHuHHR9uTg5QExnY9GrRka2pZd5xft0Q
	 BFFvrhrCPYuZkMh/j/f/mNmSjroSvGYCOIemeYSAGXMl5zW5mEvw/NuLo7ZrUb3CDx
	 Hilfxsf9VhLI/ATHk2zQ7oKEVieQ3V/W4LJJZfW7mYFqZ+gHNMmvMs7oq2dKx4ToN/
	 YWB7SHQysX0sLIdHSBa8E+8FGljdYHji1km9gRKEBkz8FNg1I5s29SL5+1tjq4Ach9
	 iASq6avKVf32w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V3 1/7] perf/x86/intel/uncore: Fix discovery unit lookup
 for multi-die systems
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zide Chen" <zide.chen@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260602144908.263680-2-zide.chen@intel.com>
References: <20260602144908.263680-2-zide.chen@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jun 2026 15:22:08 +0000
Message-Id: <20260602152208.967361F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The commit message inaccurately claims that a NULL unit can be e=
xpected when a CPU die is offline, justifying the removal of a valid WARN_O=
N_ONCE assertion, but the code path is structurally unreachable for missing=
 units.
--

commit ddb51b3d3e54081e6dbacecec75a18fa773ae364
Author: Zide Chen <zide.chen@intel.com>

perf/x86/intel/uncore: Fix discovery unit lookup for multi-die systems

This commit fixes an issue where PMON units with the same unit ID may
retrieve the wrong node on multi-die systems by using box->dieid. It
also removes a WARN_ON_ONCE() under the assumption that a NULL unit
can be expected during CPU die offline/online scenarios.

> Remove WARN_ON_ONCE() because with the above change a NULL unit can be
> expected, e.g. when a CPU die is offline during uncore enumeration and
> the unit is not added to the RB-tree. In this case,
> intel_uncore_find_discovery_unit() returns NULL once the die becomes
> online, and it is expected that the PMU box is not functional for that
> die.

> diff --git a/arch/x86/events/intel/uncore_discovery.c b/arch/x86/events/i=
ntel/uncore_discovery.c
> index 583cbd06b9b88..60e1200c4691d 100644
> --- a/arch/x86/events/intel/uncore_discovery.c
> +++ b/arch/x86/events/intel/uncore_discovery.c
> @@ -481,8 +481,8 @@ static u64 intel_generic_uncore_box_ctl(struct intel_=
uncore_box *box)
>  	struct intel_uncore_discovery_unit *unit;
> =20
>  	unit =3D intel_uncore_find_discovery_unit(box->pmu->type->boxes,
> -						-1, box->pmu->pmu_idx);
> -	if (WARN_ON_ONCE(!unit))
> +						box->dieid, box->pmu->pmu_idx);
> +	if (!unit)
>  		return 0;

[Severity: Medium]
Is the scenario described in the commit message actually possible in the
current codebase?

When a CPU die comes online, uncore_event_cpu_online() invokes
uncore_change_type_ctx(), which relies on uncore_die_has_box() to check
for the unit. If the unit is missing from the RB-tree, uncore_die_has_box()
returns false, and the box cpu assignment is skipped:

arch/x86/events/intel/uncore.c:uncore_change_type_ctx() {
    ...
    if (uncore_die_has_box(type, die, pmu->pmu_idx)) {
        box->cpu =3D new_cpu;
        cpumask_set_cpu(new_cpu, &pmu->cpu_mask);
    }
    ...
}

Because box->cpu remains -1, uncore_box_ref() bypasses initialization:

arch/x86/events/intel/uncore.c:uncore_box_ref() {
    ...
    if (box && box->cpu >=3D 0 && atomic_inc_return(&box->refcnt) =3D=3D 1)
        uncore_box_init(box);
    ...
}

Furthermore, uncore_pmu_event_init() rejects event creations if box->cpu
is negative. Because of this, it appears the PMU operations (init, enable,
disable) are never executed for this box, making the call to
intel_generic_uncore_box_ctl() unreachable.

Does this mean the removed WARN_ON_ONCE(!unit) was actually a valid
assertion, and the !unit check is effectively dead code?

> =20
>  	return unit->addr;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260602144908.2636=
80-1-zide.chen@intel.com?part=3D1
