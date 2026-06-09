Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0D5363C77;
	Tue,  9 Jun 2026 05:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780981691; cv=none; b=hQeT6xjqi461iGtFqyLWoFbaElQXKl0JPd+kH1x+hxLog9SyctN8yO+kX8VbS0Ei8SthAIQW1XOLeNun63Bc9n97kKEyMGl/T68JqcBvOyGFbFtGxMNT3q7mLS3CMXuaNJUA9g4lfAR78yVw/6KdFtVsPcEKVUlTNti9GFCD0j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780981691; c=relaxed/simple;
	bh=d9C2tn7l7TBWtBWscp2bFWf2Su8H/WG01jblldosi9I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e68PK0JB7/EyMNv1TFy4h6r9uzGrda0mCGrm2CAGAJnp+0oW9KjyGm2xCFpPje3n+ZdrRpv/xxcWzQF0md3EnyogrPbgqfuBj7G2pggCJsdnhyVBCRafK+odJ+uCW7M9U7s/5EB3U15WGe84cYsdZIQaYvnfWTgNTQA/SiGkCiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FW4vy8W4; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FW4vy8W4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780981690; x=1812517690;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=d9C2tn7l7TBWtBWscp2bFWf2Su8H/WG01jblldosi9I=;
  b=FW4vy8W4RSSIOVDAb56DSB64Nf9gfWZKAnaA2fgM/feuwRd3b1hqMOz7
   xKsMjgKwlfzIxQivkIaa2Iuk+Gfvi+fB7lOqEak0tN+hFPCXPP1dAZfjY
   8TT5A4qi7zS9mu+DJG/6hUGTmbXGrXPJLzi74oUL/MSeEyLl6MPuYOy60
   OTPWLWce5M6PnyIitDV5ofwxjWnWMiCafe8QGFEqTmbTxIY2ku3B9/qUz
   msqv4XmZ9LAYfpl/D+eI+Fkvrnn5ZCH69XcDKtvQbptA/hCLRTswVLHc4
   dhjfcRbH0LRnkWz3VAqV6jGGbGcf4oQ5JxgeVh4NGamEv0dYbldYd+bE2
   A==;
X-CSE-ConnectionGUID: q8GAkpixT4yQ3+afYKY4Fg==
X-CSE-MsgGUID: DSbdiww9ROiA8jK54mIiPA==
X-IronPort-AV: E=McAfee;i="6800,10657,11811"; a="81586190"
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; 
   d="scan'208";a="81586190"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 22:08:10 -0700
X-CSE-ConnectionGUID: HidVHS7fRSGg6oWYxm9sRA==
X-CSE-MsgGUID: yIud2icMR6e8X7TpISLulg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; 
   d="scan'208";a="283838931"
Received: from spr.sh.intel.com ([10.112.230.239])
  by orviesa001.jf.intel.com with ESMTP; 08 Jun 2026 22:08:06 -0700
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
Subject: [Patch v2 7/9] perf/x86/intel: Drop fixed-counter PEBS constraints for baseline PEBS
Date: Tue,  9 Jun 2026 13:02:20 +0800
Message-Id: <20260609050222.2458129-8-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260609050222.2458129-1-dapeng1.mi@linux.intel.com>
References: <20260609050222.2458129-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On SPR guests where pebs_baseline is not advertised, running:

$ ./perf record -e cpu/event=0x00,umask=0x01,i\
	 name=INST_RETIRED.PREC_DIST/p -c 10000 sleep 1

can trigger:

unchecked MSR access error: WRMSR to 0x3f1 ... in\
	 intel_pmu_pebs_enable_all()

Root cause:
SPR-specific PEBS constraints allow fixed-counter scheduling,
for example INST_RETIRED.PREC_DIST on fixed counter 0. In guests without
pebs_baseline, KVM does not support PEBS sampling on fixed counters,
so enabling such events reaches an invalid MSR programming path.

Fix:
Drop fixed-counter entries from the PEBS constraint table. Without
pebs_baseline, those fixed-counter PEBS events now resolve to empty
constraints and are not scheduled/enabled, avoiding the warning and the
broken guest PEBS path.

This is safe because, in pebs_baseline-capable cases, PEBS constraint
lookup already falls back to non-PEBS constraints when needed, and
fixed-counter constraints are effectively shared there.

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

