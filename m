Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A284B3B27FC;
	Fri, 29 May 2026 08:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780041762; cv=none; b=si9xWh+nBCLi4SRBRL7rrFl9QJyGmQPCFweHmAVdRNbykcN19bEsol+pHljWcw8e1xKChe08g6haaTXGCBV1C05dPKcghZHGHMJGWiwOomBeQflzXqjEeF6LBzvbIRlY1HFmMav+nBF4ylSYgwzm6+EnW2Au1y17wo3JCRUBTIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780041762; c=relaxed/simple;
	bh=qUPDEfNcCt2GNEn5iL1z6nRKeA66n8BleMMrGIHFy1E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sKbw2QSp58nndkx4qQIi1PWSpqDF5LL/TBANE7QYG1zryomlyyJQepa77/1ZUKe76ddoZTZTmd/BzikMU0G6xB43R/pq1duDWhCINWaveauVOrPbyrhe1RpfYYfv+Hy12SkQiSJPXEuRsHfFFVJRkfQOd5mO4oFbFv25/GHUfD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G/vADQhh; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G/vADQhh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780041761; x=1811577761;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qUPDEfNcCt2GNEn5iL1z6nRKeA66n8BleMMrGIHFy1E=;
  b=G/vADQhhUBqwE6u66uFvepN8X60jgGMbufJVON4CSAkbtOPop6IIw3GX
   hC1V02et5Mh7Y/3rg+jlhqbbs8OpeWssMQHLysAlxGaT0Z62YHJ9guJi7
   OXqhLElSHgUDB77bynn5hwppuyoc7Szk2PNWiGj/ngcU5NqHu7KXkdG6+
   a1UPZFzRJwRP0phRVjo+t22RA2m8bXnYunGwkO+u2GFDoxqrc4jZoOOe7
   Q96QPBo3LjNNVMcTdfFIY9yoLdlBJtORBMSY6kMkcAcpmBNEMKo22Uwk8
   eZG1sJiCK1d7zNYyrC5uciW5IzFJHEiXtCLVpOuVuh+e3hLEY6pPqj+YD
   g==;
X-CSE-ConnectionGUID: GSkrwPsXTXyHngkYv16giA==
X-CSE-MsgGUID: g2+JXHpOTBqUuoAy+cKKww==
X-IronPort-AV: E=McAfee;i="6800,10657,11800"; a="106341843"
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; 
   d="scan'208";a="106341843"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2026 01:02:40 -0700
X-CSE-ConnectionGUID: sTNTr5/gQ0O1BrJbzqeCYg==
X-CSE-MsgGUID: sLGQfdjFS1y6pTfB2sMFag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; 
   d="scan'208";a="246801936"
Received: from spr.sh.intel.com ([10.112.230.239])
  by orviesa003.jf.intel.com with ESMTP; 29 May 2026 01:02:35 -0700
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
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
	broonie@kernel.org,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Xudong Hao <xudong.hao@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [Patch v8 01/23] perf/x86/intel: Validate return value of intel_pmu_init_hybrid()
Date: Fri, 29 May 2026 15:56:23 +0800
Message-Id: <20260529075645.580362-2-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260529075645.580362-1-dapeng1.mi@linux.intel.com>
References: <20260529075645.580362-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The memory allocation for the x86_pmu.hybrid_pmu[] array in
intel_pmu_init_hybrid() can theoretically fail due to memory shortages.
If this occurs, the initialization of the x86 hybrid PMU would fail.

Currently, the code does not check the return value of the
intel_pmu_init_hybrid() function, which could lead to attempts to access
the uninitialized x86_pmu.hybrid_pmu[] array, potentially causing a
system panic.

So, adds a check for the return value of intel_pmu_init_hybrid() to
prevent invalid memory access in such scenarios.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---

V8: New patch.

 arch/x86/events/intel/core.c | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 0217e701aeeb..85c329bd52be 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -7870,6 +7870,7 @@ __init int intel_pmu_init(void)
 	int version, i;
 	char *name;
 	struct x86_hybrid_pmu *pmu;
+	int ret;
 
 	/* Architectural Perfmon was introduced starting with Core "Yonah" */
 	if (!cpu_has(&boot_cpu_data, X86_FEATURE_ARCH_PERFMON)) {
@@ -8545,7 +8546,9 @@ __init int intel_pmu_init(void)
 		 *
 		 * Initialize the common PerfMon capabilities here.
 		 */
-		intel_pmu_init_hybrid(hybrid_big_small);
+		ret = intel_pmu_init_hybrid(hybrid_big_small);
+		if (ret < 0)
+			return ret;
 
 		x86_pmu.pebs_latency_data = grt_latency_data;
 		x86_pmu.get_event_constraints = adl_get_event_constraints;
@@ -8603,7 +8606,9 @@ __init int intel_pmu_init(void)
 	case INTEL_METEORLAKE:
 	case INTEL_METEORLAKE_L:
 	case INTEL_ARROWLAKE_U:
-		intel_pmu_init_hybrid(hybrid_big_small);
+		ret = intel_pmu_init_hybrid(hybrid_big_small);
+		if (ret < 0)
+			return ret;
 
 		x86_pmu.pebs_latency_data = cmt_latency_data;
 		x86_pmu.get_event_constraints = mtl_get_event_constraints;
@@ -8634,7 +8639,9 @@ __init int intel_pmu_init(void)
 		pr_cont("Pantherlake Hybrid events, ");
 		name = "pantherlake_hybrid";
 
-		intel_pmu_init_hybrid(hybrid_big_small);
+		ret = intel_pmu_init_hybrid(hybrid_big_small);
+		if (ret < 0)
+			return ret;
 
 		/* Initialize big core specific PerfMon capabilities.*/
 		pmu = &x86_pmu.hybrid_pmu[X86_HYBRID_PMU_CORE_IDX];
@@ -8649,7 +8656,9 @@ __init int intel_pmu_init(void)
 		pr_cont("Arrowlake Hybrid events, ");
 		name = "arrowlake_hybrid";
 
-		intel_pmu_init_hybrid(hybrid_big_small);
+		ret = intel_pmu_init_hybrid(hybrid_big_small);
+		if (ret < 0)
+			return ret;
 
 		/* Initialize big core specific PerfMon capabilities.*/
 		pmu = &x86_pmu.hybrid_pmu[X86_HYBRID_PMU_CORE_IDX];
@@ -8666,7 +8675,9 @@ __init int intel_pmu_init(void)
 		pr_cont("Lunarlake Hybrid events, ");
 		name = "lunarlake_hybrid";
 
-		intel_pmu_init_hybrid(hybrid_big_small);
+		ret = intel_pmu_init_hybrid(hybrid_big_small);
+		if (ret < 0)
+			return ret;
 
 		/* Initialize big core specific PerfMon capabilities.*/
 		pmu = &x86_pmu.hybrid_pmu[X86_HYBRID_PMU_CORE_IDX];
@@ -8691,7 +8702,9 @@ __init int intel_pmu_init(void)
 		break;
 
 	case INTEL_ARROWLAKE_H:
-		intel_pmu_init_hybrid(hybrid_big_small_tiny);
+		ret = intel_pmu_init_hybrid(hybrid_big_small_tiny);
+		if (ret < 0)
+			return ret;
 
 		x86_pmu.pebs_latency_data = arl_h_latency_data;
 		x86_pmu.get_event_constraints = arl_h_get_event_constraints;
@@ -8726,7 +8739,9 @@ __init int intel_pmu_init(void)
 	case INTEL_NOVALAKE_L:
 		pr_cont("Novalake Hybrid events, ");
 		name = "novalake_hybrid";
-		intel_pmu_init_hybrid(hybrid_big_small);
+		ret = intel_pmu_init_hybrid(hybrid_big_small);
+		if (ret < 0)
+			return ret;
 
 		x86_pmu.pebs_latency_data = nvl_latency_data;
 		x86_pmu.get_event_constraints = mtl_get_event_constraints;
-- 
2.34.1

