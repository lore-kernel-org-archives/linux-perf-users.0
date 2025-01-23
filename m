Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581851E2309;
	Thu, 23 Jan 2025 06:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737613271; cv=none; b=ovXi8xuYKa9fDxUw6mpSt/j5HE27VHlywp9DW0EWgByVNulBQiGuI97WZg/ZbPPJ2DfOpYXhp0yalwnUKHTc9sHloqjje40uZrpKXd9TmPFeJwSanz8hMhG7fXuo3z9m4cOlrQtMgWLDevP6GzNONyfarP7ndnknLdCPRjdFZPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737613271; c=relaxed/simple;
	bh=ioaDTrDSThkgc8vgR2LRPC4o2BbK4SxoBXm+O75Bby8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jw9hjgug5GOYjn6xiIuwJLCNPfikCRodIeyA+Mnsa65EWcpGZPqrZG4EI5078MXuQ51Iv+vg45RqGfoOORco+DSDUmlbTiavBsefjEfRwbinPYSxdyBcUdOjV0L83PQwuoFQLEXipwlOMEY+DJrjvzSR5/2OuGRGgfWm3gOTw/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QG/KwjYc; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QG/KwjYc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737613271; x=1769149271;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ioaDTrDSThkgc8vgR2LRPC4o2BbK4SxoBXm+O75Bby8=;
  b=QG/KwjYcch07qN/M4ns8mYWq6sfAO1GxSPl4IqZcXx7r7gyscGt53wSr
   cdaD6MA2+SW8NOkDTQjoGULvaFYbRMtZOS6BB1TJASvCMxOgeLaN2UdOy
   0vrf5Ut9LT8n2xog+9mn4DZrIFVY2GZqzv+M04R8hfKD5f6A/izV78d0j
   ojIGPWonMdj5sRjYOIE5D+UDSIh01OmDNyadOyKH/lfWu+Z77NFKFuk8k
   Hw4kW6E9XOKxrnQ1uEXEZlhVJTLaHPAEhQGnXPU2PfG6JPgeczE2LRxbt
   QcFnYjBwLyXMj9ykCElhn/Bn8OtV8fbFXL2yO813tS3wlEVjMUF2O1My8
   g==;
X-CSE-ConnectionGUID: 93dawb6RQ2uazyuiI4V70w==
X-CSE-MsgGUID: v64EyHVSTdCJdUO6Kkb6dQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11323"; a="55513227"
X-IronPort-AV: E=Sophos;i="6.13,227,1732608000"; 
   d="scan'208";a="55513227"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2025 22:21:11 -0800
X-CSE-ConnectionGUID: oHuru5bCQwyRKOTSxBEBGg==
X-CSE-MsgGUID: MiVpjJGKTFe6Of+PFT4RhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="112334781"
Received: from emr.sh.intel.com ([10.112.229.56])
  by orviesa003.jf.intel.com with ESMTP; 22 Jan 2025 22:21:06 -0800
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
Subject: [PATCH 17/20] perf tools: Support to show SSP register
Date: Thu, 23 Jan 2025 14:07:18 +0000
Message-Id: <20250123140721.2496639-18-dapeng1.mi@linux.intel.com>
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

Add SSP register support.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 tools/arch/x86/include/uapi/asm/perf_regs.h    | 4 +++-
 tools/perf/arch/x86/util/perf_regs.c           | 2 ++
 tools/perf/util/intel-pt.c                     | 2 +-
 tools/perf/util/perf-regs-arch/perf_regs_x86.c | 2 ++
 4 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/arch/x86/include/uapi/asm/perf_regs.h b/tools/arch/x86/include/uapi/asm/perf_regs.h
index 7c9d2bb3833b..158e353070c3 100644
--- a/tools/arch/x86/include/uapi/asm/perf_regs.h
+++ b/tools/arch/x86/include/uapi/asm/perf_regs.h
@@ -27,9 +27,11 @@ enum perf_event_x86_regs {
 	PERF_REG_X86_R13,
 	PERF_REG_X86_R14,
 	PERF_REG_X86_R15,
+	PERF_REG_X86_SSP,
 	/* These are the limits for the GPRs. */
 	PERF_REG_X86_32_MAX = PERF_REG_X86_GS + 1,
-	PERF_REG_X86_64_MAX = PERF_REG_X86_R15 + 1,
+	PERF_REG_X86_64_MAX = PERF_REG_X86_SSP + 1,
+	PERF_REG_INTEL_PT_MAX = PERF_REG_X86_R15 + 1,
 
 	/* These all need two bits set because they are 128bit */
 	PERF_REG_X86_XMM0  = 32,
diff --git a/tools/perf/arch/x86/util/perf_regs.c b/tools/perf/arch/x86/util/perf_regs.c
index 12fd93f04802..9f492568f3b4 100644
--- a/tools/perf/arch/x86/util/perf_regs.c
+++ b/tools/perf/arch/x86/util/perf_regs.c
@@ -36,6 +36,8 @@ static const struct sample_reg sample_reg_masks[] = {
 	SMPL_REG(R14, PERF_REG_X86_R14),
 	SMPL_REG(R15, PERF_REG_X86_R15),
 #endif
+	SMPL_REG(SSP, PERF_REG_X86_SSP),
+
 	SMPL_REG2(XMM0, PERF_REG_X86_XMM0),
 	SMPL_REG2(XMM1, PERF_REG_X86_XMM1),
 	SMPL_REG2(XMM2, PERF_REG_X86_XMM2),
diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index 30be6dfe09eb..86196275c1e7 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -2139,7 +2139,7 @@ static u64 *intel_pt_add_gp_regs(struct regs_dump *intr_regs, u64 *pos,
 	u32 bit;
 	int i;
 
-	for (i = 0, bit = 1; i < PERF_REG_X86_64_MAX; i++, bit <<= 1) {
+	for (i = 0, bit = 1; i < PERF_REG_INTEL_PT_MAX; i++, bit <<= 1) {
 		/* Get the PEBS gp_regs array index */
 		int n = pebs_gp_regs[i] - 1;
 
diff --git a/tools/perf/util/perf-regs-arch/perf_regs_x86.c b/tools/perf/util/perf-regs-arch/perf_regs_x86.c
index 708954a9d35d..9a909f02bc04 100644
--- a/tools/perf/util/perf-regs-arch/perf_regs_x86.c
+++ b/tools/perf/util/perf-regs-arch/perf_regs_x86.c
@@ -54,6 +54,8 @@ const char *__perf_reg_name_x86(int id)
 		return "R14";
 	case PERF_REG_X86_R15:
 		return "R15";
+	case PERF_REG_X86_SSP:
+		return "ssp";
 
 #define XMM(x) \
 	case PERF_REG_X86_XMM ## x:	\
-- 
2.40.1

