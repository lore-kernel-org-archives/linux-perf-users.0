Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C2E2DCF6A;
	Mon, 11 Aug 2025 09:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754902907; cv=none; b=X6Kipq0YZcWucLL2A+G0EU9Hg2ST0GSPaGaDcDjOgm0dVDYgDcIlTwRpUjQmPP8jB9QNdKmcSy5qA9gL79ruOcR3Ihs0f+VA8ak+9ziqDX0f+gS8n9WjukFBRy8JCzdC93k3+Lmmia8o4SDfyTeO64xzzQ+3Jocpuyku7BelzvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754902907; c=relaxed/simple;
	bh=yroT7CzWxiE6A86M6FMgIQECV5NHrE/bzjF/iVz9y8Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gvoDc/+0FTu3iGIhtOKAv8ojGFFMZknWfckoPfDwiBDCKPfI0K4cAGS5i1p7iRp6VivQQyvjvyRXn+FRVM23+pshIh8Akbp4mginVOUJjZAJ97s5FsqLNVgUdWMEGXAboNWP/PNLqi6GTvWA4Bfl5wT3skoHR0wanX7SeR9tXJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A25IaUzj; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A25IaUzj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754902906; x=1786438906;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yroT7CzWxiE6A86M6FMgIQECV5NHrE/bzjF/iVz9y8Y=;
  b=A25IaUzjPxUDwIX+rx9pNVj0uu+PIcWrnviMOeAhK1ZyGccVrtKHpk3L
   aqjsmPXhShWGzeIs+amZDS6B8f5QiLJkbAkfjs1JHC70g/sWYlpASe5lv
   JhiSQ4RWpytevss1t9u8d5i5uC4qFjVfb8iboSegYkTE6vCn7v1iNp+Cw
   Ekc9snfb1UwgZSdjkODPgPJpAEtDT0r7iV6vvD66SYRwwM/S/QQeiNCV0
   DaOkBChRMoaBkT7w+S/RU9LexRL7ZaH4j9bMdtIiC+NOynVYsSQ7HvYm5
   2U2K6LpO4US+mrHOpw+UI07Lh6Ki+Betj4wbVhVOW5VLcKNHA4u3s7F6y
   w==;
X-CSE-ConnectionGUID: aQ3pzNC4RCqX9MGnzDyCkQ==
X-CSE-MsgGUID: p0GN6dYyS3CKEXxgU3oGAg==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="57107384"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="57107384"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 02:01:44 -0700
X-CSE-ConnectionGUID: t460OEnaQSSZgVDEkdl6oQ==
X-CSE-MsgGUID: E1bMGbCkSe62MtZ/+d5kVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="166219908"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa009.fm.intel.com with ESMTP; 11 Aug 2025 02:01:39 -0700
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
Subject: [Patch v2 4/6] perf/x86: Add PERF_CAP_PEBS_TIMING_INFO flag
Date: Mon, 11 Aug 2025 17:00:32 +0800
Message-Id: <20250811090034.51249-5-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250811090034.51249-1-dapeng1.mi@linux.intel.com>
References: <20250811090034.51249-1-dapeng1.mi@linux.intel.com>
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

