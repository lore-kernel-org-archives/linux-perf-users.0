Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793940062;
	b=ThhKRmWsHCfOdxP1Kf6zcwZ8d0ILDhk8SY5X42q0N0VjjGHML7Z18NtmQvsdXB+1beIk
	 1oOW4hTrRZSaW7BFUw6LSmE63/7Xxckd9/Nhc4B2qBfFVAbzcZqnXla3aiDRZ4eGp57dm
	 rBk94BvyBbiK7ISeMyYZFo7LVBUg7Zse9KvabJr9NIZB/vd73ac1aX+BpRCZPcXRTSajg
	 ux3FsH7zdx0NBwQL+D7/gIZaBA8W1ZRWC5u9pkfaOKnYIWBj3Mvhk1ax2nsTzJsRJL3sD
	 59iC4cFHMOcQgm4IjVJ5Q3pZzrpyjlO4Fb62nzjvIhgVhoQ9fzMxMNh6/NkIsBhvyyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793940062;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=D7/q/T/aPlGEzVxSypzUxVEG00MjcwNWaZGRGXBETmU=;
	b=KdAHwNmEL3ODDewMSmGzwLNm/9OjJsIVxxfRz0NeEKiIIhO7mdeG+vfzImGpw2HhZ712
	 oGmjI3O48vYpXQheF/nPQQllQdxuNygPnxo1zJt8/+fbPQvcPVyBTJzviylVsOvBLdrZS
	 HDRb3LZCgC7O+uHII0Cw8dQ5RRKNCbS/++mJZ5UxbXdD1UIok2nH5XnXbSim+kF/OA9F+
	 GRVjcXAec8iC3y59qaL9fABaU22+WhY0BOhAjgPda/cT+yFhPLpTerm8RSue+EJYEO1JA
	 mS32s5YCG1iwWBwdoW2QDtBLTvKhopHyvI/tHNKnDW20UmeuQ6reM0MQKzhE95US1gA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=P7L6yUd9;
	arc=none smtp.remote-ip=198.175.65.20
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46EA8606A329;
	Fri,  6 Nov 2026 04:41:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46EA8606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=P7L6yUd9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793940063; x=1825476063;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NFCAQQLacOlzuRJ4hwCOJbUnOoSTW8Mblz4prsYitV4=;
  b=P7L6yUd9E9rgj6HrvxJYOB5/bRT2tOC+uqVQBhPapT4oQjSpEwn/Jwsi
   F7WCVz3MLOD13Wpdfne/62/ChE6lWT2OnjUqIF1DFFb4VibZwz7pnSBlY
   l5tYAyeRLyrG4uAjg8Kq9gV4ETgaGd1YFY/4s7UdHe99FJWXnFtQNFtvo
   DDpb0WuKCWjQN8p7nW1LF8SbHHgKp40lzVLlA0nuCbRm+UPAVMpQSShUP
   O0UKSsPznqy70zgfz9j7SntnUZY6IYGipippAistWReBwcKGO8EnXLje5
   N8HVA9cHBg+i5o8L7WMCaIgNiuWU3n1YWbpptdBkMGQswV8Kmp4y30HWe
   w==;
X-CSE-ConnectionGUID: 5Q94eJ6GR0W84FaDDlsXLQ==
X-CSE-MsgGUID: D5ghbgDUTOipBgRVUS+xnQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2780790"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2780790"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 20:41:03 -0800
X-CSE-ConnectionGUID: rQybVVN9SnCUAl+VmoYmmA==
X-CSE-MsgGUID: mgrDigIHQJ6wRpG5I4MKWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7222875"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa001.jf.intel.com with ESMTP; 05 Nov 2026 20:40:58 -0800
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
Subject: [Patch v6 05/20] perf/x86: Add lbr_enabled to track LBR state
Date: Fri,  6 Nov 2026 12:32:42 +0800
Message-Id: <20261106043257.842864-6-dapeng1.mi@linux.intel.com>
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

Add a lbr_enabled flag to track whether LBR is enabled. This will be
used by a subsequent change to avoid blindly re-enabling LBR in
perf_snapshot_branch_stack() without checking whether LBR has already
been disabled.

Fixes: c22ac2a3d4bd ("perf: Enable branch record for software events")
Fixes: a4d18112e531 ("perf/x86/amd: Support capturing LBR from software events")
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/amd/lbr.c    | 2 ++
 arch/x86/events/intel/core.c | 5 +++++
 arch/x86/events/intel/lbr.c  | 2 ++
 arch/x86/events/perf_event.h | 9 +++++++++
 4 files changed, 18 insertions(+)

diff --git a/arch/x86/events/amd/lbr.c b/arch/x86/events/amd/lbr.c
index 6c93b8042c73..400c94ecded0 100644
--- a/arch/x86/events/amd/lbr.c
+++ b/arch/x86/events/amd/lbr.c
@@ -399,6 +399,8 @@ void amd_pmu_lbr_enable_all(void)
 	if (!cpuc->lbr_users || !x86_pmu.lbr_nr)
 		return;
 
+	cpuc->lbr_enabled = 1;
+
 	/* Set hardware branch filter */
 	if (cpuc->lbr_select) {
 		lbr_select = cpuc->lbr_sel->config & LBR_SELECT_MASK;
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 5dfb9e9156e8..e99b311c7b8d 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4001,6 +4001,11 @@ static int intel_pmu_handle_irq(struct pt_regs *regs)
 	 * It needs to be restored when leaving the handler.
 	 */
 	pmu_enabled = cpuc->enabled;
+
+	/* If pmu version < 4, LBR freeze disables LBR. */
+	if (x86_pmu.version < 4)
+		cpuc->lbr_enabled = 0;
+
 	/*
 	 * In general, the early ACK is only applied for old platforms.
 	 * For the big core starts from Haswell, the late ACK should be
diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index 1ae853f7ac1a..ee724b28d90c 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -132,6 +132,8 @@ static void __intel_pmu_lbr_enable(bool pmi)
 	if (pmi && x86_pmu.version >= 4)
 		return;
 
+	cpuc->lbr_enabled = 1;
+
 	/*
 	 * No need to reprogram LBR_SELECT in a PMI, as it
 	 * did not change.
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index e274802ef062..a4aab8130e92 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -473,6 +473,7 @@ struct cpu_hw_events {
 	unsigned long		active_mask[BITS_TO_LONGS(X86_PMC_IDX_MAX)];
 	unsigned long		dirty[BITS_TO_LONGS(X86_PMC_IDX_MAX)];
 	int			enabled;
+	int			lbr_enabled;
 
 	int			n_events; /* the # of events in the below arrays */
 	int			n_added;  /* the # last events in the below arrays;
@@ -1676,8 +1677,11 @@ int amd_pmu_lbr_hw_config(struct perf_event *event);
 
 static __always_inline void __amd_pmu_lbr_disable(void)
 {
+	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	u64 dbg_ctl, dbg_extn_cfg;
 
+	cpuc->lbr_enabled = 0;
+
 	rdmsrq(MSR_AMD_DBG_EXTN_CFG, dbg_extn_cfg);
 	wrmsrq(MSR_AMD_DBG_EXTN_CFG, dbg_extn_cfg & ~DBG_EXTN_CFG_LBRV2EN);
 
@@ -1829,13 +1833,18 @@ static __always_inline void __intel_pmu_pebs_disable_all(void)
 
 static __always_inline void __intel_pmu_arch_lbr_disable(void)
 {
+	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+
+	cpuc->lbr_enabled = 0;
 	wrmsrq(MSR_ARCH_LBR_CTL, 0);
 }
 
 static __always_inline void __intel_pmu_lbr_disable(void)
 {
+	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	u64 debugctl;
 
+	cpuc->lbr_enabled = 0;
 	rdmsrq(MSR_IA32_DEBUGCTLMSR, debugctl);
 	debugctl &= ~(DEBUGCTLMSR_LBR | DEBUGCTLMSR_FREEZE_LBRS_ON_PMI);
 	wrmsrq(MSR_IA32_DEBUGCTLMSR, debugctl);
-- 
2.34.1

