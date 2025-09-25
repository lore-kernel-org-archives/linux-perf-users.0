Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8859F2EB869;
	Thu, 25 Sep 2025 06:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758780927; cv=none; b=GmQ76YjJ9F10N36nrmD/ec6/3FTLo5GoY02hPzbU8rgpD8ITV/hLea9zrqI5n15fpoMPkXCOAZD+nogtQxxyIE4+VfOnYgnT9wObZM2eEtLMXsICZxAqasW9PwztGr2etu6+A9ef0PwAA4c4hoqGgz+9YvArVId323y5LQBlAFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758780927; c=relaxed/simple;
	bh=evISbTMuC9hzr+XrxURZGIsB/kGG2ecJfeGLM5G/f4E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YM1DyXASXbWBaC5HwUMs5MxRr7GHJzOAPUl2SI2c+I8Ug2Pa51tKztHF8lq8UAVZBfnyo1x58nmisJpxu9LbSpkXA0eMURvu0xYc+KWFb5l6q5iRkNKFVHtTCymBr0wp+SnoydbEbo/SES35atVsdmjZXbpPN8Gyry92m6ySv/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cg3XwpPx; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cg3XwpPx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758780926; x=1790316926;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=evISbTMuC9hzr+XrxURZGIsB/kGG2ecJfeGLM5G/f4E=;
  b=cg3XwpPxw4hcbqaD3zh3eRANprNDM+26qqy1uFGN8/0X1ZQHEUzWCgeX
   IQ+L9sIfds/iz86ycXwwl3zMK7ZvX6onbbtWSZh4QZSAOQc/x/FTIHnAT
   6nNi1yTvNjoIA/nIcdFKGoRCobS3yYHP/uPwzds4l1hKfIIdK5P3hZ2/8
   yBbD6+jJTDkFO53idqlREYzQ/gO9sPrAsw7a1jgN3TaU9+9oFLZyXLqQU
   Euj6kMXHKZIqnIx6AMLUsTlmTYJFWcQynuH547+hmm0SyKy6CkDyp9v2k
   x2Q3WvroLc6RbBQwnqUVfX4Rx3QhWsRwQyzgc3bx1+/S/73AshsZC8xnc
   Q==;
X-CSE-ConnectionGUID: f0NEhGjGT6Oon9/WSayKGg==
X-CSE-MsgGUID: SoOlcXM4QlO/oHScixdOFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11563"; a="61139629"
X-IronPort-AV: E=Sophos;i="6.18,292,1751266800"; 
   d="scan'208";a="61139629"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 23:15:25 -0700
X-CSE-ConnectionGUID: RPUOvHfmRxee6sFFs0L7fw==
X-CSE-MsgGUID: 31WH2JT6Qb6AYUpxwRRyrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,292,1751266800"; 
   d="scan'208";a="181528617"
Received: from spr.sh.intel.com ([10.112.230.239])
  by orviesa004.jf.intel.com with ESMTP; 24 Sep 2025 23:15:20 -0700
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
	broonie@kernel.org,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [Patch v4 14/17] perf tools: Only support legacy regs for the PT and PERF_REGS_MASK
Date: Thu, 25 Sep 2025 14:12:10 +0800
Message-Id: <20250925061213.178796-15-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250925061213.178796-1-dapeng1.mi@linux.intel.com>
References: <20250925061213.178796-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

The PERF_REG_X86_64_MAX is going to be updated to support more regs,
e.g., eGPRs.
However, the PT and PERF_REGS_MASK will not be touched in the POC.
Using the PERF_REG_X86_R15 + 1 to replace PERF_REG_X86_64_MAX.

Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 tools/perf/arch/x86/include/perf_regs.h | 2 +-
 tools/perf/util/intel-pt.c              | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/arch/x86/include/perf_regs.h b/tools/perf/arch/x86/include/perf_regs.h
index f209ce2c1dd9..793fb597b03f 100644
--- a/tools/perf/arch/x86/include/perf_regs.h
+++ b/tools/perf/arch/x86/include/perf_regs.h
@@ -17,7 +17,7 @@ void perf_regs_load(u64 *regs);
 		       (1ULL << PERF_REG_X86_ES) | \
 		       (1ULL << PERF_REG_X86_FS) | \
 		       (1ULL << PERF_REG_X86_GS))
-#define PERF_REGS_MASK (((1ULL << PERF_REG_X86_64_MAX) - 1) & ~REG_NOSUPPORT)
+#define PERF_REGS_MASK (((1ULL << (PERF_REG_X86_R15 + 1)) - 1) & ~REG_NOSUPPORT)
 #define PERF_SAMPLE_REGS_ABI PERF_SAMPLE_REGS_ABI_64
 #endif
 
diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index 9b1011fe4826..a9585524f2e1 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -2181,7 +2181,7 @@ static u64 *intel_pt_add_gp_regs(struct regs_dump *intr_regs, u64 *pos,
 	u32 bit;
 	int i;
 
-	for (i = 0, bit = 1; i < PERF_REG_X86_64_MAX; i++, bit <<= 1) {
+	for (i = 0, bit = 1; i < PERF_REG_X86_R15 + 1; i++, bit <<= 1) {
 		/* Get the PEBS gp_regs array index */
 		int n = pebs_gp_regs[i] - 1;
 
-- 
2.34.1

