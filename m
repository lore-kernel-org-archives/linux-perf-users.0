Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66EA357CEA;
	Mon, 19 Oct 2026 07:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792394216; cv=none; b=si3m+IFfRpBmnEln5wDjRpUf6VzfG5/5XeI3l0YmTIrY80sqbdlTC7+PYC5S7FLheIIz0balm596OSd6JcIYgFcuGsRRyx+wjI4a7yjfPXrVdtyCbGOauuCUlGKFy5W2ngnMqL0K+5b3eVC/pEUQipZ6VvQ8xzROvhmIku4uEoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792394216; c=relaxed/simple;
	bh=LVyn8iT4kzn8q6uYDKEARv/8FjfuCoruXxTXDF7BKXU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s7D6DjQPnMXFoHIZCO/eWFZpjxnGHKUnhnG63vGxYjOX0Up9yTCC8J8i0K7FQSjmi+rrPv20puoLj8fajMbEljSPxQ9frVhANt3lbiHoVvCBPOSgh7EgxS88r5KNeZBChCQMv8WkHY6za7ZbLRu5Q6sbp8m26zaByeO7isKXORw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TfSlm7d4; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TfSlm7d4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792394215; x=1823930215;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LVyn8iT4kzn8q6uYDKEARv/8FjfuCoruXxTXDF7BKXU=;
  b=TfSlm7d4Kmrpo7JFOLOk5OFGP4Ug8j7CI5WjyLMdwWkRgqnCr2qQp12e
   6WEX+k5bEHj/on/DgTsac2nHK1ctTo2fgNGOBSu7xaVu3/J7Qnvc8IWHZ
   K2ywiOE1wjn3xOlJ+SVQKSi40DQXj6XDKG1HNRmklwRVaLLbrydCGciSL
   pP34kiZ9A7HpbcI7950BoJWnyRdUNq8K70AGZFHiZqyucA9vw2KMkyHLz
   DyFuR2rNGAXY6JR3Q/b04wA4kulb0l4vwdstRSoaRyMB3r1y0NF1joGYi
   qgsH41d2MrkFl5MWw8sIMEwHc+XPNkh4CtB5bmAMCVd+kVPhyRrzYSq9Q
   g==;
X-CSE-ConnectionGUID: dxscHq89Sda36EJ0svkw3w==
X-CSE-MsgGUID: GFAsCs82T8SO9Depjv7dAw==
X-IronPort-AV: E=McAfee;i="6800,10657,11939"; a="1085727"
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="1085727"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 00:16:55 -0700
X-CSE-ConnectionGUID: NFa28pBISoydRdFnAAcnFw==
X-CSE-MsgGUID: BIlPBCk/QGyGS16uJy2glA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="2807246"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa007.fm.intel.com with ESMTP; 19 Oct 2026 00:16:50 -0700
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
Subject: [Patch v3 4/4] perf/x86/intel/lbr: Limit branch snapshots to valid entries
Date: Mon, 19 Oct 2026 15:08:36 +0800
Message-Id: <20261019070836.2972403-5-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261019070836.2972403-1-dapeng1.mi@linux.intel.com>
References: <20261019070836.2972403-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The branch snapshot callback used by bpf_get_branch_snapshot() always
copies x86_pmu.lbr_nr entries from cpuc->lbr_entries[], even when the
last LBR read kept fewer branches. The entries past lbr_stack.nr hold
invalid branches which end up reaching BPF programs.

Limit copying to lbr_stack.nr entries and also reset lbr_stack.nr when
no active LBR events or LBR hardware is owned by guest. So the stale or
guest LBR stack data can't be leaked.

When all active LBR users are PEBS events, the LBR stack is already
updated from the PEBS records, so there is no need to read the LBR
hardware again.

Fixes: c22ac2a3d4bd ("perf: Enable branch record for software events")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/sashiko-outbox-163130@kernel.org/
Co-developed-by: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/core.c | 2 +-
 arch/x86/events/intel/lbr.c  | 9 +++++++--
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 0a34d674df59..5dfb9e9156e8 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2822,7 +2822,7 @@ __intel_pmu_snapshot_branch_stack(struct perf_branch_entry *entries,
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 
 	intel_pmu_lbr_read();
-	cnt = min_t(unsigned int, cnt, x86_pmu.lbr_nr);
+	cnt = min_t(unsigned int, cnt, cpuc->lbr_stack.nr);
 
 	memcpy(entries, cpuc->lbr_entries, sizeof(struct perf_branch_entry) * cnt);
 	intel_pmu_enable_all(0);
diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index 249db12e927e..cc0300aba7de 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -1022,14 +1022,19 @@ void intel_pmu_lbr_read(void)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 
+	if (!cpuc->lbr_users || vlbr_exclude_host()) {
+		/* Reset lbr_stack.nr to prevent stale data leakage. */
+		cpuc->lbr_stack.nr = 0;
+		return;
+	}
+
 	/*
 	 * Don't read when all LBRs users are using adaptive PEBS.
 	 *
 	 * This could be smarter and actually check the event,
 	 * but this simple approach seems to work for now.
 	 */
-	if (!cpuc->lbr_users || vlbr_exclude_host() ||
-	    cpuc->lbr_users == cpuc->lbr_pebs_users)
+	if (cpuc->lbr_users == cpuc->lbr_pebs_users)
 		return;
 
 	x86_pmu.lbr_read(cpuc);
-- 
2.34.1

