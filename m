Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD42723314B
	for <linux-perf-users@vger.kernel.org>; Thu, 27 Mar 2025 19:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743104200; cv=none; b=nHGEYXId1YOXtQ2rpxB7aEglE6T3a/p2e4hESVDvkfxX5i/PHHTJ2GyOQuHRCo0ofNU4SuoPsLy1nA2CzTsZ3CuRodMJHI1Llx41x+9KxFFhLAWwjbpF5HKTjr1QX/Fvm3TyK6Xu3saI5qfsORgilwQupSKnK/QceWYGvn7Egc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743104200; c=relaxed/simple;
	bh=5Jdmw3jgWvYeS0zTyHlIxM0l/H/EvjQ/HA3IS77/J5E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ck1mpdfa9e6tSw5PazA8Un0nzHeEJ3wIplyx0HMJhu05LaqW0mVMl3xIpv3Qj/9HdxqmxFfItK6wlIr9jRdvWHJBmNnO72ALSk6VF0dV6GHya72IEsr7yy5D61PbYwGh6CFm3G5CHilJbldw/LG02J6o7bhoA+uZg4bxY2JpIs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=1b0jRxke; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="1b0jRxke"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3014cb646ecso1714581a91.1
        for <linux-perf-users@vger.kernel.org>; Thu, 27 Mar 2025 12:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1743104198; x=1743708998; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wclv7KMD22xenv1AEZe/Nvx9kd+X7FLj+t/yhjxf7eI=;
        b=1b0jRxkegdOj/rk+wtnZhHltjPNIJuvvEV/NdF6atdkgFqr6AG/vkHMk8hWZE5GXRX
         M8Y4LfNKpSoI/K+7cn6lJlFSQqTOivJsOZ5b09JrB0TJP3l0AsXdxXB9+baMF6VfZnDB
         3ciTY2ZK9/Cv6ozF0ByamBWaMD9pElzg8dea+Ity2Qorwp23rXLYyMks+vDjnIBIUfW/
         yz9+pqGf+YqXbErRNgd46OY45MfrkhQl4fictEp4J1771uD9xqMI08k3DtHj6/zvWN1r
         uLWhE2mOb31Q/Hv6hV2vH+CDLphATzBCpkVGfoMPiIbMak/OKdmcbseVqtrDG5qk15/f
         M1hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743104198; x=1743708998;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wclv7KMD22xenv1AEZe/Nvx9kd+X7FLj+t/yhjxf7eI=;
        b=g29Euf6x1SfDjAllA6x50sQEnyhusSclcv4RD65ifx5GLVeEzlaxoUAQ2BdVjKgsS0
         ZMQ7Fu70i1NQ6K+j2fxJO0Cg+8b1+HinvhsZdXNDUGrCy13hiO61QE5JaJzJHYxkfbcn
         0HuZQ8Sx3EcUE67h0kCLny6hcJWhKCfRBc2pMAlF5l0z8UubSkORF2S7EDoXfE46LWgz
         1iVFKewlBQFVmi8rPzDcY3KwRI+b6EXClLdcfIvJbn7azb4fo0FHO4fIGSDstg9gIKnM
         ly71X3AC2fYqtoe2MgJ3QcdeNeUD0oFfNG+d0lqxS/1vUcypVrm/c+33IaLFFK6ULeka
         liEA==
X-Forwarded-Encrypted: i=1; AJvYcCX72YvekxNo+Y53XzenAGdwAX0vvLzx67iywMaonVxiE5ZzSXF+DSJ7MMFWcMOgQFPjcRZ0qgjlC+U2I+kscxlJ@vger.kernel.org
X-Gm-Message-State: AOJu0YwhI/bNiErQPbTsS0jTkfkgMWE8ilr1IwkwiUg4iD9vXGNg0Wrw
	Gh+ef4NdvNcWwgrYBAjhogrPccNNdO22mHGX2BL5Q3958IQnFnATZdEHRphaqDQ=
X-Gm-Gg: ASbGncuKdpzvybUW1vLqthwXKYqPzn9O1AuViNrEcOoBwmDUjzyWjjf6RdJ5yOuCqx+
	bTZ39tZdhEb+Viy8zyx+od+9WMqfx8nYKkgoUDp+miYu5hYG5sFdZdB2qnjv6C1n8tZ4StRCqvv
	Tv90LwFGGfer8BXtCRPU9ojfln5pAwHxHRCwDGAY39LCU4d+2fAK1Yqs89i5XqIwqZIz2Lmmnbz
	v1HqCzC+LRWDTXqBoN+9C7KT+suNElWGAhA5+xl3KKzmYYo2reRHM7TNdgkEkqSamH1kVlkIvOi
	cbSLXLmcFPp3h3YAr+x8RqsxFKUrEYCNS0ENNnvcD9m8iDbe/gQNo5kc0w==
X-Google-Smtp-Source: AGHT+IGpvZ7sDwmBS5g3c0uLQouPDbWUaAld2oD0Poj2rMITq9x7PtP4FskafBH9EZEyuKfMYJGq4w==
X-Received: by 2002:a17:90b:2e8d:b0:2fa:e9b:33b3 with SMTP id 98e67ed59e1d1-303a7c5b918mr6255676a91.6.1743104197980;
        Thu, 27 Mar 2025 12:36:37 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3039f6b638csm2624220a91.44.2025.03.27.12.36.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 12:36:37 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
Date: Thu, 27 Mar 2025 12:35:57 -0700
Subject: [PATCH v5 16/21] RISC-V: perf: Use config2/vendor table for event
 to counter mapping
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250327-counter_delegation-v5-16-1ee538468d1b@rivosinc.com>
References: <20250327-counter_delegation-v5-0-1ee538468d1b@rivosinc.com>
In-Reply-To: <20250327-counter_delegation-v5-0-1ee538468d1b@rivosinc.com>
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
X-Mailer: b4 0.15-dev-42535

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
 drivers/perf/riscv_pmu_dev.c   | 79 ++++++++++++++++++++++++++++++++++--------
 include/linux/perf/riscv_pmu.h |  2 ++
 2 files changed, 67 insertions(+), 14 deletions(-)

diff --git a/drivers/perf/riscv_pmu_dev.c b/drivers/perf/riscv_pmu_dev.c
index d1cc8310423f..92ff42aca44b 100644
--- a/drivers/perf/riscv_pmu_dev.c
+++ b/drivers/perf/riscv_pmu_dev.c
@@ -76,6 +76,7 @@ static ssize_t __maybe_unused rvpmu_format_show(struct device *dev, struct devic
 	RVPMU_ATTR_ENTRY(_name, rvpmu_format_show, (char *)_config)
 
 PMU_FORMAT_ATTR(firmware, "config:62-63");
+PMU_FORMAT_ATTR(counterid_mask, "config2:0-31");
 
 static bool sbi_v2_available;
 static DEFINE_STATIC_KEY_FALSE(sbi_pmu_snapshot_available);
@@ -119,6 +120,7 @@ static const struct attribute_group *riscv_sbi_pmu_attr_groups[] = {
 static struct attribute *riscv_cdeleg_pmu_formats_attr[] = {
 	RVPMU_FORMAT_ATTR_ENTRY(event, RVPMU_CDELEG_PMU_FORMAT_ATTR),
 	&format_attr_firmware.attr,
+	&format_attr_counterid_mask.attr,
 	NULL,
 };
 
@@ -1381,24 +1383,77 @@ static int rvpmu_deleg_find_ctrs(void)
 	return num_hw_ctr;
 }
 
+/*
+ * The json file must correctly specify counter 0 or counter 2 is available
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
 
@@ -1427,10 +1482,6 @@ static int rvpmu_deleg_ctr_get_idx(struct perf_event *event)
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
2.43.0

