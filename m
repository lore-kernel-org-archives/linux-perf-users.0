Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B5E2C236F;
	Wed, 20 Aug 2025 02:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755657106; cv=none; b=SQxZZ2vxh4UbkwGOkmJBfRq9yCdKpaf6BDUDlfjfcJ2u8O8WSnxVwMP8oOg/1+ncxX+DmtBIuBKJpLF6s3PvdB6lYFI7vjyaffoodFCoc7swq1fYshI47sQw50SnxRE7CnRHu98zztMfiV+stDgG9UHtFQdgV3dK28HLZr4Khwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755657106; c=relaxed/simple;
	bh=yroT7CzWxiE6A86M6FMgIQECV5NHrE/bzjF/iVz9y8Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W89Vz6s79t5WTaJJL6lfnDPd+pHrXn/DFFlyPUAHqabt0QCYcrEayI2WtDdOF3fhCShk8zb8PHYwjb9DFnClhax8IC9mMZsHuNRGY0GkvJx7vA3ssmDA+mFX6NndmFHpCJn36jvx5DTcn9IRIaQIissu4UEAflE0NHTEzeaSOpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fp17ZqIl; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fp17ZqIl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755657105; x=1787193105;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yroT7CzWxiE6A86M6FMgIQECV5NHrE/bzjF/iVz9y8Y=;
  b=fp17ZqIl/J8x4wHPSajaDBRIYWxfHwT8mwiX50HXw658uBDOWzADg4ve
   jxNYxr4mYJBpFoWiJMsYFzjdQwvYJdxxuNGHtLy+epsJalqlCaR2wS0r4
   nWcTb6/hqz3M6AD3uctwOJnmvAT6h3aLMip9XBAu8GlH6dg7haeRA4xAT
   55foUId4U//0ivEF1s+hp7LxEBYh6+VnU7d668fYOJoaxCYBO+wp2dJOy
   Hnc++beN6cSssqqdHUc081YV5a4HIsLJ82DoESyR02lZpBavXmp+6M6Nf
   lGahR4SjTkEGVovYyD+0LHHh4jTi6eMcS/S8onerjUne+zS2K5QgLlBcA
   w==;
X-CSE-ConnectionGUID: hqD1tn6ISlC5jePXNrAp/w==
X-CSE-MsgGUID: tUU/751CSuWY4BVPcd1yhQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="57625463"
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="57625463"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2025 19:31:45 -0700
X-CSE-ConnectionGUID: yJK9Gyh6TyOTDmFGC5HKcg==
X-CSE-MsgGUID: /txcnBJNQBSQ8eYs0oM9Wg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="167629032"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa009.jf.intel.com with ESMTP; 19 Aug 2025 19:31:41 -0700
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
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Yi Lai <yi1.lai@intel.com>
Subject: [Patch v3 4/7] perf/x86: Add PERF_CAP_PEBS_TIMING_INFO flag
Date: Wed, 20 Aug 2025 10:30:29 +0800
Message-Id: <20250820023032.17128-5-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250820023032.17128-1-dapeng1.mi@linux.intel.com>
References: <20250820023032.17128-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

IA32_PERF_CAPABILITIES.PEBS_TIMING_INFO[bit 17] is introduced to
indicate whether timed PEBS is supported. Timed PEBS adds a new "retired
latency" field in basic info group to show the timing info. Please find
detailed information about timed PEBS in section 8.4.1 "Timed Processor
Event Based Sampling" of "Intel Architecture Instruction Set Extensions
and Future Features".

This patch adds PERF_CAP_PEBS_TIMING_INFO flag and KVM module leverages
this flag to expose timed PEBS feature to guest.

Moreover, opportunistically refine the indents and make the macros
share consistent indents.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Tested-by: Yi Lai <yi1.lai@intel.com>
---
 arch/x86/include/asm/msr-index.h       | 14 ++++++++------
 tools/arch/x86/include/asm/msr-index.h | 14 ++++++++------
 2 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index b65c3ba5fa14..f627196eb796 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -315,12 +315,14 @@
 #define PERF_CAP_PT_IDX			16
 
 #define MSR_PEBS_LD_LAT_THRESHOLD	0x000003f6
-#define PERF_CAP_PEBS_TRAP             BIT_ULL(6)
-#define PERF_CAP_ARCH_REG              BIT_ULL(7)
-#define PERF_CAP_PEBS_FORMAT           0xf00
-#define PERF_CAP_PEBS_BASELINE         BIT_ULL(14)
-#define PERF_CAP_PEBS_MASK	(PERF_CAP_PEBS_TRAP | PERF_CAP_ARCH_REG | \
-				 PERF_CAP_PEBS_FORMAT | PERF_CAP_PEBS_BASELINE)
+#define PERF_CAP_PEBS_TRAP		BIT_ULL(6)
+#define PERF_CAP_ARCH_REG		BIT_ULL(7)
+#define PERF_CAP_PEBS_FORMAT		0xf00
+#define PERF_CAP_PEBS_BASELINE		BIT_ULL(14)
+#define PERF_CAP_PEBS_TIMING_INFO	BIT_ULL(17)
+#define PERF_CAP_PEBS_MASK		(PERF_CAP_PEBS_TRAP | PERF_CAP_ARCH_REG | \
+					 PERF_CAP_PEBS_FORMAT | PERF_CAP_PEBS_BASELINE | \
+					 PERF_CAP_PEBS_TIMING_INFO)
 
 #define MSR_IA32_RTIT_CTL		0x00000570
 #define RTIT_CTL_TRACEEN		BIT(0)
diff --git a/tools/arch/x86/include/asm/msr-index.h b/tools/arch/x86/include/asm/msr-index.h
index 5cfb5d74dd5f..daebfd926f08 100644
--- a/tools/arch/x86/include/asm/msr-index.h
+++ b/tools/arch/x86/include/asm/msr-index.h
@@ -315,12 +315,14 @@
 #define PERF_CAP_PT_IDX			16
 
 #define MSR_PEBS_LD_LAT_THRESHOLD	0x000003f6
-#define PERF_CAP_PEBS_TRAP             BIT_ULL(6)
-#define PERF_CAP_ARCH_REG              BIT_ULL(7)
-#define PERF_CAP_PEBS_FORMAT           0xf00
-#define PERF_CAP_PEBS_BASELINE         BIT_ULL(14)
-#define PERF_CAP_PEBS_MASK	(PERF_CAP_PEBS_TRAP | PERF_CAP_ARCH_REG | \
-				 PERF_CAP_PEBS_FORMAT | PERF_CAP_PEBS_BASELINE)
+#define PERF_CAP_PEBS_TRAP		BIT_ULL(6)
+#define PERF_CAP_ARCH_REG		BIT_ULL(7)
+#define PERF_CAP_PEBS_FORMAT		0xf00
+#define PERF_CAP_PEBS_BASELINE		BIT_ULL(14)
+#define PERF_CAP_PEBS_TIMING_INFO	BIT_ULL(17)
+#define PERF_CAP_PEBS_MASK		(PERF_CAP_PEBS_TRAP | PERF_CAP_ARCH_REG | \
+					 PERF_CAP_PEBS_FORMAT | PERF_CAP_PEBS_BASELINE | \
+					 PERF_CAP_PEBS_TIMING_INFO)
 
 #define MSR_IA32_RTIT_CTL		0x00000570
 #define RTIT_CTL_TRACEEN		BIT(0)
-- 
2.34.1

