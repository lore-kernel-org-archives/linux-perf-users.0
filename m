Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99EFC141
	for <linux-perf-users@vger.kernel.org>; Thu, 25 Sep 2025 08:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758790105; cv=none; b=oTd5PMeMFyF2hohlPSeJeL0ZwI5/Ll9VRgI26LfBf54XjlWajacYCA7mnkn7CMCehKa3B/R2aWw0Xq/LL9Yv3A6bn6T6XGoCglZMFOPKdvQuUyhTMiiBlHu5KLmP+uGMWmAWpAtV86IYGyfIEZZWTSX+JKUKBfUl/kFPyHIoScE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758790105; c=relaxed/simple;
	bh=RZN/VoIuVXbW8M0amOmTvueFAcMEuQr4dUMY1vRqnE8=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=E5zC9Jv3diiNqVbxUwD7mup3uBHPwKM/6M0akfOcghCWbfZxkOudsJ1ZsUEHP8vVUiOLcZ2CXiDftZZcmsqspshJO3Ej5OPjqyES7QnY0y5BvXvECJ5aNrhk/xV8l9qXIogNy17dc5q79MxfpELA4+QqK7YK7MnMx+KT/UolGWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=SSCpPaX7; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="SSCpPaX7"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-76e6cbb991aso689841b3a.1
        for <linux-perf-users@vger.kernel.org>; Thu, 25 Sep 2025 01:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1758790103; x=1759394903; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=gphyOsNtOdKDqs9aSBR2mOumTKsLxXqSuoON6fWyPlc=;
        b=SSCpPaX77LqzCMX9MKph0xpfKPw2KQuNxugNrq/nA3BCOxIrUMSsJyHKFt3OfkGZJw
         x2UkXZEqlE3IlezZhwQrU/tRs1FgH29M4iUJa8d2s9MfNFoo8CEA+7iQps2A5raFBLGP
         f10jC4gel09kKBJSGXVCYRXKJ4Uc6Hck2FHzDggAx517YxUi/5qJVhpQKyGtbIAYo4I4
         dEqNgX4pi1h9X01W19+k2eDE1FVoZrw9q+H9nRbStirvRMhxbhKFfXa9L+M8Nx8MvW1W
         q+KaAbllIX4Dz37rtnv+5vy4U8OW0JLGhQw9LZYXWze7GNVSMSMUKuFrcfgN5ZJxaa92
         66Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758790103; x=1759394903;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gphyOsNtOdKDqs9aSBR2mOumTKsLxXqSuoON6fWyPlc=;
        b=BuQwyVnYg30QPy3QozprKJdSAvJw+n0M/2wTYnFZpJkDHhR9XbgLuCMFXgSZUrZVX9
         wKkG/KEhd1WE1P5SSjEOUVF6S0bqng2hWR7SY9orTaJxZ8byN7LwsTjw20mnTiwjf9to
         RrzGiZucPG8m4ByHygazi+vDFwjrhuXEl4aJWBOFXq8nYKNGXKDhS1hsk5ftqhnqJOhr
         i0/0DZ+7WT4j2swVP3Wnh6jf4xpyAO+08D9ZvQ+Jj/5Du7JZq3GQrZRcRRZhApHixjvi
         9Nzf6fgX6neSOQh84GrfGI21dsZL4nsZ/CHrXQQEALaMXBcFtHZ6dwmPV+uTxng2vGlA
         difQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDIjXhk9DP97+7chBZT+cufoOVeujxLd0A+HPNPNagi3Ooqj5cCVIxpJjc1atU1DFjauUPxX5zB5j2sFWJyNkr@vger.kernel.org
X-Gm-Message-State: AOJu0YyLS4XtuWZFOqH9xrzNzKgsoY5oxGbcg4Qd7kEaA0TMI4Rcj1Cn
	++Eg+oJErjLkif8hbZSBruCIPJ+oNpz9eedi4XmcqmO7PD9VnjhPiYQYNpBC786sUAA=
X-Gm-Gg: ASbGncvQoowKkQQQpw+rF8oZT73UE7eF2b7YKu+t1ZBAmbNrVtShI9WZkSSYE3Zc8IN
	pPk/nYFtGxhCGtIEwvVFtaD3z830QOBJTPCyDwkuW70xzxAdIJJg5I/v3+8fP8GQJFvTvVr9CO+
	6G9vKrlJ1K/lxAZrgHSV9AKahVIaWpZRGHzALvj5FGPyT8cgC8xBcAr3icayrJITd0976LswQnQ
	B+fm+M+HJu6SlZjkeyN11YOtzEK9P9rhGKlKv2TuqT4r2QFZNJYDEkiou5PZhSLMDQsmVaSFeMw
	Q835UdEhpuxQlRH/e3+IQ/1PZ8TUm/v2H1iFBoDu+S83Buz0lQdXqmwo7rmjWWVKHbyqetBg7hX
	4vpszQ0Gh3R3IRVu8QT/bC/DNWXxCMNcrEFU+5TdtgvprDhLlRzkP4HL2Y7Rf8xDEKaRRy34=
X-Google-Smtp-Source: AGHT+IF5o7MsY/7di1Syx2EkRYGotHHFJz3EjXekBBptiHMX8QMKY8RAgGzMhfi8YFQVNtPQp29NcA==
X-Received: by 2002:a05:6a00:1255:b0:77f:2e62:1e3e with SMTP id d2e1a72fcca58-780fce9a124mr2974997b3a.18.1758790102952;
        Thu, 25 Sep 2025 01:48:22 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([61.213.176.10])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-781023ec6aasm1321867b3a.46.2025.09.25.01.48.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 25 Sep 2025 01:48:22 -0700 (PDT)
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
Subject: [PATCH v2 0/2] Add HARDLOCKUP_DETECTOR_PERF support for RISC-V
Date: Thu, 25 Sep 2025 16:48:04 +0800
Message-Id: <20250925084806.89715-1-cuiyunhui@bytedance.com>
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

Link: https://lore.kernel.org/all/CAD=FV=UEhVCD6JehQi1wor2sSmtTLDyf=37xfo-DOTK1=u1xzA@mail.gmail.com/ [1]
Link: https://lore.kernel.org/all/20250916145122.416128-1-wangjinchao600@gmail.com/ [2]

Yunhui Cui (2):
  watchdog: move arm64 watchdog_hld into common code
  riscv: add HARDLOCKUP_DETECTOR_PERF support

 arch/arm64/kernel/Makefile       |  1 -
 arch/arm64/kernel/watchdog_hld.c | 94 --------------------------------
 arch/riscv/Kconfig               |  3 +
 drivers/perf/arm_pmu.c           |  5 +-
 drivers/perf/riscv_pmu_sbi.c     | 10 ++++
 include/linux/perf/arm_pmu.h     |  2 -
 kernel/watchdog_perf.c           | 81 +++++++++++++++++++++++++++
 7 files changed, 98 insertions(+), 98 deletions(-)
 delete mode 100644 arch/arm64/kernel/watchdog_hld.c

-- 
2.39.5

