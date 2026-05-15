Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76ECB37DEB4;
	Fri, 15 May 2026 06:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778825812; cv=none; b=UfIQADkd7N0+u4TlKEn4flZq4sphU5N4QwRUL7QHe7IkRkSjOwYlPQ4iPMMiOivTuuUnaYP4xQ403xJERpRIUQ9tLxA9AqGPM8BcVapNSKaT35R2GRFCmzOEtsLMVr+4rCSbZJ61tZaRJBpqETzKsA5lW5SObjctxQI/FDAhCF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778825812; c=relaxed/simple;
	bh=363o3DaURlplCn00BQG3lA+Skw/YKeruprdZ+pSyetE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CFJ7EEHMHONKQadfJl0LIgvOeKdgKVAkTOepk3oIug9a56mkn1vJi1pVMZ5kxYTVROdfU4Yq/pBrhVCHwEeL+3h8rpabuTtqcr675IiJ5Dt6/auDnWM4vnUpFCn3CKhXeKQ+xuihEcbhpd7qg/j0E9NL3OII+1+HChb6Z+wO1z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dtFkeHwp; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dtFkeHwp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778825812; x=1810361812;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=363o3DaURlplCn00BQG3lA+Skw/YKeruprdZ+pSyetE=;
  b=dtFkeHwpFpPK+LzcxeFewh1KwXhom2erPtLaxMmHbVo2dq0XaHlc64e6
   eZPIgMytpS6fy9pgmiu1hwntsXZ/i4hgPxvLZSqYzzFcLhQ28qYOcTOHK
   gsQ4ffCD2yBllwenGEVwxMeczilaZ/4TE+uGJJWQOLcEqewWdFDDzEQva
   9HMZuGxB86Y6O2GWWe+I11jI1yYh57CeQlutode1mzdmSA5GAqlXPBMCS
   9hlmzoKnuJ9etDtCMQIn5OHQHOrJ+oYFGvskPr5nhXC8Q3P43kPWTaA4t
   xKda2PBgBlgRmc21My88+o69OxIhx++KqE+DIvh/udg6e6o/b9qHiI112
   g==;
X-CSE-ConnectionGUID: waFNitG3RjmOCYLu3ql7zw==
X-CSE-MsgGUID: blZyp3MjTmK6VifxTbaHtw==
X-IronPort-AV: E=McAfee;i="6800,10657,11786"; a="79635919"
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="79635919"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2026 23:16:51 -0700
X-CSE-ConnectionGUID: 7NKnOL5GQgOXqXAutL/KrA==
X-CSE-MsgGUID: HViBV4KNS3eKql01hF+Wgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="235968430"
Received: from spr.sh.intel.com ([10.112.230.239])
  by fmviesa008.fm.intel.com with ESMTP; 14 May 2026 23:16:48 -0700
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
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [PATCH 03/11] perf/x86/intel: Update event constraints for DMR
Date: Fri, 15 May 2026 14:11:35 +0800
Message-Id: <20260515061143.338553-4-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260515061143.338553-1-dapeng1.mi@linux.intel.com>
References: <20260515061143.338553-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add missed event constraint for 0x0200 event and add comments to show
the event names in pnc_hw_cache_extra_regs[].

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/core.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index b3ccc785a4f6..0d0edc2d1b90 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -466,11 +466,12 @@ static struct extra_reg intel_lnc_extra_regs[] __read_mostly = {
 
 static struct event_constraint intel_pnc_event_constraints[] = {
 	FIXED_EVENT_CONSTRAINT(0x00c0, 0),	/* INST_RETIRED.ANY */
-	FIXED_EVENT_CONSTRAINT(0x0100, 0),	/* INST_RETIRED.PREC_DIST */
+	FIXED_EVENT_CONSTRAINT(0x0100, 0),	/* pseudo INST_RETIRED.ANY */
 	FIXED_EVENT_CONSTRAINT(0x003c, 1),	/* CPU_CLK_UNHALTED.CORE */
-	FIXED_EVENT_CONSTRAINT(0x0300, 2),	/* CPU_CLK_UNHALTED.REF */
+	FIXED_EVENT_CONSTRAINT(0x0200, 1),      /* pseudo CPU_CLK_UNHALTED.THREAD */
+	FIXED_EVENT_CONSTRAINT(0x0300, 2),	/* pseudo CPU_CLK_UNHALTED.REF_TSC */
 	FIXED_EVENT_CONSTRAINT(0x013c, 2),	/* CPU_CLK_UNHALTED.REF_TSC_P */
-	FIXED_EVENT_CONSTRAINT(0x0400, 3),	/* SLOTS */
+	FIXED_EVENT_CONSTRAINT(0x0400, 3),	/* pseudo TOPDOWN.SLOTS */
 	METRIC_EVENT_CONSTRAINT(INTEL_TD_METRIC_RETIRING, 0),
 	METRIC_EVENT_CONSTRAINT(INTEL_TD_METRIC_BAD_SPEC, 1),
 	METRIC_EVENT_CONSTRAINT(INTEL_TD_METRIC_FE_BOUND, 2),
@@ -821,12 +822,12 @@ static __initconst const u64 pnc_hw_cache_extra_regs
 {
  [ C(LL  ) ] = {
 	[ C(OP_READ) ] = {
-		[ C(RESULT_ACCESS) ] = 0x4000000000000001,
-		[ C(RESULT_MISS)   ] = 0xFFFFF000000001,
+		[ C(RESULT_ACCESS) ] = 0x4000000000000001,	/* OMR.DEMAND_DATA_RD.ANY_RESPONSE */
+		[ C(RESULT_MISS)   ] = 0xFFFFF000000001,	/* OMR.DEMAND_DATA_RD.L3_MISS */
 	},
 	[ C(OP_WRITE) ] = {
-		[ C(RESULT_ACCESS) ] = 0x4000000000000002,
-		[ C(RESULT_MISS)   ] = 0xFFFFF000000002,
+		[ C(RESULT_ACCESS) ] = 0x4000000000000002, 	/* OMR.DEMAND_RFO.ANY_RESPONSE */
+		[ C(RESULT_MISS)   ] = 0xFFFFF000000002,	/* OMR.DEMAND_RFO.L3_MISS */
 	},
  },
 };
-- 
2.34.1

