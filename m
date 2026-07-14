Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E403C40BCC8
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Jul 2026 08:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784018201; cv=none; b=pR3sV4ohdWBnwaTScjpuhhJumWA+SE5XzRoEp0rk6RhrLhr6b5hrv3haXj1oxQBftEBhpqySK7reqI99YEzcpj/I9BbK4Bodr6VfWkOz8mlm1F7UUv4+vxD+NsNU22RAwPyBCmms9IUqcbowdtXU1gzKzfUesOEWc3iodAIJL8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784018201; c=relaxed/simple;
	bh=B3IgVYrO3/tbVSQm0A+Mct3fqIkcnhLDq0eqR5lzYNA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uahhz1iQaXbmHC6ueLi44yM3RPmTaWk0DhbsN3uKWpb08AmS3T/sCmUMljKnVZGHn5ifHNpxNm/layHUt/73djLvNCDIBRJ69Q8Utsw6753NG/ShF4CSwN7zhR+fH9mMHfyNtEJQjPw8Ad9+nxtAlc3aGkUpj8nBY3qhEfKOs6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=Lkc6oidG; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Lkc6oidG"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c9e30214d8fso2826478a12.3
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Jul 2026 01:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1784018189; x=1784622989; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Jn0RkqkJtLXr9ENR5GursZsBgfA51fWj50aI39fixhE=;
        b=Lkc6oidGKOBZ19yn3g3KWpiyyqb3yWNOdRT2m9a2xHvW5Arjeg3kBgA+x030VyPZsW
         4MK7pfQMTZ6d/OY827TysKfYhdFM8r18rZuVebfaqV+6xjiDiKkkWGyR9nVHCth1wVNY
         QQUP0xMMdWeTNSVs99dAaKMEcvG2/llPC5XTpWoc2KDg06s2ee62q/+U78vDPUugftzv
         CBW8wAoo2xWkvX5CvfSkbjqHG0NpACM/bMyaHPyEsELJhn+hVN/Hlt2yrG815F80F6kI
         oizKXRScqrLKtoIY+XwH9T9Fglngdf9EI1GuBjd3+qnwC4zqEUZ3E06dHVPcKdLE8DbA
         Y82w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784018189; x=1784622989;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Jn0RkqkJtLXr9ENR5GursZsBgfA51fWj50aI39fixhE=;
        b=hBHpODDfStku5bDj/KPIbqaKKJrDFRS6O5PI99bZIrY4D0817BfC4QP9QdN8eLmqM3
         ednviWGzt0CDYikvKOOpQgxsvb/R+4VrAB++EstM3A4kcA3diDkQ/rSko3/SUgSX4kLp
         ojsYwwDtIPDw4DKgYR8oAlaCB6NbTShhKQzxwliA05YFklt7WjfL7TCwdVzUayFXo6f+
         MdP4xLV49Y9oTHyI214td2xcjMG5j57p5Mf6pmEjqRS8j02eW49cJ6l2DIOXApUeNbmW
         q2FsFOP5EoHYI268l0TTSuCzA3KChdRRlgzH8tonwdWZZTP2Fxa3I3wDBtZDNQToEJad
         dxiA==
X-Forwarded-Encrypted: i=1; AHgh+RoYxjPSJrwyQDN1jga+9ovjQb4sw0hkDaK6oDMzep+Neh4pgSN9H0fSgY/LZdzfbYOC51X1K0/cJlaISMwB2pPn@vger.kernel.org
X-Gm-Message-State: AOJu0Yy72CwttnzfohL/k692w7u9FLvG1oO5UsgWLueFXojIEuC2sgAN
	7+JNWpZDPd3i2wk5KbAAC/KVWwtirvvzE6XBoliX61eVt5KLlfvS7I73Hfq6rluHTLU=
X-Gm-Gg: AfdE7cljo5yqIMCNLall8J1gWs96N2WFECNej/Vs/CTpGXJ0I578dn5JdhcRrMzta/i
	aWgJuf+BX0EfFMVXNH4nWCMUGtNZ7vEvsz7J2h5g8gA3hUgBKlW/mLk51/LpXdQfMHoNeHdtIjD
	4PalPB+wV7zRP8C6EgEdzvckDriTiAmL7lTk//70AMDdHJ4Vs/YlP6M1vFRLWZ/I92SQAnRWRtq
	O1wr00cJuh6GXktvmxkQ4AycSxEmo8cs/8AJzMjEoufbsULDE8X4EyP6Txp70pt2LBcsUKscOTF
	Ve9FfSOPIjOdDWNC9gYicul76WE7s3bV4ATFqGN1Dw3uAT4OUX7bdGTYOMyFzxhrfejfjlpDd0U
	HVV1oiEcFnhIUXh/8J+QRat4jPfp2OTwDnOH6Q1QJwa+1PYwwErYtNk2b7NBNBOF3zmkdPpEsti
	CI3uyKuLCcQQsPz55Xsd2WIRNxC3dEBJv3+Qs=
X-Received: by 2002:a05:6a21:9f17:b0:3c0:9c19:65c4 with SMTP id adf61e73a8af0-3c110aaff03mr15644136637.76.1784018188774;
        Tue, 14 Jul 2026 01:36:28 -0700 (PDT)
Received: from sw04.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-311950eb930sm55932938eec.8.2026.07.14.01.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 01:36:28 -0700 (PDT)
From: Zong Li <zong.li@sifive.com>
To: tjeznach@rivosinc.com,
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
	iommu@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: Zong Li <zong.li@sifive.com>
Subject: [PATCH v4 0/2] RISC-V IOMMU HPM support
Date: Tue, 14 Jul 2026 01:36:20 -0700
Message-ID: <20260714083625.1083606-1-zong.li@sifive.com>
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

Changed in v3:
- Rebased oto v7.2-rc3
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
 drivers/iommu/riscv/iommu.c      |  19 +
 drivers/perf/Kconfig             |  12 +
 drivers/perf/Makefile            |   1 +
 drivers/perf/riscv_iommu_pmu.c   | 722 +++++++++++++++++++++++++++++++
 6 files changed, 755 insertions(+), 61 deletions(-)
 create mode 100644 drivers/perf/riscv_iommu_pmu.c

-- 
2.43.7

