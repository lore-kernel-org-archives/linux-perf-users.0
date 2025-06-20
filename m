Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53FC222D4FA;
	Fri, 20 Jun 2025 07:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750404567; cv=none; b=e1IUdEolrV0RfTPsWbb3P72LjUwLu5F2i06f4ek0Wb3qp9lIhGkFcI7qUVYWhSIaSwGD2+49MFGXxlIxIYdlY2eikVgCG93zpiWRPbELtdiZrpoEYui/RzGCWNy5JqxLOKyo+9lue9ZsYBNAe0Qe3hP0mkzqmh7NY9+zZsc4Rf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750404567; c=relaxed/simple;
	bh=PpzPLWdDuelV/vLGfLs1EZUny2vY0LDyLXpweAcXeJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lY1BdwvOH2uq/3RLgVDotSqn9AAEe2TpFsSK9X8i3xPaNZ19CYio3/K75GddvZlAhuTdFfvwZ59lvTG5uBsi+pHjRQMPtJIp6AVoPNZVkmfREji+hVwYoeTW9kTPnOrm0Pgd5jThzvqmN5EMQDUX/l1vmBvP2uR1P+L8U3Wwdo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VpKomr28; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VpKomr28"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750404565; x=1781940565;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PpzPLWdDuelV/vLGfLs1EZUny2vY0LDyLXpweAcXeJ8=;
  b=VpKomr28wN1MgqBOpUc0fDS79nCFV99ytevdGFOHsOvf12IyhgCeULYW
   uH2CNdeJsFVV6ku1cVj/dfu2ctMsXpbhKyV3ytvsfsonwu+PySkMn/3JH
   vmYJTIG6Xe1zaItW031/aRj6ohAy2UsWDoeSu2218LD8yjzk75KnfRGcB
   8bfpedElPxcqaOCt5Ulcta3h1O6mT7yrdcPGJD8ofCZuepV8UmbIr8sPr
   qHwZESN6kZZf/r1BXxIWab9iSjaMniZMh5k9TLYjdHSgqXrBW2CQqq8iP
   tsGJS3bHV3102EDuWEX+B8e9q1twqIyNPf4BaXRXuKomzlaZpUpnngO1t
   g==;
X-CSE-ConnectionGUID: L9c3JTH/S8+5yxWTgINydg==
X-CSE-MsgGUID: F8bi7QZ1SxWbOJ0A/EePZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="51887748"
X-IronPort-AV: E=Sophos;i="6.16,250,1744095600"; 
   d="scan'208";a="51887748"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2025 00:29:25 -0700
X-CSE-ConnectionGUID: OYnvj+JsSS+KLvKolfhRbw==
X-CSE-MsgGUID: 8UvwqDuPRbqvTSXzSRAqRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,250,1744095600"; 
   d="scan'208";a="156651005"
Received: from emr.sh.intel.com ([10.112.229.56])
  by orviesa005.jf.intel.com with ESMTP; 20 Jun 2025 00:29:22 -0700
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
Subject: [Patch v4 05/13] perf/x86/intel/ds: Factor out PEBS group processing code to functions
Date: Fri, 20 Jun 2025 10:39:01 +0000
Message-ID: <20250620103909.1586595-6-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250620103909.1586595-1-dapeng1.mi@linux.intel.com>
References: <20250620103909.1586595-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adaptive PEBS and arch-PEBS share lots of same code to process these
PEBS groups, like basic, GPR and meminfo groups. Extract these shared
code to generic functions to avoid duplicated code.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/ds.c | 170 +++++++++++++++++++++++--------------
 1 file changed, 104 insertions(+), 66 deletions(-)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 1d95e7313cac..4fdb1c59a907 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -2072,6 +2072,90 @@ static inline void __setup_pebs_counter_group(struct cpu_hw_events *cpuc,
 
 #define PEBS_LATENCY_MASK			0xffff
 
+static inline void __setup_perf_sample_data(struct perf_event *event,
+					    struct pt_regs *iregs,
+					    struct perf_sample_data *data)
+{
+	perf_sample_data_init(data, 0, event->hw.last_period);
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
+	if (sample_type & (PERF_SAMPLE_REGS_INTR | PERF_SAMPLE_REGS_USER))
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
@@ -2081,12 +2165,14 @@ static void setup_pebs_adaptive_sample_data(struct perf_event *event,
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
@@ -2094,31 +2180,17 @@ static void setup_pebs_adaptive_sample_data(struct perf_event *event,
 	perf_regs = container_of(regs, struct x86_perf_regs, regs);
 	perf_regs->xmm_regs = NULL;
 
-	sample_type = event->attr.sample_type;
 	format_group = basic->format_group;
-	perf_sample_data_init(data, 0, event->hw.last_period);
 
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
@@ -2134,54 +2206,20 @@ static void setup_pebs_adaptive_sample_data(struct perf_event *event,
 		gprs = next_record;
 		next_record = gprs + 1;
 
-		if (event->attr.precise_ip < 2) {
-			set_linear_ip(regs, gprs->ip);
-			regs->flags &= ~PERF_EFLAGS_EXACT;
-		}
-
-		if (sample_type & (PERF_SAMPLE_REGS_INTR | PERF_SAMPLE_REGS_USER))
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
+		u64 latency = x86_pmu.flags & PMU_FL_INSTR_LATENCY ?
+				meminfo->cache_latency : meminfo->mem_latency;
+		u64 instr_latency = x86_pmu.flags & PMU_FL_INSTR_LATENCY ?
+				meminfo->instr_latency : 0;
+		u64 ax = gprs ? gprs->ax : 0;
+
+		__setup_pebs_meminfo_group(event, data, sample_type, latency,
+					   instr_latency, meminfo->address,
+					   meminfo->aux, meminfo->tsx_tuning,
+					   ax);
 	}
 
 	if (format_group & PEBS_DATACFG_XMMS) {
-- 
2.43.0

