Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2EF1F8AC1
	for <linux-perf-users@vger.kernel.org>; Tue, 28 Jan 2025 05:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738040421; cv=none; b=V2IZGN9fUdUKyvssJxcubkMxaewG7diFT8ndgBhiVbHxug0EcNJa2yOP9/sYt+wzvzqaQqvQ/VcakMMzDf2090qoUDuMg9aePwhF4xH8DnUVAGs49r2+kXavKiYzGwnd1aKC71TGPKn4hZdgAKFpYZGjfutFPUNfb4OYCNB7QMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738040421; c=relaxed/simple;
	bh=7L9cr7KdPT07Iv2ikCIHod/sKcSPb3sA1NMIbfS67so=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uOchcwElWDUJQA9tpgaOK5cuhQeqjLLj0APYeXba3bwFnRkGTS5tIZAN8+o7I4P4r+kujVOM1q2N/L4VG3/fEJ8YhQJoRiX9ppFFYJl8cEiJNjU9VAYLouuNBtLmx/qabC7+D/z/9IFQFQkhGhlVxUpo97madvQUzO0EXwzO/1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=O+T053w5; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="O+T053w5"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2ef714374c0so8025057a91.0
        for <linux-perf-users@vger.kernel.org>; Mon, 27 Jan 2025 21:00:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1738040418; x=1738645218; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r5NF+IAT/KmspwMK0FGMQwrWJIha2MiTbZ1WzqIdfAY=;
        b=O+T053w5tArKqaxJ08l1uIGgzqExmtXPQGXE0mtAOMWj3lq5eQbcsWbAHmglnRZnT7
         2s5csfRqIQEmN4ej2S83O3Swbas5123zE2nNhuXnLupCbeKwFj7AFej6/lgj170gE28F
         fxfEUR9NkbN7SEoqEztocDReA7qUVU6bvQWuR1KKUff8gaNVqTiJiVMFLEHEdmWKDxOR
         Y4OccWu/V9Z0HI4VAy5sC+qG2M+iGiBdmn0JypJCod5kWqyjKkIFjjBz1cNxFvEXoGZQ
         sFEMJwtSOiszwor/bCQYGLfTCcAxOeb2SDs8PjnXaJI2fwniBl4hNReSi4P00k59zJJZ
         jdUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738040418; x=1738645218;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r5NF+IAT/KmspwMK0FGMQwrWJIha2MiTbZ1WzqIdfAY=;
        b=apgnuDnOb7WGOGJS3sflrHPF2lh+mnNElxEAoNuGJRK9HhWg/RkRm4+80OBWrqKbu4
         JecerOMQckX4ANUovpsHBw5vmvfx7AlHEfy2pdPuzGlqkcoUJFTbB2NCb1RVyK12XG6l
         hEw3xNrKzgj6+rPjNkVRYSqpOGjGud8GicFlVGLQwHWkfTmGpaaDdYrKZfJOqTdbDjDf
         P3h+w+HeO7Gq/nqkPy8HailMEgebc+fAV6WYXv9HNhWmRM1e/sEmNTjqRxSA31eNJZkg
         18Sv0R37OU6XBv0ZC6oSmVVFxzMu5GECk/JZNlQYzGNUYVsl83HseiMLbNVg9Cziiq3l
         dTpg==
X-Forwarded-Encrypted: i=1; AJvYcCW420Jd9HAuHWhBPhuPcY8RQO2KQ8EKVEU10nWzZAfUc+t3iAYzuppda+RLiZXvewIjjZP0o/ag42c9jlxvPrLb@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy2lK0LJ7ymW9qb825iXwuyM3v+MPHI1JqpPAxAjbHiuvaHFZn
	LbUML5qPYKnny2Pbqy8sDEDJlUs4vb1FMLuQFH5edi1I7G0RJakhbaNbAXBD3t0=
X-Gm-Gg: ASbGncv2wQ/NoddPzFsGz7ix205VyaNBgOxr6DRujfn8TzldN4GsiG115n1gnIB5srQ
	hlm0yML+0fJeoByzESS9rs1QqkEQJN+xAwzOiUu0ao6BE/pwz8yf3KOljlLGU51Rq6b8283Ucnu
	HfyeoFuW4fm1wGOdeXwmU6kYZIekVNUQomPmd66RjvSQ/aLpiiv8spI6CAOA3nvib20Bj9caqCe
	uk+G8S0t/0WsccBNDTrV+eULbe/zN3Q+L0ASH/5It6rVX92axLHPpLG8MV+U8UhS66Ep/uv7Rr7
	JYAoou6DBcHrgqheUTZAcARNHk1nuZrHc6YoDe0=
X-Google-Smtp-Source: AGHT+IH6k4v2G1ElxeZAZKnP2qHihpfZzn6nd2gCpEPf3NHDHrL/Cp1+5uWagHMGSZOAiqHrlZzQ2w==
X-Received: by 2002:a17:90a:f950:b0:2ee:c30f:33c9 with SMTP id 98e67ed59e1d1-2f82c076328mr3187299a91.14.1738040418390;
        Mon, 27 Jan 2025 21:00:18 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f7ffa5a7f7sm8212776a91.11.2025.01.27.21.00.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 21:00:18 -0800 (PST)
From: Atish Patra <atishp@rivosinc.com>
Date: Mon, 27 Jan 2025 20:59:59 -0800
Subject: [PATCH v3 18/21] RISC-V: perf: Add Qemu virt machine events
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250127-counter_delegation-v3-18-64894d7e16d5@rivosinc.com>
References: <20250127-counter_delegation-v3-0-64894d7e16d5@rivosinc.com>
In-Reply-To: <20250127-counter_delegation-v3-0-64894d7e16d5@rivosinc.com>
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
 Conor Dooley <conor@kernel.org>, devicetree@vger.kernel.org, 
 kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 Atish Patra <atishp@rivosinc.com>
X-Mailer: b4 0.15-dev-13183

Qemu virt machine supports a very minimal set of legacy perf events.
Add them to the vendor table so that users can use them when
counter delegation is enabled.

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/include/asm/vendorid_list.h |  4 ++++
 drivers/perf/riscv_pmu_dev.c           | 36 ++++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/arch/riscv/include/asm/vendorid_list.h b/arch/riscv/include/asm/vendorid_list.h
index 2f2bb0c84f9a..ef22b03552bc 100644
--- a/arch/riscv/include/asm/vendorid_list.h
+++ b/arch/riscv/include/asm/vendorid_list.h
@@ -9,4 +9,8 @@
 #define SIFIVE_VENDOR_ID	0x489
 #define THEAD_VENDOR_ID		0x5b7
 
+#define QEMU_VIRT_VENDOR_ID		0x000
+#define QEMU_VIRT_IMPL_ID		0x000
+#define QEMU_VIRT_ARCH_ID		0x000
+
 #endif
diff --git a/drivers/perf/riscv_pmu_dev.c b/drivers/perf/riscv_pmu_dev.c
index 055011f07759..db4a61fac838 100644
--- a/drivers/perf/riscv_pmu_dev.c
+++ b/drivers/perf/riscv_pmu_dev.c
@@ -26,6 +26,7 @@
 #include <asm/sbi.h>
 #include <asm/cpufeature.h>
 #include <asm/vendor_extensions.h>
+#include <asm/vendorid_list.h>
 #include <asm/vendor_extensions/andes.h>
 #include <asm/hwcap.h>
 #include <asm/csr_ind.h>
@@ -384,7 +385,42 @@ struct riscv_vendor_pmu_events {
 	  .hw_event_map = _hw_event_map, .cache_event_map = _cache_event_map, \
 	  .attrs_events = _attrs },
 
+/* QEMU virt PMU events */
+static const struct riscv_pmu_event qemu_virt_hw_event_map[PERF_COUNT_HW_MAX] = {
+	PERF_MAP_ALL_UNSUPPORTED,
+	[PERF_COUNT_HW_CPU_CYCLES]		= {0x01, 0xFFFFFFF8},
+	[PERF_COUNT_HW_INSTRUCTIONS]		= {0x02, 0xFFFFFFF8}
+};
+
+static const struct riscv_pmu_event qemu_virt_cache_event_map[PERF_COUNT_HW_CACHE_MAX]
+						[PERF_COUNT_HW_CACHE_OP_MAX]
+						[PERF_COUNT_HW_CACHE_RESULT_MAX] = {
+	PERF_CACHE_MAP_ALL_UNSUPPORTED,
+	[C(DTLB)][C(OP_READ)][C(RESULT_MISS)]	= {0x10019, 0xFFFFFFF8},
+	[C(DTLB)][C(OP_WRITE)][C(RESULT_MISS)]	= {0x1001B, 0xFFFFFFF8},
+
+	[C(ITLB)][C(OP_READ)][C(RESULT_MISS)]	= {0x10021, 0xFFFFFFF8},
+};
+
+RVPMU_EVENT_CMASK_ATTR(cycles, cycles, 0x01, 0xFFFFFFF8);
+RVPMU_EVENT_CMASK_ATTR(instructions, instructions, 0x02, 0xFFFFFFF8);
+RVPMU_EVENT_CMASK_ATTR(dTLB-load-misses, dTLB_load_miss, 0x10019, 0xFFFFFFF8);
+RVPMU_EVENT_CMASK_ATTR(dTLB-store-misses, dTLB_store_miss, 0x1001B, 0xFFFFFFF8);
+RVPMU_EVENT_CMASK_ATTR(iTLB-load-misses, iTLB_load_miss, 0x10021, 0xFFFFFFF8);
+
+static struct attribute *qemu_virt_event_group[] = {
+	RVPMU_EVENT_ATTR_PTR(cycles),
+	RVPMU_EVENT_ATTR_PTR(instructions),
+	RVPMU_EVENT_ATTR_PTR(dTLB_load_miss),
+	RVPMU_EVENT_ATTR_PTR(dTLB_store_miss),
+	RVPMU_EVENT_ATTR_PTR(iTLB_load_miss),
+	NULL,
+};
+
 static struct riscv_vendor_pmu_events pmu_vendor_events_table[] = {
+	RISCV_VENDOR_PMU_EVENTS(QEMU_VIRT_VENDOR_ID, QEMU_VIRT_ARCH_ID, QEMU_VIRT_IMPL_ID,
+				qemu_virt_hw_event_map, qemu_virt_cache_event_map,
+				qemu_virt_event_group)
 };
 
 const struct riscv_pmu_event *current_pmu_hw_event_map;

-- 
2.34.1

