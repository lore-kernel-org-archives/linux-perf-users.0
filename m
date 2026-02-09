Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4714131A572;
	Mon,  9 Feb 2026 07:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770621921; cv=none; b=DctoDhXaC4oKnuCPNtslIdrjghhiNf0y6+IWXjcUEc0C69M3bBnB1v2M+i2Du301MF0+LN8NCxFR2e6H8C+86dl8YRN4eB/wA8E80kv22H01CdBEFTcFRtrlDufnM19G4bYE9mvWU/THDuIh9HkHNE8LRgeifox9AP9XpiaEzdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770621921; c=relaxed/simple;
	bh=kTmN5eOmwiDtUttjg1mC7gO5xc/w3FEBKYBa689S4+M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QMNLoE0ZacIpA83wC9QvQZuFFavDchE8FcjJLuIv7ho59zvP97bbWTfbiezBL8fF0QDg4Lo6du/Cze1Oamre2/ot4x1aLD9nS59RfVslb4v8D4N8fkWnEiYgFX3HdHHKKHx32CHOlA8l+Q6taFzvV+ROvPuETkWBuNl7PV9A+G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fBvg09DH; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fBvg09DH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770621921; x=1802157921;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kTmN5eOmwiDtUttjg1mC7gO5xc/w3FEBKYBa689S4+M=;
  b=fBvg09DHt+1m7U4ErSNbK0SYsumsm93+CdadwRVFjYnWJLGu15oLshua
   POeWEaoqyWiJFcjcQgr8ew4wEjEtTTig8RJ54t/5gmIqkG2nz5JuxLrIs
   orGdXdp4DlqfDugKdgE9Eu1/n7XilKOWBJyHHkWaOBGTPtczI2SRlCaQa
   pgyDR1NM6bsBFNiIBf4xCF22kqdOHVhPAx2321GonclwYxwseO9a/MN64
   hjPTkdS1aBioXzAFRrcANBcS+lFw6Ms7tB3I8CI25huDF4o5P5q/gulkJ
   GXTsRmsp90Icu7KmcF4n7KdxHl8Ka1EZoz0ZFl1jNucNrCn7dBwCFOy+S
   g==;
X-CSE-ConnectionGUID: Vbvf+abaQ6aJTkVmFDDivA==
X-CSE-MsgGUID: ZQKSMpzKQVqMdyiojm2TUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11695"; a="83098325"
X-IronPort-AV: E=Sophos;i="6.21,281,1763452800"; 
   d="scan'208";a="83098325"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2026 23:25:20 -0800
X-CSE-ConnectionGUID: Uw5HNXi4RVaXIqPiW1HTSw==
X-CSE-MsgGUID: idOYzNrUSSG/KtXzzzh6HQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,281,1763452800"; 
   d="scan'208";a="241694624"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa001.fm.intel.com with ESMTP; 08 Feb 2026 23:25:15 -0800
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
	Kan Liang <kan.liang@linux.intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [Patch v6 06/22] perf/x86: Introduce x86-specific x86_pmu_setup_regs_data()
Date: Mon,  9 Feb 2026 15:20:31 +0800
Message-Id: <20260209072047.2180332-7-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260209072047.2180332-1-dapeng1.mi@linux.intel.com>
References: <20260209072047.2180332-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

The current perf/x86 implementation uses the generic functions
perf_sample_regs_user() and perf_sample_regs_intr() to set up registers
data for sampling records. While this approach works for general
registers, it falls short when adding sampling support for SIMD and APX
eGPRs registers on x86 platforms.

To address this, we introduce the x86-specific function
x86_pmu_setup_regs_data() for setting up register data on x86 platforms.

At present, x86_pmu_setup_regs_data() mirrors the logic of the generic
functions perf_sample_regs_user() and perf_sample_regs_intr().
Subsequent patches will introduce x86-specific enhancements.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/core.c       | 33 +++++++++++++++++++++++++++++++++
 arch/x86/events/intel/ds.c   |  9 ++++++---
 arch/x86/events/perf_event.h |  4 ++++
 3 files changed, 43 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 8c80d22864d8..d0753592a75b 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1699,6 +1699,39 @@ static void x86_pmu_del(struct perf_event *event, int flags)
 	static_call_cond(x86_pmu_del)(event);
 }
 
+void x86_pmu_setup_regs_data(struct perf_event *event,
+			     struct perf_sample_data *data,
+			     struct pt_regs *regs)
+{
+	struct perf_event_attr *attr = &event->attr;
+	u64 sample_type = attr->sample_type;
+
+	if (sample_type & PERF_SAMPLE_REGS_USER) {
+		if (user_mode(regs)) {
+			data->regs_user.abi = perf_reg_abi(current);
+			data->regs_user.regs = regs;
+		} else if (!(current->flags & PF_KTHREAD)) {
+			perf_get_regs_user(&data->regs_user, regs);
+		} else {
+			data->regs_user.abi = PERF_SAMPLE_REGS_ABI_NONE;
+			data->regs_user.regs = NULL;
+		}
+		data->dyn_size += sizeof(u64);
+		if (data->regs_user.regs)
+			data->dyn_size += hweight64(attr->sample_regs_user) * sizeof(u64);
+		data->sample_flags |= PERF_SAMPLE_REGS_USER;
+	}
+
+	if (sample_type & PERF_SAMPLE_REGS_INTR) {
+		data->regs_intr.regs = regs;
+		data->regs_intr.abi = perf_reg_abi(current);
+		data->dyn_size += sizeof(u64);
+		if (data->regs_intr.regs)
+			data->dyn_size += hweight64(attr->sample_regs_intr) * sizeof(u64);
+		data->sample_flags |= PERF_SAMPLE_REGS_INTR;
+	}
+}
+
 int x86_pmu_handle_irq(struct pt_regs *regs)
 {
 	struct perf_sample_data data;
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 87bf8672f5a8..07c2a670ba02 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -2445,6 +2445,7 @@ static inline void __setup_pebs_basic_group(struct perf_event *event,
 }
 
 static inline void __setup_pebs_gpr_group(struct perf_event *event,
+					  struct perf_sample_data *data,
 					  struct pt_regs *regs,
 					  struct pebs_gprs *gprs,
 					  u64 sample_type)
@@ -2454,8 +2455,10 @@ static inline void __setup_pebs_gpr_group(struct perf_event *event,
 		regs->flags &= ~PERF_EFLAGS_EXACT;
 	}
 
-	if (sample_type & (PERF_SAMPLE_REGS_INTR | PERF_SAMPLE_REGS_USER))
+	if (sample_type & (PERF_SAMPLE_REGS_INTR | PERF_SAMPLE_REGS_USER)) {
 		adaptive_pebs_save_regs(regs, gprs);
+		x86_pmu_setup_regs_data(event, data, regs);
+	}
 }
 
 static inline void __setup_pebs_meminfo_group(struct perf_event *event,
@@ -2548,7 +2551,7 @@ static void setup_pebs_adaptive_sample_data(struct perf_event *event,
 		gprs = next_record;
 		next_record = gprs + 1;
 
-		__setup_pebs_gpr_group(event, regs, gprs, sample_type);
+		__setup_pebs_gpr_group(event, data, regs, gprs, sample_type);
 	}
 
 	if (format_group & PEBS_DATACFG_MEMINFO) {
@@ -2672,7 +2675,7 @@ static void setup_arch_pebs_sample_data(struct perf_event *event,
 		gprs = next_record;
 		next_record = gprs + 1;
 
-		__setup_pebs_gpr_group(event, regs,
+		__setup_pebs_gpr_group(event, data, regs,
 				       (struct pebs_gprs *)gprs,
 				       sample_type);
 	}
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index cd337f3ffd01..d9ebea3ebee5 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1306,6 +1306,10 @@ void x86_pmu_enable_event(struct perf_event *event);
 
 int x86_pmu_handle_irq(struct pt_regs *regs);
 
+void x86_pmu_setup_regs_data(struct perf_event *event,
+			     struct perf_sample_data *data,
+			     struct pt_regs *regs);
+
 void x86_pmu_show_pmu_cap(struct pmu *pmu);
 
 static inline int x86_pmu_num_counters(struct pmu *pmu)
-- 
2.34.1

