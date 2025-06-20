Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D9A234987;
	Fri, 20 Jun 2025 07:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750404596; cv=none; b=HtXSq4oJARGJw5abj3zfYBmBszVHIoqsHWkhr3V/mxtIEqHEBgnewD+0FE46fpoWLAr8/yZR17L4ReOaDcXLlzREviQ26pOil3+nZ1OQlsmd/UUByv69EHtBSvOU6RZyNYEcE78mQxSDjj3++3IoH9ZrkPu3okzjoG5r5yj6CL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750404596; c=relaxed/simple;
	bh=FBRShSaC7ObO9TPOdzCzNNsbgMLNbHPsVYAw1q8ahBE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Soe4Sfjzn8NaE0OWzcBM3DIQ/0YS/dMuq7mTHzVZfpgUtLyQfRhlfY36mR3LR3cZOgtY1UXz6BuRGnPPnUvt9sH5sItVMsIXvMbug1jRCp7uE39YdM+olgobtpZPI3v1icxhm6f8oGfBGkC4KRq4cMtCmpnRfyNRmt6nnDhiyxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=blzrgeGH; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="blzrgeGH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750404594; x=1781940594;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FBRShSaC7ObO9TPOdzCzNNsbgMLNbHPsVYAw1q8ahBE=;
  b=blzrgeGH833JeY45FuiolLm6dPdE1zTJaztgvf7UKdY0CAhaEt9sbWAl
   UUoXCTuRe4646A5NbhQusqt2taiMgU+tYpUJmU996P8Ofbvd2Mf/d69Me
   pl+1AEFJGmHyBd7nAMGFVzL+Op2tQ+GalmLIRhuHxPJHE5vl+z5RdRqL+
   UNRg7WaEQeMCE+vCP4DluruJ0rP1Gfi848NLiK1vwYAAz6wqyltJqKs6i
   GJ47NewdrFe6oZQzUrdr4m0E5RGfwnln+0Vwn50oDZIPn2W4zHFQRGaeQ
   FglF3+Mpz1OTevFFnTeEJyHxFvOWjtPMSEfDfwG5oyopI577lHwjT1ib5
   A==;
X-CSE-ConnectionGUID: v7058EzvSDCoJL0YTdIliQ==
X-CSE-MsgGUID: lvPD7vGjQTqwgURKgTwD9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="51887848"
X-IronPort-AV: E=Sophos;i="6.16,250,1744095600"; 
   d="scan'208";a="51887848"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2025 00:29:54 -0700
X-CSE-ConnectionGUID: k+Mg1KqRS+eEfoxsi187Pw==
X-CSE-MsgGUID: Fh0gTQD4R7aOih6H+oQZGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,250,1744095600"; 
   d="scan'208";a="156651096"
Received: from emr.sh.intel.com ([10.112.229.56])
  by orviesa005.jf.intel.com with ESMTP; 20 Jun 2025 00:29:51 -0700
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
Subject: [Patch v4 13/13] perf tools: x86: Support to show SSP register
Date: Fri, 20 Jun 2025 10:39:09 +0000
Message-ID: <20250620103909.1586595-14-dapeng1.mi@linux.intel.com>
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

Add SSP register support for x86 platforms.

Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 tools/arch/x86/include/uapi/asm/perf_regs.h    | 7 ++++++-
 tools/perf/arch/x86/util/perf_regs.c           | 2 ++
 tools/perf/util/intel-pt.c                     | 2 +-
 tools/perf/util/perf-regs-arch/perf_regs_x86.c | 2 ++
 4 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/tools/arch/x86/include/uapi/asm/perf_regs.h b/tools/arch/x86/include/uapi/asm/perf_regs.h
index 7c9d2bb3833b..fc5e520acc00 100644
--- a/tools/arch/x86/include/uapi/asm/perf_regs.h
+++ b/tools/arch/x86/include/uapi/asm/perf_regs.h
@@ -27,9 +27,14 @@ enum perf_event_x86_regs {
 	PERF_REG_X86_R13,
 	PERF_REG_X86_R14,
 	PERF_REG_X86_R15,
+	/* shadow stack pointer (SSP) */
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
index 9b1011fe4826..a6b53718be7d 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -2181,7 +2181,7 @@ static u64 *intel_pt_add_gp_regs(struct regs_dump *intr_regs, u64 *pos,
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
2.43.0

