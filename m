Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795481527;
	b=lWZXBgild2v0hyBhMh0ny3MtiXiPadVesgCR0pb4IKS/L1wU/GfBkmrSP8reX8bbpif4
	 Yla0/DsZQqgS2jv/h8l/7ARkhfCbGyKopSVTRVzpaHQpGSj4CueEA9J6QThtkBF5NCkwk
	 LPBFOdTnbQPvzfliBZRjXVhBBwfU4dLgSAwWBWYUG30MD6WERQxGQNcXxvja5wXSaNWGe
	 S9ZPfpY2JO0DDENvKhiUQwOoIQPfxhOTVz1hCqAYudo4RZxxJUxXNso/2Cb5Y6iIvm5gO
	 PCnd1dmJ9pG6zPs678k5sTcmYWZDaaKQoLM7ZdVF2OEoZOq9xDS/GqWf+YsVE6qb44w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795481527;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=tJHReiKT1ftaev7T6DYUKnzh2/ENz2Ga0Eh2o8QvG7w=;
	b=fMW/gueQvR0F1PwOdWl0/jE4hnohzBDCm5swlJf226Ma8vSQbSOSlkdIT73dd0i+C6F1
	 xVC9C7hbfyI0s51Jt4JYltNQL8cbwx5axpFwFScTNQ6tG8D7TMPhl7B84NqrpwwLb9eoP
	 EUWvIRpzkk1cl+FVreN/NkbysGG1NCIon5KuPbyTHnP99j2cUnNiHY4H05O2QPDUvb0YO
	 xgABqWvGIcdAKcQtbTtRkAd/432G/EOWYB6VZDFO9Mx1VBPHlhIO3v0FlV0uCOT+/SDAT
	 ZBcLRYwMFJZGOcDH05FPbjtTX+byx1Vq26I2DQdm+bFr9lh65XWwwQSAtka+SWdMaxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aTgKDbmB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C14D606A322;
	Tue, 24 Nov 2026 00:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aTgKDbmB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1748B1F000C4;
	Tue, 24 Nov 2026 00:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795481526;
	bh=tJHReiKT1ftaev7T6DYUKnzh2/ENz2Ga0Eh2o8QvG7w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aTgKDbmB9sNZHBvmxed0dYjMUcuxL1SW+v5fAo5NEBh6R6NhqoN4TNrgYsSBTFoF9
	 Yc4tfmfpKKot+uTfT4z8YLKDfHAoQjW8PI/FDtjUSKp8wY5vryb26RYoBFxqdD4w53
	 h3C/dIoo2IbQZzrkfZ4pVaA2mpMlS3PY1aKfKiBRcgIDgs4OkQBrGg6rcXy/FQ8ovY
	 8DtiWUgUeWxiuGqUfWu4OHJ045Yo2/zSuPILJ6mUAJniqIh4feiXdojaCLXW6B2uy6
	 bS3/kY/Z0PhPim8eNqO+aOLK5oXeOgjLCB5bmm/umSKcoRAp5UNX2z5sM6CsVZez9g
	 Eve6ZMF/BHW7g==
Message-ID: <sashiko-outbox-230319@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 22/26] KVM: x86/pmu: Put the mediated PMU context
 lazily on slowpath VM-Exits
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yosry Ahmed" <yosry@kernel.org>
Cc: linux-perf-users@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20261124002303.1785363-23-yosry@kernel.org>
References: <20261124002303.1785363-1-yosry@kernel.org>
 <20261124002303.1785363-23-yosry@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 00:52:05 +0000
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
- [Medium] KVM: x86/pmu: cgroup guest time corruption in
  kvm_arch_vcpu_put() on sched-out
--

commit 17f48d0588e7da0bb43ece63664106faa2d5150c
Author: Yosry Ahmed <yosry@kernel.org>

KVM: x86/pmu: Put the mediated PMU context lazily on slowpath VM-Exits

This commit keeps the guest mediated PMU context loaded across slowpath
VM-Exits when there are no conflicting host perf events, deferring the put
until vcpu_put() or when perf reclaims the mediated PMU.

> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 8370ccceadb82..7fb954ed8e84b 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -2708,6 +2708,11 @@ void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
>  		srcu_read_unlock(&vcpu->kvm->srcu, idx);
>  	}
> =20
> +	if (kvm_vcpu_has_mediated_pmu(vcpu)) {
> +		scoped_guard(irqsave)
> +			kvm_mediated_pmu_put(vcpu);
> +	}
> +
>  	kvm_x86_call(vcpu_put)(vcpu);
>  	vcpu->arch.last_host_tsc =3D rdtsc();
>  }

[Severity: Medium]
Can calling kvm_mediated_pmu_put() from kvm_arch_vcpu_put() during a task
switch corrupt cgroup guest time accounting (info->timeguest.time) for the
incoming task's cgroup?

When a vCPU takes a slowpath VM-Exit while a non-conflicting cgroup perf
event (such as a software or uncore event) is active on the CPU,
perf_has_mediated_pmu_conflicts() is false, so the guest mediated PMU
context stays loaded with preemption enabled.  If the vCPU task is then
scheduled out to a task in another cgroup, prepare_task_switch() runs
perf_event_task_sched_out() before fire_sched_out_preempt_notifiers():

kernel/sched/core.c:prepare_task_switch() {
    ...
	perf_event_task_sched_out(prev, next);
	fire_sched_out_preempt_notifiers(prev, next);
    ...
}

During the switch:

  prepare_task_switch(prev, next)
    perf_event_task_sched_out(prev, next)
      ...
        perf_cgroup_switch(next)
          cpuctx->cgrp =3D cgrp;  /* switched to next's cgroup */
          ctx_sched_in(..., EVENT_ALL|EVENT_CGROUP)
            perf_cgroup_set_timestamp(cpuctx, false)
              /* sets info->time.stamp, leaves info->timeguest.stamp
               * uninitialized or stale on next's cgroup */
    fire_sched_out_preempt_notifiers(prev, next)
      kvm_sched_out()
        ...
          kvm_arch_vcpu_put()
            kvm_mediated_pmu_put()
              perf_put_guest_context()
                perf_event_sched_in(..., EVENT_GUEST)
                  ctx_sched_in(..., EVENT_PINNED | EVENT_GUEST)
                    update_cgrp_time_from_cpuctx(cpuctx, false)
                      __update_cgrp_guest_time(info, now, true)
                        info->timeguest.time +=3D now - info->timeguest.sta=
mp;

Because perf_guest_ctx_loaded is not cleared until the end of
perf_put_guest_context(), update_cgrp_time_from_cpuctx() sees
is_guest_mediated_pmu_loaded() =3D=3D true and adds now - info->timeguest.s=
tamp
to next's cgroup using an uninitialized (0) or stale timestamp.  This adds
up to the full perf_clock() uptime to next's cgroup guest time and causes
64-bit unsigned underflow when computing enabled/running time for
exclude_guest mediated PMU events in that cgroup.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124002303.1785=
363-1-yosry@kernel.org?part=3D22
