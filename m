Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0798C26FD84
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Oct 2025 03:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760411693; cv=none; b=ZyQdzbJsaR733ESGMBguWuYtZJ/83xKoELe4sUd9W0Im5KqtFIFdqv1ir+Uj5AWhPOSw2/A3DOqIi2SBITCc7l6UZ94w7OULDR347Oxp0HYFw8nOC80WRrK18oC3GoSjquFV3g2o6y/ble2Udqe+saGQ1k/ZboRWLN0pBxGnf8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760411693; c=relaxed/simple;
	bh=4m0oYSf7YDj+6AkhK+OImG8jLHv98QKB/2bNeTztQ/o=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=YBeBT0FQRODOdcBqwt3naXbPXukWEHXBJwoABTF8MqJqE8frKjAiPfgl/JtPGmnqbr6auBgGSxgZbz1xKDHd4o1tjpQ2HJXnLiuk7m5/4Bhb1R5TrKSvobG0IORkE8OHETA3/deid/3ku2cZZiWtiuOAKK39NxsJ49Gc5qiUneM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=UQHcUte1; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="UQHcUte1"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-269af38418aso57170595ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 13 Oct 2025 20:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1760411690; x=1761016490; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=h9mILizSboCplYbQmD86FAClfic5oRmsIwqr8yhg9y0=;
        b=UQHcUte1dmRK6W8OI2eYjKD/1lCwOTxFfzWGjZNVQ4kbT+a4xeedXGlaaHfGIevZAH
         YHSPRAjQhrUoVR284jztJwsn65aJfcf3Bn8AFixtfGJq4onVfUhRT2vXW82RzpM4l8k6
         GzuAWhX2kufSZq4pAn34zgOkrm54RWWrfCTgmq+JIAUv+uAGVXWBh2Obuw1xDPYGfu3l
         /HrEl6ZwvL/SKcjA4Ttt+de7muMylIO4l88AoOS+uYDrR+7U/kGCNrkhU8ha59H9wzXe
         0xk7jbYG+XToXaC9Vxz/NcE/hGfIFm1efyo1saQjMSKdsJ78LKRx2bccHEK+ate2HPvd
         1ykA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760411690; x=1761016490;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h9mILizSboCplYbQmD86FAClfic5oRmsIwqr8yhg9y0=;
        b=aoYP4Wg472K1IkpWTQBEVqy3eIJ4IaX4R1mHZR+jHw1Ckq3KaWwfKe4HrsPUKPBxrO
         xmVfOTGFIjCh1efhG1hJBqkJPMJVfFWsu5CJSpCJUpzvRiOpQ4hkEbyQNwvvlsuqesHp
         5NfqPZsZt08wwdkrpIAxbcT15ZU2lqGIk0FJO7lgecBRNEgFDrbfHUCb0Cgrkvmbj7nk
         wjszJ7dS4gABLKSXfygXcg3EVXEMEApdzK3Vtq1jP1ydniPMIKQ3pOgNUkDUQU7bR4Ix
         A1fPP3Hn4dEtf8BdVXZwdzBvBiyi1oQDL529pgx9VuJJgGJuMxQMe5DUYOJcphSCqgL1
         on5A==
X-Forwarded-Encrypted: i=1; AJvYcCXqMSuD6spnBap9unuWb3EVQvIZ2RUDojAgLzmxTIdmDbaqMM26Kd0R2Ybu1QLU/FNDoXdd2yuzA+q489o+6pfa@vger.kernel.org
X-Gm-Message-State: AOJu0YxiqoGiVOy4o+qiPabY0y1tfufv6lJdpD+tLFIAeEvi6mAXx91L
	KNQIDowRPvD5PEPgCEHI/S3Lrfw22QebgIHluxcATjXFoHls7+c/hTaWFLGJzLLVeqQ=
X-Gm-Gg: ASbGnctl9qXOlvQWTzPJxJpd4lCqBhOe2yopSP0hlQgIe3HvKW7rApygZhustWqzYqD
	ZbS7D+WS5giMaaIka8hcmzzyWAyqSrtaaBb3ukKDFXSLNJY6CDLoFYYVX+fa7uhMnJjxDsk1ZAf
	II7W20tZ0HEnc3pOTz+tvi7bkqSk7p7VySk4zdO9cjsyzouIfgnhdL5Twou1adQu5ZFa29gYHG7
	DsbpUiOYbldKL5tpQT/VW5OAhYVfx8RLzjFU/P13+jJAdkGTXsVXE/pUzPFhU2W9yyFvLqomwd5
	CgNdU/Mayy+Lgq8a4vd3c2X6hy5Wrnn+//z3SKxPSQ+CsK4BzfpNVq0SSBBo2QLmCqM1RClsf4j
	acLw6PI677Id41X5xAiJ8GDfdAJ9/B9grTbaS3aexuMhpBHFH6EkCHNvEeP+57riNKQOzgx5Bp5
	e0AnKAUA==
X-Google-Smtp-Source: AGHT+IEI3jpH2kWAbzu7oGE0nlZT9oIWVCOT7IZNd6Yq9DFB9XEbqH5fgzxf/doWGth7+r0MSrD5Aw==
X-Received: by 2002:a17:903:37c3:b0:269:a4ed:13c9 with SMTP id d9443c01a7336-290273ee214mr291664165ad.30.1760411690202;
        Mon, 13 Oct 2025 20:14:50 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([139.177.225.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f3de4asm148315845ad.92.2025.10.13.20.14.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 13 Oct 2025 20:14:49 -0700 (PDT)
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
Subject: [PATCH v4 0/2] Add HARDLOCKUP_DETECTOR_PERF support for RISC-V
Date: Tue, 14 Oct 2025 11:14:23 +0800
Message-Id: <20251014031425.93284-1-cuiyunhui@bytedance.com>
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

v3->v4:
Place the line "select WATCHDOG_PERF_ADJUST_PERIOD if HARDLOCKUP_DETECTOR_PERF && CPU_FREQ"
in the Kconfig files for arm64 and riscv in one line, with no line breaks.

Link: https://lore.kernel.org/all/CAD=FV=UEhVCD6JehQi1wor2sSmtTLDyf=37xfo-DOTK1=u1xzA@mail.gmail.com/ [1]
Link: https://lore.kernel.org/all/20250916145122.416128-1-wangjinchao600@gmail.com/ [2]

Yunhui Cui (2):
  watchdog: move arm64 watchdog_hld into common code
  riscv: add HARDLOCKUP_DETECTOR_PERF support

 arch/arm64/Kconfig               |  1 +
 arch/arm64/kernel/Makefile       |  1 -
 arch/arm64/kernel/watchdog_hld.c | 94 --------------------------------
 arch/riscv/Kconfig               |  3 +
 drivers/perf/arm_pmu.c           | 10 +++-
 drivers/perf/riscv_pmu_sbi.c     | 10 ++++
 include/linux/perf/arm_pmu.h     |  2 -
 kernel/watchdog_perf.c           | 83 ++++++++++++++++++++++++++++
 lib/Kconfig.debug                |  8 +++
 9 files changed, 114 insertions(+), 98 deletions(-)
 delete mode 100644 arch/arm64/kernel/watchdog_hld.c

-- 
2.39.5

