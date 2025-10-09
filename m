Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849A11E8320
	for <linux-perf-users@vger.kernel.org>; Thu,  9 Oct 2025 03:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759980565; cv=none; b=eS7SJhcmKIiETKZON5S7H9wAE+FvBIMGsLbp0bTwLZgoblIgk9oXoPwJI3TkG18TctQRgPgdJ/HiidGdkv9nNQSQGXiRzUw6ApNd+JAS/YsHKxxSSydN/FMICHz/xopLXqL0L4uXQu4f/iGXceivhHt//9Z12jsQZks9o8WrMpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759980565; c=relaxed/simple;
	bh=hIKKBK0byVJlVWExQ0gRjim96DiErgcAqyz29wmTGuo=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=cQn/KVvJDpcmBKcQR3eLBOEWf9aHriB6Lu2b3oz9UG5kfPIcEZ7m/tjZGWr2Sl5wZHq7surePByGl8TP7vOiAbhuX+XAztL/UVGpiRVFTBL2Yc5l04FTFPrLG4frpx3yxCRPU5nmkSk8tiu/BGhwVyGtJBz35ztcuustCWNlp6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=M7SGv41D; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="M7SGv41D"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7835321bc98so508285b3a.2
        for <linux-perf-users@vger.kernel.org>; Wed, 08 Oct 2025 20:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1759980563; x=1760585363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=JpBrYi8OaSK64ZsI47g3j0U1q75t5NwItcJ4jghSQ6k=;
        b=M7SGv41DZe6vlJSPDHpRy1hSqavSihblQlkwTqvL9oXAHL3qr6b1ut5YYmfJwOXoMq
         NWem4mcf8o1bxKQZA3mNSjTxy+0cgv91lGoIq9b+alnKNdT7346md6u61JgQm02OdFtk
         OB2A+aVgcDhfX8nxMilsr3GsATxKNPbU2Gh+oJCp62aUVKnqjKP3bbDMWeA8kB36RgfH
         rxIeeFCDojYdjhJg+VCQ7q7fK3iz4SdH29dEpv5fAIaUTHz6hFCnvsMv9Y4R7CG2CXTM
         bM0AnzdGsPj43dxVpDtGMyOTubkXydF/dyv4vqBiOxITJmFX+9hQMPJptCq6bt2q5+Pb
         Jy7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759980563; x=1760585363;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JpBrYi8OaSK64ZsI47g3j0U1q75t5NwItcJ4jghSQ6k=;
        b=bAFf26XCoPCRpWjIZ5NUtU4STlURqKgb4hrnhk0xHOSMZTa2le8PK/uO5R7YtYMXGR
         TYJUlTehw2dapfqNc8YilVmsRugoXZdwuV+KeDJsQy+MnGKoaEU0+FKrDobe/X5S+nx3
         I09306/+v9yQjdLWr262vaa1pDxXsDZA1/ANVz6qVIqVZ0lu0B2mWwfDOkZMCAsfUO4u
         qI48Qy3ZLlv/m48U6mg5a8V+tG2h/l9kUH4dRUfmmbH0XPHpG3vStKTZUGH96gIX48XG
         7DSpGklmihVhMnyxk7f4pHvQcTFgi8JeeXMR4mt88JK6tjD/A6uc3VvbPLOrOLZJOvLD
         1jYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnQ2ogEomoi05Lk1usEkCGEd3jQ49NU3ouJlODv6EkUpVmSs/v75hoM/6I2HCrOlXWgRwYy1aAlQT7/PFUspEz@vger.kernel.org
X-Gm-Message-State: AOJu0YyTl+M/SKbJ3yZJ7kMR1qnPhgMVwMUFosYlECz8iROjATueznZ4
	uxvY3fKpVnP+AfGWW4HlpLCfNhE3MDnhycgmlVz4EGteCrYglVbRtM45WYg3QlVxX4s=
X-Gm-Gg: ASbGncvbczE7zeOxK4uFP02LNz49ZDMHbdtFkQt1bRPe/HBigCNMEe5CVbuudWdmP82
	vH5KrkejvR3b6Q0t0a4w/Leu8WYp+hOlRvz31F+j3MA52bo1SwoD2Lsq6GQ9L+FaFgqvAW3njjz
	hmCSapc6Axl7ruEFAe1kPes7K34H2dYYTpvSXj1UfwribXHS7mhVE9oBNx8ArLAOZAMG4csMzTN
	ZjINskFIVJEs1LFA6a8nxK9xrOdplGRhiQeQhLBaZGq4WZPMWIi3geY4wlfhc6xT/0q0g7efWHG
	qcWS0yiQuCZx04SN6WAW8yV7+Ux334jeowE7U2AfAO/mzWN4S12MSRiJv2lSw1xRICtR/VkVR3z
	cW4F82po500wCI5puq/3avWa3YGCPpXI0JbymXHxWNRpoCinK/RdsjQ+5D6rHlFkboIGgaVTDjv
	DTYGhHNTXoqVM00olxi68/6A==
X-Google-Smtp-Source: AGHT+IFRlFMSgpyV+I+rT5AczJyjaNpsL4H8TkyxvKqiDHtqjU3VLps9m9B9k3wusNgIZV/khJ/OsA==
X-Received: by 2002:aa7:88c8:0:b0:77f:143d:eff2 with SMTP id d2e1a72fcca58-79387c191fcmr6789523b3a.28.1759980562388;
        Wed, 08 Oct 2025 20:29:22 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([139.177.225.226])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-794d4b39400sm1271306b3a.15.2025.10.08.20.29.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 08 Oct 2025 20:29:22 -0700 (PDT)
From: Yunhui Cui <cuiyunhui@bytedance.com>
To: akpm@linux-foundation.org,
	alex@ghiti.fr,
	anup@brainfault.org,
	aou@eecs.berkeley.edu,
	atish.patra@linux.dev,
	catalin.marinas@arm.com,
	cuiyunhui@bytedance.com,
	dianders@chromium.org,
	johannes@sipsolutions.net,
	lihuafei1@huawei.com,
	mark.rutland@arm.com,
	masahiroy@kernel.org,
	maz@kernel.org,
	mingo@kernel.org,
	nicolas.schier@linux.dev,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	suzuki.poulose@arm.com,
	thorsten.blum@linux.dev,
	wangjinchao600@gmail.com,
	will@kernel.org,
	yangyicong@hisilicon.com,
	zhanjie9@hisilicon.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v3 0/2] Add HARDLOCKUP_DETECTOR_PERF support for RISC-V
Date: Thu,  9 Oct 2025 11:28:36 +0800
Message-Id: <20251009032838.63060-1-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After discussion [1],[2], hardlockup_perf cannot be completely replaced by
the hardlockup_buddy approach, so this patch is still being submitted.

v1->v2:
The contents of arch/arm64/watchdog_hld.c are directly consolidated into
kernel/watchdog_perf.c.


v2->v3:
Add CONFIG_WATCHDOG_PERF_ADJUST_PERIOD to enclose the period update logic,
select it by default on arm64 and riscv, without affecting other arches
like x86 and PPC.

Link: https://lore.kernel.org/all/CAD=FV=UEhVCD6JehQi1wor2sSmtTLDyf=37xfo-DOTK1=u1xzA@mail.gmail.com/ [1]
Link: https://lore.kernel.org/all/20250916145122.416128-1-wangjinchao600@gmail.com/ [2]

Yunhui Cui (2):
  watchdog: move arm64 watchdog_hld into common code
  riscv: add HARDLOCKUP_DETECTOR_PERF support

 arch/arm64/Kconfig               |  2 +
 arch/arm64/kernel/Makefile       |  1 -
 arch/arm64/kernel/watchdog_hld.c | 94 --------------------------------
 arch/riscv/Kconfig               |  4 ++
 drivers/perf/arm_pmu.c           | 10 +++-
 drivers/perf/riscv_pmu_sbi.c     | 10 ++++
 include/linux/perf/arm_pmu.h     |  2 -
 kernel/watchdog_perf.c           | 83 ++++++++++++++++++++++++++++
 lib/Kconfig.debug                |  8 +++
 9 files changed, 116 insertions(+), 98 deletions(-)
 delete mode 100644 arch/arm64/kernel/watchdog_hld.c

-- 
2.39.5

