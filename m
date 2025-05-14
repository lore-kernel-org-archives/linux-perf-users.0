Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B599D2820D8;
	Wed, 14 May 2025 15:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747235686; cv=none; b=OeIv3m5jeIby+/8YrNu2njG/ZW4eLZ1PGcXX0TnN44vhHB4qYCbWHvFGn/vjG0scvBVhW6P5Plf4kyC5d2+xc1gp0HlmZzszZr/16CGB3BEw/6pP9dpiVsUQw/FeTHPeQPguYEfabfzusIpDX9ZpE7ImID1RHfPOts5TV8Jy1JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747235686; c=relaxed/simple;
	bh=25j5vFEsBU7YPCN2sAyzRM/ZIyTaWwct8v5PeU7SHZk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dt9AorTniY3/b4ne5zROL5vCzcq9wOU3Lg+IsNe680ULTZIB4Ty5XaM0jgSExDQlE4W2vchv/4++6TffLo0ZEPrSE7mRLs0tfx/eSX3jm1FL1t72RtqrUxc6dyOtB/d8zpCpPqmkW/A6yBExiZ3a1jgz2EDFlc9iYRA7sUHNJ8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mAQHncL5; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mAQHncL5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747235685; x=1778771685;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=25j5vFEsBU7YPCN2sAyzRM/ZIyTaWwct8v5PeU7SHZk=;
  b=mAQHncL5CA54bDKb3p5180ZdegtaXu5+t45W3nhGH/GkCzlg/7++Ve/0
   MgaNX3FDby/rgxdyQEggJkClIb6vak9Rg3ZmC9Q4jhJLHedojKk0K4clf
   04xkLY74ezmyEjqLzR38GQtC6bxJoxWbCj6k6O9M6AG+lCOaQLG1sXIBN
   QhX0biOzRBNgSV92etZNZepwJofrxTBKVWbNaFU/aT/Fq6iWA6dSvQMza
   LGaajYwWROr5dEoEEZCa7351V/fb9OgAxB0tDn1lHfZN50tekIq3V74ce
   2L1LJSfMSqOZ3zIdExcbQZRd2nz3LgF+CCADvncWMyvWb+xDjDVo4Ewnh
   w==;
X-CSE-ConnectionGUID: otDhMlYyTfqAXt7hr4FchQ==
X-CSE-MsgGUID: pAk7T3lqRqK1VfSafIj6rw==
X-IronPort-AV: E=McAfee;i="6700,10204,11433"; a="49072712"
X-IronPort-AV: E=Sophos;i="6.15,288,1739865600"; 
   d="scan'208";a="49072712"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 08:14:43 -0700
X-CSE-ConnectionGUID: TovYpVoQRzWcDaNRAPCPTg==
X-CSE-MsgGUID: 4nl4r0ooQRmTFHYvBL0iGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,288,1739865600"; 
   d="scan'208";a="142939155"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmviesa005.fm.intel.com with ESMTP; 14 May 2025 08:14:43 -0700
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
Subject: [PATCH V2 02/15] perf/x86/intel: Remove driver-specific throttle support
Date: Wed, 14 May 2025 08:13:48 -0700
Message-Id: <20250514151401.2547932-3-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20250514151401.2547932-1-kan.liang@linux.intel.com>
References: <20250514151401.2547932-1-kan.liang@linux.intel.com>
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

