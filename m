Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7B734C134
	for <linux-perf-users@vger.kernel.org>; Mon, 24 Aug 2026 02:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787538040; cv=none; b=iXTpO2J9SJFlx5Bw/9OCbeLFhmTx6VFhI8Odwgpam8+GfxkGkVeUTHwszR04fl8tQDMeSOkENqqzMwfTvZy2PaOZskMWF92d3XgHvalXY8XfQ5d2jrhHaJIRb3MR4cDp8zfa2Pc4DM47ns6E/g+PgOyjYrBSdKmNtlTOTQXmvSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787538040; c=relaxed/simple;
	bh=USG8kUY4fnqDkyeEZeBeSM+PImoZzodWQxrfboaUfXM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D6E9H1gdL4Z5u1SZ6w7dsRk7AUDnYGVf73xMtca+mL89QNXcZINH+BMnqHHO3IwOvR/JqCz4pX8MtWj6OknNNVtddWHyDgFq5Um9xt4ZfXr7zMOHqguBCAtqDrkUcW8LCIr6sZzWD33qUxe8mrOg8A0U6egfLqwX6IVaX1SiQeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=SsR4oZsD; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="SsR4oZsD"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-38e7109321dso1954725a91.3
        for <linux-perf-users@vger.kernel.org>; Sun, 23 Aug 2026 19:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1787538037; x=1788142837; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EM7lljqiPKnFmEvR8seE5KmzQ2mD6+J09RR+VPh3RxA=;
        b=SsR4oZsDsfnF7mNtnLIxHA5R5S+fXB2De8dOlHTvkI4msq8shDCAqxzSKOgC8vMEUd
         o+YRV8oNlayyzG6m3S0wtYPDGS4WAnqikaySAKZrThXOzXlP7A1TvotAUECrlgtGsqY2
         /mASDALl9E/FYDkU6V09CsBugcsW8EQjsDlLd4dSNVbjXA+sgWin/FmFTv+xZcnXNo+r
         BTqpDJ0ixIuKBFUQzvapexMtdykmkOKo0Sm0CMj20vwZY76q4r0VD8q7n/IDugLY5VDi
         v7qUHblu/Y2GZPLuN4BZDGRvf1OFd68S8Bv3cc537+MhgG4ABgqt2r2V8bEjKBrO5mDL
         NVrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787538037; x=1788142837;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EM7lljqiPKnFmEvR8seE5KmzQ2mD6+J09RR+VPh3RxA=;
        b=QRylnXoXB2ORoJietjN1RErrniQnS+KJdRAEg0QGURNmFYgASs/lA99oQtldQt22vB
         OjP/xhVQVwSrXdt9PKABRxihkfB2+1cftIBU1jdXwA7T6uegCvR/+OeGxAOWHewZ7kLd
         Nn2gVpqEbnuwJAKB4WAO7aM1CHCK7ghkIQlg6AkH7/pTXmEtoFAGN5yp/e+aPcRi/9Xm
         6QKunnslgHDXO5znCH7Qkv+Lvu2RFo4lU/1IP1yLFisipu4Yba2hSMSZawk/xpuD/+ir
         daVngf2sEexDGA8kONNXNeiaxul65nJUhoPCXixMjiWZbnMzHdVkP11b3BGhKevrR8lq
         4nDg==
X-Forwarded-Encrypted: i=1; AHgh+RqPLp5aXScltVRqFfxs5MuKsP56QPV781hIyTN+0zCxpRs4vArKriV/JIJxlD3Mx3kw1IspayA4MSqa53/KMJHm@vger.kernel.org
X-Gm-Message-State: AFuF++mGAGxePiqiee2dYby0KfFbhR+Www8P5kLKRbt9aGQopTiBiWBS
	Gjzm/rvyH1j+tfG4ibrN08OihuBUinXTeuYoFeWE+VsRDYhVtc8DuhLA/F138RTOejY=
X-Gm-Gg: AR+sD12ySvZQmbPCCeXL2fgMNL2Dzk57maM5x01LvIf3sBs7WHdYFc/wPNQ9VYgow/1
	hL7l2FKzNVgWgbiFKMCXZmkDF8dMF1x53I8YFre5XOFywp2bQ8XQS5oXskgBFRNFmM7I8XCp4QG
	YVBjnWj1Q5IbhtKeK5KiUAolQKFmLBGtckwnh9CxTPOcH4hBYcFsf67yb0IlayImv3XxhEx8kZi
	7YL9Ny8fR17Usapk+BMeNW2V+24T02QInuKhcxvuXcFXHVIOKxxs7xKuLTaS/8qzkSpzbKx2Bse
	NtWN3b9cjy7UoSf4WF8VjIDIKmqo2/QRYeam+QGerKUmezFYg75CdDHkwXC8D+7/2aGiEEm7Qwt
	/7B5L3NJg9OKNE1Z5Pg4oUG9ixfTi7A5wD5CCSmq2xzwqMzMvmBp8s1BNpN4IGTfQUMFiL4dbXL
	RZOgRZSH21RwxJLxwsC6626e5QcDm0fxTN3iZ+H6FaTyyQflxYKNsS8dv0ukYeG2ky0iO8HS2I
X-Received: by 2002:a17:90b:53c3:b0:38e:5c6:4db9 with SMTP id 98e67ed59e1d1-395c39cbc42mr41491359a91.11.1787538037613;
        Sun, 23 Aug 2026 19:20:37 -0700 (PDT)
Received: from sw04.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14186183c0esm31175869c88.12.2026.08.23.19.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 19:20:37 -0700 (PDT)
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
	iommu@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: Zong Li <zong.li@sifive.com>
Subject: [PATCH v6 0/2] RISC-V IOMMU HPM support
Date: Sun, 23 Aug 2026 19:20:27 -0700
Message-ID: <20260824022034.3916570-1-zong.li@sifive.com>
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

 drivers/iommu/riscv/Kconfig      |   1 +
 drivers/iommu/riscv/iommu-bits.h |  61 ---
 drivers/iommu/riscv/iommu.c      |  37 ++
 drivers/perf/Kconfig             |  12 +
 drivers/perf/Makefile            |   1 +
 drivers/perf/riscv_iommu_pmu.c   | 813 +++++++++++++++++++++++++++++++
 6 files changed, 864 insertions(+), 61 deletions(-)
 create mode 100644 drivers/perf/riscv_iommu_pmu.c

-- 
2.43.7

