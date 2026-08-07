Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A3B470103
	for <linux-perf-users@vger.kernel.org>; Fri,  7 Aug 2026 08:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786090224; cv=none; b=tMm2vB8Wpk5N+tKR9KInqeWuZOboBvEzPSlrE3284VBaJ+abdGBjntZr+qdxAbzQBigMRNdj9+tvRmsg6Rvjd8+UUTDH5GlUWFB3zct69S2+DxR+IwjSILptxOp+SNX4t8DJz48OLk2BtmqVlmcwpi5/Gb4M1tGCW0mFy0wG8rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786090224; c=relaxed/simple;
	bh=n0qNFTTEWg2qHnZjQiDYT7NtCwPFw7dzbI70A37ugUw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I5srMQOg6U570nyFWiCKYq6871C5olaaGgpo5IQbI0+jiNixgWF36sGtQM0GnuzVW0kUwDseMBk/uBrEUNmSmRQvOc8zXAjggnEvVmqHFtg0mM+PMWnJ3N5uHG9Va8wRaPGdMw10xldtch8odISiJtGxY0HS7ts3J6JDO4e0G+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dx7fOvsZ; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dx7fOvsZ"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786090215;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iIY6Wq50I8iIoo+siWJwkhMe5kglxW8dX12vRaOg9xA=;
	b=dx7fOvsZErsyvv7Zpux7Ws1dnvVaQ5AI002QFU0n7O2kZGc0SOxPD5dZfvAEmiL6RugkMV
	g6KL6ghagePjeJzJjWB/JSfeE8FdAjwnkq9O8tveBBkO1tvYL31Df6jxXpSpke1kh6cp+x
	p65/sQSQquHCl3QugHko08H3leOs/dE=
From: Atish Patra <atish.patra@linux.dev>
Date: Fri, 07 Aug 2026 01:09:08 -0700
Subject: [PATCH v9 13/20] RISC-V: perf: Add a mechanism to defined legacy
 event encoding
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-counter_delegation-v9-13-58658104e487@meta.com>
References: <20260807-counter_delegation-v9-0-58658104e487@meta.com>
In-Reply-To: <20260807-counter_delegation-v9-0-58658104e487@meta.com>
To: Will Deacon <will@kernel.org>, Atish Patra <atish.patra@linux.dev>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Anup Patel <anup@brainfault.org>, Ian Rogers <irogers@google.com>, 
 Rob Herring <robh@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, Jiri Olsa <jolsa@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 James Clark <james.clark@linaro.org>, Namhyung Kim <namhyung@kernel.org>
Cc: linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 Conor Dooley <conor@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org
X-Migadu-Flow: FLOW_OUT

From: Atish Patra <atishp@rivosinc.com>

RISC-V ISA doesn't define any standard event encodings or specify
any event to counter mapping. Thus, event encoding information
and corresponding counter mapping fot those events needs to be
provided in the driver for each vendor.

Add a framework to support that. The individual platform events
will be added later.

Signed-off-by: Atish Patra <atishp@rivosinc.com>
Reviewed-by: Charlie Jenkins <thecharlesjenkins@gmail.com>
Tested-by: Charlie Jenkins <thecharlesjenkins@gmail.com>
---
 drivers/perf/riscv_pmu_sbi.c | 69 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 68 insertions(+), 1 deletion(-)

diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
index 1a1430059909..7afd79b0a29b 100644
--- a/drivers/perf/riscv_pmu_sbi.c
+++ b/drivers/perf/riscv_pmu_sbi.c
@@ -10,6 +10,7 @@
 
 #define pr_fmt(fmt) "riscv-pmu-sbi: " fmt
 
+#include <linux/limits.h>
 #include <linux/perf/riscv_pmu.h>
 #include <linux/platform_device.h>
 #include <linux/irq.h>
@@ -378,6 +379,70 @@ static int pmu_sbi_check_event_info(void)
 	return result;
 }
 
+/*
+ * Vendor specific PMU events.
+ */
+struct riscv_pmu_event {
+	u64 event_id;
+	u32 counterid_mask;
+};
+
+#define HW_OP_UNSUPPORTED		U64_MAX
+#define CACHE_OP_UNSUPPORTED		U64_MAX
+
+#define PERF_MAP_ALL_UNSUPPORTED					\
+	[0 ... PERF_COUNT_HW_MAX - 1] = {HW_OP_UNSUPPORTED, 0x0}
+
+#define PERF_CACHE_MAP_ALL_UNSUPPORTED					\
+[0 ... PERF_COUNT_HW_CACHE_MAX - 1] = {					\
+	[0 ... PERF_COUNT_HW_CACHE_OP_MAX - 1] = {			\
+		[0 ... PERF_COUNT_HW_CACHE_RESULT_MAX - 1] = {		\
+			CACHE_OP_UNSUPPORTED, 0x0			\
+		},							\
+	},								\
+}
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
+static const struct riscv_pmu_event *current_pmu_hw_event_map;
+static const struct riscv_pmu_event (*current_pmu_cache_event_map)[PERF_COUNT_HW_CACHE_OP_MAX]
+							   [PERF_COUNT_HW_CACHE_RESULT_MAX];
+
+static void __init rvpmu_vendor_register_events(void)
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
+	if (!current_pmu_hw_event_map && !current_pmu_cache_event_map)
+		pr_info("No default PMU events found\n");
+}
+
 static void rvpmu_sbi_check_event(struct sbi_pmu_event_data *edata)
 {
 	struct sbiret ret;
@@ -1681,8 +1746,10 @@ static int __init rvpmu_devinit(void)
 	 */
 	if (riscv_isa_extension_available(NULL, SSCCFG) &&
 	    riscv_isa_extension_available(NULL, SMCDELEG) &&
-	    riscv_isa_extension_available(NULL, SSCSRIND))
+	    riscv_isa_extension_available(NULL, SSCSRIND)) {
 		static_branch_enable(&riscv_pmu_cdeleg_available);
+		rvpmu_vendor_register_events();
+	}
 
 	if (!(riscv_pmu_sbi_available_boot() || riscv_pmu_cdeleg_available_boot()))
 		return 0;

-- 
2.53.0-Meta

