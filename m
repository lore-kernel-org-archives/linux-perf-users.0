Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3F4381E95
	for <linux-perf-users@vger.kernel.org>; Tue,  6 Oct 2026 09:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791277415; cv=none; b=BIlNZ5S4bzcpma0CzMNXWDkqsxqNRZGdP6sB6eM0FkjQ42IBr4crF3QMPPAi3ER2IQkDkyoPjJLLZoJ84i9Bfq6Vo03ujJJJ7xFJPbqBvZELbWXYYjJn93PVqBDEgUM1+lwY01+p0S4Lizvm85THxt1XDhhtt05eF3rH0h+IKD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791277415; c=relaxed/simple;
	bh=e+QKcLiLR9aQM1GsNc5nTTQt3/CAZ42yLj3LSmwDoJg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FyqmGLc3gQB3+0XvcKXdQN8xAhZsBFpMXQtF9wL0Sv4S8y5wLDu41/4bqodPTBhVrc7P39YWMCGowzYHLy9jqmJcVoygrsaTF+OIfjI7b+UIuVZFoVYphqCsWnFaBLIsepQZ2/4DBiY9sNZ+dA6Zy8vjFbFpVHe0YxoXJN/62Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=Qb5hYuzJ; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Qb5hYuzJ"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-154e9d2d979so1046020c88.1
        for <linux-perf-users@vger.kernel.org>; Tue, 06 Oct 2026 02:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1791277412; x=1791882212; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9sHs8q4lscucI4vPZxD+59Nx1PieeXin2JvWxO3G7Kw=;
        b=Qb5hYuzJvHLDrfJNHrBIs4NczhM6EH00WvERr7v1cOB2GYnHcuA5DeAuJWR/TsIYVp
         uKi799INBOgXYe0APG3lpjmoUBb0hEnD1aOyF7UT9IKnXo7BRxvYn5iTlU7TKiOpgqkh
         0LcKKGMxHvtUMgy6lQaQ6QdAPv6CLV4U9CiHVckIDzm3yTLECd4hOWShDU2LCTdlPJ2r
         IFlLxXnzgvu7f9bF/oS2jA3HRmNiXIxLf47uu1y3+5cgb/QQMKuS+OkO49q3OVRe6etv
         dS2Tr92WfsqLa3uyOeRcSrK+rwmjloRliTPiuKPO4zNetIO9i8/BjMm+SgX5c/OfWfWG
         1X2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791277412; x=1791882212;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9sHs8q4lscucI4vPZxD+59Nx1PieeXin2JvWxO3G7Kw=;
        b=Y7IGfPkiyYaD2JJOAoiz5B3mqKyFDAW2gXZxaYlmkfIaldIAJA1Dm/I+YfgE4Hh3C6
         xKRnWbdwGgynspN0+IBWuOm1yROjToQ+SfHcRluHV0/QYA6Dpj0nGj7LwXR8B3g00wOU
         22NxeD15kFsyoF5mOhs91TVvskCqz5rONua/xMS9FjB5KrYx7jK7fCKj4SarwsiGJSTj
         ozzrpOejgdShEeck20iDEzpvrn1I5wP80i9VD6SL8er7gxCCooh2n9P8RT2rtvq1vryC
         NL01zPe0ms1qCrAOUuVo0o+Fht/TO5Z6wJfQAWud2cOcud4CW5aKnWzWji1cF3A2O71c
         c6hg==
X-Forwarded-Encrypted: i=1; AKwUvBzVFLdqMKPV0q80cOjL+VNbTjGp+gyJejcajPGG1EkD0bl8080exJtx/IouNSvPkmP/QmTE7Ef6MjN0b18awrjN@vger.kernel.org
X-Gm-Message-State: AFuF++neFoml8dQxN0AnVTZmA1hewOopdgMJcNUKXzE8rzPVPYYCj35u
	AlhkNnWovVHOW0L6u8CDAx9AIkCCJrdy2/DOe40kPlfW/vHNeMxkoHgCYA3zcrfpHhU=
X-Gm-Gg: AYBFou3mIREDyZGy4NxNfUfMRqx9WR2w5X7TcMurYmQP77Jz1oh/CAIra35OGGbf6wV
	5f+wFNf4q25bdcLRXQ8cJzPXf7Qp45f2uta1fjGOBSDS7IHxAUcxN2v76pbvQVpdqRTGwyDLuI3
	7W5CTmZZO4/6DVDnCZjAxVGQErIOU0QI27sOt67Bxaby5ZN0Qo3ExnrIR4c6KQEb7xqbSF/MN+u
	z2cbtCibrAdczmoaio0EsnCaINYEmLmrUHe+KHyIXgRymkhv9ylSPAf57vB0w15pkcdzww/qgoP
	whU+hYtyfNjDplYaDWSFmwoGOwVblX9Qn8flEDobgswvgqHUmsB05h+2DawTr60NzWTHURz4AGR
	xDExEqAGLqXTyY2j4UI5yIcoJm4zf+L4hjIbjOXRHkxWT72tyLtTfXX75MP6FukXINgezWL4IJz
	Kebc8yRAnO2L5QQ/scS03TjrhAnH0s7zuHzfNI3LNHF6duCB2/LK+o8XQFGhCViqc63e3G4avCq
	SLa8qn/g0Q=
X-Received: by 2002:a05:7022:4086:b0:151:7831:e403 with SMTP id a92af1059eb24-15ec7727b08mr1026954c88.13.1791277412387;
        Tue, 06 Oct 2026 02:03:32 -0700 (PDT)
Received: from sw04.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-15d82d04c31sm5891353c88.7.2026.10.06.02.03.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 02:03:31 -0700 (PDT)
From: Zong Li <zong.li@sifive.com>
To: tomasz.jeznach@linux.dev,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	mark.rutland@arm.com,
	andrew.jones@oss.qualcomm.com,
	guoren@kernel.org,
	david.laight.linux@gmail.com,
	zhangzhanpeng.jasper@bytedance.com,
	yang.yicong@picoheart.com,
	nutty.liu@hotmail.com,
	iommu@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: Zong Li <zong.li@sifive.com>
Subject: [PATCH v16 0/2] RISC-V IOMMU HPM support
Date: Tue,  6 Oct 2026 02:03:23 -0700
Message-ID: <20261006090327.309550-1-zong.li@sifive.com>
X-Mailer: git-send-email @GIT_VERSION@
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series implements support for the RISC-V IOMMU hardware performance
monitor.

The RISC-V IOMMU PMU driver is implemented as an auxiliary device driver
created by the parent RISC-V IOMMU driver. Therefore, the child driver
can obtain resources and information from the parent device, such as
the MMIO base address and IRQ number.

It seems sashiko-bot is giving conflicting advice about whether to add
a lock to ->read(). No matter if we add it or not, the sashiko-bot always
suggests the opposite. Looking at no lock case again, sashiko-bot
concerns about a BPF program calling bpf_perf_event_read() from NMI
context and self-deadlocking against the IRQ handler, but that scenario
cannot occur here:

  - bpf_perf_event_read() goes through perf_event_read_local(), which
    refuses to call ->read() unless event_cpu == smp_processor_id()
    (kernel/events/core.c). All events on this PMU are CPU-bound and
    non-task-bound (->event_init() forces event->cpu = pmu->on_cpu and
    rejects sampling events), so PERF_ATTACH_TASK is never set.
  - More fundamentally, perf overflow interrupts are not NMIs on RISC-V,
    and every pmu->lock critical section in this driver is held under
    raw_spin_lock_irqsave(). There is no context that can interrupt them
    and re-enter ->read().

No other driver under drivers/perf/ uses a trylock or in_nmi() check in
its ->read() callback, so dropping it also brings this driver in line
with the rest.

sashiko-bot also reported that migration calling trigger a NULL pointer
dereference. I don't think this can happen on current mainline.
perf_pmu_migrate_context() does not touch pmu->cpu_pmu_context unless it
actually finds events to migrate. This used to be a real hazard: before
commit bd2756811766 ("perf: Rewrite core context handling", v6.2-rc1)
the first two lines were per_cpu_ptr(pmu->pmu_cpu_context, ...), which
did dereference a pmu-owned pointer unconditionally. That is also why
several in-tree drivers pre-seed thier ->cpu field with a real CPU number
rather than a sentinel, and so do call perf_pmu_migrate_context() in
this window, without any reported oops.

Changed in v15:
- Rebasd onto v7.3-rc6
- Use devm_add_action() instead of devm_add_action_or_reset() for pmu
  unregister. Reported by sashiko-bot
- Move local64_set() before riscv_iommu_pmu_set_counter() in
  set_period(). Reported by sashiko-bot

Changed in v14:
- Rebased onto v7.3-rc5
- Support sparse counters and the different width of each counter
- Accecpt custom event ranges
- Verify IDT supported in event
- Add warning message if riscv_iommu_hpm_enable is failure
- Remove raw_spin_lock for ->read() flow

Changed in v13:
- Reorder the registration of cpuhp action

Changed in v12:
- Rebased onto v7.3-rc4
- Add raw_spin_trylock_irqsave for ->read() flow

Changed in v11:
- Rebased onto v7.3-rc3
- Add riscv_iommu_hpm_disaable to destroy aux dev before MSI is freed
- Fix CPU hotplug race risks reported by sashiko-bot as follows
- Re-validate pre_count after reading hw counter
- Move hwc-state into atomic critical section (pmu->lock)

Changed in v10:
- Optimize hi-lo-hi by do while for hypervisor case
- Add raw spinlock for cpu hotplug race and IRQCHIP_MOVE_DEFERRED
- Remove irq work mechanism for IRQCHIP_MOVE_DEFERRED

Changed in v9:
- Clear PMIP in irq handler on wrong CPU for re-triggering IRQ
- Add a lock in offline_cpu to avoid cpu hotplug race condition

Changed in v8:
- Rebased onto v7.3-rc2
- Add irq work mechanism for IRQCHIP_MOVE_DEFERRED case
- Filter multiple cycle event case

Changed in v7:
- Rebased onto the v7.3-rc1
- Remove raw spinlock
- Check CPU matching at the beginning of irq handler
- Add PERF_HES_STOPPED check before overflow handling

Changed in v6:
- Rebased onto the latest v7.3-rc
- Use sysfs_emit instead of cpumap_print_to_pagebuf
- Set up on_cpu and irq affinity by cpuhp callbacks
- Change type of on_cpu from unsigned int to int
- Reject filter operands of cycle event in event_init
- Check return value of counter number and  masks in probe
- Add raw spinlock for race condition (third commit)

Changed in v5:
- Pick up suggestions from sashiko-bot as follows
- Fix event group validation for sw event
- Bind IRQ to aux PMU dev instead of parent IOMMU dev
- Clear OF bit when event is NULL
- Improve hi-lo-hi patten
- Add back IRQF_SHARED flag due to mismatch
- Manage cpuhp and pmu register by devre

Changed in v4:
- Rebased onto v7.3-rc
- Use is_sampling_event() instead of accessing vairable directly
- Rename the matching name from "iommu.pmu" to "riscv-iommu.pmu"
- Change the naming of PMU device for avoid ":" in PCIe case
- Add suppress_bind_attrs attribute
- Remove IRQF_SHARED flag
- Set irq affinity to local CPU of IOMMU
- Allocate ID by IDA for auxiliary device
- Pick up suggestions from sashiko-bot

Changed in v3:
- Rebased onto v7.2-rc3
- Use hi_lo_writeq/readq to access register
- Pick comments from sashiko-bot as follows
- Set IRQ CPU affinity
- Remove IRQF_ONESHOT flag when request irq
- Adjust cycle event check by checking event_id field only
- Fix bug for group events verificaiton
- Fix KASAN issue about casting 32-bit variable to unsigned long pointer
- Clear IPSR pending bit before starting counter
- Clear OF bit in event selector register in irq handler
- Release irq by devm instead of explicit free_irq

Changed in v2:
- Rebased onto v7.2-rc1
- Use hi-lo-hi mechanism to read counter.
  Suggested by Guo Ren and David Laight

Changed in v1:
- Rebased onto v6.19-rc8
- Pick all suggestions and feedbacks from v1 series
- Add cpu hotplug implementation to avoid race enablement
- Move PMU-related definition from header to c file
- Change PMU driver to auxiliary device driver

Changed in RFC:
- Rebase onto v6.13-rc7
- Clear interrupt pending before handling interrupt
- Fix the counter value issue caused by OF bit in the cycle counter.
- Invoke riscv_iommu_hpm_disable() instead of riscv_iommu_pmu_uninit()
  in riscv_iommu_remove()

Zong Li (2):
  drivers/perf: riscv-iommu: add risc-v iommu pmu driver
  iommu/riscv: create a auxiliary device for HPM

 drivers/iommu/riscv/Kconfig      |    1 +
 drivers/iommu/riscv/iommu-bits.h |   61 --
 drivers/iommu/riscv/iommu.c      |   58 ++
 drivers/iommu/riscv/iommu.h      |    4 +
 drivers/perf/Kconfig             |   12 +
 drivers/perf/Makefile            |    1 +
 drivers/perf/riscv_iommu_pmu.c   | 1102 ++++++++++++++++++++++++++++++
 7 files changed, 1178 insertions(+), 61 deletions(-)
 create mode 100644 drivers/perf/riscv_iommu_pmu.c

-- 
2.43.7

