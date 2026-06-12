Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E795539935E;
	Fri, 12 Jun 2026 09:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781255201; cv=none; b=hTkyee2Us97TFaOKLYoGqDNOPse0HhBFf0mNLogf2evptl5cZD4neKvIQpW4m7qOOFBfaqvHSQBuHWzOQWDQ+wlvdnaOOfabJrfrU84h7W5hTndYWzXpq9ZYWnLmDrpePiVbm4KVsd56u3iLmzwhUGpss0hQtQ1BUM2bi/fTNmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781255201; c=relaxed/simple;
	bh=S94842HdpKEkH7GccAAAAfsJr+zABP1dzIFQEEDrQn8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=trTzOFiL27JG8v1UZkmaFKm0BwngWNk1KvEZux12FjB111mRVBshpDMajrYwcYQNgPiqldSTvquhW4ljod+H3QnRj7Wm9yE+moclKIgVe5IqqIHdcxLVJkmqAxTSNvTQ20zvt6/Zx/Q4p375Y9+BN62iH5xptQCeCZi/O/NC+ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZkJqUTIr; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZkJqUTIr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781255199; x=1812791199;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=S94842HdpKEkH7GccAAAAfsJr+zABP1dzIFQEEDrQn8=;
  b=ZkJqUTIrna4ysaGjuv9FKnbnIZLbYjoJMYt1+T3TDDUJTQBPF2lpdoDA
   F5kmItFrfb2R8fMiW+RPXogynQWn6WjvKf6uEpwqbYoczEXFcUw2qH0z4
   y1786Sg3bYFD1aeNdD/BY37Ir+tHb3jFJFkPykFGcO0EQ016tdWL0gn6v
   gEsqptJRSKjKe3Ft1DeAJ8nW7qDNwB88HEUXGayOsR4NFWa0EYszM+E7Q
   iA8RfH/1COr7Cp5c7qsfKt9sCkSCrtXAyLL8LCI0tVO2zSiGDo30RwvZg
   kTWgpdhCZchQdCo8DUtQmhoXvXvZTa1ptMkYvGFTy7Jn6Vcl8xzqB04ip
   w==;
X-CSE-ConnectionGUID: rW2vByvbSgyfp9QL11luPg==
X-CSE-MsgGUID: +RTjoXH0Q+WgMj45Wm1Bbg==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="85714438"
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; 
   d="scan'208";a="85714438"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2026 02:06:38 -0700
X-CSE-ConnectionGUID: nDqoEzPYT5KRBVyL0CZSTw==
X-CSE-MsgGUID: 99R85Qr8R/mKBNc9ksSgnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; 
   d="scan'208";a="246838688"
Received: from spr.sh.intel.com ([10.112.230.239])
  by orviesa007.jf.intel.com with ESMTP; 12 Jun 2026 02:06:34 -0700
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
Subject: [Patch v3 2/8] perf/x86/intel: Keep cap_user_rdpmc in sync with RDPMC user-disable state
Date: Fri, 12 Jun 2026 17:01:08 +0800
Message-Id: <20260612090114.3188886-3-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260612090114.3188886-1-dapeng1.mi@linux.intel.com>
References: <20260612090114.3188886-1-dapeng1.mi@linux.intel.com>
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

