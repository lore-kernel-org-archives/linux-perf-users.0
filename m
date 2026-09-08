Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36903330D2A
	for <linux-perf-users@vger.kernel.org>; Tue,  8 Sep 2026 02:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788833033; cv=none; b=mKo3OrOl1TjPsyBkeld+5Grf9EjCxc3Nworl8B1HWegXFL/R0SabxkN97E7mWIRZj2fpd5qg5P9qfS2rUx8Edk5atPTg99DF4hxHCQIfKV62O44GQH69pOrYNQV3FY2+VwaEL3OFtztK4FL6zAMgUd+eOOWlcfte9qVvHDw8iJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788833033; c=relaxed/simple;
	bh=hkNBN9MPkujzZCQBNuREYqDEx5xQUO+uRRcICqKbhAw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LCR4cYjgGNPPmjsc/siAWSSPOQCm19cq6P0p2DO40M4eBH3fJiosrDUAQKkNXnZFAQ85NgkUqKXVwtRy+GlQuQHFdat4vXEAtm1wqNXgg04Q+1yeLbBroVUeHxSfMuYatmTtwOMKWiinlTHb0NiF02pRn33To+GlYko9+VkONIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=WZd91LBy; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="WZd91LBy"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cc1b838f9b6so4423957a12.3
        for <linux-perf-users@vger.kernel.org>; Mon, 07 Sep 2026 19:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1788833031; x=1789437831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=E3sMw9iwve27Y2nH1ScSWttLx8rW++NN1zuHxfgNDdI=;
        b=WZd91LByEtjN8a7THteC5ms+UDXcWLZaQtMPcNnr2GbFskvoL5GaC0Js18meGe6p46
         nFZEKuJtcz38fXzPpW77mRnznusj4v45YgKWGmasJU8pxP+i1+WMXNA3rRoegceTlRrv
         a2uQoJz229d2aY2+bJswVGuUHl8PtIF6hU6/LFGdqs7ik1iGEAsNSSNJnkQdreiJk1jC
         lcmTY/ugLS+c0s8IY/BMjYxBMPoum6GGA70huPk4d9EX1MuWmk15zLIUSRakxiBFZHCX
         Jm5reUAw/CEe8n2FiXKet1zH3YNWbJWMrkxmzulfU0N1g1EPgI49QWdSJL09xwDtRYRi
         DDkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788833031; x=1789437831;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=E3sMw9iwve27Y2nH1ScSWttLx8rW++NN1zuHxfgNDdI=;
        b=I9IwlLu50soRlsur/kUTC7YdMb/g7loIYq3I6xgfgXuxX15tbQoo3BZb5OnOvjqYGo
         zsNdfRa2jm6frt6NCRbTB/IpuLQqyV7xIDhihomUnt/4rQoRh88L/i6Uu4fusAbCg6b9
         QXyMJtCF5PukA3PRhmJ+HyiM601+Dkhr5GukV2h4igRXNZEgEc6cZgxC6Yzn524avz3E
         N28OQLQ3H53b4dtyBWGFR/14vVI8fBJvLa/4ez+QP13mKujJEdfpHOjS81mDzg2tlJDu
         4kGqjz3/Oda3Ox6ycyOWx4MZOSbHaAlWJvWvFzsiAzHOsUvgT464aRez3tMkaPKiJLCE
         IPKw==
X-Forwarded-Encrypted: i=1; AKwUvBxftFkmCz6MlMvXejKfcGbKS3t1uRuQNEcVGEbKwF1cO8TX83xchweknP9aFwyY0mFLTHHnjS5w17dgUozK8F2m@vger.kernel.org
X-Gm-Message-State: AFuF++lWSf4YuWRO8feBGAssNCMYlo+wpj5XaGVyzOg88RLMcZP8QqvV
	D0JczUc5B+9454NSAec4+u4UUB47r7o7G52U1zjNRIMUk2JMLo4Epo1CD6QhJUuF3ug=
X-Gm-Gg: AYBFou3AmO+X4B2EmlET0HYjUJcZmvskbwB0W0UQ1kehWLMHDaoADLalf3/Z+L9L0jp
	lYojKrB5+nedtZn57D50dcZ6prH7P3RHMhEFTxS9qkLvVYZRqIXSzw/VV24lm0BCyeAjTJ0tW01
	XBqa/rn7XosVaYSc2tibgbM3GWMcjzzQnDOQhqxdCEJW3L5GQ1/sbs2+1V5kdKYWlmLcGMMVlzk
	Mne6XjRYApxB+4cKIiGsnu5OmEZxh4Q0U5zWbILGpRl5MFMofIMcte2tRxtzOZngbuf0CShpr6r
	Af328JRqsOeyIZ1BwmsM+YIuoMB/G8lUg6DTrvBZLp8ht6BGhizAsbtCKXaJoV1mXDDhzVyPKeO
	8Ul77Z1CmjRlSVDwvUsMlcDNz43IgLiWFIL6WQG712aPszEUjz1L8XqNeLZ1GgSBDUlFrfzbc7/
	xhCCxQz68LYuBIb/3q03mOuG0x9aY2lYb+3dOQbdUTHX4HxcCThKdJ3MsAXdGYHzc5pM6LG25Oz
	iw61UJQ+fw=
X-Received: by 2002:a17:90b:3944:b0:392:b509:b1a5 with SMTP id 98e67ed59e1d1-39b261b19d9mr43841330a91.14.1788833030494;
        Mon, 07 Sep 2026 19:03:50 -0700 (PDT)
Received: from sw04.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1434c745a09sm893671c88.7.2026.09.07.19.03.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 19:03:49 -0700 (PDT)
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
Subject: [PATCH v9 0/2] RISC-V IOMMU HPM support
Date: Mon,  7 Sep 2026 19:03:43 -0700
Message-ID: <20260908020347.1836653-1-zong.li@sifive.com>
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
 drivers/iommu/riscv/iommu.c      |   37 ++
 drivers/perf/Kconfig             |   12 +
 drivers/perf/Makefile            |    1 +
 drivers/perf/riscv_iommu_pmu.c   | 1020 ++++++++++++++++++++++++++++++
 6 files changed, 1071 insertions(+), 61 deletions(-)
 create mode 100644 drivers/perf/riscv_iommu_pmu.c

-- 
2.43.7

