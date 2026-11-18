Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794972212;
	b=D0fIev+z5QEOYVD6hREKKZjeQttUhQ2/nrojQM8XGN1gazLT/QEKVGNZDGKlfdq+Umht
	 9U0Dw2fnUDuZdjVNeawifyqihDBsM/4KLxkWLLMaqWseS15OF6nmquK2ekvtJtpq+Xsdc
	 xwTUijmQK6ujTxBUMjX0vtUD6CfHCFBNABveCldCnm69K+NJiXf+LlHR5yXuE3+mrMztt
	 BbB59hoYr6AL0tCpergb/mr1MaAk/zSNrrBxxDjIyA9oU18/pBT3IFgbexm2maKO2uUHQ
	 pPFSNC9qq/ul3Xtax+1nKMckgzJ7LsmMqUSO1MOp/X2coB6GdbYkW7MoP5ldsC2DnyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794972212;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=K02WzySQQPXQesRAqllVQeEKsVqY4BJpcIM5ZDt7DV4=;
	b=p89z2JEeW0ypHfeeYdal7i5LfCYZdIM7AtGWApesQz6iRVxDlELH8UmgRKbOc1qvMd5M
	 VNymfZWxTe1ugAtGCunPY7RU3XygMmAK8RLqtiV+uXW+Xapdh8L5ObYoHUSdKE6Ne11WG
	 4gd2y5l/Pdpnmflx8dUMNlcB0M18miCRHnmrml5kUHpo76KIjKvqXW2T/QusUeREm7WWv
	 /JJCyfNJZAUOi5rXcsXMoS58vWgCpVJodsAm0co7olVERt4gr2qVVJSo1+PiRhTIx1xTo
	 BPUngb919l/KhMIFBBco8H/M3Kb/NY7CflhrHHi54UyA5Mzl1tm9rxM4nNhk5Z9YLIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=neRH9KTq;
	arc=none smtp.remote-ip=192.198.163.7
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CCC7606A897;
	Wed, 18 Nov 2026 03:23:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9CCC7606A897
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=neRH9KTq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794972212; x=1826508212;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3rLIY6dKCflxk6XLMgVFZiGJnpfuXwUH/Sr671p2Nmk=;
  b=neRH9KTqtm+IfRtF8Hinf79eMnrIeMxt+h03MW3pHhXF6DstsVjVO1pq
   7Wu8UVkwpNi4SQExQiCWd65doI7Wo24pXFb9f0Cf0qoMu9PD5XKIUMSnd
   7u/bXkC3Q+r090uGrIUBYFXhymoL5lIjdGbTPZUf/Vu/6TH2GD2PWBNJV
   3LHETz4ZjyqOTsQpe1C5CJz62QcXfJWWKICkvw0bUvpP8eMHNfJgFpm6S
   Qc1XJxpYfnH372WvWkylVOIV9PBRJ7hKDH016Nogaw0mhsnZX6IMGHhpo
   Ox/yowuT/UIduQIvPqw1d59p/LSJwoGg2ZgQzePOj/5m+fGXqFuyTRFLi
   w==;
X-CSE-ConnectionGUID: jGs++1MuRcavVs6R2fOOOw==
X-CSE-MsgGUID: CXFyk+6WQlmX50IdtNv72w==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3629862"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3629862"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 19:23:13 -0800
X-CSE-ConnectionGUID: ZKSjlZRoRViS5nPj5YnlVA==
X-CSE-MsgGUID: CpsqVLNlT5qnJ/PZpd3feQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="9894167"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa004.jf.intel.com with ESMTP; 17 Nov 2026 19:23:09 -0800
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
Subject: [Patch v7 05/24] perf/x86: Add lbr_enabled to track LBR state
Date: Wed, 18 Nov 2026 11:14:34 +0800
Message-Id: <20261118031453.1353625-6-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261118031453.1353625-1-dapeng1.mi@linux.intel.com>
References: <20261118031453.1353625-1-dapeng1.mi@linux.intel.com>
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

Add a lbr_enabled flag to track whether LBR is enabled. This allows the
branch snapshot callbacks to avoid blindly re-enabling LBR in
perf_snapshot_branch_stack() without checking whether LBR has already
been disabled.

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
index 5dfb9e9156e8..8ca7dc8c60db 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4001,6 +4001,11 @@ static int intel_pmu_handle_irq(struct pt_regs *regs)
 	 * It needs to be restored when leaving the handler.
 	 */
 	pmu_enabled = cpuc->enabled;
+
+	/* If PMU version < 4, LBR freeze disables LBR. */
+	if (x86_pmu.version < 4)
+		cpuc->lbr_enabled = 0;
+
 	/*
 	 * In general, the early ACK is only applied for old platforms.
 	 * For the big core starts from Haswell, the late ACK should be
diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index 79303fb9b046..fe8b303839d3 100644
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

