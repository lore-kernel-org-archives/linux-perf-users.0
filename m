Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53591230D09
	for <linux-perf-users@vger.kernel.org>; Thu,  6 Feb 2025 07:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738826627; cv=none; b=pKVf2pQkc381yqBEgDbiF2WByXGPkKlth0D1hBTzTPG3cs02F8+W5vRKcJBSMosxdJiurzyjtpF3HV7g01fKsxIEo3AQkQMxlMHd0MZmPTO4UbUwCtc7ubBXffQxtJ14UzKx+J1Heqa93fA27Ar8nfoiHtFwepLf5a7ldiVWQcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738826627; c=relaxed/simple;
	bh=T0+9i+sb9ttd0Rbx/cDVgW2Ga5ShjOPn7gpB15zgFLE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eYOVQ/guDBjLudIgGjbzKiahpgGH93YNO14lABybKT4TSYw+D0yJ6jTZsGUcxvu7J/Ly08C23T7YCH1nF9Rjtn0fkXOoOhSGb8L0loc3+htJpVdD2cQJG6BLk/GmTESKZHcyNE5abb1NwbP4zT4GQsecq0znfcoqWMDYFzaTznc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=qGt01WUg; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="qGt01WUg"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2fa0892f9bdso431728a91.2
        for <linux-perf-users@vger.kernel.org>; Wed, 05 Feb 2025 23:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1738826624; x=1739431424; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j+uvKlLnv4557Icjif9h7ezpBJYOQndwpRbHYJUOt04=;
        b=qGt01WUgT4/qoTg0QzUl546YBfO/X9mS99O/ggFDNYhpl/2lWRK89o/4puPJr0BtEK
         Johh61Ral7kFTIkLARGzxCQ9bh4xgcBTPpQk7cgFYyKnAE60qzY5AMrB3yO0C2UyiPGg
         Ttz5mzPG13I8G3Y1ul1+0PoCVFC2F+M0Y6MXJ6+Fc/b8rOBafgvRuhtIdeEmSewniI65
         6STQoUmfL4wYz8qixaoKK8iMIhw5qUySKmlL49hLD/4/iwQsCFrmZcbTOi7misPDAyGh
         z4G3lP5V7HOcccih47pHER4DG7RpEhnSkvvmNxdGhuByizF5RpbeuB4Wjo5U+3j/keYV
         f0VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738826624; x=1739431424;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j+uvKlLnv4557Icjif9h7ezpBJYOQndwpRbHYJUOt04=;
        b=E0fy9eKY1Sq3qK+DnXvOzmhfPCbtRiZEk7SnwH7KTdsoxC0UqNVOSxypbx/Qss+Rnx
         nPLRzZHEa9ivqkBAU6X5JxF5eA7+O4iPD4ncbLFFOGYuXzQPOqkrLNvA+yhG6VjjPIBn
         p40TxEzXWXmVMQ2QXRKR5RPGdi0vouB5aXRsKrbt9fAJrzZ6a8p6zRGmfJAPRQSLhVnR
         vmXkQiG600FOvcX88jWdUVReAd5QHundHXQ7NBIZZkebHMeBJXDRWwZh//TQA94a3Rm9
         aarLNnwQmKsrBGhnW6epZHPYIvQhn1xayYPeYPAG4+WbCM0eRGyIXqSLG4pTNz0VV0DV
         b6TA==
X-Forwarded-Encrypted: i=1; AJvYcCVOyJdL/KrfPP1D1rcOv88QMyegBB7Qu1LLrXeDp+OvHKfF0DAaoaSmNJdZGM+K7UQCxt5yHY4t9Dx4g1/RlVfq@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh6VU1kehErEoT1lSAsI2duo1bt8G8LJrr2P96jSID00ULGcWT
	wb8641d3FwhfMciLq7V/XZScFod/uzPJj3fsd3qm/C6tRS/ydgqvWgyRSu92Cgo=
X-Gm-Gg: ASbGnct83JDrIJJeXzYvZ6rKj4J0gc2BeUkOhg+QDRjP+C+0+7KQoXaxs4z2yh8g02v
	ZFIL9Nwr8y72vMvVy7codi+iAhPsdYUQ2Kt247Ks7H6O8XSPTzfA8wdKFhI72M3L07FY00vnuW5
	NP4ZUlKFTW9qF8j14AJMzt3AlOB4b5OvXSeMjbmWocCaKkvf0OVjo/sQcSoSdjBDkIgSEGdHOF4
	PhANL/GaFpunZBEDbma8l4QlwODjFB57ZS849rj6wF3HMMtXK/Hut3hMU6WC0E7dan6Illylu+0
	72B5LAaf9vhh1nrJHZCtvPUudCoT
X-Google-Smtp-Source: AGHT+IHVvUPUTgP+795doXG0yWQz3ag++6JLrXz9noZOmxRc/vzTQhLTg6Ot+5lngwjxV29P2MJVrQ==
X-Received: by 2002:a17:90a:dfc8:b0:2f5:63a:449c with SMTP id 98e67ed59e1d1-2f9e07fbf59mr9122811a91.28.1738826624682;
        Wed, 05 Feb 2025 23:23:44 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fa09a72292sm630883a91.27.2025.02.05.23.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 23:23:44 -0800 (PST)
From: Atish Patra <atishp@rivosinc.com>
Date: Wed, 05 Feb 2025 23:23:23 -0800
Subject: [PATCH v4 18/21] RISC-V: perf: Add Qemu virt machine events
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250205-counter_delegation-v4-18-835cfa88e3b1@rivosinc.com>
References: <20250205-counter_delegation-v4-0-835cfa88e3b1@rivosinc.com>
In-Reply-To: <20250205-counter_delegation-v4-0-835cfa88e3b1@rivosinc.com>
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
index dd4627055e7a..b315f361ae79 100644
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
2.43.0

