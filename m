Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D559C18BB9C
	for <linux-perf-users@vger.kernel.org>; Tue, 28 Jan 2025 05:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738040413; cv=none; b=CNk15AQUYNFvx6AUJUe2w9beq1o8S60Q52LX/j3U/yjqjlBIW6lhVyFWYD2Bzho/qluEyA6qvNfA5uJVcRhMF2yByrZkeadifnRz5Ty7x+G/zScarsizyJ8RiwL3mZCFEmRNn1+0Ew35ErowVf3aYO8iYNlk3TL83iXjXS+Kqxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738040413; c=relaxed/simple;
	bh=D26Mz7N1pZVpB7ZSRh7CV+vm7XrT3DFpbyMeC4eMdE4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fBWLCbD2mzNEkV2yR/aIO3yx71AYH6Or8nSPnZHjvKjTXaKZ4NKn5byjVltNc7REC2kWzchdEmU0jA/Ebau1KNsRY3osOSiceJUehQ90ZtZj6Y4bO3WohNKZyYcnWD+lNfkA98fGDr6dTdyMJZX1+k+jHWAnr1KVL+6m2L3wi5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=KdqQ7h6y; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="KdqQ7h6y"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2ef714374c0so8024817a91.0
        for <linux-perf-users@vger.kernel.org>; Mon, 27 Jan 2025 21:00:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1738040410; x=1738645210; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xSrHfq1ODaepQOo+hHypeE7yxwo5oeqvpXeWUiwKXOQ=;
        b=KdqQ7h6yuzuljV54s1IK6CuIFlVeaz+siN9SRqjfqDkM2UbkZnGUBr/AyLf7sP2pjf
         vDv10UdM9ZGeqNI5RJYC/EB1tM4EiGbLrmXeUXBqPXCqUkc1pgeO5gJYkZZnAZD3qxU+
         aM98g0T0hwOY+uVS9ZYqNmhUsmYC/7xWNChGkAj9V19Pk+bXepiJjdWqWc760Io1L40v
         2o7mfsM0tpY5PR8CUUyQZySZTE+4HOYeEDS5eG2qV/VagWU+4kFB+bgMa1CKT8WjGSPq
         0rNVgsatL3I9oscngKST9uqhdIGRVrnCN9agTuZDfmATUG0o7WqDLOVPVX5LD2d8blxc
         GTJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738040410; x=1738645210;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xSrHfq1ODaepQOo+hHypeE7yxwo5oeqvpXeWUiwKXOQ=;
        b=dkXnfS95ozNwFT7lp4k0k/N5H5lsE740YpLtgAxtiMwpwywFrwKTQv6gUc//IbTrbN
         Ct/GjAlyHqB6E9Z7b5UDQLK7Jy96jUzA0/1QHf6PLW6UiAIanaAno3rhdI/XHdfqrDu5
         m39/ecghsxtGSVPqdWacTclAT4//6h71PHAEpOjR4XOVNXmPbZyquW5M0jGfPFsUN//v
         /t8J3Zvhli/zuhXxLZ5inblcmjM5xGxrssEHiX/XavMNjIsFjvjCrA38mqA5Fe68zZET
         IdpICpa1+VllU4gbQwS3iyZaUyKsIubp3eX8UFrXA2i32kA7DkQjSj2zzjnI0yqKp+qR
         dr1w==
X-Forwarded-Encrypted: i=1; AJvYcCV09K0cZP2FAKxxrIh/hmaABTFemF939fc50ZX/X0aPa+VqUVifyEdWQjGMLUBXyHx4jXJWLHSLSGD5HNPHZ7Db@vger.kernel.org
X-Gm-Message-State: AOJu0YxZHRcZcbOD2BilbyT8I5FBR3wr4psGaGJGmNDmLM5Wbz0leZYr
	1gUcqlSbUP7bUCazuwqzw6zU0lx2i72gGbwWWiqjRh3Wo4LFjAOixRfyw8yAPoA=
X-Gm-Gg: ASbGnctU+sjj+ktxwknwVmfJtloXE3IUkGr4hnVc36ONPy0+NVqD18hs7wnxRVRDcKY
	/Py6asJyLY55Z0TaPI700fXypvpKGsBHXJT0woCWv3HOnvV+PDVxmPMy7os5TsPJ1n2B7L+REf7
	auPOmoPA23LXXSMuNjxwOHy/glEwvgQmBL45oxcOeKLRs+/NJcKPuzfE3rcYQHXWwvoUy39YyVW
	Lmrv8BztbtwuWYv3qlwXTxiQsergxx3A81EH7NarmFkUnre6z9K141H1QeAPZ4hjLk73u4cRECh
	0LQe6Fufyey9QNWIGN69Q/HNJMax
X-Google-Smtp-Source: AGHT+IFvlfPVqMCu2zkoZbhcnulgbZV3w347S9tQLlvr5tqQ00LyLOv3SR3w4dBEc2GE4tcYLaucAw==
X-Received: by 2002:a17:90b:5208:b0:2f7:4c7a:b5f with SMTP id 98e67ed59e1d1-2f82bfa1bc4mr3200150a91.2.1738040410254;
        Mon, 27 Jan 2025 21:00:10 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f7ffa5a7f7sm8212776a91.11.2025.01.27.21.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 21:00:10 -0800 (PST)
From: Atish Patra <atishp@rivosinc.com>
Date: Mon, 27 Jan 2025 20:59:54 -0800
Subject: [PATCH v3 13/21] RISC-V: perf: Add a mechanism to defined legacy
 event encoding
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250127-counter_delegation-v3-13-64894d7e16d5@rivosinc.com>
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
index c7adda948b5d..7742eb6d1ed2 100644
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
2.34.1

