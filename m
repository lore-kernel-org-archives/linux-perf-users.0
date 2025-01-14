Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E75226882
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Jan 2025 22:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736895527; cv=none; b=uZACRR0ueSAUU45mnkx9wQIt/iEHj7ylEKyUw/IqtjSZfN9AoME4OK5+1o5TEd6f7akS3TJf4yEPCpL/ov0+ovpdS0wgJ89IZcgdVoA3Is0a9r9BnNWSsykW4vJJk5daycySc8QpycARB8I/nXKIw6Kfpskk02Dzyi/v5m/yb7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736895527; c=relaxed/simple;
	bh=HiTXq6OQK4mbtcvGc/N9RwcHNfGrvhnCJNp02HkOAWs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V2hm81SdQKc9QU5eJcMpU1jW3j9Zf8/lFbeNEObYJ6JsjVKPlLQl07HmbMRlt4kGR0WfqMPw5XY/Ak4Tnwp9yvbsObTV6WVoEqmVmlSASQTcZI4aiCknAOAulcwF4XwOjPhzY/oUeoLtTG3Cs1lo59e4C9s0qUIeFwlq6ZelGiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=PDs9JcNZ; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="PDs9JcNZ"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-21675fd60feso134182385ad.2
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Jan 2025 14:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1736895524; x=1737500324; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R5NzVVWM8qA9Fo1+GRIirXQzRfzq/r/+NUc9JNQjhEc=;
        b=PDs9JcNZCoTeXnLTLCEEOn5O7icdomuySvkAjmy3PF9sf0RnD9bKC9TmQTBHdjM+iM
         VyJdkcREqNEfLtwRI93JIG/qKUvMzynW9OTew3BbGgajB/15xMiU2XDdXn1gYm1SGZ1i
         YY/8DCOxkPqeKqf/Voacmu9Lq5j7/52Z+9iGwH/jX2hFIC2RUgySCuXxoxIlQFc7wg0P
         UTRq6xqHoJc/cZaRyRtXCSibubX5B7vjIjSqDAQM2zceYGUB9jVnTeZt7AW60tRCS3ES
         XhWZEHbQmIx21QHRZnlXuz1w0IXBBfXEG001bM2EqLPS+h6GO7MHwwN6CG6G1NqnjWLA
         dmzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736895524; x=1737500324;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R5NzVVWM8qA9Fo1+GRIirXQzRfzq/r/+NUc9JNQjhEc=;
        b=nwQl/IWIh7I4ADTKJrd7oczbjzjUXVeQbX9EZYn9Y7NIFYCZqDQKkfXKTTUZPuNYSh
         sTV/Ob305F/7Uhvz710AvBFyV+vdUi5AxmfNI/Xth1Ocp+Mur5MbdOlijdBGlMGeSRWa
         WmA1dZkSllDU/Cy2ZsLi+Pshz5QL6esVOerPeCtzZcTbh05l/xuGxXIIwTtrKNXGPUvF
         cPyO8QAbdKs3yDQIr2Nq68e7hf6lN6Yxprp5B3D3Nc3AUHXDhSBxe5Q0feKRV0ItSHMc
         Q+YXs5LySbS/NaK0ii3EkRdRohr0kzO2c+qJhoB6jqWlNamA3l6lZ0uwWfOc8AtO+6/b
         hy0g==
X-Forwarded-Encrypted: i=1; AJvYcCXB2Pz7Lme9aLhNwVFoRD+uqcvx1Q7Sp49tRPW13yPUrq48dcT8HUbBuwBLfcLaMPwRQKq8K25R38Z6uKauETZd@vger.kernel.org
X-Gm-Message-State: AOJu0YwrPOXQOPQhmkdeGewp2zgsg1z4DR05Gqvvifg/CuHm5aO3L1ck
	3zf/i8KvDhGGtmDq+sO0+pEng38zgS1K2Uh/I2oglKt1+XXKxK7AXuT3Hp9Wyx0=
X-Gm-Gg: ASbGnctz8oSkQb/YESYyJm2594QZrp3xguvQDUxrInZ1b7jm5cwLfNCNzsAW4puJWT5
	tKj3jWdIBsuR1V8ZpuOpYXCBUSGnXA/jse1io8XBa8jgxF/BCfede+GQnvcSJ3vzIxUfJhDde+N
	oO72grp83NuF7NEhAsnSaWK50aTZJNMPV6ek3ezDNTJYMRxZzbLZgWssne7RBX0pkSxFIqCcJa8
	5tgTXLDAiYrZ7OAK7BU5jtdgEfYUaZbIDm2rfuNjrl3K6ZuwXPgV2+Kz5hL4YYMJC+OMA==
X-Google-Smtp-Source: AGHT+IEMFajbox3otJ+OHxS2DGlG5iVgYY9Ppx0qRDeaLCpVzaKhI8pKM7MfO5qFetS73gaIgtP45A==
X-Received: by 2002:a17:903:32c3:b0:215:f1c2:fcc4 with SMTP id d9443c01a7336-21a83fe4f63mr405013495ad.41.1736895524581;
        Tue, 14 Jan 2025 14:58:44 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f10df7asm71746105ad.47.2025.01.14.14.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 14:58:44 -0800 (PST)
From: Atish Patra <atishp@rivosinc.com>
Date: Tue, 14 Jan 2025 14:57:40 -0800
Subject: [PATCH v2 15/21] RISC-V: perf: Skip PMU SBI extension when not
 implemented
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250114-counter_delegation-v2-15-8ba74cdb851b@rivosinc.com>
References: <20250114-counter_delegation-v2-0-8ba74cdb851b@rivosinc.com>
In-Reply-To: <20250114-counter_delegation-v2-0-8ba74cdb851b@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Anup Patel <anup@brainfault.org>, 
 Atish Patra <atishp@atishpatra.org>, Will Deacon <will@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, weilin.wang@intel.com
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Palmer Dabbelt <palmer@sifive.com>, Conor Dooley <conor@kernel.org>, 
 devicetree@vger.kernel.org, kvm@vger.kernel.org, 
 kvm-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-perf-users@vger.kernel.org, Atish Patra <atishp@rivosinc.com>, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.15-dev-13183

From: Charlie Jenkins <charlie@rivosinc.com>

When the PMU SBI extension is not implemented, sbi_v2_available should
not be set to true. The SBI implementation for counter config matching
and firmware counter read  should also be skipped when the SBI extension
is not implemented.

Signed-off-by: Atish Patra <atishp@rivosinc.com>
Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 drivers/perf/riscv_pmu_dev.c | 46 ++++++++++++++++++++++++++------------------
 1 file changed, 27 insertions(+), 19 deletions(-)

diff --git a/drivers/perf/riscv_pmu_dev.c b/drivers/perf/riscv_pmu_dev.c
index c80f8ef79204..83e7d1f6b016 100644
--- a/drivers/perf/riscv_pmu_dev.c
+++ b/drivers/perf/riscv_pmu_dev.c
@@ -410,18 +410,22 @@ static void rvpmu_sbi_check_event(struct sbi_pmu_event_data *edata)
 	}
 }
 
-static void rvpmu_sbi_check_std_events(struct work_struct *work)
+static void rvpmu_check_std_events(struct work_struct *work)
 {
-	for (int i = 0; i < ARRAY_SIZE(pmu_hw_event_map); i++)
-		rvpmu_sbi_check_event(&pmu_hw_event_map[i]);
-
-	for (int i = 0; i < ARRAY_SIZE(pmu_cache_event_map); i++)
-		for (int j = 0; j < ARRAY_SIZE(pmu_cache_event_map[i]); j++)
-			for (int k = 0; k < ARRAY_SIZE(pmu_cache_event_map[i][j]); k++)
-				rvpmu_sbi_check_event(&pmu_cache_event_map[i][j][k]);
+	if (riscv_pmu_sbi_available()) {
+		for (int i = 0; i < ARRAY_SIZE(pmu_hw_event_sbi_map); i++)
+			rvpmu_sbi_check_event(&pmu_hw_event_sbi_map[i]);
+
+		for (int i = 0; i < ARRAY_SIZE(pmu_cache_event_sbi_map); i++)
+			for (int j = 0; j < ARRAY_SIZE(pmu_cache_event_sbi_map[i]); j++)
+				for (int k = 0; k < ARRAY_SIZE(pmu_cache_event_sbi_map[i][j]); k++)
+					rvpmu_sbi_check_event(&pmu_cache_event_sbi_map[i][j][k]);
+	} else {
+		DO_ONCE_LITE_IF(1, pr_err, "Boot time config matching not required for smcdeleg\n");
+	}
 }
 
-static DECLARE_WORK(check_std_events_work, rvpmu_sbi_check_std_events);
+static DECLARE_WORK(check_std_events_work, rvpmu_check_std_events);
 
 static ssize_t rvpmu_format_show(struct device *dev,
 				 struct device_attribute *attr, char *buf)
@@ -549,6 +553,9 @@ static int rvpmu_sbi_ctr_get_idx(struct perf_event *event)
 
 	cflags = rvpmu_sbi_get_filter_flags(event);
 
+	if (!riscv_pmu_sbi_available())
+		return -ENOENT;
+
 	/*
 	 * In legacy mode, we have to force the fixed counters for those events
 	 * but not in the user access mode as we want to use the other counters
@@ -562,10 +569,9 @@ static int rvpmu_sbi_ctr_get_idx(struct perf_event *event)
 			cflags |= SBI_PMU_CFG_FLAG_SKIP_MATCH;
 			ctr_mask = BIT(CSR_INSTRET - CSR_CYCLE);
 		}
-	}
-
-	if (pmu_sbi_is_fw_event(event) && cdeleg_available)
+	} else if (pmu_sbi_is_fw_event(event) && cdeleg_available) {
 		ctr_mask = firmware_cmask;
+	}
 
 	/* retrieve the available counter index */
 #if defined(CONFIG_32BIT)
@@ -871,7 +877,7 @@ static u64 rvpmu_ctr_read(struct perf_event *event)
 		return val;
 	}
 
-	if (pmu_sbi_is_fw_event(event)) {
+	if (pmu_sbi_is_fw_event(event) && riscv_pmu_sbi_available()) {
 		ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_FW_READ,
 				hwc->idx, 0, 0, 0, 0, 0);
 		if (ret.error)
@@ -1952,14 +1958,16 @@ static int __init rvpmu_devinit(void)
 	int ret;
 	struct platform_device *pdev;
 
-	if (sbi_spec_version >= sbi_mk_version(0, 3) &&
-	    sbi_probe_extension(SBI_EXT_PMU)) {
-		static_branch_enable(&riscv_pmu_sbi_available);
-		sbi_available = true;
+	if (sbi_probe_extension(SBI_EXT_PMU)) {
+		if (sbi_spec_version >= sbi_mk_version(0, 3)) {
+			static_branch_enable(&riscv_pmu_sbi_available);
+			sbi_available = true;
+		}
+
+		if (sbi_spec_version >= sbi_mk_version(2, 0))
+			sbi_v2_available = true;
 	}
 
-	if (sbi_spec_version >= sbi_mk_version(2, 0))
-		sbi_v2_available = true;
 	/*
 	 * We need all three extensions to be present to access the counters
 	 * in S-mode via Supervisor Counter delegation.

-- 
2.34.1

