Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722812D3743;
	Wed, 20 Aug 2025 02:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755657116; cv=none; b=TdAklhiCrSltNZSzLhU8GiN9rhBCMGC/j9olhZW/ySSAu0fwF/akXnMETlPUY8RWCT6ehqYDiGZllnNSnWlAwJ0V+E9EmFhEqV92s5YA+7HPSMFJMcyBMo524qYYnZijZzUSZL+rAGylXEufmh41UcM8LmSABbQTKL86ZNdEKks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755657116; c=relaxed/simple;
	bh=YzXg9t3Y9pO52HXNZcUkI4xWTH2uo3hvGksKmi75rL4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FdF8tWTKMy7b3FkNzkuUqwBeRTNBoiHleEYRC71ghYR8Q486NnMmw6+QwhtsuY67H2Im7MPJnMuLc7rjIdkXFse6aT02HJKCXqDlBnRQOAMU6DVcmUCmK8yx26jcjpF9Zl+TzTYGVLCiQqsTGZUjlvw7V/6g6GseOPAM0df3GOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MFCBtAR+; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MFCBtAR+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755657116; x=1787193116;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YzXg9t3Y9pO52HXNZcUkI4xWTH2uo3hvGksKmi75rL4=;
  b=MFCBtAR+WMMPzKbnsrlJdJlTgw506wIKQQaINPriKYIffu3xqofelaMu
   dOcBsYXPTBKlKK3mn4SD3dxHqDvvor3ksyo2MQMznCKan3g6gevIHLfIF
   HyEtE6HhOuv3gXr8uG7m43jocKodkafJpl3eggN5TVG6xCapaY+jyWC32
   csb8dymyx43SCCW8xtV4nsFoYvIdDsgCRmtQnD8snK8kGTGXEHqSz43aN
   I53o+H0au8okK/vtnIS1icPizAQjbPnCLIWcjogTknu8XDQFnWX5nIxjv
   lZ/H/ekLbEOUIZWZNIZYMdX4PKAJbUAN/wN1Yl1pAiMfQ2ujQJyIxF1DI
   g==;
X-CSE-ConnectionGUID: YfYEMMSCRDmybPOrXXwi2A==
X-CSE-MsgGUID: LJA2FgJRTXuwyqVmm1xd2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="57625494"
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="57625494"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2025 19:31:56 -0700
X-CSE-ConnectionGUID: k2knp2gCTkauCA2QlC4tmQ==
X-CSE-MsgGUID: yWIRZC8uT62OkqOVaCEBNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="167629052"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa009.jf.intel.com with ESMTP; 19 Aug 2025 19:31:52 -0700
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
Subject: [Patch v3 7/7] perf/x86: Print PMU counters bitmap in x86_pmu_show_pmu_cap()
Date: Wed, 20 Aug 2025 10:30:32 +0800
Message-Id: <20250820023032.17128-8-dapeng1.mi@linux.intel.com>
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

Along with the introduction Perfmon v6, pmu counters could be
incontinuous, like fixed counters on CWF, only fixed counters 0-3 and
5-7 are supported, there is no fixed counter 4 on CWF. To accommodate
this change, archPerfmonExt CPUID (0x23) leaves are introduced to
enumerate the true-view of counters bitmap.

Current perf code already supports archPerfmonExt CPUID and uses
counters-bitmap to enumerate HW really supported counters, but
x86_pmu_show_pmu_cap() still only dumps the absolute counter number
instead of true-view bitmap, it's out-dated and may mislead readers.

So dump counters true-view bitmap in x86_pmu_show_pmu_cap() and
opportunistically change the dump sequence and words.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/core.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 7610f26dfbd9..745caa6c15a3 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2069,13 +2069,15 @@ static void _x86_pmu_read(struct perf_event *event)
 
 void x86_pmu_show_pmu_cap(struct pmu *pmu)
 {
-	pr_info("... version:                %d\n",     x86_pmu.version);
-	pr_info("... bit width:              %d\n",     x86_pmu.cntval_bits);
-	pr_info("... generic registers:      %d\n",     x86_pmu_num_counters(pmu));
-	pr_info("... value mask:             %016Lx\n", x86_pmu.cntval_mask);
-	pr_info("... max period:             %016Lx\n", x86_pmu.max_period);
-	pr_info("... fixed-purpose events:   %d\n",     x86_pmu_num_counters_fixed(pmu));
-	pr_info("... event mask:             %016Lx\n", hybrid(pmu, intel_ctrl));
+	pr_info("... version:                   %d\n", x86_pmu.version);
+	pr_info("... bit width:                 %d\n", x86_pmu.cntval_bits);
+	pr_info("... generic counters:          %d\n", x86_pmu_num_counters(pmu));
+	pr_info("... generic bitmap:            %016llx\n", hybrid(pmu, cntr_mask64));
+	pr_info("... fixed-purpose counters:    %d\n", x86_pmu_num_counters_fixed(pmu));
+	pr_info("... fixed-purpose bitmap:      %016llx\n", hybrid(pmu, fixed_cntr_mask64));
+	pr_info("... value mask:                %016llx\n", x86_pmu.cntval_mask);
+	pr_info("... max period:                %016llx\n", x86_pmu.max_period);
+	pr_info("... global_ctrl mask:          %016llx\n", hybrid(pmu, intel_ctrl));
 }
 
 static int __init init_hw_perf_events(void)
-- 
2.34.1

