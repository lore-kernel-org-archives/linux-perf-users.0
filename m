Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E89284B50;
	Tue,  6 May 2025 16:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746550095; cv=none; b=a04NKQgeCB5/eHJW3DpxoknV8cAdAPOIhtJeRHYNMt+s7kaNOWWcgC7mIwfovz1gLMNsTp/PJQW+XDvzdIEKEQ5CbBfYr6PddGvH1kV8InrH8nj5HJ22t4MnSzLInrf3/no17dDOIfWSFAKUtBDyf1enHcPhGdPEFqSbVBlUHKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746550095; c=relaxed/simple;
	bh=8RE0xbWDyWwo1by9qxsaBAuAFWZOZ+iKPD900Oa+h/I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VtPK8GuMSCEjxTDJVVlZPKe0yxigFqQ2f9PPI7mR2WxFk7GhGieXtJCJiywLjLyNnDhRjlqHVqfs3O6q9/iEGF5tGCsk46r/6Hv27V48JvCfml5SLydPf2isi8wsTLu3pd1G8GYBD2HeqKqJpMPgt3BNcY2GMSJoSLH1delayqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mXehuzW/; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mXehuzW/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746550093; x=1778086093;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8RE0xbWDyWwo1by9qxsaBAuAFWZOZ+iKPD900Oa+h/I=;
  b=mXehuzW/UQqesdmST8T9yEMOlbr+I3cbE/hkyqXbvXLVzMPF6AGd56bf
   GgQQTzm/tjzB2R9Co++UxH4LLQWB9zaoNwnCK6PxJOHdmrUOWafXUHhUV
   7lCRE+65yc0ao4QLnfKTWZ3Z31ywGg7w5pohEkoqCSgV6jmrgEq5SFNUW
   GFGbbChCsfLj9Fm6vqMqSfTGT4YC3BdAhXv38z5qEFl3yJk8XWmACzirZ
   IH0GypyfIgLQUZhvWg+5jklJf5FUbMNcqn+ZdHwP6oZrsyj+qn+euNW7S
   uoXTE66m0N8pjrEvp5aD1nyoMSOOk0PHUKuG9R4z0n8d4CEmrFrIVenVw
   g==;
X-CSE-ConnectionGUID: YO45yPZ8Rlyo987zAepaEQ==
X-CSE-MsgGUID: avAsFJ6LRCuuVg6G9pwfdw==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="59595226"
X-IronPort-AV: E=Sophos;i="6.15,266,1739865600"; 
   d="scan'208";a="59595226"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 09:48:12 -0700
X-CSE-ConnectionGUID: NVDxh0tIS0Sfq0k8upO/aQ==
X-CSE-MsgGUID: nRI49dU5QaqKDYGNK/eOaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,266,1739865600"; 
   d="scan'208";a="135674843"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmviesa007.fm.intel.com with ESMTP; 06 May 2025 09:48:11 -0700
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
	Kan Liang <kan.liang@linux.intel.com>
Subject: [RFC PATCH 02/15] perf/x86/intel: Remove driver-specific throttle support
Date: Tue,  6 May 2025 09:47:27 -0700
Message-Id: <20250506164740.1317237-3-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20250506164740.1317237-1-kan.liang@linux.intel.com>
References: <20250506164740.1317237-1-kan.liang@linux.intel.com>
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
index cd6329207311..3a319cf6d364 100644
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
index 61ee698deaab..f33451dc7bc7 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -2362,8 +2362,7 @@ __intel_pmu_pebs_last_event(struct perf_event *event,
 		 * All but the last records are processed.
 		 * The last one is left to be able to call the overflow handler.
 		 */
-		if (perf_event_overflow(event, data, regs))
-			x86_pmu_stop(event, 0);
+		perf_event_overflow(event, data, regs);
 	}
 
 	if (hwc->flags & PERF_X86_EVENT_AUTO_RELOAD) {
@@ -2591,8 +2590,8 @@ static void intel_pmu_drain_pebs_nhm(struct pt_regs *iregs, struct perf_sample_d
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

