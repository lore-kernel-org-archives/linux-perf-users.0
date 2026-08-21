Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E822F9C37
	for <linux-perf-users@vger.kernel.org>; Fri, 21 Aug 2026 02:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787279941; cv=none; b=j/va1HnXEG8L7RG1EWA2f1BPg3Mu3rxYCMowSyz6q6zcOAv+xPQC5PDHpnOckDQnrr4IYnibl5pf2hM5Dd1xeUsIhCyfxihdlsd3cug+KUgdjuwFeMvw2yANciMAGa8deWpeRnEQ9gsgiL6se8z+LIvCzA7BMOC3c8mpzWmw74Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787279941; c=relaxed/simple;
	bh=UCt0vQwPC2jc9+Bcb0bUDcj93+uNUIs5VJCsC2vcVqI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dsgbnAVfAzoRsZneNerZVS9yGJuFBlJWOGm6Jf7FbOyi6mUSLgLRoaYUh8oIcxVxanplllHaAp+Xq9/KoRgZ+7gSABy2xlpmJgkT4HzWNrqQofPcEs9Fxth3xqkYlAUY7YlkZ8KOTv2nU2MHV0HS34A+rgKMJd4fPrZj9cGNKYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=GA9QXeFp; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="GA9QXeFp"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2d0407aedd6so6116975ad.0
        for <linux-perf-users@vger.kernel.org>; Thu, 20 Aug 2026 19:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1787279938; x=1787884738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0XQisBlmr2bHAob1EYT/0m2uyrfjgMQQJZM+u5d629A=;
        b=GA9QXeFpLNWE7Q5D2aP0XbLUOOa1uEoZwX8wtkS96F7yCxUxOK1lREi7aG9nMUwsWO
         1TESxNZmB+/9ARU/QlWkKLt/O5tXxntX8MxMroWtgDsu/bL6AAKsTRwrbJo7tEOAJiA/
         lfE0lE8yuiRoxHvKEw7AZOMz/mZGseWO4ZsKU9BIuc4yKbzQqRt2d4KqjszuHxxQhP8+
         qiRRKQ3iv9k88h6xTNC7VSl3GJpVzha1xw1xIuX1EYYpTZElWlWWcRracDm0IKedpmd6
         peDDbvO50M7i+zy86rR4zBZkd/oWOjvGkvFkFqXyej9paAVhj2Xz6GZ9qKA7sOh7Gm3R
         vmpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787279938; x=1787884738;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0XQisBlmr2bHAob1EYT/0m2uyrfjgMQQJZM+u5d629A=;
        b=fwdFTEUo0xignHqV3AdDRQgydJbWut3liGBSJMI5z9xSfBJ0cKcCKO4ApKNrbJ0mbu
         T403uLsN+m8mjFo04eum76JoWhy2Fetr+oVLu6ou6yRgJLqlsP+5UR3b2pmGVFllemoH
         XoLzCpqozHYEeuO6ghXN/b+eKT6OK5i0UiSGwOH+IVX7LPslW6KrDkiW2dKvAxGzNSLP
         Zxrxbp0o99CPFy3ZWKydgB71mteqiDIna9GItgT+hxSc3SauSC/45yhdNfHXdD0X6igW
         sHj3a1Mj+8AqDGT7l/V2r52MI8QagfRlHav/Ral7ZapAVN5WN/egDfyDAVOeLnrufWTP
         Qrgg==
X-Forwarded-Encrypted: i=1; AHgh+RocSuOLS7NPR9kABR5ltpaZSbEO4nz1zj2ATS3BjtiFPmP1ow5hqmzJH6hIksggB8SC0RNNL348gHNvT6/9JUlR@vger.kernel.org
X-Gm-Message-State: AFuF++nNP/1ui8rcw+qekLWCMEsfJCXl0ztEe71ZtTc076TyP+JRDorn
	Q8n9SyrP8e0CUZaqUlkqVWd4iAQUsZeGaRpHp5ddkuBF8UtDZWTkxIuq7NQmEom4Kiw=
X-Gm-Gg: AR+sD10alD0n/KuJZuqRPzbnQf8OIp3Jc1663nnQpN3FD8Hx7NLPuSSbZCGINQxxWSz
	dbHnetdizG9DoPCO2784FLCHWWoIAkNvkwKAVW2mSwKXXmofIyld8h66mV+Y5YNQtYXVwiAwARy
	jy+TfxlnQSOtROBMwtK0o7X+YLId8qeRgV2bV2kEJjOHKNAg9F+VPVCe3hfGu23D+MkLBIavaKD
	yYDzCD2E1F2wFFC7mHVl2oWwKQMsHLYgnJ/sd3o8OC5rh42gEHL9fpwIJLTznmbZuqSN1z0ZCJ+
	uPcaimu3iU9Vv/IN3g5uWdEMnzHyvo8Jumme31CDPEaul8DUS1Dc304apvXsFgLGsrL22k4UH8r
	fQIQBv4AoOxYq/Szb1VY5s4wWYOnj6senC0o2sBQNj0GUcnaOFOcsypftm48mpUbzVV02BPGqEE
	IidmwTTdNIUZPmn7dSO2HhrMb8IZESBxJ1UGBjE8LEHQE7FbSWIV0jjlYs1uGAQatGoLCJU1n+
X-Received: by 2002:a17:903:22d0:b0:2d5:cb05:49d9 with SMTP id d9443c01a7336-2d64ade785fmr48981615ad.5.1787279938105;
        Thu, 20 Aug 2026 19:38:58 -0700 (PDT)
Received: from sw04.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327bf10b584sm35370427eec.16.2026.08.20.19.38.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 19:38:57 -0700 (PDT)
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
Subject: [PATCH v5 0/2] RISC-V IOMMU HPM support
Date: Thu, 20 Aug 2026 19:38:51 -0700
Message-ID: <20260821023854.2746349-1-zong.li@sifive.com>
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
 drivers/perf/riscv_iommu_pmu.c   | 758 +++++++++++++++++++++++++++++++
 6 files changed, 809 insertions(+), 61 deletions(-)
 create mode 100644 drivers/perf/riscv_iommu_pmu.c

-- 
2.43.7

