Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B851B4223;
	Thu,  8 May 2025 13:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746711911; cv=none; b=UaAyKXjGn+rLEr6F9JB6YcbbM6uE9qV1H2hQBK5p2mdvMZk9oSoet1H+LJQeVByB6XzKoyHDSDNb1v5RY8T1/LsnCc7kFpmi3lSNGuX/z34Q0Z1uWEjJkcrSzf4g+IZEFFFVvxtJ93dv7AEq7BoEW1VEAAdzaH2Vuymeiw9MvmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746711911; c=relaxed/simple;
	bh=5MkDSH5ThuLTr9W8JLlzUmF/famjo+LBEZSz44in2MU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S9UOok0RNT4egsytkiblZcw6ihp4lyrvmMvOz8yhB7/67bIKNCwnNgeNmaAUfyFi60Vz4dXa6s1srCrjvQM5RHF1mmXIk1QISNEcwklc5oxbpJN4nkFcx8C/9rTXaDLydNISVRzJm1ht+2YFTeRw3nJuIemAqMTk9aCfwbSOSS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b7jNUa5h; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b7jNUa5h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746711909; x=1778247909;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5MkDSH5ThuLTr9W8JLlzUmF/famjo+LBEZSz44in2MU=;
  b=b7jNUa5h8iCuV9boCQwrfHO/Ij7xM1LHnRwl7X5CDmgsOEecBOqCAA5G
   tLVarwzWxq2Y+O+REy55SKM9w01h4Rgzhvx+5Xv48uUOx15u/Zi6zgorU
   GTPwRCTMrHX0AVQefAXDXl04cwVgORDyRen+XI9XYrntRB/oFJz2c1a6n
   pOKALn3Sx2wz8A9J9RnybdR0X5lu3MNnPqfoFn6LnvweIjhhUh9t/Z8Fj
   X0T/r0iUAZuXpfGGsVccBkUEqCjAp5FuC1zIpN5wYlU7GNNBHjVxSfleP
   hRL0z+EUg40b1MioqyhW8CJLsHRkfXKYrCu6azpl0O7IuGznHvuQ+rFfI
   A==;
X-CSE-ConnectionGUID: zLgb5kX6SMGuwh/NbWMXsw==
X-CSE-MsgGUID: 9J9oHuiOQhOJJiuim51Kbw==
X-IronPort-AV: E=McAfee;i="6700,10204,11426"; a="52302943"
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; 
   d="scan'208";a="52302943"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 06:45:08 -0700
X-CSE-ConnectionGUID: 6jntlPU5QESzMqsuAIk1Uw==
X-CSE-MsgGUID: QrsHIgcPSdKX88yFohOkrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; 
   d="scan'208";a="167385076"
Received: from bkammerd-mobl.amr.corp.intel.com (HELO localhost.localdomain) ([10.124.222.200])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 06:45:05 -0700
From: Adrian Hunter <adrian.hunter@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH] perf/x86/intel: Fix segfault with PEBS-via-PT with sample_freq
Date: Thu,  8 May 2025 16:44:52 +0300
Message-ID: <20250508134452.73960-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit

Currently, using PEBS-via-PT with a sample frequency instead of a sample
period, causes a segfault.  For example:

 [  103.607823] BUG: kernel NULL pointer dereference, address: 0000000000000195
 [  103.607876]  <NMI>
 [  103.607879]  ? __die_body.cold+0x19/0x27
 [  103.607885]  ? page_fault_oops+0xca/0x290
 [  103.607891]  ? exc_page_fault+0x7e/0x1b0
 [  103.607897]  ? asm_exc_page_fault+0x26/0x30
 [  103.607901]  ? intel_pmu_pebs_event_update_no_drain+0x40/0x60
 [  103.607903]  ? intel_pmu_pebs_event_update_no_drain+0x32/0x60
 [  103.607905]  intel_pmu_drain_pebs_icl+0x333/0x350
 [  103.607910]  handle_pmi_common+0x272/0x3c0
 [  103.607919]  intel_pmu_handle_irq+0x10a/0x2e0
 [  103.607922]  perf_event_nmi_handler+0x2a/0x50

That happens because intel_pmu_pebs_event_update_no_drain() assumes all the
pebs_enabled bits represent counter indexes, which is not always the case.
In this particular case, bits 60 and 61 are set for PEBS-via-PT purposes.

The behaviour of PEBS-via-PT with sample frequency is questionable because
although a PMI is generated (PEBS_PMI_AFTER_EACH_RECORD), the period is not
adjusted anyway.

Putting that aside, fix intel_pmu_pebs_event_update_no_drain() by passing
the mask of counter bits instead of 'size'.  Note, prior to the Fixes
commit, 'size' would be limited to the maximum counter index, so the issue
was not hit.

Fixes: 722e42e45c2f1 ("perf/x86: Support counter mask")
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 arch/x86/events/intel/ds.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index adb2e44761b2..8da1105a419f 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -2469,8 +2469,9 @@ static void intel_pmu_drain_pebs_core(struct pt_regs *iregs, struct perf_sample_
 				setup_pebs_fixed_sample_data);
 }
 
-static void intel_pmu_pebs_event_update_no_drain(struct cpu_hw_events *cpuc, int size)
+static void intel_pmu_pebs_event_update_no_drain(struct cpu_hw_events *cpuc, u64 mask)
 {
+	u64 pebs_enabled = cpuc->pebs_enabled & mask;
 	struct perf_event *event;
 	int bit;
 
@@ -2481,7 +2482,7 @@ static void intel_pmu_pebs_event_update_no_drain(struct cpu_hw_events *cpuc, int
 	 * It needs to call intel_pmu_save_and_restart_reload() to
 	 * update the event->count for this case.
 	 */
-	for_each_set_bit(bit, (unsigned long *)&cpuc->pebs_enabled, size) {
+	for_each_set_bit(bit, (unsigned long *)&pebs_enabled, X86_PMC_IDX_MAX) {
 		event = cpuc->events[bit];
 		if (event->hw.flags & PERF_X86_EVENT_AUTO_RELOAD)
 			intel_pmu_save_and_restart_reload(event, 0);
@@ -2516,7 +2517,7 @@ static void intel_pmu_drain_pebs_nhm(struct pt_regs *iregs, struct perf_sample_d
 	}
 
 	if (unlikely(base >= top)) {
-		intel_pmu_pebs_event_update_no_drain(cpuc, size);
+		intel_pmu_pebs_event_update_no_drain(cpuc, mask);
 		return;
 	}
 
@@ -2630,7 +2631,7 @@ static void intel_pmu_drain_pebs_icl(struct pt_regs *iregs, struct perf_sample_d
 	       (hybrid(cpuc->pmu, fixed_cntr_mask64) << INTEL_PMC_IDX_FIXED);
 
 	if (unlikely(base >= top)) {
-		intel_pmu_pebs_event_update_no_drain(cpuc, X86_PMC_IDX_MAX);
+		intel_pmu_pebs_event_update_no_drain(cpuc, mask);
 		return;
 	}
 
-- 
2.45.2

