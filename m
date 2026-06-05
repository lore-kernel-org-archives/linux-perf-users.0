Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A2636D503;
	Fri,  5 Jun 2026 01:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780622243; cv=none; b=ftz+2lqyt2tc27Pgi60wPDeSKVIfrXwEklyxLYRHinUHTKxHUj0YsPAQkovFaEN7KTYuuDmkgwvUu4Fe9omkwKeH4A4ADX+QPe7ZTFpYbbGZzDiTmH6g5sHxzBGm0CO6jz/cDOoYb3BnUHtrBejppiHH5sLZwxviVRYkfW44iAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780622243; c=relaxed/simple;
	bh=d9C2tn7l7TBWtBWscp2bFWf2Su8H/WG01jblldosi9I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rYQEDT64b6Soq36eIyOOibSqt5n6gFp0rw4dBk5A4amps2hknkxRBKLxllq/RnIBAvJPDYk9xkp/Iq3pKxgWnt/XkxWS4kz5A8WuGne3IcJJlPH2QH+WCkdX0NYDf+7AroxhMZECxnFLYMey07AfsmnFHwhRqTwd80S+u1w1z/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VPg8Gpmq; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VPg8Gpmq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780622237; x=1812158237;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=d9C2tn7l7TBWtBWscp2bFWf2Su8H/WG01jblldosi9I=;
  b=VPg8GpmqmNq8llkFPlzwdQMTqkvelORc8Us3eO0tLFBluFD7I4jeKkmj
   PAUhg8PEqMbyTSxsLmpM0SXiDV6WJHgH8t/Mq5PiZEfkzuQYCsHCuqCZf
   anbH0ohOi54XwafQJTv/C0xndcKCyDPm8y8bcZwhFb7rq4+O85NuCAdkP
   l76VX4eyOL1Ja4DK2bGtiNnHRTx2Q1jXV0vrTt/z8RAuSB17TpHtUk/Qw
   TjMUKzeIyJ9x8hhOyPB+NdHLUc13PSk4gD6Hy6sKnHDxi++xZoCFgSF6s
   PcAqZvEDNrgNYkoSLXzdROlWi1w7kotYDr2p3g4dIdL6E/MFrspnr1fe3
   g==;
X-CSE-ConnectionGUID: DIzXqmfkTLiliSL6JCsPrQ==
X-CSE-MsgGUID: wIvn/tOwSMa01M+oqJWC/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="91772213"
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; 
   d="scan'208";a="91772213"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 18:17:16 -0700
X-CSE-ConnectionGUID: lJ/qi7pzTHqOdI7qfLU6aw==
X-CSE-MsgGUID: xK01CeQFTGiPTFvxy4FOQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; 
   d="scan'208";a="244817163"
Received: from spr.sh.intel.com ([10.112.230.239])
  by orviesa007.jf.intel.com with ESMTP; 04 Jun 2026 18:17:13 -0700
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
Subject: [PATCH 7/8] perf/x86/intel: Drop fixed-counter PEBS constraints for baseline PEBS
Date: Fri,  5 Jun 2026 09:11:35 +0800
Message-Id: <20260605011136.2043393-8-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260605011136.2043393-1-dapeng1.mi@linux.intel.com>
References: <20260605011136.2043393-1-dapeng1.mi@linux.intel.com>
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

