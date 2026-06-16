Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8396C3CC313;
	Tue, 16 Jun 2026 04:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781585572; cv=none; b=bGX8sVcYEtGKtr9Ablp+jU0eAY7xDzodTVRe0dKXkLpyG/JWDCpjt06NLa5x8Cgyu5jFF6pCpSVpBW0iD67Wl3QIGcL9rRP1FtWgBAWVcy6Ah/PAnMaoDyROmmsqxFDqEET8T1y4pFMsUZRNayUHs8GQ3iCtqykXdnDb92aQ7XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781585572; c=relaxed/simple;
	bh=s0XgtNysgzf7nYquLq39Lj6qcU45N3JbPRLtCUePeGk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AoMFmJLbUTiqu+QVGVRwsmQpAVNiffnyw4BWtOhA6fpZXV+14ABoQ1p2TkMFe4TxEwwv9EHSeWXjsqE0hksi3ZhJuFHVagnEg51S4NiHYeMKYoPrJ6HJYtCeqt4ay2mvEOIik7EPsznxfkSY8rK5sYJuMMuibuLguW7RsFmTipo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ec1pQzil; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ec1pQzil"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781585572; x=1813121572;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=s0XgtNysgzf7nYquLq39Lj6qcU45N3JbPRLtCUePeGk=;
  b=Ec1pQzil03eC9Xvq42CxjruusixMXrnk2hKh4+Rdm1pFx0DuFzBvLk80
   GdbLk9lhBhpn32/yPDOZX79Yss+G8OXCX44sidfwfBE3bNG42wPtY3IdK
   NqZpV/M76k982Nj0YUCMOC0hON418/1bJnegjdzAOFSHCrV4wOZmUPoz3
   L+rKWWPQv8WRhFgufz3GGJGNhSpNlteRXYaUHOySwVghK08TP0VexcFTn
   ZXyOK+CON9qygGZY+p9W9kl1M3rvlim8o8wRNThcGAeKbcBaqw8tVRFMa
   VCcn7FNiNTydmcAn03UZW8bVM6OOt1y+e0UoaxUkaH5AtlktZD4UzJqAb
   Q==;
X-CSE-ConnectionGUID: OWLIXzDdQBC5DNaT1X3Mtw==
X-CSE-MsgGUID: prcBm17uTmiVG4FuCRz08g==
X-IronPort-AV: E=McAfee;i="6800,10657,11818"; a="82445462"
X-IronPort-AV: E=Sophos;i="6.24,207,1774335600"; 
   d="scan'208";a="82445462"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2026 21:52:51 -0700
X-CSE-ConnectionGUID: lCaSKGxaSHKugUuKEA5Z5w==
X-CSE-MsgGUID: 75d+nE9KRaeU/PmJfGPy/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,207,1774335600"; 
   d="scan'208";a="271726487"
Received: from spr.sh.intel.com ([10.112.230.239])
  by fmviesa001.fm.intel.com with ESMTP; 15 Jun 2026 21:52:46 -0700
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
Subject: [Patch v4 6/8] perf/x86/intel: Drop fixed-counter PEBS constraints for baseline PEBS
Date: Tue, 16 Jun 2026 12:46:52 +0800
Message-Id: <20260616044654.3468742-7-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260616044654.3468742-1-dapeng1.mi@linux.intel.com>
References: <20260616044654.3468742-1-dapeng1.mi@linux.intel.com>
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

