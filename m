Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793940067;
	b=EP6uja1KFjeqJUN7YcLPF+6ambLqOP417S8MefbQ94NmoXDP88203TK8y6kac7V+9fK2
	 oNEQCpExOxAShxYnBjm9x0nvEv3ZQMEAxjXH+UuQNSDlPKBe8I0mFXh57WNvWPrW+xpCX
	 DreplHTLlrm8wd6RVGku88ToXtMYLjtWMZ8ygUKUs9GqYENZs7ddv45V5iOGv2bQ/fjWR
	 iaKGJgnchsGXkARRS7XBe/N9Oc9r1dnsetFjIb3wVsnZjtY5gLIrO5+ZuALgrBfumL4eB
	 BIkU5GkRsCPBFD7WJFQSbjdDlwefQuZ2zEyLUkSjRiMWlEfJMODFlIA2ZVwixCqcF2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793940067;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=9L1+gXxdAjeSQA7hYOcFMh3Mw2z6i4t1OI+HpS/rqU0=;
	b=jp1EPoNeW6OwBhAS2NYF+HR8yn0d/4TdKvWXjui6es3/diSCh4upeeTIVBfRGu3zY/lW
	 xyoYFzOpOV+syxz+ttfnOXgHXpZ+TTRYpqvB5YMpJ84Z2Pqdz+q4kwpOcQ9KO6KirL1c0
	 P1TOriBWBets61XqSrbJmDQ72rWkdc7tIflsRJwkvZPBWFEYnGwPy/DpDArcwgKWtrc87
	 owgn1YDDZdmxEDSrFsRrd1J37JHKdQLPZTi8a1bsEedE6X4jWcCIRFOKWVUrGZ0bjwqDV
	 g3OLL5R8z5vAUdHuhXJrE/WwFFAz1lhtU3abODzcSEskUzoouQsflKOaKL1mBHI1R8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MkjoOzyk;
	arc=none smtp.remote-ip=198.175.65.20
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEEFC606A328;
	Fri,  6 Nov 2026 04:41:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AEEFC606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MkjoOzyk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793940067; x=1825476067;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ReR4A1JldgW6oUKtmGMqxoRucaQ4BM1TbBWXAH3x/W0=;
  b=MkjoOzykKOR5Rg6EGLLKLCmHRHYzfnAOGG+NqicKPCAgsd0zpQMWXQ34
   1IpqX+tbPTWtNZhhgdlcEnu32NMmnoZq0DlBbdPOD1I2BXXCMwGMcxnq5
   9jH8RckQlGxKoKkN5rlEU9ikkOk96ccrcO7lNhvMdkzxPMT9eN6JaUKoS
   zxEQ3frfIBVnHdX2ksqTeShHWKZ1ljIrQr7PRBGVyQ6JVboaX1j9U2bqG
   ShcdSPBXf3NnNAyi5SK41W51u7ses0MjoiHPS4X441gSjmEM88a/mjYMg
   Jfqy7jMfyKbzVtezkwIVNQO/57uGOX2spy10GduLmZylfUnUTqb1AeDcC
   A==;
X-CSE-ConnectionGUID: fXypcJAERPGq1okJITeG0w==
X-CSE-MsgGUID: o0S49h0gTH+FacxON1S/nw==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2780799"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2780799"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 20:41:07 -0800
X-CSE-ConnectionGUID: Ucc3aQLmR6qZAs0DP6/Xyg==
X-CSE-MsgGUID: drDr1wOVT3ODlDZF0q+6Rg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7222888"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa001.jf.intel.com with ESMTP; 05 Nov 2026 20:41:02 -0800
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
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [Patch v6 06/20] perf/x86/amd: Avoid re-enabling PMU and LBR for BPF when disabled
Date: Fri,  6 Nov 2026 12:32:43 +0800
Message-Id: <20261106043257.842864-7-dapeng1.mi@linux.intel.com>
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

amd_pmu_v2_snapshot_branch_stack() currently re-enables the PMU and LBR
unconditionally even when they were already disabled in PMI context
This can cause events such as cycles and instructions to be counted
while the PMI handler is running, which is not intended.

Only restore the PMU and LBR on the BPF path if they were originally
enabled.

Cc: Sandipan Das <sandipan.das@amd.com>
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/sashiko-outbox-179823@kernel.org/
Fixes: a4d18112e531 ("perf/x86/amd: Support capturing LBR from software events")
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/amd/core.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index bf631f60757c..851d8a938f52 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -932,22 +932,28 @@ static int amd_pmu_v2_snapshot_branch_stack(struct perf_branch_entry *entries, u
 {
 	struct cpu_hw_events *cpuc;
 	unsigned long flags;
+	int pmu_enabled;
+	int lbr_enabled;
 
 	/*
 	 * The sequence of steps to freeze LBR should be completely inlined
 	 * and contain no branches to minimize contamination of LBR snapshot
 	 */
 	local_irq_save(flags);
+	cpuc = this_cpu_ptr(&cpu_hw_events);
+	pmu_enabled = cpuc->enabled;
+	lbr_enabled = cpuc->lbr_enabled;
 	amd_pmu_core_disable_all();
 	__amd_pmu_lbr_disable();
 
-	cpuc = this_cpu_ptr(&cpu_hw_events);
-
 	amd_pmu_lbr_read();
 	cnt = min(cnt, cpuc->lbr_stack.nr);
 	memcpy(entries, cpuc->lbr_entries, sizeof(struct perf_branch_entry) * cnt);
 
-	amd_pmu_v2_enable_all(0);
+	if (lbr_enabled)
+		amd_pmu_lbr_enable_all();
+	if (pmu_enabled)
+		amd_pmu_core_enable_all();
 	local_irq_restore(flags);
 
 	return cnt;
-- 
2.34.1

