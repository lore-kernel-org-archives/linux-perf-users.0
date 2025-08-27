Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81CF22D249D
	for <linux-perf-users@vger.kernel.org>; Wed, 27 Aug 2025 10:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756289423; cv=none; b=XOJwpIbHDbdY8UvOcSMs3vQ//3xLVBi8Nnh0b6f2CZwH3ekaN0F0uMHhsu9ukydFXwOcPfXgIRxBirZhBKdkfUy2cszx4LHxzvyZhP/4jfEXtIEQf+aLvDdLOsu9Pi+pgSeOEbbDaWKiYjIMzBXpLaOe18TFAqJ0lV5VLUMYz9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756289423; c=relaxed/simple;
	bh=gT+TxytpB2pMt3fNZ4AkISCyEtC23V29tHLEOyl3WRM=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=Gtwrn37B8DVisGA3keD0M5W5bV8xRGxFhadYyPKNApiIua7nLKzq/vgOYevHioS7IxQQ43dsMJ6TDB6GE7rIVZ56+nhdg7Op5z5uAmorxZTtFLDpbFVNJ3udPFszFUFlb+3RyRFDvGQ/7JRekHXDINvG5i5PwnMnQ8rLftWaO3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Od87xW4p; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Od87xW4p"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3253f0c8788so5540383a91.0
        for <linux-perf-users@vger.kernel.org>; Wed, 27 Aug 2025 03:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1756289421; x=1756894221; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=fBu9j6IaTs08Cy0/naQSIbDYy/Ds97IIeYDx16xjQz0=;
        b=Od87xW4p84E66eplDqlWSgtDuMdhypyVAcfmgDXMXG/9NjbMtOpPtdaMTE5xlhSYiR
         +fzsPSydkZfCbDiCTW2KhYqyWzgSqTVtBvticp9LKUBEbyBOkvydmYKp2w2bmkfB6WGd
         5+EF/aA3iekARLDWRlELluCy3G2i/QoIHG/dI14EQNdViLtTOHhTz7HvSp8rerulQYqN
         PK8DECUh3kGWaWuZ6VtOPApUa6LP/YHFqqV0AbpULorW/j+HVWb4dJsWUwNEryWJRyJb
         LVAYCEpaztoNbwBZn2HsjIErVhw01/UnHGckkgqfreTA86vvelE8JQmn8oLis/k8WPHC
         d3lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756289421; x=1756894221;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fBu9j6IaTs08Cy0/naQSIbDYy/Ds97IIeYDx16xjQz0=;
        b=Nb4984EH6bFkGJHVMt4cPjDCismjn3E8QS4Df27g0f5it5WgAfqrczaFarZUyS/On4
         z/MGG/Lx+2Hfihrh9qBpXPS3x1q8FChDc+8PecRxakqOrcGe7cjhRKaQVlLYaquPIGUx
         8kWQ5ltIRthik66iLyQJrKpcVvJC4YSUTpSE8btRfhhy0BoYUm8GiaVVhfDO5JIPr+22
         A1uBjD1V18j02NHjZCnml2CczTgaoXWIO2WeIoI0nzoGu+M/jAJ+LqAEZbbpfuJirezg
         vIY3jci2oYXEYDUrolH7eXr42nfVUSnylp9i8c0V/bW5jdg/PBGVNf/+5ETWRHwM/Qwc
         U1zg==
X-Forwarded-Encrypted: i=1; AJvYcCVATiq1G1XgnPJesqZ2Q+oS7qESrq48JbtU4HgrJzxdKf2YrTyjWvma/uPYvEyklWiovpGYpNZNR/8B6ov1Jxg1@vger.kernel.org
X-Gm-Message-State: AOJu0YxaHxPLtLglTwiGJVVP0+t6sgw1QmVPuzeM9X0cHY+wllT3LOHF
	fyunWG+wUfaFGUu6lfFoBea7xWJBME2XfYedadHpKmpiXAbxUW4/X9V0fWISJTaRlSU=
X-Gm-Gg: ASbGncs4LS/hvYa9EOjBHo4qGMvdbs8FlllX7RDOnULtWVWkZ8VCBnOh3f/3l1X53YH
	+PVcc2tsHVOQmMxfpsiBTJexNUKt8wQAJealHn43gPDNqGRWf+KfQOR20FT7bdlKIEPLNlfqdWQ
	mmmZGupbq5oxb8Ik9qwxXJzAviAhNhw0dgDreDZYu9BvWY2WKFdDqj2IquW1W6v8jyLFscPIFkc
	69ltlSZoIdPlbtd/Y8LbnDo06QpLjze9HcNmPM6kPqdUnlnwf0IHtcdzcd3T98AdQ9WVeDxub+v
	PmGmnWTBAvUj8X98BOhvXquilr886b1MMU8NJx1RUP119So7QxmtmybsarDMDn8VLXZZ2gVnSV1
	hcWj2Te4mKnO/zlmbKMsb1zJZvnb4CA9RG3jNiNRem6cRbfH9ollBfh1A4ecvr9zP6kAQjCoN0A
	==
X-Google-Smtp-Source: AGHT+IE247z+6IbaCQjI/JRybcT+dCJSxuMKhLrRKRCY3vXFrDNcNNm2FeQS/0dKWf+BL5aq7dNmLQ==
X-Received: by 2002:a17:90b:538b:b0:325:cce7:f65b with SMTP id 98e67ed59e1d1-325cce7f86emr11644260a91.29.1756289420620;
        Wed, 27 Aug 2025 03:10:20 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([139.177.225.229])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-770401eb20dsm12813462b3a.79.2025.08.27.03.10.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 27 Aug 2025 03:10:20 -0700 (PDT)
From: Yunhui Cui <cuiyunhui@bytedance.com>
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	atish.patra@linux.dev,
	anup@brainfault.org,
	will@kernel.org,
	mark.rutland@arm.com,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	catalin.marinas@arm.com,
	masahiroy@kernel.org,
	suzuki.poulose@arm.com,
	cuiyunhui@bytedance.com,
	maz@kernel.org,
	zhanjie9@hisilicon.com,
	yangyicong@hisilicon.com,
	dianders@chromium.org,
	mingo@kernel.org,
	lihuafei1@huawei.com,
	akpm@linux-foundation.org,
	jpoimboe@kernel.org,
	rppt@kernel.org,
	kees@kernel.org,
	thomas.weissschuh@linutronix.de
Subject: [PATCH 0/2] Add HARDLOCKUP_DETECTOR_PERF for riscv 
Date: Wed, 27 Aug 2025 18:09:57 +0800
Message-Id: <20250827100959.83023-1-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset is mainly based on RISCV_SSE, and the enabling of the
hardlockup perf feature depends on RISCV_PMU_SSE.
Link: https://lore.kernel.org/all/20250808153901.2477005-1-cleger@rivosinc.com/
patch[1]: Move watchdog_hld.c to kernel/ to facilitate reuse by RISC-V.
patch[2]: Add Kconfig selections for RISC-V.

Yunhui Cui (2):
  watchdog: refactor watchdog_hld functionality
  riscv: add HARDLOCKUP_DETECTOR_PERF support

 arch/arm64/kernel/Makefile                   | 1 -
 arch/riscv/Kconfig                           | 3 +++
 drivers/perf/arm_pmu.c                       | 2 +-
 drivers/perf/riscv_pmu_sbi.c                 | 8 ++++++++
 include/linux/nmi.h                          | 1 +
 include/linux/perf/arm_pmu.h                 | 2 --
 kernel/Makefile                              | 2 +-
 {arch/arm64/kernel => kernel}/watchdog_hld.c | 8 ++++++--
 8 files changed, 20 insertions(+), 7 deletions(-)
 rename {arch/arm64/kernel => kernel}/watchdog_hld.c (97%)

-- 
2.39.5

