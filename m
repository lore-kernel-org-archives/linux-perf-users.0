Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4F233B6F9;
	Tue, 24 Mar 2026 00:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774313185; cv=none; b=t5pJDxmsmh7AIz31h7isgySnXvDp66SYa9cGObB614UFQ67f5b6DttYOuYYW6f6mTcE0KV2IyqTnAR0is2bRfj33Jw/fnnW17FgBk+dbyLgoBsIMfVyqa9kb8rbxVji8DEy66TpkUvEmRDN4hz2hueGaOfd+9+QQw418ADbdQRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774313185; c=relaxed/simple;
	bh=H6ySoMCaHGo87/RTioxATtj06rUnRQVpMFCMIsPks/4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WTYtNU9QlDQVpCXMFwtD3R7CHHhNJFpR2o5Z78ks28Y5DSo0lzTHUeoIb+Kak2fe/aQwdimYYwVNVpdynYNXKAX+ylG6s9tHYueB0pvnP2Fl4KXZDH64lahRd1eExmU5rpqVB4bc3d/AOAb7VLqCtDVVcyt9EimLfIflbv0Lx24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EETBZ/z8; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EETBZ/z8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774313184; x=1805849184;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=H6ySoMCaHGo87/RTioxATtj06rUnRQVpMFCMIsPks/4=;
  b=EETBZ/z8ADXxY3Yan5Tu1YqPgW/qarU3Yr6DhqIAKE70wvCP82QQqYVP
   ntiXgMeRIw7lZPCOke9DaHXNCrkx4pWxWPurIwWaRI5LW4Vy/AU9X1VRe
   2yTIeRj1YfxKSEJJPHAOIVXN9CyByX3kcU3OsG0ZWPLlviZ01nQSXJmPW
   4pNdMCbghi5tz3/JY4tP+IOtzSJ+uk9/Yh6DWqB43U8l3I582cuBu82nB
   06Yv6zoekXIuLOVMVRrCwoJw6bhr8zTt0EbhOybHbEBx3j4xOkiHd2wWE
   o58QasapC8r1oPGztF2ptjjQ1N8sSUTAz3LrqJstihIMA6+RoPdXt8h+o
   A==;
X-CSE-ConnectionGUID: pWSPB/kvTqqp5yCBekQiVQ==
X-CSE-MsgGUID: QIvWe3oXTi+3DWvOO9H9Mg==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="86397065"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="86397065"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 17:46:24 -0700
X-CSE-ConnectionGUID: VHOkmS2VSeaLWRTPWqeJMQ==
X-CSE-MsgGUID: w0ehnexnRmuS22T/lGhTIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="221322700"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa008.fm.intel.com with ESMTP; 23 Mar 2026 17:46:20 -0700
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
Subject: [Patch v7 07/24] perf/x86: Introduce x86-specific x86_pmu_setup_regs_data()
Date: Tue, 24 Mar 2026 08:41:01 +0800
Message-Id: <20260324004118.3772171-8-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260324004118.3772171-1-dapeng1.mi@linux.intel.com>
References: <20260324004118.3772171-1-dapeng1.mi@linux.intel.com>
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
index ad6cbc19592d..0a6c51e86e9b 100644
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
index 52eb6eac5df3..b045297c02d0 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -2450,6 +2450,7 @@ static inline void __setup_pebs_basic_group(struct perf_event *event,
 }
 
 static inline void __setup_pebs_gpr_group(struct perf_event *event,
+					  struct perf_sample_data *data,
 					  struct pt_regs *regs,
 					  struct pebs_gprs *gprs,
 					  u64 sample_type)
@@ -2459,8 +2460,10 @@ static inline void __setup_pebs_gpr_group(struct perf_event *event,
 		regs->flags &= ~PERF_EFLAGS_EXACT;
 	}
 
-	if (sample_type & (PERF_SAMPLE_REGS_INTR | PERF_SAMPLE_REGS_USER))
+	if (sample_type & (PERF_SAMPLE_REGS_INTR | PERF_SAMPLE_REGS_USER)) {
 		adaptive_pebs_save_regs(regs, gprs);
+		x86_pmu_setup_regs_data(event, data, regs);
+	}
 }
 
 static inline void __setup_pebs_meminfo_group(struct perf_event *event,
@@ -2553,7 +2556,7 @@ static void setup_pebs_adaptive_sample_data(struct perf_event *event,
 		gprs = next_record;
 		next_record = gprs + 1;
 
-		__setup_pebs_gpr_group(event, regs, gprs, sample_type);
+		__setup_pebs_gpr_group(event, data, regs, gprs, sample_type);
 	}
 
 	if (format_group & PEBS_DATACFG_MEMINFO) {
@@ -2677,7 +2680,7 @@ static void setup_arch_pebs_sample_data(struct perf_event *event,
 		gprs = next_record;
 		next_record = gprs + 1;
 
-		__setup_pebs_gpr_group(event, regs,
+		__setup_pebs_gpr_group(event, data, regs,
 				       (struct pebs_gprs *)gprs,
 				       sample_type);
 	}
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index fad87d3c8b2c..39c41947c70d 100644
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

