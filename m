Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DC222F391
	for <linux-perf-users@vger.kernel.org>; Thu,  6 Feb 2025 07:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738826619; cv=none; b=lBuhtbTWnHXJ+mloL4Puc00F45qDk7cWcsvMUA1M00xNATA+yEzenn+slK606Daulz2k/BAYMbGB1MACiRqQOA+KllB+dNNyOD9B7B4GLjqOY+i4WnwG2U3Fx6xCTDdZ//+8pqD0/uiH9G5GjGywugbDFrEortAwBvZcIyZ7pNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738826619; c=relaxed/simple;
	bh=owUvB8mXQhCMAGqKKjj+GfpILC8p7EgqazERy09roN0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=faylvLE0B+9WZ6rxCswk+qxxxF4/wRPn4d36vvWisEOvqYCZy73TQZ87j0acPChfDyCTDR35RnCzwyAKQy5aQs+vNKGA16ILQc+1EWAmCeoED34xzT/OwFlNww6vfhqZ+DUB1+lGEto8KEfaLLjyRUHHqc0qsjcEhCaP3DBfE6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=KXH45sEb; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="KXH45sEb"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2f9c3124f31so798922a91.0
        for <linux-perf-users@vger.kernel.org>; Wed, 05 Feb 2025 23:23:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1738826616; x=1739431416; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LgFNQleQh/rKyQJtr5gK6tFb1jww+ogex5C6sOF/Bv0=;
        b=KXH45sEbUeXUsMtQE6UrKQESzsFsrh4e7yxFg1raXIxTjTVeMKY9VObcGU1Tj0d1Qx
         C8pMu3nvAGJrFgvR1Lr2YPp7ezAD7/rQWTakjrGaRq+HPSiOUF7mUVf7tQwiw9FDsnL5
         Kdk+ldAjnX5lbK6lXsawMvnpgsZcAoKb5CsCns51/14odF4QsgeUAjk9Pn/py3tXhpAf
         T7Tyfco2I4wwNG/NCG/1itTSKbs8yXy2seg3hsL+G4rdijfrc2xlxL5rplGlfGY5BIST
         bBbRRHnOxDprh48ZMB+T4aXf1t5fUhYkIaXs3NBxZI/RLM79lplR5o5JPAcrL9v0sEbg
         7ztg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738826616; x=1739431416;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LgFNQleQh/rKyQJtr5gK6tFb1jww+ogex5C6sOF/Bv0=;
        b=N6SAMiVD2ciLdAcW4VMbnWsQNwg7u+6bEe+xm7MVWq+xe7Bxr/HxlHLRfYsYOYMHAL
         vgX2wOv/4e+LtMgBufzAP6aJvQHJYNsDtacPimFcccyI8V1HoVgAEZNbkuyEHX8zm5vP
         wFoUMz6QUMU9AaaZQGjr3tK40W6PtCbmA6yFZGV8I38iuD+HBThbRlNX9osJzgbrX76O
         BWnTLsh/L7B18OJ0OaJLYSFi2ZlfgaGyzw1EepXN6JBKvVBv+b2WRnXXgXjgyyukgqCg
         /NQBbq/GKaiVGf6uSu0O8hOyLmurKQbEv1TDMT/3g/VOcvV3nP2iVuk8djjFByfSjHGg
         +hiA==
X-Forwarded-Encrypted: i=1; AJvYcCXqJkpcFebcZEeNEw2EgheOgHDFJzDe8ELP06SsPHFseLcuTgQHgt3l7LjwLsX391jMqpXH6SNhj+dlG6BrpPwv@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+0PZj5XcW866DWHtjA+T4WN3N0r3lXW2H8Ozzo8at9gP+rhyA
	EpP+YLvulS+5z2mTIaIZirnJajQ1ktUieCIwj0mUhb/5ZibDRHWuxxOUFo1wwog=
X-Gm-Gg: ASbGncsbskexNvCL4GWH44UJxZdqiN9ev14gjLcOWk5d0U4qqUkfTmuUGiZj9/QcL0K
	U87hbdd8xxhHbPZav0kvia80ykcqTVP5qlJGP/DvEas5Bhp/X6TtvHAnKhz9Huk67QsJ9VoNaYI
	Sc+OuO3Vms0GjVSw0s9M2H0ykYuFQazW0R+pQWZDClxh8EN/TVacYtwOCyjK9jrWL57ZOuXJ2f/
	m86VyegR6uMYK56/BNEvh9NNvnYLHmsLQ91kbu7jtHTtR669CsSgNzO7Vec17S7pkzdPwY7Vv9G
	uJtjNNK/3pIs2oRbYooVu7tDHlxb
X-Google-Smtp-Source: AGHT+IHC0uM6MKO6WJlQMIOHrq37adlEkVa8Q/0ld10wE8fTHq/Aau2QSOpqmWEdj7z9+naSpofcKQ==
X-Received: by 2002:a17:90b:2f85:b0:2ee:ab29:1a65 with SMTP id 98e67ed59e1d1-2f9e0753e18mr9830024a91.4.1738826616579;
        Wed, 05 Feb 2025 23:23:36 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fa09a72292sm630883a91.27.2025.02.05.23.23.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 23:23:36 -0800 (PST)
From: Atish Patra <atishp@rivosinc.com>
Date: Wed, 05 Feb 2025 23:23:18 -0800
Subject: [PATCH v4 13/21] RISC-V: perf: Add a mechanism to defined legacy
 event encoding
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250205-counter_delegation-v4-13-835cfa88e3b1@rivosinc.com>
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

RISC-V ISA doesn't define any standard event encodings or specify
any event to counter mapping. Thus, event encoding information
and corresponding counter mapping fot those events needs to be
provided in the driver for each vendor.

Add a framework to support that. The individual platform events
will be added later.

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 drivers/perf/riscv_pmu_dev.c   | 51 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/perf/riscv_pmu.h | 13 +++++++++++
 2 files changed, 64 insertions(+)

diff --git a/drivers/perf/riscv_pmu_dev.c b/drivers/perf/riscv_pmu_dev.c
index 5ddf4924c5b3..2eb58b248c88 100644
--- a/drivers/perf/riscv_pmu_dev.c
+++ b/drivers/perf/riscv_pmu_dev.c
@@ -307,6 +307,56 @@ static struct sbi_pmu_event_data pmu_cache_event_sbi_map[PERF_COUNT_HW_CACHE_MAX
 	},
 };
 
+/*
+ * Vendor specific PMU events.
+ */
+struct riscv_pmu_event {
+	u64 event_id;
+	u32 counter_mask;
+};
+
+struct riscv_vendor_pmu_events {
+	unsigned long vendorid;
+	unsigned long archid;
+	unsigned long implid;
+	const struct riscv_pmu_event *hw_event_map;
+	const struct riscv_pmu_event (*cache_event_map)[PERF_COUNT_HW_CACHE_OP_MAX]
+						       [PERF_COUNT_HW_CACHE_RESULT_MAX];
+};
+
+#define RISCV_VENDOR_PMU_EVENTS(_vendorid, _archid, _implid, _hw_event_map, _cache_event_map) \
+	{ .vendorid = _vendorid, .archid = _archid, .implid = _implid, \
+	  .hw_event_map = _hw_event_map, .cache_event_map = _cache_event_map },
+
+static struct riscv_vendor_pmu_events pmu_vendor_events_table[] = {
+};
+
+const struct riscv_pmu_event *current_pmu_hw_event_map;
+const struct riscv_pmu_event (*current_pmu_cache_event_map)[PERF_COUNT_HW_CACHE_OP_MAX]
+							   [PERF_COUNT_HW_CACHE_RESULT_MAX];
+
+static void rvpmu_vendor_register_events(void)
+{
+	int cpu = raw_smp_processor_id();
+	unsigned long vendor_id = riscv_cached_mvendorid(cpu);
+	unsigned long impl_id = riscv_cached_mimpid(cpu);
+	unsigned long arch_id = riscv_cached_marchid(cpu);
+
+	for (int i = 0; i < ARRAY_SIZE(pmu_vendor_events_table); i++) {
+		if (pmu_vendor_events_table[i].vendorid == vendor_id &&
+		    pmu_vendor_events_table[i].implid == impl_id &&
+		    pmu_vendor_events_table[i].archid == arch_id) {
+			current_pmu_hw_event_map = pmu_vendor_events_table[i].hw_event_map;
+			current_pmu_cache_event_map = pmu_vendor_events_table[i].cache_event_map;
+			break;
+		}
+	}
+
+	if (!current_pmu_hw_event_map || !current_pmu_cache_event_map) {
+		pr_info("No default PMU events found\n");
+	}
+}
+
 static void rvpmu_sbi_check_event(struct sbi_pmu_event_data *edata)
 {
 	struct sbiret ret;
@@ -1547,6 +1597,7 @@ static int __init rvpmu_devinit(void)
 	    riscv_isa_extension_available(NULL, SSCSRIND)) {
 		static_branch_enable(&riscv_pmu_cdeleg_available);
 		cdeleg_available = true;
+		rvpmu_vendor_register_events();
 	}
 
 	if (!(sbi_available || cdeleg_available))
diff --git a/include/linux/perf/riscv_pmu.h b/include/linux/perf/riscv_pmu.h
index 525acd6d96d0..a3e1fdd5084a 100644
--- a/include/linux/perf/riscv_pmu.h
+++ b/include/linux/perf/riscv_pmu.h
@@ -28,6 +28,19 @@
 
 #define RISCV_PMU_CONFIG1_GUEST_EVENTS 0x1
 
+#define HW_OP_UNSUPPORTED		0xFFFF
+#define CACHE_OP_UNSUPPORTED		0xFFFF
+
+#define PERF_MAP_ALL_UNSUPPORTED					\
+	[0 ... PERF_COUNT_HW_MAX - 1] = {HW_OP_UNSUPPORTED, 0x0}
+
+#define PERF_CACHE_MAP_ALL_UNSUPPORTED					\
+[0 ... C(MAX) - 1] = {							\
+	[0 ... C(OP_MAX) - 1] = {					\
+		[0 ... C(RESULT_MAX) - 1] = {CACHE_OP_UNSUPPORTED, 0x0}	\
+	},								\
+}
+
 struct cpu_hw_events {
 	/* currently enabled events */
 	int			n_events;

-- 
2.43.0

