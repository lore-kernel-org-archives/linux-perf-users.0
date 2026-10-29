Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793249230;
	b=ziyM793DoqHYUo3LYjHsKJai7cw9SF5XBRm1JAuJXb7Q+hc5ursyWGVYRKmc+9TaENst
	 7q6fb2Q84bwJ2sBC0ZZBosmfMlZc+MYEgnW+8E9Kk7/C3p21rbXSOtZKrgJEMdL3vvlPS
	 Fdio0Ifh2NQ23xSD67W3YPel+pmyTsbRjvetdDiB8DyJIkSL/yy/gYDNddW9QT55ahsZS
	 zbk2mYNyq0j1fTn5hstjmoj6aChQR3enpADOvq80toFM9NK+2qyWtkDpnn/8D5Gsc8D/z
	 bpNjIC4qAcic0jyRB/WzaSANXFT6+j2R456OeTnwR4QI9FYaphifbORKyRPcI61FYow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793249230;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=EVZSa+JCW0r3IF9Trz6lBB+QW2zzYmpajcWmeaMS9ys=;
	b=Q+TYkQsWNF73BT2AAjQpZHPvyGfMOXWRu27RvRbSL1yRuMOFRidnTWfa97WX9JtDrRdG
	 /dyk68cpFs+8W1gU+cgufs90RMYVdzlrYyoLgw/+7ARknQUTwY0K6hXplMEc5Ryb1xH8X
	 15JWWsUy1LflXl+U3w2tao66QEJsb+qlwi6ztwMAuHIApXDE/csDtX3vgf6TjS2dmTu13
	 8gmoYmXi5mdBIctHXSF7TGOw+z4b79/+a2mvM95Px85WzSGn6DMTGJgSNi7dokdWcfiW6
	 chqTTXm2Z1WYKNWr3Xu7XavTd2qk3SsW+5hIZP/fcwOjQrBKWvY1ccW52bzgEKEGAYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nUNRvkEq;
	arc=none smtp.remote-ip=192.198.163.15
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6339C606A31D;
	Thu, 29 Oct 2026 04:47:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6339C606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nUNRvkEq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793249230; x=1824785230;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=m9oQyuXjXHPAgPDhoJ9Z/pc12Lgkp1kc9r8qJOdIYPk=;
  b=nUNRvkEqsvjhuIL3ECxKNNEcY2CbUgfC4nKeT0qJU2MuxJYsbiY9EWKG
   F7rslbp1/pu7tmhXrSDGnsoq8ND2t3uSYr+aHkj+KOO1KEjoTnjq08A+I
   FqSsfFK8p6Xbar42RpASXAx9Rgxw6I8dMqWHFVFgE0TypmIDg45+5aqZh
   W9REKbj6r1y3ob6mqPnZJdU3bvoVOpgwSBUVxur8nt+MozUpYrr+IChGH
   KffsB7C2q7OCEd6gsOrKfl6sDT3ua6mWc9AfRaLRZwHRbTEASZUUQPVpi
   T13PSnY3MOUPZPPr6OXj0Tk/tlHfz3BczTDH2cJvWXGpIzs+vwRGkPKat
   A==;
X-CSE-ConnectionGUID: 0+NcdFgZQG6jFtyEyCX/3g==
X-CSE-MsgGUID: rL2m0iLOTLeedkw76OtltQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="1986274"
X-IronPort-AV: E=Sophos;i="6.27,183,1787036400"; 
   d="scan'208";a="1986274"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 21:47:09 -0700
X-CSE-ConnectionGUID: iZQyjj0GThqoG8Em8TywxQ==
X-CSE-MsgGUID: /m/0cRLYR9KkVP8IaU2KnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,183,1787036400"; 
   d="scan'208";a="5420387"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa007.fm.intel.com with ESMTP; 28 Oct 2026 21:47:05 -0700
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
Subject: [Patch v5 06/18] perf/x86/amd: Avoid re-enabling PMU and LBR for BPF when disabled
Date: Thu, 29 Oct 2026 12:39:02 +0800
Message-Id: <20261029043914.1395147-7-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261029043914.1395147-1-dapeng1.mi@linux.intel.com>
References: <20261029043914.1395147-1-dapeng1.mi@linux.intel.com>
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

