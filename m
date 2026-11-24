Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795554254;
	b=leRDc5iwGO87xO5ry/Vnfh1HJpdGeSSKOqVToQqcu5kBu+YAmBctEl4jTzKPc9enGQgn
	 UT3hbksqme9X+Hh+gtoeqFEPlOnf5iU9bInLgMbBh1Tb2dmF+n6KWB9O289VNIXWhw0yN
	 Ywg4Tba5X/nOXQ74eJSw8pFseATPLQNBBbq4k1YqG1s0sm3ycCwIZ4gvfwi4iTiDX4V4Y
	 MU6+PwrwEbiIt+y2mwOQLpkeW3uxwEcH6zMN6FKDVyzk0NuP/Fxzsuqx8xdp9551XpSIu
	 v5OOkZttL1e0B/uNgSytcoSFO/5zHNhx3VyiYHDrZxtm4sgrO17P6MBNvLXQKBUWHMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795554254;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=6dubRZ+psZ8Qs4E+TpOMXYLhcvIEPixdHXGPYBCuxJw=;
	b=4wm66iAYJYUJGI3AtPmh8KLTerIZapr42hFB/HifOSpTmGle2XCPXzRX7tTDtUARCW2X
	 cSdFNVczIQuFu+l4OOHEWnOwypiZNKmTHizAOaIhna7765OhfAaAv902/rDQU/ogul08P
	 03UROVk2Nx3YCR10DXlv48luuB3ymOb23ZC7FvMzOnWD5TDFYsJO/BT2k5Vjre4PUfMEL
	 M4L0Ui4FjB61nOqRI7jEWY7k1RI8KSTh5nJYYmpK6dpLOJELVSXb4pTvfM8jLpWWknEPU
	 U0J4CHx3rQAq/71ZkzQgAoy8hUEDuST1JNVocOnsSidZBJ7Q6W9ggowK68xnZMZr/NQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E31yohwI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36980606A31E;
	Tue, 24 Nov 2026 21:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E31yohwI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 578041F000C0;
	Tue, 24 Nov 2026 21:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795554253;
	bh=6dubRZ+psZ8Qs4E+TpOMXYLhcvIEPixdHXGPYBCuxJw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=E31yohwI1HSD6GQXv6X2jlRti1B+6XAuLacDTcUp71pnPeSyB3rHv0h3Sz+t+U7z4
	 e1ViJZRgt1kSdq4XtWboFqBeycB7kD/VYCwz81seJ5vxt0i1WeFeoKRmdPibS1d1Sn
	 IwX2xtpFAOmrk8egAeGmTsKRz5MpidV0FPuf2+Bbb6t7i/9WLjlrzUlvZv0l9CQBni
	 3r9FU+7bw2O1l3RmptjURBc6s7cVTAShql3HGZ7oKlM6ZNa+hxGQsrXU/Zq7hvTQr2
	 zoKdED3wnBYy4m1QJSfqIgVF3JgvY/lz6u74EQQXUXKWaawhq8SjCCugXC6iHoeEI4
	 RU8XqmEnCz4lA==
Date: Tue, 24 Nov 2026 21:04:12 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [RFC PATCH 22/26] KVM: x86/pmu: Put the mediated PMU context
 lazily on slowpath VM-Exits
Message-ID: <awX4ejrfT_zdZ3vS@google.com>
References: <20261124002303.1785363-1-yosry@kernel.org>
 <20261124002303.1785363-23-yosry@kernel.org>
 <sashiko-outbox-230319@kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sashiko-outbox-230319@kernel.org>

On Tue, Nov 24, 2026 at 12:52:05AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Medium] KVM: x86/pmu: cgroup guest time corruption in
>   kvm_arch_vcpu_put() on sched-out
> --
> 
> commit 17f48d0588e7da0bb43ece63664106faa2d5150c
> Author: Yosry Ahmed <yosry@kernel.org>
> 
> KVM: x86/pmu: Put the mediated PMU context lazily on slowpath VM-Exits
> 
> This commit keeps the guest mediated PMU context loaded across slowpath
> VM-Exits when there are no conflicting host perf events, deferring the put
> until vcpu_put() or when perf reclaims the mediated PMU.
> 
> > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> > index 8370ccceadb82..7fb954ed8e84b 100644
> > --- a/arch/x86/kvm/x86.c
> > +++ b/arch/x86/kvm/x86.c
> > @@ -2708,6 +2708,11 @@ void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
> >  		srcu_read_unlock(&vcpu->kvm->srcu, idx);
> >  	}
> >  
> > +	if (kvm_vcpu_has_mediated_pmu(vcpu)) {
> > +		scoped_guard(irqsave)
> > +			kvm_mediated_pmu_put(vcpu);
> > +	}
> > +
> >  	kvm_x86_call(vcpu_put)(vcpu);
> >  	vcpu->arch.last_host_tsc = rdtsc();
> >  }
> 
> [Severity: Medium]
> Can calling kvm_mediated_pmu_put() from kvm_arch_vcpu_put() during a task
> switch corrupt cgroup guest time accounting (info->timeguest.time) for the
> incoming task's cgroup?
> 
> When a vCPU takes a slowpath VM-Exit while a non-conflicting cgroup perf
> event (such as a software or uncore event) is active on the CPU,
> perf_has_mediated_pmu_conflicts() is false, so the guest mediated PMU
> context stays loaded with preemption enabled.  If the vCPU task is then
> scheduled out to a task in another cgroup, prepare_task_switch() runs
> perf_event_task_sched_out() before fire_sched_out_preempt_notifiers():
> 
> kernel/sched/core.c:prepare_task_switch() {
>     ...
> 	perf_event_task_sched_out(prev, next);
> 	fire_sched_out_preempt_notifiers(prev, next);
>     ...
> }
> 
> During the switch:
> 
>   prepare_task_switch(prev, next)
>     perf_event_task_sched_out(prev, next)
>       ...
>         perf_cgroup_switch(next)
>           cpuctx->cgrp = cgrp;  /* switched to next's cgroup */
>           ctx_sched_in(..., EVENT_ALL|EVENT_CGROUP)
>             perf_cgroup_set_timestamp(cpuctx, false)
>               /* sets info->time.stamp, leaves info->timeguest.stamp
>                * uninitialized or stale on next's cgroup */
>     fire_sched_out_preempt_notifiers(prev, next)
>       kvm_sched_out()
>         ...
>           kvm_arch_vcpu_put()
>             kvm_mediated_pmu_put()
>               perf_put_guest_context()
>                 perf_event_sched_in(..., EVENT_GUEST)
>                   ctx_sched_in(..., EVENT_PINNED | EVENT_GUEST)
>                     update_cgrp_time_from_cpuctx(cpuctx, false)
>                       __update_cgrp_guest_time(info, now, true)
>                         info->timeguest.time += now - info->timeguest.stamp;
> 
> Because perf_guest_ctx_loaded is not cleared until the end of
> perf_put_guest_context(), update_cgrp_time_from_cpuctx() sees
> is_guest_mediated_pmu_loaded() == true and adds now - info->timeguest.stamp
> to next's cgroup using an uninitialized (0) or stale timestamp.  This adds
> up to the full perf_clock() uptime to next's cgroup guest time and causes
> 64-bit unsigned underflow when computing enabled/running time for
> exclude_guest mediated PMU events in that cgroup.

I don't think this causes a problem in practice. The cgroup guest time
is only consumed by events in a mediated-capable PMU's context. Such an
event would be a conflicting event. So KVM will put the guest context
when exiting to the slowpath, or the IPI installing it will reclaim the
PMU.  But it may be fragile, and having silently broken (yet unused)
accounting is not ideal.

An earlier version I had just reclaimed the PMU on context switch. I had
convinced myself that it's not needed because KVM's preempt notifier
(vcpu_put()) does so anyway. I missed the cgroup scheduling code. I
think it's probably safer to just reclaim on context switch.

One slightly annoying (but minor) problem is stats. Currently the
reclaim stat counts instances where perf reclaims the PMU because host
perf needs it (i.e. it conflicts with the mediated PMU). The vCPU put
path is not counted, as it's technically an implementation detail. The
context switch path would be counted as a reclaim, when it technically
isn't. Not a big deal, and I am not sure if Sean will want to keep the
stats anyway, we can discuss it separately.

I think it would basically be a new patch calling
perf_reclaim_mediated_pmu() at the beginning of
__perf_event_task_sched_out(), something like this on top of the
series:

diff --git a/kernel/events/core.c b/kernel/events/core.c
index d3e1b33c97716..0cdaaf9bbfb13 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -4019,6 +4019,15 @@ static void perf_event_switch(struct task_struct *task,
 void __perf_event_task_sched_out(struct task_struct *task,
                                 struct task_struct *next)
 {
+       /*
+        * The guest's mediated PMU context may still be loaded, e.g. if KVM
+        * left it loaded across slowpath VM-Exits, and KVM only puts it from
+        * its preempt notifier after this.  Reclaim the PMU first, as perf's
+        * sched-out (e.g. switching cgroups) must not run with a guest context
+        * loaded.
+        */
+       perf_reclaim_mediated_pmu();
+
        if (__this_cpu_read(perf_sched_cb_usages))
                perf_pmu_sched_task(task, next, false);

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261124002303.1785363-1-yosry@kernel.org?part=22
