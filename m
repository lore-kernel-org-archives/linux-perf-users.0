Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247BA2798FA;
	Tue, 20 May 2025 18:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747765036; cv=none; b=nqglr7etXHDNqbKlxuqgEV5LH4iZOTIa503/jbDJOES26l8MhCJ4TOVOD3Y3pCGv9E0dqFGVeitu3kVkjO1HxDcNUK534bYpo3TAeHXw6+FX2LxBrp53lMqD4hDFYBO01YD9vTazswUeM0JjziBam4itMeAMYGgTR9LyWfwsrMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747765036; c=relaxed/simple;
	bh=25j5vFEsBU7YPCN2sAyzRM/ZIyTaWwct8v5PeU7SHZk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jup33YD8nTH73yH7cFgJWCWtZIxztXOTg13jhhepfojePGjXqNGMS12riPAFSJeGbLYbKl6GLftR7squRD+3na513QeGZQpjXNeUabAAWM9VjKDsEpZhTx/Hc1QDlKREpXzeJFZ6j5K04vzR0qXgKiSsTmaiHm3nfYq36Ry5Cyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OPjGmPbp; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OPjGmPbp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747765035; x=1779301035;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=25j5vFEsBU7YPCN2sAyzRM/ZIyTaWwct8v5PeU7SHZk=;
  b=OPjGmPbpqdhURMSR6TCJ3ScM2GNijGujKI3T9/pZ6vtQQVRZ664Sipu6
   c80P/Vf2WzxYUrfdPXpTa7OiZLcwVHGotb3F9qENXx/BuZiq8iQVPv5XM
   x0iPESPTv4TR0y5Mkjvfq/VprovF7TbXnYSv9cQzSqYx4hitWFDpp8vuf
   RdYauMLLxpXmEVUS7DG3dvLcWDe6u/alkYL+2oyTHJnJ5d3P0W3z0CZNP
   g5jrWERwb6qJCeADXPqKeFEucDT4izu/+TMU5COfkWSrhcWwlGcFUYn9o
   L5E/ytrU8p4ewM5G+QvrB21DunLia2yVzBpvgvs2OsFe1b0mlOWwBVpPt
   Q==;
X-CSE-ConnectionGUID: HzxgwxW1R8+KMyXFQMQN8Q==
X-CSE-MsgGUID: p44wuas0S8CmcLBmUcrVuQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11439"; a="49847961"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="49847961"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 11:17:13 -0700
X-CSE-ConnectionGUID: LFIbr82xTlaH6zyIPqrotw==
X-CSE-MsgGUID: XOFD5mFLTOe38gHhmlOvxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="144514706"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orviesa003.jf.intel.com with ESMTP; 20 May 2025 11:17:12 -0700
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
Subject: [PATCH V4 03/16] perf/x86/intel: Remove driver-specific throttle support
Date: Tue, 20 May 2025 11:16:31 -0700
Message-Id: <20250520181644.2673067-4-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20250520181644.2673067-1-kan.liang@linux.intel.com>
References: <20250520181644.2673067-1-kan.liang@linux.intel.com>
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

