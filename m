Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2848361964
	for <linux-perf-users@vger.kernel.org>; Wed,  7 Oct 2026 07:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791358252; cv=pass; b=BOthJHBr952FO64gJo3mTaAiwUlpQV4xk4l4vHIyHm1XYfJKmzUhoKdKqRQX9tS7eGEEl/H9nrUQL5Mx6PhP5D+d/dCptoKxNuF6ClWwwSiqxGOJiZns+TNIaRbOTLQelug3+ozHx5uTupz+XoDutAqJnNX6VV8t/FSanWBAIp8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791358252; c=relaxed/simple;
	bh=bCMKGP/nRG0J8JkFF+jTqQ6LtRWlhkz7G62TyefjW2U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=p//91o5V/Cg0KkKXbNuhkt+D1JLKYvtKrpaYJi7uZR5368wJO7+jHINIxaBKe6UjAmthrsNifxq9/jIWc8oJRflh5IGoBnxmOt4wQQvPJiGxO2bpl9bFPxrPQKnikCgNuKsCgl2UY7xlF4iRp26f8mg2M9CoHGJ2FdzpehuzzfM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=YI2hLGLh; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="YI2hLGLh"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6a0a4aa99bdso2102780a12.1
        for <linux-perf-users@vger.kernel.org>; Wed, 07 Oct 2026 00:30:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791358248; cv=none;
        d=google.com; s=arc-20260327;
        b=jD1B6RkZB4iwl9POUFzNXJAjHIu62y3diXkZGDRrPG4vDN6bV3yvbynOMUI9DC6SDS
         jJXiUnv/Fo4IP+tCp1vhvK0mhqkAsTnBNZI85tWzCzQGwfbx2lxAs7oud4WUASU/k7Cy
         jtXmSks9Wn63xw0GZJmVFY06aczdKOChtYQl+sDV1CbzLzqb9G/7DWtXvVx2m939nA0e
         nE3QBqzT4wiFwP1TiySUyYKHK61oZB0GdMgO1J5ChARIuTDS3ee+udjLt42UoqWouTXi
         VYr+ryugjmR5893cZ0YTnNr7X6ZVJSTC+MZsQ2AmThzzravmhKytLbReTNe3iuBUiXh7
         UMrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nGH76CQ9N9VJMY99D2yCS2way7M9p9aVK78CkM0G/dQ=;
        fh=qnz45FIB7N1qSD76gP047L4Rnqv8s8HQpkaUHwWgEt4=;
        b=esCPl9g179vO1mUzwqOrzNq1dTNlGiqIVN0o0ZpvVKmf6A6f8Fm23zGUgRUYapcZFJ
         6OHfrOmQvwaPj0+e272iyNVEnxe+kNHQSZQkjaA9FA8oIPs+bkl42JhGav/YqTjoRZT9
         MnbCqFfFpGD15RBVh3ofeacFUqqRB8HCsctlwQCSFc4zHejEeBOtlZD0Ld7enlFg5836
         4/o+cVodhYLy4kHJsy5FR835m5VbYy2i73ipByNZG70KrE7Q0u5B2VS7LxJYig0XlqcS
         iL/RipZ6M98UxP6QoVPjvPAME1J3urWFTXxdUJUkRSKm8fHnSg0m83IgywaTX9ZBxpg4
         +j4Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1791358248; x=1791963048; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nGH76CQ9N9VJMY99D2yCS2way7M9p9aVK78CkM0G/dQ=;
        b=YI2hLGLh+AQw3RI4Goe1ZJuByUXTSu2FPtS9db1lz/Z/tX6ooMvB6rjqWKnvSdkq9C
         k5SrjQPTNGMQOpAuUSnujZowqAXoDfJwid/kRpCtYA08k3mKPBGDG+xlA5+d+sTAe039
         aHh5Wxq0MZSKMklGFOZOxNHuU51Ejdo2XMuVqj10RcdJSwbAw+9511GjL6155t6Kzgpb
         Qdd/GJ9Jp59ovDt1spoLrnLKabB1/NaqfrZkDgqqRmD1PScpX7+2XBzEBVIJbc8lY/Jo
         h36xKKIprULxdKh/Hh48bIiqQtIWSt6JM4kKI2aIHbqSB8Y1mInh9IOVJbARpgKB348C
         oRLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791358248; x=1791963048;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nGH76CQ9N9VJMY99D2yCS2way7M9p9aVK78CkM0G/dQ=;
        b=iaDkZd7VYVrfe6UaTrU7f4SeLY5lTmWpQzOAxNufsDi1o7/ZJRybUyufW5uZUhioOh
         PNk3I5MXem8Y8DioPhlupwpBa6pSnOim1rOQZV7no7CMGHhR9QqO8HYunUWTicZqL+i6
         /N3kNvvqo/Nc74wVYKnW3Vx5JGOlxov/6VOkFKJ1meNuDhRLSPVVLMMxNwTlf9lgNDCv
         DiuN2PloQuobQ1sELEBZXeuo9gq7dM1HeTmnW3+C6BC3VfEZYyAHf80s2Z11ub1Rlj1X
         7WxjTTE3mLiZsuyl4H4LiVbQsEmz9dd5orpThOYA8ev4+SP5wcLOjxo004YbLwLQhMhO
         HlAw==
X-Forwarded-Encrypted: i=1; AKwUvBxj71mZl359R6roX2yIlzv1MQ//eVbooZ2fQr2ebG4BlHmJgjj5DfaSTmEQTuC6XfWQ3YuT8mWuLj45CJ8YUd11@vger.kernel.org
X-Gm-Message-State: AFq9FYL7Rfad0I07CPZZKt3xbxw3RtScCYZ56OMvv+OLXraPUa7d4c7t
	fOKV8HgRlKZ5mgZYB7/MIdDHg0cy2BteSwKsXpyySX84tm+rsZSgAAWBaTJyIK8QE5Y9nmVqM39
	BB6zRE7rMsva4nWr7z/VqsYElsi5OtW4kCqISHUy9vg==
X-Gm-Gg: AYBFou0rpKFjZZi2R7jmdFhgYtrSbGIWyafuq9iiFIgua1kO3h6NbDQ2o02FxxZqI4H
	BMhdlY3a14clciVXBxsDp+/nqTjJd5HTTtpiBWP3Bh8dtQvywqqP0BR7X9rDJjXi9MBNGCwy3mo
	ZqVPXkEwt3Yb8njSa7U5fZGYzFXvu3ox309p5PBJxEAGjDyc8+HeeW74vQ9kvyG7ALHC1bQ0bvV
	Fu0l7Yt2SKvpV/66NBwwLiyf/v9jjQi0XwRuOYFUNPBdCxa9TqcPou9a9ZSLrWqsjbVen1bBt3e
	H5eJOdPltoLfiYZgrX4owMaaTN5l3kHuKTHFRKhau05LQArjE+flAX2q1w==
X-Received: by 2002:a05:6402:23d2:b0:6ac:b9b5:8e7a with SMTP id
 4fb4d7f45d1cf-6aff4533a3amr1051475a12.19.1791358247525; Wed, 07 Oct 2026
 00:30:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261006090327.309550-1-zong.li@sifive.com>
In-Reply-To: <20261006090327.309550-1-zong.li@sifive.com>
From: Zong Li <zong.li@sifive.com>
Date: Wed, 7 Oct 2026 15:30:35 +0800
X-Gm-Features: AclHuK_8_XtJo9ZbMrxqLyh3zITUWmdfL4HpjdH5DgCQPWZ1gzUUIYhCStDDekg
Message-ID: <CANXhq0qPxywpTmw=mAspYgfXivAyyoBN-r8iPpwYVXmJ3AmXyQ@mail.gmail.com>
Subject: Re: [PATCH v16 0/2] RISC-V IOMMU HPM support
To: tomasz.jeznach@linux.dev, joro@8bytes.org, will@kernel.org, 
	robin.murphy@arm.com, pjw@kernel.org, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, alex@ghiti.fr, mark.rutland@arm.com, 
	andrew.jones@oss.qualcomm.com, guoren@kernel.org, 
	david.laight.linux@gmail.com, zhangzhanpeng.jasper@bytedance.com, 
	yang.yicong@picoheart.com, nutty.liu@hotmail.com, iommu@lists.linux.dev, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 6, 2026 at 5:03=E2=80=AFPM Zong Li <zong.li@sifive.com> wrote:
>
> This series implements support for the RISC-V IOMMU hardware performance
> monitor.
>
> The RISC-V IOMMU PMU driver is implemented as an auxiliary device driver
> created by the parent RISC-V IOMMU driver. Therefore, the child driver
> can obtain resources and information from the parent device, such as
> the MMIO base address and IRQ number.
>
> It seems sashiko-bot is giving conflicting advice about whether to add
> a lock to ->read(). No matter if we add it or not, the sashiko-bot always
> suggests the opposite. Looking at no lock case again, sashiko-bot
> concerns about a BPF program calling bpf_perf_event_read() from NMI
> context and self-deadlocking against the IRQ handler, but that scenario
> cannot occur here:
>
>   - bpf_perf_event_read() goes through perf_event_read_local(), which
>     refuses to call ->read() unless event_cpu =3D=3D smp_processor_id()
>     (kernel/events/core.c). All events on this PMU are CPU-bound and
>     non-task-bound (->event_init() forces event->cpu =3D pmu->on_cpu and
>     rejects sampling events), so PERF_ATTACH_TASK is never set.
>   - More fundamentally, perf overflow interrupts are not NMIs on RISC-V,
>     and every pmu->lock critical section in this driver is held under
>     raw_spin_lock_irqsave(). There is no context that can interrupt them
>     and re-enter ->read().
>
> No other driver under drivers/perf/ uses a trylock or in_nmi() check in
> its ->read() callback, so dropping it also brings this driver in line
> with the rest.
>
> sashiko-bot also reported that migration calling trigger a NULL pointer
> dereference. I don't think this can happen on current mainline.
> perf_pmu_migrate_context() does not touch pmu->cpu_pmu_context unless it
> actually finds events to migrate. This used to be a real hazard: before
> commit bd2756811766 ("perf: Rewrite core context handling", v6.2-rc1)
> the first two lines were per_cpu_ptr(pmu->pmu_cpu_context, ...), which
> did dereference a pmu-owned pointer unconditionally. That is also why
> several in-tree drivers pre-seed thier ->cpu field with a real CPU number
> rather than a sentinel, and so do call perf_pmu_migrate_context() in
> this window, without any reported oops.
>
> Changed in v15:
> - Rebasd onto v7.3-rc6
> - Use devm_add_action() instead of devm_add_action_or_reset() for pmu
>   unregister. Reported by sashiko-bot
> - Move local64_set() before riscv_iommu_pmu_set_counter() in
>   set_period(). Reported by sashiko-bot
>
> Changed in v14:
> - Rebased onto v7.3-rc5
> - Support sparse counters and the different width of each counter
> - Accecpt custom event ranges
> - Verify IDT supported in event
> - Add warning message if riscv_iommu_hpm_enable is failure
> - Remove raw_spin_lock for ->read() flow
>
> Changed in v13:
> - Reorder the registration of cpuhp action
>
> Changed in v12:
> - Rebased onto v7.3-rc4
> - Add raw_spin_trylock_irqsave for ->read() flow
>
> Changed in v11:
> - Rebased onto v7.3-rc3
> - Add riscv_iommu_hpm_disaable to destroy aux dev before MSI is freed
> - Fix CPU hotplug race risks reported by sashiko-bot as follows
> - Re-validate pre_count after reading hw counter
> - Move hwc-state into atomic critical section (pmu->lock)
>
> Changed in v10:
> - Optimize hi-lo-hi by do while for hypervisor case
> - Add raw spinlock for cpu hotplug race and IRQCHIP_MOVE_DEFERRED
> - Remove irq work mechanism for IRQCHIP_MOVE_DEFERRED
>
> Changed in v9:
> - Clear PMIP in irq handler on wrong CPU for re-triggering IRQ
> - Add a lock in offline_cpu to avoid cpu hotplug race condition
>
> Changed in v8:
> - Rebased onto v7.3-rc2
> - Add irq work mechanism for IRQCHIP_MOVE_DEFERRED case
> - Filter multiple cycle event case
>
> Changed in v7:
> - Rebased onto the v7.3-rc1
> - Remove raw spinlock
> - Check CPU matching at the beginning of irq handler
> - Add PERF_HES_STOPPED check before overflow handling
>
> Changed in v6:
> - Rebased onto the latest v7.3-rc
> - Use sysfs_emit instead of cpumap_print_to_pagebuf
> - Set up on_cpu and irq affinity by cpuhp callbacks
> - Change type of on_cpu from unsigned int to int
> - Reject filter operands of cycle event in event_init
> - Check return value of counter number and  masks in probe
> - Add raw spinlock for race condition (third commit)
>
> Changed in v5:
> - Pick up suggestions from sashiko-bot as follows
> - Fix event group validation for sw event
> - Bind IRQ to aux PMU dev instead of parent IOMMU dev
> - Clear OF bit when event is NULL
> - Improve hi-lo-hi patten
> - Add back IRQF_SHARED flag due to mismatch
> - Manage cpuhp and pmu register by devre
>
> Changed in v4:
> - Rebased onto v7.3-rc
> - Use is_sampling_event() instead of accessing vairable directly
> - Rename the matching name from "iommu.pmu" to "riscv-iommu.pmu"
> - Change the naming of PMU device for avoid ":" in PCIe case
> - Add suppress_bind_attrs attribute
> - Remove IRQF_SHARED flag
> - Set irq affinity to local CPU of IOMMU
> - Allocate ID by IDA for auxiliary device
> - Pick up suggestions from sashiko-bot
>
> Changed in v3:
> - Rebased onto v7.2-rc3
> - Use hi_lo_writeq/readq to access register
> - Pick comments from sashiko-bot as follows
> - Set IRQ CPU affinity
> - Remove IRQF_ONESHOT flag when request irq
> - Adjust cycle event check by checking event_id field only
> - Fix bug for group events verificaiton
> - Fix KASAN issue about casting 32-bit variable to unsigned long pointer
> - Clear IPSR pending bit before starting counter
> - Clear OF bit in event selector register in irq handler
> - Release irq by devm instead of explicit free_irq
>
> Changed in v2:
> - Rebased onto v7.2-rc1
> - Use hi-lo-hi mechanism to read counter.
>   Suggested by Guo Ren and David Laight
>
> Changed in v1:
> - Rebased onto v6.19-rc8
> - Pick all suggestions and feedbacks from v1 series
> - Add cpu hotplug implementation to avoid race enablement
> - Move PMU-related definition from header to c file
> - Change PMU driver to auxiliary device driver
>
> Changed in RFC:
> - Rebase onto v6.13-rc7
> - Clear interrupt pending before handling interrupt
> - Fix the counter value issue caused by OF bit in the cycle counter.
> - Invoke riscv_iommu_hpm_disable() instead of riscv_iommu_pmu_uninit()
>   in riscv_iommu_remove()
>

Hi all

In the v16, sashiko-bot suggested to add a pmu->lock in ->read()
again, let me address this, and explain why I would prefer to leave it
as a documented limitation in this series rather than respin.

What I would like to push back on is the suggested fix, because every
point fix in this area has already been reviewed and rejected in an
earlier round of this series:

  - Taking pmu->lock in ->read() (which is literally the diff
suggested here) was in v7-resend. It was rejected: a BPF program
reading an IOMMU PMU event from NMI context via bpf_perf_event_read()
invokes pmu->read(), and if that NMI lands on a CPU already holding
pmu->lock in the IRQ handler or in ->add(), the read callback spins
forever.
  - raw_spin_trylock_irqsave() in ->read() was the v13 answer to that.
It was rejected in v14: on cross-CPU contention the trylock fails,
->read() returns without updating, and userspace silently gets a stale
count.
  - The current lockless form is what v15 and v16 are objecting to.

So the three obvious shapes for ->read() have each been rejected, in
each case for a valid reason. That is a strong hint that ->read() is
the wrong place to fix this: the actual root cause is that the
overflow handler may run off the bound CPU at all.

Worth noting that no PMU driver under drivers/perf/ (including all the
hisilicon ones) or arch/x86/events/intel/uncore.c takes a spinlock in
its ->read() callback -- not even on x86, which does have NMI-context
perf events. They don't need to, because they pin the overflow
interrupt to on_cpu with irq_set_affinity(), so the handler and the
perf callbacks all run on the same CPU, and ->read() is already
invoked there with interrupts disabled (smp_call_function_single()
from perf_event_read(), or the event_cpu =3D=3D smp_processor_id() check
in perf_event_read_local()). Same-CPU plus interrupts-disabled is the
entire synchronisation mechanism, and it is why the
prev_count/hardware pair cannot be observed half-updated.

RISC-V IOMMU PMU driver does the same irq_set_affinity() call, but on
IMSIC the move can be deferred, so the guarantee is weaker. Hence the
race. On the scope of the impact, to explain why I think this can
wait:
  - The consequence is confined to a reported count. prev_count and
event->count are local64_t and the cmpxchg cannot tear, so there is no
memory-safety issue, no oops, and no effect on IOMMU operation itself.
  - The window requires an affinity change to be in flight.
riscv_iommu_pmu_bind_cpu() is only called from the CPU hotplug online
and offline callbacks, so a deferred move is only pending during CPU
hotplug. In steady state the interrupt is already on on_cpu, ->read()
runs on that same CPU with interrupts disabled, and the window does
not exist. This is a transient during hotplug, not the common case.

That is a structural change to the interrupt path with several
interacting constraints, each of which has already caused a regression
in this series once. I would rather not fold it into this series at
this point, both because it deserves review on its own and because
getting it wrong again in a hurry is worse than a documented
counter-accuracy limitation during hotplug. So my proposal is: leave
the code as-is for this series, add a comment on
riscv_iommu_pmu_read() recording the limitation and why the three
obvious fixes are not used, and address it in a follow-up patchset.

Please let me know if you want me to do more for this series.
Thanks!

> Zong Li (2):
>   drivers/perf: riscv-iommu: add risc-v iommu pmu driver
>   iommu/riscv: create a auxiliary device for HPM
>
>  drivers/iommu/riscv/Kconfig      |    1 +
>  drivers/iommu/riscv/iommu-bits.h |   61 --
>  drivers/iommu/riscv/iommu.c      |   58 ++
>  drivers/iommu/riscv/iommu.h      |    4 +
>  drivers/perf/Kconfig             |   12 +
>  drivers/perf/Makefile            |    1 +
>  drivers/perf/riscv_iommu_pmu.c   | 1102 ++++++++++++++++++++++++++++++
>  7 files changed, 1178 insertions(+), 61 deletions(-)
>  create mode 100644 drivers/perf/riscv_iommu_pmu.c
>
> --
> 2.43.7
>
