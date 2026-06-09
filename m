Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12706347520;
	Tue,  9 Jun 2026 05:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780981674; cv=none; b=Kp/RCkXNS+xQntGH+KEz9XfQv+oWrGcTAKkUUzBCLyVymltWLijotHwJoXJxxJcoD4/ocnofS/Yeoj8O72MbuZpyFFXjXI0rft6w5azJAqHQpJGR2uNe4fSuZQ22O29qmC1LgvnB1lYviqCqJI16Mgx3/br4akjlHJkRqmIkGrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780981674; c=relaxed/simple;
	bh=kxiU0Am5/rbomr+M7ysYlX649RjyBNgXhSmJGoV+QKU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RPvITqtPahBI8+60+Twg86rbpIcCBZR1RcLmSddYjreFMlDMjx2lV2SfxJGqRqpjrRge5yQReJzCnzJM5FOJerVGHXOTSHx42tD/DuX7OUF0OCsCCxOLM1gTKsgjRZcKg3kAQDdIqlzDUb0M0E42PV5GPeEWgqrIVe8K72QwAyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bSy5aH2J; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bSy5aH2J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780981673; x=1812517673;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kxiU0Am5/rbomr+M7ysYlX649RjyBNgXhSmJGoV+QKU=;
  b=bSy5aH2J4wv7eW0NsduH4vxTRUIBj9X6+tsdz5fHB/6qgnIfAIHUDWnU
   v9352RDQY2SqkmpTu/+vY4hjWTj/d/2Oqc6KxEvSs9YKZIgNupM6B0eX/
   WCr2MMcHgYlQbH4eqfg6MTiUuJL+BRMNsqvgfCmBhkFcMbfDdv3AKb2nI
   XkcLNa5TShf/3yiSgGoeua0tzG4805jM6pz/e+wDUeIFshGciQLhmI0xW
   5gnGLLfwu6zPqZUGqUimXnPkbyjVhPb0rFryWxkX2IOPccYy+8AFREtcX
   UgNWUQAGOlpv+6NC/UZ27MY9mDKUqhgDOzy4hRYYkJbwP0unjupyhqk9u
   g==;
X-CSE-ConnectionGUID: FYwOJjxSTFyCPI1f8Ua8Fg==
X-CSE-MsgGUID: I2Ej6UtNTbabZ05VPHa3ww==
X-IronPort-AV: E=McAfee;i="6800,10657,11811"; a="81586162"
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; 
   d="scan'208";a="81586162"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 22:07:53 -0700
X-CSE-ConnectionGUID: wCy4NXJqR9qvz2wBnSSwXQ==
X-CSE-MsgGUID: jh9rv4AlSN6AeGEWSLzQkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; 
   d="scan'208";a="283838907"
Received: from spr.sh.intel.com ([10.112.230.239])
  by orviesa001.jf.intel.com with ESMTP; 08 Jun 2026 22:07:49 -0700
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
Subject: [Patch v2 3/9] perf/x86: Update cap_user_rdpmc base on rdpmc user disable state
Date: Tue,  9 Jun 2026 13:02:16 +0800
Message-Id: <20260609050222.2458129-4-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260609050222.2458129-1-dapeng1.mi@linux.intel.com>
References: <20260609050222.2458129-1-dapeng1.mi@linux.intel.com>
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
cap_user_rdpmc based on the RDPMC user disable state. If RDPMC user
disable is enabled, cap_user_rdpmc is set to false, allowing user-space
programs to fall back to the read() syscall to obtain the real event
count.

Since arch_perf_update_userpage() could be called for software events,
enhance x86_pmu_has_rdpmc_user_disable() to only check the x86 PMUs.

Fixes: 59af95e028d4 ("perf/x86/intel: Add support for rdpmc user disable feature")
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Reviewed-by: Zide Chen <zide.chen@intel.com>
Reviewed-by: Thomas Falcon <thomas.falcon@intel.com>
---
 arch/x86/events/core.c       | 3 +++
 arch/x86/events/perf_event.h | 5 +++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 3bd0522afe6d..6cd95b8e31cb 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2797,6 +2797,9 @@ void arch_perf_update_userpage(struct perf_event *event,
 	userpg->cap_user_time_zero = 0;
 	userpg->cap_user_rdpmc =
 		!!(event->hw.flags & PERF_EVENT_FLAG_USER_READ_CNT);
+	if (x86_pmu_has_rdpmc_user_disable(event->pmu) &&
+	    event->hw.config & ARCH_PERFMON_EVENTSEL_RDPMC_USER_DISABLE)
+		userpg->cap_user_rdpmc = 0;
 	userpg->pmc_width = x86_pmu.cntval_bits;
 
 	if (!using_native_sched_clock() || !sched_clock_stable())
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index dbb5c8e8a8ea..4003e2e0aa9c 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1359,8 +1359,9 @@ static inline u64 x86_pmu_get_event_config(struct perf_event *event)
 
 static inline bool x86_pmu_has_rdpmc_user_disable(struct pmu *pmu)
 {
-	return !!(hybrid(pmu, config_mask) &
-		 ARCH_PERFMON_EVENTSEL_RDPMC_USER_DISABLE);
+	return is_x86_pmu(pmu) &&
+	       (hybrid(pmu, config_mask) &
+		ARCH_PERFMON_EVENTSEL_RDPMC_USER_DISABLE);
 }
 
 extern struct event_constraint emptyconstraint;
-- 
2.34.1

