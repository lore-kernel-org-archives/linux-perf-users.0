Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793249254;
	b=TGonlbNg3ClsMEqRABHJ0jFCYoG+J9Pb03FjJrdi/2p2LLzeDOjSIE04FA7lLftODZdf
	 pnDSZGYTJB+WkRlOftyUXsxX5E2TklL9wrFmXHRt37JQhRZY3vFLwHir3otnAB13r+Ga1
	 GLkdMMS6G3d00tLrm15NKVy7i/13yz3tamHTZe4K8Xx/3ps29yMmfhZZAIwnrnSJ0AyY2
	 ua4MEFGJrXaz5Dblj8CXpIbFryAqhu425b/LtZcFaLP/xjnTDelk8GADZTSbkfuqdXO1c
	 zQ+4m5J4ORLq/ITMcibiwXDtBGB23aeqK88yUACz9K5EM/it8ccojgSDBUWCs7Y23yw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793249254;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=1Xx+O19auFIcwR2aL9PTf/5lVxOSzPS5GVI4wOBFAic=;
	b=BLYmvwAi+HliQlTpdIYNAVwX9Ov5FTniLul+PvCCH+wkOPedRvkedM0SWPp9wsaek0hF
	 U5qM3qzW3L1jeb0m0WSPBppT0CySb+PXfAhiQH0PPSbQrfh0EOyLnfFt/A7VsOfzT69RI
	 +++dOI3JcPZSeGkIQpOZSdF7SbXwxwpjdSX/PwkBsskyfuwXXJR/PLGmUoBd0jbhWiMLc
	 6e3Kl+3FN4mGlcywOtn9LG33gDZLj1FsnTUrQfe0jYbZg+JYFSpaJZg1M6giSyOPb/Ws7
	 WYJQFxtbyHZGtN8lsDsPoYxUy/JNaPQv2qWfzLMBxfCUVHzr64rTlXacZ89GPSUEeSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kHW6BKwh;
	arc=none smtp.remote-ip=192.198.163.15
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE9060A2610;
	Thu, 29 Oct 2026 04:47:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5AE9060A2610
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kHW6BKwh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793249255; x=1824785255;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XxprkDlI9Ch/ACcTOuvAzDSPnmHChZ9K4/Qx80v6rkQ=;
  b=kHW6BKwhjtfaLvlPDcw8HYwcxyxxzhwnN7bCcI6VSjKC9JahSKtCFs6S
   fBoh5m1HJkple1IwkZPquZmJxKp2KE1uMR/dkzqG4dgJbEXsKANtiXUZt
   DscbKUg+YCEq7kvqv+4naq0fSdWzhCahdptemXqHewdFZUxWUZO+lGobv
   dxSA01CFV6wL0JyUDhkHxDL6KaVyD8wV4VBgBizVUSPhJWVntdSoxZurA
   9gzxBnl11nQnUFy4nerpJbftsE6pyrfelL6+oXyeZqkvawRjrWFoAIuLj
   9PZXTasMpSqK1KS15CsCO04kLYhtUVidxNAf8exNGcoQlGfraExZnXN2n
   Q==;
X-CSE-ConnectionGUID: Jnmu13AgQ727usWDmrjenA==
X-CSE-MsgGUID: plNPa09NQIO1zH+397tZvQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="1986308"
X-IronPort-AV: E=Sophos;i="6.27,183,1787036400"; 
   d="scan'208";a="1986308"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 21:47:34 -0700
X-CSE-ConnectionGUID: xUdrnTjFQ0CeMnIH20ezxQ==
X-CSE-MsgGUID: Nr7pLx3pR0mbvJ4ixCRe+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,183,1787036400"; 
   d="scan'208";a="5420505"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa007.fm.intel.com with ESMTP; 28 Oct 2026 21:47:29 -0700
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
Subject: [Patch v5 11/18] perf/x86/intel: Use a dedicated LBR stack for BPF snapshotting
Date: Thu, 29 Oct 2026 12:39:07 +0800
Message-Id: <20261029043914.1395147-12-dapeng1.mi@linux.intel.com>
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

BPF LBR snapshotting currently reuses the default LBR stack
(cpuc->lbr_stack) when storing sampled data. This is unsafe when the
BPF helper runs in PMI context via bpf_overflow_handler(): it can
overwrite the cached LBR state for active PEBS LBR events, causing
incorrect LBR data to be reported to userspace. When the PEBS and BPF
stacks have different depths, this can also lead to out-of-bounds reads
when the LBR stack is later exported.

Use a dedicated LBR stack for BPF snapshotting so the BPF path no
longer clobbers the shared LBR state used by other perf events.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Fixes: 425507fa5f32 ("perf/x86/intel/lbr: Optimize v4 LBR unfreezing")
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/core.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 5eda551cc9f2..482a148916bf 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2819,18 +2819,24 @@ static void intel_pmu_enable_all(int added)
 	__intel_pmu_enable_all(false);
 }
 
+struct lbr_snapshot {
+	struct perf_branch_stack stack;
+	struct perf_branch_entry entries[MAX_LBR_ENTRIES];
+	u64 counters[MAX_LBR_ENTRIES];
+};
+static DEFINE_PER_CPU(struct lbr_snapshot, lbr_snapshot);
+
 static noinline int
 __intel_pmu_snapshot_branch_stack(struct perf_branch_entry *entries,
 				  unsigned int cnt, unsigned long flags,
 				  int pmu_enabled, int lbr_enabled)
 {
-	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+	struct lbr_snapshot *bpf = this_cpu_ptr(&lbr_snapshot);
 
-	intel_pmu_lbr_read(&cpuc->lbr_stack,
-			   cpuc->lbr_entries, cpuc->lbr_counters);
-	cnt = min_t(unsigned int, cnt, cpuc->lbr_stack.nr);
+	intel_pmu_lbr_read(&bpf->stack, bpf->entries, bpf->counters);
+	cnt = min_t(unsigned int, cnt, bpf->stack.nr);
 
-	memcpy(entries, cpuc->lbr_entries,
+	memcpy(entries, bpf->entries,
 	       sizeof(struct perf_branch_entry) * cnt);
 
 	/*
-- 
2.34.1

