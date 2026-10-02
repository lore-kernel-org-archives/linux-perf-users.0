Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6913F23D0
	for <linux-perf-users@vger.kernel.org>; Fri,  2 Oct 2026 06:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790922800; cv=none; b=ff+SNr2sySE8ZMOlJ+hkgoDj9jIisOXZi4Sil17tsVmHnON44Z2kUK7iymDp+HtJqfVFh6mg3b6DrsTEn72NNRwWGpU5XL4HkwMki4QDcxZnczw7aZmmI+G0+/hZLmtsQH3Rx2W/TpUpsirZaERGhNcCzfNI+hqPjbmtc15tMZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790922800; c=relaxed/simple;
	bh=FCZ6sIAIFfPswMpdAnsl3++lstKHkX6vjPLQMQ5mWXM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cNjvIC6tHiuDgQ77t1lo6fstOtsUfjk2EWPkyok9VyTCz5XoWYxudHalsnRGusgdRSfXKp0nS8PaJZlwUXrFcGFgsw3wb42dtO4rKHLzcsxH8bpK3OP02DP8YkJhLsX+d/7wxxnP5gxOgh9FgsfeCQfBB6+VXCN3al60DpxdyV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=RJnu3hL0; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="RJnu3hL0"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-34c4a0868b6so1449633eec.0
        for <linux-perf-users@vger.kernel.org>; Thu, 01 Oct 2026 23:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1790922798; x=1791527598; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=d7cgR6ZneSf8y5V7zAIslHSi/tYxEvm4mPs702VSwro=;
        b=RJnu3hL0TG7nr5MeLbO+T3r4Xe/ui3MprWYPS2AWAdTULW3PADYLMjMrC6LRJiFWcq
         K9MzczyXPPPa8LsydmJ3VmWeDLewwbPLiZCjube9INExHeZPQOz4zLKzNCvtdRDEGFMe
         mmqn5LLmV/63fVokt5Lyg2l62yHCEeDqfKtPjFYm0XjR/1T1hKAEJQJLzxShvOWtE6kI
         5c5mxLKwrT+91wB4SDTZ9d3FNCBuLnKaiRZhhkpzCQK6lpD7qf31BwXDni1Ej9OPjD4L
         lm/RjImUpgfyipy124mu69Dm+AewjD4V8Ue7SITZsm2uOmK5+GbELSTGKPiMWXzD+xmC
         JKCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790922798; x=1791527598;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=d7cgR6ZneSf8y5V7zAIslHSi/tYxEvm4mPs702VSwro=;
        b=OjZrEB25omsnPxZUs8u+CRRKmjg/hcVC+QX8uadWNHX/K0GVCnKHh2R2vo3n4DC4TR
         NoJHM/tPkIGuu5rSxE2e1QMI+ksAGK4CB9xuly/dDqfHdCGwcIptupSzshd5kmY79uR5
         iv976Fejct62Hj3Jmvr+NmW0TzHMFNHkjjdGBu9SzklCGCIxWMkx+ksjsjW+SazGZ19o
         yG5uc5RLknSqwnC/50RBNIVL/+V4vZNQu+O/eIgnz2OK0/4j3WyYSXU9y6T5QKD7o/mI
         PFti904hGSJdDXyQj1TjnxSVLJTy8bde5tpOdnAswMvLl25YW5yUa0IC+5gQ0g/XtZs2
         7MKw==
X-Forwarded-Encrypted: i=1; AKwUvBx8S6hFF9z7UViQ6jc3iUHHbKF6tlwHRryngX0AM7GJJtZA8ABEZpiRYhI1vmEMyRYpippa2E/DBaOXz49pioFj@vger.kernel.org
X-Gm-Message-State: AFuF++mN5P153e45B5poxlPq5efhZcAjGTmrVL5qnGIIrYGJCJG6OA+3
	2rdr/ZfdRszwL3wQimPmbgdxQzCExYUzOJMD7YxPa6QMoMdaCt+5kDubIIrdBru9MDc=
X-Gm-Gg: AYBFou3JQBaedYkvxD0MHPAjrTWk34oYNnW6C6xPN6T8V6QFrkFuKz8N0VdCI7lAKrT
	SD0MAlR8PDuOoK9Q6JFNca5e0VWZXaSl6h/hCKYLCD/lRnatJKWKkFBUmCI2YENvNQvBOKAzvDM
	qHAU73F6c5NFpVhBcRSFlkjRX/efoIPT6wdkkpucAzDRQNDKXUpOE42F5zJljh6KUm72SeSzjHG
	25d3gufsPUCu6yE9tjhNWbNfM4gsXjVyUiPxez/fxpUgpG+yNlnqL6XpQYmWBavWV/NvvJMUwbL
	9bk1wtskKz039/dxQzzcyejZ9DLwUPooaaGzqvvFYiAT6kTSHzwENf5R+RbFGVPBLJCWtng1iu4
	L+MN3Dy0VDDHNG4ujPwbZhXgxQ+sTA5xlemsiYkkMpVmN1/sUIPKhLJhXvw9F8gV+HKwPlHuxjm
	kvXrrvsFFHd0hCK9HPY+bFqRlx/AXs4Tsd6282110rdzftmiR+8tWo5LaypNGhJB78aXfYOupaz
	cUzTgjpGH8=
X-Received: by 2002:a05:7022:7e82:b0:149:f2b3:efcb with SMTP id a92af1059eb24-14dd10af1famr6118991c88.14.1790922797740;
        Thu, 01 Oct 2026 23:33:17 -0700 (PDT)
Received: from sw04.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14f45fedd43sm6315754c88.4.2026.10.01.23.33.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 23:33:17 -0700 (PDT)
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
Subject: [PATCH v15 0/2] RISC-V IOMMU HPM support
Date: Thu,  1 Oct 2026 23:33:10 -0700
Message-ID: <20261002063315.1535817-1-zong.li@sifive.com>
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

Thank Joreg for reporting some differences with the spec.
One issue is that the spec does not say if the counters must be
continuous, or if the mask must be the same for all counters.
Since non-continuous counters and different widths are very rare, the
original driver assumed that all counters were continuous and had the
same width. However, this does not follow the spec. I also fixed this
problem in this version

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
 drivers/perf/riscv_iommu_pmu.c   | 1081 ++++++++++++++++++++++++++++++
 7 files changed, 1157 insertions(+), 61 deletions(-)
 create mode 100644 drivers/perf/riscv_iommu_pmu.c

-- 
2.43.7

