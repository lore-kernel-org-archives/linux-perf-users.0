Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8243988EB;
	Fri, 12 Jun 2026 09:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781255222; cv=none; b=pHpNDTFs0r75nECScdG+W9XQkGRx0IXRP7SCG0hNK/d4xy+JkyOyRZSUtrDswXtFFczBSe/W/B225yJqR0C7ogdRoa/la2dWH6cbJE8XdWGhxrUBcQKGjzrFnXyVD0oIR8H/jCb7mGqExWQ5S/vbmrNwIc9ui+A0aQqSeFSRW5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781255222; c=relaxed/simple;
	bh=s0XgtNysgzf7nYquLq39Lj6qcU45N3JbPRLtCUePeGk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GEO6tpdzSoaj4pboMbCTQHVk0SYsQJrgz83oThIRk8fDZukJ6uhpPUnRMEBOMqzHJOvh6kQ48qxWrnChikNYXDT9OOwGMxvmRNly/P6aQigfMLUDDyHSEBzeNB5Ocwgkg6D0Gbv8fSj9IAj+d/wg1wO/mQVzY/xYbvNEo2BWgbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hmR4A8ij; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hmR4A8ij"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781255215; x=1812791215;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=s0XgtNysgzf7nYquLq39Lj6qcU45N3JbPRLtCUePeGk=;
  b=hmR4A8ijm19YzrL/WFkdcw8tZhReL8aZgFoxT2Te/P36/5BEa+dCbtE+
   G4RFLov38AieJoDZ2EGVh09f0VJxfdWyRoAedKc5eWgh8IE1CjOU8viDQ
   q9vAyPx+xUZPnqewqkUdp8YkCTfCGbZ302nYvSUqAcMAHPmxSVfRR86sb
   Bq5QZPPsQZV86FgDoSLmyqLNeRg/CNePqkaQVWj/kcl/n5u3GmSeqUf8z
   gDgCLBtE7T2rZHavobCB2prQAo8AoD9bKXiLOZ2jWqP43hd5R5eLcJNiz
   gV0R8F3KQQj1X27U/lV1YQWj1gofhc1q14Kc3lXPOGrr4pX9zgq+6QagA
   g==;
X-CSE-ConnectionGUID: XYpQ1ZQbSN27mCue2HMvbA==
X-CSE-MsgGUID: CTvl+np2TLeyilJhTfyIYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="85714468"
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; 
   d="scan'208";a="85714468"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2026 02:06:55 -0700
X-CSE-ConnectionGUID: NVSzAAOeQvSr1mCScC4+tA==
X-CSE-MsgGUID: qOe8ABgKSCKtV+0FdWO6qg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; 
   d="scan'208";a="246838762"
Received: from spr.sh.intel.com ([10.112.230.239])
  by orviesa007.jf.intel.com with ESMTP; 12 Jun 2026 02:06:50 -0700
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Xudong Hao <xudong.hao@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Yi Lai <yi1.lai@intel.com>
Subject: [Patch v3 6/8] perf/x86/intel: Drop fixed-counter PEBS constraints for baseline PEBS
Date: Fri, 12 Jun 2026 17:01:12 +0800
Message-Id: <20260612090114.3188886-7-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260612090114.3188886-1-dapeng1.mi@linux.intel.com>
References: <20260612090114.3188886-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sapphire Rapids (SPR) guests where pebs_baseline is not advertised,
running command

$ ./perf record -e cpu/event=0x00,umask=0x01,i\
	 name=INST_RETIRED.PREC_DIST/p -c 10000 sleep 1

can trigger:

unchecked MSR access error: WRMSR to 0x3f1 ... in\
	 intel_pmu_pebs_enable_all()

This occurs because SPR-specific PEBS constraints allow fixed-counter
scheduling (for example, INST_RETIRED.PREC_DIST on fixed counter 0).
In guests lacking pebs_baseline, KVM does not support PEBS sampling on
fixed counters, so enabling such events reaches an invalid MSR
programming path.

Starting with Icelake, regardless of whether Extended PEBS or
Architectural PEBS is in use, all counters (including fixed counters)
support PEBS sampling, and the PMU_FL_PEBS_ALL flag is set by default.
As long as PMU_FL_PEBS_ALL is set, constraint lookup automatically falls
back to the corresponding non-PEBS constraints if no matching entry is
found in the PEBS constraints table. Since non-PEBS event constraints
already contain the same fixed-counter constraints, it is safe to remove
these fixed-counter entries from the PEBS constraints table. The fallback
mechanism will ensure that fixed PEBS events are scheduled onto the
correct fixed counters.

So, directly drop the fixed-counter entries from the PEBS constraint
table. Without pebs_baseline, these fixed-counter PEBS events will now
resolve to empty constraints and will not be scheduled or enabled,
thereby avoiding the warning and bypassing the broken guest PEBS path.

Reported-by: Yi Lai <yi1.lai@intel.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/ds.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index cb72af9b61ce..5db15a92017a 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1447,10 +1447,6 @@ struct event_constraint intel_skl_pebs_event_constraints[] = {
 };
 
 struct event_constraint intel_icl_pebs_event_constraints[] = {
-	INTEL_FLAGS_UEVENT_CONSTRAINT(0x01c0, 0x100000000ULL),	/* old INST_RETIRED.PREC_DIST */
-	INTEL_FLAGS_UEVENT_CONSTRAINT(0x0100, 0x100000000ULL),	/* INST_RETIRED.PREC_DIST */
-	INTEL_FLAGS_UEVENT_CONSTRAINT(0x0400, 0x800000000ULL),	/* SLOTS */
-
 	INTEL_PLD_CONSTRAINT(0x1cd, 0xff),			/* MEM_TRANS_RETIRED.LOAD_LATENCY */
 	INTEL_FLAGS_UEVENT_CONSTRAINT_DATALA_LD(0x11d0, 0xf),	/* MEM_INST_RETIRED.STLB_MISS_LOADS */
 	INTEL_FLAGS_UEVENT_CONSTRAINT_DATALA_ST(0x12d0, 0xf),	/* MEM_INST_RETIRED.STLB_MISS_STORES */
@@ -1473,9 +1469,6 @@ struct event_constraint intel_icl_pebs_event_constraints[] = {
 };
 
 struct event_constraint intel_glc_pebs_event_constraints[] = {
-	INTEL_FLAGS_UEVENT_CONSTRAINT(0x100, 0x100000000ULL),	/* INST_RETIRED.PREC_DIST */
-	INTEL_FLAGS_UEVENT_CONSTRAINT(0x0400, 0x800000000ULL),
-
 	INTEL_FLAGS_EVENT_CONSTRAINT(0xc0, 0xfe),
 	INTEL_PLD_CONSTRAINT(0x1cd, 0xfe),
 	INTEL_PSD_CONSTRAINT(0x2cd, 0x1),
@@ -1500,9 +1493,6 @@ struct event_constraint intel_glc_pebs_event_constraints[] = {
 };
 
 struct event_constraint intel_lnc_pebs_event_constraints[] = {
-	INTEL_FLAGS_UEVENT_CONSTRAINT(0x100, 0x100000000ULL),	/* INST_RETIRED.PREC_DIST */
-	INTEL_FLAGS_UEVENT_CONSTRAINT(0x0400, 0x800000000ULL),
-
 	INTEL_FLAGS_UEVENT_CONSTRAINT(0x012a, 0x1),		/* OCR.* events */
 	INTEL_FLAGS_UEVENT_CONSTRAINT(0x012b, 0x1),		/* OCR.* events */
 
@@ -1534,9 +1524,6 @@ struct event_constraint intel_lnc_pebs_event_constraints[] = {
 };
 
 struct event_constraint intel_pnc_pebs_event_constraints[] = {
-	INTEL_FLAGS_UEVENT_CONSTRAINT(0x100, 0x100000000ULL),	/* INST_RETIRED.PREC_DIST */
-	INTEL_FLAGS_UEVENT_CONSTRAINT(0x0400, 0x800000000ULL),
-
 	INTEL_HYBRID_LDLAT_CONSTRAINT(0x1cd, 0xfc),
 	INTEL_HYBRID_STLAT_CONSTRAINT(0x2cd, 0x3),
 	INTEL_FLAGS_UEVENT_CONSTRAINT_DATALA_LD(0x11d0, 0xf),	/* MEM_INST_RETIRED.STLB_MISS_LOADS */
-- 
2.34.1

