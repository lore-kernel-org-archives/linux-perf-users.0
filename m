Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0422F3D1A8E
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Jul 2026 10:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783678135; cv=none; b=sDVmFke/zKZoIu8MJ8EZkaeYBcaaAjTlaSpN9rCtIz83SO2ti7D63hIc44t0oWIiGa1ZXdIN474PWnNdDd9sGQz8qAWgie6VRNYjI51uQSX887YP8XEeBY8xTzSJKy3WOmWIAqVBevp3WWF09GSihiIFTBTrcgy8Y+xTRzB1c7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783678135; c=relaxed/simple;
	bh=AhjmgdCr6ZA23t+PouDdsy0jZEVrZCgXxFZp9YVJ/sg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rccwan3JiFcoaEovJ1XizZxTDVeN7665tZtvjXSZHUbw9gIyW0rOpXYt3ooE7qKoKx454GAzGOoXTOd495ikjr7CJpq/3Zlr0wLPbHpbGljxQEKgS5xAHSJsayggX3qck5tgoxonJL7jTB2sxEgbWHLgSZI/fp0Sewmxv7+/NrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TisDmcjK; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TisDmcjK"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-493ece78b0cso5616925e9.0
        for <linux-perf-users@vger.kernel.org>; Fri, 10 Jul 2026 03:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783678132; x=1784282932; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lRikmQyOKgqKnyLuQ+vxx3W3W3hQlqGIgJrN16gls5I=;
        b=TisDmcjKaVQ3flTDwR+loTuBumxdNobIpxYcUVbfn0Y0tm0A/gnkwObbLWFtt284yW
         eEG9LVd+jZLzT+Bo1h/bVU6kTMKdLQjuxt2G7CbL56KR2Z5pBuVVzEf6h7bua2ZbSL5c
         YpA/P8X4YvNN/+gcm8or5GAYJguY+bipFaWi95aOHEtHPvebXmw+DGzncmx51UtboN3g
         JW0/rIyNePO1IOzd+dq3kAYGHkzPD5w9PVCyjQd50+KnTETSKhoey8AJ5BECNyP8h6Hq
         jrUWNw86AxEeCY8intWfv4xaSmvyrbD6oyURYm4pMIyQm90MxxtzWm8pAgrQkFvTZFX8
         JwaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783678132; x=1784282932;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lRikmQyOKgqKnyLuQ+vxx3W3W3hQlqGIgJrN16gls5I=;
        b=Z82oW3tqZLDn7UY0AB5qyJKLtphSxGhEFKFq2QreEl29RlDo7ZS/yiZ8/+4YeQ8hvt
         q7Ce8oLm333P2pw8oKSdmTRnCS5r44GqT8Hm5lfLjflDlZQJyUZHmFsmdKlLIccUqrG3
         C942kFrfU39qxGKVOp7wEA1oMS9A84qs5ekXFF2rS0B79Lfy4AeHQld9GfWMyNK2mzxN
         61cDvwc3RCq+ieySFON8d0jQNNPsffGTWEOYR3a21AK4RyPYOKNo0cTZYZGYVllJCG8R
         1TIej417zWjGuNM2lonDMD0dzUKRlNxwdvJDiMjt/lBuYzENj03AD5H4SYyX05DAhox3
         JOsw==
X-Forwarded-Encrypted: i=1; AHgh+RrwFzJ8XKx6iq2CYS1d2zmUdodM1Va2HA5ydIh8y6Z2XMyAjYQO9VZWw39H6LI9HjzR3YmalM5kTC4RW0KZ2I5b@vger.kernel.org
X-Gm-Message-State: AOJu0YzHfNQusCM1SiAgIZ3/kZmmSCw2YqE989u4C7phji0+fdB+Lp0V
	oyV+wIJ49A+yxN4QKihawAyxL9KgoMu9jxoMEPI9dHJuxJGCafMszbJB
X-Gm-Gg: AfdE7ck7kbp5wgIEqvgdAaUwFk9QZBTphpXKelKrOqr5dg7XV25xoRNmXoKtomsbhdO
	ELjQNVd1HizqmLmQt3eFfZAK4HjQxnOUjRLLi+stjN9kiFkw2M5yzxz1/wT61Wc5IlbtrnYfSyv
	Rve8zKMixAi8Lc6Nr0cH+W1MDwYEasKv67qHcgQjcBFDI6lcLGF4jDgfI2kGKFeRhtSyz1Rl5On
	6MR98UbzL/PH0n+rtrnAKR+qSJnCjw54tGd8Ab4qk/6kwzV37GLPPWbX/fXR3ohGHTx6YKKvXEy
	A2W1OwLBV588NtVOZHTney2XzEY4QnbDGFtTpfL2YzNdHuPE4acaEvzmT2UtQhz/AY4D6omu5Wl
	O1nNg7uLMZ8hcSnJ1IB6meWM0OzDpz+3Cqs2G65OD+DtBCUf6Qlv08xES4NRUvxkp0QvsSRS5WR
	x9gBOWO0bpwV6UG02h
X-Received: by 2002:a05:600c:6208:b0:492:3e44:214b with SMTP id 5b1f17b1804b1-493e6843fb6mr101057725e9.13.1783678132163;
        Fri, 10 Jul 2026 03:08:52 -0700 (PDT)
Received: from curiosity ([80.211.22.60])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-493eb6f3b85sm207711765e9.2.2026.07.10.03.08.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 03:08:51 -0700 (PDT)
From: Sergey Matyukevich <geomatsi@gmail.com>
To: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Atish Patra <atish.patra@linux.dev>,
	Anup Patel <anup@brainfault.org>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Sergey Matyukevich <geomatsi@gmail.com>
Subject: [PATCH] drivers/perf: riscv: handle legacy fallback in event check
Date: Fri, 10 Jul 2026 13:08:35 +0300
Message-ID: <20260710100837.1362558-1-geomatsi@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Common events PERF_COUNT_HW_CPU_CYCLES and PERF_COUNT_HW_INSTRUCTIONS
can fall back to the legacy counters. So do not mark them as invalid
if OpenSBI reports that they are not mapped to sampling counters
in PMU DT node.

Signed-off-by: Sergey Matyukevich <geomatsi@gmail.com>
---
 drivers/perf/riscv_pmu_sbi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
index dfc886dee5ad..8f7aa71dc96f 100644
--- a/drivers/perf/riscv_pmu_sbi.c
+++ b/drivers/perf/riscv_pmu_sbi.c
@@ -335,7 +335,8 @@ static int pmu_sbi_check_event_info(void)
 		goto free_mem;
 	}
 
-	for (i = 0; i < ARRAY_SIZE(pmu_hw_event_map); i++) {
+	/* skip check for cycles and instructions as they can fall back to legacy counters */
+	for (i = 2; i < ARRAY_SIZE(pmu_hw_event_map); i++) {
 		if (!(event_info_shmem[i].output & RISCV_PMU_EVENT_INFO_OUTPUT_MASK))
 			pmu_hw_event_map[i].event_idx = -ENOENT;
 	}

base-commit: a635d6748234582ea287c5ffeae28b9b23f91c7e
-- 
2.54.0

