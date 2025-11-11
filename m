Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD49281341
	for <linux-perf-users@vger.kernel.org>; Tue, 11 Nov 2025 07:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762846527; cv=none; b=dkJyfkxVVz2S3T5za1dH5ug3VglZh9kgBQsEdrSpW1cEOF8oRngZei5bgt+40HnRSbwayZL8rNI1kYV6Zm9IPj03sIuPERFlI+dZl+Qu1ObQ+5wtlOMRHYTt869oglCuct/BTzakk7E+Lvtot9WNgvRxkHz2o7dsDs1ehklySPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762846527; c=relaxed/simple;
	bh=GlLb7hndPvEpfxlqOLmPms+o+qaLaVat60M/Kd9C5Fo=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=ZWSUhKBcPPpr+NecbUoC+U40pXcMbwWBa7yTbx4nPYe0s1hm+8WyBt+A64yjaGnveP0O9CgsW6/fTdacnZMEVLdiTbr05AN7c+TCjH34yLQZQwOm8ZI3WRbateCT9qtfjElqGR2YyB4gqKGj/QCUFwMVyBu+S3XNKIt19Dm8CW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=QVRUMlPH; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="QVRUMlPH"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-29516a36affso38208155ad.3
        for <linux-perf-users@vger.kernel.org>; Mon, 10 Nov 2025 23:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1762846524; x=1763451324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=533MpmlhqTKJtLtKqvZVG6ekGMT1k9z8ZUML8V8gWiY=;
        b=QVRUMlPHi1N9oef9xSGByvemx9lc4kRPfB57aJl+3XVHYiX/3qTIAjM/rkoBbG5W7v
         J8eLYXodT0uhaC9ZoyGhev3plsko2NivMIZAdehB56kBfTLT354xcX7sB3/fA4mZZTnE
         +dl53zUvunXp/Jpq2E9yrG8vPV/AF/njQ3CXCS9a4Rjn6N5mrkTUNoC+yRMHWZact2R/
         KZaKUhU2Y62ezTpDy/ugjz9NRz2sBWJ8O29NW4x6xjwN2JESnRbrVHaNF98DtpmydgrF
         zD7dO5DjZJXVafHWtOxuwJw0FgXJGG0JBlPWq0ct+ie0wZHm4c8UNdmdJPTcMlh4v1us
         x1mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762846524; x=1763451324;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=533MpmlhqTKJtLtKqvZVG6ekGMT1k9z8ZUML8V8gWiY=;
        b=vTl49lG6JyhwjUlf1QJgPW7ZNoCffA6cVQtLw56Z39EZuX9oVeJJtj1zTS4vnQL35e
         qBlu0sy7uGRs/jzmZfQgiOYhagjC9wMONi2+TCHto3cfsDUGLmMaPZxnLxDHfMszJAIl
         GnEnkIkS6bznLRSODrqbuEGu6Ev5ZMMhFnLVHYeEpFXsiw2qH+Omcy9JD623mDQEgo+g
         39lNThKMn+/ntyf1tSnhP9g+MJLPQ8GY73V33vnbzwqt02tSfyJyZPauWjLmqDAeX9If
         j/LtXRAm5wTqSfVyaiNCtBe6GE6PtJnJ+sW6KnntcQkwG9hyBaUJVuON0LJgTBtVcWXY
         PnjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVaNPX/clOJMcaq9vGYR67NH04TXOY6KcPLzEaQGQBJswd/865Qcxdjfb0/DU9LgOcoWli8ZEVIfyBKGPbYAuvx@vger.kernel.org
X-Gm-Message-State: AOJu0YyviTIHJ/ZhDb3I5dOuylH0fBh2nDGulsilrt/lCV3pX0TMhg1/
	PG7541MhpBZjCZj2bdcxsJYq3cz7YQFOlRU1gjbLslDrz0KxVaFEEmXCB2ecmkjE0ac=
X-Gm-Gg: ASbGnct86sHxkpAFwL3HCcItCe0A+Wp7D/KozjjJmxTojy3OdCGgDSjOk7EMvcjiGSA
	a/DviN2+QSQDFcIalIKb4TmxwEXHDM3QRB5aolZOccdKkeLc0+8aoGJEM87gODg5aPI851lWO8P
	BU7t1tdabX7/YCHvWgFLr4TZrNUhkOvETNjfIyHBQIL8HDbPtcDiRUEYeUXHOjs/pidfChrSd2s
	/znzDYquebIyTegus4aDDz3opIzdVahR3hBoz0stca9yk+3vic/avhLmmoE/u+IRw5tfNa/CA2k
	0XSPCtIETnOvLBzCRcQcqo+TZpQrnFiBoEFDTmP3XtZnXc2D7hUYYBbbv2WXGLfOiRhiJmcnhSX
	XYN2NjbA7ShVwOmtH6DtS96yW5IC6zn/V5tX2TgF+XWgVCY2jC5Y51QS+7Ed8qAyItCM3F6jsqs
	3QjKukVYS9zg4FtL0T83LI5BmMYfw//q8=
X-Google-Smtp-Source: AGHT+IHc4/svjuXEJqiJPblrTTMmTzjo8sWSLvFxa7A/n/1dDjeXQeMDKykLsDl5TXqJ0t2zOlW8CA==
X-Received: by 2002:a17:902:f684:b0:295:987d:f7ff with SMTP id d9443c01a7336-297e56df951mr138535025ad.42.1762846523563;
        Mon, 10 Nov 2025 23:35:23 -0800 (PST)
Received: from L6YN4KR4K9.bytedance.net ([61.213.176.12])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651c94abasm172928885ad.82.2025.11.10.23.35.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 10 Nov 2025 23:35:23 -0800 (PST)
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
Subject: [PATCH v5 0/2] Add HARDLOCKUP_DETECTOR_PERF support for RISC-V
Date: Tue, 11 Nov 2025 15:34:57 +0800
Message-Id: <20251111073459.44030-1-cuiyunhui@bytedance.com>
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

v4->v5:
Remove __weak from hw_nmi_get_sample_period()

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

