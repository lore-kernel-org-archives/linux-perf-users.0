Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254AD41DE02
	for <linux-perf-users@vger.kernel.org>; Fri, 11 Sep 2026 06:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789108257; cv=none; b=uBi975/i/+NgHO+fWe1MQhabxsjLKEDLR9IZrVZ2xcLAYVg+l40n0Llai0c26WOgDKEftdx59D7YKgkZNE4o27359py02q3QHMC6s5X8GbPOyaLjiPcY5O19J3PYNPMF7Afd3NiIOSGftMaxBHxYQIor/80mGNhoYNU32Ix/pd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789108257; c=relaxed/simple;
	bh=RQnl9JsCyLlas2wqU9XhaI0GPuGEC5V7ikoHzldSR9o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mK1SjDj3hJlCSqJGxUkyMkMdXWCQ9EyjuaO6JoLOvdwlaurswIn5MFbXtzR7PDpWRYlYPYyqq7YhxWMrShpagSS+l+DL93seaFMnJ/poqvmMN1Ro5anwCsBoUzquLhZKRbSC7oZ68eUNv+XgVfFLKIiB1Ka6W8MHmYeIRumvvgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=MUOv3HWo; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="MUOv3HWo"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cbedf433a99so688213a12.2
        for <linux-perf-users@vger.kernel.org>; Thu, 10 Sep 2026 23:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1789108246; x=1789713046; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=m6fEOf/IOiBj0LrijFeZ/8VfHCADIoPG1CxdjXEq88Q=;
        b=MUOv3HWoM9Jnz9QSWJXzcOyVWu70rkCdxUpQ3tYnobnCL4Rw/+9KtBoR6WouJxu/GT
         kZT8h9w+V6ARoD1KpyM8/1lhMMLO1t9p8rHkZ8cBXUoWPF6QVmgT4uAzKpdpa/PtgOpJ
         X8NYTNkHFHjBhKFMa4wHtxxMNqWVpxndGZqMLgKdJQtF97PYV7f5Ha405VMqCP2Yc45M
         5A+RWWk/0u1CUEGvSVfMc2GB5TU+i7F0Wir8g8kjxt591JF4g/CYmRkW4QEKbVRSmhJY
         ARLnZTcVU7n6icfpEgZ/bbdaqNTdb5R/mcfJWHpA84Kuz6FadBvsEBnySOQnT5Pbwrob
         P+lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789108246; x=1789713046;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=m6fEOf/IOiBj0LrijFeZ/8VfHCADIoPG1CxdjXEq88Q=;
        b=MSDolYtgnRopi4wHY6+6g75TlPBkluDzEnu9sIUMwQvSi6pfz111sbqzduE5W1U8Wu
         uq5oi56i6vnBfVxnHjMr5dkp960H9H3AY6YITuRtk8k1w2U2ICsHUCkyrolhJis6LiON
         /UgieyKSr0h8yiqHU2idIxYoH4OIOqGi4eLpYkizWdNazgJ7Rl+WVwrSbKOTeIVx2N+o
         NQ6fGBaXTQagAWCwMRRKeaaIsgwaPpDGbPYY3MPvtvVfV57sVbdknL30QFCNe+Sca74y
         fBRzdMiHho5ZRujlr1W08JW8POrINfjlFFRG69p8AifHLE9NwDQq7yEfrryF9Zj9+zQh
         sS0g==
X-Forwarded-Encrypted: i=1; AKwUvBzJqILWQnwkMfK9Qg7ZJiKUKEx7Jc74mN/ccOwM3fM2gt/EHZmAw5X+VscgDwDNRVOTiC8lhYIL6QLXlXdV05qt@vger.kernel.org
X-Gm-Message-State: AFuF++mK4d5D04bBb8tv4oQJD5MdSg7Z5BXgCHu/xtvsMhR4NWDdgGqq
	nZI2hNRGtu7ZHuqwq5YBjK+YZsYoW1Th4TkJUq5/aACVFPFra3w3MdVeRjS+lZTT5hc=
X-Gm-Gg: AYBFou1s56SRTH7RwVpvVR3dzbIO4CTSLkzVAMpoDE+rk5JJCC/0gMtjnWmzTtfmxy0
	ijQnyuQglJTHtsycTa4Jbn95c6JE1HKILvZ34PoEp79STRr+/dJh1XIGB++4EhazjwRkNQ0ezjr
	e1mXridx+M+2us5TSRqgjmhe3HH5qgshovG3wQPh1GcfOp76VSNU4ywho8xtqu3DeEXoJKfGdfR
	QzwqyY/XmpnQ2WVxeNVxHMOmUfzbkKcfFvjxJPKGoKAsyQKqFe+DY9zKy+fDu/cfDR4v+iFVkJe
	GockjdXeuHxSQD6s/KkCo28Ohsg1CFGfHM7c8FPgB7oM260ZudCgEB2TxcH+XWvoobWMi27dWJN
	6QxpvUWEDyjxzVPOJkgOXAhB/6CuPyWYKuoTG5m/cZydPovV2cWq+Q3sSlOHIFpr9WaI10R8+KR
	ZT3SmNnER+eCD7ahLphGt4fbDyvcjskosyoQ5B9oxss30YjZHtOIhtdgLe8t9kSaJddE8gyYK5m
	cv+p12FdSuvHTmVQLo2Aw==
X-Received: by 2002:a17:90b:1650:b0:398:d8eb:cb2a with SMTP id 98e67ed59e1d1-39d9c34266dmr4534758a91.23.1789108245853;
        Thu, 10 Sep 2026 23:30:45 -0700 (PDT)
Received: from sw04.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33baf0ea9a1sm331152eec.8.2026.09.10.23.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 23:30:45 -0700 (PDT)
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
Subject: [PATCH v10 0/2] RISC-V IOMMU HPM support
Date: Thu, 10 Sep 2026 23:30:40 -0700
Message-ID: <20260911063043.916844-1-zong.li@sifive.com>
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
 drivers/iommu/riscv/iommu.c      |   37 ++
 drivers/perf/Kconfig             |   12 +
 drivers/perf/Makefile            |    1 +
 drivers/perf/riscv_iommu_pmu.c   | 1042 ++++++++++++++++++++++++++++++
 6 files changed, 1093 insertions(+), 61 deletions(-)
 create mode 100644 drivers/perf/riscv_iommu_pmu.c

-- 
2.43.7

