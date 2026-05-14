Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A2B25B094
	for <linux-perf-users@vger.kernel.org>; Thu, 14 May 2026 04:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778732859; cv=none; b=LdyN8UTWZMhVu4IeLHozlME9IinsZtSDe59L3NfFhErxa2y7BTFOiYoTWYXJ0+x8znpzDczZOJpSmYlYaZSLEMdIJ7M9zG6WpTfA+7feIaBp/aZEUvTvVtoThybkLziwp8dJ7X0X2DE4Gef5tX9b2yoBRSUnRD+tByQBgaUKdGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778732859; c=relaxed/simple;
	bh=oUWJWLQiXFo5JMnNXlRhu5toUh4UYuNWmXNoUtBcry8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nLD87ycK7cHLCcYPbblCe483FjMckdtOuLBhkSXI4QK3vgL0zsaZuJdU4krQC6haGu4J24Rc4ineOyIsiRzy/07ByYet21diFXyIsxuKvvHm3o8ca0chzNtlI9fnPdgXEvHhKnDrtJYyopoiMLg9nm6bgyCDm+UtuiyTsH56brs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DCxE8KAV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DCxE8KAV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80B40C2BCB7;
	Thu, 14 May 2026 04:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778732858;
	bh=oUWJWLQiXFo5JMnNXlRhu5toUh4UYuNWmXNoUtBcry8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=DCxE8KAVG7oIbydOP6GFGY49kGM71ZFRspVP3V3zmPELNPU3/AapMgS8niESOxlzk
	 xP+gjCLdOlaZMgyMVkxjn+CrW91glNyEaIJ2lXTfPoV74nGE9+1KfYXQtq/TC0K1Se
	 qO8AGD+eKOK0Le+1yRZI5jVery8auu1av1Y+vv3SoDqA1+j7Tqv7g+QUlaq7A/tyqW
	 L2yLCJhOGpkt/tr7eVknR46AuW1XyaAw/9yx/wPaM8KauMu8r46bYSHVKfbQjzs/3+
	 aRk7zV+j28KyK9IlaL5oM2fc7GmStsdmqHOWLuOLCggTnY7mT7OWKFgX8+f9/W4OV9
	 //IwcQ+6u+YOw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/7] perf/x86/intel/uncore: Introduce PMU flags and
 broken state
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zide Chen" <zide.chen@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260512233048.9577-6-zide.chen@intel.com>
References: <20260512233048.9577-6-zide.chen@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 04:27:37 +0000
Message-Id: <20260514042738.80B40C2BCB7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Critical] Intentionally leaking `die_refcnt` on PCI box setup failure pr=
events PMU unregistration, leading to a Use-After-Free.
- [High] Global `PMU_BROKEN` state disables new event creation and breaks C=
PU context migration for fully functional dies.
- [Medium] Confused lifecycle assumptions lead to contradictory error handl=
ing and dead code between PCI and MSR/MMIO PMUs.
- [Medium] Data race between plain store and atomic bitwise operation on `p=
mu->flags`.
--

commit 553c891e098baf8dc3f2b474849cc4642dfe9be6
Author: Zide Chen <zide.chen@intel.com>

perf/x86/intel/uncore: Introduce PMU flags and broken state

This commit replaces the 'registered' field in intel_uncore_pmu with a
'flags' field, introducing a PMU_BROKEN flag to track box setup failures.
If a box fails to initialize, the PMU is marked broken, which rejects new
event assignments and skips future box setup attempts.

> diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncor=
e.c
> index 617a68c1d76c3..4d31dcaf5405b 100644
> --- a/arch/x86/events/intel/uncore.c
> +++ b/arch/x86/events/intel/uncore.c

[ ... ]

> @@ -738,7 +738,7 @@ static int uncore_pmu_event_init(struct perf_event *e=
vent)
> =20
>  	pmu =3D uncore_event_to_pmu(event);
>  	/* no device found for this pmu */
> -	if (!pmu->registered)
> +	if (!uncore_pmu_available(pmu))
>  		return -ENOENT;

Since PMU_BROKEN is a global flag across all dies and packages, if one die
fails initialization, the entire PMU is marked broken. Does this cause
uncore_pmu_event_init() to incorrectly reject new event assignments on fully
functional packages?

[ ... ]

> @@ -934,16 +934,16 @@ static int uncore_pmu_register(struct intel_uncore_=
pmu *pmu)
> =20
>  	ret =3D perf_pmu_register(&pmu->pmu, pmu->name, -1);
>  	if (!ret)
> -		pmu->registered =3D true;
> +		uncore_pmu_set_registered(pmu);
>  	return ret;
>  }
> =20
>  static void uncore_pmu_unregister(struct intel_uncore_pmu *pmu)
>  {
> -	if (!pmu->registered)
> +	if (!uncore_pmu_registered(pmu))
>  		return;
>  	perf_pmu_unregister(&pmu->pmu);
> -	pmu->registered =3D false;
> +	WRITE_ONCE(pmu->flags, 0);

Can this plain store data race with concurrent atomic bitwise operations?

If uncore_box_setup() executes on another CPU (e.g., probing a new failing
die while removing a successful die), it uses the atomic read-modify-write
instruction set_bit(PMU_BROKEN_BIT, &(pmu)->flags). Mixing plain stores and
atomic bitwise operations on the same memory location could lead to
clobbered updates.

[ ... ]

> @@ -1136,7 +1136,13 @@ static int uncore_box_setup(struct intel_uncore_pm=
u *pmu,
> =20
>  	/* die_refcnt tracks online dies, not only functioning boxes. */
>  	dies =3D atomic_inc_return(&pmu->die_refcnt);
> -	uncore_box_init(box);
> +
> +	if (uncore_pmu_broken(pmu))
> +		return -ENODEV;
> +
> +	ret =3D uncore_box_init(box);
> +	if (ret)
> +		goto err;
> =20
>  	/* First active box registers the pmu. */
>  	if (dies > 1)
> @@ -1148,6 +1154,19 @@ static int uncore_box_setup(struct intel_uncore_pm=
u *pmu,
> =20
>  	return 0;
>  err:
> +	/*
> +	 * On failure on any box, mark the per-package PMU as broken regardless
> +	 * of whether it was registered or not.
> +	 *
> +	 * Don't decrement die_refcnt to prevent any future CPU online
> +	 * event or PCI probe, from retrying the failed PMU registration.
> +	 *
> +	 * Don't decrement cpu_refcnt to avoid other in-die CPUs from
> +	 * trying to set up the PMU box again.
> +	 *
> +	 * Don't kfree box; MSR and MMIO boxes are freed at module exit only.
> +	 */

Is there a risk of a use-after-free resulting from intentionally leaking
die_refcnt here?

For PCI PMUs, the caller uncore_pci_pmu_register() executes kfree(box) on e=
rror
and fails the PCI probe, meaning uncore_pci_remove() is never called to cle=
an
up this leaked reference.

If another successfully probed PCI box for this PMU is later removed,
uncore_pci_pmu_unregister() decrements die_refcnt, but it will not reach 0 =
due
to the earlier leak. Consequently, uncore_pmu_unregister(pmu) is skipped,
leaving the PMU and its associated perf events active.

When uncore_pci_pmu_unregister() then frees the successful box, active
perf_event instances could still hold event->pmu_private pointing to this f=
reed
box, potentially triggering a use-after-free on subsequent event reads or
context switches.

Additionally, this comment claims MSR and MMIO boxes are freed at module ex=
it
only. Does this conflict with PCI PMUs which unconditionally execute kfree(=
box)
on error, immediately destroying the box?

> +	uncore_pmu_set_broken(pmu);
>  	uncore_box_exit(box);
>  	return ret;
>  }

[ ... ]

> @@ -1483,7 +1502,8 @@ static void uncore_change_type_ctx(struct intel_unc=
ore_type *type, int old_cpu,
> =20
>  		if (old_cpu < 0) {
>  			WARN_ON_ONCE(box->cpu !=3D -1);
> -			if (uncore_die_has_box(type, die, pmu->pmu_idx)) {
> +			if (uncore_die_has_box(type, die, pmu->pmu_idx) &&
> +			    !uncore_pmu_broken(pmu)) {
>  				box->cpu =3D new_cpu;
>  				cpumask_set_cpu(new_cpu, &pmu->cpu_mask);
>  			}
> @@ -1493,7 +1513,7 @@ static void uncore_change_type_ctx(struct intel_unc=
ore_type *type, int old_cpu,
>  		WARN_ON_ONCE(box->cpu !=3D -1 && box->cpu !=3D old_cpu);
>  		box->cpu =3D -1;
>  		cpumask_clear_cpu(old_cpu, &pmu->cpu_mask);
> -		if (new_cpu < 0)
> +		if (new_cpu < 0 || uncore_pmu_broken(pmu))
>  			continue;

If uncore_pmu_broken(pmu) causes this to skip, does this strand active hard=
ware
events on offlined CPUs for fully functional dies?

The commit message states the goal is to avoid disrupting in-flight events =
on
other boxes, but skipping uncore_pmu_cancel_hrtimer() and
perf_pmu_migrate_context() here seems to break CPU context migration for th=
ose
events.

> =20
>  		if (!uncore_die_has_box(type, die, pmu->pmu_idx))

[ ... ]

> @@ -1573,7 +1593,7 @@ static int allocate_boxes(struct intel_uncore_type =
**types,
>  		type =3D *types;
>  		pmu =3D type->pmus;
>  		for (i =3D 0; i < type->num_boxes; i++, pmu++) {
> -			if (pmu->boxes[die])
> +			if (pmu->boxes[die] || uncore_pmu_broken(pmu))
>  				continue;

Is this check dead code? allocate_boxes() is exclusively used by MSR/MMIO
PMUs, but those PMUs ignore hardware initialization failures and never call
uncore_pmu_set_broken(pmu).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260512233048.9577=
-1-zide.chen@intel.com?part=3D5
