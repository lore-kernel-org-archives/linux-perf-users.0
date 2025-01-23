Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C761D1724;
	Thu, 23 Jan 2025 06:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737613242; cv=none; b=bo8uNjGdkufYOW1B49Es25laSlcPeB0C/2G9ubBBLP1URSryn6+sLYCfUzUNtIfc6B/89Zvtfpchrjt8zqTRMyv9FvzJSb2Ild3I4bDyYWGWx2wGvSXpasqMmto5hHIbbDpVGUf6kcxML+CBAItFZoB2MPnqlMA/fFj63H+oImY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737613242; c=relaxed/simple;
	bh=CvPk3wWDihTn8g7Y/3fuCoShzeKz2XJK+MWaNNvV3mM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lVDeCfhlRihvxXGsbCpAPtSnBoPB39zLZEne1vdEH7CpMAAZf/1I6NSPSULs1wbmN01dpZcqnajaVp4flsjDoa2xj9yWIMF893+qL14jInEG6qox3ov1CbKnnNagP3Gk912YGkTLvBUEOOwd0loWvG0ZaGPokHtQHZiOIbAzD/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EMCmyppV; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EMCmyppV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737613242; x=1769149242;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CvPk3wWDihTn8g7Y/3fuCoShzeKz2XJK+MWaNNvV3mM=;
  b=EMCmyppVWwJY4GW4OBkNm5napFUwHcG1R/Ra/YTRXO8yWF4q5/+XyQAq
   EuYdXai1ia1fnJjfKzgtQMuSNBLAWv/ia4gZptus+F35USVziTy48VuH+
   31B9tn84ZayAINSgMsw0J4cxr/m9VDTxyzvnBWT0lZZ1ybL2aOtvPpH59
   oV5Rjr53CrBbzq869AER3avRO/E+TY6gz+JHQaUGguLuC7MdW065pugUQ
   95087xiH1dSRBh63AZot6ZF3gW8iJyt+sJHX0y2IRKkVAZBfJlxmoAyB6
   DBaDYFXn/W6QnREOF0b3xPIu4oWUPnZkonfdCnz2acTEk2kGdso0Lw8cH
   A==;
X-CSE-ConnectionGUID: EbjNzhB5Q5eAVNW75IAxRA==
X-CSE-MsgGUID: S2NuWhZvRhq9N6tPA/my4g==
X-IronPort-AV: E=McAfee;i="6700,10204,11323"; a="55513113"
X-IronPort-AV: E=Sophos;i="6.13,227,1732608000"; 
   d="scan'208";a="55513113"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2025 22:20:41 -0800
X-CSE-ConnectionGUID: i8+8d8PkSWK3xS/TV34RNQ==
X-CSE-MsgGUID: 8UrWhZPoQya2o8W8VgNC3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="112334586"
Received: from emr.sh.intel.com ([10.112.229.56])
  by orviesa003.jf.intel.com with ESMTP; 22 Jan 2025 22:20:37 -0800
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [PATCH 09/20] perf/x86/intel: Factor out common functions to process PEBS groups
Date: Thu, 23 Jan 2025 14:07:10 +0000
Message-Id: <20250123140721.2496639-10-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250123140721.2496639-1-dapeng1.mi@linux.intel.com>
References: <20250123140721.2496639-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adaptive PEBS and arch-PEBS share lots of same code to process these
PEBS groups, like basic, GPR and meminfo groups. Extract these shared
code to common functions to avoid duplicated code.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/ds.c | 239 ++++++++++++++++++-------------------
 1 file changed, 119 insertions(+), 120 deletions(-)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 680637d63679..dce2b6ee8bd1 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -2061,6 +2061,91 @@ static inline void __setup_pebs_counter_group(struct cpu_hw_events *cpuc,
 
 #define PEBS_LATENCY_MASK			0xffff
 
+static inline void __setup_perf_sample_data(struct perf_event *event,
+					    struct pt_regs *iregs,
+					    struct perf_sample_data *data)
+{
+	perf_sample_data_init(data, 0, event->hw.last_period);
+	data->period = event->hw.last_period;
+
+	/*
+	 * We must however always use iregs for the unwinder to stay sane; the
+	 * record BP,SP,IP can point into thin air when the record is from a
+	 * previous PMI context or an (I)RET happened between the record and
+	 * PMI.
+	 */
+	perf_sample_save_callchain(data, event, iregs);
+}
+
+static inline void __setup_pebs_basic_group(struct perf_event *event,
+					    struct pt_regs *regs,
+					    struct perf_sample_data *data,
+					    u64 sample_type, u64 ip,
+					    u64 tsc, u16 retire)
+{
+	/* The ip in basic is EventingIP */
+	set_linear_ip(regs, ip);
+	regs->flags = PERF_EFLAGS_EXACT;
+	setup_pebs_time(event, data, tsc);
+
+	if (sample_type & PERF_SAMPLE_WEIGHT_STRUCT)
+		data->weight.var3_w = retire;
+}
+
+static inline void __setup_pebs_gpr_group(struct perf_event *event,
+					  struct pt_regs *regs,
+					  struct pebs_gprs *gprs,
+					  u64 sample_type)
+{
+	if (event->attr.precise_ip < 2) {
+		set_linear_ip(regs, gprs->ip);
+		regs->flags &= ~PERF_EFLAGS_EXACT;
+	}
+
+	if (sample_type & PERF_SAMPLE_REGS_INTR)
+		adaptive_pebs_save_regs(regs, gprs);
+}
+
+static inline void __setup_pebs_meminfo_group(struct perf_event *event,
+					      struct perf_sample_data *data,
+					      u64 sample_type, u64 latency,
+					      u16 instr_latency, u64 address,
+					      u64 aux, u64 tsx_tuning, u64 ax)
+{
+	if (sample_type & PERF_SAMPLE_WEIGHT_TYPE) {
+		u64 tsx_latency = intel_get_tsx_weight(tsx_tuning);
+
+		data->weight.var2_w = instr_latency;
+
+		/*
+		 * Although meminfo::latency is defined as a u64,
+		 * only the lower 32 bits include the valid data
+		 * in practice on Ice Lake and earlier platforms.
+		 */
+		if (sample_type & PERF_SAMPLE_WEIGHT)
+			data->weight.full = latency ?: tsx_latency;
+		else
+			data->weight.var1_dw = (u32)latency ?: tsx_latency;
+
+		data->sample_flags |= PERF_SAMPLE_WEIGHT_TYPE;
+	}
+
+	if (sample_type & PERF_SAMPLE_DATA_SRC) {
+		data->data_src.val = get_data_src(event, aux);
+		data->sample_flags |= PERF_SAMPLE_DATA_SRC;
+	}
+
+	if (sample_type & PERF_SAMPLE_ADDR_TYPE) {
+		data->addr = address;
+		data->sample_flags |= PERF_SAMPLE_ADDR;
+	}
+
+	if (sample_type & PERF_SAMPLE_TRANSACTION) {
+		data->txn = intel_get_tsx_transaction(tsx_tuning, ax);
+		data->sample_flags |= PERF_SAMPLE_TRANSACTION;
+	}
+}
+
 /*
  * With adaptive PEBS the layout depends on what fields are configured.
  */
@@ -2070,12 +2155,14 @@ static void setup_pebs_adaptive_sample_data(struct perf_event *event,
 					    struct pt_regs *regs)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+	u64 sample_type = event->attr.sample_type;
 	struct pebs_basic *basic = __pebs;
 	void *next_record = basic + 1;
-	u64 sample_type, format_group;
 	struct pebs_meminfo *meminfo = NULL;
 	struct pebs_gprs *gprs = NULL;
 	struct x86_perf_regs *perf_regs;
+	u64 format_group;
+	u16 retire;
 
 	if (basic == NULL)
 		return;
@@ -2083,32 +2170,17 @@ static void setup_pebs_adaptive_sample_data(struct perf_event *event,
 	perf_regs = container_of(regs, struct x86_perf_regs, regs);
 	perf_regs->xmm_regs = NULL;
 
-	sample_type = event->attr.sample_type;
 	format_group = basic->format_group;
-	perf_sample_data_init(data, 0, event->hw.last_period);
-	data->period = event->hw.last_period;
 
-	setup_pebs_time(event, data, basic->tsc);
-
-	/*
-	 * We must however always use iregs for the unwinder to stay sane; the
-	 * record BP,SP,IP can point into thin air when the record is from a
-	 * previous PMI context or an (I)RET happened between the record and
-	 * PMI.
-	 */
-	perf_sample_save_callchain(data, event, iregs);
+	__setup_perf_sample_data(event, iregs, data);
 
 	*regs = *iregs;
-	/* The ip in basic is EventingIP */
-	set_linear_ip(regs, basic->ip);
-	regs->flags = PERF_EFLAGS_EXACT;
 
-	if (sample_type & PERF_SAMPLE_WEIGHT_STRUCT) {
-		if (x86_pmu.flags & PMU_FL_RETIRE_LATENCY)
-			data->weight.var3_w = basic->retire_latency;
-		else
-			data->weight.var3_w = 0;
-	}
+	/* basic group */
+	retire = x86_pmu.flags & PMU_FL_RETIRE_LATENCY ?
+			basic->retire_latency : 0;
+	__setup_pebs_basic_group(event, regs, data, sample_type,
+				 basic->ip, basic->tsc, retire);
 
 	/*
 	 * The record for MEMINFO is in front of GP
@@ -2124,54 +2196,20 @@ static void setup_pebs_adaptive_sample_data(struct perf_event *event,
 		gprs = next_record;
 		next_record = gprs + 1;
 
-		if (event->attr.precise_ip < 2) {
-			set_linear_ip(regs, gprs->ip);
-			regs->flags &= ~PERF_EFLAGS_EXACT;
-		}
-
-		if (sample_type & PERF_SAMPLE_REGS_INTR)
-			adaptive_pebs_save_regs(regs, gprs);
+		__setup_pebs_gpr_group(event, regs, gprs, sample_type);
 	}
 
 	if (format_group & PEBS_DATACFG_MEMINFO) {
-		if (sample_type & PERF_SAMPLE_WEIGHT_TYPE) {
-			u64 latency = x86_pmu.flags & PMU_FL_INSTR_LATENCY ?
-					meminfo->cache_latency : meminfo->mem_latency;
-
-			if (x86_pmu.flags & PMU_FL_INSTR_LATENCY)
-				data->weight.var2_w = meminfo->instr_latency;
-
-			/*
-			 * Although meminfo::latency is defined as a u64,
-			 * only the lower 32 bits include the valid data
-			 * in practice on Ice Lake and earlier platforms.
-			 */
-			if (sample_type & PERF_SAMPLE_WEIGHT) {
-				data->weight.full = latency ?:
-					intel_get_tsx_weight(meminfo->tsx_tuning);
-			} else {
-				data->weight.var1_dw = (u32)latency ?:
-					intel_get_tsx_weight(meminfo->tsx_tuning);
-			}
-
-			data->sample_flags |= PERF_SAMPLE_WEIGHT_TYPE;
-		}
-
-		if (sample_type & PERF_SAMPLE_DATA_SRC) {
-			data->data_src.val = get_data_src(event, meminfo->aux);
-			data->sample_flags |= PERF_SAMPLE_DATA_SRC;
-		}
+		u64 latency = x86_pmu.flags & PMU_FL_INSTR_LATENCY ?
+				meminfo->cache_latency : meminfo->mem_latency;
+		u64 instr_latency = x86_pmu.flags & PMU_FL_INSTR_LATENCY ?
+				meminfo->instr_latency : 0;
+		u64 ax = gprs ? gprs->ax : 0;
 
-		if (sample_type & PERF_SAMPLE_ADDR_TYPE) {
-			data->addr = meminfo->address;
-			data->sample_flags |= PERF_SAMPLE_ADDR;
-		}
-
-		if (sample_type & PERF_SAMPLE_TRANSACTION) {
-			data->txn = intel_get_tsx_transaction(meminfo->tsx_tuning,
-							  gprs ? gprs->ax : 0);
-			data->sample_flags |= PERF_SAMPLE_TRANSACTION;
-		}
+		__setup_pebs_meminfo_group(event, data, sample_type, latency,
+					   instr_latency, meminfo->address,
+					   meminfo->aux, meminfo->tsx_tuning,
+					   ax);
 	}
 
 	if (format_group & PEBS_DATACFG_XMMS) {
@@ -2234,13 +2272,13 @@ static void setup_arch_pebs_sample_data(struct perf_event *event,
 					struct pt_regs *regs)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+	u64 sample_type = event->attr.sample_type;
 	struct arch_pebs_header *header = NULL;
 	struct arch_pebs_aux *meminfo = NULL;
 	struct arch_pebs_gprs *gprs = NULL;
 	struct x86_perf_regs *perf_regs;
 	void *next_record;
 	void *at = __pebs;
-	u64 sample_type;
 
 	if (at == NULL)
 		return;
@@ -2248,18 +2286,7 @@ static void setup_arch_pebs_sample_data(struct perf_event *event,
 	perf_regs = container_of(regs, struct x86_perf_regs, regs);
 	perf_regs->xmm_regs = NULL;
 
-	sample_type = event->attr.sample_type;
-	perf_sample_data_init(data, 0, event->hw.last_period);
-	data->period = event->hw.last_period;
-
-	/*
-	 * We must however always use iregs for the unwinder to stay sane; the
-	 * record BP,SP,IP can point into thin air when the record is from a
-	 * previous PMI context or an (I)RET happened between the record and
-	 * PMI.
-	 */
-	if (sample_type & PERF_SAMPLE_CALLCHAIN)
-		perf_sample_save_callchain(data, event, iregs);
+	__setup_perf_sample_data(event, iregs, data);
 
 	*regs = *iregs;
 
@@ -2268,16 +2295,14 @@ static void setup_arch_pebs_sample_data(struct perf_event *event,
 	next_record = at + sizeof(struct arch_pebs_header);
 	if (header->basic) {
 		struct arch_pebs_basic *basic = next_record;
+		u16 retire = 0;
 
-		/* The ip in basic is EventingIP */
-		set_linear_ip(regs, basic->ip);
-		regs->flags = PERF_EFLAGS_EXACT;
-		setup_pebs_time(event, data, basic->tsc);
+		next_record = basic + 1;
 
 		if (sample_type & PERF_SAMPLE_WEIGHT_STRUCT)
-			data->weight.var3_w = basic->valid ? basic->retire : 0;
-
-		next_record = basic + 1;
+			retire = basic->valid ? basic->retire : 0;
+		__setup_pebs_basic_group(event, regs, data, sample_type,
+				 basic->ip, basic->tsc, retire);
 	}
 
 	/*
@@ -2294,44 +2319,18 @@ static void setup_arch_pebs_sample_data(struct perf_event *event,
 		gprs = next_record;
 		next_record = gprs + 1;
 
-		if (event->attr.precise_ip < 2) {
-			set_linear_ip(regs, gprs->ip);
-			regs->flags &= ~PERF_EFLAGS_EXACT;
-		}
-
-		if (sample_type & PERF_SAMPLE_REGS_INTR)
-			adaptive_pebs_save_regs(regs, (struct pebs_gprs *)gprs);
+		__setup_pebs_gpr_group(event, regs, (struct pebs_gprs *)gprs,
+				       sample_type);
 	}
 
 	if (header->aux) {
-		if (sample_type & PERF_SAMPLE_WEIGHT_TYPE) {
-			u16 latency = meminfo->cache_latency;
-			u64 tsx_latency = intel_get_tsx_weight(meminfo->tsx_tuning);
+		u64 ax = gprs ? gprs->ax : 0;
 
-			data->weight.var2_w = meminfo->instr_latency;
-
-			if (sample_type & PERF_SAMPLE_WEIGHT)
-				data->weight.full = latency ?: tsx_latency;
-			else
-				data->weight.var1_dw = latency ?: (u32)tsx_latency;
-			data->sample_flags |= PERF_SAMPLE_WEIGHT_TYPE;
-		}
-
-		if (sample_type & PERF_SAMPLE_DATA_SRC) {
-			data->data_src.val = get_data_src(event, meminfo->aux);
-			data->sample_flags |= PERF_SAMPLE_DATA_SRC;
-		}
-
-		if (sample_type & PERF_SAMPLE_ADDR_TYPE) {
-			data->addr = meminfo->address;
-			data->sample_flags |= PERF_SAMPLE_ADDR;
-		}
-
-		if (sample_type & PERF_SAMPLE_TRANSACTION) {
-			data->txn = intel_get_tsx_transaction(meminfo->tsx_tuning,
-							  gprs ? gprs->ax : 0);
-			data->sample_flags |= PERF_SAMPLE_TRANSACTION;
-		}
+		__setup_pebs_meminfo_group(event, data, sample_type,
+					   meminfo->cache_latency,
+					   meminfo->instr_latency,
+					   meminfo->address, meminfo->aux,
+					   meminfo->tsx_tuning, ax);
 	}
 
 	if (header->xmm) {
-- 
2.40.1

