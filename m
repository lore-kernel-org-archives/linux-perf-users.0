Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD2323A994;
	Tue, 18 Feb 2025 08:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739866498; cv=none; b=QleDuZH01/PHeYfL0bbXqRhnJHK7gwbqg7b20VaZOHYcqenBIG2z8P5lBYZa35b9gLwN8IN+xJYqeMogesNb+PgdwI8p+n8fM7qnRJorzshQgsNDkb5N6K8cBsLrDOwblfvNar2/zZhKZbdrDhtDONGwq9dT7CvwF47JaJXmv/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739866498; c=relaxed/simple;
	bh=FAfg4NlWSqWarG44b3rZlBp2gJSjEkErxxY8icsPQTA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=imv08qTXTwpMNVWt9e3vIyocdkUyCKBnHHgGCORZyo+Vl32JwRTcpHM18YLSz3oLKXLcQLanFDYXMXcK1L/KjQIIAY35FyOKuhaLmrlZTl/JusBOQolVNR8pQWPxgadpagWF6p7vx8YpdF9RWFLFmTc2h+ZCDD6rL65hLKb33D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UDP0hR6R; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UDP0hR6R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739866498; x=1771402498;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FAfg4NlWSqWarG44b3rZlBp2gJSjEkErxxY8icsPQTA=;
  b=UDP0hR6RfD01N/DUtAH64RMwadyXn96R2VSqvgzBCKQKDwemotXOHSgi
   kM17EnsOl+9N/DSU+XJUfcb1ltYsEyMtss38iKD/dYokVnO9xlNtnqFSu
   DwNe/wfWMv/A7NTCoKlFv8n0uXk4J9JOhfTWUz0Qw/94pNXbtBwU8bFNy
   g5JHcd0MXZsuC+6dSAtTzvrIiwg4DvNEL7whkUOYwEiiVbpHyeOOf17Aq
   xghuh2OL3VJZaKW7N8CQKWUJRLw5nQYOEydv2DQWNdfjA1YP3pDgnbaph
   dt7oha9/3t/BTTE7qRZqjrqJiFqYcZXmDqJP+HNgLM9RT+zYn7fG9H7qS
   g==;
X-CSE-ConnectionGUID: YjvvexseS2atEzEHzbRLWw==
X-CSE-MsgGUID: zBywe0aVRIGPoq7SFhdxnw==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="44200861"
X-IronPort-AV: E=Sophos;i="6.13,295,1732608000"; 
   d="scan'208";a="44200861"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 00:14:58 -0800
X-CSE-ConnectionGUID: aEO+CWTeRnCMS2O48znd3w==
X-CSE-MsgGUID: /lIWyOqyRaC/fLuBkR4Mnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,295,1732608000"; 
   d="scan'208";a="145166302"
Received: from emr.sh.intel.com ([10.112.229.56])
  by orviesa002.jf.intel.com with ESMTP; 18 Feb 2025 00:14:53 -0800
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
Subject: [Patch v2 19/24] perf tools: Support to show SSP register
Date: Tue, 18 Feb 2025 15:28:13 +0000
Message-Id: <20250218152818.158614-20-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250218152818.158614-1-dapeng1.mi@linux.intel.com>
References: <20250218152818.158614-1-dapeng1.mi@linux.intel.com>
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
index 7c9d2bb3833b..9c45b07bfcf7 100644
--- a/tools/arch/x86/include/uapi/asm/perf_regs.h
+++ b/tools/arch/x86/include/uapi/asm/perf_regs.h
@@ -27,9 +27,14 @@ enum perf_event_x86_regs {
 	PERF_REG_X86_R13,
 	PERF_REG_X86_R14,
 	PERF_REG_X86_R15,
+	/* Shadow stack pointer (SSP) present on Clearwater Forest and newer models. */
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

