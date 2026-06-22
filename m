Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734963911AA
	for <linux-perf-users@vger.kernel.org>; Mon, 22 Jun 2026 08:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782115573; cv=none; b=tdL5CbpOMtnfO8DbUOh4X/z9OjTYj4c/nhx2iEfsAqglATm2pb3R7NBeVBBFxfZsvvUcSMFJCxDyc2IxLmQzUs3i2TEfSoYnUiIyECI+5fJYaMUw9wODhMJw3DeNdM8T3shDf8PP65/zDirmynRi6E/PqpHCRvCYr2pbWS1NSII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782115573; c=relaxed/simple;
	bh=Kwwgbw1c4sNaNps+UkFAOdg2N3E8N3eKKSNyw1Szguc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GJLYLh05Gzsi3O1BhK1n8jrsQR3NlJUQHRIRsruXKQB3ZTfkBeCSBD1SRfr4IiYmHnYYHW6pTP06mQ5azLux7ooIZfMQGt8bFyL1K4QssRep8FLB4XT3984g240cTmaJVhg7Jl4jAUP2PemrcX8lKrYCTEu2Byy33fXylrs3OT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gnngztz0; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gnngztz0"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782115569;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8zUNI9RJNq07LMnKcfhWgwPKCHhzpkeqRorfVP+Mqdc=;
	b=gnngztz0xhq0dGORb+pF2pUeGmV88Pt2sW8XHWQFe4Nd7I9X72pImb62OwET+CAnlQ1ZUw
	y6UupTBkIxs4wIJPz1pT+uEFkowC3BtU3bP096y6kbVuDiLArBxtqtO4GjlYCJjg6gTyL6
	9MQyfCQUeLwAJLXgBTIE/fJl0aklBV4=
From: Atish Patra <atish.patra@linux.dev>
Date: Mon, 22 Jun 2026 01:04:28 -0700
Subject: [PATCH v7 16/22] RISC-V: perf: Use config2/vendor table for event
 to counter mapping
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260622-counter_delegation-v7-16-0ba2fd34614e@meta.com>
References: <20260622-counter_delegation-v7-0-0ba2fd34614e@meta.com>
In-Reply-To: <20260622-counter_delegation-v7-0-0ba2fd34614e@meta.com>
To: Jiri Olsa <jolsa@kernel.org>, James Clark <james.clark@linaro.org>, 
 Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, Rob Herring <robh@kernel.org>, 
 Ian Rogers <irogers@google.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Anup Patel <anup@brainfault.org>, Paul Walmsley <pjw@kernel.org>, 
 Atish Patra <atish.patra@linux.dev>, Namhyung Kim <namhyung@kernel.org>
Cc: devicetree@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 Conor Dooley <conor@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
X-Migadu-Flow: FLOW_OUT

From: Atish Patra <atishp@rivosinc.com>

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
 drivers/perf/riscv_pmu_sbi.c   | 95 +++++++++++++++++++++++++++++++++++-------
 include/linux/perf/riscv_pmu.h |  2 +
 2 files changed, 81 insertions(+), 16 deletions(-)

diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
index 4f3a30143db1..1c846cdc96cf 100644
--- a/drivers/perf/riscv_pmu_sbi.c
+++ b/drivers/perf/riscv_pmu_sbi.c
@@ -77,6 +77,7 @@ static ssize_t __maybe_unused rvpmu_format_show(struct device *dev, struct devic
 	RVPMU_ATTR_ENTRY(_name, rvpmu_format_show, (char *)_config)
 
 PMU_FORMAT_ATTR(firmware, "config:62-63");
+PMU_FORMAT_ATTR(counterid_mask, "config2:0-31");
 
 static bool sbi_v2_available;
 static bool sbi_v3_available;
@@ -121,6 +122,7 @@ static const struct attribute_group *riscv_sbi_pmu_attr_groups[] = {
 static struct attribute *riscv_cdeleg_pmu_formats_attr[] = {
 	RVPMU_FORMAT_ATTR_ENTRY(event, RVPMU_CDELEG_PMU_FORMAT_ATTR),
 	&format_attr_firmware.attr,
+	&format_attr_counterid_mask.attr,
 	NULL,
 };
 
@@ -1501,24 +1503,85 @@ static int rvpmu_deleg_find_ctrs(void)
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
+	bool guest_events = event->attr.config1 & RISCV_PMU_CONFIG1_GUEST_EVENTS;
+	int idx;
+
+	/* event_base is 0 on the delegation path; match via the original perf attrs. */
+	if (guest_events) {
+		if (event->attr.type != PERF_TYPE_HARDWARE)
+			return -EINVAL;
+		if (event->attr.config == PERF_COUNT_HW_CPU_CYCLES)
+			idx = 0; /* CY counter */
+		else if (event->attr.config == PERF_COUNT_HW_INSTRUCTIONS)
+			idx = 2; /* IR counter */
+		else
+			return -EINVAL;
+	} else if (event->attr.config2 & RISCV_PMU_CYCLE_FIXED_CTR_MASK) {
+		idx = 0; /* CY counter */
+	} else if (event->attr.config2 & RISCV_PMU_INSTRUCTION_FIXED_CTR_MASK) {
+		idx = 2; /* IR counter */
+	} else {
+		return -EINVAL;
+	}
+
+	/* Take the fixed counter only if delegated and free, else fall back. */
+	if (!(cmask & BIT(idx)) || test_bit(idx, cpuc->used_hw_ctrs))
+		return -EINVAL;
+
+	return idx;
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
+
+	if (!hw_ctr_mask)
+		return -EINVAL;
 
-	/* Select only hpmcounters */
-	hw_ctr_mask = cmask & (~0x7);
-	hw_ctr_mask &= ~(cpuc->used_hw_ctrs[0]);
 	return __ffs(hw_ctr_mask);
 }
 
@@ -1547,10 +1610,6 @@ static int rvpmu_deleg_ctr_get_idx(struct perf_event *event)
 	u64 priv_filter;
 	int idx;
 
-	/*
-	 * TODO: We should not rely on SBI Perf encoding to check if the event
-	 * is a fixed one or not.
-	 */
 	if (!is_sampling_event(event)) {
 		idx = get_deleg_fixed_hw_idx(cpuc, event);
 		if (idx == 0 || idx == 2) {
@@ -1570,10 +1629,14 @@ static int rvpmu_deleg_ctr_get_idx(struct perf_event *event)
 		goto out_err;
 found_idx:
 	priv_filter = get_deleg_priv_filter_bits(event);
+	if (test_and_set_bit(idx, cpuc->used_hw_ctrs))
+		goto out_err;
 	update_deleg_hpmevent(idx, hwc->config, priv_filter);
+	return idx;
 skip_update:
-	if (!test_and_set_bit(idx, cpuc->used_hw_ctrs))
-		return idx;
+	if (test_and_set_bit(idx, cpuc->used_hw_ctrs))
+		goto out_err;
+	return idx;
 out_err:
 	return -ENOENT;
 }
diff --git a/include/linux/perf/riscv_pmu.h b/include/linux/perf/riscv_pmu.h
index 3c64151cb038..b23b71cb4e66 100644
--- a/include/linux/perf/riscv_pmu.h
+++ b/include/linux/perf/riscv_pmu.h
@@ -30,6 +30,8 @@
 #define RISCV_PMU_CONFIG1_GUEST_EVENTS 0x1
 
 #define RISCV_PMU_DELEG_RAW_EVENT_MASK GENMASK_ULL(55, 0)
+#define RISCV_PMU_CYCLE_FIXED_CTR_MASK 0x01
+#define RISCV_PMU_INSTRUCTION_FIXED_CTR_MASK 0x04
 
 struct cpu_hw_events {
 	/* currently enabled events */

-- 
2.53.0-Meta

