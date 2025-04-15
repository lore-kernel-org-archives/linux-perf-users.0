Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F0728E5E7;
	Tue, 15 Apr 2025 08:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744705456; cv=none; b=AmnZWHIHF6Q3UmQyGgYvOjO4Hpi2Z1RW5LRsVCTizR/71ts6ozsApdzs/pwmSVe5EKr7auffxAf+DGHBz1y1gPn+18+3NobRKHRW6fu1//FCk3vZP/2hkOCZzH0/x2JxvzLV3N4tSKcYAmrNmoA62GYmrNJ/7FdsYaoglscc0v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744705456; c=relaxed/simple;
	bh=+Zt70Jq+vHmKxuWddWk27DeekEa3h2+uFWDNCqkphRI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=beDG0QzuAZ9UAZ/aXTP0BMpAO/4atWDnVnr+tUXbNqIGZC2BVj1Hltu1eJg8ruUHK/G8TxnGzflBcIgTcSZxVzYA0IRQcaJfKKYHwRCnACBapaGuGGrzhvqS7bMgMoKXRGotK1oh9dAe9BhaSPr3Wr8H+hqm/ceVv+CUORD2Mmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UxAktIya; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UxAktIya"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744705455; x=1776241455;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+Zt70Jq+vHmKxuWddWk27DeekEa3h2+uFWDNCqkphRI=;
  b=UxAktIyaW2V5Yb8pMrwRsdJZSIiQyU+ud4kWDZ7N9Kn2+CgdYO85utpa
   CTW3lxc9+vtCeWDzQT4nHphXtcfeqfI4nLkz5c5ySZxA4TIpRNnakFWvf
   vB43zL32HpI4wbEvBFp/fHkhiASDmUVcsYxf9v2JrJzFKpDOjIh4NvT4h
   sCiANCbEzCmQkN6zIIMejfiF0ndsLMIahG4Pn36OdWrFeJnonjiM2xWNV
   SQaerfjabSlPHm6XHzBRiiChqxSeOQF6+ILOTRZlGWufFuHLJUr9CWjTj
   u3ThEOu9mxj+ce+eU2UJmKEV/bB6ltVLzflJZlyygRUfXURXGmSFHbUM8
   g==;
X-CSE-ConnectionGUID: OMfphx9USMagEsEr7aVNjQ==
X-CSE-MsgGUID: umm89REhTk67ATgZ5tr3Sw==
X-IronPort-AV: E=McAfee;i="6700,10204,11403"; a="46116131"
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; 
   d="scan'208";a="46116131"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 01:24:15 -0700
X-CSE-ConnectionGUID: jnWOWEYrRM2EZAdHr2e5wQ==
X-CSE-MsgGUID: C5TglTvWTfWlXe1/z/b6hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; 
   d="scan'208";a="130055673"
Received: from emr.sh.intel.com ([10.112.229.56])
  by fmviesa007.fm.intel.com with ESMTP; 15 Apr 2025 01:24:11 -0700
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
Subject: [Patch v3 18/22] perf tools: Support to show SSP register
Date: Tue, 15 Apr 2025 11:44:24 +0000
Message-Id: <20250415114428.341182-19-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250415114428.341182-1-dapeng1.mi@linux.intel.com>
References: <20250415114428.341182-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add SSP register support.

Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 tools/arch/x86/include/uapi/asm/perf_regs.h    | 7 ++++++-
 tools/perf/arch/x86/util/perf_regs.c           | 2 ++
 tools/perf/util/intel-pt.c                     | 2 +-
 tools/perf/util/perf-regs-arch/perf_regs_x86.c | 2 ++
 4 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/tools/arch/x86/include/uapi/asm/perf_regs.h b/tools/arch/x86/include/uapi/asm/perf_regs.h
index 7c9d2bb3833b..1c7ab5af5cc1 100644
--- a/tools/arch/x86/include/uapi/asm/perf_regs.h
+++ b/tools/arch/x86/include/uapi/asm/perf_regs.h
@@ -27,9 +27,14 @@ enum perf_event_x86_regs {
 	PERF_REG_X86_R13,
 	PERF_REG_X86_R14,
 	PERF_REG_X86_R15,
+	/* arch-PEBS supports to capture shadow stack pointer (SSP) */
+	PERF_REG_X86_SSP,
 	/* These are the limits for the GPRs. */
 	PERF_REG_X86_32_MAX = PERF_REG_X86_GS + 1,
-	PERF_REG_X86_64_MAX = PERF_REG_X86_R15 + 1,
+	/* PERF_REG_X86_64_MAX used generally, for PEBS, etc. */
+	PERF_REG_X86_64_MAX = PERF_REG_X86_SSP + 1,
+	/* PERF_REG_INTEL_PT_MAX ignores the SSP register. */
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
index 4e8a9b172fbc..ad23973c9075 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -2179,7 +2179,7 @@ static u64 *intel_pt_add_gp_regs(struct regs_dump *intr_regs, u64 *pos,
 	u32 bit;
 	int i;
 
-	for (i = 0, bit = 1; i < PERF_REG_X86_64_MAX; i++, bit <<= 1) {
+	for (i = 0, bit = 1; i < PERF_REG_INTEL_PT_MAX; i++, bit <<= 1) {
 		/* Get the PEBS gp_regs array index */
 		int n = pebs_gp_regs[i] - 1;
 
diff --git a/tools/perf/util/perf-regs-arch/perf_regs_x86.c b/tools/perf/util/perf-regs-arch/perf_regs_x86.c
index 708954a9d35d..c0e95215b577 100644
--- a/tools/perf/util/perf-regs-arch/perf_regs_x86.c
+++ b/tools/perf/util/perf-regs-arch/perf_regs_x86.c
@@ -54,6 +54,8 @@ const char *__perf_reg_name_x86(int id)
 		return "R14";
 	case PERF_REG_X86_R15:
 		return "R15";
+	case PERF_REG_X86_SSP:
+		return "SSP";
 
 #define XMM(x) \
 	case PERF_REG_X86_XMM ## x:	\
-- 
2.40.1

