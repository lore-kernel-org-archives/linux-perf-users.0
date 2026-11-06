Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793940100;
	b=pYVq4ZOI7mReLYkhOdT4zwled0BN1LURr8tFfqQMlgAvQKLvWiREeJuNtJcHjnSpYR68
	 oyY7+FY81KcsuVixZZpa4WxdtKVovuBJQKOlGtSQieHYZVlH5fa9tkZHkTq7vxzotZATi
	 wlW8O5et/mOx1iC+dz5fi8027TS3ADdpFXObOetvojok0aGrT/Fft0+WvcVda4FCOmqDL
	 Ktsc5OSEvIb9UoHrJ4vDD+N9cZYW64uNrErgWptjkZkbDwhdEAFN5zN6O3Ctb4C+mtu4A
	 3Ty6rZbiPClzS4rlKrY95b6Gf4O7wrf/WeoSUxZ3amw2eVXJT1wN/fWvc2fgObQt9NA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793940100;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Xw4XhAU+j7oA69LL9oBqhk9JoFdt4gTpiyFfE011Z7A=;
	b=K0ZuvzBie7G1OBxHGYJplyF2oM78nGQ004pG9eHkOfF4Oik6sLpD7dcfYoTCBdmQMb4Q
	 d5SOGn9NQLK/wRvo4fSQiBi853uB+qk6vpRAhaD6loVgfTb8hNNsYvycwbqaPtbVvHLck
	 g9vRHj83dDQwyxvPYJI5E6o/R/4AskxjgDoGyyu0gaw9uURVLkLgVNZN4Hz6qWMisEi2C
	 cf3/azosps7QRJw7Nm9Lld0ZVDCTZ3anx3WDyXxGyzklB9AF9g0/QzRgmkhCOJyWKGy9P
	 ZVvB1XJPAd/RePkokF5xqGE91b00crkTs0qUU38kf8BYpz06FFFRUHKDV+Pg4ZQrGPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Kz5Ul6nj;
	arc=none smtp.remote-ip=198.175.65.20
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2980A606D822;
	Fri,  6 Nov 2026 04:41:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2980A606D822
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Kz5Ul6nj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793940100; x=1825476100;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZgJBPoaah0w75MujXEb5i/38pcrdocFg28zZru1iFIk=;
  b=Kz5Ul6njNcsRu7b9Qp8LBudFrlO/d/wfX5fgmu3QD4uNKh089iYZFtiy
   rJ++0hFOr2Km1I2VjjVRM6SOVIdDuVSXDJJ0ksGildXWsFPQuYMZlagxE
   Kc7HjEFy6RUnYEHYaSEPOUJUncgImiHVkCMK+kMZlVhjbDiyUyuD2ZcUW
   RSBadEzRHB18jP/G0KzTR0iVE3zyzkDeTGktxd5ZKj+6lagVJU5wKpk2Z
   k9b0mVIYGioDiQnEMUoxSvrr4aIPp1fOPQKZATKVX4DH4IFzNXCTR/3hD
   ynqKvr6noN+UE8UT3Oe0e66M3h6inuygsflbXOr7CD1EDXVuBE3dy7gGq
   A==;
X-CSE-ConnectionGUID: DkcS6xAPRjKRY0O0xO1opw==
X-CSE-MsgGUID: f4eFRUDRQUyIiFM/KEQd8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2780878"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2780878"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 20:41:39 -0800
X-CSE-ConnectionGUID: uSL18lTBRQ6NZbgchzdK1Q==
X-CSE-MsgGUID: DwGHDi//RcqtFJqZ6BJVAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7222980"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa001.jf.intel.com with ESMTP; 05 Nov 2026 20:41:31 -0800
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
Subject: [Patch v6 12/20] perf/x86/intel: Use a dedicated LBR stack for BPF snapshotting
Date: Fri,  6 Nov 2026 12:32:49 +0800
Message-Id: <20261106043257.842864-13-dapeng1.mi@linux.intel.com>
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

BPF LBR snapshotting currently reuses the default LBR stack
(cpuc->__lbr_stack) when storing sampled data. This is unsafe when the
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
 arch/x86/events/intel/core.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index b7045c05b736..a3aaa98108cd 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2819,17 +2819,25 @@ static void intel_pmu_enable_all(int added)
 	__intel_pmu_enable_all(false);
 }
 
+struct lbr_snapshot {
+	u64 __lbr_stack[LBR_STACK_SIZE / sizeof(u64)];
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
+	struct perf_branch_stack *lbr_stack =
+		(struct perf_branch_stack *)bpf->__lbr_stack;
 
-	intel_pmu_lbr_read(cpu_lbr_stack(cpuc), cpuc->lbr_counters);
-	cnt = min_t(unsigned int, cnt, cpu_lbr_stack(cpuc)->nr);
+	intel_pmu_lbr_read(lbr_stack, bpf->counters);
+	cnt = min_t(unsigned int, cnt, lbr_stack->nr);
 
-	memcpy(entries, cpu_lbr_stack(cpuc)->entries,
+	memcpy(entries, lbr_stack->entries,
 	       sizeof(struct perf_branch_entry) * cnt);
 
 	/*
-- 
2.34.1

