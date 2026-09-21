Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1DF44F546
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Sep 2026 08:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789978559; cv=none; b=BNSc/ljOag0JTsypX/IjY1Zk2DM2NOZ7ukPkM3JT7MqijzbJWouCc/lVfuXijN4MUFhZ0MPyQQvZPXNy/l1ZWyYrFdSELsEuc+ClrnIe5kcDldUCTT7f0WhjfIRQQ74hrcDpa3BTh/sEAgXr9gX2spU62GxXXqNodC9SZ+7Ig2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789978559; c=relaxed/simple;
	bh=xBIf3Pr0YmX+pDdZctFWoUSgPyNr7jHiFRAl3YR/qso=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BVddnQhdeZAXz9dSkD9jDTVcqjmeOuwTKE+C10KgvgCzQfEPOk5D70+iUtB6r28ZhOjcz6q/NmF2zfk0YJeQY1Q2bpl0K/2bvTWlw+WzSua6/VmP+esOBvvi8rT/3whXvWIWX5II8/aQKmkq83rYgIVVWbNUJeIg/k2ea9DOq8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=FWroJM3O; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="FWroJM3O"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2dd68a16955so34611395ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 21 Sep 2026 01:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1789978557; x=1790583357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=txdK8zZNvr3IeIOXJRWIc2g69quLivVkGnF05uJ2f70=;
        b=FWroJM3ODb1+QfDaaO4G700Ps+cBNVPE5yT9G5SVvhg2QQAVs/yjsZxlkVPCC0ThyO
         0GKLhoDn9ndjjmnfL1KvVpunwc7ttosHv7GK956yfwSRll/B3hzlFHcixL+yVqR3LQCB
         k5c0clBjTxv4hlpYlDtNcH6Tr3Lf9Thxlc5PORBMsvkvtifjAsIWSwHkv61S8OY6Jkdu
         A8Ap9AzVAU2qH7rk3RlgH+oxopvNiw4zYldj4cIL0+I2533xlXblSjrBTPiapwsaUpHg
         Kfk0CnAn7yGm57blsWXGEx5WGOVGxz9nXbuEGqysVJtk0l2zYNWP+Nu1HVjmIFYgRKKm
         Ezxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789978557; x=1790583357;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=txdK8zZNvr3IeIOXJRWIc2g69quLivVkGnF05uJ2f70=;
        b=FJLll/9j6eZw7N22HY199H2G83c37z+GByEx+wy4nPcQ3vcKkCEbLELy4shEWRpdZD
         nUvQEItGx/32XHn0iuuWUb9Vnqn3dQ+b1UnX+jbvgYZcw87bf+eSj1dqDdgYf/zlOqmy
         oXS0oOWORXa/blMprBomo1JohnNdaOCYXS1BfFLDN1clF3wzsQcGuCOUqXRU+Gtz/srH
         7Ky2PBcz8t4XLuh/4lfqPPJHkIHmS9C/7zqGcHOsk7AaBr1DQpzyUxQ+roeJjUIikfZy
         yhMwOhPFMTIQ9uEhzIhOhNXF+bxFMkF8VtnC0+iTKGT8iSegIlq/J/Orobh+pT+UE2s1
         n6gw==
X-Forwarded-Encrypted: i=1; AKwUvBwyAVy3hzvFy3yi8fheoLNg23iYXeSkjS4BMuA3P3jk4StQQVNb72aLuweE1mf6ulYBII3fwP0pTA1yQGtBsNOj@vger.kernel.org
X-Gm-Message-State: AFuF++mFnBW1mD6Lwn/UmnAKNxBo1PmuHqvLM/N5SVr/BkD5uXiRheXF
	OgVJmuqmu+IQhfHMSaSihbxs2Fn7JVdxOCdONmyR+xfpFPaGaReRM1xNkS6nK5ZfG24=
X-Gm-Gg: AYBFou3asjk7fFi0ipT0pWWtnNZaLdN09yBHNNctXLF4mOGfZBskPyQdQ4/epijY6yc
	9vsnfDl4HC8tXH/E2a4t/HM/q+/nKaAuoBCOufbTTCn+Q9PIRfgzQ8LrxjklsOCX18JjcF72YRR
	JtqvRGiEqfCmOgtTgu6/R0KSvxQ6UAR7mePR++i7+mHpDXOzpAqTSsbgjuxp3/mwCW5GbUDbHFT
	XMxKIryWFx4+9iMkt+sqIYQjP4/e+4r9+HjzGNp1F7MXLVIBYrc/XhZOcKlInzpOZI/aFVB1PWc
	+c1zRp7vD3nOxx/gO/uXlHkFbZCusRP2CNeLii773eDCyhowYDgK7ElKt7vx9v0X8e3PV45YJQl
	0cdc/SQV1uPZmiOcNohZKZCdmWtyMxE5fxx66395vEIJf4niD3iHZQR0ryvxBzga5PqNSd3QQUS
	QuhZLTSiG1Fte0qIaoliwzeHfAH/ldwuF32htBpcG+ERor1xMQOnGT1M7M2pFxapqAUsKOSPuX6
	rGIpqVdGjM=
X-Received: by 2002:a17:902:cf09:b0:2db:3734:cfa4 with SMTP id d9443c01a7336-2dd9c6b9151mr156850515ad.5.1789978557003;
        Mon, 21 Sep 2026 01:15:57 -0700 (PDT)
Received: from sw04.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33c32f16f9csm17151344eec.2.2026.09.21.01.15.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 01:15:56 -0700 (PDT)
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
Subject: [PATCH v13 0/2] RISC-V IOMMU HPM support
Date: Mon, 21 Sep 2026 01:15:41 -0700
Message-ID: <20260921081544.1797510-1-zong.li@sifive.com>
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
 drivers/perf/riscv_iommu_pmu.c   | 1007 ++++++++++++++++++++++++++++++
 7 files changed, 1073 insertions(+), 61 deletions(-)
 create mode 100644 drivers/perf/riscv_iommu_pmu.c

-- 
2.43.7

