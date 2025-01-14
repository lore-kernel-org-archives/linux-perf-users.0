Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7C7227571
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Jan 2025 22:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736895529; cv=none; b=P3srgWkaeGAzGMsJL/rVfYuLsCahR2jowBFzjqtwnQsqpeje0Na+HLe2txCzSAlqtv9D4ByE6SuriV4uvg2rF5sbg14jTmPBvp1HaF8PfsSGBWtZSNSl+q18STF3P9bz2RQrjxNIihN9Vit3otfeO2YYk/5MckcB3JwaciO30a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736895529; c=relaxed/simple;
	bh=I1BUHXefgcvXV+llh09yE8pbz5zop+4y6ZtBb+wl4Bs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fuRvTpiMN5tprTbOoO4cWN2peqKQlTxgwfgRPy0OlgEyu4xgvt32DT5+L2ptkRdqjYLjPmAfJyD+gaqYS8cEEtC/3+6DVkSo+x95HyV0K5Ax1xiXFp3C+hEuttvLAam8qG6UHrlJR3VCzK/gvz3O6kBXkGAibbb1lfGT35eHEZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=rbH0gkup; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="rbH0gkup"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2165448243fso131791235ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Jan 2025 14:58:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1736895526; x=1737500326; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6Y0M33imgYQ7iOQMj5lBrHLPaiCzYIUYZ4s5QSMsm/8=;
        b=rbH0gkupkEgItMV3BTnJNMg67biEk1pNPzFdA51jDwyDDMUAGhGsj9JMXHa/OrUZhw
         b0OFIZO2M3QZqAW/4WGjBKMg5plhjJZTZcyBi3zLHA3sQ2NwtKhkhfKfHI0QbjZHR8UP
         Mg12o+QUjct7orsDJAyZqn1ZIqMJd8V5rFKPpGHLp01uPAKKDMAQJHO5W0+SYFAd/wps
         2WzURLO3kH/5iz2khct4VlwGslXAQvCCKc7ExUU3wtkBvTf+7qiZqqPt8NX5r+G/3oHL
         en1r1+fhvkSuXa4gm3TOV2UEp/q/sgkrTksSu/oGi0pCCB69zwOGPRhdPq8+gS4CuvNU
         /nNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736895526; x=1737500326;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Y0M33imgYQ7iOQMj5lBrHLPaiCzYIUYZ4s5QSMsm/8=;
        b=Am4LOR81ERsvUYumbbj1d1g7S5fOCQEnK147fyNiGk0tpS0D5FV8P7cjoODE+CkzAQ
         CgMOtOyWFoBIgJGJvm/Q9v4x/wCaJaAlchh4ndDmeZirLjXOj5M3tlXybuEVtK6O+/EP
         SDB8Df9n2vUOOY56KlCLtHq7APKkDqsp59cno2Sk1S1l/NDTG4eh74O33Wtp+hegKp8P
         NsNdhF8YOaWzSh7efFR/WeqeWLbau9N14de9wiWXRwiKHuOCfzGfnMiNCTvX6ZrC+NqE
         G8AeHXtNnwudVn1yCeieSfMQHgoH1uFZ1pLYkIIg66440pMj/jSOYahVhfVQFBa8kzWB
         8TrQ==
X-Forwarded-Encrypted: i=1; AJvYcCW58SSWQMQJuKzUa958ifPn0d24dUagJ9m/HHGFI1KqEdjvhL9in4DxC9JRy12ykOOoKef9lDDBrHOJIzS+jG0Y@vger.kernel.org
X-Gm-Message-State: AOJu0YxR5XagvpOv7oODXJH1stKIt6UJO9DyfIeKUTlxOIDMu0DuxRYt
	DwcamRI9MI0JtO3U621X90cWjs87bod2nkuaeSC3EK0DCK15Afvwd68YYdKDctI=
X-Gm-Gg: ASbGncvQ4rnw6pVT+Tz9OqYXR4QjbLJqmnDHALSUitVcNxjsNkC6J8ADqHNfRkeZRyr
	Nk1kCtGzLsTHYDxEhqeFWpoBz0sMr1q18MG63Rfx6A4rZxwSOcMfZz+yhmkiY2/FMc+fI9OhYkL
	qhLZ5/ODKvZE0ka/GSsj+dEFf5Ne+8UntUXBX42N2KK6BRTE4MI403UIfmXZTqRcVJq7OovbG3m
	au+QkvwBYsbjQaJnyep/gg2VKffjE2NvlCvyy83H+GQHq3bvxgBWGVlOk5/ZaIzbA6JBQ==
X-Google-Smtp-Source: AGHT+IHqzS/Vjctf50pHiq//oKQavezwc50tWzvRtyLeDE1EG5BvxcMNH9WLo20EpXnOKe7Qia3Q0Q==
X-Received: by 2002:a17:902:d2d0:b0:216:45b9:439b with SMTP id d9443c01a7336-21a8400a357mr420464835ad.50.1736895526354;
        Tue, 14 Jan 2025 14:58:46 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f10df7asm71746105ad.47.2025.01.14.14.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 14:58:46 -0800 (PST)
From: Atish Patra <atishp@rivosinc.com>
Date: Tue, 14 Jan 2025 14:57:41 -0800
Subject: [PATCH v2 16/21] RISC-V: perf: Use config2/vendor table for event
 to counter mapping
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250114-counter_delegation-v2-16-8ba74cdb851b@rivosinc.com>
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
 linux-perf-users@vger.kernel.org, Atish Patra <atishp@rivosinc.com>
X-Mailer: b4 0.15-dev-13183

The counter restriction specified in the json file is passed to
the drivers via config2 paarameter in perf attributes. This allows
any platform vendor to define their custom mapping between event and
hpmcounters without any rules defined in the ISA.

For legacy events, the platform vendor may define the mapping in
the driver in the vendor event table.
The fixed cycle and instruction counters are fixed (0 and 2
respectively) by the ISA and maps to the legacy events. The platform
vendor must specify this in the driver if intended to be used while
profiling. Otherwise, they can just specify the alternate hpmcounters
that may monitor and/or sample the cycle/instruction counts.

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 drivers/perf/riscv_pmu_dev.c   | 78 ++++++++++++++++++++++++++++++++++--------
 include/linux/perf/riscv_pmu.h |  2 ++
 2 files changed, 66 insertions(+), 14 deletions(-)

diff --git a/drivers/perf/riscv_pmu_dev.c b/drivers/perf/riscv_pmu_dev.c
index 83e7d1f6b016..8c5e2474fb7d 100644
--- a/drivers/perf/riscv_pmu_dev.c
+++ b/drivers/perf/riscv_pmu_dev.c
@@ -76,6 +76,7 @@ static ssize_t __maybe_unused rvpmu_format_show(struct device *dev, struct devic
 	RVPMU_ATTR_ENTRY(_name, rvpmu_format_show, (char *)_config)
 
 PMU_FORMAT_ATTR(firmware, "config:62-63");
+PMU_FORMAT_ATTR(counterid_mask, "config2:0-31");
 
 static bool sbi_v2_available;
 static DEFINE_STATIC_KEY_FALSE(sbi_pmu_snapshot_available);
@@ -112,6 +113,7 @@ static const struct attribute_group *riscv_sbi_pmu_attr_groups[] = {
 static struct attribute *riscv_cdeleg_pmu_formats_attr[] = {
 	RVPMU_FORMAT_ATTR_ENTRY(event, RVPMU_CDELEG_PMU_FORMAT_ATTR),
 	&format_attr_firmware.attr,
+	&format_attr_counterid_mask.attr,
 	NULL,
 };
 
@@ -1390,24 +1392,76 @@ static int rvpmu_deleg_find_ctrs(void)
 	return num_hw_ctr;
 }
 
+/* The json file must correctly specify counter 0 or counter 2 is available
+ * in the counter lists for cycle/instret events. Otherwise, the drivers have
+ * no way to figure out if a fixed counter must be used and pick a programmable
+ * counter if available.
+ */
 static int get_deleg_fixed_hw_idx(struct cpu_hw_events *cpuc, struct perf_event *event)
 {
-	return -EINVAL;
+	struct hw_perf_event *hwc = &event->hw;
+	bool guest_events = event->attr.config1 & RISCV_PMU_CONFIG1_GUEST_EVENTS;
+
+	if (guest_events) {
+		if (hwc->event_base == SBI_PMU_HW_CPU_CYCLES)
+			return 0;
+		if (hwc->event_base == SBI_PMU_HW_INSTRUCTIONS)
+			return 2;
+		else
+			return -EINVAL;
+	}
+
+	if (!event->attr.config2)
+		return -EINVAL;
+
+	if (event->attr.config2 & RISCV_PMU_CYCLE_FIXED_CTR_MASK)
+		return 0; /* CY counter */
+	else if (event->attr.config2 & RISCV_PMU_INSTRUCTION_FIXED_CTR_MASK)
+		return 2; /* IR counter */
+	else
+		return -EINVAL;
 }
 
 static int get_deleg_next_hpm_hw_idx(struct cpu_hw_events *cpuc, struct perf_event *event)
 {
-	unsigned long hw_ctr_mask = 0;
+	u32 hw_ctr_mask = 0, temp_mask = 0;
+	u32 type = event->attr.type;
+	u64 config = event->attr.config;
+	int ret;
 
-	/*
-	 * TODO: Treat every hpmcounter can monitor every event for now.
-	 * The event to counter mapping should come from the json file.
-	 * The mapping should also tell if sampling is supported or not.
-	 */
+	/* Select only available hpmcounters */
+	hw_ctr_mask = cmask & (~0x7) & ~(cpuc->used_hw_ctrs[0]);
+
+	switch (type) {
+	case PERF_TYPE_HARDWARE:
+		temp_mask = current_pmu_hw_event_map[config].counter_mask;
+		break;
+	case PERF_TYPE_HW_CACHE:
+		ret = cdeleg_pmu_event_find_cache(config, NULL, &temp_mask);
+		if (ret)
+			return ret;
+		break;
+	case PERF_TYPE_RAW:
+		/*
+		 * Mask off the counters that can't monitor this event (specified via json)
+		 * The counter mask for this event is set in config2 via the property 'Counter'
+		 * in the json file or manual configuration of config2. If the config2 is not set,
+		 * it is assumed all the available hpmcounters can monitor this event.
+		 * Note: This assumption may fail for virtualization use case where they hypervisor
+		 * (e.g. KVM) virtualizes the counter. Any event to counter mapping provided by the
+		 * guest is meaningless from a hypervisor perspective. Thus, the hypervisor doesn't
+		 * set config2 when creating kernel counter and relies default host mapping.
+		 */
+		if (event->attr.config2)
+			temp_mask = event->attr.config2;
+		break;
+	default:
+		break;
+	}
+
+	if (temp_mask)
+		hw_ctr_mask &= temp_mask;
 
-	/* Select only hpmcounters */
-	hw_ctr_mask = cmask & (~0x7);
-	hw_ctr_mask &= ~(cpuc->used_hw_ctrs[0]);
 	return __ffs(hw_ctr_mask);
 }
 
@@ -1436,10 +1490,6 @@ static int rvpmu_deleg_ctr_get_idx(struct perf_event *event)
 	u64 priv_filter;
 	int idx;
 
-	/*
-	 * TODO: We should not rely on SBI Perf encoding to check if the event
-	 * is a fixed one or not.
-	 */
 	if (!is_sampling_event(event)) {
 		idx = get_deleg_fixed_hw_idx(cpuc, event);
 		if (idx == 0 || idx == 2) {
diff --git a/include/linux/perf/riscv_pmu.h b/include/linux/perf/riscv_pmu.h
index 9e2758c32e8b..e58f83811988 100644
--- a/include/linux/perf/riscv_pmu.h
+++ b/include/linux/perf/riscv_pmu.h
@@ -30,6 +30,8 @@
 #define RISCV_PMU_CONFIG1_GUEST_EVENTS 0x1
 
 #define RISCV_PMU_DELEG_RAW_EVENT_MASK GENMASK_ULL(55, 0)
+#define RISCV_PMU_CYCLE_FIXED_CTR_MASK 0x01
+#define RISCV_PMU_INSTRUCTION_FIXED_CTR_MASK 0x04
 
 #define HW_OP_UNSUPPORTED		0xFFFF
 #define CACHE_OP_UNSUPPORTED		0xFFFF

-- 
2.34.1

