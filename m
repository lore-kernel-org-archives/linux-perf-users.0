Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F632222CB
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Dec 2025 01:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765848009; cv=none; b=IQeWzJAsVRwd7LX2zijK1ZexKW21ihThIVg3wDNQMCHePDCWtyHpFSXGuTgb00d4TFtRbU19vx8ajZq95e8YaX1zo4EuEyppu2PDHVNH6uiMYymthfAwPtJCGICtq9WV0MMDWViuCTo77XUyN6CVBXjitUNJ/a4ObKjUx8hlRpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765848009; c=relaxed/simple;
	bh=otPy5H9YRubAr/y+Uf1Jo4QzPzJqenEdbe+yUk9KE5E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kWD9wiVIAochI34TbbLHMU1w1acnlodedJ0Aef/LO1PGs5JWz4fbtYsGdIkJMxfW38UtWVloZbqOtE9sbefuJiI+a39U/9rGaGEduT74BIli2comP3Hs4BTs3+7gGHwfya4gGw3zdW9E/Xo9DTUyJ448ujqDdo0uy/N5hSzQv30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NXs3rIkF; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NXs3rIkF"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-6446d7a8eadso3735711d50.0
        for <linux-perf-users@vger.kernel.org>; Mon, 15 Dec 2025 17:20:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765848006; x=1766452806; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4D2fKjhV+xXooGe5GhIIOsVNBVoSb/WsPEzHiyDzi2s=;
        b=NXs3rIkF3IgFUN2AX/74BRVN2f+S5p5thYnNvocMdCLX2elY/o2RNhOg8wiMUDPm9R
         3zB4xoEtAkUkhFutnJLclo8LfizCb9WWcoCXQTvQR28x6CTK/lFrwfJkRbDtXl8e3o4L
         z08faFeB3w7JUIKAgSX/rxy8Y1JDlyJzX6RznWyNb+dwTapfbNQ2s5bCQfnHxO7Oyh1O
         VyJqTDJq12NXu1y0GasNy1ZCtlqhBuVK4Te8QXp4IDrASpOYfl35aPFctzpunyea4zKQ
         Aj6OZo2fydaZFXiJJ3/AuGAZcXSG1KFJOMhRoNCFkg/XI7tjbujbp8EgPmNYRn2dpoof
         U1yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765848006; x=1766452806;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4D2fKjhV+xXooGe5GhIIOsVNBVoSb/WsPEzHiyDzi2s=;
        b=sNJSqAKznMs+45MftuNxqbHnX8m5ClsmZmIu8Xc5iAuxNloWWritl3L5sh0rm4wokB
         PdQ5j8KVN1Hyy5K2KeXnK/JRyq+mJXU9GXeYMLFwIn9hDPADl5qCx7hjgMDvPeNKr1+6
         4EF/ej2IPalSRwgCS7xgrUpgjpmZpktQxyniPxU1sXil4regeSgCmh9j7iGkyuaPavKX
         SbuBjeuiHtDi3Kge/a+ejO6yzLRiQhNZddmh/3oJiry1NKbI6Nww7YwsD+NypgxzxVxU
         b1Z7D01uPCsad1pqjolUizaA96DP5yJa3zXwG6T5vz1H6Mq9ngLaPD/fnaCoKOUhhnpI
         Ad0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUeH6JSVbJqXBs4UG4THLfJ5xsVq0RUCxE18WL4TTZPAa+3S4N+ioM/NbBs2tS/lQoq8tEsvMiuZUHXRDpH0p9A@vger.kernel.org
X-Gm-Message-State: AOJu0Yww4fDuLtGgyVZNz3nkOxdSjRgGdtPNTfbMSuZswWDeTgin+gAV
	wUWpoC/LO7cXkbz/B+euPaa52VGCCrj67wmzo18lpmRgXmda/1dj1PV4
X-Gm-Gg: AY/fxX7Bg2qdFwu1hd6eCb+rGNrDITxagLd374p//G5ur7FthbJRje4L2q2QoISoehm
	uZbIgcdLQlrcCIsoMVGMaDK5ltN8TQndkGHhz+oXcNpVQINZ4N1Y8hsGh3wRlkteZXDGf8VN81j
	4vmtSx8U/RFNsUEW38VaLQJgjwJBOusCHPY3b26qUnPvZQKHsrkx6lJtVhOSct2iiI3Uh9H9l+d
	Bv9P1pR0KaCvOojuOxh8viPA8zV5DCQqJoIBhKEjlEN/sqS4ZD0W81yBYRv/SkW0ZSeBmGvHkp5
	otPw6Cek4VPoaTjLIyaNt8eRb7urVt61y9k4sfMF5wA3fbmMoTV+Ge0ynLEBBHaNzkh/DP00QK4
	IU8QDQPEFiDv+LfP6+P+l0dvSD7wskF8g+APbqUYE86WdON/DzqnvqtLPS9li0wo9Ik1StRq/uo
	pQQ0SocQ==
X-Google-Smtp-Source: AGHT+IFfmvm90rdPTujJGHfPtnqhB1WsV9zGN12cd9dzeHQbXYRNvb06ZpPINTYrYrF+Tfl+/bGheQ==
X-Received: by 2002:a05:690e:1a44:b0:63f:9cef:d5f4 with SMTP id 956f58d0204a3-645555eb79emr7067344d50.36.1765848005823;
        Mon, 15 Dec 2025 17:20:05 -0800 (PST)
Received: from localhost ([2601:346:0:79bd:6b0:1f10:bc87:9bd7])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64477d58416sm7082747d50.10.2025.12.15.17.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 17:20:05 -0800 (PST)
From: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
To: Atish Patra <atish.patra@linux.dev>,
	Anup Patel <anup@brainfault.org>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Ji Sheng Teoh <jisheng.teoh@starfivetech.com>,
	linux-riscv@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
Subject: [PATCH] drivers: perf: use bitmap_empty() where appropriate
Date: Mon, 15 Dec 2025 20:20:03 -0500
Message-ID: <20251216012004.341288-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bitmap_empty() is more verbose and efficient, as it stops traversing
bitmaps as soon as the 1st set bit found.

Switch perf code to using bitmap_empty() where appropriate, and
correspondingly use boolean types.

Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
---
 drivers/perf/riscv_pmu_sbi.c         | 2 +-
 drivers/perf/starfive_starlink_pmu.c | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
index 7dd282da67ce..9dcc22fd48ef 100644
--- a/drivers/perf/riscv_pmu_sbi.c
+++ b/drivers/perf/riscv_pmu_sbi.c
@@ -1244,7 +1244,7 @@ static int riscv_pm_pmu_notify(struct notifier_block *b, unsigned long cmd,
 {
 	struct riscv_pmu *rvpmu = container_of(b, struct riscv_pmu, riscv_pm_nb);
 	struct cpu_hw_events *cpuc = this_cpu_ptr(rvpmu->hw_events);
-	int enabled = bitmap_weight(cpuc->used_hw_ctrs, RISCV_MAX_COUNTERS);
+	bool enabled = !bitmap_empty(cpuc->used_hw_ctrs, RISCV_MAX_COUNTERS);
 	struct perf_event *event;
 	int idx;
 
diff --git a/drivers/perf/starfive_starlink_pmu.c b/drivers/perf/starfive_starlink_pmu.c
index 5e5a672b4229..964897c2baa9 100644
--- a/drivers/perf/starfive_starlink_pmu.c
+++ b/drivers/perf/starfive_starlink_pmu.c
@@ -450,8 +450,7 @@ static int starlink_pmu_pm_notify(struct notifier_block *b,
 							 starlink_pmu_pm_nb);
 	struct starlink_hw_events *hw_events =
 					this_cpu_ptr(starlink_pmu->hw_events);
-	int enabled = bitmap_weight(hw_events->used_mask,
-				    STARLINK_PMU_MAX_COUNTERS);
+	bool enabled = !bitmap_empty(hw_events->used_mask, STARLINK_PMU_MAX_COUNTERS);
 	struct perf_event *event;
 	int idx;
 
-- 
2.43.0

