Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FE927E1AC;
	Fri, 16 May 2025 18:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747420164; cv=none; b=YvUA0M7TWUfyWdTUjE4x4bKbpntxGULtjG0b0m/xqDAZG9K22uaCgxYbVKxZUWH5vmeG863efRThmLMp9oo8yQFOIXxPFYmL0XMjIGkZzFbyH0uQrrHQ1Bi0SNkwdTiOGU/NTDMcqUnsWr4Z5OZdCYA6WD2CbOkF1+Y7wdXEGjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747420164; c=relaxed/simple;
	bh=25j5vFEsBU7YPCN2sAyzRM/ZIyTaWwct8v5PeU7SHZk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O+cShUdSlXMR6ihoRV/tJcvfpsKoL6BmAD2ghNkWi7SDR1K6eQTBFRWUY6dPVU/c3+8AtMKHGxJviGUn3OYNzP7gJruv3R7h0p8IGTVS1Qe3Dz6PrObjcTQZ9hFNstIkvzJDPDdoqYX4xbMjq6Ramb2qSFIWbomz7PQKQeooezQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ckwNm2Du; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ckwNm2Du"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747420163; x=1778956163;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=25j5vFEsBU7YPCN2sAyzRM/ZIyTaWwct8v5PeU7SHZk=;
  b=ckwNm2DuCU3pbSJJ/h+MJbAC8p7l4e+RL9hK8qiara8of33TBFwVinf0
   YzP+NKi+vZo3WwIYrbhZ3LQYosjuTUG2NkPQg3dOuj3oBR7CX9JO/jDl2
   BAOvds6aY8lcp04pziragq2fhhiSvoxjaBa/Io/yF3yaBdprxj8VUL26C
   XGvGPtQpMvc+azwt58cRDBC5z0tr7gI72r7r5K7OWb0AvOAqEKnd4F8J2
   0hY3iVffxcgqrGWz034tSx6ZrTF+TYw2kDeITN0Xv8s6VCVlO62EmpROl
   lanBC8LBVVLaBFXNGCP1SCTtK28yOFOSY/B43qZ66W67Crr1OZLVuQb7L
   Q==;
X-CSE-ConnectionGUID: RIXGIwmLQ7+wzeqthzMeBw==
X-CSE-MsgGUID: EKeJer3CRqelpWvgYgx1gA==
X-IronPort-AV: E=McAfee;i="6700,10204,11435"; a="49328809"
X-IronPort-AV: E=Sophos;i="6.15,294,1739865600"; 
   d="scan'208";a="49328809"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 11:29:21 -0700
X-CSE-ConnectionGUID: Ga5hlcp5RIe6iRFCYiYwHw==
X-CSE-MsgGUID: hB0MF+2gTyyV8cz6RZ5a7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,294,1739865600"; 
   d="scan'208";a="169802599"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmviesa001.fm.intel.com with ESMTP; 16 May 2025 11:29:20 -0700
From: kan.liang@linux.intel.com
To: peterz@infradead.org,
	mingo@redhat.com,
	namhyung@kernel.org,
	irogers@google.com,
	mark.rutland@arm.com,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: eranian@google.com,
	ctshao@google.com,
	tmricht@linux.ibm.com,
	leo.yan@arm.com,
	Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V3 03/16] perf/x86/intel: Remove driver-specific throttle support
Date: Fri, 16 May 2025 11:28:40 -0700
Message-Id: <20250516182853.2610284-4-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20250516182853.2610284-1-kan.liang@linux.intel.com>
References: <20250516182853.2610284-1-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

The throttle support has been added in the generic code. Remove
the driver-specific throttle support.

Besides the throttle, perf_event_overflow may return true because of
event_limit. It already does an inatomic event disable. The pmu->stop
is not required either.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/core.c       | 3 +--
 arch/x86/events/intel/core.c | 6 ++----
 arch/x86/events/intel/ds.c   | 7 +++----
 arch/x86/events/intel/knc.c  | 3 +--
 arch/x86/events/intel/p4.c   | 3 +--
 5 files changed, 8 insertions(+), 14 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 186e31cd0c14..8a2f73333a50 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1730,8 +1730,7 @@ int x86_pmu_handle_irq(struct pt_regs *regs)
 
 		perf_sample_save_brstack(&data, event, &cpuc->lbr_stack, NULL);
 
-		if (perf_event_overflow(event, &data, regs))
-			x86_pmu_stop(event, 0);
+		perf_event_overflow(event, &data, regs);
 	}
 
 	if (handled)
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index b7562d66c6ea..a8309a67693e 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3138,8 +3138,7 @@ static void x86_pmu_handle_guest_pebs(struct pt_regs *regs,
 			continue;
 
 		perf_sample_data_init(data, 0, event->hw.last_period);
-		if (perf_event_overflow(event, data, regs))
-			x86_pmu_stop(event, 0);
+		perf_event_overflow(event, data, regs);
 
 		/* Inject one fake event is enough. */
 		break;
@@ -3282,8 +3281,7 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
 		if (has_branch_stack(event))
 			intel_pmu_lbr_save_brstack(&data, cpuc, event);
 
-		if (perf_event_overflow(event, &data, regs))
-			x86_pmu_stop(event, 0);
+		perf_event_overflow(event, &data, regs);
 	}
 
 	return handled;
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 58c054fa56b5..f8610f7196f0 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -2368,8 +2368,7 @@ __intel_pmu_pebs_last_event(struct perf_event *event,
 		 * All but the last records are processed.
 		 * The last one is left to be able to call the overflow handler.
 		 */
-		if (perf_event_overflow(event, data, regs))
-			x86_pmu_stop(event, 0);
+		perf_event_overflow(event, data, regs);
 	}
 
 	if (hwc->flags & PERF_X86_EVENT_AUTO_RELOAD) {
@@ -2597,8 +2596,8 @@ static void intel_pmu_drain_pebs_nhm(struct pt_regs *iregs, struct perf_sample_d
 		if (error[bit]) {
 			perf_log_lost_samples(event, error[bit]);
 
-			if (iregs && perf_event_account_interrupt(event))
-				x86_pmu_stop(event, 0);
+			if (iregs)
+				perf_event_account_interrupt(event);
 		}
 
 		if (counts[bit]) {
diff --git a/arch/x86/events/intel/knc.c b/arch/x86/events/intel/knc.c
index 3e8ec049b46d..384589168c1a 100644
--- a/arch/x86/events/intel/knc.c
+++ b/arch/x86/events/intel/knc.c
@@ -254,8 +254,7 @@ static int knc_pmu_handle_irq(struct pt_regs *regs)
 
 		perf_sample_data_init(&data, 0, last_period);
 
-		if (perf_event_overflow(event, &data, regs))
-			x86_pmu_stop(event, 0);
+		perf_event_overflow(event, &data, regs);
 	}
 
 	/*
diff --git a/arch/x86/events/intel/p4.c b/arch/x86/events/intel/p4.c
index c85a9fc44355..126d5ae264cb 100644
--- a/arch/x86/events/intel/p4.c
+++ b/arch/x86/events/intel/p4.c
@@ -1072,8 +1072,7 @@ static int p4_pmu_handle_irq(struct pt_regs *regs)
 			continue;
 
 
-		if (perf_event_overflow(event, &data, regs))
-			x86_pmu_stop(event, 0);
+		perf_event_overflow(event, &data, regs);
 	}
 
 	if (handled)
-- 
2.38.1

