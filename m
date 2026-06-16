Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3100B3CAA3E;
	Tue, 16 Jun 2026 04:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781585555; cv=none; b=ShTzu4XXrhHQLEOp7eMQpVFJ0sTcUC4hDP6UXrTtCZiy50mIwZGQmuxtBx0irTh7E6iii10jr1NlvBLtDvszkxYnxutTaDInGeJlHsQMz92jny6re//djo2Yd2VId/RCq4x1Fj3zHTaYjmp/RxByeXyr/NEkXyybEQcKv/BXrZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781585555; c=relaxed/simple;
	bh=S94842HdpKEkH7GccAAAAfsJr+zABP1dzIFQEEDrQn8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T6jgfbc93jlQDxgcokowRUd/vSUeyQSiAmZd7xG/kbMQ0AkSENK/b6B2dYV+a3Z0j0BPRgbGe+ldGNXI3T3CAeXHF9FMp3mZmTXSIQBkYSYYs6RS7KkfgsuR8su0zGAXEPrVo2S1Ifmhmy00ANBXPDrVvnOONDUaQkIMvmPvCSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZRY/rMkG; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZRY/rMkG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781585554; x=1813121554;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=S94842HdpKEkH7GccAAAAfsJr+zABP1dzIFQEEDrQn8=;
  b=ZRY/rMkGfiz46lAjSMva4MFopw5hoaskLReoWYVDa6o5RA4tSEvjDjJM
   41rs5TcnaddtpKHz0AavBnul+mrOPkyyv1Q9TCPvm2o/1zP63SNIDuA54
   bLUsxrir9TGuIf3VeAGLCqyabadH1NuDSrfRLgFMaewr5Q3xJeUsWTFi7
   E030280QZLTQxMheLAFJC9jT1UUD2dwoSWiW3aSLeZKavm4BUpYsbTpP5
   Y/77lfB8FlrYx+N+7XSFBSYGmW93LLCC9H3Ye7SpYoi9d16/IFRBNmBtM
   IAzOcD+qcu3AowGxxbf0/HQ73Cyum0+ohj1plZ7SkKWENg/Wi3VItrOt7
   A==;
X-CSE-ConnectionGUID: OGa9GFkVRfWNwYciuwMg2w==
X-CSE-MsgGUID: jJzYd/Y/S+aRFD7eRaLP9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11818"; a="82445381"
X-IronPort-AV: E=Sophos;i="6.24,207,1774335600"; 
   d="scan'208";a="82445381"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2026 21:52:34 -0700
X-CSE-ConnectionGUID: a0/aFbh9SkiLjHkQ0swnGQ==
X-CSE-MsgGUID: DpTOfb7gTEmE6Vm47k1hqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,207,1774335600"; 
   d="scan'208";a="271726255"
Received: from spr.sh.intel.com ([10.112.230.239])
  by fmviesa001.fm.intel.com with ESMTP; 15 Jun 2026 21:52:29 -0700
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Xudong Hao <xudong.hao@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [Patch v4 2/8] perf/x86/intel: Keep cap_user_rdpmc in sync with RDPMC user-disable state
Date: Tue, 16 Jun 2026 12:46:48 +0800
Message-Id: <20260616044654.3468742-3-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260616044654.3468742-1-dapeng1.mi@linux.intel.com>
References: <20260616044654.3468742-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After introducing the RDPMC user disable feature, user-space RDPMC may
return 0 instead of the actual event count. This creates an inconsistency
with cap_user_rdpmc, where cap_user_rdpmc is set, but user-space RDPMC
only returns 0.

To accurately represent the user-space RDPMC capability, update
cap_user_rdpmc (depending on PERF_EVENT_FLAG_USER_READ_CNT) according to
the RDPMC user disable state. If RDPMC user disable is enabled,
cap_user_rdpmc is updated to false eventually, allowing user-space
programs to fall back to the read() syscall to obtain the real event
count.

Because PERF_EVENT_FLAG_USER_READ_CNT is evaluated in
x86_pmu_event_init(), move intel_pmu_update_rdpmc_user_disable()
earlier into intel_pmu_hw_config(). This ensures that the user-disable
state is updated before updating PERF_EVENT_FLAG_USER_READ_CNT. Note that
since event->ctx is not yet assigned at this stage, use the
PERF_ATTACH_TASK flag to detect whether the event is task-attached.

While at it, fix the indentation of x86_pmu_has_rdpmc_user_disable()
to adhere to the kernel coding style.

Fixes: 59af95e028d4 ("perf/x86/intel: Add support for rdpmc user disable feature")
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/core.c       | 3 ++-
 arch/x86/events/intel/core.c | 6 +++---
 arch/x86/events/perf_event.h | 2 +-
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 4b9e105309c6..a76a2afae2fb 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2539,7 +2539,8 @@ static int x86_pmu_event_init(struct perf_event *event)
 	}
 
 	if (READ_ONCE(x86_pmu.attr_rdpmc) &&
-	    !(event->hw.flags & PERF_X86_EVENT_LARGE_PEBS))
+	    !(event->hw.flags & PERF_X86_EVENT_LARGE_PEBS) &&
+	    !(event->hw.config & ARCH_PERFMON_EVENTSEL_RDPMC_USER_DISABLE))
 		event->hw.flags |= PERF_EVENT_FLAG_USER_READ_CNT;
 
 	return err;
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index ea3ab3050a3b..db52e7e53a6c 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3532,7 +3532,7 @@ static void intel_pmu_update_rdpmc_user_disable(struct perf_event *event)
 	 */
 	if (x86_pmu.attr_rdpmc == X86_USER_RDPMC_ALWAYS_ENABLE ||
 	    (x86_pmu.attr_rdpmc == X86_USER_RDPMC_CONDITIONAL_ENABLE &&
-	     event->ctx->task))
+	     (event->attach_state & PERF_ATTACH_TASK)))
 		event->hw.config &= ~ARCH_PERFMON_EVENTSEL_RDPMC_USER_DISABLE;
 	else
 		event->hw.config |= ARCH_PERFMON_EVENTSEL_RDPMC_USER_DISABLE;
@@ -3546,8 +3546,6 @@ static void intel_pmu_enable_event(struct perf_event *event)
 	struct hw_perf_event *hwc = &event->hw;
 	int idx = hwc->idx;
 
-	intel_pmu_update_rdpmc_user_disable(event);
-
 	if (unlikely(event->attr.precise_ip))
 		static_call(x86_pmu_pebs_enable)(event);
 
@@ -5146,6 +5144,8 @@ static int intel_pmu_hw_config(struct perf_event *event)
 		leader->hw.flags |= PERF_X86_EVENT_ACR;
 	}
 
+	intel_pmu_update_rdpmc_user_disable(event);
+
 	if ((event->attr.type == PERF_TYPE_HARDWARE) ||
 	    (event->attr.type == PERF_TYPE_HW_CACHE))
 		return 0;
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 5902a297daa1..a8afea8d38f0 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1344,7 +1344,7 @@ static inline u64 x86_pmu_get_event_config(struct perf_event *event)
 static inline bool x86_pmu_has_rdpmc_user_disable(struct pmu *pmu)
 {
 	return !!(hybrid(pmu, config_mask) &
-		 ARCH_PERFMON_EVENTSEL_RDPMC_USER_DISABLE);
+		  ARCH_PERFMON_EVENTSEL_RDPMC_USER_DISABLE);
 }
 
 extern struct event_constraint emptyconstraint;
-- 
2.34.1

