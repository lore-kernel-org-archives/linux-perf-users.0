Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412C737C0FA
	for <linux-perf-users@vger.kernel.org>; Mon,  4 May 2026 22:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777932713; cv=none; b=jx5TFmYYJlJ9daTg33wmzjwpzIgHDz/e6SsBkmIH2xEeTeKzpICFW4Zox3Rg9ZBhN5KWuprMoUszj+J0T1V4dc39oFAIDiAkxp4xHEg3l/wwXrpCTGJCLbs483NhQF/lkKYEWeTKgtQFtQ7hji+MHMGwVV68vV43ZuICnUSCUZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777932713; c=relaxed/simple;
	bh=ghn7Qk+WDSYWbANls3cxopBUMENWA25fVvCiSSvjDyc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cfHGhGt0fAb9ArANN87/2mBUM86YxM/L1+aYjiDibFS+8JEt3PmD55332VP4irceTldgjJMvjKX03ZOZCuYtS7v/pNR8C8pRL7DrISyQJ07amSmpBDLe5oWZHJ7/wT7OtSBQUpbeDcZV7Dgk6MC1dwbNgL5kt5Mgka7xslR3kso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bMdJ9oF8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bMdJ9oF8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC8BEC2BCB8;
	Mon,  4 May 2026 22:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777932713;
	bh=ghn7Qk+WDSYWbANls3cxopBUMENWA25fVvCiSSvjDyc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=bMdJ9oF8lkwQFF8qWYRdHOt9QtTssDQ8nP6HfNfN+5rMLzkWXOGTbrGRxjoOv+u/C
	 hJ+mZwiT6f8YogAL6xROpBFNnR7s9Vmn5RiwmdlkDRGkIpVnIZ3K0rm7hTzBezdhYE
	 /Kt23uY2EO5KW6Kj1paE0mf4tTpVUny5wkzcd/PSlQL0LN2kxgq0Ff9giZ6GrdJVTK
	 2vNdmPC/XpSbz1l3RHbwwaCeLkteScnIOmZebeSH/T/LSd9G22abZj5fkiKcNEa8jp
	 Di/7WNWItChsD0ckXWx1WGkhtAJfb/QnSU40nSBBswAnU5PzIC9/1TCNB8MSxKfOyT
	 7tcO+FlQowCaw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 13/20] KVM: arm64: Apply dynamic guest counter
 reservations
Reply-To: sashiko@lists.linux.dev
To: "Colton Lewis" <coltonlewis@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260504211813.1804997-14-coltonlewis@google.com>
References: <20260504211813.1804997-14-coltonlewis@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 04 May 2026 22:11:52 +0000
Message-Id: <20260504221152.EC8BEC2BCB8@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Hard lockup / Deadlock due to acquiring `perf_ctx_lock` with hardw=
are interrupts enabled.
- [High] Data race and cross-CPU isolation breach due to dynamic modificati=
on of the global PMU counter mask (`cntr_mask`).
- [High] NULL pointer dereference risk due to lockless, unprotected access =
to the per-CPU perf events array.
- [Medium] Pending host perf events remain permanently inactive due to skip=
ped PMU reschedule updates.
--

commit ad275b1ce5aad3594e39d36f37c39f73178b1c0b
Author: Colton Lewis <coltonlewis@google.com>

KVM: arm64: Apply dynamic guest counter reservations

Apply dynamic guest counter reservations by checking if the requested
guest mask collides with any events the host has scheduled and calling
pmu_perf_resched_update() with a hook that updates the mask of
available counters in between schedule out and schedule in.

> diff --git a/arch/arm64/kvm/pmu-direct.c b/arch/arm64/kvm/pmu-direct.c
> index 2252d3b905db9..14cc419dbafad 100644
> --- a/arch/arm64/kvm/pmu-direct.c
> +++ b/arch/arm64/kvm/pmu-direct.c

[ ... ]

> @@ -100,6 +100,73 @@ u8 kvm_pmu_hpmn(struct kvm_vcpu *vcpu)
> +static void kvm_pmu_set_guest_counters(struct arm_pmu *cpu_pmu, u64 gues=
t_mask)
> +{
> +	struct pmu_hw_events *cpuc =3D this_cpu_ptr(cpu_pmu->hw_events);
> +	DECLARE_BITMAP(guest_bitmap, ARMPMU_MAX_HWEVENTS);
> +	DECLARE_BITMAP(new_mask, ARMPMU_MAX_HWEVENTS);
> +	bool need_resched =3D false;
> +
> +	bitmap_from_arr64(guest_bitmap, &guest_mask, ARMPMU_MAX_HWEVENTS);
> +	bitmap_copy(new_mask, cpu_pmu->hw_cntr_mask, ARMPMU_MAX_HWEVENTS);
> +
> +	if (guest_mask) {
> +		/* Subtract guest counters from available host mask */
> +		bitmap_andnot(new_mask, new_mask, guest_bitmap, ARMPMU_MAX_HWEVENTS);
> +
> +		/* Did we collide with an active host event? */
> +		if (bitmap_intersects(cpuc->used_mask, guest_bitmap, ARMPMU_MAX_HWEVEN=
TS)) {
> +			int idx;
> +
> +			need_resched =3D true;
> +			cpuc->host_squeezed =3D true;
> +
> +			/* Look for pinned events that are about to be preempted */
> +			for_each_set_bit(idx, guest_bitmap, ARMPMU_MAX_HWEVENTS) {
> +				if (test_bit(idx, cpuc->used_mask) && cpuc->events[idx] &&
> +				    cpuc->events[idx]->attr.pinned) {

Is there a risk of a NULL pointer dereference here?

The per-CPU events array is accessed without locks and with hardware interr=
upts
enabled. If an interrupt occurs (like an IPI triggering an event removal)
between the evaluation of cpuc->events[idx] and reading ->attr.pinned, and
the compiler issues separate memory reads due to a lack of READ_ONCE(), cou=
ld
the second read observe a NULL pointer?

> +					pr_warn_ratelimited("perf: Pinned host event squeezed out by KVM gu=
est PMU partition\n");
> +					break;
> +				}
> +			}
> +		}
> +	} else {
> +		/*
> +		 * Restoring to hw_cntr_mask.
> +		 * Only resched if we previously squeezed an event.
> +		 */
> +		if (cpuc->host_squeezed) {
> +			need_resched =3D true;
> +			cpuc->host_squeezed =3D false;
> +		}
> +	}

What happens to host perf events created while the guest is actively runnin=
g?

It looks like cpuc->host_squeezed is only set if a host event collided when
the guest was loaded. If a new host event is created while the guest is
running, it will fail to allocate a counter due to the restricted mask.

When the guest unloads, cpuc->host_squeezed is false, so no reschedule is
requested. Will the perf subsystem be notified that counters have been free=
d,
or will the host event remain permanently inactive?

> +
> +	if (need_resched) {
> +		/* Collision: run full perf reschedule */
> +		perf_pmu_resched_update(&cpu_pmu->pmu, kvm_pmu_update_mask, new_mask);

Could this cause a deadlock if a Performance Monitor Interrupt (PMI) or
perf IPI fires?

kvm_pmu_load() calls this with preemption disabled but leaves hardware
interrupts enabled. perf_pmu_resched_update() unconditionally calls
perf_ctx_lock(), which acquires the context lock without disabling local IR=
Qs.

If an interrupt fires on the same CPU while this lock is held, and the
handler attempts to acquire ctx->lock via raw_spin_lock_irqsave(), will
it spin indefinitely?

> +	} else {
> +		/* Host was never using guest counters anyway */
> +		bitmap_copy(cpu_pmu->cntr_mask, new_mask, ARMPMU_MAX_HWEVENTS);

Does modifying cpu_pmu->cntr_mask here introduce a data race?

struct arm_pmu represents PMU hardware capabilities shared across multiple =
CPUs
in a domain. If this per-CPU load/put path dynamically mutates cntr_mask
without global synchronization, could reserving guest counters on one CPU
incorrectly prevent host perf events from running on another CPU?

Also, when a vCPU unloads, it appears to unconditionally restore cntr_mask =
to
hw_cntr_mask, which might wipe out active reservations from other vCPUs.

> +	}
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260504211813.1804=
997-1-coltonlewis@google.com?part=3D13
