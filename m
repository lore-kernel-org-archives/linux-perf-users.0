Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2EE4400E11
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Sep 2026 10:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790244094; cv=none; b=eQeHMrmUDEIzeuPp02arDG/VOAAed9pXBrpP8I2e/bKc7FxouB/hCjxG6LCDO9efIXQxseHNSSpL65lSyvR0tLtLN3QFMMRHx94HEU8rVAZTAS+3arMqki0QNNa8nEP3rSd0ZQUs7zXvRZAwlH+D6+6vFQTL8+KmtaU/uhbLNoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790244094; c=relaxed/simple;
	bh=jodBbkvPA0Tk/y9h6SJNWm6ZLaJKUz5cCBJdy8OssNM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CN3MlPaSpOEC1wW+2L6GWq+2kuQq45M4Mz4a4NVD1GwbtV8wjk7YL08Ys0J1aXN64GWUjBsXmuUVZAYZNJCx+y+hQDlYEdqF+1vEAJ+mm8tw/frVaPc1/NpMzXL6ZDkNCaayD1VQPI0aWZKcpIjgPq2DfqW/dF4x8Mot+zgVgJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=FvqqQOxF; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="FvqqQOxF"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-33e630052ebso2172615eec.0
        for <linux-perf-users@vger.kernel.org>; Thu, 24 Sep 2026 03:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1790244070; x=1790848870; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T7LuCKXGDjbZFiX4G8+riT24rAGxjFj+z2Uy0TMvuv8=;
        b=FvqqQOxFXbIUflrdp+Cbf+y3T3yAZnLFTVQIsU9Pvii0hP7dYpTY03EB4siLhnlk+a
         12D+TKNCREFopmvNlMu05Tc8QGpcwfWooLHvSYRQVL0tPHj1ItrA5EFf3kaCVCoYo6sO
         SQKXv2nbh+2L8Vr6y7xRILa1sdwtC26EKLFRdN19W5jSLIQOV6/RDhiYAXWHzbx/b2Ca
         sdYhUf7sFqj15fEDk7f+CB7RZzKlGNBZ0MJe/e8dSzr4CqcGBqwiqO53Pe+6xkMi9gW+
         oUGhuHSy7LWikNLLe4Cb0+i7TioNusm7dsLhgpSmyWmi3E9pCV2+ZWGz8/G+h1ZOnK2i
         QHwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790244070; x=1790848870;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=T7LuCKXGDjbZFiX4G8+riT24rAGxjFj+z2Uy0TMvuv8=;
        b=1JevXotVxfI4pUsqWTXTKDEd9f6yzv+zkaygL3QMLKxBNcqj07rbqjwKnz9p59A6Kj
         KKwEJf8ugORGkWw3ebpN0Q42nNn50PoQPw3qxK8JQY4b2EAYoz+z9Z0wt2bEJy+mFP4s
         LXMhEmknJiPbAly8NOjod66XZP+1QJLzDfkyPzY/Sq8c7w+Z19BBif9kTcKnCrDP//uU
         Q0DZpnAawgJvZSzHS6rrQ7d/aCgzER3DD5qYm6sc6WC/DEDVb2AVNB749L2shT4kN0h5
         aeivdkMAioC/dchFfydLiFQmw0JTC+hd0IKnM0sBduMn75+tuI/UveIrOD0eYTUnqQHn
         NbFw==
X-Forwarded-Encrypted: i=1; AKwUvBzPB/KRNUD9V0aJZ/dYLq3f8bPpQml6l3sHymFdXfObbCHRE1JJr5qpvR52Hi9GtYftciuRV9e8hjSL11d2C+2s@vger.kernel.org
X-Gm-Message-State: AFuF++mvbyqoMY5ylqcXlpv63FsxPwQdvfI/FWOmX+JoujN9JfcvgA5y
	aElWcxTlltl2x+NlHsSlji2uixpMWb6PMTVlcMFQd9qvl11xAkgnDvyj6pM2KJoOJ2Q=
X-Gm-Gg: AYBFou3qtYP3JLT6BqU0/PjyI8M9CXKj3dgDo0F3I97Fi6qPuCpkq2hxsijxcZ5kkFI
	RDuTgXASKRND2sWlbaRt0cS81yRLtFsrU7Ef7xUAUYNDTB+3RvDsMmhwul488SQqaXgpNVfqa1P
	9gE+oV+DFZ5QHPAp4SH7cCo8zhzhD1WA7QtUWPkXvF5aWcsnJDE4mUxqX9fX+HkKHs9QFwUVt9u
	lspk3WFctU2N2dW+vhsyjL6ACvSagb2JQv1iItgzNW2SYABb8KHyGPVNY8YC/hsTdzWkX0CXht3
	JmoRJTG6BAyhZMAhkUiJ6VlGMO19V29TejbLq4irdI9ydrHPwdjly3n6M4SRqndsl1OM12Mq0wO
	1q/DHoHx6e2G/URtgYucKlmCCPhkI6WtDr4aBNmt54FyQ/elh8CvvsXaZdGkReMWC00Xd/9qHId
	EraTsHHVa46fWJLEg/gZnM6zV5eg33AFBujcqyqHLXEO7gwqhRZnF93fgrvTBwp27Hw8MxQMml1
	ih3IgBkJCA=
X-Received: by 2002:a05:693c:829b:10b0:33f:3ad7:fe5b with SMTP id 5a478bee46e88-34004592b23mr1653984eec.3.1790244069709;
        Thu, 24 Sep 2026 03:01:09 -0700 (PDT)
Received: from sw04.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e96e498f0sm11649975eec.27.2026.09.24.03.01.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 03:01:09 -0700 (PDT)
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
Subject: [PATCH v14 0/2] RISC-V IOMMU HPM support
Date: Thu, 24 Sep 2026 03:01:03 -0700
Message-ID: <20260924100106.2054127-1-zong.li@sifive.com>
X-Mailer: git-send-email @GIT_VERSION@
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series implements support for the RISC-V IOMMU hardware performance
monitor.

The RISC-V IOMMU PMU driver is implemented as an auxiliary device driver
created by the parent RISC-V IOMMU driver. Therefore, the child driver
can obtain resources and information from the parent device, such as
the MMIO base address and IRQ number.

Sashiko-bot reported that writing RISCV_IOMMU_IPSR_PMIP will trigger a
bus access fault on strict hardware implementations in v13 series.
But this follows the exact same pattern already used elsewhere in
drivers/iommu/riscv/iommu.c for the other three interrupt causes (CQ, FQ,
PQ), all of which write their own bit to this same IPSR register to clear
the pending flag.

In each of these existing call sites, the IPSR write is performed as an
explicit, separate step from clearing the underlying per-queue CSR
error/status bits (CQCSR/FQCSR/PQCSR). If IPSR were purely a read-only,
combinatorial mirror of those CSR bits, these writes would be
unnecessary — clearing the CSR would be sufficient on its own. The fact
that the driver has always written IPSR independently at every one of
these sites indicates each IPSR bit has its own write-1-to-clear latch,
not a live combinatorial output.
Given that, the PMIP write in the PMU handler is consistent with an
established, already-in-tree convention for this same register rather
than a new pattern introduced by this series.

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
 drivers/iommu/riscv/iommu.c      |   48 ++
 drivers/iommu/riscv/iommu.h      |    4 +
 drivers/perf/Kconfig             |   12 +
 drivers/perf/Makefile            |    1 +
 drivers/perf/riscv_iommu_pmu.c   | 1012 ++++++++++++++++++++++++++++++
 7 files changed, 1078 insertions(+), 61 deletions(-)
 create mode 100644 drivers/perf/riscv_iommu_pmu.c

-- 
2.43.7

