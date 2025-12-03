Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF76329B229;
	Wed,  3 Dec 2025 06:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764745097; cv=none; b=LpJHOtNy0tUXQkyPklCIh0ZU1+LtVoo0IhdOVlGUSDoBXDdegogn+B9OijqLUo0ARKuEbrWfx7FIcT6YLWuHvO8NZzcjlfRhD1UCkDdtiDIzzoEs3ZVp9oLENr5Y1XO2VtL2QmDq6QhEqQSvXoEI8QXRY8qAkKbrSQXglT13r5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764745097; c=relaxed/simple;
	bh=NWDX0b18H+JRWd7zZxTxDJESj0fJMlzbeOV8IIQCMpY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SJkS+Y8q7N+orvEi5s49j5YLTRh3btZpVVnitJ4qNY0sI+0JpsFov31qnVwIAkqMIZkTPm6btoa9y8PsKYeJclDPnefmj8dgkaMqIo9HaL1k3uFHvOwpfvoqsP2UDvke4Gjb8vEgr22g7re7fLJ/SaYIr4MkDX14bpoWc7Cvt3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h6cXXqQr; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h6cXXqQr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764745096; x=1796281096;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NWDX0b18H+JRWd7zZxTxDJESj0fJMlzbeOV8IIQCMpY=;
  b=h6cXXqQr0xjVbAI/QeXYLrQ+NzbXAt2MXO3y6WLER1SYoVwiftAyyKh5
   mBiJC5dhJPs5PymJZGevDncBCJ3+NN212Td64VsrdMWzMzN/dnn5AuvHE
   2eiaI/68YAiUaPNClElCJmzgtCJNzwaozw7BqJhPJnDCVIoAcXVktTn6D
   gL8CRVmBgCs/xJdyLQMPVept/WI6S8MNUb8GUV93BYJdg1gXTr0VmEVSs
   adGBCpWhi626A+sHC+tEeeBVKd7mGPjOxvqd8TvxG5a0pdgdGSHorXnIK
   MJFZBmxF6rgT/4YPXqbF2YAU/TFghiZ9CtqWt86ahKIOfI6HTEBUUI+KL
   w==;
X-CSE-ConnectionGUID: x5bN0voiSm+jvfGhQX7Bvw==
X-CSE-MsgGUID: ATDm+0JZSmGmcHf+ou2ooQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11631"; a="84324762"
X-IronPort-AV: E=Sophos;i="6.20,245,1758610800"; 
   d="scan'208";a="84324762"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2025 22:58:16 -0800
X-CSE-ConnectionGUID: FNsoQpoeR8y8NEuE3Z2Tkw==
X-CSE-MsgGUID: tka7fAYpSMCnvh0iGHHkWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,245,1758610800"; 
   d="scan'208";a="199003798"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa005.fm.intel.com with ESMTP; 02 Dec 2025 22:58:10 -0800
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
Subject: [Patch v5 03/19] perf/x86: Introduce x86-specific x86_pmu_setup_regs_data()
Date: Wed,  3 Dec 2025 14:54:44 +0800
Message-Id: <20251203065500.2597594-4-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251203065500.2597594-1-dapeng1.mi@linux.intel.com>
References: <20251203065500.2597594-1-dapeng1.mi@linux.intel.com>
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
 arch/x86/events/core.c       | 32 ++++++++++++++++++++++++++++++++
 arch/x86/events/intel/ds.c   |  9 ++++++---
 arch/x86/events/perf_event.h |  4 ++++
 3 files changed, 42 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index ef3bf8fbc97f..dcdd2c2d68ee 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1695,6 +1695,38 @@ static void x86_pmu_del(struct perf_event *event, int flags)
 	static_call_cond(x86_pmu_del)(event);
 }
 
+void x86_pmu_setup_regs_data(struct perf_event *event,
+			     struct perf_sample_data *data,
+			     struct pt_regs *regs)
+{
+	u64 sample_type = event->attr.sample_type;
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
+			data->dyn_size += hweight64(event->attr.sample_regs_user) * sizeof(u64);
+		data->sample_flags |= PERF_SAMPLE_REGS_USER;
+	}
+
+	if (sample_type & PERF_SAMPLE_REGS_INTR) {
+		data->regs_intr.regs = regs;
+		data->regs_intr.abi = perf_reg_abi(current);
+		data->dyn_size += sizeof(u64);
+		if (data->regs_intr.regs)
+			data->dyn_size += hweight64(event->attr.sample_regs_intr) * sizeof(u64);
+		data->sample_flags |= PERF_SAMPLE_REGS_INTR;
+	}
+}
+
 int x86_pmu_handle_irq(struct pt_regs *regs)
 {
 	struct perf_sample_data data;
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 2e170f2093ac..c7351f476d8c 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -2180,6 +2180,7 @@ static inline void __setup_pebs_basic_group(struct perf_event *event,
 }
 
 static inline void __setup_pebs_gpr_group(struct perf_event *event,
+					  struct perf_sample_data *data,
 					  struct pt_regs *regs,
 					  struct pebs_gprs *gprs,
 					  u64 sample_type)
@@ -2189,8 +2190,10 @@ static inline void __setup_pebs_gpr_group(struct perf_event *event,
 		regs->flags &= ~PERF_EFLAGS_EXACT;
 	}
 
-	if (sample_type & (PERF_SAMPLE_REGS_INTR | PERF_SAMPLE_REGS_USER))
+	if (sample_type & (PERF_SAMPLE_REGS_INTR | PERF_SAMPLE_REGS_USER)) {
 		adaptive_pebs_save_regs(regs, gprs);
+		x86_pmu_setup_regs_data(event, data, regs);
+	}
 }
 
 static inline void __setup_pebs_meminfo_group(struct perf_event *event,
@@ -2283,7 +2286,7 @@ static void setup_pebs_adaptive_sample_data(struct perf_event *event,
 		gprs = next_record;
 		next_record = gprs + 1;
 
-		__setup_pebs_gpr_group(event, regs, gprs, sample_type);
+		__setup_pebs_gpr_group(event, data, regs, gprs, sample_type);
 	}
 
 	if (format_group & PEBS_DATACFG_MEMINFO) {
@@ -2407,7 +2410,7 @@ static void setup_arch_pebs_sample_data(struct perf_event *event,
 		gprs = next_record;
 		next_record = gprs + 1;
 
-		__setup_pebs_gpr_group(event, regs,
+		__setup_pebs_gpr_group(event, data, regs,
 				       (struct pebs_gprs *)gprs,
 				       sample_type);
 	}
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 3161ec0a3416..80e52e937638 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1294,6 +1294,10 @@ void x86_pmu_enable_event(struct perf_event *event);
 
 int x86_pmu_handle_irq(struct pt_regs *regs);
 
+void x86_pmu_setup_regs_data(struct perf_event *event,
+			     struct perf_sample_data *data,
+			     struct pt_regs *regs);
+
 void x86_pmu_show_pmu_cap(struct pmu *pmu);
 
 static inline int x86_pmu_num_counters(struct pmu *pmu)
-- 
2.34.1

