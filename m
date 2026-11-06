Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793940071;
	b=ciAnNoexcRxjnQlVMpSg81IdkHF7pyiddvL4I2wFGwNze3ySt/KptiZfDcGjZ3XfPKOZ
	 J3KuGMRQEzpHp8CxSGG8BLfwy4BwgTooT6YWNCpQMeMTTTOrixLqoqNhtdL+B2c4C2Hor
	 O9aWVrJWToi+TZ1btdzRr2BPoSnObo/xzxGKIrsso5VbMj3YQXWs3BsGFcpE05dbh2CBa
	 FaIfDCaKWbJhfynfLh5jJRHna+lc6djy8n+9S5ZD1Fk5i0/bD0cmi9AaZsXDfZaTJk88Z
	 +lKzN3AQzW1AY0E5zPMu9TIqpZBJ5k1NKlXb/LGI1LGCv8dCXnHicgClx95Hc1Jr4xQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793940071;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=YcM8v/RTKwblj58hKcHHQdEbFFVRRmrldYYxF4ZWcBY=;
	b=4oQ+1MEkjodU8e9w9mDUybLhOBeJDUHmR2Qec3fCJ9DBwDyW0ZPsUW0SPy3HHRkK8Sn9
	 iapZmqUUf4ZJRCx2WDwblMun9pwOvyjgXlqsQTdxhmtjfO+s7eQHCd1kt39ZchZR0yzn4
	 Eq+Bn4pgVJJuBzzy8oXFwFrq0kSHlxbbX08fkS8f1tw6cKYn/Gehlb7dfDwKBtA+zWJ50
	 blEHtUM7/gFbcoPNzmzTFjgsngdKKj8KhNvJ+1KMyzSRyFTYF7QkDcGfdYiT4vd/wo2gA
	 5yJzSBdmpp1YoYvDRHRNdVbKy2D7DiEGsPIK+p/BCXKaoQtWTNZMvPBRcHFwivMYoag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ARMG4wMC;
	arc=none smtp.remote-ip=198.175.65.20
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12BB1606D803;
	Fri,  6 Nov 2026 04:41:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 12BB1606D803
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ARMG4wMC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793940072; x=1825476072;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fi5VDIVrm+cqwudwgaOZD+KaFDJ7hm8tYxzOjhUF2FM=;
  b=ARMG4wMC8FkwsYNs+HOoL9lD+w69UZrbtZZNIFZx7+otPguh3TXkEYID
   SWJurOyFTByYHEuksZxGrSt8VeCqiGVzGeWWiSTsMpBCjNFKkFhacaxb1
   Jb66csMPQO2Qg2SveNw0Z+TdyEtGO+uRruHJfqpfuRhouTdpAFX0mfJeL
   bA2UlSD99CJL02Y5Gig7yEu8RKNqk5/LlEX96IzdWKKrusdRtTy7ChSku
   DY0EPs0kLXC5S90yAdTgj1aDbzcrVq/r6u5982e7GDxYFJbqBsRXHnWFb
   4VHS3uiifvt6/+ItsBDrrtBishQ2iMnsS1MprYYFNu1SEESIL1sDoJ8nZ
   A==;
X-CSE-ConnectionGUID: YETTryH9Q966oP73X/nxEg==
X-CSE-MsgGUID: MTtS0F2jQDmNpdwfUEJZ3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2780806"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2780806"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 20:41:11 -0800
X-CSE-ConnectionGUID: 1/7j9aOJQ8OGWWvKxC85iA==
X-CSE-MsgGUID: K5RSBurDTCOVF4126fbVHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7222905"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa001.jf.intel.com with ESMTP; 05 Nov 2026 20:41:07 -0800
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>,
	Sandipan Das <sandipan.das@amd.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Song Liu <song@kernel.org>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Ananth Narayan <ananth.narayan@amd.com>
Cc: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	bpf@vger.kernel.org,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Xudong Hao <xudong.hao@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [Patch v6 07/20] perf/x86/intel: Add helper to enable PMU without LBR
Date: Fri,  6 Nov 2026 12:32:44 +0800
Message-Id: <20261106043257.842864-8-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261106043257.842864-1-dapeng1.mi@linux.intel.com>
References: <20261106043257.842864-1-dapeng1.mi@linux.intel.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, __intel_pmu_enable_all() also re-enables LBR in addition to
the PMU. Split out the PMU-only path into a new helper,
___intel_pmu_enable_all(), so the PMU can be enabled independently. This
helper will be used by a subsequent patch.

Also remove the unused added argument from __intel_pmu_enable_all().

No functional change intended.

Fixes: c22ac2a3d4bd ("perf: Enable branch record for software events")
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/core.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index e99b311c7b8d..9d8398da1989 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2783,13 +2783,11 @@ static __always_inline void intel_pmu_disable_all(void)
 	intel_pmu_lbr_disable_all();
 }
 
-static void __intel_pmu_enable_all(int added, bool pmi)
+static void ___intel_pmu_enable_all(void)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	u64 intel_ctrl = hybrid(cpuc->pmu, intel_ctrl);
 
-	intel_pmu_lbr_enable_all(pmi);
-
 	if (cpuc->fixed_ctrl_val != cpuc->active_fixed_ctrl_val) {
 		wrmsrq(MSR_ARCH_PERFMON_FIXED_CTR_CTRL, cpuc->fixed_ctrl_val);
 		cpuc->active_fixed_ctrl_val = cpuc->fixed_ctrl_val;
@@ -2809,10 +2807,16 @@ static void __intel_pmu_enable_all(int added, bool pmi)
 	}
 }
 
+static void __intel_pmu_enable_all(bool pmi)
+{
+	intel_pmu_lbr_enable_all(pmi);
+	___intel_pmu_enable_all();
+}
+
 static void intel_pmu_enable_all(int added)
 {
 	static_call_cond(x86_pmu_pebs_enable_all)();
-	__intel_pmu_enable_all(added, false);
+	__intel_pmu_enable_all(false);
 }
 
 static noinline int
@@ -4056,7 +4060,7 @@ static int intel_pmu_handle_irq(struct pt_regs *regs)
 	/* Only restore PMU state when it's active. See x86_pmu_disable(). */
 	cpuc->enabled = pmu_enabled;
 	if (pmu_enabled)
-		__intel_pmu_enable_all(0, true);
+		__intel_pmu_enable_all(true);
 	intel_bts_enable_local();
 
 	/*
-- 
2.34.1

